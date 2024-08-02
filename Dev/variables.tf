variable "aws_region" {
  description = "AWS region to deploy resources"
  type = string
  default = "us-west-2"
  
}

variable "instance_type" {
  description = "Type of EC2 instance for dev"
  type        = string
  default     = "t2.small"
}

variable "subnet_id" {
  description = "List of subnet IDs for dev"
  type        = list(string)
  
}

variable "desired_capacity" {
  description = "Desired capacity for autoscaling group"
  type = number
  default = 1
  
}
# Define other dev-specific variables as needed
