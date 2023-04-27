provider "aws" {
  region  = "us-east-2"
  profile = "default"
}
resource "aws_db_instance" "this" {
  engine               = "mariadb"
  engine_version       = "10.3"
  instance_class       = "db.t2.micro"
  allocated_storage    = 20
  db_name              = "this_db"
  username             = "admin"
  password             = "password"
  parameter_group_name = "default.mariadb10.3"
  skip_final_snapshot  = true
  publicly_accessible  = false
  # provisioner "local-exec" {
  #   command = "mysql -h ${aws_db_instance.this.endpoint} -P 3306 -u ${aws_db_instance.this.username} -p${aws_db_instance.this.password} -e 'CREATE DATABASE stud'"
  # }
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
  provisioner "remote-exec" {
    # inline = [
    #   "sudo apt-get install mysql* -y",
    #   "sudo systemctl start mysql",
    #   "mysql -h ${aws_db_instance.this.endpoint} -u ${aws_db_instance.this.username} -p${aws_db_instance.this.password} < sqlscript.sql"
    # ]
    script = "./userdata.sh"
  }
  # provisioner "local-exec" {
  #   connection {
  #     type     = "tcp"
  #     user     = aws_db_instance.this.username
  #     password = aws_db_instance.this.password
  #     host     = aws_db_instance.this.endpoint
  #     port     = 3306
  #   }
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

  # provisioner "remote-exec" {
  #   inline = [
  #     "sudo apt-get install mysql* -y",
  #     "sudo systemctl start mysql",
  #     "sudo systemctl status mysql",
  #     "mysql -h ${aws_db_instance.this.endpoint} -u ${aws_db_instance.this.username} -p${aws_db_instance.this.password} < sqlscript.sql"
  #   ]
  # }
  tags = {
    Name = "iae"
  }
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
