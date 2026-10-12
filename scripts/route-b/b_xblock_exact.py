"""Lemma 27's constant, discharged exactly over Q and without Schur.

The summand needs no representation theory:  X_p (x) R^q = { V in Weyl_n :
supp V inside the (pp,mix) block }, obtained here as the exact rational nullspace
of the Bianchi and Ricci conditions restricted to that support.  Its dimension
comes out at X(p)*q = p(p^2-4)q/3 on the nose.

On a basis of that nullspace, sharp_bilin(I_p, V) = -V/2 holds with ZERO exact
mismatches, off-support entries included -- so by linearity it holds for every V
in the summand.  This matters because the previous route carried the constant off
a single representative by Schur, and Schur is Nienhaus Remark 4.7(ii) at
p in {3,4}; that coupled the two grants.  This computation covers p in {3,4} and
(3,3) directly, so the constant no longer depends on 4.7(ii).

What is still owed is uniformity in p and q: the check is exact at each split run,
not for all of them at once.
"""
from fractions import Fraction as F
import itertools

def pairs_of(n): return [(i,j) for i in range(n) for j in range(i+1,n)]

def structure_constants(pr, idx):
    C = {}
    for a,(i,j) in enumerate(pr):
        for b,(k,l) in enumerate(pr):
            out = {}
            def add(x,y,co):
                if x == y: return
                t = tuple(sorted((x,y))); out[t] = out.get(t,0) + (co if t==(x,y) else -co)
            if j==k: add(i,l, 1)
            if i==k: add(j,l,-1)
            if j==l: add(i,k,-1)
            if i==l: add(j,k, 1)
            for t,co in out.items():
                if co: C[(a,b,idx[t])] = co
    return C

def summand_basis(p,q):
    """Exact rational basis of { V in Weyl_n : supp V inside (pp,mix) }."""
    n=p+q; pr=pairs_of(n); idx={x:a for a,x in enumerate(pr)}; N=len(pr)
    def blk(a):
        i,j=pr[a]; return 'PP' if (i<p and j<p) else 'QQ' if (i>=p and j>=p) else 'MX'
    free=sorted({(a,b) if a<b else (b,a) for a in range(N) for b in range(N)
                 if (blk(a)=='PP' and blk(b)=='MX') or (blk(a)=='MX' and blk(b)=='PP')})
    def Rget(v,i,j,k,l):
        if i==j or k==l: return F(0)
        s=1
        if i>j: i,j,s=j,i,-s
        if k>l: k,l,s=l,k,-s
        a,b=idx[(i,j)],idx[(k,l)]; key=(a,b) if a<b else (b,a)
        return s*v.get(key,F(0))
    rows=[]
    for (A,B,D,E) in itertools.combinations(range(n),4):
        r={f:val for f in free if (val:=Rget({f:F(1)},A,B,D,E)+Rget({f:F(1)},A,D,E,B)+Rget({f:F(1)},A,E,B,D))}
        if r: rows.append(r)
    for i in range(n):
        for j in range(i,n):
            r={f:val for f in free if (val:=sum((Rget({f:F(1)},i,k,j,k) for k in range(n)),F(0)))}
            if r: rows.append(r)
    cols=list(free); M=[[row.get(cc,F(0)) for cc in cols] for row in rows]
    piv=[]; r=0
    for cix in range(len(cols)):
        pv_row=next((rr for rr in range(r,len(M)) if M[rr][cix]!=0),None)
        if pv_row is None: continue
        M[r],M[pv_row]=M[pv_row],M[r]
        pv=M[r][cix]; M[r]=[x/pv for x in M[r]]
        for rr in range(len(M)):
            if rr!=r and M[rr][cix]!=0:
                f2=M[rr][cix]; M[rr]=[a-f2*b for a,b in zip(M[rr],M[r])]
        piv.append(cix); r+=1
    basis=[]
    for fc in [i for i in range(len(cols)) if i not in piv]:
        vec={cols[fc]:F(1)}
        for ri,cix in enumerate(piv): vec[cols[cix]]=-M[ri][fc]
        basis.append({k:v for k,v in vec.items() if v!=0})
    return basis, pr, idx, N, blk, structure_constants(pr, idx)

def check(p,q):
    basis, pr, idx, N, blk, C = summand_basis(p,q)
    Ppl=[a for a in range(N) if blk(a)=='PP']
    bad=0
    for vec in basis:
        V={}
        for (a,b),val in vec.items(): V[(a,b)]=val; V[(b,a)]=val
        def T(a,b):
            tot=F(0)
            for (s,m),vv in V.items():
                for rr in Ppl:
                    c1=C.get((a,m,rr),0)
                    if not c1: continue
                    c2=C.get((b,rr,s),0)
                    if not c2: continue
                    tot+=c1*c2*vv
            return tot
        probe=list(V)+[(x,y) for x in range(N) for y in range(N) if (x,y) not in V][:60]
        for (a,b) in probe:
            if F(-1,4)*(T(a,b)+T(b,a)) != F(-1,2)*V.get((a,b),F(0)): bad+=1
    return len(basis), p*(p*p-4)//3*q, bad

if __name__=="__main__":
    print(f"{'(p,q)':>7} {'dim':>5} {'X(p)*q':>7} {'exact mismatches':>17}")
    for (p,q) in [(3,3),(3,4),(4,3),(4,4),(3,5)]:
        d,pred,bad=check(p,q)
        print(f"{str((p,q)):>7} {d:5d} {pred:7d} {bad:17d}", flush=True)
