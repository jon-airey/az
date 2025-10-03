targetScope = 'subscription'

param resourceGroupName string
param location string
param acrName string
param aksName string
// param sshPublicKey string
// param adminUserName string

// 1️⃣ Create the RG at subscription scope
resource rg 'Microsoft.Resources/resourceGroups@2023-07-01' = {
  name: resourceGroupName
  location: location
}

// 2️⃣ Deploy all RG-scoped resources via a module
module rgResources 'resources.bicep' = {
  name: 'deployResources'
  scope: resourceGroup(resourceGroupName) // ✅ resourceGroup scope
  params: {
    location: location
    acrName: acrName
    aksName: aksName
    // sshPublicKey: sshPublicKey
    // adminUserName: adminUserName
  }
  dependsOn: [rg]
}
