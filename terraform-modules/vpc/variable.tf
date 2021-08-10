
variable "environment" {}

variable "vpc_cidr" {}

variable "public_subnet_cidr" {
  description = "CIDR for the public subnet"
  default     = "10.0.1.0/24"
}

variable "public_subnet_cidr_blocks" {
  default     = ["10.50.250.0/24", "10.50.251.0/24", "10.50.252.0/24"]
  description = "List of public subnet CIDR blocks"
}
variable "private_subnet_cidr_blocks" {
  default     = ["10.50.253.0/24", "10.50.254.0/24", "10.50.255.0/24"]
  description = "List of private subnet CIDR blocks"
}