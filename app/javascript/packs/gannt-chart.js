const { Hash } = require("webpack/lib/util/createHash");

// Set to 00:00:00:000 today
var today = new Date(),
    day = 1000 * 60 * 60 * 24,
    dateFormat = Highcharts.dateFormat,
    series,
    cars;

// Set to 00:00:00:000 today
today.setUTCHours(0);
today.setUTCMinutes(0);
today.setUTCSeconds(0);
today.setUTCMilliseconds(0);
today = today.getTime();


courses = []
index = 0

//======= Set Chart data =======
gon.courses.forEach(course => {

  console.log(index);
  console.log(course)

  if (course.length > 0){

    //======= Set assignment list =======
    assignments = []
    course.forEach(element => {
      assignment =   {
        name: element.name,
        user_name: element.user_name,
        current: 0,
        homeworks: [
          {
            title: element.homework.title,
            from: today + element.homework.start_date * day,
            to: today + element.homework.end_date * day
          }
        ]
      };
      assignments.push(assignment)
    });


    //======= Set Series =======
    series = assignments.map(function (assignment, i) {
        var data = assignment.homeworks.map(function (homework) {
            return {
                id: 'homework-' + i,
                title: homework.title,
                start: homework.from,
                end: homework.to,
                y: i
            };
        });
        return {
            name: assignment.name,
            user_name: assignment.user_name,
            data: data,
            current: assignment.homeworks[assignment.current]
        };
    });

    console.log(series);

    //======= Set Highchart =======
    Highcharts.ganttChart(`gannt-chart-${index}`, {
        series: series,
        title: {
            text: series[0].name
        },
        tooltip: {
            pointFormat: '<span>Title: {point.title}</span><br/><span>From: {point.start:%e. %b}</span><br/><span>To: {point.end:%e. %b}</span>'
        },
        lang: {
            accessibility: {
                axis: {
                    xAxisDescriptionPlural: 'The chart has a two-part X axis showing time in both week numbers and days.',
                    yAxisDescriptionSingular: 'The chart has a tabular Y axis showing a data table row for each point.'
                }
            }
        },
        accessibility: {
            keyboardNavigation: {
                seriesNavigation: {
                    mode: 'serialize'
                }
            },
            point: {
                valueDescriptionFormat: 'Title {point.title} from {point.x:%A, %B %e} to {point.x2:%A, %B %e}.'
            },
            series: {
                descriptionFormatter: function (series) {
                    return series.name + ', assignment ' + (series.index + 1) + ' of ' + series.chart.series.length + '.';
                }
            }
        },
        xAxis: {
            currentDateIndicator: true
        },
        yAxis: {
            type: 'category',
            grid: {
                columns: [{
                    title: {
                        text: 'Homework'
                    },
                    categories: series.map(function (s) {
                        return s.current.title;
                    })
                }, {
                    title: {
                        text: 'From'
                    },
                    categories: series.map(function (s) {
                        return dateFormat('%e. %b', s.current.from);
                    })
                }, {
                    title: {
                        text: 'To'
                    },
                    categories: series.map(function (s) {
                        return dateFormat('%e. %b', s.current.to);
                    })
                }]
            }
        }
    });
    index = index + 1;
  }
})
