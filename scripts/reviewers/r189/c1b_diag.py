import sys, os, numpy as np
d=os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0,d); sys.path.insert(0,os.path.join(d,"..","r179"))
import core, weyl_invariants as WI
p=core.P
rng=np.random.default_rng(7); W=WI.random_weyl(5,p,rng)
P0=core.allP(W)
for plane in ((0,1),(2,3)):
    zeta=5
    g=core.plane_rot(zeta,*plane)
    Pg=core.allP(core.act(g,W))
    print(f"--- plane {plane}, zeta={zeta} ---")
    tab={}
    for idx,(lam,k) in enumerate(core.COV):
        if P0[idx]==(0,0): tab[(lam,k)]='P=0'; continue
        # ratio Pg/P0 in F_p[i]
        den=P0[idx]; nrm=(den[0]*den[0]+den[1]*den[1])%p
        if nrm==0: tab[(lam,k)]='isotropic'; continue
        invd=pow(nrm,p-2,p)
        r=core.gmul(Pg[idx],(den[0]*invd%p,(-den[1]*invd)%p))
        hit=None
        for kk in range(-9,10):
            if r==(pow(zeta,kk%(p-1),p),0): hit=kk; break
        tab[(lam,k)]=hit if hit is not None else f"not a power (r={r})"
    for key,v in tab.items(): print("   ",key,"->",v)
