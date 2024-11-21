# Configure the AWS provider
provider "aws" {
  region = "us-east-1"
}

# Create a Security Group for an EC2 instance
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

# Create an EC2 instance
resource "aws_instance" "example" {
  ami           = "ami-0866a3c8686eaeeba" # Ensure this AMI is valid 
  instance_type = "t2.micro"

  vpc_security_group_ids = [aws_security_group.instance.id]

  user_data = <<-EOF
    #!/bin/bash
    sudo yum install -y wget
    mkdir -p /var/www/html
    wget -O /var/www/html/index.html https://saravjeet0806.github.io/calculator-app-reactjs/
    nohup busybox httpd -f -p 8080 &
  EOF

  tags = {
    Name = "terraform-example"
  }
}

# Output variable: Public IP address
output "public_ip" {
  description = "The public IP address of the EC2 instance"
  value       = aws_instance.example.public_ip
}
