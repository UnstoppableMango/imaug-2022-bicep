param location string = resourceGroup().location
param numEndpoints int = 3

var contentToCompress = [
  'application/json'
  'application/xml'
]

resource accounts 'Microsoft.Storage/storageAccounts@2021-08-01' = [for i in range(0, numEndpoints): {
  name: 'stimaug03${i}'
  location: location
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
}]

resource cdn 'Microsoft.Cdn/profiles@2021-06-01' = {
  name: 'cdnp-imaug-03'
  location: location
  sku: {
    name: 'Standard_Microsoft'
  }

  resource endpoints 'endpoints' = [for i in range(0, numEndpoints): {
    name: 'cdne-imaug-03-${i}'
    location: location
    properties: {
      contentTypesToCompress: contentToCompress
      origins: [
        {
          name: 'default'
          properties: {
            originHostHeader: accounts[i].properties.primaryEndpoints.web
            hostName: accounts[i].properties.primaryEndpoints.web
          }
        }
      ]
    }
  }]
}
