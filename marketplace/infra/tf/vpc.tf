resource "aws_vpc" "main" {
  cidr_block       = "${var.vpc_cidr}"
  instance_tenancy = "${var.tenancy}"
  enable_dns_support               = true
  enable_dns_hostnames             = true
  assign_generated_ipv6_cidr_block = false
  tags = "${var.vpc_tags}"
}

resource "aws_subnet" "private_subnet1" {
    vpc_id = "${aws_vpc.main.id}"
    cidr_block = "${var.private_subnet1_cidr}"
    availability_zone = "${data.aws_availability_zones.available.names[0]}"
    tags = {
        Name = "PrivateSubnet1"
    }
}

resource "aws_subnet" "private_subnet2" {
    vpc_id = "${aws_vpc.main.id}"
    cidr_block = "${var.private_subnet2_cidr}"
    availability_zone = "${data.aws_availability_zones.available.names[1]}"
    tags = {
        Name = "PrivateSubnet2"
    }

}

resource "aws_subnet" "public_subnet1" {
    vpc_id = "${aws_vpc.main.id}"
    cidr_block = "${var.public_subnet1_cidr}"
    availability_zone = "${data.aws_availability_zones.available.names[0]}"
    map_public_ip_on_launch = "${var.public_ip_on_launch}"
    tags = {
        Name = "PublicSubnet1"
    }
}

resource "aws_subnet" "public_subnet2" {
    vpc_id = "${aws_vpc.main.id}"
    cidr_block = "${var.public_subnet2_cidr}"
    availability_zone = "${data.aws_availability_zones.available.names[1]}"
    map_public_ip_on_launch = "${var.public_ip_on_launch}"
    tags = {
        Name = "PublicSubnet2"
    }
}
resource "aws_internet_gateway" "public-gw" {
    vpc_id = "${aws_vpc.main.id}"
    tags = "${var.vpc_tags}"
}

resource "aws_route_table" "public-rt" {
    vpc_id = "${aws_vpc.main.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.public-gw.id}"
    }
    tags = "${var.vpc_tags}"
}

resource "aws_route_table_association" "PublicSubnet1Association" {
    subnet_id = "${aws_subnet.public_subnet1.id}"
    route_table_id = "${aws_route_table.public-rt.id}"
}

resource "aws_route_table_association" "PublicSubnet2Association" {
    subnet_id = "${aws_subnet.public_subnet2.id}"
    route_table_id = "${aws_route_table.public-rt.id}"
}

resource "aws_eip" "nat-ip" {
    vpc = true 
}
resource "aws_nat_gateway" "nat-gw" {
    allocation_id = "${aws_eip.nat-ip.id}"
    subnet_id = "${aws_subnet.public_subnet1.id}"
    depends_on = [
        "aws_internet_gateway.public-gw"
    ]
}

resource "aws_route_table" "private-rt" {
    vpc_id = "${aws_vpc.main.id}"
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = "${aws_nat_gateway.nat-gw.id}"
    }
    tags = {
        Name = "private"
    }
}

resource "aws_route_table_association" "PrivateSubnet1Associtation" {
    subnet_id = "${aws_subnet.private_subnet1.id}"
    route_table_id = "${aws_route_table.private-rt.id}"
}

resource "aws_route_table_association" "PrivateSubnet2Associtation" {
    subnet_id = "${aws_subnet.private_subnet2.id}"
    route_table_id = "${aws_route_table.private-rt.id}"
}