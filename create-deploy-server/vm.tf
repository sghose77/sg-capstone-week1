data "aws_ami" "deploy-server" {
  most_recent = true

  filter {
    name   = "name"
    values = ["sg-week1-capstone-*"]
  }
  
  owners = ["self"]
  
}


resource "aws_instance" "vm" {
  ami           = data.aws_ami.deploy-server.id
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.allow-ssh.id]
  tags = {
    Name = "deploy-server-capstone-week1"
  }
}
