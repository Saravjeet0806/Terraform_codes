# Use the Kreuzwerker Docker provider
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.24.0" # Use the latest compatible version
    }
  }
}

# Configure the Docker provider
provider "docker" {}

# Define a Docker image resource
resource "docker_image" "my_image" {
  name = "nginx" # Replace with your image name and tag
}


# Define a Docker container resource
resource "docker_container" "my_container" {
  name  = "terraform-nginx"
  image = docker_image.my_image.latest
  ports {
    internal = 80
    external = 8080
  }
}

# Output container ID
output "container_id" {
  value = docker_container.my_container.id
}
