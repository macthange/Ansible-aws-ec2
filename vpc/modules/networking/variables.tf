
variable "name" {
  type        = string
  default     = "demo"
  description = "Name prefix for eatch resource"

}
variable "owner" {
  type        = string
  default     = "demo"
  description = "The Name/Email ID of owner to resposible for support & billing"
}

variable "enabled" {
  type        = bool
  default     = false
  description = "Name prefix for eatch resource"
}
variable "region_number" {
  # Arbitrary mapping of region name to number to use in
  # a VPC's CIDR prefix.
  default = {
    eu-central-1   = 1
    ap-northeast-1 = 2
    us-east-1      = 3
    us-west-1      = 4
    us-west-2      = 5

  }
}


