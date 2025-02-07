provider "aws" {
  region = "ap-northeast-2"
}

variable "account_id" {
  default = "jhlee-ninja"
}

resource "aws_s3_bucket" "tfstate" {
  bucket = "${var.account_id}-apne2-remote-state"

  tags = {
    Name        = "${var.account_id}-apne2-remote-state"
    Environment = ""
  }
}


resource "aws_dynamodb_table" "terraform_state_lock" {
  name         = "${var.account_id}-apne2-remote-state-lock"
  hash_key     = "LockID"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "LockID"
    type = "S"
  }
}
