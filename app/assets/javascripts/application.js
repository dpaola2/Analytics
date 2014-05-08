// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery_ujs
//= require bootstrap
//= require_tree .
//= require_self


var useLineChart = function() {
    window.Prefs.chart_type = "line";
    reloadCharts();
};
var useBarChart = function() {
    window.Prefs.chart_type = "bar";
    reloadCharts();
};
var usePieChart = function() {
    window.Prefs.chart_type = "pie";
    reloadCharts();
};

var useHeatmapChart = function() {
    window.Prefs.chart_type = "heatmap";
    reloadCharts();
};

var reloadCharts = function() {
    var url = window.Prefs.data_url + '/' + window.Prefs.fact + "?by=" + window.Prefs.time_bucket + "&last=" + window.Prefs.last;
    var mapper = {
        "line" : Chartkick.LineChart,
        "bar"  : Chartkick.ColumnChart,
        "pie"  : Chartkick.PieChart,
        "heatmap"  : HeatmapChart,
    };
    new mapper[window.Prefs.chart_type]('chart', url, {});
    updateLabels();
};

var byHour = function() {
    window.Prefs.time_bucket = "hourly";
    window.Prefs.last = 24;
    reloadCharts();
};

var byDay = function() {
    window.Prefs.time_bucket = "daily";
    window.Prefs.last = 30;
    reloadCharts();
};

var byWeek = function() {
    window.Prefs.time_bucket = "weekly";
    window.Prefs.last = 12;
    reloadCharts();
};

var byMonth = function() {
    window.Prefs.time_bucket = "monthly";
    window.Prefs.last = 12;
    reloadCharts();
};

var byDayOfWeek = function() {
    window.Prefs.time_bucket = "day_of_week";
    window.Prefs.last = null;
    reloadCharts();
};

var byHourOfDay = function() {
    window.Prefs.time_bucket = "hour_of_day";
    window.Prefs.last = null;
    reloadCharts();
};

var byHoursByWeekday = function() {
    window.Prefs.time_bucket = "hours_by_weekday";
    window.Prefs.last = null;
    reloadCharts();
};

var updateLabels = function() {
    $('.time_dimension_label').text(window.Prefs.time_bucket);
    $('.chart_type_label').text(window.Prefs.chart_type);
};
