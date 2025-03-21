# TERRAFORM-AWS-VPC
This project provides an AWS VPC through the essential resources, such as subnets, route tables, and others.

## Modules
The Terraform code was built using the following modules:

### VPC  
Provides a VPC with private and public subnets. The subnet calculation is performed using the cidrsubnet function. This function splits a CIDR block into smaller subnets, and the values to use with it must be defined by variables.

**cidrsubnet function syntax:**  
```bash
cidrsubnet(prefix, newbits, netnum)
```
- **prefix:** The original CIDR block that will be split. For example, 10.0.0.0/21 is a CIDR block that can be subdivided into smaller subnets. This value is defined when the vpc_cidr_block variable is set.

- **newbits:** The number of additional bits that will be used to create new subnets. The larger this number, the smaller the resulting subnets will be. For example, if the original CIDR block is /21 and newbits is 3, the resulting subnets will be /24. The newbits value is defined by setting the newbits_private_subnet and newbits_public_subnet variables.

- **netnum:** The index of the subnet within the range of possible subnets. It determines which specific subnet will be selected from the available ones. The value must be an integer, starting from 0. For example, if the original CIDR block is /21 and newbits is 3, the available subnets will have a /24 prefix, and netnum = 0 will select the first subnet, netnum = 1 the second, and so on. The netnum value is defined by setting the private_subnet_numbers and public_subnet_numbers variables in the variables.tf file within the VPC module.

More details about this Terraform function can be found in the HashiCorp [documentation](https://developer.hashicorp.com/terraform/language/functions/cidrsubnet).

### Route  
Sets up two route tables: one that will work with the NAT Gateway and be associated with the private subnets, and another that will work with the Internet Gateway and be associated with the public subnets.

### Security  
Creates two Security Groups: one for internal VPC traffic, and another that allows access from a specific LAN, which can be a home, office, or any network you work from. Since this project provides a secure connection through a VPN, the security group for LAN access is intentionally permissive, with a rule to allow all traffic. However, this can be adjusted if necessary.

### VPN  
Provides the resources to create a Site-to-Site VPN with a local network. After creating the tunnel on the AWS side, it is necessary to establish the connection on the local network firewall.

## :warning: Notes
- **Region configuration**  
In the variables.tf and output.tf files within the VPC module, the region is not set by variables. Therefore, you need to manually change the value as required. This will be addressed in future improvements.

- **EKS clusters and ELB**  
To set up the VPC to work with a Kubernetes cluster on EKS, it is necessary to uncomment some tags in the aws_subnet resources in the vpc.tf file within the VPC module. This will enable communication between the cluster and the load balancers through the subnets.


## How to use

### Variables
Create a file named "terraform.tfvars" in the project root and populate it with variables as shown in the following example
```hcl
project_name               = "devops"           # Name of the project used to prefix resource names
region_id                  = "us-east-1"        # The AWS region where resources will be provisioned
cli_profile                = "devops-cli"       # The AWS CLI profile to use for authentication and access
vpc_cidr_block             = "10.0.0.0/24"      # The IPv4 CIDR block to assign to the VPC
newbits_private_subnet     = "3"                # Number of additional bits to extend the VPC CIDR for private subnets"
newbits_public_subnet      = "3"                # Number of additional bits to extend the VPC CIDR for public subnets
office_lan_cidr_block      = "192.168.0.0/16"   # The CIDR block representing the office network for restricted access
office_external_gateway_ip = "82.129.81.110"    # The external IP address of the office's internet gateway
```

### Terminal
After setting the variables as needed, execute the following Terraform commands
```bash
terraform init
terraform plan
terraform apply
```