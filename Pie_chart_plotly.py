import plotly.graph_objs as go
from plotly.subplots import make_subplots
import plotly.express as px
import pandas as pd
import matplotlib.pyplot as plt
import sys
import plotly.io as pio
#pio.orca.config.use_xvfb = True
filename = sys.argv[1]
df = pd.read_csv(filename)
lst = list(df.groupby('Phylum'))
rows = 5
cols = 3
subplot_titles = [l[0] for l in lst]
specs = [[{'type':'domain'}] * cols] * rows
fig = make_subplots(
        rows=rows,
        cols=cols,
        subplot_titles=subplot_titles,
        specs=specs,
        print_grid=True)
for i, l in enumerate(lst):
    
    row = i // cols + 1
    
    
    col = i % (rows - 2) + 1
    
    
    d = l[1]
    fig.add_trace(
        go.Pie(labels=d["RiPPs"],
               values=d["count"],
               showlegend=False,
               textposition='inside',
               textinfo='label+value'),
         row=row,
         col=col
)
fig.update_layout(autosize=False,
    width=900,
    height=1300,
    margin=dict(
        l=50,
        r=50,
        b=50,
        t=70,
        pad=2
    ),title="RiPPs Distribution in Phylum",title_x=0.5,legend=dict(
    orientation="h",
    yanchor="bottom",
    y=1.02,
    xanchor="right",
    x=1
))
fig.show()
#fig.write_image('out.png',format='png',bbox_inches='tight',pad_inches=0.5,dpi=1000)
#fig.write_image('out.png')
