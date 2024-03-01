

#### Delete all resources in a namespace
    
    kubectl delete all --all -n {namespace}


#### Get iniutial password 
    
    argocd admin initial-password -n argocd

#### Restart

    kubectl rollout restart deploy argocd-server -n argocd

####  Set default namespace to `argocd`

    alias k=kubectl
    k config set-context --current --namespace=argocd


#### 

    kubectl port-forward svc/argocd-server -n argocd 9000:443

### Get project

    kubectl get appproject -n argocd



















