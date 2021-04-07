job "myproject-static-prod" {
  datacenters = [
    "dc1"
  ]

  priority = 80

  constraint {
    attribute = "${meta.client_id}"
    value = "main_client"
  }

  group "myproject-static-prod" {
    count = 1

    task "myproject-static-prod" {
      driver = "docker"

      vault {
        policies = [
          "nomad-server"
        ]
      }

      config {
        image = "$DOCKER_REGISTRY/$DOCKER_IMAGE_STATIC:$CI_COMMIT_SHORT_SHA"

        ports = ["http"]

        volumes = [
          "/opt/myproject-backend/prod/media:/usr/share/nginx/html/media:ro"
        ]

        auth {
          username = "${REGISTRY_LOGIN}"
          password = "${REGISTRY_PASSWORD}"
          server_address = "$DOCKER_REGISTRY"
        }
      }

      template {
        data = <<EOH
{{ with secret "registry/gitlab" }}
REGISTRY_LOGIN="{{ .Data.data.USERNAME }}"
REGISTRY_PASSWORD="{{ .Data.data.PASSWORD }}"
{{ end }}
EOH

        destination = "secrets/environment.env"
        env = true
      }

      resources {
        cpu = 200
        memory = 50
      }
    }

    network {
      port "http" {
        static = 8091
        to = 80
      }
    }
  }
}
