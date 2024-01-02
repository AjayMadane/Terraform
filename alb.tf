resource "aws_lb" "alb" {
  name               = "test-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow_tls_ec2.id]
  subnets            = ["aws_subnet.public1.id","aws_subnet.public2.id"]
  
  enable_deletion_protection = true


  tags = {
    Environment = "production"
  }
}
//listner
resource "aws_lb_listener" "front-end" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.albtg.arn
  }
}
//target group
resource "aws_lb_target_group" "albtg" {
  name        = "tf-example-lb-alb-tg"
  target_type = "instance"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.main.id


}

resource "aws_lb_target_group_attachment" "test" {
  target_group_arn = aws_lb_target_group.albtg.arn
  target_id        = aws_instance.public1.id 
  port             = 80
}

resource "aws_lb_target_group_attachment" "test1" {
  target_group_arn = aws_lb_target_group.albtg.arn
  target_id        = aws_instance.public2.id 
  port             = 80
}
