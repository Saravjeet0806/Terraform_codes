terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

variable "region" {
  description = "The AWS region to deploy resources in"
  type        = string
}

variable "profile" {
  description = "The AWS CLI profile to use"
  type        = string
}

variable "table_name" {
  description = "The name of the DynamoDB table"
  type        = string
}

variable "table_billing_mode" {
  description = "The billing mode for the DynamoDB table"
  type        = string
}

variable "environment" {
  description = "The environment tag for the resources"
  type        = string
}


provider "aws" {
  alias   = "user"
  region  = var.region
  profile = var.profile
}

resource "aws_dynamodb_table" "my_first_table" {
  name         = var.table_name
  billing_mode = var.table_billing_mode
  hash_key     = "employee-id"

  attribute {
    name = "employee-id"
    type = "S"
  }

  tags = {
    environment = var.environment
  }
}
