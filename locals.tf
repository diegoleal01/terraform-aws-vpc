locals {
  tags = merge(
    var.tags,
    {
      ManagedBy = "Terraform"
    }
  )
}
