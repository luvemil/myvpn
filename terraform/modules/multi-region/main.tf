module "openvpn-server" {
  source = "../single-vpn-server"

  aws_key_name        = aws_key_pair.terraform.key_name
  security_group_name = aws_security_group.allow_base.name
}

output "instance_ip_addr" {
  value = module.openvpn-server.instance_ip_addr
}

