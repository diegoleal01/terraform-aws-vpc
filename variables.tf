variable "project_name" {
  type        = string
  description = "Name of the project used to prefix resource names"
}

variable "region_id" {
  type        = string
  description = "The AWS region where resources will be provisioned"
}

variable "cli_profile" {
  type        = string
  description = "The AWS CLI profile to use for authentication and access"
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

variable "office_lan_cidr_block" {
  type        = string
  description = "The CIDR block representing the office network for restricted access"
}

variable "office_external_gateway_ip" {
  type        = string
  description = "The external IP address of the office's internet gateway"
}