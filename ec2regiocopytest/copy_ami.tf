#copying ami with the instance details
resource "aws_ami_copy" "ami_data_ec2" {
  name              = "ami_data_ec2"
  description       = "A copy of ${aws_instance.mytestinstance.id}"
  source_ami_id     = "${aws_ami_from_instance.test_ami.id}"
  source_ami_region = "us-east-1"

  tags = {
    Name = "New AMI with data volumes "
  }
}
