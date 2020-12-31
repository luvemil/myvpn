module "eu-central-1" {
  source = "./modules/multi-region"
  providers = {
    aws = aws
  }

  aws_pub_key = var.aws_pub_key
}

module "us-east-1" {
  source = "./modules/multi-region"
  providers = {
    aws = aws.us-east-1
  }

  aws_pub_key = var.aws_pub_key
}


output "eu-central-1_ip_address" {
  value = module.eu-central-1.instance_ip_addr
}

output "us-east-1_ip_address" {
  value = module.us-east-1.instance_ip_addr
}
