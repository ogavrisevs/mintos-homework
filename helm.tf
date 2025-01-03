resource "null_resource" "install_docker" {
  provisioner "local-exec" {
    command = <<EOT
      # Update apt and install required dependencies
      sudo apt-get update -y
      sudo apt-get install -y curl apt-transport-https
      
      # Add Helm GPG key and repository
      curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null
      echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list

      # Update apt and install Helm 3
      sudo apt-get update -y
      sudo apt-get install -y helm
      
      # Verify Helm installation
      helm version
      
    EOT
  }
}


