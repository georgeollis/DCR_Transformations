param name string = 'windows-rule'
param location string = 'uksouth'
param workspaceId string

resource dcr 'Microsoft.Insights/dataCollectionRules@2021-09-01-preview' = {
  name: name
  location: location
  kind: 'Windows'
  properties: {
    dataSources: {
      windowsEventLogs: [
        {
          streams: [
            'Microsoft-Event'
          ]
          xPathQueries: [
            'Application!*[System[(Level=1 or Level=2 or Level=3 or Level=4 or Level=5)]]'
            'Security!*[System[(band(Keywords,13510798882111488))]]'
            'System!*[System[(Level=1 or Level=2 or Level=3 or Level=4 or Level=5)]]'
          ]
          name: 'eventLogsDataSource'
        }
      ]
    }
    destinations: {
      logAnalytics: [
        {
          workspaceResourceId: workspaceId
          name: 'la-847693882'
        }
      ]
    }
    dataFlows: [
      {
        streams: [
          'Microsoft-Event'
        ]
        destinations: [
          'la-847693882'
        ]
        transformKql: 'source\n| extend table_CF = "HelloWorld"\n'
      }
    ]
  }
}
