apt update
apt upgrade -y

apt install ansible -y

export SSL_CERT_DIR=/usr/local/share/ca-certificates/
ansible-playbook -K ./wslSetup/playbook.yaml
