# provider "docker" {
#   host = "unix:///var/run/docker.sock"
# }

# resource "docker_image" "mysql" {
#   name = "mysql:latest"
# }

# resource "docker_container" "mysql" {
#   name  = "mysql-db"
#   image = docker_image.mysql.image_id
#   env = [
#     "MYSQL_ROOT_PASSWORD=example", # Set your root password here
#     "MYSQL_DATABASE=example",      # Name of the database to create
#     "MYSQL_USER=example",          # Username for the database
#     "MYSQL_PASSWORD=example"       # Password for the user
#   ]
#   ports {
#     internal = 3306
#     external = 3306
#   }
# }
