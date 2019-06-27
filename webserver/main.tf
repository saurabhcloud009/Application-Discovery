provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}


resource "aws_security_group" "instance" {
  name = "WebSecurity Group"
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  }

resource "aws_key_pair" "" {
 key_name ="tauhid"
 public_key = ""

}


resource "aws_instance" "web" {
  ami           = "ami-cfdafaaa"
  instance_type = "t2.micro"
  count = "1"
  key_name = "tauhid"

tags {
    Name = "test machines"
  }

user_data = <<HEREDOC
  #!/bin/bash
  yum update -y
  yum install -y httpd24 php56 php56-mysqlnd
  service httpd start
  chkconfig httpd on
HEREDOC
}
