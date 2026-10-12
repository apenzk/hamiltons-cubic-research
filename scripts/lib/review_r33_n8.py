"""N8: is e o X = mu X exactly, for all p,q >= 2?  Exact rational arithmetic."""
import sys, itertools
from fractions import Fraction as F
sys.path.insert(0, 'scripts/lib')

def pairs(n): return [(i,j) for i in range(n) for j in range(i+1,n)]

def cstruct(n):
    """sparse structure constants: dict (a,b) -> list of (c, val).  c_{abc} totally antisym, values +-1."""
    P = pairs(n); idx = {pq:a for a,pq in enumerate(P)}
    # [phi_ij, phi_kl] = d_jk phi_il - d_ik phi_jl - d_jl phi_ik + d_il phi_jk
    C = {}
    def put(a,b,i,l,s):
        if i==l: return
        ii,ll,ss = (i,l,s) if i<l else (l,i,-s)
        C.setdefault((a,b),{}); C[(a,b)][idx[(ii,ll)]] = C[(a,b)].get(idx[(ii,ll)],0)+ss
    for (i,j) in P:
        a = idx[(i,j)]
        for (k,l) in P:
            b = idx[(k,l)]
            if j==k: put(a,b,i,l,1)
            if i==k: put(a,b,j,l,-1)
            if j==l: put(a,b,i,k,-1)
            if i==l: put(a,b,j,k,1)
    return {k:{c:v for c,v in d.items() if v!=0} for k,d in C.items()}

def c_full(n):
    """dense dict c[(a,b,c)] = val"""
    C = cstruct(n); out = {}
    for (a,b),d in C.items():
        for c,v in d.items(): out[(a,b,c)] = v
    return out

def eps_vec(p,q):
    n=p+q
    ePP = F(q,(p-1)*(n-1)); eQQ = F(p,(q-1)*(n-1)); ePQ = F(-1,n-1)
    out = []
    for (i,j) in pairs(n):
        if i<p and j<p: out.append(ePP)
        elif i>=p and j>=p: out.append(eQQ)
        else: out.append(ePQ)
    return out

def X_support(p,q):
    n=p+q; idx = {pq:a for a,pq in enumerate(pairs(n))}
    A_,B_,Cc,Dd = 0,1,p,p+1
    ent = {}
    def st(u,v,val):
        ent[(idx[u],idx[v])] = val; ent[(idx[v],idx[u])] = val
    st((A_,B_),(Cc,Dd), F(2,3))
    st((A_,Cc),(B_,Dd), F(1,3))
    st((A_,Dd),(B_,Cc), F(-1,3))
    return ent

def circ_eX(p,q):
    """returns dict (a,b)->Fraction for (e o X), e diagonal."""
    n=p+q; D=n*(n-1)//2
    C = c_full(n)
    # index c by (a,m) -> list of (r,val)   [c_{a m r}]
    by_am = {}
    for (a,m,r),v in C.items(): by_am.setdefault((a,m),[]).append((r,v))
    eps = eps_vec(p,q); Xe = X_support(p,q)
    out = {}
    # part 1: 1/2 (eX + Xe)_ab = (eps_a + eps_b)/2 X_ab
    for (a,b),v in Xe.items():
        out[(a,b)] = out.get((a,b),F(0)) + (eps[a]+eps[b])*v/2
    # part 2: sharp(e,X)_ab = -1/4 (T_ab + T_ba),  T_ab = sum_{(q,m) in supp} X_qm sum_r c_{amr} eps_r c_{brq}
    T = {}
    for (qq,mm),xv in Xe.items():
        for (a,m),lst in by_am.items():
            if m != mm: continue
            for (r,v1) in lst:
                w = xv*v1*eps[r]
                if w==0: continue
                for (b,rr,q2),v2 in ():
                    pass
                # need c_{b r q} : iterate over b with c_{b r qq} != 0
                for b in range(D):
                    v2 = C.get((b,r,qq))
                    if v2 is None: continue
                    T[(a,b)] = T.get((a,b),F(0)) + w*v2
    for (a,b),v in T.items():
        out[(a,b)] = out.get((a,b),F(0)) - v/4
        out[(b,a)] = out.get((b,a),F(0)) - v/4
    return {k:v for k,v in out.items() if v != 0}

def test(p,q, verbose=False):
    n=p+q
    mu = F(n-2, 2*(p-1)*(q-1))
    Xe = X_support(p,q); res = circ_eX(p,q)
    keys = set(res) | set(Xe)
    bad = []
    for k in keys:
        lhs = res.get(k, F(0)); rhs = mu*Xe.get(k, F(0))
        if lhs != rhs: bad.append((k, lhs, rhs))
    return mu, bad

if __name__ == "__main__":
    cases = [(2,2),(2,3),(2,4),(2,5),(2,6),(2,8),(3,3),(3,4),(3,5),(3,6),(3,7),(3,9),
             (4,4),(4,5),(4,6),(4,7),(4,8),(5,5),(5,6),(5,7),(6,6),(6,7),(7,7),(4,11),(5,10),(2,13),(3,12)]
    for (p,q) in cases:
        mu, bad = test(p,q)
        n=p+q
        flag = "OK " if not bad else f"FAIL({len(bad)})"
        print(f"  (p,q)=({p},{q}) n={n:3d} mu={str(mu):>10s}={float(mu):.6f}  {flag}", flush=True)
        if bad:
            for k,l,r in bad[:6]: print("      ", k, l, r)
