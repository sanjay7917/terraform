resource "aws_lb" "myalb" {
  name               = "my-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = [aws_subnet.pub_sub1.id, aws_subnet.pub_sub2.id]
  security_groups    = ["${aws_security_group.sg.id}"]
}
resource "aws_lb_target_group" "mytg" {
  name     = "my-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.myvpc.id
  health_check {
    path = "/"
  }
}
resource "aws_lb_listener" "mylistener" {
  load_balancer_arn = aws_lb.myalb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.mytg.arn
  }
}
resource "aws_lb_target_group_attachment" "test" {
  target_group_arn = aws_lb_target_group.mytg.arn
  target_id        = aws_instance.server.id
  port             = 80
}