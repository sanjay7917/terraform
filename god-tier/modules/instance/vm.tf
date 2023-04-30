resource "aws_instance" "name" {
  ami                    = var.img
  instance_type          = var.vm_size[0]
}