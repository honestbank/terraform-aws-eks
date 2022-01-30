variable "aws_region" {
  description = "The AWS region to use."
}

variable "eks_desired_capacity" {
  description = "Number of desired nodes"
}

variable "eks_instance_type" {
  description = "EC2 instance type to install K8s on to"
}

variable "eks_max_capacity" {
  description = "Max allowed number of nodes"
}

variable "eks_min_capacity" {
  description = "Minimum allowed number of nodes"
}

variable "eks_worker_node_ebs_volume_size" {
  description = "The EBS volume size used in the Launch Template for worker nodes."
  # A very rare exception of adding a default value. PVCs are generally used rather than actual volumes,
  # so this should have low impact. Needs to be deprecated and removed.
  default = 100
}

variable "eks_worker_node_ebs_volume_type" {
  description = "The EBS volume type used in the Launch Template for worker nodes."
  # A very rare exception of adding a default value. PVCs are generally used rather than actual volumes,
  # so this should have low impact. Needs to be deprecated and removed.
  default = "gp2"
}

variable "enable_irsa" {
  description = "Enable IRSA (IAM Roles for Service Accounts). Enabling this provisions and configures an OIDC (OpenID Connect) provider for in the EKS cluster"
}

variable "kubernetes_version" {
  description = "version of K8s to install in the cluster"
}

variable "map_users" {
  description = "Additional IAM users to add to the aws-auth configmap."
  type = list(object({
    userarn  = string
    username = string
    groups   = list(string)
  }))
  default = []
}

variable "map_roles" {
  description = "Additional IAM roles to add to the aws-auth-configmap."
  type = list(object({
    rolearn  = string
    username = string
    groups   = list(string)
  }))
  default = []
}

variable "name" {
  description = "Name allocated to the EKS cluster"
}

variable "private_subnets" {
  description = "A list of AWS subnet Ids, used to deploy the EKS cluster"
  type        = list(string)
}

variable "vpc_id" {
  description = "AWS id for the VPC to install the EKS cluster in"
}
