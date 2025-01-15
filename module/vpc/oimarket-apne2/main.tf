module "vpc" {
  source = "../../modules/vpc"

  vpc_name           = "oimarket-apne2"
  cidr_block         = "10.0.0.0/16"
  availability_zones = ["a", "b"]

  subnets = {
    "oimarket-apne2-public-subnet-a" = {
      availability_zone = "ap-northeast-2a"
      cidr_block        = "10.0.1.0/24"
    },
    "oimarket-apne2-public-subnet-b" = {
      availability_zone = "ap-northeast-2b"
      cidr_block        = "10.0.2.0/24"
    },
    "oimarket-apne2-private-subnet-a" = {
      availability_zone  = "ap-northeast-2a"
      cidr_block         = "10.0.11.0/24"
      nat_gateway_subnet = "oimarket-apne2-public-subnet-a"
    }
    "oimarket-apne2-private-subnet-b" = {
      availability_zone  = "ap-northeast-2b"
      cidr_block         = "10.0.12.0/24"
      nat_gateway_subnet = "oimarket-apne2-public-subnet-b"
    },
  }

  security_groups = {
    "oimarket-apne2-permit-ssh-security-group" = {
      ingress_rules = [
        {
          cidr_blocks = ["0.0.0.0/0"]
          from_port   = 22
          protocol    = "tcp"
          to_port     = 22
        }
      ]

      egress_rules = [{
        cidr_blocks = ["0.0.0.0/0"]
        from_port   = 0
        protocol    = "-1"
        to_port     = 0
      }]
    },

    "oimarket-apne2-permit-http-security-group" = {
      ingress_rules = [
        {
          cidr_blocks = ["0.0.0.0/0"]
          from_port   = 80
          protocol    = "tcp"
          to_port     = 80
        },
        {
          cidr_blocks = ["0.0.0.0/0"]
          from_port   = 443
          protocol    = "tcp"
          to_port     = 443
        }
      ]

      egress_rules = [{
        cidr_blocks = ["0.0.0.0/0"]
        from_port   = 0
        protocol    = "-1"
        to_port     = 0
      }]
    }
  }

}