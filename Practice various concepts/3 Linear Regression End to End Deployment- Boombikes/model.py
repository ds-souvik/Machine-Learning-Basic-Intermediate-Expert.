import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
import warnings
warnings.filterwarnings('ignore')


#Reading the dataset
df=pd.read_csv('day.csv')

# Converting date to Pandas datetime format
df['dteday'] = pd.to_datetime(df['dteday'])

#Changing the season, weathersit, mnth, weekday columns from numerical values to categorical strings
df.season=df.season.map({1:'spring', 2:'summer', 3:'fall', 4:'winter'})
df.weathersit=df.weathersit.map({1:'Best', 2:'Neutral', 3:'Bad', 4:'Worse'})
df.mnth=df.mnth.map({1:'Jan',2:'Feb',3:'Mar',4:'Apr',5:'May',6:'June',7:'Jul',8:'Aug',9:'Sep',10:'Oct',11:'Nov',12:'Dec'})
df.weekday=df.weekday.map({1:'Mon',2:'Tue',3:'Wed',4:'Thu',5:'Fri',6:'Sat',0:'Sun'})

#The column 'instant' is very insignificant. Hence dropping that column.
df=df.drop('instant',axis=1)

#Inserting a new variable day in the dataframe.
df.insert(4,'day','')
df['day']=pd.DatetimeIndex(df['dteday']).day

#dropping dteday
df=df.drop('dteday', axis=1)

df=df.drop(['casual', 'registered'],axis=1)
df=df.drop('atemp',axis=1,)

#Creating Dummy variables

def dummies(x,dataframe):
    temp = pd.get_dummies(dataframe[x], drop_first = True)
    dataframe = pd.concat([dataframe, temp], axis = 1)
    dataframe.drop([x], axis = 1, inplace = True)
    return dataframe
# Applying the function to the bikeSharing

df = dummies('season',df)
df = dummies('mnth',df)
df = dummies('weekday',df)
df = dummies('weathersit',df)

import sklearn
from sklearn.model_selection import train_test_split

df_train, df_test= train_test_split(df,train_size=0.7, random_state=100)

from sklearn.preprocessing import MinMaxScaler
scaler=MinMaxScaler()

need_rescale=['temp','hum','windspeed']
df_train[need_rescale]=scaler.fit_transform(df_train[need_rescale])

y_train=df_train.pop('cnt')
X_train=df_train

X_train=X_train[['Best', 'Neutral', 'spring', 'temp', 'winter', 'summer', 'hum', 'Jul', 'Sep', 'windspeed', 'yr', 'holiday']]

from sklearn.linear_model import LinearRegression
regressor=LinearRegression()

#Fitting model with training data
regressor.fit(X_train, y_train)

#Saving model to disk #wb=write bytes
import pickle
pickle.dump(regressor, open('model.pkl', 'wb'))

