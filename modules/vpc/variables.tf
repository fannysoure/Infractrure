# Count variables
variable "items_count" {
    description = "default count used to set AZs and instances"
    type = number
    default = 3
}

# VPC variables
variable "vpc_cidr" {
    description = "default vpc cidr block"
    type = string
    default = "10.0.0.0/16"
  
}

### AZs variables

variable "availability_zone_names" {
    type = list(string)
    default = [ "us-west-1a", "us-west-1b", "us-west-1c" ]
  
}

## Variable Public Subnet

variable "public_subnet_cidr" {
    type = list(string)
    default = [ "10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24" ]
  
}

##Variable Private subnet

variable "private_subnet_cidr" {
    type = list(string)
    default = [ "10.0.21.0/24", "10.0.22.0/24", "10.0.23.0/24" ]
  
}

#### Instance variables

variable "ami_id" {
  type = string
  default = "ami_add_ami_type"
}

variable "instance_type"{
    type = string
    default = "t2.micro"

}

variable "enable_nat_gateway" {
  description = "Should be true if you want to provision NAT Gateways for each of your private networks"
  type        = bool
  default     = true
}

variable "single_nat_gateway" {
  description = "Should be true if you want to provision a single shared NAT Gateway across all of your private networks"
  type        = bool
  default     = false
}

variable "one_nat_gateway_per_az" {
  description = "Should be true if you want only one NAT Gateway per availability zone."
  type        = bool
  default     = true
}




## Create database sensitive variable
variable "user_information" {
    type =  map(any)
    default = {
      username = "user"
      password = "passwd"

    }
    sensitive = true
  
}