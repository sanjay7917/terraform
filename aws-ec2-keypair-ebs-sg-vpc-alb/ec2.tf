resource "aws_instance" "server" {
  count                  = 2
  ami                    = var.ami
  instance_type          = var.instance_type[0]
  key_name               = aws_key_pair.key.key_name
  vpc_security_group_ids = ["${aws_security_group.sg.id}"]
  subnet_id              = aws_subnet.pub_sub[count.index].id
  # subnet_id              = [aws_subnet.pub_sub[0].id, aws_subnet.pri_sub[0].id]
  # associate_public_ip_address = var.associate_public_ip_address
  user_data = file("${path.module}/userdata.sh")
  tags      = merge(var.instance_tags, { Name = "Server-${count.index + 1}" })
}

output "name" {
  value = file("${path.module}/userdata.sh")
}