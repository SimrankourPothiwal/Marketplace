output "vpc_id" {
  value = "${aws_vpc.main.id}"
}
output "private_subnet1" {
    value = "${aws_subnet.private_subnet1.id}"
}
output "private_subnet2" {
    value = "${aws_subnet.private_subnet2.id}"
}
output "public_subnet1" {
    value = "${aws_subnet.public_subnet1.id}"
}
output "public_subnet2" {
    value = "${aws_subnet.public_subnet2.id}"
}
output "igw_id" {
    value = "${aws_internet_gateway.public-gw.id}"
}
output "public_routetable_id" {
    value = "${aws_route_table.public-rt.id}"
}
output "private_routable_id" {
    value = "${aws_route_table.private-rt.id}"
}
output "eip" {
    value = "${aws_eip.nat-ip.public_ip}"
}
output "aws_nat_gateway_id" {
    value = "${aws_nat_gateway.nat-gw.id}"
} 