az deployment group create \
    --resource-group "$(cat ../rg-name.txt)" \
    --template-file azuredeploy.json \
    --parameters parameters.json \
    --mode Complete
