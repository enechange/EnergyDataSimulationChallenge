# EnergyPriceSimulationChallenge

Welcome to EnergyPriceSimulationChallenge! This project is to challenge the analysis of big energy consumption data. We prepared two challenges. You can try either of them or maybe both :)
Your pull-request is always welcome.

## Challenge 1 - Price Plan Optimization

Please analyze the energy consumption data and fiture out which price plan is the best for each user.

### Dataset

Dataset file is in data/ directory as follows.
```
$ head data/dataset_500.csv | column -s, -t
ID  Label  House  Year  Month  Temperature  Daylight  EnergyProduction
0   0      1      2011  7      26.2         178.9     740
1   1      1      2011  8      25.8         169.7     731
2   2      1      2011  9      22.8         170.2     694
3   3      1      2011  10     16.4         169.1     688
4   4      1      2011  11     11.4         169.1     650
5   5      1      2011  12     4.2          199.5     763
6   6      1      2012  1      1.8          203.1     765
7   7      1      2012  2      2.8          178.2     706
8   8      1      2012  3      6.7          172.7     788
```

The first line of the file gives the format name.
The rest of the file describes EnergyProduction data for 500 houses.
Each data of a house consists of 24 lines showing monthly EnergyProduction data with Temparature data and Daylight data.

### Trying

1. Fork it
2. Create your branch
(Name the branch name 'analyst/YOURNAME' like analysit/shirakia)
3. Create your directory in 'analysis' directory.
4. Code your analysis programs and commit them
5. Push to the branch
6. Make a Pull Request

### Attention
- Avoid working in any branch except your own branch
- Avoid committing any file except in your directory

## Challenge 2 - Web Application

Please create a web application to show each user's energy usages with time-series graph.

- @TODO: Detail of the rule to be described here
