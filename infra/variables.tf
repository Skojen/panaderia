variable "project_id" {}
variable "region" {}
variable "db_instance_name" {}
variable "db_name" {}
variable "db_user" {}
variable "db_password" {}
variable "service_name" {}
variable "container_image" {}
variable "deployer_email" {}
variable "create_service_account" {
  type    = bool
  default = true
}