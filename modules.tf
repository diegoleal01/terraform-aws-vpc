module "vpc" {
  source                 = "./modules/vpc"
  vpc_cidr_block         = var.vpc_cidr_block
  project_name           = var.project_name
  newbits_private_subnet = var.newbits_private_subnet
  newbits_public_subnet  = var.newbits_public_subnet
  ngw_public_subnet_id   = module.vpc.ngw_public_subnet_id
  tags                   = local.tags
}

module "route" {
  source            = "./modules/route"
  project_name      = var.project_name
  tags              = local.tags
  vpc_id            = module.vpc.vpc_id
  igw_id            = module.vpc.igw_id
  ngw_id            = module.vpc.ngw_id
  public_subnet_id  = module.vpc.public_subnet_id
  private_subnet_id = module.vpc.private_subnet_id
}