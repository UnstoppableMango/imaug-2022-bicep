az deployment group validate \
    --resource-group "$(cat ../rg-name.txt)" \
    --template-file azuredeploy.json
