output "certificate_authority_data" {
  description = "CA data used to connect to the cluster. Outputted to allow the Kubernetes provider to install the aws_auth config map (allow allocated users to access)"
  value       = module.eks.certificate_authority_data
}

output "cluster_id" {
  description = "Tied to the internal cluster_id of the AWS EKS module"
  value       = module.eks.cluster_id
}

output "cluster_oidc_issuer_url" {
  description = "The URL on the EKS cluster OIDC Issuer"
  value       = module.eks.cluster_oidc_issuer_url
}

output "cluster_primary_security_group_id" {
  description = "The primary cluster Security Group"
  value       = module.eks.cluster_primary_security_group_id
}

output "eks-cluster-endpoint" {
  description = "The URI of the cluster endpoint, used for Admin tasks, i.e Kubectl"
  value       = module.eks.eks-cluster-endpoint
}

output "eks-cluster-token" {
  description = "Token to access the EKS cluster"
  value       = module.eks.eks-cluster-token
  sensitive   = true
}

output "oidc_provider_arn" {
  description = "The ARN of the OIDC Provider if `enable_irsa = true`"
  value       = module.eks.oidc_provider_arn
}
