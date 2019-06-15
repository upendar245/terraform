resource "aws_key_pair" "mykey" {
  key_name   = "awsla"
  public_key = ""
}


locals {
     instance-userdata = <<EOF
#!/bin/bash
yum update -y   >> /var/log/bootstrap.log
yum install httpd -y >> /var/log/bootstrap.log
chkconfig httpd on >> /var/log/bootstrap.log
service httpd start >> /var/log/bootstrap.log

EOF


}



resource "aws_instance" "mytestinstance" {
  ami           = "ami-0756fbca465a59a30"
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.pub2.id}"
  vpc_security_group_ids  = ["${aws_security_group.allow_web_public.id}", "${aws_security_group.allow_ssh_public.id}"]
  associate_public_ip_address = true
  key_name = "awsla"
  user_data_base64 = "${base64encode(local.instance-userdata)}"
  tags = {
    Name = "Test Instance"
  }
}

resource "aws_instance" "mytestinstance2" {
  ami           = "ami-0756fbca465a59a30"
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.pub1.id}"
  vpc_security_group_ids  = ["${aws_security_group.allow_web_public.id}", "${aws_security_group.allow_ssh_public.id}"]
  associate_public_ip_address = false
  key_name = "awsla"
  user_data_base64 = "${base64encode(local.instance-userdata)}"
  tags = {
    Name = "Test Instance2"
  }
}
