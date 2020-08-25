#----ecr service/main.tf----

resource "aws_ecr_repository" "tf_repository" {
  name = "${var.aws_resource_prefix}-repo"
}
