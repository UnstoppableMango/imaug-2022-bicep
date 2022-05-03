targetScope = 'subscription'

param location string = deployment().location
param name string

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: name
  location: location
}
