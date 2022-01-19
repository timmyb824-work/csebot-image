variable "awscli_profile" {
    type = string
    description = "AWS CLI profile to use"
}

variable "region" {
    type = string
    description = "AWS region to use"
}

# variable "ami" {
#     type = string
#     description = "AWS AMI to use"
# }

variable "instance_type" {
    type = string
    description = "AWS instance type to use"
}

variable "subnet_id" {
    type = string
    description = "AWS subnet ID to use"
}

variable "key_name" {
    type = string
    description = "AWS key pair to use"
}

variable "sg_name" {
    type = string
    description = "AWS security group name"
}

variable "sg_description" {
    type = string
    description = "AWS security group description"
}

variable "vpc_id" {
    type = string
    description = "AWS VPC ID to use"
}

variable "tags" {
    type = map
    description = "AWS tags to apply to the resources"
    default = {}
}

variable "sg_ingress_rules" {
    type = map
    description = "AWS security group ingress rules"
    default = {}
}

# variable "table_name" {
#     type = string
#     description = "AWS DynamoDB table name"
# }