ansible-playbook -i inventory install-docker.yaml
ansible-playbook -i inventory database_conf.yaml
ansible-playbook -i inventory backend_conf.yaml
ansible-playbook -i inventory frontend_conf.yaml -e "backend_ip=40.69.66.148"

ansible-playbook -i inventory configure_environment.yaml
