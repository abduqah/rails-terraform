#----s3/main.tf----

# Create a random id
resource "random_id" "tf_bucket_id" {
  byte_length = 2
}

# Create the bucket
resource "aws_s3_bucket" "tf_s3" {
    bucket        = format("la-terraform-%d", random_id.tf_bucket_id.dec)
    acl           = "private"

    force_destroy =  true

    tags = {
      Name = "${var.aws_resource_prefix}_bucket"
    }
}
