az deployment sub create \
    --location "East US 2" \
    --template-file azuredeploy.bicep \
    --parameters name="$(cat ../rg-name.txt)"
