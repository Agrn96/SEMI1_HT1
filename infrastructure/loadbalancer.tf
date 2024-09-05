resource "aws_lb" "semi_load_balancer1" {
  name               = "elb-semi1-a-2s2024-ht1-201612174"
  internal           = false
  load_balancer_type = "application"
  
  # Use default subnets for the load balancer
  subnets            = data.aws_subnets.default.ids

  enable_deletion_protection = false
  enable_http2               = true
  security_groups    = [aws_security_group.Semi1-instances-sg1.id]
}

resource "aws_security_group" "Semi1-sg1" {
  name   = "Semi1-sg1"
  description = "Security group for load balancer"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow HTTP traffic
  }

  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow traffic on port 5000 (e.g., for Node.js app)
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]  # Allow all outbound traffic
  }
}

resource "aws_lb_listener" "web1" {
  load_balancer_arn = aws_lb.semi_load_balancer1.arn
  port              = 80  # Typically, you would listen on port 80 for HTTP traffic
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.semi_target_group1.arn
  }
}

resource "aws_lb_target_group" "semi_target_group1" {
  name     = "semi-target-group1"
  port     = 5000  # The port your application is listening on
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.default.id  # Use the default VPC

  health_check {
    enabled             = true
    interval            = 30
    matcher             = "200"
    path                = "/"
    port                = "5000"
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 2
  }
}

resource "aws_lb_target_group_attachment" "ec2_node_ht1" {
  target_group_arn = aws_lb_target_group.semi_target_group1.arn
  target_id        = aws_instance.ec2_node_ht1.id
  port             = 5000
}

resource "aws_lb_target_group_attachment" "ec2_python_ht1" {
  target_group_arn = aws_lb_target_group.semi_target_group1.arn
  target_id        = aws_instance.ec2_python_ht1.id
  port             = 5000
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}
