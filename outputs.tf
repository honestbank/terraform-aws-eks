output "cluster_id" {
  description = "Tied to the internal cluster_id of the AWS EKS module"
  value       = module.eks.cluster_id
}

output "config_map_aws_auth" {
  description = "The aws-auth ConfigMap"
  value       = module.eks.config_map_aws_auth
}
