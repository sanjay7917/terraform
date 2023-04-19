resource "aws_security_group" "sg" {
  name        = "sg"
  description = "test sg"
  vpc_id      = aws_vpc.myvpc.id
  dynamic "ingress" {
    for_each = [22, 80]
    iterator = port
    content {
      description = "SSH from VPC"
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