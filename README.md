# myvpn

Terraform spec and ansible scripts to setup an openvpn server and client

## References

Most of the content of the `ansible` folder is copied from [this blog post](https://www.mikejonesey.co.uk/security/2fa/openvpn-with-2fa) with minor changes to make it work on Ubuntu and on new versions.

# How To

1. create a key pair on aws EC2, add the name to `terraform/terraform.tfvars`
2. run `terraform apply`
3. fill `ansible/vars/main.yaml` with your info (public_ip is the ip from the output of step 2)
4. configure your machine to reach the instance from step 2 using the name ovpn-server and add it to your inventory for ansible
5. run the playbook `ansible/master/setup_master.yaml` to setup the CA and generate all keys on your local machine
6. run the playbook `ansible/master/setup_server.yaml` to setup the VPN server
7. run the playbook `ansible/master/gen_client.yaml` to generate the client configuration

# TODO

- [ ] configure the vpn to have all client traffic routed through the VPN server
- [ ] make the aws region an input parameter
- [ ] add optional 2fa
- [ ] integrate terraform and ansible calls
- [ ] use a terraform backend
- [ ] use [terraformize](https://dzone.com/articles/terraformize-applydestory-terraform-modules-via-a) to hook server deploys on Rest API calls
