job "myproject-backend-dev" {
  datacenters = [
    "dc1"
  ]

  priority = 60

  constraint {
    attribute = "${meta.client_id}"
    value = "main_client"
  }

  group "myproject-backend-dev" {
    count = 1

    task "myproject-backend-dev" {
      driver = "docker"

      user = "1000:1000"

      vault {
        policies = [
          "nomad-server"
        ]
      }

      config {
        image = "$DOCKER_REGISTRY/$DOCKER_IMAGE:$CI_COMMIT_SHORT_SHA"
        entrypoint = [
          "./scripts/run-start.sh"
        ]

        ports = ["http"]

        volumes = [
          "/opt/myproject-backend/dev/media:/project/media"
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
{{ with secret "myproject/dev" }}
DB_HOST="{{ .Data.data.DB_HOST }}"
DB_DRIVER="{{ .Data.data.DB_DRIVER }}"
DB_USERNAME="{{ .Data.data.DB_USERNAME }}"
DB_PASSWORD="{{ .Data.data.DB_PASSWORD }}"
DB_NAME="{{ .Data.data.DB_NAME }}"
APP_DEBUG="{{ .Data.data.DEBUG }}"

SECRET_KEY="{{ .Data.data.SECRET_KEY }}"
CELERY_BROKER_URL="{{ .Data.data.CELERY_BROKER_URL }}"

PE_TOKEN="{{ .Data.data.PE_TOKEN }}"
PE_URL="{{ .Data.data.PE_URL }}"

EMAIL_HOST="{{ .Data.data.EMAIL_HOST }}"
EMAIL_PORT="{{ .Data.data.EMAIL_PORT }}"
EMAIL_HOST_USER="{{ .Data.data.EMAIL_HOST_USER }}"
EMAIL_HOST_PASSWORD="{{ .Data.data.EMAIL_HOST_PASSWORD }}"
EMAIL_USE_TLS="{{ .Data.data.EMAIL_USE_TLS }}"
EMAIL_TO="{{ .Data.data.EMAIL_TO }}"
{{ end }}
EOH

        destination = "secrets/environment.env"
        env = true
      }

      resources {
        cpu = 250
        memory = 250
      }
    }

    network {
      port "http" {
        static = 10001
        to = 8000
        host_network = "public"
      }
    }

  }
}
