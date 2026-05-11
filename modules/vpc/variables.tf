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

variable "newbits_private_subnet" {
  type        = number
  description = "Number of additional bits to extend the VPC CIDR for private subnets"
}

variable "newbits_public_subnet" {
  type        = number
  description = "Number of additional bits to extend the VPC CIDR for public subnets"
}

variable "az_count" {
  type        = number
  description = "Number of Availability Zones to spread subnets across"

  validation {
    condition     = contains([2, 3], var.az_count)
    error_message = "az_count must be 2 or 3."
  }
}