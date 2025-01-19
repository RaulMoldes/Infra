provider "aws" {
  region = var.aws_region
}

## DEFINE THE BACKEND

terraform {
  backend "s3" {
    bucket         = "tf-states-raulmoldes"
    key            = "tf-states/raulmoldes/ec2/tf.state"
    region         = "eu-west-1"
    dynamodb_table = "tf_states_raulmoldes"
  }
}

data "aws_vpc" "default" {
  default = true
}


data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }

}

# Define a security group for the instance
resource "aws_security_group" "SingleServerSG" {
  name_prefix = "SingleServerSG"
  description = "Allow SSH and HTTP access"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow SSH from anywhere; restrict in production
  }

  ingress {
    from_port   = var.server_port
    to_port     = var.server_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow HTTP from anywhere
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # All traffic
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "SingleServerSG"
  }
}

# Create an EC2 instance
resource "aws_instance" "SingleServer" {
  ami           = "ami-0ef0975ebdd78b77b"
  instance_type = "t2.micro"

  # Associate the security group
  vpc_security_group_ids = [aws_security_group.SingleServerSG.id]

  # Specify a key pair for SSH access
  key_name = aws_key_pair.SingleServerKey.key_name

  # Configure block storage
  root_block_device {
    volume_size = 10    # Root volume size in GB
    volume_type = "gp2" # General Purpose SSD
  }

  user_data = <<-EOF
    #!/bin/bash
    echo "Hello, World!" > index.html
    nohup busybox httpd -f -p {var.server_port} &
    EOF

  # user_data.replace_on_change = true

  # Tags for better identification
  tags = {
    Name = "SingleServer"
  }
}

# Create a key pair for SSH access
resource "aws_key_pair" "SingleServerKey" {
  key_name   = "SingleServerKey"
  public_key = file("/home/raulmoldes/.ssh/id_rsa.pub") # Path to your public SSH key
}

# Outputs to display after provisioning
output "instance_public_ip" {
  value = aws_instance.SingleServer.public_ip
}

output "instance_ssh_command" {
  value = "ssh -i /home/raulmoldes/.ssh/id_rsa ec2-user@${aws_instance.SingleServer.public_ip}"
}
