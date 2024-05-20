  vpc_cidr = "11.0.0.0/16"
  vpc_name = "vpc_terraformjenkins"
  cidr_public_subnet = ["11.0.1.0/24","11.0.2.0/24"]
  cidr_private_subnet  = ["11.0.3.0/24", "11.0.4.0/24"]
  availability_zone = ["eu-north-1a", "eu-north-1b"]

ec2_ami_id = "ami-0705384c0b33c194c"
ec2_key_pair = "ec2-keypair"    #please create the Ec2 key pair manually.
#public_key = ""
bucket_name = "13-terraformjenkins-remotebackend"
region = "eu-north-1"