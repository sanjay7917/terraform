resource "aws_key_pair" "key" {
  key_name = "terra"
  #   public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC7E74lLqFYG7tvIBzCanLsvRh59DbDA0o+X0bOVFH3G6N1lJWyeLkRm4HB/IHhAXkcZZIWqMpFA8Wl1DXSVY78UVgpD9rB43FqHNCJtkBcT+wAe+ypsQ6eYGVgMLgke7n3vupCD1Rq//LWgKt3eTPWWQCe/MR+fyDBN8lbXfNr3/VLIPPNH0rbLizFTsytV7s3Fg46jIJaIvb65AjGfLDdj4ob8MX3bHKj/b+KwMFXVpD2/w65l8MKMde0qAEVn82GrVgeaKJHUFPhCMmX3t+JjhZDyDnFEnU1aqQY6E8itf5SEzGTNFjFrwzpODWDizmU8nim/5pc+yJMg0ujA3Z7w5ke+U61KJygYqyfqV0T5MTqk6LrB73g0TLVSS6aBJ/ZCMGCiHC6NkrfaTzAiDGU0cuinRR5p2WY4gCy1EOER1on1yna3dFBUq+XsGtAp6GQXdS+tKXzynwPAeiPQi3vJrUZlNwGIcSNCN6qUxbg+Tg49OTdcJ/JpCnZDFDmBes= killu@Sanjus-MacBook-Air.local"
  public_key = file("${path.module}/id_rsa.pub")

}
resource "aws_security_group" "sg" {
  name        = "sg"
  description = "test sg"
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
resource "aws_instance" "server" {
  ami                    = "ami-06c4532923d4ba1ec"
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.key.key_name
  vpc_security_group_ids = ["${aws_security_group.sg.id}"]
  tags = {
    Name = "aws-ec2-keypair-sgt"
  }
}