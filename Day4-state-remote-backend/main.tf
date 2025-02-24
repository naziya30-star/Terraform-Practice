resource "aws_instance" "name" {
  ami           = "ami-05b10e08d247fb927"
  instance_type = "t2.micro"
  key_name      = "newkey"

  tags = {
    Name = "dev"
  }
}
resource "aws_s3_bucket" "example" {
  bucket = "nazzbucket786"
}