output "cluster_id" {
  description = "Tied to the internal cluster_id of the AWS EKS module"
  value       = module.amazon_eks.cluster_id
}
