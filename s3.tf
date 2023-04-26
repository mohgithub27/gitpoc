resource "aws_s3_bucket" "Source_Iac_demo_bucket" {
  bucket = "Source_Iac-demo-bucket"
  acl    = "private"

  tags = {
    Name        = "Demo Bucket for POC"
    Environment = "Non-Prod"
  }
}

resource "aws_s3_bucket" "Destination_Iac_demo_bucket" {
  bucket = "Destination_Iac-demo-bucket"
  acl    = "private"

  tags = {
    Name        = "Demo Bucket for POC"
    Environment = "Non-Prod"
  }
}
