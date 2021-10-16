# Practice Nginx + PHP-FPM

## Configure

1. Build docker image with command: `docker build -t hands-on:v1 ./`
2. Load image into minikube: `minikube image load hands-on:v1`
3. Deploy it with command: `kubectl create ns myapp && kubectl apply -f k8s/deployment.yaml`
4. View all resource with command: `kubectl get all -n myapp`
5. Access it from local browser "http://localhost:8080/" with command: `kubectl port-forward svc/nginx-phpfpm-service 8080:80`
