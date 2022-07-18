variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}
variable "bucket" {
  type = string
  default = "radi-tf-state1"
}

variable "acl" {
  default = "private"
}

variable "table" {
  type = string
    default = "tf-state1"
}