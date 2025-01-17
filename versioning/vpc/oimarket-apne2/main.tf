locals {
  config = yamldecode(file("config.yaml"))
}

module "vpc" {
  source = "../../modules/vpc"

  vpc_name        = local.config.vpc_name
  cidr_block      = local.config.cidr_block
  subnets         = local.config.subnets
  security_groups = local.config.security_groups
  ingress_rules   = local.config.ingress_rules
  egress_rules    = local.config.egress_rules
}
