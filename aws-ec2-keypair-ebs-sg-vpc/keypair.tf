resource "aws_key_pair" "key" {
  key_name   = "terra"
  public_key = file("${path.module}/id_rsa.pub")

}