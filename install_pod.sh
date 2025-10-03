echo "installing resources"

export ACR_NAME=$(jq -r '.acrName.value' params.json)
export DOCKER_IMGNAME='gemma3:latest'
export APP_NAME='sig-parser'

echo 'ACR_NAME:' $ACR_NAME
echo 'DOCKER_IMGNAME:' $DOCKER_IMGNAME
echo 'APP_NAME:' $APP_NAME

# ------------------------------
# Deploy workload to AKS
# ------------------------------
echo "=== Deploying workload to AKS ==="
# envsubst < sigparser-private-template.yaml
# envsubst < sigparser-private-template.yaml | kubectl apply -f -
envsubst < sigparser-public-template.yaml | kubectl apply -f -

# ------------------------------
# Summary
# ------------------------------
echo "✅ Deployment complete!"
kubectl get pods
kubectl get svc