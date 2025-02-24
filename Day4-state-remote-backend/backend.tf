terraform {
  backend "s3" {
     bucket = "nazzbucket786"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}