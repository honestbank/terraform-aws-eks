# terraform-aws-eks Core Module

This folder contains the core code of the [terraform-aws-eks repo](https://github.com/honestbank/terraform-aws-eks).
When embedding this repo as a submodule, point the Terraform module source to this folder rather than the root of the repo.
The root of the repo contains a [wrapper](/terraform-aws-eks-wrapper.tf) that allows for testing and validation
of the module on [Terraform Cloud](https://app.terraform.io).

For background info on this repo and its functionality at a higher level, see the [repo readme](/README.md).
---

>
> To regenerate this section, delete everything under the horizontal divider below and run
> `terraform-docs markdown ./ >> README.md` in the folder root.
>
---

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 3.52 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | ~> 2.4 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.74.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_amazon_eks"></a> [amazon\_eks](#module\_amazon\_eks) | terraform-aws-modules/eks/aws | 17.1.0 |

## Resources

| Name | Type |
|------|------|
| [aws_kms_key.eks_node_ebs_encryption_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_launch_template.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_eks_cluster.eks-cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster) | data source |
| [aws_eks_cluster_auth.eks-cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster_auth) | data source |
| [aws_iam_policy_document.ebs_decryption](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_eks_desired_capacity"></a> [eks\_desired\_capacity](#input\_eks\_desired\_capacity) | Number of desired nodes | `any` | n/a | yes |
| <a name="input_eks_instance_type"></a> [eks\_instance\_type](#input\_eks\_instance\_type) | EC2 instance type to install K8s on to | `any` | n/a | yes |
| <a name="input_eks_max_capacity"></a> [eks\_max\_capacity](#input\_eks\_max\_capacity) | Max allowed number of nodes | `any` | n/a | yes |
| <a name="input_eks_min_capacity"></a> [eks\_min\_capacity](#input\_eks\_min\_capacity) | Minimum allowed number of nodes | `any` | n/a | yes |
| <a name="input_enable_irsa"></a> [enable\_irsa](#input\_enable\_irsa) | Enable IRSA (IAM Roles for Service Accounts). Enabling this provisions and configures an OIDC (OpenID Connect) provider for in the EKS cluster | `any` | n/a | yes |
| <a name="input_kubernetes_version"></a> [kubernetes\_version](#input\_kubernetes\_version) | version of K8s to install in the cluster | `any` | n/a | yes |
| <a name="input_map_roles"></a> [map\_roles](#input\_map\_roles) | Additional IAM roles to add to the aws-auth-configmap. | <pre>list(object({<br>    rolearn  = string<br>    username = string<br>    groups   = list(string)<br>  }))</pre> | `[]` | no |
| <a name="input_map_users"></a> [map\_users](#input\_map\_users) | Additional IAM users to add to the aws-auth configmap. | <pre>list(object({<br>    userarn  = string<br>    username = string<br>    groups   = list(string)<br>  }))</pre> | `[]` | no |
| <a name="input_name"></a> [name](#input\_name) | Name allocated to the EKS cluster | `any` | n/a | yes |
| <a name="input_private_subnets"></a> [private\_subnets](#input\_private\_subnets) | A list of AWS subnet Ids, used to deploy the EKS cluster | `list(string)` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | AWS id for the VPC to install the EKS cluster in | `any` | n/a | yes |

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
