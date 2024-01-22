resource "aws_security_group" "backend_sg" {
  name        = "${var.name}-security-group"
  description = "Backend Security Group for SSH, DNS, HTTP, and HTTPS"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "For SSH connections to the server"
  }

  egress {
    from_port   = 53
    to_port     = 53
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "For DNS requests from the server"
  }

  egress {
    from_port   = 53
    to_port     = 53
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "For DNS requests from the server"
  }

  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "For HTTP requests from the server"
  }

  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "For HTTP requests from the server"
  }

  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "For HTTPS requests from the server"
  }

  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "For HTTPS requests from the server"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["10.0.1.1/32"]
    description = "For HTTP requests to the server from frontend"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "udp"
    cidr_blocks = ["10.0.1.1/32"]
    description = "For HTTP requests to the server from frontend"
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["10.0.1.1/32"]
    description = "For HTTPS requests to the server from frontend"
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "udp"
    cidr_blocks = ["10.0.1.1/32"]
    description = "For HTTPS requests to the server from frontend"
  }

  egress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["10.0.1.3/32"]
    description = "For requests to the database from the server"
  }
}

resource "aws_instance" "backend" {
  key_name = var.name
  ami           = var.image  
  instance_type = var.instance_type
  subnet_id     = var.subnet_id  
  private_ip    = var.private_ip
  vpc_security_group_ids = [aws_security_group.backend_sg.id]
}