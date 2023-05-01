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