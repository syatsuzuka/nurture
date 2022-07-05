Highcharts.chart('org-chart', {
  chart: {
      height: 600,
      inverted: true
  },

  title: {
      text: gon.org_title
  },

  accessibility: {
      point: {
          descriptionFormatter: function (point) {
              var nodeName = point.toNode.name,
                  nodeId = point.toNode.id,
                  nodeDesc = nodeName === nodeId ? nodeName : nodeName + ', ' + nodeId,
                  parentDesc = point.fromNode.id;
              return point.index + '. ' + nodeDesc + ', reports to ' + parentDesc + '.';
          }
      }
  },

  series: [{
      type: 'organization',
      name: 'Highsoft',
      keys: ['from', 'to'],
      data: gon.org_data,
      nodes: gon.org_nodes,
      colorByPoint: false,
      color: '#007ad0',
      dataLabels: {
          color: 'white'
      },
      borderColor: 'white',
      nodeWidth: 65
  }],
  tooltip: {
      outside: true
  },
  exporting: {
      allowHTML: true,
      sourceWidth: 800,
      sourceHeight: 600
  }
});
