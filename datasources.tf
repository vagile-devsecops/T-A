


# data "aws_ami" "amz_ami" {
#     most_recent = true
#     owners = ["amazon"]
#     filter {
#         name = "name"
#         values = ["amzn2-ami-hvm*"]
#     }
# }


# resource "aws_instance" "dev_server" {
#   ami                    = data.aws_ami.amz_ami.id
#   instance_type          = "t2.micro"
# #   count = var.isdev == true ? 2 : 0
# #   tags = local.common_tags
# }
