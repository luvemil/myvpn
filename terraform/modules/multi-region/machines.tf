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
  count         = var.server_count
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  tags = {
    Name    = "myopenvpn-server-${count.index}"
    Project = "myopenvpn"
    Misc    = "terraform"
  }
  key_name        = aws_key_pair.terraform.key_name
  security_groups = [aws_security_group.allow_base.name]
}

output "instance_ip_addr" {
  value = [aws_instance.openvpn.*.public_ip]
}
