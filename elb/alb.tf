resource "aws_lb" "appelb" {
  name               = "appelb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${aws_security_group.allow_web_public.id}"]
  subnets            = ["${aws_subnet.pub1.id}", "${aws_subnet.pub2.id}" ]

  enable_deletion_protection = false


  tags = {
    Environment = "test"
  }
}


# creating target group 
resource "aws_lb_target_group" "apptg" {
  name     = "apptg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${aws_vpc.main.id}"
  target_type = "instance"
  health_check {
   path = "/"
   port = 80
   healthy_threshold = 5
   unhealthy_threshold = 2
   timeout = 2
   interval = 5 

   }
}
resource "aws_lb_target_group_attachment" "apptg_traget1" {
  target_group_arn = "${aws_lb_target_group.apptg.arn}"
  target_id        = "${aws_instance.appinstance1.id}"
  port             = 80
}

resource "aws_lb_target_group_attachment" "apptg_traget2" {
  target_group_arn = "${aws_lb_target_group.apptg.arn}"
  target_id        = "${aws_instance.appinstance2.id}"
  port             = 80
}



resource "aws_lb_listener" "front_end" {
  load_balancer_arn = "${aws_lb.appelb.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = "${aws_lb_target_group.apptg.arn}"

  }
}
