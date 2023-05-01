resource "aws_key_pair" "key" {
  key_name   = "bastion"
  public_key = file("${path.module}/id_rsa.pub")
}
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}
resource "aws_launch_template" "bastion_host_template" {
  name                   = "bastion_host_template"
  image_id               = data.aws_ami.ubuntu.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [var.vpc_security_group_ids]
  key_name               = aws_key_pair.key.key_name
  # user_data              = filebase64("${path.module}/scripts.sh")
    user_data = base64encode(<<-EOF
    #!/bin/bash
    echo '${filebase64("${path.module}/id_rsa")}' | base64 --decode > /home/ubuntu/id_rsa
    sudo chmod 600 /home/ubuntu/id_rsa
  EOF
  )
  # echo '${base64encode(file("${path.module}/id_rsa"))}' | base64 --decode > /home/ubuntu/id_rsa
  # connection {
  #   type        = "ssh"
  #   user        = "ubuntu"
  #   private_key = file("${path.module}/id_rsa")
  #   # host        = self.public_ip
  # }
  # provisioner "file" {
  #   source      = "id_rsa"
  #   destination = "/home/ubuntu/id_rsa"
  # }
  # user_data              = filebase64("${path.module}/userdata.sh")
  # network_interfaces {
  #   associate_public_ip_address = true
  #   security_groups = ["${aws_security_group.sg.id}"]
  # }
  # tag_specifications {
  #   resource_type = "instance"
  #   tags = {
  #     Name = "bastion-host-template"
  #   }
  # }
}
resource "aws_autoscaling_group" "bastion_host_scaling" {
  name                      = "bastion_host_scaling"
  max_size                  = 1
  min_size                  = 1
  desired_capacity          = 1
  health_check_grace_period = 300
  vpc_zone_identifier       = var.pub_sub_ids
  launch_template {
    id      = aws_launch_template.bastion_host_template.id
    version = "$Latest"
  }
  # target_group_arns = [aws_lb_target_group.example.arn]
}
# resource "aws_autoscaling_attachment" "asg_attachment_bar" {
#   autoscaling_group_name = aws_autoscaling_group.example.id
#   lb_target_group_arn    = aws_lb_target_group.example.arn
# }
# resource "aws_lb" "example" {
#   name               = "example"
#   load_balancer_type = "application"
#   security_groups    = [aws_security_group.sg.id]
#   subnets            = [aws_subnet.public_a.id, aws_subnet.public_b.id]
# }
# resource "aws_lb_target_group" "example" {
#   name     = "example"
#   vpc_id   = aws_vpc.example.id
#   port     = 80
#   protocol = "HTTP"

#   health_check {
#     path = "/"
#   }
# }
# resource "aws_lb_listener" "example" {
#   load_balancer_arn = aws_lb.example.arn
#   port              = "80"
#   protocol          = "HTTP"

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.example.arn
#   }
# }