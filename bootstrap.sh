sudo apt update
sudo apt upgrade -y

sudo apt install ansible -y
sudo apt install python3.10-venv -y

ansible-playbook -K ./playbook.yaml 
