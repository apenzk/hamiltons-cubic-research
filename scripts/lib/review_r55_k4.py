"""Reviewer 55, K4: how high can an S=0 blow-up climb?

A k-block blow-up is COORDINATE-DIAGONAL on Lambda^2, so the whole class lives in
the diagonal locus and the vertex system is all that is needed.

For a graph G on k vertices with block sizes n_a, the symmetric ansatz
  c_aa = d_a (same block), c_ab = p_ab (G-edge, negative), c_ab = q_ab (non-edge)
is solved directly; theta = P/|W|^3 with
  |W|^2 = 1/2 sum lam_ij^2,   P = 1/2 ( sum lam_ij^3 + tr(lam^3) ).
"""
import numpy as np, itertools, sys
from scipy.optimize import least_squares, fsolve
sys.path.insert(0, 'scripts/lib')
from review_r55_core import theta0

def blowup_system(G, sizes):
    """Residual for the full k x k block matrix C (unknowns = upper triangle,
    with c_aa omitted when the block is a singleton).  Idempotent normalisation."""
    k=len(sizes); n=sum(sizes)
    idx=[(a,b) for a in range(k) for b in range(a,k) if a!=b or sizes[a]>=2]
    pos={p:t for t,p in enumerate(idx)}
    def unpack(x):
        C=np.zeros((k,k))
        for (a,b),t in pos.items(): C[a,b]=C[b,a]=x[t]
        return C
    def res(x):
        C=unpack(x); r=[]
        for (a,b) in idx:
            s=C[a,b]**2
            for dd in range(k):
                if dd==a or dd==b: continue
                s+=sizes[dd]*C[a,dd]*C[b,dd]
            if a!=b:
                s+=(sizes[a]-1)*C[a,a]*C[a,b] + (sizes[b]-1)*C[b,b]*C[a,b]
            else:
                s+=(sizes[a]-2)*C[a,a]**2
            r.append(s-C[a,b])
        for a in range(k):
            r.append((sizes[a]-1)*C[a,a] + sum(sizes[b]*C[a,b] for b in range(k) if b!=a))
        return np.array(r)
    return idx, unpack, res

def full_lam(C, sizes):
    lab=sum([[a]*b for a,b in enumerate(sizes)],[])
    lam=C[np.ix_(lab,lab)].astype(float); np.fill_diagonal(lam,0.0)
    return lam

def stats(C, sizes):
    """Block-level statistics: no n x n triangle enumeration."""
    k=len(sizes); n=sum(sizes); nn=np.array(sizes,dtype=float)
    # ||Lambda||^2 = sum_{i!=j} lam_ij^2 = sum_ab n_a n_b C_ab^2 - sum_a n_a C_aa^2
    nrm2 = 0.5*(float(np.einsum('a,b,ab->', nn, nn, C**2)) - float((nn*np.diag(C)**2).sum()))
    # sum_{i!=j} lam_ij^3
    s3 = float(np.einsum('a,b,ab->', nn, nn, C**3)) - float((nn*np.diag(C)**3).sum())
    # tr(Lambda^3): Lambda = M - diag pieces; M = blow-up including diagonal blocks
    M = C*np.sqrt(np.outer(nn,nn))       # similar to Lambda^2 blow-up spectrum carrier
    # exact: tr(Lambda^3) with Lambda_ij = C_ab (i!=j), 0 on the diagonal
    # write Lambda = B - D0 where B_ij = C_{a(i)a(j)} everywhere, D0 = diag(C_aa)
    # tr(B^3) = sum_abc n_a n_b n_c C_ab C_bc C_ca
    trB3 = float(np.einsum('a,b,c,ab,bc,ca->', nn, nn, nn, C, C, C))
    trB2 = float(np.einsum('a,b,ab->', nn, nn, C**2))
    trB  = float((nn*np.diag(C)).sum())
    d = np.repeat(np.diag(C), sizes.astype(int) if hasattr(sizes,'astype') else sizes)
    # tr((B-D)^3) = trB^3 - 3 tr(B^2 D) + 3 tr(B D^2) - tr(D^3)
    trB2D = float(np.einsum('a,b,ab,ab,b->', nn, nn, C, C, np.diag(C)))*1.0
    trB2D = float(np.einsum('a,b,ab,ba,b->', nn, nn, C, C, np.diag(C)))
    trBD2 = float(np.einsum('a,aa,a->', nn, C, np.diag(C)**2))
    trD3  = float((nn*np.diag(C)**3).sum())
    trL3 = trB3 - 3*trB2D + 3*trBD2 - trD3
    nrm = np.sqrt(nrm2)
    P = 0.5*(s3 + trL3)
    th = P/nrm**3
    # negative graph at BLOCK level
    negb = [[0]*k for _ in range(k)]
    for a in range(k):
        for b in range(k):
            if a!=b and C[a,b] < -1e-10: negb[a][b]=1
    within = [1 if (sizes[a]>=2 and C[a,a]<-1e-10) else 0 for a in range(k)]
    tri = 0
    for a in range(k):
        for b in range(a+1,k):
            for c in range(b+1,k):
                if negb[a][b] and negb[b][c] and negb[a][c]:
                    tri += sizes[a]*sizes[b]*sizes[c]
    for a in range(k):
        if within[a]:
            tri += sizes[a]*(sizes[a]-1)*(sizes[a]-2)//6
            for b in range(k):
                if b!=a and negb[a][b]:
                    tri += sizes[b]*sizes[a]*(sizes[a]-1)//2
    # connectivity / bipartiteness of the blown-up negative graph, at block level
    adjl={a:set() for a in range(k)}
    for a in range(k):
        for b in range(k):
            if negb[a][b]: adjl[a].add(b)
    active=[a for a in range(k) if adjl[a] or within[a]]
    col={}; comps=0; bip=True
    for s0 in active:
        if s0 in col: continue
        comps+=1; col[s0]=0; st=[s0]
        while st:
            u=st.pop()
            for v in adjl[u]:
                if v not in col: col[v]=1-col[u]; st.append(v)
                elif col[v]==col[u]: bip=False
    for a in range(k):
        if within[a] and sizes[a]>=2: bip=False       # an edge inside an independent block
    edges = sum(sizes[a]*sizes[b] for a in range(k) for b in range(a+1,k) if negb[a][b])
    edges += sum(sizes[a]*(sizes[a]-1)//2 for a in range(k) if within[a])
    rows=set(tuple(np.round(C[a],9)) for a in range(k))
    return dict(theta=th, n=n, ratio=th/theta0(n), tri=tri, bip=bip, comps=comps,
                distinct_rows=len(rows), edges=edges,
                isolated=sum(sizes[a] for a in range(k) if a not in col))

def solve_blowup(G, sizes, seeds=200, seed=0, want_sign=True):
    """Find the solution whose negative graph is exactly the blow-up of G."""
    k=len(sizes)
    idx,unpack,res = blowup_system(G,sizes)
    rng=np.random.default_rng(seed)
    out=[]
    for _ in range(seeds):
        x0=np.zeros(len(idx))
        for t,(a,b) in enumerate(idx):
            if a==b: x0[t]= abs(rng.normal(0.4,0.2))
            elif G[a][b]: x0[t]= -abs(rng.normal(0.3,0.2))
            else: x0[t]= abs(rng.normal(0.2,0.2))
        s=least_squares(res,x0,method='lm',xtol=1e-15,ftol=1e-15,gtol=1e-15,max_nfev=8000)
        if np.linalg.norm(s.fun)>1e-11 or np.linalg.norm(s.x)<1e-8: continue
        C=unpack(s.x)
        if want_sign:
            ok=True
            for a in range(k):
                for b in range(k):
                    if a==b: continue
                    if G[a][b] and not C[a,b]<0: ok=False
                    if (not G[a][b]) and C[a,b]<0: ok=False
                for _b in [a]:
                    if len(sizes)>0 and sizes[a]>=2 and C[a,a]<0: ok=False
            if not ok: continue
        out.append(C)
    # dedupe
    uniq=[]
    for C in out:
        if not any(np.allclose(np.sort(np.linalg.eigvalsh(full_lam(C,sizes))),
                               np.sort(np.linalg.eigvalsh(full_lam(C2,sizes))),atol=1e-7)
                   for C2 in uniq):
            uniq.append(C)
    return uniq

def cycle(k):
    G=[[0]*k for _ in range(k)]
    for a in range(k): G[a][(a+1)%k]=G[(a+1)%k][a]=1
    return G

def petersen():
    # Kneser(5,2)
    V=list(itertools.combinations(range(5),2)); k=len(V)
    G=[[0]*k for _ in range(k)]
    for i in range(k):
        for j in range(i+1,k):
            if not set(V[i])&set(V[j]): G[i][j]=G[j][i]=1
    return G

def kneser(nn,kk):
    V=list(itertools.combinations(range(nn),kk)); k=len(V)
    G=[[0]*k for _ in range(k)]
    for i in range(k):
        for j in range(i+1,k):
            if not set(V[i])&set(V[j]): G[i][j]=G[j][i]=1
    return G

def mycielski(G):
    k=len(G); m=2*k+1
    H=[[0]*m for _ in range(m)]
    for a in range(k):
        for b in range(k):
            H[a][b]=G[a][b]
    for a in range(k):
        for b in range(k):
            if G[a][b]: H[a][k+b]=H[k+b][a]=1
    for a in range(k):
        H[k+a][2*k]=H[2*k][k+a]=1
    return H

def complete_bip(p,q):
    k=p+q; G=[[0]*k for _ in range(k)]
    for a in range(p):
        for b in range(p,k): G[a][b]=G[b][a]=1
    return G
