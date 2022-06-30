Highcharts.chart('org-chart', {
  chart: {
      height: 600,
      inverted: true
  },

  title: {
      text: 'Organization'
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
      // data: [
      //     ['test', 'james'],
      //     ['james', 'ed'],
      //     ['james', 'shunjiro'],
      //     ['ed', 'shingo'],
      //     ['shunjiro', 'doug']
      // ],
      nodes: gon.org_nodes,
    //   nodes: [{
    //     id: 'test',
    //     title: 'test',
    //     name: 'James Reed'
    // }, {
    //       id: 'james',
    //       title: 'james',
    //       name: 'James Reed'
    //   }, {
    //       id: 'ed',
    //       title: 'ed',
    //       name: 'Ed Oz'
    //   }, {
    //       id: 'shunjiro',
    //       title: 'shunjiro',
    //       name: 'Shunjiro Yatsuzuka'
    //   }, {
    //       id: 'shingo',
    //       title: 'shingo',
    //       name: 'Shingo Kubomura'
    //   }, {
    //       id: 'doug',
    //       title: 'doug',
    //       name: 'Doug Berkeley'
    //   }],
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
