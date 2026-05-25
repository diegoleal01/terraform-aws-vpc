# terraform-aws-vpc

Reusable Terraform module for provisioning a VPC on AWS with public and private subnets spread across multiple Availability Zones.

---

## Architecture

The module provisions a standard multi-AZ VPC topology:

- **VPC** with configurable CIDR, DNS hostnames and DNS resolution enabled
- **Public subnets** — one per AZ, connected to an Internet Gateway
- **Private subnets** — one per AZ, connected to a NAT Gateway
- **Internet Gateway** attached to the VPC
- **NAT Gateway** (single, in the first AZ) with an associated Elastic IP
- **Route tables** — one public (default route → IGW), one private (default route → NGW), each associated with its subnet tier

---

## Requirements

- Terraform `>= 1.10`
- AWS provider `~> 6.0`

An AWS provider must be configured by the calling module:

```hcl
provider "aws" {
  region = "us-east-1"
}
```

---

## Usage

```hcl
module "vpc" {
  source = "github.com/diegoleal01/terraform-aws-vpc?ref=v1.0.1"

  project_name           = "my-project"
  vpc_cidr_block         = "10.0.0.0/16"
  newbits_public_subnet  = 8
  newbits_private_subnet = 8
  az_count               = 3

  tags = {
    Project     = "my-project"
    Environment = "staging"
    Owner       = "platform-team"
  }
}
```

Referencing outputs in other resources:

```hcl
resource "aws_eks_cluster" "this" {
  name     = "my-cluster"
  role_arn = aws_iam_role.cluster.arn

  vpc_config {
    subnet_ids = values(module.vpc.private_subnet_ids)
  }
}
```

---

## Inputs

- **`project_name`** `string` — Prefix used in all resource names (e.g. `vpc-<project_name>`).
- **`vpc_cidr_block`** `string` — IPv4 CIDR block for the VPC.
- **`newbits_public_subnet`** `number` — Bits added to the VPC prefix to size public subnets. See [Subnet sizing](#subnet-sizing).
- **`newbits_private_subnet`** `number` — Bits added to the VPC prefix to size private subnets. See [Subnet sizing](#subnet-sizing).
- **`az_count`** `number` — Number of Availability Zones to use. Accepted values: `2` or `3`.
- **`tags`** `map(string)` — Tags applied to all resources. `ManagedBy = "Terraform"` is merged in automatically.

All inputs are required.

---

## Outputs

- **`vpc_id`** `string` — ID of the VPC.
- **`igw_id`** `string` — ID of the Internet Gateway.
- **`ngw_id`** `string` — ID of the NAT Gateway.
- **`public_subnet_ids`** `map(string)` — Map of `availability_zone → subnet_id` for public subnets.
- **`private_subnet_ids`** `map(string)` — Map of `availability_zone → subnet_id` for private subnets.

---

## Subnet sizing

`newbits_public_subnet` and `newbits_private_subnet` are passed directly to Terraform's [`cidrsubnet()`](https://developer.hashicorp.com/terraform/language/functions/cidrsubnet) function. The value is the number of additional bits added to the VPC prefix length to produce each subnet.

Example: `vpc_cidr_block = "10.0.0.0/16"`, `az_count = 3`, both `newbits = 8` → `/24` subnets:

```
Public  us-east-1a  10.0.0.0/24
Public  us-east-1b  10.0.1.0/24
Public  us-east-1c  10.0.2.0/24
Private us-east-1a  10.0.3.0/24
Private us-east-1b  10.0.4.0/24
Private us-east-1c  10.0.5.0/24
```

Private subnets use a `netnum` offset equal to `az_count` to avoid overlapping with public subnets. Keep both `newbits` values equal to maintain a uniform address space and prevent accidental overlaps.

---

## Known limitations

- **Always full topology:** NAT Gateway and private subnets are always created. A cost-optimized mode (public subnets only, no NAT) is planned for a future release.
- **Single NAT Gateway:** deployed in the first AZ only. Multi-NAT for cross-AZ high availability is planned for a future release.
- **IPv6:** not supported.

---

## License

[MIT](LICENSE)
