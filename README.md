# EnergyDataSimulationChallenge

Welcome to EnergyDataSimulationChallenge!
This project is to challenge the analysis of big energy production data.
We prepared several challenges.
You can try either of them or maybe all :)
Your pull-request is always welcome.

## Instructions

### Steps

1. Fork it
2. Create your branch
(Name the branch 'challengeX/YOURNAME' like challenge1/shirakia)
3. Create your directory in 'analysis/' or 'webapp/' directory
4. Code your analysis programs and commit them to the branch
5. Push the branch
6. Make a Pull Request

### Attention
- Avoid working in any branch except your own branch
- Avoid committing any file except in your directory

### Reward

* Winner will be kindly offered the position for Paid Internship. (3-month programme, competitive salary.)
* Accommodation (private room) and your desk at Co-Working space in Cambridge, UK will be provided for FREE if you wish to work with us here.
* Or, you can still work from your own place remotely.
* After Successful 3-month programme, we could offer other positions (permanent position, longer contract, additional intern etc.)

## Challenge 1 - Energy Production Data Simulation

We prepared the energy production data for 500 houses.
For each house, there are monthly data from July, 2011 to June, 2013.
The data are given temperature data and daylight data.

Please make a model for predicting EnergyProduction using data from July 2011 to May 2013.
On that basis, predict EnergyProduction on June 2013 for each house, and calculate MAPE(Mean Absolute Persentage Error).
You can use any algorithms including multiple-variables regression, polynomial regression, Neural network, SVM, etc...

We will see **accuracy of prediction(MAPE), algorithm choice, parameter tuning, programming skill**.
Make sure that MAPE value is not all. We would like to see many aspects of your commits.

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

Output is predicted_energy_production.csv, mape.txt and another files.
Please set these files in challenge1/analysis/YOURNAME/.

1. **predicted_energy_production.csv**
Need to include House column and EnergyProduction column for each line.
Any csv file that we can find which columns means House and EnergyProduction is also acceptable.
2. **mape.txt**
Need to include just MAPE value. Minimize it.
3. **another files**
Files you use, edit, or write like R source code, batch Python file, excel file, etc.
These files will be good materials for us to understand your thoughts.
This rule is not so strict that you can avoid to commit your secret files.


## Challenge 2 - Visualization of Energy Consumptions

The following task is intended to give us an idea of your data visualisation skills. Please use the tools/programming language you are most familiar with.


### Steps
1. Download the data-set total-watt.csv
2. The data-set consists of two columns: a time stamp and the energy consumption
3. visualise the data-set
5. visualise the data-set as values per day
6. cluster the values per day into 3 groups: low, medium, and high energy consumption
7. visualise the clusters (How you visualize the data is up to you. Please show us your imagination and creativity!)

### Input
dataset file is in data/ directory as follows.

```
$ head data/total_watt.csv| column -s, -t
2011-04-18 13:22:00  925.840613752523
2011-04-18 13:52:00  483.295891812865
2011-04-18 14:22:00  915.761633660131
2011-04-18 14:52:00  609.043490935672
2011-04-18 15:22:00  745.155434458509
2011-04-18 15:52:00  409.855947368421
2011-04-18 16:22:00  434.084038321073
2011-04-18 16:52:00  152.684299188514
2011-04-18 17:22:00  327.579073188405
2011-04-18 17:52:00  156.826945856169
```

### Output
Please set output files in challenge2/analysis/YOURNAME/.

1. visualization of the data-set as values per 30mins
2. visualization of the data-set as values per day
3. visualization of the data-set as clusters

## Challenge 3 - Web Application

Please create a web application to show house energy usages.

1. Insert csv files into SQL database. (MySQL, postgreSQL, etc..)
2. Load data from DB and show it on the web with a web framework. (Rails preffered)
3. Show 1 or 2 types of charts of the data. (no more than 2 types)
4. (Option) Deploy it to somewhere. (AWS, Heroku, your own server, etc...)

We will see basic programming skill, data modeling and what to show. We will **not** see web design skill.

### Input

Input dataset files are in challenge3/data/ directory as follows.
```
$ ls data/
dataset_50.csv  house_data.csv

$ head data/house_data.csv | column -s, -t
ID  Firstname  Lastname  City       num_of_people  has_child
1   Carolyn    Flores    London     2              Yes
2   Jennifer   Martinez  Cambridge  3              No
3   Larry      Robinson  London     4              Yes
4   Paul       Wright    Oxford     3              No
5   Frances    Ramirez   London     3              Yes
6   Pamela     Lee       Oxford     3              Yes
7   Patricia   Taylor    London     3              Yes
8   Denise     Lewis     Oxford     4              Yes
9   Kelly      Clark     Cambridge  4              No
```
(Names are by Random Name Generator http://random-name-generator.info/ )

dataset_50.csv is almost same to Challenge1's Input. It is smaller and its ID starts with 1 rather than 0. Please refer to Challenge1.
house_data.csv is household data related to dataset_50.csv.
The first line gives the format name. 'ID' is 'House' of dataset_50.csv. 'City' includes 'London', 'Cambridge' and 'Oxford'. 'has_child' has only 'Yes' or 'No'.

### Output

1. Please set All source codes in challenge3/webapp/YOURNAME/
2. Write deployed URL in Pull Request Comment.

You can refer to sample implementation in challenge3/webapp/sample/
But please mind that it is rough and may have some points to be fixed.
