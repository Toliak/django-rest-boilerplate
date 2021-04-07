ob "myproject-backend-migrate-dev" {
  datacenters = [
    "dc1"
  ]

  type = "batch"

  priority = 65

  constraint {
    attribute = "${meta.client_id}"
    value = "main_client"
  }

  group "myproject-backend-migrate-dev" {
    count = 1

    task "myproject-backend-migrate-dev" {
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
          "./scripts/run-prepare.sh"
        ]

        volumes = [
          "/opt/myproject-backend/dev/media:/project/media",
          "/opt/myproject-backend/dev/backups:/project/backups",
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
DB_DRIVER="{{ .Data.data.DB_DRIVER }}"
DB_HOST="{{ .Data.data.DB_HOST }}"
DB_NAME="{{ .Data.data.DB_NAME }}"
DB_PASSWORD="{{ .Data.data.DB_PASSWORD }}"
DB_USERNAME="{{ .Data.data.DB_USERNAME }}"
APP_DEBUG="{{ .Data.data.DEBUG }}"
CELERY_BROKER_URL="{{ .Data.data.CELERY_BROKER_URL }}"
SECRET_KEY="{{ .Data.data.SECRET_KEY }}"
PE_TOKEN="{{ .Data.data.PE_TOKEN }}"
{{ end }}
EOH

        destination = "secrets/environment.env"
        env = true
      }

      resources {
        cpu = 100
        memory = 100
      }
    }

    restart {
      attempts = 0
    }
  }
}
