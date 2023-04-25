resource "aws_s3_bucket" "Iac_demo_bucket" {
  bucket = "Iac-demo-bucket"
  acl    = "private"

  tags = {
    Name        = "Example Bucket"
    Environment = "Production"
  }
}
