variable "image_id" {
    type = string
  }
   variable "instance_type" {
    type = string
  }
   variable "subnet_id" {
    type = string
  }
   variable "isPublic" {
    type = bool
  }
   variable "security_group_id" {
    type = string
  }

  variable "isProxy" {
    type = bool
  }

  variable "proxy_traffic_target" {
    type = string
  }