terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"  # Change this to your desired region
}

# Create IAM user
resource "aws_iam_user" "admin_user" {
  name = "admin-user"  # Change this to your desired username
  
  tags = {
    Description = "Administrator user"
    Environment = "Production"
  }
}

# Create access key for the user
resource "aws_iam_access_key" "admin_user_key" {
  user = aws_iam_user.admin_user.name
}

# Attach AdministratorAccess policy directly to the user
resource "aws_iam_user_policy_attachment" "admin_access" {
  user       = aws_iam_user.admin_user.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

# Output the access key details
output "access_key_id" {
  value = aws_iam_access_key.admin_user_key.id
}

output "secret_access_key" {
  value     = aws_iam_access_key.admin_user_key.secret
  sensitive = true
}

output "user_arn" {
  value = aws_iam_user.admin_user.arn
}
