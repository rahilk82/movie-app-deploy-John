resource "aws_instance" "test" {
  ami           = "ami-0694d931cee176e7d" # Specify the Ubuntu 22.04 AMI ID
  instance_type = "t2.micro"
  key_name      = "john" # Specify your key pair name

  tags = {
    Name = "Ubuntu-22.04-Nginx-Instance"
  }

  provisioner "file" {
    source      = "/home/rahil/Rahil/John/Test/app.zip" # Specify the path to your local zip file
    destination = "/home/ubuntu/app.zip"                # Specify the destination path on the remote instance
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      "sudo apt install -y nginx",
      "sudo apt install -y unzip",
      "unzip /home/ubuntu/app.zip",
      "mv Online_Movie_Registration_Form app",
      "sudo cp /home/ubuntu/app/index.html /var/www/html/",
      "sudo cp /home/ubuntu/app/thankyou.html /var/www/html/" # Unzip the file
    ]
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("/home/rahil/Downloads/john.pem") # Use the key pair name as the private key
    host        = aws_instance.test.public_ip
  }

  provisioner "file" {
    source      = "/home/rahil/Rahil/John/Test/app.zip" # Specify the path to your local zip file
    destination = "/home/ubuntu/app.zip"                # Specify the destination path on the remote instance
  }
}
