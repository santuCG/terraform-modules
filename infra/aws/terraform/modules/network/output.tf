output "bastion" {
  description = "The details of the bastion host"
  value = module.bastion_host
}  
output "id" {
  value       = module.aws_vpc.id
  description = "The ID of the aws vpc"
}  