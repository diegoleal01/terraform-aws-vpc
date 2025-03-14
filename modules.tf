module "vpc" {
  source                 = "./modules/vpc"
  vpc_cidr_block         = var.vpc_cidr_block
  project_name           = var.project_name
  newbits_private_subnet = var.newbits_private_subnet
  newbits_public_subnet  = var.newbits_public_subnet
  nat_public_subnet_id   = module.vpc.nat_public_subnet_id
  tags                   = local.tags
}