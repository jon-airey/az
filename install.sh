echo "installing resources"

RG_NAME=$(jq -r '.rgName.value' params.json)
LOCATION=$(jq -r '.location.value' params.json)
ACR_NAME=$(jq -r '.acrName.value' params.json)
AKS_NAME=$(jq -r '.aksName.value' params.json)
DEPLOY_NAME=$(jq -r '.deployName.value' params.json)

PROVISIONING_TIMEOUT=1800
DOCKER_FILE='gemma3.dockerfile'
DOCKER_IMGNAME='gemma3:latest'
HF_TOKEN=''
APP_NAME='sig-parser'

echo 'RG_NAME:' $RG_NAME
echo 'LOCATION:' $LOCATION
echo 'ACR_NAME:' $ACR_NAME
echo 'AKS_NAME:' $AKS_NAME

echo 'PROVISIONING_TIMEOUT:' $PROVISIONING_TIMEOUT
echo 'DOCKER_FILE:' $DOCKER_FILE
echo 'DOCKER_IMGNAME:' $DOCKER_IMGNAME
echo 'HF_TOKEN:' $HF_TOKEN
echo 'APP_NAME:' $APP_NAME
echo 'DEPLOY_NAME:' $DEPLOY_NAME

az deployment sub create \
  --name "$DEPLOY_NAME" \
  --location "$LOCATION" \
  --template-file main.bicep \
  --parameters @params.json \

echo "⏳ Waiting for subscription deployment to complete..."
az deployment sub wait \
  --name "$DEPLOY_NAME" \
  --created \
  --timeout "$PROVISIONING_TIMEOUT"  

# ------------------------------
# Connect AKS to ACR
# ------------------------------
az aks update -g "$RG_NAME" -n "$AKS_NAME" --attach-acr "$ACR_NAME"  

# ------------------------------
# Set AKS credentials
# ------------------------------
az aks get-credentials \
  --resource-group rgai \
  --name rgaiAks \
  --overwrite-existing

# ------------------------------
# Build and push Docker image to ACR
# ------------------------------
az acr build \
  --registry "$ACR_NAME" \
  --image "$DOCKER_IMGNAME" \
  --file "$DOCKER_FILE" \
  .

# ------------------------------
# Get AKS credentials
# ------------------------------
echo "=== Configuring kubectl for AKS ==="
kubectl create secret generic huggingface-secret \
  --from-literal=HF_TOKEN="$HF_TOKEN"

# ------------------------------
# Deploy workload to AKS
# ------------------------------
echo "=== Deploying workload to AKS ==="
kubectl apply -f - <<EOF
apiVersion: apps/v1
kind: Deployment
metadata:
  name: $APP_NAME
spec:
  replicas: 1
  selector:
    matchLabels:
      app: $APP_NAME
  template:
    metadata:
      labels:
        app: $APP_NAME
    spec:
      containers:
      - name: $APP_NAME
        image: $ACR_NAME.azurecr.io/$DOCKER_IMGNAME
        ports:
        - containerPort: 80
        env:
        - name: HF_TOKEN
          valueFrom:
            secretKeyRef:
              name: huggingface-secret
              key: HF_TOKEN
EOF

# ------------------------------
# Summary
# ------------------------------
echo "✅ Deployment complete!"
kubectl get pods
kubectl get svc