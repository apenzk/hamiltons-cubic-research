# Screen c' = min over unit angle vectors a (sorted, nonneg, kernel present) of
# (8 - S6(a)) / dist^2(a, Ext), dist^2 = 2 - 2*max(<a,tri>, <a,star>) (sorted pairing).
import numpy as np, itertools
rng=np.random.default_rng(5)
def S6(a):
    m=len(a); v=[]
    for i,j in itertools.combinations(range(m),2):
        v+= [(a[i]+a[j])**2]*2 + [(a[i]-a[j])**2]*2
    for i in range(m): v+=[a[i]**2]*2*3   # kernel slots (plenty of kernel)
    v.sort(reverse=True); return sum(v[:6])
tri=np.array([1,1,1])/np.sqrt(3); star=np.array([3,1,1,1])/np.sqrt(12)
def dist2(a):
    s=np.sort(a)[::-1]
    return 2-2*max(s[:3]@tri, s[:4]@star if len(s)>=4 else 0)
best=(9,None)
for _ in range(300000):
    m=rng.integers(3,7)
    base=rng.choice(['tri','star','rand'])
    if base=='tri': a=np.array([1,1,1]+[0]*(m-3),float)/np.sqrt(3)
    elif base=='star':
        m=max(m,4); a=np.array([3,1,1,1]+[0]*(m-4),float)/np.sqrt(12)
    else: a=rng.random(m)
    a=np.abs(a+rng.normal(0,rng.choice([0.01,0.05,0.15,0.4]),m)); a/=np.linalg.norm(a)
    d=dist2(a)
    if d<1e-9: continue
    r=(8-S6(a))/d
    if r<best[0]: best=(r,np.round(np.sort(a)[::-1],4),round(d,5))
print(best)
