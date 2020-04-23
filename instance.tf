resource "aws_instance" "amazonLinux" {
  ami           = "ami-0fc61db8544a617ed"
  instance_type = "t2.micro"
  tags = {
    Auto-StartStop-Enabled= "yes"
  }
  
 }




