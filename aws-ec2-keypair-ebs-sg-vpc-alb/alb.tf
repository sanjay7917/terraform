resource "aws_lb" "myalb" {
  name               = var.alb_name
  internal           = var.internal
  load_balancer_type = var.load_balancer_type
  subnets            = [aws_subnet.pub_sub[0].id, aws_subnet.pub_sub[1].id]
  security_groups    = ["${aws_security_group.sg.id}"]
}
resource "aws_lb_target_group" "mytg" {
  name     = var.target_group_name
  port     = var.alb_tg_port
  protocol = var.target_group_protocol
  vpc_id   = aws_vpc.myvpc.id
  health_check {
    path = "/"
  }
}
resource "aws_lb_listener" "mylistener" {
  load_balancer_arn = aws_lb.myalb.arn
  port              = var.alb_tg_port
  protocol          = var.target_group_protocol

  default_action {
    type             = var.alb_tg_action_type
    target_group_arn = aws_lb_target_group.mytg.arn
  }
}
resource "aws_lb_target_group_attachment" "test" {
  count            = 2
  target_group_arn = aws_lb_target_group.mytg.arn
  target_id        = aws_instance.server[count.index].id
  port             = var.alb_tg_port
}