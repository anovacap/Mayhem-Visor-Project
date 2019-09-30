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
cd /tmp
mkdir /home/ubuntu/logs
curl -LO https://github.com/concourse/concourse/releases/download/v5.5.1/concourse-5.5.1-linux-amd64.tgz
echo "curl concourse $?">>/home/ubuntu/logs/user_data.log
sudo wget https://github.com/concourse/concourse/releases/download/v5.5.1/fly-5.5.1-linux-amd64.tgz -O /tmp/fly.tgz
echo "wget fly $?">>/home/ubuntu/logs/user_data.log
tar -xzvf /tmp/fly.tgz
echo "tar fly $?">>/home/ubuntu/logs/user_data.log
sudo chmod +x concourse* /tmp/fly*
sudo mv concourse* /usr/local/bin/concourse
sudo mv /tmp/fly /usr/local/bin/fly
./usr/local/bin/concourse
./usr/local/bin/fly
mkdir /home/ubuntu/DC
cd /home/ubuntu/DC
wget https://raw.githubusercontent.com/starkandwayne/concourse-tutorial/master/docker-compose.yml
echo "wget concourse docker-compose $?">>/home/ubuntu/logs/user_data.log
sudo sed -i 's/4.2.1/5.5.1/g' /home/ubuntu/DC/docker-compose.yml
sudo docker-compose up -d
echo "docker-compose $?">>/home/ubuntu/logs/user_data.log
docker-compose logs>>/home/ubuntu/logs/user_data.log
sudo apt install openssh-server
sudo systemctl enable ssh
sudo systemctl start ssh
sudo snap install powershell --classic
sudo apt install openssh-client
sudo apt install openssh-server
cd /etc/ssh/
sudo sed -i 's/#StrictModes yes/StrictModes no/g' sshd_config
sudo sed -i 's/#PubkeyAuthentication no/PubkeyAuthentication yes/g' sshd_config
sudo sed -i 's/Subsystem      sftp    /usr/lib/openssh/sftp-server/Subsystem powershell /usr/bin/pwsh -sshs -NoLogo -NoProfile/g' sshd_config
sudo service sshd restart
