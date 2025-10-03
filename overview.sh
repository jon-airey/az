ACR_NAME=$(jq -r '.acrName.value' params.json)

echo "\nresource groups"
az group list -o table

echo "\ncontainer registries"
az acr list -o table

echo "\ncontainer registry repositories"
az acr repository list --name "$ACR_NAME" -o table

echo "\ncontainer registry repository tags"
az acr repository show-tags --name "$ACR_NAME" --repository gemma3 --output table

echo "\nkubernetes clusters"
az aks list -o table

echo "\nkubernetes pods"
kubectl get pods
