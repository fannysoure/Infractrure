variable "instance_type" {
  description = "Type of EC2 instance for dev"
  type        = string
  default     = "t2.small"
}

variable "subnet_ids" {
  description = "List of subnet IDs for dev"
  type        = list(string)
  default     = ["subnet-12345678", "subnet-87654321"]
}

# Define other dev-specific variables as needed
