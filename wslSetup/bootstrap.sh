sudo apt update
sudo apt upgrade -y

sudo apt install ansible -y


ansible-playbook -K ./wslSetup/playbook.yaml 
