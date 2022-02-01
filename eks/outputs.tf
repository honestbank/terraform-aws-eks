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

output "cluster_primary_security_group_id" {
  description = "The primary cluster Security Group"
  value       = module.amazon_eks.cluster_primary_security_group_id
}

output "cluster_security_group_id" {
  description = "A Security Group attached to the EKS cluster, shown as 'Additional security groups' in the EKS console"
  value       = module.amazon_eks.cluster_security_group_id
}

output "eks_node_ebs_encryption_key_arn" {
  description = "ARN of the auto-created KMS key used to encrypt/decrypt the cluster worker nodes' EBS volumes."
  value       = aws_kms_key.eks_node_ebs_encryption_key.arn
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

output "eks_cluster_worker_node_launch_template_id" {
  description = "The ID of the Launch Template used for the EKS cluster's worker nodes."
  value       = aws_launch_template.default.id
}
