variable "project_name" {
  type        = string
  description = "Name of the project used to prefix resource names"
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to apply to AWS resources"
}

variable "default_route" {
  type        = string
  default     = "0.0.0.0/0"
  description = "The default IPv4 route used for routing traffic"
}

variable "vpc_id" {
  type        = string
  description = "The ID of the VPC where resources will be deployed"
}

variable "igw_id" {
  type        = string
  description = "The ID of the Internet Gateway (IGW) attached to the VPC"
}

variable "ngw_id" {
  type        = string
  description = "The ID of the NAT Gateway (NGW) used for private subnet internet access"
}

variable "public_subnet_id" {
  type        = map(string)
  description = "A map of public subnet IDs for route table association"
}

variable "private_subnet_id" {
  type        = map(string)
  description = "A map of private subnet IDs for route table association"
}