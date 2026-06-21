# # condition ? true : false

# # resource "aws_instance" "prod_server" {
# #   ami                    = "ami-00403f401ee6a4b98"
# #   instance_type          = "t2.large"
# # #   count = var.isdev == false ? 3 : 0
# # tags = local.common_tags
# # }

# # variable "isdev" {}
# # locals {
# #   common_tags = {
# #     Owner = "Devops_Team"
# #     service = "frontend"
# #   }
# # }








# # resource "aws_instance" "dev_server" {
# #   ami                    = "ami-00403f401ee6a4b98"
# #   instance_type          = "t2.micro"
# # #   count = var.isdev == true ? 2 : 0
# #   tags = local.common_tags
# # }


# resource "null_resource" "local_exec" {
#   depends_on = [aws_instance.demo_server]

#   provisioner "local-exec" {
#     command = "echo ${aws_instance.demo_server.public_ip} > ec2-ip.txt"
#   }
# }

# resource "null_resource" "file_copy" {
#   depends_on = [aws_instance.demo_server]

#   connection {
#     type        = "ssh"
#     host        = aws_instance.demo_server.public_ip
#     user        = "ubuntu"
#     private_key = file("./jenkinsagent.pem")
#   }

#   provisioner "file" {
#     source      = "./ec2-ip.txt"
#     destination = "/home/ubuntu/ec2-ip.txt"
#   }
# }

# resource "null_resource" "remote_exec" {
#   depends_on = [aws_instance.demo_server]

#   connection {
#     type        = "ssh"
#     host        = aws_instance.demo_server.public_ip
#     user        = "ubuntu"
#     private_key = file("./jenkinsagent.pem")
#   }

#   provisioner "remote-exec" {
#     inline = [
#       "sudo apt update -y",
#       "sudo apt install docker.io -y",
#       "sudo usermod -aG docker ubuntu",
#       "sudo systemctl start docker",
#       "sudo systemctl enable docker",
#       "sudo docker run -d -p 8080:8080 -p 50000:50000 --name jenkins-agent jenkins/agent:latest",
#       "sudo docker ps -a "
#     ]
#   }
# }