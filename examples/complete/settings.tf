provider "aws" {
  alias  = "ireland"
  region = "eu-west-1"
}

provider "aws" {
  alias  = "london"
  region = "eu-west-2"
}

provider "aws" {
  alias  = "frankfurt"
  region = "eu-central-1"
}

terraform {
  required_version = ">= 0.14.11"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.20.0"
    }
    # docker = {
    #   source  = "kreuzwerker/docker"
    #   version = ">= 2.13.0" # Use an appropriate version for your needs.
    # }
    time = {
      source  = "hashicorp/time"
      version = "0.12.1"
    }
  }
}
