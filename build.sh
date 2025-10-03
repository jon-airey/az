az acr build \
  --registry rgaiAcr \
  --image gemma3:latest \
  --file gemma3.dockerfile \
  .

az acr repository list --name rgaiAcr --output table