import numpy as np
rng=np.random.default_rng(2); mk=(9,None); mm=(9,None)
for _ in range(2000000):
    v=np.array([np.sqrt(3)/2,*(np.ones(3)/np.sqrt(12)),0.0])+rng.normal(0,rng.choice([0.02,0.06,0.12]),5)
    v=np.abs(v); v/=max(1,np.linalg.norm(v))*np.sqrt(1+rng.random()*0.05)
    a,l,b=v[0],v[1:4],v[4]
    B=1-(a*a+l@l)
    if B<b*b-1e-12: continue
    slots=(a+l)**2; y=8-2*slots.sum()
    if y>0.277: continue
    mu6=slots.min()
    gK=mu6-a*a
    rest=max([((a-x)**2) for x in l]+[(l[i]+l[j])**2 for i in range(3) for j in range(i+1,3)]+[(x+b)**2 for x in l]+[x*x for x in l]+[(a-b)**2, 2*B])
    gM=mu6-rest
    if gK<mk[0]: mk=(gK,np.round(v,3),round(y,3))
    if gM<mm[0]: mm=(gM,np.round(v,3),round(y,3))
print('min gK',mk); print('min gM',mm)
