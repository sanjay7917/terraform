output "pub_sub_a_id" {
  value = aws_subnet.public_a.id
}
output "pub_sub_b_id" {
  value = aws_subnet.public_b.id
}
output "security_group_id" {
  value = aws_security_group.sg.id
}