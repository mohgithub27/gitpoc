resource "aws_instance" "ec2_instance" {
  ami                    = "ami-0c55b159cbfafe1f0"
  instance_type          = "t2.micro"
  key_name               = "mohkey"
  subnet_id              = "subnet-0f410b77cfff6009c"
  vpc_security_group_ids = ["sg-0d07281bc9e626247"]

  tags = {
    Name = "ec2_instance_through_Iac"
  }
}
