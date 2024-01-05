#!/usr/bin/env python
import seaborn as sns
import matplotlib.pyplot as plt
import pandas as pd
import re
import sys
import os
filename = sys.argv[1]
df = pd.read_csv(filename)
fig = plt.subplots(figsize=(13,8))
g = sns.barplot(x = 'RiPPs',y = 'Count',data = df)
ax=g
#annotate axis = seaborn axis
for index, row in df.iterrows():
    g.text(row.name,row.Count, round(row.Count,2), color='black', ha="center")
plt.ylabel('BGC Count',fontweight ='bold', fontsize=10)
plt.xlabel('RiPPs',fontweight ='bold', fontsize=10)
plt.xticks(fontsize =8, rotation =45, ha='right')
plt.title('RiPP BGCs in Microbiome', fontweight ='bold',fontsize=10)
#plt.show()
plt.savefig('fig_1.png',format='png',bbox_inches='tight',pad_inches=0.5,dpi=1000)
