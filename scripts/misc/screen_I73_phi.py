import numpy as np
exec(open(__file__.replace('screen_I73_phi.py','screen_I73_stability.py')).read().split('best=(9,None)')[0])
rng=np.random.default_rng(7)
bins=np.array([0.02,0.05,0.08,0.1,0.15,0.2,0.3,0.4]); mins={b:9 for b in bins}
for _ in range(400000):
    m=rng.integers(3,7); base=rng.choice(['tri','star','rand'])
    if base=='tri': a=np.array([1,1,1]+[0]*(m-3),float)/np.sqrt(3)
    elif base=='star':
        m=max(m,4); a=np.array([3,1,1,1]+[0]*(m-4),float)/np.sqrt(12)
    else: a=rng.random(m)
    a=np.abs(a+rng.normal(0,rng.choice([0.01,0.05,0.15,0.4]),m)); a/=np.linalg.norm(a)
    d=dist2(a); dfc=8-S6(a)
    for b in bins:
        if d>=b: mins[b]=min(mins[b],dfc)
for b in bins: print('dist2>=%.2f  min deficit %.4f  ratio %.2f'%(b,mins[b],mins[b]/b))
