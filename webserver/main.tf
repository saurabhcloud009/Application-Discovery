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

resource "aws_key_pair" "tauhid" {
 key_name ="tauhid"
 public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCvWLP90s6xDqeQii5I4ftZsGsfeG9mj00MAFTlRhZeT1UIWvRYp9X2Fx5LzV26OkoDW8JoEkZfrfVYscc5YUO+22ar3dw+NYMnJRKl0XhJqwxK0dyuoDaLh+5YaGEHcbQwo6ntoTthXnegIhTrPsLMLy0ROmT1YIoFuvXSgGOYMiW+8Oh1UbrskI7cyfxPzrq4QSU0rOEa16paLvlK2sKRX//5LGPGzLPT47jhSrhIfbcYBgdRh9fC6dRkEyFZHp5JSDRDXwe5p5E8mMD5Br+X5npSvpLJBR9/bmPe5imi5NDpJoP34obIb92g8dscN3vg3ETIXCBdlQmAZiO/2Pt5 tauhid"
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
