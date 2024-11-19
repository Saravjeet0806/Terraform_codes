resource "aws_instance" "my_ec2" {
  ami           = "ami-0866a3c8686eaeeba" # Update this to your desired AMI
  instance_type = "t2.micro"
  subnet_id              = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  key_name               = "sarav_server" # Replace with your key pair name

  root_block_device {
    volume_size = 50 # disk size in GB (default 8 GB)
    volume_type = "gp2" # Optional: Specify the volume type (gp2, gp3, io1, io2, etc.)
  }

  tags = {
    Name = "ec2_created_using_tf"
  }
}
/* check if particular ami is available in the region = aws ec2 describe-images --image-ids ami-06a5805fdb18fee25 --region us-east-1 */
