resource "aws_iam_role" "glue_role" {
  name = "my_glue_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "glue.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "glue_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AWSGlueServiceRole"
  role       = aws_iam_role.glue_role.name
}

