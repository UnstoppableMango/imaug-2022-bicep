param location string = resourceGroup().location

module keyVaultDeployment 'key-vault/azuredeploy.bicep' = {
  name: '${deployment().name}-keyvault'
  params: {
    name: 'key-imaug-04'
    location: location
  }
}

output keyVaultUri string = keyVaultDeployment.outputs.uri
