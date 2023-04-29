provider "aws" {
  region  = "us-east-2"
  profile = "default"
}
terraform {
  backend "s3" {
    bucket = "mytfstatefile112233"
    region = "us-east-2"
    key    = "terraform.tfstate"
  }
}
#We Can USE Terraform to Create Secret Manager and Store value.
#But if we do that our username and password will be displyed in our CODE.
#So its better if create Secret Manager through AWS Console and store our username and password.
#Then we can just Retrive Secret Manager's value using data resource.
#We can use Secret's ARN or Secret's Name to retrive value from Secret Manager. The secret must already exist.
# variable "example" {
#   type = map(string)
#   default = {
#     username = "admin"
#     password = "Admin123"
#   }
# }
# resource "aws_secretsmanager_secret" "rdbpassword" {
#   name = "hidden_info"
#   recovery_window_in_days = 0
# }

# resource "aws_secretsmanager_secret_version" "rdbpassword" {
#   secret_id     = aws_secretsmanager_secret.rdbpassword.id
#   secret_string = jsonencode(var.example)
# }
# data "aws_secretsmanager_secret_version" "rdbpassword" {
#   secret_id = aws_secretsmanager_secret.rdbpassword.id
# }
data "aws_secretsmanager_secret_version" "secret" {
  secret_id = "one_piece"
}
resource "aws_db_instance" "this" {
  engine            = "mariadb"
  engine_version    = "10.3"
  instance_class    = "db.t2.micro"
  allocated_storage = 20
  db_name           = "this_db"
  # username          = var.rds_username
  # password          = var.rds_password
  username             = jsondecode(data.aws_secretsmanager_secret_version.secret.secret_string)["username"]
  password             = jsondecode(data.aws_secretsmanager_secret_version.secret.secret_string)["password"]
  parameter_group_name = "default.mariadb10.3"
  skip_final_snapshot  = true
  publicly_accessible  = false
}

resource "aws_key_pair" "key" {
  key_name   = "terra"
  public_key = file("${path.module}/id_rsa.pub")
}
resource "aws_instance" "this" {
  ami           = "ami-06c4532923d4ba1ec"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.key.key_name
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("${path.module}/id_rsa")
    host        = self.public_ip
  }
  provisioner "file" {
    source      = "sqlscript.sql"
    destination = "/tmp/sqlscript.sql"
  }
  #---------------------HEY ONE---------------------
  # user_data = <<-EOF
  # #!/bin/bash
  # sudo apt update -y
  # sudo apt install mysql-server -y
  # sudo systemctl start mysql
  # sudo systemctl enable mysql
  # MYSQL_USER="admin"
  # MYSQL_CONFIG="config.cnf"
  # echo "[client]
  # user=$MYSQL_USER
  # password=Admin123" > $MYSQL_CONFIG
  # echo "CREATE DATABASE studentapp;
  # show databases;
  # use studentapp;
  # CREATE TABLE if not exists students(student_id INT NOT NULL AUTO_INCREMENT,
  #   student_name VARCHAR(100) NOT NULL,
  #   student_addr VARCHAR(100) NOT NULL,
  #   student_age VARCHAR(3) NOT NULL,
  #   student_qual VARCHAR(20) NOT NULL,
  #   student_percent VARCHAR(10) NOT NULL,
  #   student_year_passed VARCHAR(10) NOT NULL,
  #   PRIMARY KEY (student_id)
  #   );" > /tmp/schema.sql
  # mysql --defaults-file=$MYSQL_CONFIG -h ${split(":", aws_db_instance.this.endpoint)[0]} < /tmp/schema.sql
  # rm $MYSQL_CONFIG
  # rm /tmp/schema.sql  
  # EOF
  #---------------------WAY TWO---------------------
  # user_data = <<-EOF
  # #!/bin/bash
  # sudo apt update -y
  # sudo apt install mysql-server -y
  # sudo systemctl start mysql
  # sudo systemctl enable mysql
  # MYSQL_CONFIG="config.cnf"
  # echo "[client]
  # user=${var.rds_username}
  # password=${var.rds_password}" > $MYSQL_CONFIG
  # mysql --defaults-file=$MYSQL_CONFIG -h ${split(":", aws_db_instance.this.endpoint)[0]} < /tmp/sqlscript.sql
  # rm /tmp/sqlscript.sql
  # EOF
  #---------------------WAY THREE---------------------
  # provisioner "remote-exec" {
  #   inline = [
  #     "sudo apt update -y",
  #     "sudo apt-get install mysql* -y",
  #     "sudo systemctl start mysql",
  #     "sudo systemctl enable mysql",
  #     "mysql -h ${split(":", aws_db_instance.this.endpoint)[0]} -u ${var.rds_username} -p${var.rds_password} < /tmp/sqlscript.sql"
  #   ]
  # }
  #---------------------WAY FOUR(BEST WAY)---------------------
  provisioner "remote-exec" {
    inline = [
      "sudo apt update -y",
      "sudo apt-get install mysql* -y",
      "sudo systemctl start mysql",
      "sudo systemctl enable mysql",
      "mysql -h ${split(":", aws_db_instance.this.endpoint)[0]} -u ${aws_db_instance.this.username} -p${aws_db_instance.this.password} < /tmp/sqlscript.sql",
      "rm /tmp/sqlscript.sql"
    ]
  }
  tags = {
    Name = "RDS_Tension"
  }
}
output "rds_endpoint" {
  value = "WITH PORT NO: ${aws_db_instance.this.endpoint}\nWITHOUT PORT NO: ${split(":", aws_db_instance.this.endpoint)[0]}"
}
