@secure()
param password string

@secure()
param adminPassword string = 'HardcodedPassword'

var managementURL = 'https://management.azure.com'
var name = concat('app-', 'imaug-05')

resource vm 'Microsoft.Compute/virtualMachines@2020-12-01' = {
  name: name
  location: 'East US 2'
  properties: {
    osProfile: {
      adminUsername: 'adminUsername'
    }
    storageProfile: {
      imageReference: {
        offer: 'WindowsServer-preview'
        sku: '2019-Datacenter-preview'
        version: 'preview'
      }
    }
  }
}

resource appServicePlan 'Microsoft.Web/serverfarms@2020-12-01' = {
  name: '${name}'
  location: resourceGroup().location
  sku: {
    name: 'F1'
    capacity: 1
  }
}

resource webApplication 'Microsoft.Web/sites@2018-11-01' = {
  name: '${name}'
  location: resourceGroup().location
  properties: {
    serverFarmId: appServicePlan.id
  }
  dependsOn: [
    appServicePlan
  ]
}

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-06-01' existing = {
  name: name
}

resource customScriptExtension 'Microsoft.HybridCompute/machines/extensions@2019-08-02-preview' = {
  name: '${vm.name}/CustomScriptExtension'
  location: 'Brazil South'
  properties: {
    publisher: 'Microsoft.Compute'
    type: 'CustomScriptExtension'
    autoUpgradeMinorVersion: true
    settings: {
      fileUris: split('a uri', ' ')
      commandToExecute: 'mycommand ${storageAccount.listKeys().keys[0].value}'
    }
  }
}

output input string = password
output password string = ''
