d3.json("/service/listdataset", function(error, data){
    var text = "";
    for(var i=0; i<data.length; i++){
        text += data[i].label + " = " + data[i].house + "<br>";
    }
    d3.select("#result").html(text);
});