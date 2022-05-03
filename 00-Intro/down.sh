az deployment group create \
    --resource-group "$(cat ../rg-name.txt)" \
    --template-file ../util/empty.bicep \
    --mode Complete
