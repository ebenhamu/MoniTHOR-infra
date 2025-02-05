all:
  vars:
    ansible_ssh_private_key_file: ${key_name}
    ansible_user: ${ssh_user}
    ansible_python_interpreter: /usr/bin/python3
  children:
    docker:
      hosts:
        docker-node:
          ansible_host: ${docker_node_ip}
