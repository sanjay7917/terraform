resource "aws_key_pair" "key" {
  key_name   = "terra"
  public_key = file("${path.module}/id_rsa.pub")
}
# resource "tls_private_key" "this" {
#   algorithm = "RSA"
#   rsa_bits  = 4096
# }
# resource "aws_key_pair" "this" {
#   key_name   = "terra"
#   public_key = tls_private_key.this.public_key_openssh
# }