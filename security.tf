data "aws_ec2_managed_prefix_list" "s3" {
  name = "com.amazonaws.${var.region}.s3"
}

resource "aws_security_group" "app" {
  name        = "${var.environment}-app-sg"
  description = "Aucun flux entrant ; administration via SSM Session Manager"
  vpc_id      = aws_vpc.main.id

  tags = { Name = "${var.environment}-app-sg" }
}

resource "aws_vpc_security_group_egress_rule" "vpc_https" {
  security_group_id = aws_security_group.app.id
  description       = "HTTPS vers les endpoints VPC interface pour agent SSM"
  cidr_ipv4         = var.vpc_cidr
  ip_protocol       = "tcp"
  from_port         = 443
  to_port           = 443
}

resource "aws_vpc_security_group_egress_rule" "s3_https" {
  security_group_id = aws_security_group.app.id
  description       = "HTTPS vers S3 via endpoint gateway pour depots AL2023"
  prefix_list_id    = data.aws_ec2_managed_prefix_list.s3.id
  ip_protocol       = "tcp"
  from_port         = 443
  to_port           = 443
}
