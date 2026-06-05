provider "aws" {
  region = var.region
}
locals {
  feature_flags = {
    provision_bastion_host = var.provision_bastion_host
  }
  tags = {
    Customer           = var.customer
    Category           = var.category
    BusinessUnit       = var.business_unit
    ApplicationName    = var.applicationname
    DataClassification = var.data_classification
    ApproverName       = var.approver_name
    Environment        = var.environment
    OwnerName          = var.owner_name
    Contact            = var.contact
  }
}

#--------------------------------------------------------------------
#VPC
#--------------------------------------------------------------------

module "aws_vpc" {
  source                           = "../../resources/aws_vpc"
  vpc_cidr_block 			             = var.vpc_cidr_block
  region                           = var.region
  instance_tenancy                 = var.instance_tenancy
  enable_dns_hostnames             = var.enable_dns_hostnames
  enable_dns_support               = var.enable_dns_support
  assign_generated_ipv6_cidr_block = var.assign_generated_ipv6_cidr_block
  tags                             = local.tags
}

#--------------------------------------------------------------------
#Bastion Host
#--------------------------------------------------------------------
module "bastion_host" {
  source        = "../../resources/Bastion_Host"
  count         = local.feature_flags.provision_bastion_host == true ? 1 : 0
  vpc_id        = module.aws_vpc.id
  ami           = var.ami
  instance_type = var.instance_type
  # key_name      = var.key_name
  # subnet_id     = var.subnet_id
  tags          = local.tags
}