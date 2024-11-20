data "aws_instance" "existing_instance" {
  instance_id = "instance id"  # Replace with your EC2 instance ID
}

resource "null_resource" "create_users" {
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("C:/Users/SAMARJEET SINGH/Downloads/sarav_server.pem") #absolute path
    host        = data.aws_instance.existing_instance.public_ip
  }

  provisioner "remote-exec" { #for invoking the script
    inline = [
      "sudo useradd user1",
      "echo 'user1:password' | sudo chpasswd",
      "sudo useradd user2",
      "echo 'user2:password' | sudo chpasswd"
    ]
  }
}
