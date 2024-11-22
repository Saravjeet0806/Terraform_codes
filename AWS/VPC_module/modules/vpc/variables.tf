variable "vpc_name" {
  type        = string
  description = "Name of the VPC"
}

variable "cidr_block" {
  type        = string
  description = "CIDR block for the VPC"
}

variable "enable_dns" {
  type        = bool
  description = "Enable DNS support and hostnames"
  default     = true
}
