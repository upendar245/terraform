# Adding securuty groups
resource "aws_security_group" "allow_nfs_traffic" {
          name = "allow_nfs_traffic"
          description = "allow nfs traffic"
          vpc_id     = "${aws_vpc.main.id}"
          ingress {
                 from_port = 2049
                 to_port = 2049
                 protocol = "tcp"
                 cidr_blocks = [ "10.0.0.0/16"]
                 description = " allow web traffic"
                  }
          egress {
               from_port       = 0
               to_port         = 0
               protocol        = "-1"
               cidr_blocks     = ["0.0.0.0/0"]
               }
}






###################################################################
resource "aws_efs_file_system" "mynfs" {
  creation_token = "homedir"

  tags = {
    Name = "homedir"
  }
}

resource "aws_efs_mount_target" "pri1" {
  file_system_id = "${aws_efs_file_system.mynfs.id}"
  subnet_id      = "${aws_subnet.pub2.id}"
  security_groups = ["${aws_security_group.allow_nfs_traffic.id}"]
}
