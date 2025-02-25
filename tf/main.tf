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

resource "aws_instance" "app" {
  count         = 3  # Create three instances
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name
  vpc_security_group_ids = [var.security_group_id]
  tags = {
    Name       = count.index == 0 ? "monithor-fe" : count.index == 1 ? "monithor-be" : "monithor-db"
    Managed_By = "Terraform"
  }
}

resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/../ansible/inventory.yaml.tpl", {
    app_node_ips = aws_instance.app.*.public_ip
    key_name        = "${var.key_path}/${var.key_name}.pem"
    ssh_user        = var.ssh_user
  })
  filename = "${path.module}/../ansible/inventory.yaml"
}

resource "local_file" "ansible_cfg" {
  content = templatefile("${path.module}/../ansible/ansible.cfg.tpl", {
    inventory_file   = "${path.module}/../ansible/inventory.yaml"
    remote_user      = var.ssh_user
    private_key_file = "${var.key_path}${var.key_name}.pem"
    host_key_checking = false
  })
  filename = "${path.module}/../ansible/ansible.cfg"
}

resource "null_resource" "wait_for_ssh" {
  provisioner "local-exec" {
    command = "sleep 60"  # Wait for 20 seconds
  }
}

resource "null_resource" "run_ansible" {
  depends_on = [local_file.ansible_inventory, null_resource.wait_for_ssh]

  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i ${path.module}/../ansible/inventory.yaml ${path.module}/../ansible/main.yaml"
  }
}

output "app_node_ips" {
  value = aws_instance.app.*.public_ip
  description = "List of public IP addresses for the application nodes"
}

output "frontend_ip" {
  value = aws_instance.app[0].public_ip
  description = "Public IP address for the frontend node (monithor-fe)"
}

output "backend_ip" {
  value = aws_instance.app[1].public_ip
  description = "Public IP address for the backend node (monithor-be)"
}

output "database_ip" {
  value = aws_instance.app[2].public_ip
  description = "Public IP address for the database node (monithor-db)"
}

output "key_name" {
  value = var.key_name
  description = "Name of the SSH key used for accessing the instances"
}
