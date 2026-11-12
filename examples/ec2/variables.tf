variable "aws_region" {
  description = "AWS region in which to deploy"
  type        = string
  default     = "eu-west-2"
}

variable "project_name" {
  description = "Short project name used in tags"
  type        = string
  default     = "terraform-notes"
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

