all:
  vars:
    ansible_ssh_private_key_file: ${key_name}
    ansible_user: ${ssh_user}
    ansible_python_interpreter: /usr/bin/python3
  children:
    docker:
      hosts:
%{ for ip in docker_node_ips ~}
%{ if ip == docker_node_ips[0] ~}
        Test-FE:
          ansible_host: ${ip}
%{ else ~}
        Test-BE:
          ansible_host: ${ip}
%{ endif ~}
%{ endfor ~}
