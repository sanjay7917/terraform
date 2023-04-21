resource "aws_instance" "server" {
  #ami = "ami-06c4532923d4ba1ec"
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.key.key_name
  vpc_security_group_ids      = ["${aws_security_group.sg.id}"]
  subnet_id                   = aws_subnet.pub_sub1.id
  associate_public_ip_address = true
  user_data                   = file("${path.module}/userdata.sh")
  tags = {
    Name    = "Server"
    Worker  = "employ123@gmail.com"
    Purpose = "Terraform Testing in Work Environment destrry"
    Enddate = "99-09-9999"
  }
}