# # Create a VPC
# # resource "aws_vpc" "vagile_vpc" {
# #   cidr_block = "10.0.0.0/16"
# #   tags = {
# #     Name = "dev-vpc"
# #   }
# # }


# # resource "aws_eip" "my_eip" {
# # #   domain = "vpc" 
# # # }

# # resource "aws_eip_association" "eip_assoc" {
# #   instance_id   = aws_instance.jenkins_server.id
# #   allocation_id = aws_eip.my_eip.id
# # }



# resource "aws_instance" "demo_server" {
#   provider = aws
#   ami                    = "ami-0b6d9d3d33ba97d99"
#   instance_type          = "t3.small"
#   associate_public_ip_address = true
#   key_name              = "jenkinsagent"
#   tags = {
#     Name = "dev-server"
#   }
# }

# resource "null_resource" "local_exec" {
#   depends_on = [aws_instance.demo_server]
#   provisioner "local-exec" {
#     command = "echo ${aws_instance.demo_server.public_ip} > public_ip.txt"
#   }
# }

# resource "null_resource" "copy_file" {
#     depends_on = [aws_instance.demo_server]

#     connection {
#         type        = "ssh"
#         host        = aws_instance.demo_server.public_ip
#         user        = "ubuntu"
#         private_key = file("./jenkinsagent.pem")
#     }
#     provisioner "file" {
#         source      = "./public_ip.txt"
#         destination = "/home/ubuntu/public_ip.txt"
#     }
# }

# resource "null_resource" "remote_exec" {
#     depends_on = [aws_instance.demo_server,]

#     connection {
#         type        = "ssh"
#         host        = aws_instance.demo_server.public_ip
#         user        = "ubuntu"
#         private_key = file("./jenkinsagent.pem")
#     }
#     provisioner "remote-exec" {
#         inline = [
#             "sudo apt update -y",
#             "sudo apt install -y docker.io ",
#             "sudo systemctl start docker",
#             "sudo systemctl enable docker",
#             "sudo docker run -d -p 8080:8080 -p 50000:50000 --name c-jenkins jenkins/jenkins:latest",
#             "sudo docker ps -a",
#             "sudo  docker logs c-jenkins"
#         ]
#     }
# }

resource "null_resource" "slack_notify" {

  provisioner "local-exec" {
    when = destroy

    interpreter = ["PowerShell", "-Command"]

    command = <<EOT
$body = @{
    text = "Terraform Destroy Completed Successfully"
} | ConvertTo-Json

Invoke-RestMethod `
    -Uri "https://hooks.slack.com/services/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" `
    -Method Post `
    -Body $body `
    -ContentType "application/json"
EOT
  }
}
