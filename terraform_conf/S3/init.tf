provider "aws" {
  region = "ap-northeast-2" # Please use the default region ID
}

# S3 bucket for backend
resource "aws_s3_bucket" "ksy_tfstate" { 
  bucket = "sy_tf_storage"
}
resource "aws_s3_bucket_versioning" "ksy_tfstate" {
  bucket = aws_s3_bucket.ksy_tfstate.bucket

  versioning {
    enabled = true # Prevent from deleting tfstate file
  }
}

# DynamoDB for terraform state lock
resource "aws_dynamodb_table" "terraform_state_lock" {
  name           = "terraform-lock"
  hash_key       = "LockID"
  billing_mode   = "PAY_PER_REQUEST"

  attribute {
    name = "LockID"
    type = "S"
  }
}
