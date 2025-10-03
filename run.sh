kubectl run acr-test \
  --image=rgaiAcr.azurecr.io/gemma3:latest \
  --restart=Never

kubectl expose pod acr-test \
  --type=LoadBalancer \
  --name=acr-test-svc \
  --port=80 \
  --target-port=8080
# kubectl delete service acr-test-svc

kubectl get svc acr-test-svc

kubectl get pods

kubectl get pod acr-test -w