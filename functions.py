import json
import os
import re
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import datetime
import tensorflow as tf
import seaborn as sns



def autolabel(rects,ax):
    """Attach a text label above each bar in *rects*, displaying its height."""
    for rect in rects:
        height = rect.get_height()
        ax.annotate('{:.0f}'.format(height),
                    xy=(rect.get_x() + rect.get_width() / 2, height),
                    xytext=(0, 3),  # 3 points vertical offset
                    textcoords="offset points",
                    ha='center', va='bottom')


def loadLog(filePath):
    """Loads json from path and converts to dataframe.

        Parameters
        ----------
        filePath : str, required
        
        the path of the file

        Returns
        ------
        obj
        
        Pandas DataFrame object
        
        """

    dirname = os.path.abspath('')
    log = os.path.join(dirname, 'data/'+filePath)
    with open(log) as json_file:
        data = json.load(json_file)
    return pd.json_normalize(data)



def compareDates(df,df1):
    
    """makes comparisons of timelines available in slow and general logs
       -converts string to float
       -calculates and prints timelines of the logs
       -visualizes logs activites(number of requests per minute) in lineplot for each log
       -views and printsdescriptive stats (number of requests per minute) for each log
       -summarizes the above in boxplot
       -calculates the differences between the number of activities recorded in each log
       -plot the above on the scatter plot
       
        Parameters
        ----------
        df : pandas.dataFrame, required
        df1 : pandas.dataFrame, required

        """
    gen=df['event_time'].map(lambda x: x[:19]).value_counts().sort_index()
    slow=df1['start_time'].map(lambda x: x[:19]).value_counts().sort_index()
    
    print("General log timeline is over: ")
    print(datetime.datetime.strptime(max(df['event_time']), '%Y-%m-%d %H:%M:%S.%f')-datetime.datetime.strptime(min(df['event_time']), '%Y-%m-%d %H:%M:%S.%f'))
    print("_______________________________")
    print("Slow log timeline is over: ")
    print(datetime.datetime.strptime(max(df1['start_time']), '%Y-%m-%d %H:%M:%S.%f')-datetime.datetime.strptime(min(df1['start_time']), '%Y-%m-%d %H:%M:%S.%f'))
    
    merged= pd.concat([gen, slow], axis=1).fillna(0).sort_index()
    fig, ax = plt.subplots()
    fig.set_size_inches(15, 7, forward=True)
    
    y = list(range(merged.shape[0]))
    logs = ['event_time', 'start_time']
    
    
    rects1 = ax.plot(y,merged['event_time'], alpha=0.3,label='General log')
    rects2 = ax.plot(y, merged['start_time'], alpha=0.3, label='Slow log')
    # Plot formatting
    plt.legend(prop={'size': 10}, title = 'Logs')
    plt.title('Requests per minute reported by both logs')
    plt.xlabel('Timeline (minutes)')
    
    plt.ylabel('Number of requests')
    plt.show()
    
    print(merged[['event_time','start_time']].describe())
    
    fig, ax = plt.subplots()
    fig.set_size_inches(15, 7, forward=True)
    ax.set_title('Number of requests per minute')
    ax.boxplot(merged[['event_time','start_time']].T)
    ax.set_xticklabels(['General Log', 'Slow Log'])
    plt.show()
    
    differences=abs(merged['event_time']- merged['start_time'])
    print("Logs provide "+ str(differences[differences>0].shape[0])+ " different values regarding number of requests per minute")
    print("__________________________")
    
    
    
    plt.figure(figsize=(10,5))
    plt.title("Request number per minute differences")
    plt.xlabel('Timeline (minutes)')
    plt.ylabel('Difference in requests per minute')
    plt.scatter(range(differences.shape[0]),differences)
    plt.ylim(bottom=1.)
    
    
    
def clean(s):
    """- Removes text between */ /*
       - removes spaces in from nad behind the string

        Parameters
        ----------
        s : str, required
        
        string to preprocess

        Returns
        ------
        s: str
        """
    s = re.sub('\s+', ' ', s)
    try:
        s=re.search(r'(.*)/(.*)',s).group(2)
    except:
        pass
    return s.strip()


def getCapitalWords(df):
    """Gets words written in capital letters.

        Parameters
        ----------
        df : obj, pandas dataframe
        

        Returns
        ------
        list :str
        
        list of strings
        """
    arr=set()
    for i in df:
        try:
            for u in i.split():
                s=''.join(re.findall('([A-Z])', u))
                arr.add(s)
        except:
            pass
    return arr