from rdkit import Chem
from rdkit.Chem import AllChem
from rdkit.Chem import Draw
#from rdkit import DataStructs
from rdkit.Chem.Fingerprints import FingerprintMols
import re
import sys


#Define clustering setup
def ClusterFps(tcfps,cutoff):
    from rdkit import DataStructs
    from rdkit.ML.Cluster import Butina
    for i in range(len(tcfps)):
        mol = truecyc1[i].rstrip()
        mol_l = mol.split("\t")
        #print (mol_l[1],end = "\t")	

    # first generate the distance matrix:
    dists = []
    nfps = len(tcfps)
    for i in range(1,nfps):
        sims = DataStructs.BulkTanimotoSimilarity(tcfps[i],tcfps[:i])
        dists.extend([1-x for x in sims])

    # now cluster the data:
    cs = Butina.ClusterData(dists,nfps,cutoff,isDistData=True)
    return cs
###Load True Cyclic Set
filename = sys.argv[1]
truecyc = []
truecyc1 = []
dists = []
with open(filename) as f:
        for line in f:
                lists =line
                truecyc.append(Chem.MolFromSmiles(lists))
                truecyc1.append(lists)
                #transformed_strings = np.array(truecyc1).reshape(-1,1)
f.close()
tcfps = [AllChem.GetMorganFingerprintAsBitVect(x,2,1024) for x in truecyc]
clusters=ClusterFps(tcfps,0.2)
print (clusters)
print (clusters[0])
