apt update
apt upgrade -y

apt install ansible -y

pwd
ansible-playbook -K ./wslSetup/playbook.yaml
