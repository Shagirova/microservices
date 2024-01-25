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
  availability_zone = var.availability_zone

  tags = {
    Name = "Main"
  }
}

module "frontend1" {
  source = "./modules/frontend"
  name = "frontend_1"
  access_key = var.access_key
  security_key = var.security_key
  image           = "ami-0c7217cdde317cfec"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.main.id  
  private_ip    = "10.0.1.5" 
  region = var.region
  vpc_id = aws_vpc.main.id
}

module "backend1" {
  source = "./modules/backend"
  name = "backend_1"
  access_key = var.access_key
  security_key = var.security_key
  image           = "ami-0c7217cdde317cfec"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.main.id  
  private_ip    = "10.0.1.6" 
  region = var.region
  vpc_id = aws_vpc.main.id
}

module "database1" {
  source = "./modules/database"
  name = "database_1"
  access_key = var.access_key
  security_key = var.security_key
  image          = "ami-0c7217cdde317cfec"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.main.id  
  private_ip    = "10.0.1.7"
  database_size = 10
  device_name = "/dev/sdf"
  region = var.region
  availability_zone = var.availability_zone
  vpc_id = aws_vpc.main.id
}