# Iowa Microsoft Azure User Group - Bicep Talk

Infrastructure as code with Bicep and migrating from ARM.

This talk assumes a loose knowledge of Azure Resource Manager (ARM) templates and Infrastructure as Code (IaC).

## What is Bicep?

Bicep is a domain-specific language (DSL) that uses declarative syntax to deploy Azure resources.

<https://docs.microsoft.com/en-us/azure/azure-resource-manager/bicep/overview?tabs=bicep>

## Tooling

The Bicep CLI is the primary driver for working with `.bicep` files.
It can be installed multiple ways, but if you already have the Azure CLI you can install bicep from there.

```shell
az bicep install
```

More installation options can be found in the [docs](https://docs.microsoft.com/en-us/azure/azure-resource-manager/bicep/install).

To get the best development experience, use [VSCode](https://code.visualstudio.com/) and install the [Bicep extension](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-bicep).
This will enable syntax highlighting, intellisense, navigation, and linting all in the editor.

## 01 Bicep

Basic syntax and usage.

Parameters

```bicep
param name string = 'imaug-01'
```

Variables

```bicep
var appName = 'app-imaug-01'
```

Resources

```bicep
resource app 'Microsoft.Web/sites@2021-03-01' = {
    // ...
}
```

Strings

```bicep
var appName = 'app-${name}'
```

Functions

```bicep
param location string = resourceGroup().location
```

Outputs

```bicep
output appUrl string = myApp.properties.defaultHostName
```

<https://docs.microsoft.com/en-us/azure/azure-resource-manager/bicep/file>

## 02 Conditionals

`if` statements

```bicep
resource app 'Microsoft.Web/sites@2021-03-01' if (shouldDeploy) {
    // ...
}
```

Ternaries

```bicep
var name = location == 'eastus2' ? 'in-the-east' : 'not-in-the-east'
```

<https://docs.microsoft.com/en-us/azure/azure-resource-manager/bicep/conditional-resource-deployment>

## 03 Loops

Arrays

```bicep
var numArray = [
    1
    2
    3
]
```

Resource loop

```bicep
resource accounts 'Microsoft.Storage/storageAccounts@2021-08-01' = [for i in numArray: {
    // ...
}]
```

Using resource arrays

```bicep
var accountNames = [for i in numArray: accounts[i].name]
```

<https://docs.microsoft.com/en-us/azure/azure-resource-manager/bicep/loops>

## 04 Modules

Modules

```bicep
module keyVaultDeployment 'key-vault.bicep' = {
    // ...
}
```

Module outputs

```bicep
// key-vault.bicep
output uri string = vault.properties.vaultUri

// azuredeploy.bicep
var vaultUri = keyVaultDeployment.outputs.uri
```

<https://docs.microsoft.com/en-us/azure/azure-resource-manager/bicep/modules>

## 05 Linting

Bicep comes with a linter and can be used with `bicep build` or the [VSCode Extension](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-bicep).
The default rules at the time of writing are taken from [arm-ttk test cases](https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/template-test-cases).

<https://docs.microsoft.com/en-us/azure/azure-resource-manager/bicep/linter>

## 06 Migrating from ARM

<https://docs.microsoft.com/en-us/azure/azure-resource-manager/bicep/migrate>

## Using this repo

This repo is primarily used for presenting, but you can deploy the samples if you like.
Change the name in [rg-name.txt](/rg-name.txt) to the name of your resource group.

Each directory contains a reference bicep file, and an empty azuredeploy bicep file.
The `azuredeploy.bicep` file will be used while presenting, with the reference file available in case I screw something up.

Each directory also contains a setup of helper scripts to setup and tear down resources.
These point at the empty `azuredeploy.bicep` files by default.
You can either point them at the `reference.bicep` file, or update `azuredeploy.bicep`.

As always, be sure to verify the contents yourself before executing anything!
