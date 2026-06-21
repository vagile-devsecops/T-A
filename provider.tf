terraform {
   backend "s3" {
    bucket = "vagile-bucket"
    key    = "v/dev/terraform.tfstate"
    region = "us-east-1"
    encrypt = true
    use_lockfile = true
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.1"
    }
  }
  required_version = ">= 1.0"
}

# # Configure the AWS Provider
# provider "aws" {
#   region = "us-east-1"
# }

# provider "aws" {
#   alias  = "ohio"
#   region = "us-east-2"
  
# }