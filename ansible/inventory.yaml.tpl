all:
  vars:
    ansible_ssh_private_key_file: ${key_name}
    ansible_user: ${ssh_user}
    ansible_python_interpreter: /usr/bin/python3
  children:
    docker:
      hosts:
%{ for ip in docker_node_ips ~}
        ${ip}:
          ansible_host: ${ip}
%{ endfor ~}
