apt update
apt upgrade -y

apt install ansible -y


ansible-playbook -K ./wslSetup/playbook.yaml
