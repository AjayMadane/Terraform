resource "aws_eip" "eip" {
  //instance = aws_instance.web.id
  domain   = "vpc"
}