resource "aws_kms_key" "eks_node_ebs_encryption_key" {
  description = "EKS Node EBS volume encryption key"

  policy = data.aws_iam_policy_document.ebs_decryption.json

  enable_key_rotation = true
}
