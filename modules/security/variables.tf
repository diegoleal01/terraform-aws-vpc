variable "project_name" {
  type        = string
  description = "Name of the project used to prefix resource names"
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to apply to AWS resources"
}

variable "office_access_sg_name" {
  type        = string
  default     = "office-access"
  description = "The name of the security group for office network access"
}

variable "office_cidr_block" {
  type        = string
  description = "The CIDR block representing the office network for restricted access"
}

variable "default_route" {
  type        = string
  default     = "0.0.0.0/0"
  description = "The default IPv4 route used for routing traffic"
}

variable "vpc_access_sg_name" {
  type        = string
  default     = "vpc-access"
  description = "The name of the security group for local VPC access"
}

variable "vpc_cidr_block" {
  type        = string
  description = "The IPv4 CIDR block to assign to the VPC"
}

variable "vpc_id" {
  type        = string
  description = "The ID of the VPC where resources will be deployed"
}