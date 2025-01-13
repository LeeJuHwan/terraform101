vpc_name           = "oimarket-apne2"
cidr_block         = "10.0.0.0/16"
availability_zones = ["a", "b"]

public_subnets = {
  "oimarket-apne2-public-subnet-b" = {
    availability_zone = "ap-northeast-2b"
    cidr_block        = "10.0.2.0/24"
  },
  "oimarket-apne2-public-subnet-a" = {
    availability_zone = "ap-northeast-2a"
    cidr_block        = "10.0.1.0/24"
  }

}

private_subnets = {
  "oimarket-apne2-private-subnet-a" = {
    availability_zone = "ap-northeast-2a"
    cidr_block        = "10.0.11.0/24"
  }
  "oimarket-apne2-private-subnet-b" = {
    availability_zone = "ap-northeast-2b"
    cidr_block        = "10.0.12.0/24"
  },
}
