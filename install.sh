echo "installing resources"

az deployment sub create \
  --location eastus \
  --template-file main.bicep \
  --parameters @params.json

az aks update -g rgai -n rgaiAks --attach-acr rgaiAcr  
