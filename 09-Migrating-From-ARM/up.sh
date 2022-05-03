az deployment group create \
    --resource-group "$(cat ../rg-name.txt)" \
    --template-file azuredeploy.bicep \
    --parameters parameters.json \
    --mode Complete
