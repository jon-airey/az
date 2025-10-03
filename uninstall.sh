echo "deleting azure container registry rgaiAcr"
az acr delete --name rgaiAcr --resource-group rgai --yes

echo "deleting aks cluster rgaiAks"
az aks delete --name rgaiAks --resource-group rgai --yes --no-wait

echo "deleting resource group rgai"
az group delete --name rgai --yes --no-wait