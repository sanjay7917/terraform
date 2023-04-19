resource "aws_instance" "server" {
  ami                         = "ami-06c4532923d4ba1ec"
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.key.key_name
  vpc_security_group_ids      = ["${aws_security_group.sg.id}"]
  subnet_id                   = aws_subnet.pub_sub.id
  associate_public_ip_address = true
  tags = {
    Name = "aws-ec2-keypair-sgt"
  }
}