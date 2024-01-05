import numpy as np
import matplotlib.pyplot as plt
import os
import pandas as pd
import sys
barWidth = 0.25
filename = sys.argv[1]
data = os.path.join(os.getcwd(),filename)
f1 = open(data,"r")
Phylum=[]
Genome=[]
RiPPs=[]
for line in f1:
    line = line.strip("\n")
    if line.startswith('Phylum'):
        pass
    else:
        j = line.split(",")[1]
        Genome.append(int(j))
        k = line.split(",")[2]
        RiPPs.append(int(k))
        l = line.split(",")[0]
        Phylum.append(l)
print(Genome)
print(RiPPs)
print(Phylum)
fig = plt.subplots(figsize=(12,8))
br1 = np.arange(len(Genome))
br2 = [x + barWidth for x in br1]
plt.bar(br1, Genome, color ='cyan', width = barWidth,
        edgecolor ='grey', label ='Genome')
plt.bar(br2, RiPPs, color ='blue', width = barWidth,
        edgecolor ='grey', label ='RiPP BGCs')
plt.xlabel('Phylum', fontweight ='bold', fontsize = 15)
plt.ylabel('Log value', fontweight ='bold', fontsize = 15)
plt.xticks([r + barWidth for r in range(len(Genome))],
        Phylum, fontsize =8, rotation =45, ha='right')
plt.yscale("log")
plt.title("Phylum wise Genome distribution Vs RiPP BGCs Prediction")
plt.legend()
plt.savefig('fig3.png',format='png',bbox_inches='tight',pad_inches=0.5,dpi=1000)
