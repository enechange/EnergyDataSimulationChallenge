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
4. Design and write your programs and commit them to the branch
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
On that basis, predict EnergyProduction on June 2013 for each house, and calculate MAPE(Mean Absolute Percentage Error).
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
Need to include just MAPE value. Minimise it.
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
2. Load data from DB and show it on the web with a web framework. (Rails preferred)
3. Show 1 or 2 types of charts of the data. (no more than 2 types)
4. (Option) Deploy it to somewhere. (AWS, Heroku, your own server, etc...)

We will see basic programming skill, data modelling and what to show. We will **not** see web design skill.

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
The first line gives the format name. `ID` column values in this file are same to `House` column values in dataset_50.csv. `City` column includes 'London', 'Cambridge' and 'Oxford'. `has_child` column has only 'Yes' or 'No'.

### Output

1. Please set ALL source codes in challenge3/webapp/YOURNAME/
2. Write deployed URL in Pull Request Comment.

You can refer to sample implementation in challenge3/webapp/sample/
But please mind that it is rough and may have some parts to be fixed.

## Challenge 4 - WEB-API Server

Please create a web api server to calculate electricity charges.

1. see TEPCO's explanation of electricity charges.
  - http://www.tepco.co.jp/e-rates/individual/data/chargelist/chargelist04-j.html
  - http://www.tepco.co.jp/e-rates/individual/menu/home/home02-j.html
  - http://www.tepco.co.jp/e-rates/individual/menu/home/home08-j.html
  - http://www.tepco.co.jp/en/customer/guide/ratecalc-e.html

2. you have to calculate `Energy Charge` of "Meter-Rate Lighting B" and "Yoru Toku Plan",
   and write WEB-API server with your favorite web framework ( Ruby on Rails preferred )
   `Energy Charge` grows when the energy consumption ( kWh ) is bigger.

3. deploy it to somewhere ( AWS, heroku, your own server, etc...)

We will see basic programming skill, API design and performance.

### Input

Input dataset files are in challenge4/data/ directory as follows.

```
  $ ls data/
sample-consumption.json plans.json

  $ cat data/sample-consumption.json
[
  [ 0.2, 0.3, 0.2, ... ], # 24 values for 1st day, 1 am, 2 am .. 12 am, 1 pm ..  12 pm
  [ 0.2, 0.3, 0.2, ... ], # 24 values for 2nd day
  ...
  [ 0.2, 0.3, 0.2, ... ]  # 24 values for 31st day
]
```

   sample-consumptions.json is a JSON array of arrays of float values.
   Each float value is a energy consumption(kWh).
   First value of a day is a consumption from 0 am to 1 am.

```
  $ cat data/plans.json
{
  "Meter-Rate Lighting B": {
    "Day time": [
      [ null, 120, 19.43],
      [ 120, 300, 25.91],
      [ 300, null, 29.93]
    ],
    "Night time": null,
    "Night time range": null
  },

  "Yoru Toku Plan": {
    "Day time": [
      [ null, 90, 24.03],
      [ 90, 230, 32.03],
      [ 230, null, 37.00]
    ],
    "Night time": [
      [ null, null, 12.48]
    ],
    "Night time range":
      [ true, true, true, true,
        true, false, false, false,
        false, false, false, false,
        false, false, false, false,
        false, false, false, false,
        false, true, true, true ]
  }
}
```
  "Day time" and "Night time" values are
  array [ from kWh, to kWh, unit price tax included ]
  ex) [ null, 120, 19.43 ] :
      the unit price is ¥19.43 per kilo watt hour upto initial 120 kWh.
      [ 300, null, 29.93 ] :
      the unit price is ¥29.93 when the energy consumption is larger than 300 kWh.

  When "Night time" attribute is null, the plan has only day time.
  "Night time range" is 24 boolean values which represent 24 hours night time and day time.

  (Yoru Toku Plan offers discount rate in night time.)

 Output of the API is just one float number of `Energy Charge` with tax.

### Output

1. Please set ALL source codes in challenge4/webapp/YOURNAME/
2. Write deployed URL in Pull Request Comment.

## Challenge 5 - Business Analyst Task

For this challenge, you will be required to demonstrate your knowledge of the UK domestic energy market. Please prepare a presentation that answers the following qustion:

If you were to start a energy retail company in the UK through Cambridge Energy Data Lab, how would you go about doing it? Please assume that only domestic/household consumers will be the customers to the service, and the company will offer both electricity and gas tariffs. Prepare as if this were a presentation for an investor looking to partner with Cambridge Energy Data Lab in creating such a service.

Please limit your presentation to no more than 15 slides, including title and/or reference pages. Send your presentation to cam_all_ml@googlegroups.com. If we like your presentation and your CV, we will contact you to arrange for a final interview in Cambridge where you will make your "pitch" for us in person.


