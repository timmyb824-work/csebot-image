# use aws provider
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "3.57.0"
    }
  }
  # Required values are passed as command line arguments
  #  backend "s3" {
  #  }
}

#configure the aws provider
provider "aws" {
  profile = var.awscli_profile
  region  = var.region
}

data "aws_ami" "caebot-ami" {
  most_recent      = true
  owners           = ["self"]

  filter {
    name   = "name"
    values = ["csebot-*"]
  }
}

# resource "aws_dynamodb_table" "dynamodb-terraform-state-lock" {
#   name           = var.table_name
#   hash_key       = "LockID"
#   read_capacity  = 20
#   write_capacity = 20
# attribute {
#     name = "LockID"
#     type = "S"
#   }
# tags ={
#     Name = "DynamoDB Terraform State Lock Table"
#   }
# }

# configure the aws instance
resource "aws_instance" "csebot" {
  ami           = data.aws_ami.caebot-ami.id
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.tls-sg.id]
  subnet_id = var.subnet_id
  key_name = var.key_name
  tags = var.tags
}

resource "aws_security_group" "tls-sg" {
  name = var.sg_name
  description = var.sg_description
  vpc_id = var.vpc_id

  dynamic "ingress" {
    for_each = var.sg_ingress_rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
  }
}

  dynamic "ingress" {
    for_each = var.sg_ingress_rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
  }
}

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
   tags = var.tags
}


