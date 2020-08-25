#----lb/main.tf----

resource "aws_lb" "tf_load_balancer" {
  name               = "${var.aws_resource_prefix}-lb-tf" # Naming our load balancer
  subnets            = var.public_subnets
  security_groups    = var.public_sg
}


resource "aws_lb_target_group" "tf_target_group" {
  name        = "${var.aws_resource_prefix}-target-group"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id
  depends_on  = [aws_lb.tf_load_balancer]
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb_listener" "tf_listener" {
  load_balancer_arn = aws_lb.tf_load_balancer.arn # Referencing our load balancer
  port              = "80"
  protocol          = "HTTP"
  depends_on        = [aws_lb_target_group.tf_target_group]
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tf_target_group.arn # Referencing our tagrte group
  }
}

