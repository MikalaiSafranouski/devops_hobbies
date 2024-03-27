
### Connect to a EKS cluster

```
    aws eks update-kubeconfig --name hobbies-cluster --region eu-north-1 --profile mikalai-admin
```

```
alias k=kubectl
```

### Install HA-argocd
Get installation file, specify the version of argocd...I use v.2.10.4(latest)
```
wget https://raw.githubusercontent.com/argoproj/argo-cd/v2.10.4/manifests/ha/install.yaml
```
Apply downloaded `install.yaml` file in namespace `argocd`
```angular2html
kubectl apply -f install.yaml -n argocd
```
Argocd server (UI) accessible via port-forwarding:
```angular2html
kubectl port-forward svc/argocd-server -n argocd 9090:443
```

### Change argocd-server being accessible on port 80:
Apply `argocd-cm-patch.yaml` to set insecure mode for server
```angular2html
kubectl apply -f argocd-cm-patch.yaml -n argocd
```

### Set up domain name for Argocd UI


#### Ingress and ingress controller installation
Resources: 
 - https://kubernetes.github.io/ingress-nginx/deploy/
 - https://kubernetes.github.io/ingress-nginx/deploy/#aws


Ingress controller installation as NETWORK LOAD BALANCER (NLB):
```
kubectl create namespace ingress-nginx
wget 
## Ingress and ingress controller installation
Resources: 
 - https://kubernetes.github.io/ingress-nginx/deploy/
 - https://kubernetes.github.io/ingress-nginx/deploy/#aws


Ingress controller installation -> NETWORK LOAD BALANCER (NLB):


kubectl create namespace ingress-nginx
wget https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.10.0/deploy/static/provider/aws/nlb-with-tls-termination/deploy.yaml
```

1. Edit the file and change the VPC CIDR in use for the Kubernetes cluster:

```
proxy-real-ip-cidr: XXX.XXX.XXX/XX
```

2. Change the AWS Certificate Manager (ACM) ID as well:

```
arn:aws:acm:us-west-2:XXXXXXXX:certificate/XXXXXX-XXXXXXX-XXXXXXX-XXXXXXXX
```

Deploy the manifest:

```
kubectl apply -f deploy.yaml -n ingress-nginx
```

Check ingress-controller is running in ingress-nginx namespace:

```
kubectl get pod -n ingress-nginx
```

In order to delete resources in `ingress-nginx` namespace:

```
kubectl delete all  --all -n ingress-nginx
```

### Create Ingress for Argocd UI
Apply `argo-ingress.yaml` manifest to route traffic to `argocd.mikalaika.fun` domain name

```angular2html
kubectl apply -f argo-ingress.yaml
```
Because we changed configuration to accept insecure requests we also need restart our ArgoCD deployment to get this configuration.
```angular2html
kubectl rollout restart deploy argocd-server -n argocd
```

#### 
Get default password for `admin`:
```angular2html
argocd admin initial-password -n argocd
```

### Install Argo Rollouts
```angular2html
kubectl create namespace argo-rollouts
kubectl apply -n argo-rollouts -f https://github.com/argoproj/argo-rollouts/releases/download/v1.2.2/install.yaml
```

### Run Argo application
```angular2html
kubectl apply -f argocd-app.yaml -n argocd
```
















