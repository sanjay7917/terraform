provider "aws" {
  region  = "us-east-2"
  profile = "default"
}
resource "aws_key_pair" "key" {
  key_name   = "terra"
  public_key = file("${path.module}/id_rsa.pub")
}
resource "aws_instance" "this" {
  ami           = "ami-06c4532923d4ba1ec"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.key.key_name
  user_data     = file("${path.module}/userdata.sh")
  # user_data     = "${file("${path.module}/userdata.sh)")}\n${file("${path.module}/sqlscript.sql")}"
  # provisioner "remote-exec" {
  #   script = "./sqlscript.sql"
  # }
  tags = {
    Name = "iae"
  }
}
resource "aws_db_instance" "example" {
  engine               = "mariadb"
  engine_version       = "10.3"
  instance_class       = "db.t2.micro"
  allocated_storage    = 20
  db_name              = "example_db"
  username             = "admin"
  password             = "password"
  parameter_group_name = "default.mariadb10.3"
  publicly_accessible  = false
}
resource "null_resource" "example" {
  connection {
    type     = "tcp"
    user     = aws_db_instance.example.username
    password = aws_db_instance.example.password
    host     = aws_db_instance.example.endpoint
    port     = 3306
  }

  # provisioner "local-exec" {
  #   command = "mysql -h ${aws_db_instance.example.endpoint} -u ${aws_db_instance.example.username} -p${aws_db_instance.example.password} < sqlscript.sql"
  # }
}
