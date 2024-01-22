variable "name" {
  type = string  
}

variable "access_key" {
    type = string
}

variable "security_key" {
    type = string
}

variable "region" {
  type = string
}

variable "availability_zone" {
  type = string
}

variable "subnet_id" {
  type = string  
}

variable "private_ip" {
  type = string  
}

variable "instance_type" {
  type = string  
}

variable "image" {
  type = string  
}

variable "database_size" {
  type = number 
}

variable "device_name" {
  type = string
  default = "/dev/sdf"
  
}