all:
  vars:
    ansible_ssh_private_key_file: ${key_name}
    ansible_user: ${ssh_user}
    ansible_python_interpreter: /usr/bin/python3
  children:
    docker:
      hosts:
        backend-node:
          backend: ${backend_node_ip}
        frontend-node:
          frontend: ${frontend_node_ip}
          backend_ip: ${backend_node_ip}
