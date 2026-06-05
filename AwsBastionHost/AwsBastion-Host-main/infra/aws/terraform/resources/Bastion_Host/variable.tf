variable "security_group_name" {
  description = "Name of the Security Group."
  type        = string
  default     = "securitytesting"
}
variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
  default     = ""
}
variable "key_name" {
  description = "The key name of the Key Pair to use for the instance."
  type        = string
  default     = ""
}
variable "ami" {
  type        = string
  description = " AMI to use for the instance. Required unless launch_template is specified and the Launch Template specifes an AMI. If an AMI is specified in the Launch Template, setting ami will override the AMI specified in the Launch Template."
  default     = ""
}
variable "instance_type" {
  description = "The type of instance to start."
  type        = string
  default     = ""
}
variable "disk_size" {
  description = "The size of the root volume in gigabytes."
  type        = number
  default     = 10
}
variable "associate_public_ip_address" {
  type        = bool
  description = "Whether to associate a public IP address with an instance in a VPC."
  default     = true
}
variable "delete_on_termination" {
  type        = bool
  description = "Whether the volume should be destroyed on instance termination. Defaults to true."
  default     = true
}
variable "tags" {
  description = "Name of the internet gateway"
  type        = map(string)
}
