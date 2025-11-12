# Get Default VPC
#data "aws_vpc" "default" {
#  default = true
#}

# Get default Subnet ids
#data "aws_subnets" "public" {
#  filter {
#    name   = "vpc-id"
#    values = [data.aws_vpc.default.id]
#  }
#}

###########################################
# Get Default VPC
###########################################
data "aws_vpc" "default" {
  default = true
}

###########################################
# Get Default Subnets — filter only supported AZs for EKS
###########################################
data "aws_subnets" "public" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }

  # EKS supports only these zones in us-east-1
  filter {
    name   = "availability-zone"
    values = ["us-east-1a", "us-east-1b", "us-east-1c"]
  }
}

###########################################
# Output for debugging / reference
###########################################
output "vpc_id" {
  value = data.aws_vpc.default.id
}

output "public_subnet_ids" {
  value = data.aws_subnets.public.ids
}
