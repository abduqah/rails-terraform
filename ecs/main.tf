#----ecs/main.tf----

resource "aws_ecs_cluster" "tf_cluster" {
  name = "${var.aws_resource_prefix}-cluster" # Naming the cluster
}

resource "aws_ecs_task_definition" "tf_task" {
  family                   = "${var.aws_resource_prefix}-task" # Naming our first task
  container_definitions    = <<DEFINITION
  [
    {
      "name": "${var.aws_resource_prefix}-task",
      "image": "${var.repository_url}",
      "essential": true,
      "portMappings": [
        {
          "containerPort": 80,
          "hostPort": 80
        }
      ],
      "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-group": "${var.logger_group}",
          "awslogs-region": "${var.aws_region}",
          "awslogs-stream-prefix": "web"
        }
      }
    }
  ]
  DEFINITION
  requires_compatibilities = ["FARGATE"] # Stating that we are using ECS Fargate
  network_mode             = "awsvpc"    # Using awsvpc as our network mode as this is required for Fargate
  memory                   = 8192         # Specifying the memory our container requires
  cpu                      = 4096         # Specifying the CPU our container requires
  execution_role_arn       = var.iam_role_arn
}

resource "aws_ecs_service" "tf_service" {
  name            = "${var.aws_resource_prefix}-service"                             # Naming our first service
  cluster         = aws_ecs_cluster.tf_cluster.id             # Referencing our created Cluster
  task_definition = aws_ecs_task_definition.tf_task.arn # Referencing the task our service will spin up
  launch_type     = "FARGATE"
  desired_count   = var.instances_number # Setting the number of containers to 3

  load_balancer {
    target_group_arn = var.aws_lb_target_group_arn # Referencing our target group
    container_name   = aws_ecs_task_definition.tf_task.family
    container_port   = 80 # Specifying the container port
  }

  network_configuration {
    subnets          = var.public_subnets
    assign_public_ip = true                                                # Providing our containers with public IPs
    security_groups  = var.public_sg
  }
}
