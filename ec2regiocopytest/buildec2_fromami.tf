#more to come
 resource "aws_instance" "testinstancefromami" {
  ami           = "${aws_ami_copy.ami_data_ec2.id}"
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.pub1.id}"
  vpc_security_group_ids  = ["${aws_security_group.allow_web_public.id}", "${aws_security_group.allow_ssh_public.id}"]
  associate_public_ip_address = true
  key_name = "awsla"
  tags = {
    Name = "instance built form stable ami "
  }
}

