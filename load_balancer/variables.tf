variable "lb_name" {
  type = string
  default = "new_lb"
}
  
variable "external_lb_subnets" {
  type = list
}

variable "external_lb_security_groups" {
  type = list
}

variable "isInternal" {
  type = bool
}
variable "load_balancer_type" {
  type = string
}
