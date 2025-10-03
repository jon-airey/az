echo "validating template"

az deployment sub validate \
  --location eastus \
  --template-file main.bicep \
  --parameters @params.json \
  --out table \
  --debug