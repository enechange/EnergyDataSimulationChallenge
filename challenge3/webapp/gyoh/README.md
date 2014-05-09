EnergyDataSimulationChallenge 3 - Web Application
=================================================

App is written with Go on the server side and CoffeeScript on the client side. The app uses MySQL for the database. Frameworks and libraries used for this app are as follows:

* [Martini](http://martini.codegangsta.io/)
* [gorp](https://github.com/coopernurse/gorp)
* [AngularJS](https://angularjs.org/)
* [ngTable](http://bazalt-cms.com/ng-table/)
* [Bootstrap](http://getbootstrap.com/)
* [morris.js](http://www.oesmith.co.uk/morris.js/)

Loading Data
------------

"house_data_nocolumnname.csv" and "dataset_50_nocolumnname.csv" are loaded into MySQL by the following sequence of commands:

    $ mysql --local-infile=1 -u root -p
    mysql> create database energydatasimulationchallenge default character set utf8;
    mysql> use energydatasimulationchallenge;
    mysql> load data local infile 'house_data_nocolumnname.csv' into table houses fields terminated by ',';
    mysql> load data local infile 'dataset_50_nocolumnname.csv' into table energies fields terminated by ',';

Running App
-----------

You need Go and Node.js installed properly to run the application. Then simply run the application with the following command from the app's root directory:

    $ go run

Deployed URL
------------

The app is deployed to Heroku at:

* <http://energydatasimulationchallenge3.herokuapp.com/>