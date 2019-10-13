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
#sudo apt-get install -y python3-pip
#sudo pip3 install awscli
#pip3 install --upgrade --user awscli
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
#mkdir /home/ubuntu/DC
cd /home/ubuntu/
#wget https://raw.githubusercontent.com/starkandwayne/concourse-tutorial/master/docker-compose.yml
git clone https://github.com/concourse/concourse-docker.git
cd concourse-docker
./keys/generate
port_number="8080"
public_ip="$(aws ec2 describe-instances --instance-ids $instance_id --output text|grep ASSOCIATION |awk '{print $3}'|head -1)"
sudo sed -i "s/CONCOURSE_EXTERNAL_URL: http://localhost:8080/CONCOURSE_EXTERNAL_URL: http://$public_ip:$port_number" /home/ubuntu/concourse-docker/docker-compose.yml
echo "wget concourse docker-compose $?">>/home/ubuntu/logs/user_data.log
#sudo sed -i 's/4.2.1/5.5.1/g' /home/ubuntu/DC/docker-compose.yml
sudo docker-compose up -d
echo "docker-compose $?">>/home/ubuntu/logs/user_data.log
docker-compose logs>>/home/ubuntu/logs/user_data.log
# -- Add for Session Manager
#aws configure
#AWS Access Key ID [None]: AKIAIOSFODNN7EXAMPLE
#AWS Secret Access Key [None]: wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
#Default region name [None]: us-west-2




# -- Not Used --
# sudo apt install openssh-server
# sudo systemctl enable ssh
# sudo systemctl start ssh
# sudo snap install powershell --classic
# sudo apt install openssh-client
# sudo apt install openssh-server
# cd /etc/ssh/
# sudo sed -i 's/#StrictModes yes/StrictModes no/g' sshd_config
# sudo sed -i 's/#PubkeyAuthentication no/PubkeyAuthentication yes/g' sshd_config
# sudo sed -i 's/Subsystem      sftp    /usr/lib/openssh/sftp-server/Subsystem powershell /usr/bin/pwsh -sshs -NoLogo -NoProfile/g' sshd_config
# sudo service sshd restart
