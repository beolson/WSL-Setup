apt update
apt upgrade -y

apt install ansible -y
# echo ~
# ls -lA ~
# export SSL_CERT_DIR=/usr/local/share/ca-certificates/
ansible-playbook -K ./wslSetup/playbook.yaml
