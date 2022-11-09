# -*- coding: utf-8 -*-
"""
Spyder Editor

This is a temporary script file.
"""
import numpy as np
import pandas as pd

df=pd.read_excel(r"C:\Users\cleme\Downloads\example_data_cleaning.xlsx")
df = pd.DataFrame(df)
df.head(10)

df_missing=df.isna().sum()

df=df.drop(30, axis = 0)

df=df.drop("Unnamed: 7", axis = 1)

df.duplicated().any()

df=df.drop("Unnamed: 8", axis = 1)

df_desc=df.describe()

df=df.drop("Department", axis = 1)

df=df.replace(2.39909e+06, np.nan)
df['Amount'].fillna((df['Amount'].mean()), inplace=True)

a = df.plot.bar(x='BirthYear', y='ClientID', rot=0)

df=df.drop(2, axis = 0)
df=df.drop(13, axis = 0)

