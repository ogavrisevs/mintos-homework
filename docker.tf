resource "null_resource" "install_docker" {
  provisioner "local-exec" {
    command = <<EOT
      # Update package index
      sudo apt update -y
      
      # Install Docker prerequisites
      sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
      
      # Add Docker's official GPG key
      curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
      
      # Set up Docker repository
      echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
      
      # Update package index again
      sudo apt update -y
      
      # Install Docker
      sudo apt install -y docker-ce docker-ce-cli containerd.io
      
      # Start 
      sudo systemctl enable docker
      sudo systemctl start docker

      # Add current user to the Docker group
      sudo usermod -aG docker $USER
      newgrp docker
      
    EOT
  }
}
