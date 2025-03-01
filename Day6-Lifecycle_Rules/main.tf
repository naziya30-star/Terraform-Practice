resource "aws_instance" "import" {
  ami = "ami-05b10e08d247fb927"
  instance_type = "t2.micro"
  key_name = "newkey"
  tags = {
    Name = "EC2"
  }

lifecycle {
    ignore_changes = [tags,]
}
}