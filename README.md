# EnergyDataSimulationChallenge

Welcome to EnergyDataSimulationChallenge!
This project is to challenge the analysis of big energy production data.
We prepared two challenges.
You can try either of them or maybe both :)
Your pull-request is always welcome.

## Challenge 1 - Energy Production Data Simulation

We prepared the energy production data for 500 houses.
For each house, there are monthly data from July, 2011 to June, 2013.
The data are given temperature data and daylight data.

Please make a model for predicting EnergyProduction using data from July 2011 to May 2013.
On that basis, predict EnergyProduction on June 2013 for each house, and calculate MAE(Mean Absolute Error).
You can use any algorithms including multiple-variables regression, polynomial regression, Neural network, SVM, etc...

We will see **accuracy of prediction(MAE), algorithm choice, parameter tuning, programming skill**.
Make sure that MAE value is not all. We would like to see many aspects of your commits.

### Input

Input dataset file is in data/ directory as follows.
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
Each data of a house consists of 24 lines showing monthly EnergyProduction data with Temperature data and Daylight data.

training_dataset_500.csv and test_dataset_500.csv are just subsets of dataset_500.csv.
test_dataset_500.csv includes only June 2013 data of each house. The rest of it is training_dataset_500.csv.

You can use any given data you like. But do not forget that you can use only data from July 2011 to May 2013 for training.

### Output

Output is predicted_energy_production.csv, mae.txt and another files.
Please set these files in analysis/YOURNAME/.

1. **predicted_energy_production.csv**
Need to include House column and EnergyProduction column for each line.
Any csv file that we can find which columns means House and EnergyProduction is also acceptable.
2. **mae.txt**
Need to include just MAE value. Minimize it.
3. **another files**
Files you use, edit, or write like R source code, batch Python file, excel file, etc.
These files will be good materials for us to understand your thoughts.
This rule is not so strict that you can avoid to commit your secret files.

### Trying

1. Fork it
2. Create your branch
(Name the branch name 'analyst/YOURNAME' like analyst/shirakia)
3. Create your directory in 'analysis' directory.
4. Code your analysis programs and commit them
5. Push to the branch
6. Make a Pull Request

### Attention
- Avoid working in any branch except your own branch
- Avoid committing any file except in your directory

### Deadline

The deadline for Challenge 1 is 30th September.
Please commit files and make a Pull Request by the deadline.

### Reward

* Winner (max 2 people) will be kindly offered the position for Paid Internship. (3-month programme, competitive salary.)
* Accommodation (private room) and your desk at Co-Working space in Cambridge, UK will be provided for FREE if you wish to work with us here.
* Or, you can still work from your own place remotely.
* After Successful 3-month programme, we could offer other positions (permanent position, longer contract, additional intern etc.)

## Challenge 2 - Web Application

Please create a web application to show each user's energy usages with time-series graph.

- @TODO: Detail of the rule to be described here
