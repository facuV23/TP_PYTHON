from xmlrpc.client import _datetime_type
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
import csv


p=pd.read_csv("~/desktop/favaloro/labo de micro/TP_PYTHON/src/presion_tp1.csv")
print(type(p))
Fs=500
Ts=1/Fs

L=len(p)
K=np.arange(0,L)
t=K*Ts


Vmax=1
Vmin=-1



p2=p*((3.3-0)/(Vmax-Vmin))+ ((3.3-0)/2)
res = float(Fs / (L-1)) 
n = np.array(range(0, L)) * res 

S2_min= 0
S2_max=3.3




N1=8
D1_min=0
D1_max=2**N1-1
D1f=(p2*(D1_max/S2_max))
D1=round(p2*(D1_max/S2_max))
E1=D1-D1f


N2=12
D2_max=2**N2-1
D2f=(p2*(D2_max/S2_max))
D2=round(p2*(D2_max/S2_max))
E2=D2-D2f



N3=24
D3_max=2**N3-1
D3f=(p2*(D3_max/S2_max))
D3=round(p2*(D3_max/S2_max))
E3=D3-D3f



plt.figure(figsize=(10,7.5))
im1 = plt.subplot (3,1,1) 
plt.plot(t,D1)  
plt.plot(t, D1f)
plt.plot(t, E1)    
plt.grid(True)                                                                    
plt.xlabel('[s]')                                                         
plt.title("D1")


im1 = plt.subplot (3,1,2) 
plt.plot(t, D2)    
plt.plot(t, D2f)
plt.plot(t, E2)    
plt.grid(True)                                                                    
plt.xlabel('[s]')                                                         
plt.title("D2")


im1 = plt.subplot (3,1,3) 
plt.plot(t, D3)    
plt.plot(t, D3f)
plt.plot(t, E3)    
plt.grid(True)                                                                    
plt.xlabel('[s]')                                                         
plt.title("D3")    
plt.show()
