provider "aws" {
  region = "eu-north-1"
}

resource "aws_key_pair" "awskey" {
  key_name = "id_rsa"
  public_key = file("./id_rsa.pub")
}
resource "aws_instance" "public1" {
  ami           = "ami-03643cf1426c9b40b"
  key_name = aws_key_pair.awskey.key_name
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.public1.id
  vpc_security_group_ids = [aws_security_group.allow_tls_ec2.id]
  associate_public_ip_address = true
  tags = {
    Name = "public1"
  }
  connection {
    type = "ssh"
    user = "ubuntu"
    private_key = file("./id_rsa")
    host = self.public_ip
  }
}



resource "aws_instance" "public2" {
  ami           = "ami-03643cf1426c9b40b"
  key_name = aws_key_pair.awskey.key_name
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.public2.id
  vpc_security_group_ids = [aws_security_group.allow_tls_ec2.id]
  associate_public_ip_address = true

  tags = {
    Name = "public2"
  }
  connection {
    type = "ssh"
    user = "ubuntu"
    private_key = file("./id_rsa")
    host = self.public_ip
  }
}

resource "aws_instance" "private_db" {
  ami           = "ami-03643cf1426c9b40b"
  key_name = aws_key_pair.awskey.key_name
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.private.id
  vpc_security_group_ids = [aws_security_group.allow_tls_ec2.id]

  tags = {
    Name = "private_db"
  }
  connection {
    type = "ssh"
    user = "ubuntu"
    private_key = file("./id_rsa")
    host = self.public_ip
  }
}


