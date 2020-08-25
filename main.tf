#----root/main.tf----

provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = var.aws_region
  version    = "~> 2.7"
}

# Cloud watch resources

module "cloud_watch" {
  source              = "./cloud_watch"
  aws_resource_prefix = var.aws_resource_prefix
}

# Deploy vpc resources
module "vpc" {
  source              = "./vpc"
  aws_resource_prefix = var.aws_resource_prefix
  vpc_cidr            = var.vpc_cidr
}

# Deploy subnets resources
module "subnets" {
  source              = "./subnets"
  aws_resource_prefix = var.aws_resource_prefix
  vpc_id              = module.vpc.vpc_id
  public_cidrs        = var.public_cidrs
  private_cidrs       = var.private_cidrs
}

# Deploy security groups Resources
module "security_groups" {
  source                     = "./security_groups"
  aws_resource_prefix        = var.aws_resource_prefix
  vpc_id                     = module.vpc.vpc_id
  vpc_cidr                   = var.vpc_cidr
  accessip                   = var.accessip
}

# Deploy nat Resources
module "nat" {
  source                     = "./nat_service"
  aws_resource_prefix        = var.aws_resource_prefix
  vpc_id                     = module.vpc.vpc_id
  vpc_default_route_table_id = module.vpc.default_route_table_id
  public_subnets             = module.subnets.public_subnet_ids
  private_subnets            = module.subnets.private_subnet_ids
}

# Deploy cache services resources
module "cache_services" {
  source                 = "./cache_services"
  private_subnets        = module.subnets.private_subnet_ids
  aws_resource_prefix    = var.aws_resource_prefix
  elasticache_cluster_id = var.elasticache_cluster_id
  ec_instance_node_type  = var.ec_instance_node_type
}

# Deploy s3 resources
module "s3" {
  source                 = "./s3"
  aws_resource_prefix    = var.aws_resource_prefix
}

# Deploy rds Resources
module "rds" {
  source                           = "./rds"
  aws_resource_prefix              = var.aws_resource_prefix
  aws_resource_prefix_alphanumeric = var.aws_resource_prefix_alphanumeric
  vpc_security_group_ids           = [module.security_groups.rds_sg]
  rds_subnet_group_id              = module.subnets.rds_subnet_group_id
  db_instance_class                = var.db_instance_class
  dbname                           = var.dbname
  dbuser                           = var.dbuser
  dbpassword                       = var.dbpassword
}

# Deploy iam role
module "iam_role" {
  source              = "./iam"
  aws_resource_prefix = var.aws_resource_prefix
}

# Deploy ecr service
module "ecr_service" {
  source              = "./ecr_service"
  aws_resource_prefix = var.aws_resource_prefix

}

# Deploy load balancer
module "lb" {
  source                = "./lb"
  aws_resource_prefix   = var.aws_resource_prefix
  public_sg             = module.security_groups.lb_security_groups_ids
  vpc_id                = module.vpc.vpc_id
  public_subnets        = module.subnets.public_subnet_ids
}

# Deploy ecs module
module "ecs" {
  source                  = "./ecs"
  aws_resource_prefix     = var.aws_resource_prefix
  repository_url          = module.ecr_service.repo_url
  iam_role_arn            = module.iam_role.iam_role_arn
  aws_lb_target_group_arn = module.lb.aws_lb_target_group_arn
  public_subnets          = module.subnets.public_subnet_ids
  public_sg               = module.security_groups.ecs_security_groups_ids
  instances_number        = var.instances_number
  aws_region              = var.aws_region
  logger_group            = module.cloud_watch.logger_group_name
}

