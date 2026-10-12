# Weighted star-side count. X0 angles: centre a1, leaves l2..l4 (top three), extra planes b, kernel.
# Budgets: kernel slots of the centre cost gK = mu6 - a1^2; first-order leaks cost gM = mu6 - max(rest);
# "+" slots to further planes are equal-angle (harmless, free).
# Partner distance: e_j >= sqrt(1 - align(k_j^2)^2) - m_j, align(kappa) for angles alpha^2-beta^2=kappa.
import numpy as np
from scipy.optimize import minimize
rng=np.random.default_rng(11)
P=8-2*(2+np.sqrt(3))
def phi(e2): return min(P, 6*e2*(1-e2/4))
def align(kap):
    kap=min(max(kap,0),1); al=np.sqrt((1+kap)/2); be=np.sqrt((1-kap)/2)
    return max(np.sqrt(3)/2*al+be/np.sqrt(12), (al+be)/np.sqrt(3))
def total(v,gK,gM,budget):
    k2=np.abs(v[:6]); m=np.abs(v[6:])
    s=gK*k2.sum()+gM*(m**2).sum()
    if s>budget+1e-9: return 9+s
    out=0
    for j in range(6):
        e=np.sqrt(max(0,1-align(k2[j])**2))-m[j]
        out+=phi(max(e,0)**2)
    return out
worst=(9,None)
for trial in range(3000):
    a1=np.sqrt(3)/2+rng.normal(0,0.05); l=np.abs(1/np.sqrt(12)+rng.normal(0,0.05,3)); b=abs(rng.normal(0,0.08))
    v=np.array([a1,*l,b]); v/=np.linalg.norm(v); a1,l,b=v[0],v[1:4],v[4]
    slots=[(a1+x)**2 for x in l]; mu6=min(slots)
    y=8-2*sum(slots)
    if y>0.277 or y<0: continue
    rest=max([(a1-x)**2 for x in l]+[(l[i]+l[j])**2 for i in range(3) for j in range(i+1,3)]+[(x+b)**2 for x in l]+[x**2 for x in l]+[b*b])
    gK=mu6-a1**2; gM=mu6-rest
    if gK<=0 or gM<=0: continue
    x=rng.uniform(y,0.277); budget=x-y
    best=9
    for r in range(8):
        v0=np.abs(rng.normal(0,1,12)); v0*=np.sqrt(budget/(gK*v0[:6].sum()+gM*(v0[6:]**2).sum()))
        res=minimize(lambda v: total(v,gK,gM,budget),v0,method='Nelder-Mead',options={'maxiter':2000})
        best=min(best,res.fun,total(v0,gK,gM,budget))
    margin=best-(1.936-x)
    if margin<worst[0]: worst=(margin,(np.round(v,3),round(x,3),round(y,3),round(gK,3),round(gM,3),round(best,3)))
print('worst margin (partners deficit - needed):',worst)
