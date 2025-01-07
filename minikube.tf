# Install Minikube using a local resource
resource "null_resource" "install_minikube" {
  provisioner "local-exec" {
    command = <<EOT
      # Update system packages
      sudo apt update -y
      
      # Install required dependencies
      sudo apt install -y apt-transport-https curl software-properties-common conntrack

      # Download Minikube
      curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64

      # Install Minikube
      sudo install minikube /usr/local/bin/

      # Start k8s 
      minikube start 
      minikube addons enable ingress
      
      # Clean up
      rm minikube
    EOT
  }
}

# Install kubectl using a local resource
resource "null_resource" "install_kubectl" {
  provisioner "local-exec" {
    command = <<EOT
      # Download kubectl binary
      curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

      # Install kubectl
      sudo install kubectl /usr/local/bin/

      # Clean up
      rm kubectl
    EOT
  }

  depends_on = [null_resource.install_minikube]
}