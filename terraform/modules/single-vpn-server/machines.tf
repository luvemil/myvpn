# Source: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "openvpn" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  tags = {
    Name    = "myopenvpn-server-1"
    Project = "myopenvpn"
    Misc    = "terraform"
  }
  key_name        = var.aws_key_name
  security_groups = [var.security_group_name]
}

output "instance_ip_addr" {
  value = aws_instance.openvpn.public_ip
}
