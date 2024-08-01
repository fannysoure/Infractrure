module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = "local.cluster_name"
  cluster_version = "1.30"

  

  vpc_id                   = "aws_vpc.myvpc.id"
  subnet_ids               = "subnet_id = aws_subnet.public_subnet[count.index].id"
  

  # EKS Managed Node Group(s). Starting on 1.30, AL2023 is the default AMI type for EKS managed node groups
  eks_managed_node_group_defaults = {
    ami_type = "AL2023_x86_64_STANDARD"
  }   

  eks_managed_node_groups = {
    node = {
     
    
      instance_types = ["t3.small"]

      min_size     = 2
      max_size     = 6
      desired_size = 2

      pre_bootstrap_user_data = <<-EOT
      echo 'foo bar'
      EOT

      vpc_security_group_ids = [
        aws_security_group.node.id
      ]
    }
  }
}