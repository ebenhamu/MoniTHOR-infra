all:
  vars:
    ansible_ssh_private_key_file: ${key_name}
    ansible_user: ${ssh_user}
    ansible_python_interpreter: /usr/bin/python3
  children:
    app:
      hosts:
%{ for ip in app_node_ips ~}
%{ if ip == app_node_ips[0] ~}
        monithor-fe:
          ansible_host: ${ip}
%{ else ~}
        monithor-be:
          ansible_host: ${ip}
%{ endif ~}
%{ endfor ~}
