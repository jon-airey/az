# set -x

echo '\nresource groups'
echo 'az group list --output table'
#echo 'az provider show \ --namespace Microsoft.Resources \ --query "resourceTypes[?resourceType=='resourceGroups'].apiVersions" \ -o json'
az provider show \
  --namespace Microsoft.Resources \
  --query "resourceTypes[?resourceType=='resourceGroups'].apiVersions" \
  -o json

echo '\ncontainer registries'
echo 'az acr list --output table'
#echo 'az provider show \ --namespace Microsoft.ContainerRegistry \ --query "resourceTypes[?resourceType=='registries'].apiVersions" \ -o json'
az provider show \
  --namespace Microsoft.ContainerRegistry \
  --query "resourceTypes[?resourceType=='registries'].apiVersions" \
  -o json

echo '\nkubernetes clusters'
echo 'az aks list --output table'
#echo 'az provider show \ --namespace Microsoft.ContainerService \ --query "resourceTypes[?resourceType=='managedClusters'].apiVersions" \ -o json'
az provider show \
  --namespace Microsoft.ContainerService \
  --query "resourceTypes[?resourceType=='managedClusters'].apiVersions" \
  -o json
