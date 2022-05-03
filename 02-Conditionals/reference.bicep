param location string = resourceGroup().location
param enableGit bool = false
param githubAccount string = ''
param githubRepo string = ''

resource dataFactory 'Microsoft.DataFactory/factories@2018-06-01' = {
  name: 'adf-imaug-02'
  location: location
  properties: {
    repoConfiguration: enableGit ? {
      type: 'FactoryGitHubConfiguration'
      accountName: githubAccount
      repositoryName: githubRepo
      collaborationBranch: 'main'
      rootFolder: '02-Conditionals'
    } : null
  }
}
