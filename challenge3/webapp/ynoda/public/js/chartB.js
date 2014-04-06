require([
	 "dojox/charting/Chart",
	 "dojox/charting/axis2d/Default",
	 "dojox/charting/plot2d/Scatter",
	 "dojox/charting/themes/Julie",
	 "dojo/domReady!"
],function(Chart, Default, Scatter, Theme, ready){
	    var c = new Chart("chartbNode");
	    c.addPlot("default", {type: Scatter});
	    c.addAxis("x", {fixLower: "major", fixUpper: "major"});
	    c.addAxis("y", {vertical: true, fixLower: "major", fixUpper: "major", min: 0});
	    c.setTheme(Theme);
	    c.addSeries("Series A", [1, 2, 0.5, 1.5, 1, 2.8, 0.4]);
	    c.addSeries("Series B", [2.6, 1.8, 2, 1, 1.4, 0.7, 2]);
	    c.addSeries("Series C", [6.3, 1.8, 3, 0.5, 4.4, 2.7, 2]);
	    c.render();
});