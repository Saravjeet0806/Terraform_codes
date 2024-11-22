provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "instance" {
  name        = "terraform-example-instance"
  description = "Allow HTTP traffic on port 8080"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # Allow all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "example" {
  ami           = "ami-0866a3c8686eaeeba" # Ensure this AMI is valid 
  instance_type = "t2.micro"

  vpc_security_group_ids = [aws_security_group.instance.id]

  key_name = "sarav_server" # Use the uploaded key pair

 user_data = <<-EOF
	      #!/bin/bash
	      echo "Hello, World" > index.html
	      nohup busybox httpd -f -p 8080 &
	      EOF

  tags = {
    Name = "terraform-example"
  }
}

output "public_ip" {
  description = "The public IP address of the EC2 instance"
  value       = aws_instance.example.public_ip
}
