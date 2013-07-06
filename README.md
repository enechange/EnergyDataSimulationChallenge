# EnergyPriceSimulationChallenge

Welcome to EnergyPriceSimulationChallenge! This project is to challenge the analysis of big energy consumption data. We prepared two challenges. You can try either of them or maybe both :)
Your pull-request is always welcome.


## Set Up

please run this scala script to create data files.

```
scala util/GenerateUserData.scala <number of users>
```

data files will be crated in data/user directories as follows.

```
$ scala util/GenerateUserData.scala 10
generating 10 user data
data/user/user_00001.csv
data/user/user_00002.csv
data/user/user_00003.csv
data/user/user_00004.csv
data/user/user_00005.csv
data/user/user_00006.csv
data/user/user_00007.csv
data/user/user_00008.csv
data/user/user_00009.csv
data/user/user_00010.csv
```

The data files have enegy consumption in every 5 minutes as you see this [sample file](https://github.com/peisan/EnergyPriceSimulationChallenge/blob/master/data/user/sample.csv)

```
2013/01/01,00:00,79W
2013/01/01,00:05,71W
2013/01/01,00:10,6W
2013/01/01,00:15,11W
2013/01/01,00:20,2W
2013/01/01,00:25,87W
2013/01/01,00:30,66W
2013/01/01,00:35,90W
2013/01/01,00:40,30W
2013/01/01,00:45,55W
2013/01/01,00:50,72W
2013/01/01,00:55,63W
2013/01/01,01:00,83W
2013/01/01,01:05,38W
2013/01/01,01:10,66W
2013/01/01,01:15,35W
2013/01/01,01:20,83W
2013/01/01,01:25,91W
2013/01/01,01:30,27W
2013/01/01,01:35,48W
2013/01/01,01:40,75W
```


## Challenge 1 - Price Plan Optimization

Please analyze the energy consumption data and fiture out which price plan is the best for each user.

- @TODO: Price plans to be posted here
- @TODO: Detail of the rule to be described here

## Challenge 2 - Web Application

Please create a web application to show each user's energy usages with time-series graph.

- @TODO: Detail of the rule to be described here

