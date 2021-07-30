variable "name" {
  description = "Name allocated to the EKS cluster"
}

variable "private_subnets" {
  description = "A list of AWS subnet Ids, used to deploy the EKS cluster"
  type        = list(string)
}

variable "eks_desired_capacity" {
  description = "Number of desired nodes"
}

variable "eks_max_capacity" {
  description = "Max allowed number of nodes"
}

variable "eks_min_capacity" {
  description = "Minimum allowed number of nodes"
}

variable "eks_instance_type" {
  description = "EC2 instance type to install K8s on to"
}

variable "kubernetes_version" {
  description = "version of K8s to install in the cluster"
}

variable "vpc_id" {
  description = "AWS id for the VPC to install the EKS cluster in"
}

variable "map_users" {
  description = "A map of type list that allocated users to K8s roles via their AWS ARN"
  type = list(object({
    groups   = list(string)
    userarn  = string
    username = string
  }))
}

variable "map_roles" {
  description = "A map of type list that allocated roles to K8s roles via their AWS ARN"
  type = list(object({
    groups   = list(string)
    rolearn  = string
    username = string
  }))
}
