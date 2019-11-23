http://18.223.15.140:8000/energySimulator/default/index

the code is the same as in challenge 4

Two different APIs created:
1. http://18.223.15.140:8000/energySimulator/default/form - you can upload input and plan files and see the result at the screen; files will be added to 'uploads' directory and accessible by link in the DB

2.a. GET http://18.223.15.140:8000/energySimulator/default/api/1.json?raw=No to calculate baseing on link 1 in the DB

2.b. GET http://18.223.15.140:8000/energySimulator/default/api/4.json?raw=raw to calculate using raw data (id=4) from DB

3  POST in format 

payload = {'plan': p, 'input': c}
r = requests.post("http://127.0.0.1:8000/energySimulator/default/api/tarif.json", data=payload)

to add raw data into DB
