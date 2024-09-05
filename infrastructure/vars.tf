variable "AWS_ACCESS_KEY" {
  default = "AQUI PEGAN SU CLAVE DE ACCESO DE AWS"
}

variable "AWS_SECRET_KEY" {
  default = "AQUI PEGAN SU CLAVE DE ACCESO DE AWS"
}

variable "AWS_REGION" {
  description = "The AWS region where resources will be created"
}

variable "user_ssh" {
  description = "Username for SSH access"
}

variable "PATH_KEYPAIR" {
  description = "Path to the private key file"
}

variable "PATH_PUBLIC_KEYPAIR" {
  description = "Path to the public key file"
}

variable "DATABASE_PASSWORD" {
  description = "Database password"
}

variable "DATABASE_USER" {
  description = "Database username"
}

variable "DATABASE_NAME" {
  description = "Database name"
}
