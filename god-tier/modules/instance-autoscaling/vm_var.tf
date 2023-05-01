variable "key_name" {
  type = string
}
variable "image_type" {
  type = string
}
variable "template_tags" {
  type = map(any)
}
variable "vpc_security_group_ids" {
    type = string
}
variable "pub_sub_ids" {
  type = list(string)
}
variable "pri_sub_ids" {
  type = list(string)
}
variable "rds_endpoint" {
  type = string
}
# variable "rds_db_name" {
#   type = string
# }
variable "rds_username" {
  type = string
}
variable "rds_password" {
  type = string
}