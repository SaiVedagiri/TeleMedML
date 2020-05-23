import csv
import random

fields = ['Disease', 'Temperature', 'Headache', 'Cough', 'Sneeze', 'Congestion']
diseases = ['COVID-19', 'Influenza', 'Common Cold', 'No Symptoms']

rows = []

for x in range(0, 1000):
    num = random.randint(0, 3)
    appendArr = []
    appendArr.append(diseases[num])
    temp = 0
    headache = 0
    cough = 0
    sneeze = 0
    cong = 0

    if num == 0:
        feverScore = random.randint(0, 100)
        if feverScore < 88:
            temp = float(random.randint(1000, 1040))/10.0
        else:
            temp = 98.6
        headacheScore = random.randint(0, 100)
        if headacheScore < 13:
            headache = 1
        coughScore = random.randint(0, 100)
        if coughScore < 72:
            cough = 1
        sneezeScore = random.randint(0, 100)
        if sneezeScore < 20:
            sneeze = 1
        congScore = random.randint(0, 100)
        if congScore < 6:
            cong = 1
    elif num == 1:
        feverScore = random.randint(0, 100)
        if feverScore < 80:
            temp = float(random.randint(1000, 1020))/10.0
        else:
            temp = 98.6
        headacheScore = random.randint(0, 100)
        if headacheScore < 76:
            headache = 1
        coughScore = random.randint(0, 100)
        if coughScore < 79:
            cough = 1
        sneezeScore = random.randint(0, 100)
        if sneezeScore < 48:
            sneeze = 1
        congScore = random.randint(0, 100)
        if congScore < 39:
            cong = 1
    elif num == 2:
        feverScore = random.randint(0, 100)
        if feverScore < 14:
            temp = float(random.randint(1000, 1040))/10.0
        else:
            temp = 98.6
        headacheScore = random.randint(0, 100)
        if headacheScore < 19:
            headache = 1
        coughScore = random.randint(0, 100)
        if coughScore < 53:
            cough = 1
        sneezeScore = random.randint(0, 100)
        if sneezeScore < 86:
            sneeze = 1
        congScore = random.randint(0, 100)
        if congScore < 91:
            cong = 1
    else:
        feverScore = random.randint(0, 100)
        if feverScore < 0:
            temp = float(random.randint(1000, 1040))/10.0
        else:
            temp = 98.6
        headacheScore = random.randint(0, 100)
        if headacheScore < 30:
            headache = 1
        coughScore = random.randint(0, 100)
        if coughScore < 2:
            cough = 1
        sneezeScore = random.randint(0, 100)
        if sneezeScore < 2:
            sneeze = 1
        congScore = random.randint(0, 100)
        if congScore < 2:
            cong = 1
    appendArr.append(temp)
    appendArr.append(headache)
    appendArr.append(cough)
    appendArr.append(sneeze)
    appendArr.append(cong)
    rows.append(appendArr)

filename = "symptomsData.csv"
    
# writing to csv file  
with open(filename, 'w') as csvfile:  
    # creating a csv writer object  
    csvwriter = csv.writer(csvfile)  
        
    # writing the fields  
    csvwriter.writerow(fields)  
        
    # writing the data rows  
    csvwriter.writerows(rows)

