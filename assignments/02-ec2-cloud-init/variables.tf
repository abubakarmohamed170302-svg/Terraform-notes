variable "aws_region" {
  description = "AWS region in which to deploy"
  type        = string
  default     = "eu-west-2"
}

variable "project_name" {
  description = "Project name used for naming and tags"
  type        = string
  default     = "terraform-cloud-init"
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "test", "prod"], var.environment)
    error_message = "Environment must be dev, test or prod."
  }
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "vpc_id" {
  description = "VPC in which to create the security group"
  type        = string
}

variable "subnet_id" {
  description = "Public subnet in which to launch the EC2 instance"
  type        = string
}

variable "key_name" {
  description = "Optional existing EC2 key pair name"
  type        = string
  default     = null
  nullable    = true
}

variable "admin_cidr" {
  description = "Optional trusted IPv4 CIDR for SSH"
  type        = string
  default     = null
  nullable    = true

  validation {
    condition     = var.admin_cidr == null ? true : can(cidrhost(var.admin_cidr, 0))
    error_message = "admin_cidr must be null or a valid IPv4 CIDR."
  }
}

