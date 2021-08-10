module "vpc" {
  source      = "./vpc"
  environment = var.environment
  vpc_cidr    = var.vpc_cidr
}

module "ec2" {
  source           = "./ec2"
  environment      = var.environment
  ami              = var.ami
  public_subnet_id = module.vpc.public_subnets[0]
  instance_type    = var.instance_type
  vpc_id           = module.vpc.vpc_id
}