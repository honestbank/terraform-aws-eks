# Terraform AWS EKS

This Terraform Component module builds an [AWS Elastic Kubernetes Service](https://aws.amazon.com/eks/) cluster.

This module is opinionated towards security by design. That means there will generally be no support for overriding
or disabling security best practice-based features (eg. EBS volume encryption).

The docs below specify the inputs/outputs of the wrapper. For the actual module's inputs/outputs see
[eks/README.md](/eks/README.md).

---

To update the docs below run `make docs`.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 3.52 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | ~> 2.4 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.52.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_eks"></a> [eks](#module\_eks) | ./eks | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_eks_cluster.eks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster) | data source |
| [aws_eks_cluster_auth.eks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster_auth) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region to install the EKS cluster into | `any` | n/a | yes |
| <a name="input_aws_vpc_name"></a> [aws\_vpc\_name](#input\_aws\_vpc\_name) | The name of the AWS VPC to install the EKS cluster into | `any` | n/a | yes |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | The name of the EKS cluster | `any` | n/a | yes |
| <a name="input_eks_desired_capacity"></a> [eks\_desired\_capacity](#input\_eks\_desired\_capacity) | Number of desired nodes | `any` | n/a | yes |
| <a name="input_eks_instance_type"></a> [eks\_instance\_type](#input\_eks\_instance\_type) | EC2 instance type to install K8s on to | `any` | n/a | yes |
| <a name="input_eks_max_capacity"></a> [eks\_max\_capacity](#input\_eks\_max\_capacity) | Max allowed number of nodes | `any` | n/a | yes |
| <a name="input_eks_min_capacity"></a> [eks\_min\_capacity](#input\_eks\_min\_capacity) | Minimum allowed number of nodes | `any` | n/a | yes |
| <a name="input_enable_irsa"></a> [enable\_irsa](#input\_enable\_irsa) | Enable IRSA (IAM Roles for Service Accounts). Enabling this provisions and configures an OIDC (OpenID Connect) provider for in the EKS cluster | `any` | n/a | yes |
| <a name="input_kubernetes_version"></a> [kubernetes\_version](#input\_kubernetes\_version) | version of K8s to install in the cluster | `any` | n/a | yes |
| <a name="input_map_roles"></a> [map\_roles](#input\_map\_roles) | Additional IAM roles to add to the aws-auth configmap. | <pre>list(object({<br>    rolearn  = string<br>    username = string<br>    groups   = list(string)<br>  }))</pre> | n/a | yes |
| <a name="input_map_users"></a> [map\_users](#input\_map\_users) | Additional IAM users to add to the aws-auth configmap. | <pre>list(object({<br>    userarn  = string<br>    username = string<br>    groups   = list(string)<br>  }))</pre> | n/a | yes |
| <a name="input_private_subnets"></a> [private\_subnets](#input\_private\_subnets) | A list of AWS subnet Ids, used to deploy the EKS cluster | `list(string)` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The VPC Id of the AWS VPC to install the EKS cluster into | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_certificate_authority_data"></a> [certificate\_authority\_data](#output\_certificate\_authority\_data) | CA data used to connect to the cluster. Outputted to allow the Kubernetes provider to install the aws\_auth config map (allow allocated users to access) |
| <a name="output_cluster_id"></a> [cluster\_id](#output\_cluster\_id) | Tied to the internal cluster\_id of the AWS EKS module |
| <a name="output_cluster_oidc_issuer_url"></a> [cluster\_oidc\_issuer\_url](#output\_cluster\_oidc\_issuer\_url) | The URL on the EKS cluster OIDC Issuer |
| <a name="output_cluster_primary_security_group_id"></a> [cluster\_primary\_security\_group\_id](#output\_cluster\_primary\_security\_group\_id) | The primary cluster Security Group |
| <a name="output_cluster_security_group_id"></a> [cluster\_security\_group\_id](#output\_cluster\_security\_group\_id) | A Security Group attached to the EKS cluster, shown as 'Additional security groups' in the EKS console |
| <a name="output_eks-cluster-endpoint"></a> [eks-cluster-endpoint](#output\_eks-cluster-endpoint) | The URI of the cluster endpoint, used for Admin tasks, i.e Kubectl |
| <a name="output_eks-cluster-token"></a> [eks-cluster-token](#output\_eks-cluster-token) | Token to access the EKS cluster |
| <a name="output_eks_node_ebs_encryption_key_arn"></a> [eks\_node\_ebs\_encryption\_key\_arn](#output\_eks\_node\_ebs\_encryption\_key\_arn) | ARN of the auto-created KMS key used to encrypt/decrypt the cluster worker nodes' EBS volumes. |
| <a name="output_oidc_provider_arn"></a> [oidc\_provider\_arn](#output\_oidc\_provider\_arn) | The ARN of the OIDC Provider if `enable_irsa = true` |
<!-- END_TF_DOCS -->
