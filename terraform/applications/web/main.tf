module "ec2" {
  source = "../../modules/ec2"
  ami           = var.ec2_ami
  instance_type = var.ec2_instance_type
  key_name      = var.ec2_key_name
  volume_size   = var.ec2_volume_size
}