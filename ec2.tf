resource "aws_instance" "public1" {
  ami           = ami-03643cf1426c9b40b
  key_name = amazon.pem
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.public1.id
  vpc_security_group_ids = [aws_security_group.allow_tls_ec2.id]
  associate_public_ip_address = true

  tags = {
    Name = "public1"
  }

  provisioner "file" {
    source = "./amazon.pem"
    destination = "/home/ec2-user/amazon.pem"
  
    connection {
      type = "ssh"
      host = self.public_ip
      user = "ec2-user"
      private_key = "${file("./amazon.pem")}"
    }  
}
}


resource "aws_instance" "public2" {
  ami           = ami-03643cf1426c9b40b
  key_name = amazon.pem
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.public2.id
  vpc_security_group_ids = [aws_security_group.allow_tls_ec2.id]
  associate_public_ip_address = true

  tags = {
    Name = "public2"
  }
}

resource "aws_instance" "private_db" {
  ami           = ami-03643cf1426c9b40b
  key_name = amazon.pem
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.private.id
  vpc_security_group_ids = [aws_security_group.allow_tls_ec2.id]

  tags = {
    Name = "private_db"
  }
}