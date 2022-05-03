# Iowa Microsoft Azure User Group - Bicep Talk

## What is Bicep?

Bicep is a domain-specific language (DSL) that uses declarative syntax to deploy Azure resources.

<https://docs.microsoft.com/en-us/azure/azure-resource-manager/bicep/overview?tabs=bicep>

## 01 Bicep

Basic syntax and usage.

[azuredeploy.bicep](/01-Bicep/azuredeploy.bicep)

## Using this repo

This repo is primarily used for presenting, but you can deploy the samples if you like.
Change the name in [rg-name.txt](/rg-name.txt) to the name of your resource group.

Each directory contains a reference bicep file, and an empty azuredeploy bicep file.
The `azuredeploy.bicep` file will be used while presenting, with the reference file as a reference.

Each directory also contains a setup of helper scripts to setup and tear down resources.
These point at the empty `azuredeploy.bicep` files by default.
You can either point them at the `reference.bicep` file, or update `azuredeploy.bicep`.

As always, be sure to read the contents before executing anything!
