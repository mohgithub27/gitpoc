resource "aws_iam_role" "emr_role" {
  name = "my_emr_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "elasticmapreduce.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_emr_cluster" "emr_cluster" {
  name          = "my_emr_cluster"
  release_label = "emr-6.2.0"
  service_role  = "EMR_DefaultRole"
  job_flow_role = "EMR_EC2_DefaultRole"

  master_instance_group {
    instance_type  = "m5.xlarge"
    instance_count = 1
  }

  core_instance_group {
    instance_type  = "m5.xlarge"
    instance_count = 2
  }

  ec2_attributes {
    subnet_id = "subnet-123456789"
    key_name  = "mohkey"
  }

  configurations_json = <<EOF
[
  {
    "Classification": "emrfs-site",
    "Properties": {
      "fs.s3.consistent.retryPolicyType": "exponential",
      "fs.s3.consistent.retryPeriodSeconds": "10",
      "fs.s3.consistent": "true",
      "fs.s3.consistent.metadata.tableName": "EmrFSMetadata"
    }
  }
]
EOF

  tags = {
    Environment = "Non-Prod"
  }

}

