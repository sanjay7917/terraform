resource "aws_ebs_volume" "this" {
  count             = 2
  availability_zone = element(var.ebs_availability_zone, count.index)
  size              = var.ebs_volume_size
  # tags = var.ebs_tags
  tags              = merge(var.ebs_tags, { Name = "${var.namespace}-EBS_Volume-${count.index + 1}" })
}
resource "aws_volume_attachment" "this" {
  count       = 2
  device_name = var.ebs_device_name
  volume_id   = aws_ebs_volume.this[count.index].id
  instance_id = aws_instance.server[count.index].id
}