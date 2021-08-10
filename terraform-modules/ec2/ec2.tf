resource "aws_network_interface" "ec2" {
  subnet_id       = var.public_subnet_id
  security_groups = [aws_security_group.ec2.id]
  tags = {
    Name        = "${var.environment}-nf"
    environment = var.environment
  }
}

resource "aws_instance" "ec2" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = "${var.environment}-keypair"

  network_interface {
    network_interface_id = aws_network_interface.ec2.id
    device_index         = 0
  }

  tags = {
    Name        = "${var.environment}-server"
    environment = var.environment
  }
}

resource "aws_security_group" "ec2" {
  vpc_id      = var.vpc_id
  name        = "${var.environment}-ec2-sg"
  description = "security group that allows ssh and egress traffic to the nodes"

  tags = {
    Name        = "${var.environment}-ec2-sg"
    environment = var.environment
  }
}

## INGRESS RULE #1
resource "aws_security_group_rule" "allow_ec2_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.ec2.id
  cidr_blocks       = ["0.0.0.0/0"]
}