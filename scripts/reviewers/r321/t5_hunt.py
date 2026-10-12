import numpy as np, sys, itertools
sys.path.insert(0,'scripts/reviewers/r321')
from scipy.optimize import least_squares
np.set_printoptions(suppress=True, linewidth=200)

def proj_V(G, n):
    """orthogonal projection of a symmetric G onto V = {sym, hollow, row sums 0}."""
    gens=[]
    for i in range(n):
        D=np.zeros((n,n)); D[i,i]=1.0; gens.append(D)
    for i in range(n):
        e=np.zeros(n); e[i]=1.0
        gens.append(np.outer(np.ones(n),e)+np.outer(e,np.ones(n)))
    A=np.array([g.reshape(-1) for g in gens]).T
    x,_,_,_ = np.linalg.lstsq(A, G.reshape(-1), rcond=None)
    return G - (A@x).reshape(n,n)

def vec(M,n):
    iu=np.triu_indices(n,1); return M[iu]
def unvec(x,n):
    M=np.zeros((n,n)); iu=np.triu_indices(n,1); M[iu]=x; return M+M.T

def resid(x,n):
    M=unvec(x,n)
    N=M*M+M@M
    PN=proj_V(N,n)
    th=float((N*M).sum())/float((M*M).sum())
    R=PN-th*M
    return np.concatenate([vec(R,n), [ (M*M).sum()-2.0 ]])

def find_crit(n, rng, tries=400):
    out=[]
    for t in range(tries):
        M0=proj_V(unvec(rng.standard_normal(n*(n-1)//2),n),n)
        M0*=np.sqrt(2.0/ (M0*M0).sum())
        s=least_squares(resid, vec(M0,n), args=(n,), xtol=1e-14, ftol=1e-14, gtol=1e-14, max_nfev=3000)
        if s.cost<1e-20:
            M=unvec(s.x,n)
            if np.abs(M).max()>1e-6: out.append(M)
    return out

def graph_test(M,n,tol=1e-9):
    iu=np.triu_indices(n,1)
    vals=M[iu]
    if (np.abs(vals)<tol).any(): return None       # kernel present, skip
    k=int(np.argmin(vals)); i,j = iu[0][k], iu[1][k]
    if np.sum(np.abs(vals-vals[k])<1e-9)>1: mult=int(np.sum(np.abs(vals-vals[k])<1e-9))
    else: mult=1
    neg = M< -tol; pos = M> tol
    np.fill_diagonal(neg,False); np.fill_diagonal(pos,False)
    # blocks at v = e_i ^ e_j
    mm = int(sum(1 for k2 in range(n) if k2 not in (i,j) and neg[i,k2] and neg[j,k2]))
    pp = int(sum(1 for k2 in range(n) if k2 not in (i,j) and pos[i,k2] and pos[j,k2]))
    # global invariants
    Smmm = sum(1 for a,b,c in itertools.combinations(range(n),3) if neg[a,b] and neg[b,c] and neg[a,c])
    Smpp = 0
    for a,b,c in itertools.combinations(range(n),3):
        for (x,y,z) in [(a,b,c),(b,c,a),(c,a,b)]:
            if neg[x,y] and pos[y,z] and pos[x,z]: Smpp+=1
    return dict(minedge=(i,j),mult=mult,mm=mm,pp=pp,Smmm=Smmm,Smpp=Smpp,
                theta=float(((M*M+M@M)*M).sum())/2.0)

rng=np.random.default_rng(2026)
hitsA=[]; hitsB=[]
for n in [7,8,9,10]:
    crits=find_crit(n,rng, tries=250)
    print(f"n={n}: {len(crits)} diagonal critical points found")
    for M in crits:
        g=graph_test(M,n)
        if g is None or g['mult']>1: continue
        if g['Smmm']>0 and g['mm']==0: hitsA.append((n,M,g))
        if g['Smpp']>0 and g['pp']==0: hitsB.append((n,M,g))
print(f"\nCOUNTEREXAMPLE A (S_mmm>0 but m x m block = 0): {len(hitsA)} found")
for (n,M,g) in hitsA[:3]:
    print(f"  n={n} theta={g['theta']:.6f} min edge {g['minedge']} #neg-triangles={g['Smmm']} mm-count={g['mm']} pp-count={g['pp']}")
    np.save(f'/tmp/r321_ceA_n{n}.npy', M)
print(f"COUNTEREXAMPLE B (S_mpp>0 but p x p block = 0): {len(hitsB)} found")
for (n,M,g) in hitsB[:3]:
    print(f"  n={n} theta={g['theta']:.6f} min edge {g['minedge']} #mpp-triangles={g['Smpp']} pp-count={g['pp']}")
    np.save(f'/tmp/r321_ceB_n{n}.npy', M)
