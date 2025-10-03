set -x

echo "cleaing subscription deployments"
az deployment sub delete --name main 

echo "cleaning resource group deployments"
az deployment group delete --resource-group rgai --name main 