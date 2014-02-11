
Visualisation file : energy_consumption_vis.html

Please copy the file to a webserver and access it via URL in your browser instead of accessing it directly as a local
file. The visualisation is implemented using d3.js which
requires callback/ajax capability. You can run the below command to start a
simple python webserver:

    cd EnergyDataSimulationChallenge/challenge2/analysis/joyanujoy

    python -m SimpleHTTPServer 8000

    Point your browser to http://127.0.0.1:8000/energy_consumption_vis.html


d3.js will work only on modern browsers(I have tested it on chrome).


Files included:
    joyanujoy/js : contains d3.js libraries 
    joyanujoy/energy_consumption_vis.html : visualisation html
    
    joyanujoy/analysis.py : Python program to analyse and produce files for
    visualisation. As I'm not faimiliar with numpy library I have implemented
    Kmeans clustering in a simple way - it isn't optimized to handle very large
    files but it is very quick for the given file.

    To run:

    python analysis.py ../../data/total_watt.csv

    produces 3 files:
        watts_grouped_by_30.csv 
        watts_grouped_by_day.csv
        watts_cluster_areachart.csv

    These 3 files are used by energy_consumption_vis.html to produce SVG
    visualisation dynamically. You should be able to run analysis.py against any file in the same format
    as total_watt.csv and load the vis html file in browser to see the
    visualisation. d3.js will automatically realign axes, scales etc. There may
    be slight issues with lablels and pie/tool tips as I have aligned them
    specifically for the data in total_watt.csv


I initially planned to produce a web app by wrappping analysis.py inside a
python microframework(bottle). In that way new files can be loaded via the
webapp for anaylysis and visuslisation can be made fully dynamic by accessing
analysis.py via api calls. I didn't get to time to work on that! 



