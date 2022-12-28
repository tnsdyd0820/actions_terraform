provider "aws" {
  region  = "ap-northeast-2"
}


resource "aws_instance" "gitaction-test" {
  ami = "ami-06eea3cd85e2db8ce"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.sg.id]
  key_name = "test"

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p 8080 &
              EOF

  user_data_replace_on_change = true

  tags = {
    Name = "gitaction-test"
  }
}

resource "aws_security_group" "sg" {

  name = var.security_group_name

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

variable "security_group_name" {
  description = "The name of the security group"
  type        = string
  default     = "gitaction-test-sg"
}

output "public_ip" {
  value       = aws_instance.gitaction-test.public_ip
  description = "The public IP of the Instance"
}

