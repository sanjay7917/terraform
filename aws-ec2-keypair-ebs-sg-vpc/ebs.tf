resource "aws_ebs_volume" "this" {
  availability_zone = "us-east-2a"
  size              = 10
  tags = {
    Name = "EBS VOL"
  }
}
resource "aws_volume_attachment" "this" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.this.id
  instance_id = aws_instance.server.id
}