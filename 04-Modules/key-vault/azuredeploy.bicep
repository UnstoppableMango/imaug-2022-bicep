param location string = resourceGroup().location
param name string
param readerIds array = []
param contributorIds array = []
param ownerIds array = []

var readerPermissions = [
  'get'
  'list'
]

var contributorPermissions = [
  'get'
  'list'
  'set'
]

var ownerPermissions = [
  'backup'
  'delete'
  'get'
  'list'
  'recover'
  'restore'
]

var readerPolicies = [for id in readerIds: {
  objectId: id
  tenantId: subscription().tenantId
  permissions: {
    certificates: readerPermissions
    secrets: readerPermissions
  }
}]

var contributorPolicies = [for id in contributorIds: {
  objectId: id
  tenantId: subscription().tenantId
  permissions: {
    certificates: contributorPermissions
  }
}]

var ownerPolicies = [for id in ownerIds: {
  objectId: id
  tenantId: subscription().tenantId
  permissions: {
    certificates: concat(ownerPermissions, [
      'create'
      'import'
      'update'
    ])
    secrets: concat(ownerPermissions, [
      'set'
    ])
  }
}]

var policies = concat(readerPolicies, contributorPolicies, ownerPolicies, [
  {
    // Microsoft Azure WebSites Resource Provider Service Principal
    objectId: 'abfa0a7c-a6b6-4736-8310-5855508787cd'
    tenantId: subscription().tenantId
    permissions: {
      secrets: [
        'get'
      ]
    }
  }
])

resource keyVault 'Microsoft.KeyVault/vaults@2021-11-01-preview' = {
  name: name
  location: location
  properties: {
    sku: {
      family: 'A'
      name: 'standard'
    }
    tenantId: subscription().tenantId
  }

  resource accessPolicies 'accessPolicies' = {
    name: 'add'
    properties: {
      accessPolicies: policies
    }
  }
}

output uri string = keyVault.properties.vaultUri
