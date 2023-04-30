output "rds_endpoint" {
  value = "WITH PORT NO: ${aws_db_instance.this.endpoint}\nWITHOUT PORT NO: ${split(":", aws_db_instance.this.endpoint)[0]}"
}