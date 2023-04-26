provider "aws" {
  region  = "us-east-2"
  profile = "default"
}
resource "aws_lb" "example" {
  name               = "example"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.sg.id]
  subnets            = [aws_subnet.public_a.id, aws_subnet.public_b.id]
}
resource "aws_lb_target_group" "example" {
  name     = "example"
  vpc_id   = aws_vpc.example.id
  port     = 80
  protocol = "HTTP"

  health_check {
    path = "/"
  }
}
resource "aws_lb_listener" "example" {
  load_balancer_arn = aws_lb.example.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.example.arn
  }
}
resource "aws_key_pair" "key" {
  key_name   = "terra"
  public_key = file("${path.module}/id_rsa.pub")
}
resource "aws_launch_template" "example" {
  name                   = "example"
  image_id               = "ami-06c4532923d4ba1ec"
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.key.key_name
  user_data              = filebase64("${path.module}/userdata.sh")
  network_interfaces {
    associate_public_ip_address = true
    security_groups = ["${aws_security_group.sg.id}"]
  }
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "example-instance"
    }
  }
}
resource "aws_autoscaling_group" "example" {
  name                      = "example"
  max_size                  = 3
  min_size                  = 1
  desired_capacity          = 2
  health_check_grace_period = 300
  vpc_zone_identifier       = [aws_subnet.public_a.id, aws_subnet.public_b.id]
  launch_template {
    id      = aws_launch_template.example.id
    version = "$Latest"
  }
  target_group_arns = [aws_lb_target_group.example.arn]
}
resource "aws_autoscaling_attachment" "asg_attachment_bar" {
  autoscaling_group_name = aws_autoscaling_group.example.id
  lb_target_group_arn    = aws_lb_target_group.example.arn
}