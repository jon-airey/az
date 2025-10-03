targetScope = 'resourceGroup'

param location string
param acrName string
param aksName string
param maxPods int
// param sshPublicKey string
// param adminUserName string

// Azure Container Registry
resource acr 'Microsoft.ContainerRegistry/registries@2025-04-01' = {
  name: acrName
  location: location
  sku: {
    name: 'Basic'
  }
  properties: {
    adminUserEnabled: true
  }
}

// AKS cluster
resource aks 'Microsoft.ContainerService/managedClusters@2025-04-01' = {
  name: aksName
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    dnsPrefix: aksName
    agentPoolProfiles: [
      {
        name: 'agentpool'
        count: 1        // initial nodes
        minCount: 1     // autoscaler minimum
        maxCount: 2     // autoscaler maximum
        enableAutoScaling: true
        vmSize: 'Standard_DS2_v2'
        maxPods: maxPods
        osType: 'Linux'
        type: 'VirtualMachineScaleSets'
        mode: 'System'
      }
    ]
    // linuxProfile: {        //cannot do this in my dev model, can manage nodes thru kubectl alternatively
    //   adminUsername: adminUserName
    //   ssh: {
    //     publicKeys: [
    //       { keyData: sshPublicKey }
    //     ]
    //   }
    // }
  }
  dependsOn: [
    acr
  ]
}

// --- Attach ACR to AKS by creating role assignment ---
resource acrPullRole 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(aks.id, 'acrpull')  // unique deterministic GUID
  scope: acr
  properties: {
    roleDefinitionId: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '7f951dda-4ed3-4680-a7ca-43fe172d538d') // AcrPull role
    principalId: aks.identity.principalId
    principalType: 'ServicePrincipal'
  }
}
