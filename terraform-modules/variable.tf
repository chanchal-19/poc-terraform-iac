
variable "environment" {}
variable "aws_region" {}
variable "vpc_cidr" {}
variable "ami" {}
variable "instance_type" {}
variable "public_subnet_cidr" {
  description = "CIDR for the public subnet"
  default     = "10.0.1.0/24"
}