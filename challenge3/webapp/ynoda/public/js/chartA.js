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
		   avgEP = data;

		   var chart = new Chart("chartaNode");
		   chart.setTheme(Theme);
                   chart.addPlot("default", {type: "StackedAreas", markers: true});
                   chart.addAxis("x");
                   chart.addAxis("y", { min: 0, max: 3000, vertical: true, fixLower: "major", fixUpper: "major" });
		   
		   Array.forEach(avgEP, function(c){
			   chart.addSeries(c.city, c.avgs);
		   });
		   var tip = new Tooltip(chart, "default");                                                                                   
		   var mag = new Magnify(chart,"default");
		   chart.render();
		   var legend = new Legend({ chart: chart }, "legend");
	   }, function(err){
                   console.log(err);
	   }, function(evt){
                   console.log(evt);
	   });

});