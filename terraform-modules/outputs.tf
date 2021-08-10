###########################
########## VPC ############
###########################

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "vpc_igw_id" {
  value = module.vpc.vpc_igw_id
}

output "vpc_nat_id" {
  value = module.vpc.vpc_nat_id
}

output "public_subnets" {
  value = module.vpc.public_subnets
}

output "private_subnets" {
  value = module.vpc.private_subnets
}

output "public_routetable_id" {
  value = module.vpc.public_routetable_id
}

output "private_routetable_id" {
  value = module.vpc.private_routetable_id
}

###########################
########## EC2 ############
###########################

output "ec2_dns" {
  value = module.ec2.ec2_dns
}

output "ec2_ip" {
  value = module.ec2.ec2_ip
}

output "ec2_sg_id" {
  value = module.ec2.ec2_sg_id
}