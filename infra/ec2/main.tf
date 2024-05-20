variable "ami_id" {}
variable "instance_type" {}
variable "tag_name" {}
variable "subnet_id" {}
variable "sg_enable_ssh_https" {}
variable "enable_public_ip_address" {}
variable "user_data" {}
variable "ec2_sg_name_for_python_api" {}
variable "ec2_key_pair" {}

output "ssh_connection_string_for_ec2" {
  value = format("%s%s", "ssh -i /home/ubuntu/keys/aws_ec2_terraform ubuntu@", aws_instance.tj_ec2.public_ip)
}

output "tj_ec2_instance_id" {
  value = aws_instance.tj_ec2.id
}

# Resource Creation e.g. EC2
resource "aws_instance" "tj_ec2" {
  ami           = var.ami_id
  instance_type = var.instance_type
  tags = {
    Name = var.tag_name
  }
  key_name                    = var.ec2_key_pair  #"aws_key"
  subnet_id                   = var.subnet_id[0]
  vpc_security_group_ids      = [var.sg_enable_ssh_https, var.ec2_sg_name_for_python_api]
  associate_public_ip_address = var.enable_public_ip_address
  user_data = var.user_data


  metadata_options {
    http_endpoint = "enabled"  # Enable the IMDSv2 endpoint
    http_tokens   = "required" # Require the use of IMDSv2 tokens
  }
}

/*
resource "aws_key_pair" "tj_public_key" {
  key_name   = "aws_key"
  public_key = var.public_key
}
*/