
# Commented out IPython magic to ensure Python compatibility.
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
# %matplotlib inline
import datetime as dt
from sklearn.cluster import DBSCAN

def get_infected_names(input_name,new_data):
    epsilon = 0.0018288 # a radial distance of 6 feet in kilometers
    model = DBSCAN(eps=epsilon, min_samples=2, metric='haversine').fit(new_data[['latitude', 'longitude']])
    new_data['cluster'] = model.labels_.tolist()
    labels = model.labels_
    # fig = plt.figure(figsize=(12,10))
    # sns.scatterplot(new_data['latitude'], new_data['longitude'], hue = ['cluster-{}'.format(x) for x in labels])
    # plt.legend(bbox_to_anchor = [1, 1])

    input_name_clusters = []
    for i in range(len(new_data)):
        if new_data['id'][i] == input_name:
            if new_data['cluster'][i] in input_name_clusters:
                pass
            else:
                input_name_clusters.append(new_data['cluster'][i])
    
    infected_names = []
    for cluster in input_name_clusters:
        if cluster != -1:
            ids_in_cluster = new_data.loc[new_data['cluster'] == cluster, 'id']
            for i in range(len(ids_in_cluster)):
                member_id = ids_in_cluster.iloc[i]
                if (member_id not in infected_names) and (member_id != input_name):
                    infected_names.append(member_id)
                else:
                    pass
    return infected_names

def predict_inf(df,name,ctime):
    
    df['timestamp'] = df['date'].astype('int64')
    inf_per = name
    inf_ts = ctime
    #new = df[df['id'] == inf_ per]
    #new = new.reset_index(drop=True)                             
    total_infected = []                                               
    for i in range(1, 169):
        #new_time = new['timestamp'][i]                       // 4:pm  3pm-4pm 2pm-3pm 1pm-2pm
        subs = i*3600     #                                      4-1 = 3  3 +1 = 4     4-2 = 2  2 +1 = 3    
        lb = inf_ts - subs
        ub = lb + 3600
        dat = df[df['timestamp'] >= lb]
        new_data = dat[dat['timestamp'] <= ub]
        new_data = new_data.reset_index(drop=True)
        if(len(new_data) > 0):
            result = get_infected_names(inf_per,new_data)
            if len(result) != 0:
              for i in result:
                    total_infected.append(i) 
    return total_infected
