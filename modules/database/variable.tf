#### Create Database Variable
variable "allocated_storage" {
    description = "The allocated storage size"
    type = number
  
}

variable "engine" {
    type = string

  
}

variable "engine_version" {
    type = string
  
}
variable "instance_class" {
  type = string
}

variable "multi_az" {
    type = bool
  
}

variable "db_name" {
    type = string

  
}

variable "username" {
  type = string
}

variable "password" {
    description = "Database password"
    type = string
  
}

variable "skip_final_snapshot" {
    type = string
  
}








##variable "rds_instance" {
    ##type = map(any)
   ## default = {
      ##allocated_storage = 10
      #engine = "postgresql"
      #engine_version = "8.0.20"
      #instance_class = "db.t2.micro"
      #multi_az = false
      #name = db
      #skip_final_snapshot = true

    ##}
#}