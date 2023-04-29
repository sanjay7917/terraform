# variable "rds_endpoint" {
#   type = string  
# }
variable "rds_username" {
  description = "Database administrator username"
  type        = string
  default     = "admin"
}

variable "rds_password" {
  description = "Database administrator password"
  type        = string
  default     = "Admin123"
}
