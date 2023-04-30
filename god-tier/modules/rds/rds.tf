data "aws_secretsmanager_secret_version" "secret" {
  secret_id = "valak_oo"
}
resource "aws_db_instance" "this" {
  engine            = "mariadb"
  engine_version    = "10.3"
  instance_class    = "db.t2.micro"
  allocated_storage = 20
  db_name           = "this_db"
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

