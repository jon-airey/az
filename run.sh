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

#  kubectl get pods                                                                                                                                              3s ○ rgaiAks 18:03:58 
# NAME       READY   STATUS             RESTARTS   AGE
# acr-test   0/1     ImagePullBackOff   0          2m50s
# /mnt/c/dev/projects/az ❯ kubectl delete                                                                                                                                                4s ○ rgaiAks 18:04:20 
# error: You must provide one or more resources by argument or filename.
# Example resource specifications include:
#    '-f rsrc.yaml'
#    '--filename=rsrc.json'
#    '<resource> <name>'
#    '<resource>'
# /mnt/c/dev/projects/az ❯ kubectl delete acr-test                                                                                                                                          ○ rgaiAks 18:04:31 
# error: the server doesn't have a resource type "acr-test"
# /mnt/c/dev/projects/az ❯ kubectl delete pod acr-test                                                                                                                                      ○ rgaiAks 18:04:43 
# pod "acr-test" deleted from default namespace