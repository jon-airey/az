echo "\nresource groups"
az group list -o table

echo "\ncontainer registries"
az acr list -o table

echo "\ncontainer registry repositories"
az acr repository list --name rgaiAcr -o table

echo "\ncontainer registry repository tags"
az acr repository show-tags --name rgaiAcr --repository gemma3 --output table

echo "\nkubernetes clusters"
az aks list -o table

echo "\nkubernetes pods"
kubectl get pods

echo "\nsubscription deployments"
az deployment sub list --query "[].{name:name, state:properties.provisioningState, error:properties.error}" -o table

echo "\nresource group deployments"
az deployment group list --resource-group <rgName> -o table