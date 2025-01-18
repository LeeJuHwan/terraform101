terraform {
  backend "s3" {
    bucket         = "oimarket-terraform-study-remote-state"
    key            = "ec2/bastion/terraform.tfstate"
    region         = "ap-northeast-2"
    dynamodb_table = "oimarket-terraform-study-remote-state-lock"
  }
}
