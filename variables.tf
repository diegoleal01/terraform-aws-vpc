variable "project_name" {
  type        = string
  description = "Name of the project used to prefix resource names"
}

variable "vpc_cidr_block" {
  type        = string
  description = "The IPv4 CIDR block to assign to the VPC"
}

variable "newbits_private_subnet" {
  type        = number
  description = "Number of additional bits to extend the VPC CIDR for private subnets"
}

variable "newbits_public_subnet" {
  type        = number
  description = "Number of additional bits to extend the VPC CIDR for public subnets"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all resources"
}