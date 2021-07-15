import matplotlib as mpl
import matplotlib.pyplot as plt
import numpy as np
import os

# mpl.rcParams.update({'font.family': 'serif',
#     'text.usetex': True,
#     'axes.labelsize': 8,
#     'font.size': 8,
#     'legend.fontsize': 8,
#     'xtick.labelsize': 8,
#     'ytick.labelsize': 8 })

FOUT = 'roofline'

MAX_BANDWIDTH   = 13.601 # GBytes/s
SCALAR_PEAK  = 7.2
AVX_512_PEAK = 23.4

DATA = {'cis': [13637e6*0.7148/1.0034e9, # p3
                9773e6*0.1818/0.3457e9,  #p1
                15196e6*1.75/2.1e9,  # p5
                5375e6*0.32/0.34e9,  # p1, novec
                9507e6*1.06/0.99e9,  # p3, novec
               ],
        'MFlops/s': [13637,  # p3
                     9773,  # p1
                     15196,  # p5
                     5375,  # p1, novec
                     9507,  # p3, novec
                     ]}

CIS = np.logspace(-1, 2, 1000)

fig,ax = plt.subplots()

# shaded area
cis = CIS[MAX_BANDWIDTH*CIS > SCALAR_PEAK]
plt.fill_between(cis, 
                 np.minimum(MAX_BANDWIDTH*cis, SCALAR_PEAK),
                 np.minimum(MAX_BANDWIDTH*cis, AVX_512_PEAK),
                 color='lightgrey')

# memory bandwidth
plt.plot(CIS, np.minimum(MAX_BANDWIDTH*CIS, AVX_512_PEAK), c='lightgrey')

plt.scatter(DATA['cis'], np.array(DATA['MFlops/s'])/1e3, c='b', s=3)

plt.annotate('P3',
             (DATA['cis'][0], np.array(DATA['MFlops/s'][0])/1e3), 
             horizontalalignment='right',
             verticalalignment='center')

plt.annotate('P1',
             (DATA['cis'][1], np.array(DATA['MFlops/s'][1])/1e3), 
             horizontalalignment='right',
             verticalalignment='center')

plt.annotate('P5',
             (DATA['cis'][2], np.array(DATA['MFlops/s'][2])/1e3), 
             horizontalalignment='left',
             verticalalignment='center')

plt.annotate('P1, novec',
             (DATA['cis'][3], np.array(DATA['MFlops/s'][3])/1e3), 
             horizontalalignment='left',
             verticalalignment='center')

plt.annotate('P3, novec',
             (DATA['cis'][4], np.array(DATA['MFlops/s'][4])/1e3), 
             horizontalalignment='left',
             verticalalignment='center')

plt.xlabel('Flops/Byte')
plt.ylabel('GFlops/s')

plt.xlim(CIS[0], CIS[-1])
plt.ylim(1, 70)

plt.xscale('log')
plt.yscale('log')

fig.tight_layout()

plt.savefig('{}.png'.format(FOUT))
plt.show()

