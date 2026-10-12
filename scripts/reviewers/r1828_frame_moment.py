"""r1828 value check for the position file's averaging dead end: at the unit balanced product W_0 of S^m x S^m (n=2m), the diagonal mass t_F^2 in Haar-random frames F. Prints E[t_F^2] against Schur's 6/((n+1)(n+2)) and the ratio E[t_F^3]/E[t_F^2]^(3/2), which is O(1) exactly when the frame-average constant K grows like n^3. 400 frames per n. Run: sage -python r1828_frame_moment.py"""
import numpy as np, itertools
rng=np.random.default_rng(1828)
for n in (8,12,16,20):
    m=n//2; P=set(range(m)); pairs=list(itertools.combinations(range(n),2))
    Nn=(n-1)*(n-2); al=m*(m-1)/Nn; be=-(m-1)*(m-1)/Nn
    E=np.array([al if ((i in P)==(j in P)) else be for i,j in pairs]); E/=np.linalg.norm(E)
    I=np.array([i for i,j in pairs]); J=np.array([j for i,j in pairs])
    t2=[]
    for _ in range(400):
        G,R=np.linalg.qr(rng.standard_normal((n,n))); G=G*np.sign(np.diag(R))
        X=G[I][:,I]*G[J][:,J]-G[J][:,I]*G[I][:,J]   # rows (i,j), cols (a,b): Lambda^2 coords of f_a^f_b
        a=(E[:,None]*X**2).sum(0)
        t2.append((a**2).sum())
    t2=np.array(t2)
    print(n, "E t^2 =%.5f"%t2.mean(), "Schur 6/((n+1)(n+2)) =%.5f"%(6/((n+1)*(n+2))), "E t^3/(E t^2)^1.5 =%.4f"%((t2**1.5).mean()/t2.mean()**1.5), "max t over sample =%.4f"%np.sqrt(t2.max()))
