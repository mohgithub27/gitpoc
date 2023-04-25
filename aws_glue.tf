resource "aws_glue_catalog_database" "glue_db" {
  name = "my_database"
}

resource "aws_glue_catalog_table" "glue_table" {
  name          = "my_table"
  database_name = aws_glue_catalog_database.glue_db.name
  table_type    = "EXTERNAL_TABLE"
  parameters = {
    "skip.header.line.count" = "1"
  }
  storage_descriptor {
    location      = "s3://my-bucket/my-folder/"
    input_format  = "org.apache.hadoop.mapred.TextInputFormat"
    output_format = "org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat"
    serde_info {
      serialization_library = "org.apache.hadoop.hive.serde2.OpenCSVSerde"
      parameters = {
        "separatorChar" = ","
      }
    }
    columns {
      name = "column1"
      type = "string"
    }
    columns {
      name = "column2"
      type = "int"
    }
  }
}

resource "aws_glue_job" "glue_job" {
  name               = "my_job"
  role_arn           = aws_iam_role.glue_role.arn
  allocated_capacity = 2
  command {
    name            = "glueetl"
    script_location = "s3://my-bucket/my-script.py"
  }
  default_arguments = {
    "--job-language"                     = "python"
    "--enable-continuous-cloudwatch-log" = "true"
  }
  execution_property {
    max_concurrent_runs = 1
  }
  connections {
    connections = [
      "my-jdbc-connection",
      "my-s3-connection"
    ]
  }
  tags = {
    Environment = "non-prod"
  }
}










