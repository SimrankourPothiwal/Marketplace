variable "aws_region" {
  default = "us-west-2"
}
variable "vpc_cidr" {
  default = "172.8.0.0/16"
}
variable "private_subnet1_cidr" {
    default = "172.8.16.0/20"
}
variable "private_subnet2_cidr" {
    default = "172.8.32.0/20" 
}
variable "public_subnet1_cidr" {
    default = "172.8.64.0/20"
}
variable "public_subnet2_cidr" {
    default = "172.8.128.0/20"
}
variable "tenancy" {
  default = "default"
}
variable "public_ip_on_launch" {
    default = true 
}
variable "vpc_tags" {
  type = "map"

  default = {
    Name              = "Marketplace"
    Environment       = "qa"
    ApplicationOwner = "7now"
    Managed_by        = "terraform"
    CreatorName       = "ssoma"
  }
}