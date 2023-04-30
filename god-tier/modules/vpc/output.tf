output "vpc_security_group_ids" {
  value = aws_security_group.sg.id
}

output "pri_sub_ids" {
  value = aws_subnet.pri_sub[*].id
}
