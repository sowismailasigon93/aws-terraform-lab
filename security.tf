resource "aws_security_group" "app" {
  name        = "${var.environment}-app-sg"
  description = "Aucun flux entrant ; administration via SSM Session Manager"
  vpc_id      = aws_vpc.main.id

  tags = { Name = "${var.environment}-app-sg" }
}

# Sortie HTTPS uniquement : requis par l'agent SSM
resource "aws_vpc_security_group_egress_rule" "https" {
  security_group_id = aws_security_group.app.id
  description       = "HTTPS sortant pour agent SSM et les mises a jour"
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "tcp"
  from_port         = 443
  to_port           = 443
}

resource "aws_vpc_security_group_egress_rule" "http" {
  security_group_id = aws_security_group.app.id
  description       = "HTTP sortant pour les depots de paquets"
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "tcp"
  from_port         = 80
  to_port           = 80
}
