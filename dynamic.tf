# variable "sg_ports" {
#     type = list(number)
#     default = [22, 80, 443, 8080, 8081]
# }

# resource "aws_security_group" "dev_sg" {
#   name        = "dev-sg"
#   description = "Security group for development servers"

#   dynamic "ingress" {
#     for_each = var.sg_ports
#     content {
#       from_port   = ingress.value
#       to_port     = ingress.value
#       protocol    = "tcp"
#       cidr_blocks = ["0.0.0.0/0"]
#     }
#   }
# }