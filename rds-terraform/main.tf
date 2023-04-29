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
# variable "example" {
#   type = map(string)
#   default = {
#     password = "admin123"
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
#   # version_id = "AWSCURRENT"
# }
resource "aws_db_instance" "this" {
  engine            = "mariadb"
  engine_version    = "10.3"
  instance_class    = "db.t2.micro"
  allocated_storage = 20
  db_name           = "this_db"
  username          = var.rds_username
  password          = var.rds_password
  # password          = "${jsondecode(data.aws_secretsmanager_secret_version.rdbpassword.secret_string)["password"]}"
  # password = lookup(var.example, "password")

  # password = file("password.txt")
  # password          = "${nonsensitive(aws_secretsmanager_secret_version.rdbpassword.secret_string)}"
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
  # user_data     = file("${path.module}/userdata.sh")
  user_data = <<-EOF
  #!/bin/bash
  sudo apt update -y
  sudo apt install mysql-server -y
  sudo systemctl start mysql
  sudo systemctl enable mysql
  MYSQL_USER="admin"
  MYSQL_CONFIG="config.cnf"
  echo "[client]
  user=$MYSQL_USER
  password=Admin123" > $MYSQL_CONFIG
  echo "CREATE DATABASE studentapp;
  show databases;
  use studentapp;
  CREATE TABLE if not exists students(student_id INT NOT NULL AUTO_INCREMENT,
    student_name VARCHAR(100) NOT NULL,
    student_addr VARCHAR(100) NOT NULL,
    student_age VARCHAR(3) NOT NULL,
    student_qual VARCHAR(20) NOT NULL,
    student_percent VARCHAR(10) NOT NULL,
    student_year_passed VARCHAR(10) NOT NULL,
    PRIMARY KEY (student_id)
    );" > /tmp/schema.sql
  mysql --defaults-file=$MYSQL_CONFIG -h ${split(":", aws_db_instance.this.endpoint)[0]} < /tmp/schema.sql

  EOF
  # mysql --defaults-file=$MYSQL_CONFIG -h ${aws_db_instance.this.endpoint} < /tmp/schema.sql
  # rm $MYSQL_CONFIG
  # rm /tmp/schema.sql  
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("${path.module}/id_rsa")
    host        = self.public_ip
  }
  provisioner "file" {
    source      = "sqlscript.sql"
    destination = "/home/ubuntu/sqlscript.sql"
  }

  # provisioner "remote-exec" {
  #   inline = [
  #     "sudo apt update -y",
  #     "sudo apt-get install mysql* -y",
  #     "sudo systemctl start mysql",
  #     "sudo systemctl enable mysql",
  #     "mysql -h ${aws_db_instance.this.endpoint} -u ${aws_db_instance.this.username} -p${split(":", aws_db_instance.this.endpoint)[0]} < sqlscript.sql"
  #     # "mysql -h ${aws_db_instance.this.endpoint} -u ${aws_db_instance.this.username} -p${aws_db_instance.this.endpoint} < sqlscript.sql"
  #   ]
  # }
  # provisioner "remote-exec" {
  # inline = [
  #   "echo ${var.pass} > /tmp/password.txt"
  # ]
  # provisioner "remote-exec" {
  # sensitive = true
  # inline = [
  # "sudo apt-get install mysql* -y",
  # "sudo systemctl start mysql",
  # "sudo systemctl enable mysql",
  #   "sudo apt install awscli -y",
  #   "mysql -h ${aws_db_instance.this.endpoint} -u ${aws_db_instance.this.username} -p${split(":", aws_db_instance.this.endpoint)[0]} < sqlscript.sql"
  # "export DB_PASSWORD=${aws_db_instance.this.password}",
  # "mysql -h ${aws_db_instance.this.endpoint} -u ${aws_db_instance.this.username} -p$DB_PASSWORD < sqlscript.sql"
  # "mysql -h ${aws_db_instance.this.endpoint} -u ${var.db_username} -p${var.db_password} < sqlscript.sql"
  # "mysql -h terraform-20230427164324078000000001.cmomitk2ez52.us-east-2.rds.amazonaws.com -u admin -pinsecurepassword < sqlscript.sql"
  # "mysql -h ${var.rds_end} -u ${var.rds_usr} -p${var.rds_pas} < sqlscript.sql"
  # ]
  # script = "./userdata.sh"
  # }

  # provisioner "local-exec" {
  # connection {
  #   type     = "tcp"
  #   user     = aws_db_instance.this.username
  #   password = aws_db_instance.this.password
  #   host     = aws_db_instance.this.endpoint
  #   port     = 3306
  # }
  #   # when    = "change"
  #   interpreter = ["/bin/bash", "-c"]
  #   # working_dir = "/home/ubuntu"
  #   # on_failure = continue
  #   command = "mysql -h ${aws_db_instance.this.endpoint} -u ${aws_db_instance.this.username} -p${aws_db_instance.this.password} < sqlscript.sql"
  #   # command = "mysql -h terraform-20230427103616215200000001.cmomitk2ez52.us-east-2.rds.amazonaws.com -u admin -ppassword < sqlscript.sql"
  # }
  # provisioner "remote-exec" {
  #   script = "./sqlscript.sql"
  # }

  tags = {
    Name = "tension"
  }
}
# output "name" {
#   sensitive = true
#   # value = nonsensitive(aws_secretsmanager_secret_version.rdbpassword.secret_string)
#   # value = lookup(var.example, "password")
#   # value = aws_db_instance.this.password
#   # value = nonsensitive(aws_db_instance.this.password)
#   value = jsondecode(data.aws_secretsmanager_secret_version.rdbpassword.secret_string)["password"]
# }

output "rds_endpoint" {
  value = "${aws_db_instance.this.endpoint},\n ${split(":", aws_db_instance.this.endpoint)[0]}"
  # value = split(":", aws_db_instance.this.endpoint)[0]
}

# resource "null_resource" "this" {
# connection {
#   type     = "tcp"
#   user     = aws_db_instance.this.username
#   password = aws_db_instance.this.password
#   host     = aws_db_instance.this.endpoint
#   port     = 3306
# }

# provisioner "local-exec" {
#   command = "mysql -h ${aws_db_instance.this.endpoint} -u ${aws_db_instance.this.username} -p${aws_db_instance.this.password} < sqlscript.sql"
# }
# }
# export TF_VAR_username=admin
# export TF_VAR_password=password