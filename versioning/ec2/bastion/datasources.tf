data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket = "oimarket-terraform-study-remote-state"
    key    = "vpc/oimarket-apne2/terraform.tfstate"
    region = "ap-northeast-2"
  }
}
