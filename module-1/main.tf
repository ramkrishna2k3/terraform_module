terraform {
  required_version = ">=0.12"
}

resource "aws_instance" "ec2_example" {

    ami = var.ami_id
    instance_type = var.web_instance_type
    key_name= aws_key_pair.deployer.key_name
    vpc_security_group_ids = [aws_security_group.main.id]

  user_data = <<-EOF
      #!/bin/sh
      sudo yum update
      sudo yum install -y httpd
      sudo systemctl status httpd
      sudo systemctl start httpd
      sudo chown -R $USER:$USER /var/www/html
      sudo echo "<html><body><h1>Hello this is module-1 at instance id `curl http://169.254.169.254/latest/meta-data/instance-id` </h1></body></html>" > /var/www/html/index.html
      EOF
}

resource "aws_security_group" "main" {
    name        = "EC2-webserver-SG-1"
  description = "Webserver for EC2 Instances"

  ingress {
    from_port   = 80
    protocol    = "TCP"
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    protocol    = "TCP"
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "deployer" {
    key_name   = "aws_key"
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQD2HbxMfntiX5YETZCEIy/w8qu/YGl4COKfGdb0W13BrkoDuVMczRTYD/uEY5QtHXj7VwBKygXS/nDmLirTtyLxKRAGW696exl9Yy5zdAHL+4oj3eTIe+1z1nnSwl5h4OK1wV6sLYMgwXVDuePFomOpkp7TZE1v6g1rc1ksj//XtK0cTnq1lF2R8yIw5+zSDI1j4YMkOvzIRGwvTfoj0sr4cGFbjFFy7WEEivINMM8kTQTmDv/q7FaWq3SY+b9EXh0odlgT/5ap57uY9ASCOO5qXYHpZQADFqDP2RlxJxTgYuNDqeNczFHyT/dYAMpuDi7mI/GCHTM7Sw16RBlrcXkJ root@ip-172-31-43-236.ap-south-1.compute.internal"
}