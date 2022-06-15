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

courses = [
  {
    name: gon.courses[0].name,
    current: 0,
    homeworks: [
      {
        title: gon.courses[0].homework.title,
        from: today + gon.courses[0].homework.start_date * day,
        to: today + gon.courses[0].homework.end_date * day
      }
    ]
  },
  {
    name: gon.courses[1].name,
    current: 0,
    homeworks: [
      {
        title: gon.courses[1].homework.title,
        from: today + gon.courses[1].homework.start_date * day,
        to: today + gon.courses[1].homework.end_date * day
      }
    ]
  }
];

// Parse car data into series.
series = courses.map(function (course, i) {
    var data = course.homeworks.map(function (deal) {
        return {
            id: 'deal-' + i,
            title: deal.title,
            start: deal.from,
            end: deal.to,
            y: i
        };
    });
    return {
        name: course.name,
        data: data,
        current: course.homeworks[course.current]
    };
});

Highcharts.ganttChart('gannt-chart', {
    series: series,
    title: {
        text: 'Homework Schedule'
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
                return series.name + ', course ' + (series.index + 1) + ' of ' + series.chart.series.length + '.';
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
                    text: 'Course Name'
                },
                categories: series.map(function (s) {
                    return s.name;
                })
            }, {
                title: {
                    text: 'Homework Title'
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


// ======= original =======

// // Set to 00:00:00:000 today
// var today = new Date(),
//     day = 1000 * 60 * 60 * 24,
//     dateFormat = Highcharts.dateFormat,
//     series,
//     courses;

// // Set to 00:00:00:000 today
// today.setUTCHours(0);
// today.setUTCMinutes(0);
// today.setUTCSeconds(0);
// today.setUTCMilliseconds(0);
// today = today.getTime();

// cars = [{
//     model: 'Nissan Leaf',
//     current: 0,
//     deals: [{
//         rentedTo: 'Lisa Star',
//         from: today - 1 * day,
//         to: today + 2 * day
//     }, {
//         rentedTo: 'Shane Long',
//         from: today - 3 * day,
//         to: today - 2 * day
//     }, {
//         rentedTo: 'Jack Coleman',
//         from: today + 5 * day,
//         to: today + 6 * day
//     }]
// }, {
//     model: 'Jaguar E-type',
//     current: 0,
//     deals: [{
//         rentedTo: 'Martin Hammond',
//         from: today - 2 * day,
//         to: today + 1 * day
//     }, {
//         rentedTo: 'Linda Jackson',
//         from: today - 2 * day,
//         to: today + 1 * day
//     }, {
//         rentedTo: 'Robert Sailor',
//         from: today + 2 * day,
//         to: today + 6 * day
//     }]
// }, {
//     model: 'Volvo V60',
//     current: 0,
//     deals: [{
//         rentedTo: 'Mona Ricci',
//         from: today + 0 * day,
//         to: today + 3 * day
//     }, {
//         rentedTo: 'Jane Dockerman',
//         from: today + 3 * day,
//         to: today + 4 * day
//     }, {
//         rentedTo: 'Bob Shurro',
//         from: today + 6 * day,
//         to: today + 8 * day
//     }]
// }, {
//     model: 'Volkswagen Golf',
//     current: 0,
//     deals: [{
//         rentedTo: 'Hailie Marshall',
//         from: today - 1 * day,
//         to: today + 1 * day
//     }, {
//         rentedTo: 'Morgan Nicholson',
//         from: today - 3 * day,
//         to: today - 2 * day
//     }, {
//         rentedTo: 'William Harriet',
//         from: today + 2 * day,
//         to: today + 3 * day
//     }]
// }, {
//     model: 'Peugeot 208',
//     current: 0,
//     deals: [{
//         rentedTo: 'Harry Peterson',
//         from: today - 1 * day,
//         to: today + 2 * day
//     }, {
//         rentedTo: 'Emma Wilson',
//         from: today + 3 * day,
//         to: today + 4 * day
//     }, {
//         rentedTo: 'Ron Donald',
//         from: today + 5 * day,
//         to: today + 6 * day
//     }]
// }];

// // Parse car data into series.
// series = cars.map(function (car, i) {
//     var data = car.deals.map(function (deal) {
//         return {
//             id: 'deal-' + i,
//             rentedTo: deal.rentedTo,
//             start: deal.from,
//             end: deal.to,
//             y: i
//         };
//     });
//     return {
//         name: car.model,
//         data: data,
//         current: car.deals[car.current]
//     };
// });

// Highcharts.ganttChart('gannt-chart', {
//     series: series,
//     title: {
//         text: 'Car Rental Schedule'
//     },
//     tooltip: {
//         pointFormat: '<span>Rented To: {point.rentedTo}</span><br/><span>From: {point.start:%e. %b}</span><br/><span>To: {point.end:%e. %b}</span>'
//     },
//     lang: {
//         accessibility: {
//             axis: {
//                 xAxisDescriptionPlural: 'The chart has a two-part X axis showing time in both week numbers and days.',
//                 yAxisDescriptionSingular: 'The chart has a tabular Y axis showing a data table row for each point.'
//             }
//         }
//     },
//     accessibility: {
//         keyboardNavigation: {
//             seriesNavigation: {
//                 mode: 'serialize'
//             }
//         },
//         point: {
//             valueDescriptionFormat: 'Rented to {point.rentedTo} from {point.x:%A, %B %e} to {point.x2:%A, %B %e}.'
//         },
//         series: {
//             descriptionFormatter: function (series) {
//                 return series.name + ', car ' + (series.index + 1) + ' of ' + series.chart.series.length + '.';
//             }
//         }
//     },
//     xAxis: {
//         currentDateIndicator: true
//     },
//     yAxis: {
//         type: 'category',
//         grid: {
//             columns: [{
//                 title: {
//                     text: 'Model'
//                 },
//                 categories: series.map(function (s) {
//                     return s.name;
//                 })
//             }, {
//                 title: {
//                     text: 'Rented To'
//                 },
//                 categories: series.map(function (s) {
//                     return s.current.rentedTo;
//                 })
//             }, {
//                 title: {
//                     text: 'From'
//                 },
//                 categories: series.map(function (s) {
//                     return dateFormat('%e. %b', s.current.from);
//                 })
//             }, {
//                 title: {
//                     text: 'To'
//                 },
//                 categories: series.map(function (s) {
//                     return dateFormat('%e. %b', s.current.to);
//                 })
//             }]
//         }
//     }
// });
