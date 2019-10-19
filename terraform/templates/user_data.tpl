#!/bin/bash
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable edge"
sudo apt-get update -y
sudo apt-get upgrade -y
apt-cache policy docker-ce
sudo apt-get install -y docker-ce
sudo apt install -y docker-compose
sudo usermod -a -G docker $USER
sudo apt-get install -y postgresql postgresql-contrib
sudo -u postgres createuser concourse
sudo -u postgres createdb --owner=concourse atc
sudo apt install -y python3-pip
sudo pip3 install awscli
pip3 install --upgrade --user awscli
cd /tmp
mkdir /home/ubuntu/logs
curl -LO https://github.com/concourse/concourse/releases/download/v5.5.1/concourse-5.5.1-linux-amd64.tgz -o /tmp/concourse.tgz
echo "curl concourse $?">>/home/ubuntu/logs/user_data.log
sudo wget https://github.com/concourse/concourse/releases/download/v5.5.1/fly-5.5.1-linux-amd64.tgz -o /tmp/fly.tgz
echo "wget fly $?">>/home/ubuntu/logs/user_data.log
tar -xzvf /tmp/fly.tgz
tar -xzvf /tmp/concourse.tgz
echo "tar fly $?">>/home/ubuntu/logs/user_data.log
sudo chmod +x /tmp/concourse*
sudo chmod +x /tmp/fly*
sudo mv /tmp/concourse* /usr/local/bin/concourse
sudo mv /tmp/fly /usr/local/bin/fly
./usr/local/bin/concourse
./usr/local/bin/fly
cd /home/ubuntu/
git clone https://github.com/concourse/concourse-docker.git
cd concourse-docker
./keys/generate
port_number="8080"
public_ip=`curl http://169.254.169.254/latest/meta-data/public-ipv4`
# instance id used for concourse script
instance_id=`aws ssm describe-instance-information --query "InstanceInformationList[1].InstanceId" --output text --region us-west-2`
sudo sed -i "s#CONCOURSE_EXTERNAL_URL: http://localhost:8080#CONCOURSE_EXTERNAL_URL: http://$public_ip:$port_number#g" /home/ubuntu/concourse-docker/docker-compose.yml
echo "wget concourse docker-compose $?">>/home/ubuntu/logs/user_data.log
sudo docker-compose up -d
echo "docker-compose $?">>/home/ubuntu/logs/user_data.log
docker-compose logs>>/home/ubuntu/logs/user_data.log
sudo apt-get install -y emacs
cd ..
mkdir Concourse
cd Concourse
echo '#!/bin/bash' > trigger.sh
echo 'ssh_command_id=$(aws ssm send-command --instance-ids "i-0b6df3f0de04bf148" --document-name "AWS-RunPowerShellScript" --comment "Demo run shell script on Linux Instance" --parameters commands="#!/bin/bashpowershell.exe -nologo -noprofile C:\Users\Administrator\Documents\test.ps1" --query "Command.CommandId" --output text) aws ssm list-command-invocations --command-id "$ssh_command_id" --details --query "CommandInvocations[*].CommandPlugins[*].Output[]" --output text' >> trigger.sh
chmod u+x trigger.sh
sed -i "s/i-0b6df3f0de04bf148/$instance_id/g" trigger.sh