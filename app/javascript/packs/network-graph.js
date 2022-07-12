Highcharts.addEvent(
  Highcharts.Series,
  'afterSetOptions',
  function (e) {
      var colors = Highcharts.getOptions().colors,
          i = 0,
          nodes = {};

      if (
          this instanceof Highcharts.seriesTypes.networkgraph &&
          e.options.id === 'lang-tree'
      ) {
          e.options.data.forEach(function (link) {

              if (link[0] === 'Goal') {
                  nodes['Goal'] = {
                      id: 'Goal',
                  marker: {
                          radius: 20
                      }
                  };
                  nodes[link[1]] = {
                      id: link[1],
                      marker: {
                          radius: 10
                      },
                      color: colors[i++]
                  };
              } else if (nodes[link[0]] && nodes[link[0]].color) {
                  nodes[link[1]] = {
                      id: link[1],
                      color: nodes[link[0]].color
                  };
              }
          });

          e.options.nodes = Object.keys(nodes).map(function (id) {
              return nodes[id];
          });
      }
  }
);

Highcharts.chart('network-graph', {
  chart: {
      type: 'networkgraph',
      height: gon.tree_height
  },
  title: {
      text: gon.tree_title
  },
  plotOptions: {
      networkgraph: {
          keys: ['from', 'to'],
          layoutAlgorithm: {
              enableSimulation: true,
              friction: -0.9
          }
      }
  },
  series: [{
      accessibility: {
          enabled: false
      },
      dataLabels: {
          enabled: true,
          linkFormat: ''
      },
      id: 'lang-tree',
      data: gon.tree_data
  }]
});
