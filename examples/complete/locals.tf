locals {
  tags = {
    Name        = var.name
    Cost_Center = "example"
    Project = "example"
  }
    region = data.aws_region.current.name
    partition = data.aws_partition.current.partition


    dns_suffix = data.aws_partition.current.dns_suffix
  account_id = data.aws_caller_identity.current.account_id
}