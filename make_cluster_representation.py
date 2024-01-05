from reportlab.lib import colors
from reportlab.lib.units import cm
from Bio.Graphics import GenomeDiagram
from Bio import SeqIO
from Bio.SeqFeature import SeqFeature, FeatureLocation
from sys import argv
import os

pathname = os.path.join(argv[2], argv[1])
#inputfile = directory/inputfile
record = SeqIO.read(pathname, "genbank")
gd_diagram = GenomeDiagram.Diagram(record.id)
#print(gd_diagram)
gd_track_for_features = gd_diagram.new_track(1, name="Annotated Features")
#print(gd_track_for_features)
gd_feature_set = gd_track_for_features.new_set()
#print(gd_feature_set)
for feature in record.features:
	#print(feature.type)
	color=colors.lightblue
	if feature.type != "gene":
		pfam_annotations = feature.qualifiers.get("product")
		if pfam_annotations is not None:
			#print(pfam_annotations)
			pfam_annotations_str = ''.join(pfam_annotations)
			if 'XME' in pfam_annotations_str:	#NRPS AD Domain
				#print('aa')
				color = colors.firebrick
			elif 'Others' in pfam_annotations_str:		#PKS AT Domain
				color = colors.olive
			else:
				color = colors.blue
			#print(color)
			gd_feature_set.add_feature(feature, sigil="ARROW", color=color, label=True, label_size=9, label_angle=70) 
			continue
		continue
outfile = os.path.join(argv[2], argv[1]+'_fig.png')
gd_diagram.draw(format="linear",  pagesize=(25*cm,6*cm), fragments=1,
                start=0, end=len(record))
gd_diagram.write(outfile, "PNG")

