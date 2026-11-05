variable "region" {
  description = "Région AWS de déploiement"
  type        = string
  default     = "eu-north-1"
}

variable "environment" {
  description = "Nom de l'environnement"
  type        = string
  default     = "lab"
}

variable "vpc_cidr" {
  description = "Plage d'adresses du VPC"
  type        = string
  default     = "10.20.0.0/16"
}
