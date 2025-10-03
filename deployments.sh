RG_NAME=$(jq -r '.rgName.value' params.json)
DP_NAME=$(jq -r '.dpName.value' params.json)

echo "\nsubscription deployments"
az deployment sub list --query "[].{name:name, state:properties.provisioningState, error:properties.error}" -o table

# az deployment sub show \
#   --name "$DP_NAME" \
#   -o json

echo "\nresource group deployments"
az deployment group list --resource-group "$RG_NAME" -o table

# az deployment sub delete --name "$RG_NAME"