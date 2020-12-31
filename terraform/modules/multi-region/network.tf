data "aws_vpc" "default" {
  default = true
}

resource "aws_security_group" "allow_base" {
  name        = "allow_base"
  description = "Allow SSH, HTTPS"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "TLS from anywhere"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "OpenVPN UDP port"
    from_port   = 1194
    to_port     = 1194
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "All from VPC"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [data.aws_vpc.default.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "allow_base"
    Project = "myopenvpn"
    Misc    = "terraform"
  }
}

resource "aws_key_pair" "terraform" {
  key_name   = "terraform-key"
  public_key = var.aws_pub_key

  tags = {
    Project = "myopenvpn"
    Misc    = "terraform"
  }
}
