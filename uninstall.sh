RG_NAME=$(jq -r '.rgName.value' params.json)
ACR_NAME=$(jq -r '.acrName.value' params.json)
AKS_NAME=$(jq -r '.aksName.value' params.json)

echo "deleting azure container registry $ACR_NAME"
az acr delete --name $ACR_NAME --resource-group $RG_NAME --yes

echo "deleting aks cluster $AKS_NAME"
az aks delete --name $AKS_NAME --resource-group $RG_NAME --yes --no-wait

echo "deleting resource group $RG_NAME"
az group delete --name $RG_NAME --yes --no-wait