import numpy as np
import matplotlib.pyplot as plt
import os
import re
import sys
import pandas as pd
barWidth = 0.25
filename = sys.argv[1]
#data = os.path.join(os.getcwd(),'sort_fig_part2_final.csv')
#f1 = open(data,"r")
MOD_ENZY=[]
HHPRED=[]
HMMER=[]
with open(filename) as f:
	for line in f:
		line = line.strip("\n")
		if line.startswith('MOD'):
			pass
		else:
			j = line.split(",")[1]
			HHPRED.append(int(j))
			k = line.split(",")[2]
			HMMER.append(int(k))
			l = line.split(",")[0]
			MOD_ENZY.append(l)
		#print(Genome)
		#print(RiPPs)
		#print(Phylum)


# In[61]:


fig = plt.subplots(figsize=(12,8))
# Set position of bar on X axis
br1 = np.arange(len(HHPRED))
br2 = [x + barWidth for x in br1]
#make plot
plt.bar(br1, HHPRED, color ='cyan', width = barWidth,
        edgecolor ='grey', label ='HHPRED')
plt.bar(br2, HMMER, color ='blue', width = barWidth,
        edgecolor ='grey', label ='HMMER')
# Adding Xticks
plt.xlabel('MOD_ENZY', fontweight ='bold', fontsize = 15)
plt.ylabel('Avg Covg', fontweight ='bold', fontsize = 15)
#plt.xticks([r + barWidth for r in range(len(HHPRED))],
        MOD_ENZY, fontsize =8, rotation =45, ha='right')
#plt.yscale("log")
plt.title("Mod Enz HHPRED Vs HMMER Prediction")
plt.legend()
#plt.show()
plt.savefig('out.png',format='png',bbox_inches='tight',pad_inches=0.5,dpi=1000)
