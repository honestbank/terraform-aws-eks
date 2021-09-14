variable "aws_vpc_name" {
  description = "The name of the AWS VPC to install the EKS cluster into"
}

variable "aws_region" {
  description = "AWS region to install the EKS cluster into"
}

variable "cluster_name" {
  description = "The name of the EKS cluster"
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

variable "enable_irsa" {
  description = "Enable IRSA (IAM Roles for Service Accounts). Enabling this provisions and configures an OIDC (OpenID Connect) provider for in the EKS cluster"
}

variable "kubernetes_version" {
  description = "version of K8s to install in the cluster"
}

variable "map_roles" {
  description = "Additional IAM roles to add to the aws-auth configmap."
  type = list(object({
    rolearn  = string
    username = string
    groups   = list(string)
  }))
}

variable "map_users" {
  description = "Additional IAM users to add to the aws-auth configmap."
  type = list(object({
    userarn  = string
    username = string
    groups   = list(string)
  }))
}

variable "private_subnets" {
  description = "A list of AWS subnet Ids, used to deploy the EKS cluster"
  type        = list(string)
}

variable "vpc_id" {
  description = "The VPC Id of the AWS VPC to install the EKS cluster into"
}
