/*
Purpose - To create an EC2 instance with VPC (Public Subnet) with Security Group attached
Developer - K.Janarthanan
*/


#Security Group
resource "aws_security_group" "main" {
  name        = var.SecurityGroup_Name1
  description = "To allow FTP, SFTP and SSH Traffic"
  vpc_id      = aws_vpc.main.id


  tags = {
    Name = var.SecurityGroup_Name1
  }

  ingress {
    description = "HTTP Traffic Allow"
    from_port   = 21
    to_port     = 21
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH and SFTP Traffic Allow"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Outside"
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}

