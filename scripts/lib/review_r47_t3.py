"""T3: is S=0 near-automatic only when dim m is small?
Hunt for S=0 ungraded critical points with LARGE dim m."""
import numpy as np, itertools
from review_r47_core import *

def kblock(g, blocks):
    """Weyl operator of S^{n_1} x ... x S^{n_k}, diagonal in coordinate 2-planes."""
    n = g.n; assert sum(blocks)==n
    lab = np.concatenate([[a]*nb for a,nb in enumerate(blocks)])
    w = np.zeros(g.N)
    for idx,(i,j) in enumerate(g.prs):
        a,b = lab[i],lab[j]
        if a!=b: w[idx] = -1.0/(n-1)
        else:    w[idx] = (n-blocks[a])/((n-1)*(blocks[a]-1))
    M = np.diag(w); return M/np.linalg.norm(M)

def support_rank(g, M, tol=1e-9):
    """dimension of the smallest V <= R^n with W in Lambda^2 V"""
    R = g.mat_to_tensor(M)
    G = np.einsum('iklm,jklm->ij', R, R)
    ev = np.linalg.eigvalsh(G)
    return int((ev > tol*max(1.0,ev.max())).sum())

def report(tag, g, M):
    th,res = crit_residual(g,M)
    st = struct_sums(g,M)
    sup = support_rank(g,M)
    graded = (st['leak'] < 1e-16*max(1.0,st['total'])) and (st['S'] < 1e-16*max(1.0,st['total']))
    ncond = 0 if st['dim_m']<3 else st['dim_m']*(st['dim_m']-1)*(st['dim_m']-2)//6
    print(f" {tag:34s} n={g.n:2d} th={th:.9f} res={res:.1e} dim_m={st['dim_m']:3d} "
          f"dim[m,m]={st['dim_mm']:3d} #S-eqs={ncond:5d} S={st['S']:.3e} leak={st['leak']:9.4f} "
          f"supp={sup:2d} {'GRADED' if graded else 'ungraded'}")
    return st


def cp_m(m):
    """W_{CP^m} as the U(m)-invariant line in Weyl_{2m}"""
    n=2*m; g=Geom(n); Bas=g.weyl_basis()
    J=np.zeros((n,n))
    for a in range(m): J[2*a,2*a+1]=1.0; J[2*a+1,2*a]=-1.0
    A=g.so_basis()
    rows=np.array([(X@J-J@X).ravel() for X in A]).T
    _,sv,Vt=np.linalg.svd(rows); rk=int((sv>1e-10*sv[0]).sum())
    um=np.einsum('ka,aij->kij',Vt[rk:],A)
    rr=[]
    for X in um:
        adX=g.ad(X); rr.append(np.array([(adX@V-V@adX).ravel() for V in Bas]).T)
    _,sv,Vt=np.linalg.svd(np.concatenate(rr,axis=0)); rk=int((sv>1e-9*sv[0]).sum())
    line=np.einsum('ka,aij->kij',Vt[rk:],Bas)
    W=line[0]/np.linalg.norm(line[0])
    if crit_residual(g,W)[0]<0: W=-W
    return g,W



if __name__ == "__main__":
    print("### is W_CP2 graded in its NATIVE dimension 4?")
    g4,W4 = cp_m(2)
    report("W_CP2 native (n=4)", g4, W4)
    g6,W6 = cp_m(3)
    report("W_CP3 native (n=6)", g6, W6)
    g8c,W8c = cp_m(4)
    report("W_CP4 native (n=8)", g8c, W8c)

    print("\n### padded CP^m: S survives, gradedness does not")
    for (gs,Ws,tag) in ((g4,W4,"W_CP2"),(g6,W6,"W_CP3")):
        for n in (8,10,12):
            if n<=gs.n: continue
            gb=Geom(n); report(f"{tag} padded -> n={n}", gb, pad(gs,gb,Ws))

    print("\n### THE ATTACK: graded points with LARGE dim m, padded")
    for (p,q,ns) in ((3,3,(8,10,12)),(4,4,(10,12)),(5,5,(12,14)),(6,6,(14,))):
        gs=Geom(p+q); Ws=sphere_product(gs,p,q)
        report(f"S^{p}xS^{q} native", gs, Ws)
        for n in ns:
            gb=Geom(n); report(f"S^{p}xS^{q} padded -> n={n}", gb, pad(gs,gb,Ws))

    print("\n### control: genuinely ungraded full-support points (multi-block, k>=3)")
    for blocks in ((2,2,2),(2,2,4),(3,3,3),(4,4,4),(2,2,2,2)):
        n=sum(blocks); g=Geom(n); report(f"blocks {blocks}", g, kblock(g,blocks))

