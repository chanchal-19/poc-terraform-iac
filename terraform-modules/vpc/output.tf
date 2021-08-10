output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "vpc_igw_id" {
  value = aws_internet_gateway.igw.id
}

output "vpc_nat_id" {
  value = aws_nat_gateway.nat_gw.*.id
}

output "public_subnets" {
  value = aws_subnet.public.*.id
}

output "private_subnets" {
  value = aws_subnet.private.*.id
}

output "public_routetable_id" {
  value = aws_route_table.public.id
}

output "private_routetable_id" {
  value = aws_route_table.private.*.id
}