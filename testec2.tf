# resource "aws_instance" "virgnia_server" {
#   ami                    = "ami-00403f401ee6a4b98"
#   instance_type          = var.maps["ap-south-1"]
#   associate_public_ip_address = true
#   tags = {
#     Name = "dev-server"
#   }
# }

# variable "users" {
#     type = list
#     default = ["prasad", "srinivas", "moeed", "andy", "dennis", "vashi", "queeen"]
# }

# resource "aws_iam_user" "vagile_user" {
#   name = var.users[count.index]
#   path = "/system/"
#   count = 7
# }