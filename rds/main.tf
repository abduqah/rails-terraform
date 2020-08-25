#----rds/main.tf----

# create postgres instance
resource "aws_db_instance" "tf_postgres" {
  identifier             = "${var.aws_resource_prefix}-database"
  allocated_storage      = 10
  engine                 = "postgres"
  engine_version         = "9.6.9"
  instance_class         = var.db_instance_class
  name                   = "${var.aws_resource_prefix_alphanumeric}db"
  username               = var.dbuser
  password               = var.dbpassword
  db_subnet_group_name   = var.rds_subnet_group_id
  vpc_security_group_ids = var.vpc_security_group_ids
  storage_encrypted      = false
  skip_final_snapshot    = true
}
