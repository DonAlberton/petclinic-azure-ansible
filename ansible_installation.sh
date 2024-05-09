sudo apt update
sudo apt install software-properties-common sshpass -y
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install ansible -y
ansible-config init --disabled > ansible.cfg

echo "[defaults]\nhost_key_checking = False" | sudo tee -a /etc/ansible/ansible.cfg > /dev/null


