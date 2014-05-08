(function(){
  // Sample data
 // {
 //   "Sunday": {
 //     "10am": 335,
 //     "11am": 283,
 //     ...
 //   }
 //   "Monday": {
 //     "10am": 300,
 //     "11am": 100,
 //   }
 //   ...
 // }
  //

  var _domID = null
    , _options = null
    ;

  var HeatmapChart = function (domID, url, options) {
    _domID = domID
    _options = options

    $(function(){
      $.getJSON(url, renderChart)
    });
  }


  var renderChart = function(data) {
    // Make hours
    var hours = _.chain(data).values().first().keys().value();
    // Make days
    var days = _.keys(data);
    var seriesData = [ ];

    // map data
    _.each(days, function(day, dayIndex){
      _.each(hours, function(hour, hourIndex){
        count = data[day][hour];
        seriesData.push([hourIndex, dayIndex, count]);
      });
    });



    //render chart
    $('#' + _domID).highcharts({
      chart: {
        type: 'heatmap',
        inverted: true,
        height: 800
      },
      title: {
        text: Prefs.fact + ' for each hour of the week'
      },
      xAxis: {
        categories: hours
      },
      yAxis: {
        categories: days
      },
      colorAxis: {
        min: 0,
        minColor: '#FFFFFF',
        maxColor: Highcharts.getOptions().colors[0]
      },
      legend: {
        align: 'right',
        layout: 'vertical',
        margin: 0,
        verticalAlign: 'top',
        y: 25,
        symbolHeight: 320
      },
      series: [{
        data: seriesData,
        dataLabels: {
          enabled: true,
          color: 'black',
          style: {
            textShadow: 'none'
          }
        }
      }]
    });
  };


  window.HeatmapChart = HeatmapChart;
})();
