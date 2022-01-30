# Source: https://github.com/terraform-aws-modules/terraform-aws-eks/blob/v17.1.0/examples/launch_templates_with_managed_node_groups/launchtemplate.tf
#
# This is based on the LT that EKS would create if no custom one is specified (aws ec2 describe-launch-template-versions --launch-template-id xxx)
# there are several more options one could set but you probably dont need to modify them
# you can take the default and add your custom AMI and/or custom tags
#
# Trivia: AWS transparently creates a copy of your LaunchTemplate and actually uses that copy then for the node group. If you DONT use a custom AMI,
# then the default user-data for bootstrapping a cluster is merged in the copy.
resource "aws_launch_template" "default" {
  name_prefix            = "eks-"
  description            = "EKS Node Group Launch Template - Encrypted EBS"
  update_default_version = true

  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_size           = var.eks_worker_node_ebs_volume_size
      volume_type           = var.eks_worker_node_ebs_volume_type
      delete_on_termination = true
      encrypted             = true

      # Enable this if you want to encrypt your node root volumes with a KMS/CMK. encryption of PVCs is handled via k8s StorageClass tho
      # you also need to attach data.aws_iam_policy_document.ebs_decryption.json from the disk_encryption_policy.tf to the KMS/CMK key then !!
      kms_key_id = aws_kms_key.eks_node_ebs_encryption_key.arn
    }
  }

  #  instance_type = var.eks_instance_type
  #
  #  monitoring {
  #    enabled = true
  #  }
  #
  #  network_interfaces {
  #    associate_public_ip_address = false
  #    delete_on_termination       = true
  #    security_groups             = [module.amazon_eks.worker_security_group_id]
  #  }

  # if you want to use a custom AMI
  # image_id      = var.ami_id

  # If you use a custom AMI, you need to supply via user-data, the bootstrap script as EKS DOESNT merge its managed user-data then
  # you can add more than the minimum code you see in the template, e.g. install SSM agent, see https://github.com/aws/containers-roadmap/issues/593#issuecomment-577181345
  #
  # (optionally you can use https://registry.terraform.io/providers/hashicorp/cloudinit/latest/docs/data-sources/cloudinit_config to render the script, example: https://github.com/terraform-aws-modules/terraform-aws-eks/pull/997#issuecomment-705286151)

  # user_data = base64encode(
  #   data.template_file.launch_template_userdata.rendered,
  # )


  # Supplying custom tags to EKS instances is another use-case for LaunchTemplates
  #  tag_specifications {
  #    resource_type = "instance"
  #
  #    tags = {
  #      Terraform = "true"
  #    }
  #  }

  # Supplying custom tags to EKS instances root volumes is another use-case for LaunchTemplates. (doesnt add tags to dynamically provisioned volumes via PVC tho)
  #  tag_specifications {
  #    resource_type = "volume"
  #
  #    tags = {
  #      Terraform = "true"
  #    }
  #  }

  # Tag the LT itself
  #  tags = {
  #    Terraform = "true"
  #  }

  lifecycle {
    create_before_destroy = true
  }
}
