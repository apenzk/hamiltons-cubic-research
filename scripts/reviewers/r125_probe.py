"""Reviewer 125 -- (a) sign of the bracket, (b) top vs bottom, on random Weyl and
on numerically-found critical points."""
import numpy as np
from r125_lib import struct, sharp, Q, to_tensor, weyl_basis, project
np.set_printoptions(precision=6, suppress=True)

def pieces(M,c,pos,n,v):
    W=to_tensor(M,pos,n)
    K=np.zeros((n,n))
    for (a,b),k in pos.items(): K[a,b]=K[b,a]=M[k,k]
    A=np.zeros((n,n,n)); B=np.zeros((n,n,n,n))
    for a in range(n):
        A[a]=W[a,:,a,:]
        for b in range(n): B[a,b]=W[a,:,b,:]
    Rab=np.zeros((n,n))
    for (a,b),k in pos.items():
        r=np.sum(M[k,:]**2)-M[k,k]**2; Rab[a,b]=Rab[b,a]=r
    G=np.einsum('a,apq->pq',v,A); Goff=G-np.diag(np.diag(G))
    termK=v@(K**2)@v
    termB=sum(v[a]*v[b]*np.trace(B[a,b]@B[a,b]) for a in range(n) for b in range(n))
    Dt=np.array([np.sum(A[a]**2) for a in range(n)])
    br=termK-termB
    return dict(K=K,muK=v@K@v,Goff=np.sum(Goff**2),R=v@Rab@v,br=br,
                diagpart=-np.sum(v**2*Dt),offpart=br+np.sum(v**2*Dt),
                Gsq=np.sum(G**2),t=np.sum(K**2))

def run(n,ntrials=60,seed=1):
    b,pr,pos,N,c=weyl_basis(n)
    rng=np.random.default_rng(seed)
    print(f"===== n={n}  RANDOM WEYL (non-critical): sign census =====")
    negR_top=negBr_top=negOff_top=0
    for _ in range(ntrials):
        co=rng.standard_normal(len(b)); M=np.einsum('k,kab->ab',co,b); M/=np.linalg.norm(M)
        K=np.zeros((n,n))
        for (a,bb),k in pos.items(): K[a,bb]=K[bb,a]=M[k,k]
        ev,evec=np.linalg.eigh(K); v=evec[:,-1]
        d=pieces(M,c,pos,n,v)
        negR_top+= d['R']<0; negBr_top+= d['br']<0; negOff_top+= d['offpart']<0
    print(f"  top-eigvec: v'Rv<0 in {negR_top}/{ntrials};  bracket<0 in {negBr_top}/{ntrials};"
          f"  bracket-offpart<0 in {negOff_top}/{ntrials}")
    # extremes
    worstR=None
    for _ in range(400):
        co=rng.standard_normal(len(b)); M=np.einsum('k,kab->ab',co,b); M/=np.linalg.norm(M)
        K=np.zeros((n,n))
        for (a,bb),k in pos.items(): K[a,bb]=K[bb,a]=M[k,k]
        ev,evec=np.linalg.eigh(K); v=evec[:,-1]
        d=pieces(M,c,pos,n,v)
        if worstR is None or d['R']<worstR[0]: worstR=(d['R'],d['br'],d['offpart'],d['Goff'])
    print(f"  most negative v'Rv over 400 random: v'Rv={worstR[0]:+.6f} bracket={worstR[1]:+.6f}"
          f" offpart={worstR[2]:+.6f} ||Goff||^2={worstR[3]:.6f}")
    return b,pr,pos,N,c

def crit_search(n,b,c,pos,ntrials=40,seed=7):
    rng=np.random.default_rng(seed)
    print(f"===== n={n}  CRITICAL POINTS from random starts =====")
    found=[]
    for tr in range(ntrials):
        co=rng.standard_normal(len(b)); M=np.einsum('k,kab->ab',co,b); M/=np.linalg.norm(M)
        for it in range(6000):
            Gm=project(Q(M,c),b); lam=np.sum(Gm*M); r=Gm-lam*M
            if np.linalg.norm(r)<1e-13: break
            M=M+0.12*r; M/=np.linalg.norm(M)
        Gm=project(Q(M,c),b); lam=np.sum(Gm*M); res=np.linalg.norm(Gm-lam*M)
        if res>1e-9: continue
        K=np.zeros((n,n))
        for (a,bb),k in pos.items(): K[a,bb]=K[bb,a]=M[k,k]
        offd=np.linalg.norm(M-np.diag(np.diag(M)))
        ev,evec=np.linalg.eigh(K)
        dtop=pieces(M,c,pos,n,evec[:,-1]); dbot=pieces(M,c,pos,n,evec[:,0])
        found.append((round(lam,7),offd,ev[-1],ev[0],dtop,dbot,lam))
    seen={}
    for f in found:
        seen.setdefault(f[0],f)
    print(f"  distinct lambda values: {sorted(seen.keys())}")
    for lam,f in sorted(seen.items()):
        _,offd,evmax,evmin,dt,db,l=f
        print(f"  lam={l:.7f} offdiag(M)={offd:.4f} muKmax={evmax:.6f} t={dt['t']:.5f}")
        print(f"     TOP: lam*muK-muK^2={l*dt['muK']-dt['muK']**2:+.7f} = Goff {dt['Goff']:+.7f}"
              f" + R {dt['R']:+.7f} + br {dt['br']:+.7f} (diag {dt['diagpart']:+.7f} off {dt['offpart']:+.7f})")
        print(f"     BOT: lam*muK-muK^2={l*db['muK']-db['muK']**2:+.7f} = Goff {db['Goff']:+.7f}"
              f" + R {db['R']:+.7f} + br {db['br']:+.7f} (diag {db['diagpart']:+.7f} off {db['offpart']:+.7f})")
        print(f"     bound lambda<=muK_max: {'HOLDS' if l<=evmax+1e-9 else 'FAILS'}")

for n in (6,8):
    b,pr,pos,N,c=run(n)
    crit_search(n,b,c,pos)
