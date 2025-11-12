resource "aws_eks_cluster" "eks_cluster" {
  name     = "Three-tier-cloud"
  role_arn = aws_iam_role.cluster_role.arn

  vpc_config {
    subnet_ids = aws_subnet.public[*].id
  }

  depends_on = [
    aws_iam_role_policy_attachment.cluster_AmazonEKSClusterPolicy
  ]

  tags = {
    Name = "Three-tier-cloud"
  }
}
