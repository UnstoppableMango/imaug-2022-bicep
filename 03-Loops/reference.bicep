param location string = resourceGroup().location
param numContainers int = 3

resource account 'Microsoft.Storage/storageAccounts@2021-08-01' = {
  name: 'stimaug03'
  location: location
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
  
  resource blob 'blobServices' = {
    name: 'default'

    resource container 'containers' = [for i in range(0, numContainers): {
      name: 'container-${i}'
    }]
  }
}
