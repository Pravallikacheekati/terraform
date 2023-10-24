provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source = "./modules/vpc"
}

module "ec2_instance" {
  source = "./modules/ec2"
  ami_id = var.ami_id
  instance_type = var.instance_type
  vpc_id = module.vpc.vpc_id
  subnet_id = module.vpc.public_subnet_id
  sg_id = module.vpc.default_sg_id
}

output "public_ip" {
  value = module.ec2_instance.public_ip
}

