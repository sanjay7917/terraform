data "aws_secretsmanager_secret_version" "secret" {
  secret_id = var.sm_secret_id
}
resource "aws_db_instance" "this" {
  identifier             = var.rds_identifier
  engine            = var.rds_engine
  engine_version    = var.rds_engine_version
  instance_class    = var.rds_instance_class
  storage_type           = var.rds_storage_type  
  allocated_storage = var.rds_allocated_storage  
  db_name           = jsondecode(data.aws_secretsmanager_secret_version.secret.secret_string)["db_name"]
  username             = jsondecode(data.aws_secretsmanager_secret_version.secret.secret_string)["username"]
  password             = jsondecode(data.aws_secretsmanager_secret_version.secret.secret_string)["password"]
  db_subnet_group_name = aws_db_subnet_group.db_subnet.name
  vpc_security_group_ids = [var.vpc_security_group_ids]
  parameter_group_name = var.rds_parameter_group_name
  skip_final_snapshot  = var.rds_skip_final_snapshot
  publicly_accessible  = var.rds_publicly_accessible
}

resource "aws_db_subnet_group" "db_subnet" {
  name       = var.db_subnet_group_name
  subnet_ids = [var.pri_sub_ids[0], var.pri_sub_ids[1]]
  tags       = var.db_subnet_tags
}
# resource "aws_key_pair" "key" {
#   key_name   = "terra"
#   public_key = file("${path.module}/id_rsa.pub")
# }
# resource "aws_instance" "this" {
#   ami           = "ami-06c4532923d4ba1ec"
#   instance_type = "t2.micro"
#   key_name      = aws_key_pair.key.key_name
#   connection {
#     type        = "ssh"
#     user        = "ubuntu"
#     private_key = file("${path.module}/id_rsa")
#     host        = self.public_ip
#   }
#   provisioner "file" {
#     source      = "sqlscript.sql"
#     destination = "/tmp/sqlscript.sql"
#   }
#   provisioner "remote-exec" {
#     inline = [
#       "sudo apt update -y",
#       "sudo apt-get install mysql* -y",
#       "sudo systemctl start mysql",
#       "sudo systemctl enable mysql",
#       "mysql -h ${split(":", aws_db_instance.this.endpoint)[0]} -u ${aws_db_instance.this.username} -p${aws_db_instance.this.password} < /tmp/sqlscript.sql",
#       "rm /tmp/sqlscript.sql"
#     ]
#   }
#   tags = {
#     Name = "RDS_Tension"
#   }
# }

