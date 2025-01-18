resource "aws_instance" "bastion" {
  ami           = "ami-0a998385ed9f45655"
  instance_type = "t3.micro"
  subnet_id     = data.terraform_remote_state.vpc.outputs.subnets["oimarket-apne2-public-subnet-a"].id
  vpc_security_group_ids = [
    data.terraform_remote_state.vpc.outputs.security_groups["oimarket-apne2-permit-ssh-security-group"].id
  ]

  tags = {
    Name = "oimarket-apne2-bastion"
  }
}
