resource "aws_instance" "name" {
  ami           = "ami-05b10e08d247fb927"
  instance_type = "t2.micro"
  key_name      = "newkey"
  availability_zone = "us-east-1"
  tags = {
    Name = "dev"
  }
}

