terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
}
}
}

provider "aws" {
  region = "eu-central-1"
  shared_credentials_file="~/.aws/credentials"
}
