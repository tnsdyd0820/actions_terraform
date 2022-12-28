provider "aws" {
  region = "ap-northeast-2"
}

terraform {
  backend "s3" {
      bucket         = "ksy-ksy-tf-storage"
      key            = "terraform/s3/main.tfstate"
      region         = "ap-northeast-2"
      encrypt        = true
      dynamodb_table = "ksy-lock"
  }
}

resource "aws_s3_bucket" "s3" {
  bucket = "ksy-ksy-tf-storage"
}
