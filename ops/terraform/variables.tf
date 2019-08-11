
variable "do_access_token" {
    type = "string"
}

variable "do_region" {
    type = "string"
}

variable "backend_pod_name" {
    default = "backend"
    type    = "string"
}

variable "backend_pod_image" {
    default = "edenr/backend:latest"
    type    = "string"
}

variable "backend_service_name" {
    default = "backend"
    type    = "string"
}

variable "cluster_node_count" {
    default = "1"
    type    = "string"
}

variable "deployment_replicas_count" {
    default = "1"
    type    = "string"
}

variable "mysql_password" {
    type = "string"
}


