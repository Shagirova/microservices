variable "region" {
  type = string
  default = "us-east-1"
}

variable "access_key" {
    type = string
    sensitive = true
}

variable "security_key" {
    type = string
    sensitive = true
}

variable availability_zone {
  type = string
  default = "us-east-1a"
}