output "cluster_id" {
  description = "Tied to the internal cluster_id of the AWS EKS module"
  value       = module.amazon_eks.cluster_id
}

output "config_map_aws_auth" {
  description = "The aws-auth ConfigMap"
  value       = module.amazon_eks.config_map_aws_auth
}
