# I73, step 9 route A's teeth test: great circles along the Weyl-projected class projectors at padded W_CP2, n = 12.
# They collapse to one direction with a = <L_W V,V> = 0, b = P(V) = 1.2016 < theta, so max_t g = theta. /usr/bin/python3, minutes.
import sys, numpy as np
sys.path.insert(0,__file__.rsplit('/',1)[0])
from screen_I73_pair_direction import pairs, structure_constants, weyl_projector, sharp_mat
from screen_I73_pair_blindness import padded_cp2, theta_and_checks
n=12; N=len(pairs(n)); c=structure_constants(n); Pi,_=weyl_projector(n)
W=padded_cp2(n); W=W/np.linalg.norm(W)
th,wy,cr=theta_and_checks(W,c,Pi,N); print('theta',th,'weyl res',wy,'crit res',cr)
P=lambda X: np.trace(X@X@X)+np.sum(X*sharp_mat(c,X,X))
ev,U=np.linalg.eigh(W); vals=np.round(ev,8)
classes={}
for k,v in enumerate(vals): classes.setdefault(v,[]).append(k)
proj={v:U[:,idx]@U[:,idx].T for v,idx in classes.items()}
print('classes',{float(v):len(i) for v,i in classes.items()})
def gmax(V):
    V=(Pi@V.ravel()).reshape(N,N); V=V-np.sum(V*W)*W; nv=np.linalg.norm(V)
    if nv<1e-10: return None
    V=V/nv; a=np.sum(V*(0.5*(W@V+V@W)+sharp_mat(c,W,V))); b=P(V)
    ts=np.linspace(0,2*np.pi,20001); g=th*np.cos(ts)**3+3*a*np.cos(ts)*np.sin(ts)**2+b*np.sin(ts)**3
    return a,b,g.max()
for v,Pv in proj.items(): print('class',float(v),'a,b,max g =',gmax(Pv))
rng=np.random.default_rng(0); best=0
keys=list(proj)
for _ in range(2000):
    gam=rng.normal(size=len(keys)); r=gmax(sum(g*proj[k] for g,k in zip(gam,keys)))
    if r and r[2]>best: best=r[2]; arg=gam
print('best max g over class combos',best,'vs theta',th, arg)
