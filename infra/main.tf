terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.40"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "sa-east-1"
}

module "lambda_authorizer" {
  source = "./modules/lambda_authorizer"
  
  lambda_authorizer_name = "${var.lambda_authorizer_name}"
}

module "api_gateway" {
  source = "./modules/api_gateway"
  
  lambda_authorizer_invoke_arn = module.lambda_authorizer.lambda_invoke_arn
  region = var.region
}
