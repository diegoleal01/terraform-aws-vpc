variable "project_name" {
  type        = string
  description = "Name of the project used to prefix resource names"
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to apply to AWS resources"
}

variable "vpc_cidr_block" {
  type        = string
  description = "The IPv4 CIDR block to assign to the VPC"
}

variable "vpc_dns_hostnames" {
  type        = bool
  default     = true
  description = "Enable public DNS hostnames for instances with public IPs. Required for EKS"
}

variable "vpc_dns_support" {
  type        = bool
  default     = true
  description = "Enable DNS resolution via Amazon-provided DNS. Required for EKS"
}

variable "private_subnet_numbers" {
  type = map(number)
  default = {
    "us-east-1a" = 1
    "us-east-1b" = 2
  }
  description = "Map of availability zones to numbers for private subnet creation"
}

variable "public_subnet_numbers" {
  type = map(number)
  default = {
    "us-east-1a" = 3
    "us-east-1b" = 4
  }
  description = "Map of availability zones to numbers for public subnet creation"
}

variable "newbits_private_subnet" {
  type        = number
  description = "Number of additional bits to extend the VPC CIDR for private subnets"
}

variable "newbits_public_subnet" {
  type        = number
  description = "Number of additional bits to extend the VPC CIDR for public subnets"
}

variable "ngw_public_subnet_id" {
  type        = string
  description = "ID of the public subnet to associate with the NAT gateway"
}