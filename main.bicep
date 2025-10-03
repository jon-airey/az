targetScope = 'subscription'

param rgName string
param location string
param acrName string
param aksName string
param maxPods int
param deployName string

// 1️⃣ Create the RG at subscription scope
resource rg 'Microsoft.Resources/resourceGroups@2025-04-01' = {
  name: rgName
  location: location
}

// 2️⃣ Deploy all RG-scoped resources via a module
module rgResources 'resources.bicep' = {
  name: deployName
  scope: resourceGroup(rgName) // ✅ resourceGroup scope
  params: {
    location: location
    acrName: acrName
    aksName: aksName
    maxPods: maxPods
  }
  dependsOn: [rg]
}
