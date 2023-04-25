resource "aws_security_group" "sg" {
  name        = var.aws_sg_name
  description = var.aws_sg_description
  vpc_id      = aws_vpc.myvpc.id
  dynamic "ingress" {
    for_each = var.sg_ports
    iterator = port
    content {
      description = var.sg_ingress_description
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}