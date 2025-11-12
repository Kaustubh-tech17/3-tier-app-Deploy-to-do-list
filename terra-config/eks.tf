
# Create the EKS Cluster
#resource "aws_eks_cluster" "eks_cluster" {
#name = "Three-tier-cloud"

 # role_arn = aws_iam_role.cluster_role.arn

 # vpc_config {
  #  subnet_ids = data.aws_subnets.public.ids
  #}
  #depends_on = [
  #  aws_iam_role_policy_attachment.cluster_AmazonEKSClusterPolicy,
  #]
#}
------------------------------------------------------------------
#resource "aws_eks_cluster" "eks_cluster" {
  #name = "Three-tier-cloud"
  #role_arn = aws_iam_role.cluster_role.arn

  #vpc_config {
   # subnet_ids = data.aws_subnets.public.ids
  #}

  #depends_on = [
   # aws_iam_role_policy_attachment.cluster_AmazonEKSClusterPolicy
  #]
#}
------------------------------------------------------
resource "aws_eks_cluster" "eks_cluster" {
  name     = "Three-tier-cloud"
  role_arn = aws_iam_role.cluster_role.arn

  vpc_config {
    subnet_ids = [
      "subnet-05d3a52cc30950a8c", # us-east-1a
      "subnet-04b6af886a1fff2a2", # us-east-1b
      "subnet-05e74108971ae5074", # us-east-1c
      "subnet-08854e83a1fccda99", # us-east-1d
      "subnet-097337a08153cd7ef"  # us-east-1f
    ]
  }

  depends_on = [
    aws_iam_role_policy_attachment.cluster_AmazonEKSClusterPolicy
  ]
}
