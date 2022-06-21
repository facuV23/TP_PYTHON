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

Vmax_ADC=3.3
Vmin_ADC=0

p2=p*((Vmax_ADC-Vmin_ADC)/(Vmax-Vmin))+ ((Vmax_ADC-Vmin_ADC)/2)
res = float(Fs / (L-1)) 
n = np.array(range(0, L)) * res 


plt.figure(1)
plt.subplot(2,1,1)
plt.plot(t,p)
plt.xlabel("t(s)")
plt.ylabel("Voltaje")

plt.subplot(2,1,2)
plt.plot(n, p2)
plt.xlabel("frequencia, Hz")
plt.ylabel("Amplitud")

plt.show()