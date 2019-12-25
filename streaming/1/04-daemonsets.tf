resource "kubernetes_daemonset" "fluentd" {
  metadata {
    name = "fluentd"
    namespace = "kube-system"
    labels {
      test = "fluentd"
    }
  }

  spec {
    selector {
      match_labels {
        test = "fluentd"
      }
    }

    template {
      metadata {
        labels {
          test = "fluentd"
        }
      }

      spec {

        volume {
          name = "varlog"
          host_path { 
            path = "/var/log" 
          }
        }

        volume {
          name = "varlibdockercontainers"
          host_path {
            path = "/var/lib/docker/containers"
          }
        }

        container {
          image = "garland/kubernetes-fluentd-loggly:1.0"
          name  = "fluentd-es"

          volume_mount {
            name = "varlog"
            mount_path = "/var/log"
          }

          volume_mount {
            name = "varlibdockercontainers"
            mount_path = "/var/lib/docker/containers"
            read_only = true
          }

          command = [ "/bin/sh", "-c", "/usr/sbin/td-agent 2>&1 >> /var/log/fluentd.log" ]

          env {
            name = "LOGGLY_URL"
            value = "https://logs-01.loggly.com/inputs/reemplazar-con-token/tag/k8"
          }

          resources{
            limits{
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests{
              cpu    = "250m"
              memory = "50Mi"
            }
          }
        }
      }
    }
  }
}
