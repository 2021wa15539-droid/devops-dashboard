variable "region" {
  default = "ap-south-1"
}
variable "cluster_name" {
  default = "devops-dashboard-cluster"
}
variable "vpc_id" {}
variable "subnet_ids" {
  type = list(string)
}
