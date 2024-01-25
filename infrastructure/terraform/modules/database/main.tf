resource "aws_security_group" "database_sg" {
  name        = "${var.name}-security-group"
  description = "Database Security Group for SSH, DNS, HTTP, and HTTPS"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
    description = "SSH connections to the server"
  }

  egress {
    from_port   = 53
    to_port     = 53
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
    description = "DNS requests from the server"
  }

  egress {
    from_port   = 53
    to_port     = 53
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
    description = "DNS requests from the server"
  }

  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
    description = "HTTP requests from the server"
  }

  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
    description = "HTTP requests from the server"
  }

  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
    description = "HTTPS requests from the server"
  }

  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
    description = "HTTPS requests from the server"
  }

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["10.0.1.2/32"]
    description = "Requests to the server from backend"
  }
}

resource "aws_instance" "database" {
  ami           = var.image  
  instance_type = var.instance_type
  subnet_id     = var.subnet_id  
  private_ip    = var.private_ip
  vpc_security_group_ids = [aws_security_group.database_sg.id]
  availability_zone = var.availability_zone
}

resource "aws_volume_attachment" "database_volume_attach" {
  device_name = "/dev/sdf"
  instance_id = aws_instance.database.id
  volume_id   = aws_ebs_volume.database_volume.id
}

resource "aws_ebs_volume" "database_volume" {
  availability_zone = var.availability_zone
  size              = var.database_size
}