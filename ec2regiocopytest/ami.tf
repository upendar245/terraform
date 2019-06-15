resource "aws_ami_from_instance" "test_ami" {
  name               = "test_ami"
  source_instance_id = "${aws_instance.mytestinstance.id}"
}
