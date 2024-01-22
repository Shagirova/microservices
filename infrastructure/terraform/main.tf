resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "main"
  }
}

resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "Main"
  }
}

module "frontend" {
  source = "./modules/frontend"
  name = "frontend"
  access_key = var.access_key
  security_key = var.security_key
  image           = "ami-0c7217cdde317cfec"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.main.id  
  private_ip    = "10.0.1.1" 
  region = var.region
}

module "backend" {
  source = "./modules/backend"
  name = "backend"
  access_key = var.access_key
  security_key = var.security_key
  image           = "ami-0c7217cdde317cfec"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.main.id  
  private_ip    = "10.0.1.2" 
  region = var.region
}

module "database" {
  source = "./modules/database"
  name = "database"
  access_key = var.access_key
  security_key = var.security_key
  image          = "ami-0c7217cdde317cfec"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.main.id  
  private_ip    = "10.0.1.3"
  database_size = 10
  device_name = "/dev/sdf"
  region = var.region
  availability_zone = var.availability_zone
}

resource "aws_ebs_volume" "volume" {
  availability_zone = var.region
  size              = 10
}