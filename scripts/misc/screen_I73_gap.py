# Screen: for unit X with angles s (plus kernel), the 3-slot "+" configurations
# (triangle on planes {0,1,2} or star centred at 0 with leaves {1,2,3}),
# y = 8 - 2*sum of the three slot values, g = min slot value - max eigenvalue off E.
# Report the worst (x-y)/g over configs with y <= x, at x = 0.277.
import numpy as np, itertools
rng=np.random.default_rng(1)
X=0.277
def spectrum_off(s,E):
    m=len(s); vals=[]
    for a,b in itertools.combinations(range(m),2):
        vals.append(((s[a]+s[b])**2,('+',a,b)))
        vals.append(((s[a]-s[b])**2,('-',a,b)))
    for a in range(m): vals.append((s[a]**2,('k',a)))   # kernel present
    return max(v for v,t in vals if t not in E)
worst={'tri':0,'star':0}; arg={}
for trial in range(400000):
    m=rng.integers(3,7)
    typ='tri' if rng.random()<0.5 else 'star'
    if typ=='star' and m<4: m=4
    if typ=='tri': base=np.array([1,1,1]+[0]*(m-3),float)
    else: base=np.array([3,1,1,1]+[0]*(m-4),float)
    s=np.abs(base/np.linalg.norm(base)+rng.normal(0,rng.choice([0.02,0.05,0.1,0.2]),m))
    s/=np.linalg.norm(s)
    E={('+',0,1),('+',0,2),('+',1,2)} if typ=='tri' else {('+',0,1),('+',0,2),('+',0,3)}
    slotv=[(s[a]+s[b])**2 for _,a,b in E]
    y=8-2*sum(slotv)
    if y>X: continue
    g=min(slotv)-spectrum_off(s,E)
    if g<=0: r=np.inf
    else: r=(X-y)/g
    if r>worst[typ]: worst[typ]=r; arg[typ]=(np.round(s,4),round(y,4),round(g,4))
print(worst); print(arg)
