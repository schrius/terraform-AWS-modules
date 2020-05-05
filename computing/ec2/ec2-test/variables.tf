terraform {
    required_version = ">= 0.12"
}

provider "aws" {
  region = "us-east-1"
}

variable "policy_name" {
    description = "Policy variable name"
    default = "terraform-policy-test"
    type = string
}