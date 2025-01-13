variable "cidr_block" {
  description = "The cidr block of vpc"
}

variable "vpc_name" {
  description = "The name of vpc"
}

variable "availability_zones" {
  type        = list(string)
  description = "az of subnets"
}

variable "subnets" {
  type = map(object({
    availability_zone  = string
    cidr_block         = string
    nat_gateway_subnet = optional(string)
  }))
}
