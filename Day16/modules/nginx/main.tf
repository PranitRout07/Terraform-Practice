
resource "docker_image" "nginx" {
  name         = "nginx"
  keep_locally = false
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.image_id
  name  = "nginx"

  ports {
    internal = var.internal_ip
    external = var.external_ip
  }
}
