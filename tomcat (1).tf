terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }
}
provider "aws"{
access_key= ""
secret_key= ""
region= "ap-south-1"
}

resource "aws_instance" "Tomcat_conf" {
  ami           = "ami-01a4f99c4ac11b03c"
  instance_type = "t2.micro"
key_name= "project"
vpc_security_group_ids      = ["${aws_security_group.Tomcat_conf.id}"]
provisioner "file" {
    source      = "conf.sh"
    destination = "/tmp/conf.sh"
  }
provisioner "remote-exec"  {
    inline  = [
    "sudo yum install -y java",
    "sudo wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.71/bin/apache-tomcat-9.0.71.tar.gz",
    "sudo yum upgrade -y", 
    "sudo tar -xf apache-tomcat-9.0.71.tar.gz",
    "sudo sh /tmp/conf.sh",
    ]
}
connection {
    type         = "ssh"
        host         = self.public_ip
	    user         = "ec2-user"
	        private_key  = file("C:\\Users\\User\\Downloads\\project.pem" )
		   }
  tags = {
    "Name" = "Tomcat_conf"
  }
}
