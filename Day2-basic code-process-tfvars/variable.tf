variable "ami_id" {
  description = "The AMI ID to use for the instance"
  type        = string
  default     = "ami-05b10e08d247fb927"
}

variable "instance_type" {  # Renamed from 'type' to 'instance_type' for clarity
  description = "The type of instance to launch"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {  # Renamed from 'key' to 'key_name' for clarity
  description = "The name of the SSH key pair to use"
  type        = string
  default     = "newkey"
}
