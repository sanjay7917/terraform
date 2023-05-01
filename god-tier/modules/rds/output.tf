output "rds_endpoint" {
  value = split(":", aws_db_instance.this.endpoint)[0]
}