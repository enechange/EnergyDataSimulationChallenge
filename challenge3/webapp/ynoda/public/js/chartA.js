define([
	"dojo/_base/array",
	"dojo/request/xhr",
	"dojox/charting/Chart",
	"dojox/charting/widget/Legend",
	"dojox/charting/action2d/Tooltip",
	"dojox/charting/action2d/Magnify",
	"dojox/charting/themes/PrimaryColors",
	"dojox/charting/plot2d/StackedAreas",
	"dojox/charting/plot2d/Markers",
	"dojox/charting/axis2d/Default",
	"dojo/domReady!"
], function(Array, Xhr, Chart, Legend, Tooltip, Magnify, Theme){
	   var deffered = Xhr("/service/getAvgEPByCity", {handleAs: "json"}).then(function(data){
		   var chart = new Chart("chartaNode");
		   chart.setTheme(Theme);
                   chart.addPlot("default", {type: "StackedAreas", markers: true});
                   chart.addAxis("x", {
			   title: "Year - Month",
			   titleOrientation: "away",
			   labels: data[0].timelabels
		   });
                   chart.addAxis("y", {
			   title: "Energy Production",
			   min: 0,
			   max: 3000,
			   vertical: true,
			   fixLower: "major",
			   fixUpper: "major"
		   });
      		   Array.forEach(data, function(d){
			   chart.addSeries(d.city, d.avgs);
		   });
		   var tip = new Tooltip(chart, "default");                                                                                   
		   var mag = new Magnify(chart,"default");
		   chart.render();
		   var legend = new Legend({ chart: chart }, "legenda");
	   }, function(err){
                   console.log(err);
	   }, function(evt){
                   console.log(evt);
	   });

});