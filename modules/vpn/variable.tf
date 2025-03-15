variable "project_name" {
  type        = string
  description = "Name of the project used to prefix resource names"
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to apply to AWS resources"
}

variable "office_cgw_name" {
  type        = string
  default     = "customer-gateway-principal-link"
  description = "The name of the Customer Gateway (CGW) for the corporate network"
}

variable "vpc_id" {
  type        = string
  description = "The ID of the VPC where resources will be deployed"
}

variable "office_lan_cidr_block" {
  type        = string
  description = "The CIDR block representing the office network for restricted access"
}

variable "private_rtb_id" {
  type        = string
  description = "The ID of the private route table (RTB) for subnet associations"
}

variable "public_rtb_id" {
  type        = string
  description = "The ID of the public route table (RTB) for subnet associations"
}

variable "office_external_gateway_ip" {
  type        = string
  description = "The external IP address of the office's internet gateway"
}