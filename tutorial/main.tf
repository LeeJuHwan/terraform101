terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.54.1"
    }
  }
}
resource "aws_vpc" "main" {
  cidr_block = var.cidr_block

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.vpc_name}-igw"
  }
}


resource "aws_subnet" "public" {
  vpc_id = aws_vpc.main.id
  count = length(var.availability_zones)
  cidr_block = cidrsubnet(var.cidr_block, 8, count.index + 1)
  availability_zone = "ap-northeast-2${var.availability_zones[count.index]}"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.vpc_name}-public-subnet-${var.availability_zones[count.index]}"
  }
}