provider "aws" {
  region = "eu-central-1"
}

data "aws_vpc" "vpc" {
  id = "vpc-09412c32472e47fcc"
}

data "aws_subnet" "subnet" {
  id = "subnet-02e83f98fd9ff0004"
}

data "aws_key_pair" "me" {
  key_name = "oskars"
}


resource "aws_security_group" "sg" {
  vpc_id      = "vpc-09412c32472e47fcc"
  name        = "AllowSshWeb"
  description = "Allow SSH/Web access"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

 ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "SecurityGroup"
  }
}

resource "aws_instance" "ec2" {
  ami           = "ami-0a628e1e89aaedf80"
  instance_type = "t3.small"
  subnet_id     = "subnet-02e83f98fd9ff0004"
  key_name      = "oskars"

  associate_public_ip_address = true
  vpc_security_group_ids = [ aws_security_group.sg.id,]

  root_block_device {
    volume_size = 40  
    volume_type = "gp3"
  }

  tags = {
    Name = "ec2"
  }

  depends_on = [aws_security_group.sg]
}

resource "null_resource" "copy_files" {
  provisioner "file" {
    source      = "./../../mintos-homework"
    destination = "/home/ubuntu"

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = "${file("~/.ssh/id_rsa")}"
      host        = aws_instance.ec2.public_ip
    }
  }

  triggers = {
    trigger_value = "${timestamp()}"
  }
  depends_on = [aws_instance.ec2]
}

resource "null_resource" "exec_bash" {
  provisioner "remote-exec" {
    inline = [". /home/ubuntu/mintos-homework/run.sh"]
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = "${file("~/.ssh/id_rsa")}"
      host        = aws_instance.ec2.public_ip
    }
  }

  triggers = {
    trigger_value = "${timestamp()}"
  }

  depends_on = [null_resource.copy_files]

}

output "instance_public_ip" {
  description = "Public IP "
  value       = aws_instance.ec2.public_ip
}