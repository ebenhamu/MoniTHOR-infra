terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

resource "aws_instance" "docker" {
  count         = 2  # Create two instances 
  ami           = var.ami
  instance_type = var.instance_type
  key_name = var.key_name
  vpc_security_group_ids = [var.security_group_id]
  tags = {
    Name = "Docker-Node"
    Managed_By  = "Terraform"
  }
}

resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/../ansible/inventory.yaml.tpl", {
    docker_node_ips = aws_instance.docker.*.public_ip
    key_name         = "${var.key_path}/${var.key_name}.pem"
    ssh_user         = var.ssh_user
  })
  filename = "${path.module}/../ansible/inventory.yaml"
}

resource "local_file" "ansible_cfg" {
  content = templatefile("${path.module}/../ansible/ansible.cfg.tpl", {
    inventory_file = "${path.module}/../ansible/inventory.yaml"
    remote_user = var.ssh_user
    private_key_file = "${var.key_path}${var.key_name}.pem"
    host_key_checking = false
  })
  filename = "${path.module}/../ansible/ansible.cfg"
}

resource "null_resource" "run_ansible" {
  depends_on = [local_file.ansible_inventory]

  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i ${path.module}/../ansible/inventory.yaml ${path.module}/../ansible/main.yaml"
  }
}

output "docker_node_ips" {
  value = aws_instance.docker.*.public_ip
}

output "key_name" {
  value = var.key_name
}



# # Configure the required AWS provider
# terraform {
#   required_providers {
#     aws = {
#       source  = "hashicorp/aws"
#       version = "~> 3.0"
#     }
#   }
# }

# # Configure AWS provider with specified region
# provider "aws" {
#   region = var.aws_region
# }


# # Docker Agent Instance
# # Agent that runs docker containers
# resource "aws_instance" "docker" {
#   count         = 1  # Set to desired number of instances 
#   ami           = var.ami
#   instance_type = var.instance_type
#   key_name = var.key_name
#   vpc_security_group_ids = [var.security_group_id]
#   tags = {
#     Name = "Test-FE-BE"
#     Managed_By  = "Terraform"
#   }
# }





# # Generate the Ansible inventory file
# resource "local_file" "ansible_inventory" {
#   content = templatefile("${path.module}/../ansible/inventory.yaml.tpl", {
  
#     docker_node_ip   = aws_instance.docker[0].public_ip 
#     key_name         = "${var.key_path}/${var.key_name}.pem"
#     ssh_user         = var.ssh_user
  
#   })
#   filename = "${path.module}/../ansible/inventory.yaml"
# }

# # Generate the Ansible configuration file
# resource "local_file" "ansible_cfg" {
#   content = templatefile("${path.module}/../ansible/ansible.cfg.tpl", {
#     inventory_file = "${path.module}/../ansible/inventory.yaml"
#     remote_user = var.ssh_user
#     private_key_file = "${var.key_path}${var.key_name}.pem"
#     host_key_checking = false
#   })
#   filename = "${path.module}/../ansible/ansible.cfg"
# }

# # Run Ansible after inventory is created
# resource "null_resource" "run_ansible" {
#   depends_on = [local_file.ansible_inventory]

#   provisioner "local-exec" {
#     command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i ${path.module}/../ansible/inventory.yaml ${path.module}/../ansible/main.yaml "
#   }
# }


# output "docker_node_ip" {
#   value = aws_instance.docker[0].public_ip
# }


# output "key_name" {
#   value = var.key_name
# }