data "template_file" "user_data" {
  template = file("sftp.sh")
}

#EC2 instance creation for Dev
resource "aws_instance" "EC-1" {
  ami                    = var.AMI_ID
  instance_type          = var.EC2_Size
  subnet_id              = aws_subnet.public1.id
  vpc_security_group_ids = [aws_security_group.main.id]
  user_data              = data.template_file.user_data.rendered

  tags = {
    Name = "SFTP-Server"
  }
}

