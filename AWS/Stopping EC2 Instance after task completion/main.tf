data "aws_instance" "existing_instance" {
  instance_id = "i-014ab8c3a58b5d430" # Replace with your EC2 instance ID
}

resource "null_resource" "start_instance" {
  provisioner "local-exec" { #replace us-east-1 with your region
    command = <<EOT
      $state = (aws ec2 describe-instances --instance-ids ${data.aws_instance.existing_instance.instance_id} --query \"Reservations[0].Instances[0].State.Name\" --output text --region us-east-1) 
      if ($state -ne "running") {
        Write-Host "Instance is not running. Starting instance..."
        aws ec2 start-instances --instance-ids ${data.aws_instance.existing_instance.instance_id} --region us-east-1
        Write-Host "Waiting for the instance to start..."
        aws ec2 wait instance-running --instance-ids ${data.aws_instance.existing_instance.instance_id} --region us-east-1
      } else {
        Write-Host "Instance is already running."
      }
    EOT
    interpreter = ["powershell", "-Command"]
  }
}

resource "null_resource" "create_users" {
  depends_on = [null_resource.start_instance]

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("C:/Users/SAMARJEET SINGH/Downloads/sarav_server.pem") # Use an absolute path
    host        = data.aws_instance.existing_instance.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "mkdir f1 f2 f3",
      "sudo apt-get update",
      "echo 'Work completed on the instance.'"
    ]
  }

  provisioner "local-exec" {
    command = <<EOT
      echo "Stopping the instance after work is done..."
      aws ec2 stop-instances --instance-ids ${data.aws_instance.existing_instance.instance_id} --region us-east-1
    EOT
  }
}

output "instance_public_ip" {
  value = data.aws_instance.existing_instance.public_ip
}
