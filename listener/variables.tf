###########################################3
# listener vars
variable "load_balancer_arn" {
  type = string
}

variable "port" {
  type = string
}

variable "protocol" {
  type = string
}



#########################################
# target_group_vars
variable "target_group_name" {
  type = string
}

variable "vpc_id" {
  type = string
}


