param location string = resourceGroup().location
param name string

var sku = {
  tier: 'Basic'
  name: 'B1'
}

resource appPlan 'Microsoft.Web/serverfarms@2021-03-01' = {
  name: 'plan-${name}'
  location: location
  sku: sku
}

resource app 'Microsoft.Web/sites@2021-03-01' = {
  name: 'app-${name}'
  location: location
  properties: {
    serverFarmId: appPlan.id
  }

  resource appsettings 'config' = {
    name: 'appsettings'
    properties: {
      Environment: 'Development'
    }
  }
}

resource webSettings 'Microsoft.Web/sites/config@2021-03-01' = {
  name: '${app.name}/web'
  properties: {
    minTlsVersion: '1.2'
  }
}

output environment string = app::appsettings.properties.Environment
