resource "aws_key_pair" "Semi1-key2" {
  key_name   = "Semi1-ht1" 
  public_key = file("${var.PATH_PUBLIC_KEYPAIR}")
}

resource "aws_security_group" "Semi1-instances-sg1" {
  name   = "Semi1_instances-sg1"
  description = "Security group for EC2 instances and related services"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow SSH from anywhere (consider restricting this for security)
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow HTTP traffic
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow traffic on port 3000 (e.g., for Node.js app)
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]  # Allow all outbound traffic
  }
}

resource "aws_instance" "ec2_node_ht1" {
  ami             = "ami-0fa00f9c3aad25769"
  instance_type   = "t2.micro"
  key_name        = aws_key_pair.Semi1-key2.key_name
  security_groups = [aws_security_group.Semi1-instances-sg1.name]  # Use the security group by name

  tags = {
    Name = "Instancia-1"
  }
}

resource "aws_instance" "ec2_python_ht1" {
  ami             = "ami-0fa00f9c3aad25769"
  instance_type   = "t2.micro"
  key_name        = aws_key_pair.Semi1-key2.key_name
  security_groups = [aws_security_group.Semi1-instances-sg1.name]  # Use the security group by name

  tags = {
    Name = "Instancia-2"
  }
}
