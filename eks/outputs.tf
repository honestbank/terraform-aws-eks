output "certificate_authority_data" {
  description = "CA data used to connect to the cluster. Outputted to allow the Kubernetes provider to install the aws_auth config map (allow allocated users to access)"
  value       = data.aws_eks_cluster.eks-cluster.certificate_authority.0.data
}

output "cluster_id" {
  description = "Tied to the internal cluster_id of the AWS EKS module"
  value       = module.amazon_eks.cluster_id
}

output "cluster_oidc_issuer_url" {
  description = "The URL on the EKS cluster OIDC Issuer"
  value       = module.amazon_eks.cluster_oidc_issuer_url
}

output "eks-cluster-endpoint" {
  description = "The URI of the cluster endpoint, used for Admin tasks, i.e Kubectl"
  value       = data.aws_eks_cluster.eks-cluster.endpoint
}

output "eks-cluster-token" {
  description = "Token to access the EKS cluster"
  value       = data.aws_eks_cluster_auth.eks-cluster.token
  sensitive   = true
}

output "oidc_provider_arn" {
  description = "The ARN of the OIDC Provider if `enable_irsa = true`"
  value       = module.amazon_eks.oidc_provider_arn
}
