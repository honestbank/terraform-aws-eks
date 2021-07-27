variable "name" {}
variable "private_subnets" {
  type = list(string)
}

variable "eks_desired_capacity" {}
variable "eks_max_capacity" {}
variable "eks_min_capacity" {}
variable "eks_instance_type" {}
variable "kubernetes_version" {}
variable "vpc_id" {}
