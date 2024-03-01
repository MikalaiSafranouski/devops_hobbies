username    = "admin"
password    = "IR4sfKRfpOM-Rpfr"
server_addr = "localhost:9000"
namespace   = "argocd"

destination_server    = "https://kubernetes.default.svc"
destination_namespace = "terraform"

repo_url        = "https://github.com/MikalaiSafranouski/devops_hobbies.git"
path            = "argocd/nginx_application/helm/nginx"
target_revision = "main"

values_files = ["custom-values.yaml"]
insecure     = true
