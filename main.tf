terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket = "cloudmastry-backend"
    key    = "ec2/terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "web_server" {
  ami           = "ami-0c55b159cbfafe1f0"  # Amazon Linux 2
  instance_type = "t2.micro"
  
  tags = {
    Name        = "web-server"
    Environment = "production"
    ManagedBy   = "Terraform"
  }
}

output "instance_public_ip" {
  value = aws_instance.web_server.public_ip
}