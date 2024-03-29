# # Deploys the Video streaming microservice to the Kubernetes cluster.
# #---------------------------------------------------------------------#
# # push 까지의 자동화
# #---------------------------------------------------------------------#
# locals {
#   service_name = "video-streaming"
#   login_server = azurerm_container_registry.container_registry.login_server
#   username     = azurerm_container_registry.container_registry.admin_username
#   password     = azurerm_container_registry.container_registry.admin_password
#   image_tag    = "${local.login_server}/${local.service_name}:${var.app_version}"
# }

# resource "null_resource" "docker_build" {

#   triggers = {
#     always_run = timestamp()
#   }

#   provisioner "local-exec" {
#     command = "docker build -t ${local.image_tag} --file ../${local.service_name}/Dockerfile-prod ../${local.service_name}"
#   }
# }

# resource "null_resource" "docker_login" {

#   depends_on = [null_resource.docker_build]

#   triggers = {
#     always_run = timestamp()
#   }

#   provisioner "local-exec" {
#     command = "docker login ${local.login_server} --username ${local.username} --password ${local.password}"
#   }
# }

# resource "null_resource" "docker_push" {

#   depends_on = [null_resource.docker_login]

#   triggers = {
#     always_run = timestamp()
#   }

#   provisioner "local-exec" {
#     command = "docker push ${local.image_tag}"
#   }
# }
# #---------------------------------------------------------------------#
# # 컨테이너 레지스트리 인증 자동화
# #---------------------------------------------------------------------#
# locals {
#   dockercreds = {
#     auths = {
#       "${local.login_server}" = {
#         auth = base64encode("${local.username}:${local.password}")
#       }
#     }
#   }
# }

# resource "kubernetes_secret" "docker_credentials" {
#   metadata {
#     name = "docker-credentials"
#   }

#   data = {
#     ".dockerconfigjson" = jsonencode(local.dockercreds)
#   }

#   type = "kubernetes.io/dockerconfigjson"
# }
# #---------------------------------------------------------------------#
# # 마이크로 서비스 배포 자동화
# #---------------------------------------------------------------------#
# resource "kubernetes_deployment" "service_deployment" {

#   depends_on = [null_resource.docker_push]

#   metadata {
#     name = local.service_name

#     labels = {
#       pod = local.service_name
#     }
#   }

#   spec {
#     replicas = 1

#     selector {
#       match_labels = {
#         pod = local.service_name
#       }
#     }

#     template {
#       metadata {
#         labels = {
#           pod = local.service_name
#         }
#       }

#       spec {
#         container {
#           image = local.image_tag
#           name  = local.service_name

#           env {
#             name  = "PORT"
#             value = "80"
#           }
#         }

#         image_pull_secrets {
#           name = kubernetes_secret.docker_credentials.metadata[0].name
#         }
#       }
#     }
#   }
# }

# resource "kubernetes_service" "service" {
#   metadata {
#     name = local.service_name
#   }

#   spec {
#     selector = {
#       pod = kubernetes_deployment.service_deployment.metadata[0].labels.pod
#     }

#     session_affinity = "ClientIP"

#     port {
#       port        = 80
#       target_port = 80
#     }

#     type = "LoadBalancer"
#   }
# }
