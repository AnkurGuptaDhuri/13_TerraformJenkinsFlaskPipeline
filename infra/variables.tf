variable "bucket_name" {
  type        = string
  description = "Remote state bucket name"
}

/*
variable "environment" {
  type        = string
  description = "Environment name"
} */

variable "vpc_cidr" {
  type        = string
  description = "Public Subnet CIDR values"
}

variable "vpc_name" {
  type        = string
  description = "VPC name: Terraform Jenkins Flask pipeline"
}

variable "cidr_public_subnet" {
  type        = list(string)
  description = "Public Subnet CIDR values"
}

variable "cidr_private_subnet" {
  type        = list(string)
  description = "Private Subnet CIDR values"
}

variable "availability_zone" {
  type        = list(string)
  description = "Availability Zones"
}

/*
variable "public_key" {
  type        = string
  description = "Terrform Jenkins Project - Public key for EC2 instance"
}*/

variable "ec2_key_pair" {
  type        = string
  description = "Ec2 key pair which is already created in account"
}

variable "ec2_ami_id" {
  type        = string
  description = "Terrform Jenkins Project - AMI Id for EC2 instance"
}

variable "region" {
  type = string
  description = "Define the region for this infrastructure"
  
}