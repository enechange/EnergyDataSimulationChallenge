require([
	 "dojo/_base/array",
	 "dojo/request/xhr",
	 "dojox/charting/Chart",
	 "dojox/charting/widget/Legend",
	 "dojox/charting/action2d/Tooltip",
	 "dojox/charting/action2d/Magnify",
	 "dojox/charting/axis2d/Default",
	 "dojox/charting/plot2d/Scatter",
	 "dojox/charting/themes/Julie",
	 "dojo/domReady!"
],function(Array, Xhr, Chart, Legend, Tooltip, Magnify, Default, Scatter, Theme, ready){
	    var deffered = Xhr("/service/getEPByFamily", {handleAs: "json"}).then(function(data){
		    var chartB = new Chart("chartbNode");
		    chartB.addPlot("default", {type: "Scatter", markers: true});
		    chartB.addAxis("x", {
			    title: "Templature",
			    titleOrientation: "away",
			    fixLower: "major",
			    fixUpper: "major",
			    min: 0,
			    max: 35
		    });
		    chartB.addAxis("y", {
			    title: "Energy Production",
			    vertical: true,
			    fixLower: "major",
			    fixUpper: "major",
			    min: 0,
			    max: 1300
		    });
		    chartB.setTheme(Theme);
		    var hasChild = [];
		    var noChild = [];
		    Array.forEach(data, function(d){
			    if(d.has_child == "Yes"){
				hasChild.push({x: d.x, y: d.y});
			    }else if(d.has_child == "No"){
				noChild.push({x: d.x, y: d.y});
			    }
		    });
		    chartB.addSeries("House without Child", noChild, {stroke: {color: "red", width: 0.1}, fill: "orange"});
		    chartB.addSeries("House with Child", hasChild, {stroke: {color: "blue", width: 0.1}, fill: "deepskyblue"});
		    var tip = new Tooltip(chartB, "default", {text: function(o){
				return "<div>Templature:" + o.x + "</div><div>Energy Production:" + o.y + "</div>";
			    }});
		    var mag = new Magnify(chartB, "default");
		    chartB.render();
		    var legend = new Legend({ chart: chartB }, "legendb");
	    }, function(err){
		    console.log(err);
	    }, function(evt){
		    console.log(evt);
	    });
});