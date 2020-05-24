import numpy as np # linear algebra
import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import MinMaxScaler
import tensorflow as tf

import os

os.environ['TF_CPP_MIN_LOG_LEVEL'] = '2'

model = tf.keras.models.Sequential([
        tf.keras.layers.Dense(64, activation='relu'),    # relu activation is a piecewise function that is 0 when x < 0 and x when x > 0
                                                        # activation helps a neuron "decide when to fire". Otherwise our output is a whole lot of numbers
                                                        # also makes it a lot faster to calculate. just a general good idea. use relu for 99% of the time
        tf.keras.layers.Dropout(0.2), # Randomly sets input to 0, prevents overfitting (when your model is too tied to your training data)
        tf.keras.layers.Dense(32, activation='relu'), # Our second layer
        tf.keras.layers.Dense(16, activation='relu'), # Our second layer
        tf.keras.layers.Dense(1, activation='sigmoid'), # Our last layer. Notice activation=sigmoid. This gives us the probability of the output from 0 to 1. Our layer is also 1 wide, because we only want to output, if it survived or not
    ])     

def preprocess(df):
    df = df[['Temperature', 'Headache', 'Cough', 'Sneeze', 'Congestion', 'Disease']] # We're now interested in a lot of things
    
    def normalize_age(data): # Neural networks work MUCH better when all the data is close to 0, so here we scale it to be from 0 to 1
        print(data["Temperature"])
        data["Temperature"] = MinMaxScaler().fit_transform(data["Temperature"].values.reshape(-1,1))
        data["Disease"] = MinMaxScaler().fit_transform(data["Disease"].values.reshape(-1,1))
        return data
    
    df = normalize_age(df)
         
    df = df.dropna() # Drop rows with no data
    x_train, x_test, y_train, y_test = train_test_split(df[['Temperature', 'Headache', 'Cough', 'Sneeze', 'Congestion']], df['Disease'], test_size=0.33, random_state=42) # Our testing set is 1/3 of the original, and we set a random seed so it is the same every time
    
    return x_train, x_test, y_train, y_test

def initialize():
    train_df = pd.read_csv("symptomsData.csv")

    x_train, x_test, y_train, y_test = preprocess(train_df)                                             # If you want multiple outputs with probabilities, use softmax

    model.compile(optimizer='adam', # The algorithm to update our model during training. Just keep this
                loss='binary_crossentropy', # How the model measures how good it is. This is good for binary classification
                metrics=['accuracy']) # How we can monitor its progress

    model.fit(np.array(x_train), np.array(y_train), epochs=50) # Epochs is basically how long it runs

def predict(temp, headache, cough, sneeze, cong):
    result = model.predict([[104.8/105,0,1,0,0]])[0][0]
    diagnosis = ""
    confidence = 0

    if result < 0.3333333333:
        diagnosis = "COVID-19"
        confidence = ((0.3333333333-result)*3) * 100
    elif result < 0.6666666667:
        diagnosis = "Influenza"
        confidence = ((0.6666666667-result)*3) * 100
    else:
        diagnosis = "Common Cold"
        confidence = ((1-result)*3) * 100
    return diagnosis, confidence

if __name__ == '__main__':
    initialize()
    print(predict(98.6, 1, 1, 1, 1))