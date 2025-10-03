ACR_NAME=$(jq -r '.acrName.value' params.json)
DOCKERFILE=$(jq -r '.dockerFile.value' params.json)
DOCKERIMGNAME=$(jq -r '.dockerImgName.value' params.json)

az acr build \
  --registry "$ACR_NAME" \
  --image "$DOCKERIMGNAME" \
  --file "$DOCKERFILE" \
  .

az acr repository list --name rgaiAcr --output table