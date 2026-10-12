"""Brute force over small integer matrices on the diagonal locus: C4 and C5."""
import sys, itertools, numpy as np
sys.path.insert(0,'scripts/lib'); sys.path.insert(0,'scripts/reviewers/r291')
from r291_core import *

def components(G, n):
    seen=[-1]*n; c=0
    for s in range(n):
        if seen[s]>=0: continue
        st=[s]; seen[s]=c
        while st:
            u=st.pop()
            for v in range(n):
                if G[u,v] and seen[v]<0:
                    seen[v]=c; st.append(v)
        c+=1
    return seen, c

def structure_ok(M, n):
    """C4's right-hand side, read literally."""
    G = M > 0
    lab, k = components(G, n)
    blocks=[[i for i in range(n) if lab[i]==b] for b in range(k)]
    for B in blocks:                                  # constant inside each block
        vals={M[i,j] for i in B for j in B if i<j}
        if len(vals)>1: return False
    for A in blocks:                                  # constant on each ordered block pair
        for B in blocks:
            if A is B: continue
            vals={M[i,j] for i in A for j in B}
            if len(vals)>1: return False
            if max(vals)>0: return False              # inter-block entries <= 0
    return True

def cliques_and_twins(M,n):
    """the sub-claim: components of G+ are cliques and co-members are twins."""
    G=M>0; lab,k=components(G,n)
    for a in range(n):
        for b in range(a+1,n):
            if lab[a]==lab[b]:
                if not G[a,b]: return False, 'not-clique'
                for d in range(n):
                    if d!=a and d!=b and M[a,d]!=M[b,d]: return False,'not-twins'
    return True,''

def run(n, vals, seed_report):
    prs=pairs_of(n); N=len(prs)
    bad4=[]; bad5=[]; badsub=[]; nz=0
    for combo in itertools.product(vals, repeat=N):
        M=np.zeros((n,n))
        for a,(i,j) in enumerate(prs): M[i,j]=M[j,i]=combo[a]
        if np.abs(M@np.ones(n)).max()>0: continue
        if not np.any(M): continue
        nz+=1
        W=M_to_W(M)
        D,tot,S,g,lam=defect_mine(n,W)
        d0 = D < 1e-9
        s0 = structure_ok(M,n)
        if d0 != s0: bad4.append((combo, D, s0))
        sub,why = cliques_and_twins(M,n)
        if d0 != sub: badsub.append((combo,D,sub,why))
        Gm = M < 0
        if abs(S - 6*tri_count(Gm)) > 1e-6: bad5.append((combo,S,tri_count(Gm)))
    print(f"  n={n} vals={vals}: {nz} nonzero locus points; C4 mismatches={len(bad4)}"
          f"  subclaim mismatches={len(badsub)}  C5 mismatches={len(bad5)}")
    for x in bad4[:5]: print("    C4 counterexample:", x)
    for x in badsub[:5]: print("    subclaim counterexample:", x)
    for x in bad5[:5]: print("    C5 counterexample:", x)

run(4, (-2,-1,0,1,2), 0)
run(5, (-2,-1,0,1,2), 0)
