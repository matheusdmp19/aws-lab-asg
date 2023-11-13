module "network" {
  source = "./modules/network"

  vpc_cidr_block = var.vpc_cidr_block
}

module "asg" {
  source = "./modules/asg"

  instance_type = var.instance_type
  ssh_key_pair  = var.ssh_key_pair

  asg_vpc    = module.network.asg_vpc
  asg_subnet = module.network.asg_subnet
}
