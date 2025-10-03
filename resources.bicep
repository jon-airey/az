targetScope = 'resourceGroup'

param location string
param acrName string
param aksName string
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
        count: 1
        vmSize: 'Standard_DS2_v2'
        maxPods: 110
        osType: 'Linux'
        type: 'VirtualMachineScaleSets'
        mode: 'System'
      }
    ]
    // linuxProfile: {
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

