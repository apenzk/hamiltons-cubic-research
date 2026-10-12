"""Fast exact-structure L_e at S^p x S^q, and its full spectrum."""
import sys, itertools, numpy as np, scipy.sparse as spr
sys.path.insert(0, 'scripts/lib')

def pairs(n): return [(i,j) for i in range(n) for j in range(i+1,n)]

def cdict(n):
    P = pairs(n); idx = {pq:a for a,pq in enumerate(P)}
    C = {}
    for (i,j,k) in itertools.combinations(range(n),3):
        a,b,c = idx[(i,j)], idx[(j,k)], idx[(i,k)]
        # [phi_ij, phi_jk] = phi_ik  ->  c_{a b c} = +1, totally antisymmetric
        for (x,y,z),s in [((a,b,c),1),((b,c,a),1),((c,a,b),1),((b,a,c),-1),((a,c,b),-1),((c,b,a),-1)]:
            C[(x,y,z)] = s
    return C

def weyl_basis(n):
    """Orthonormal-in-Frobenius basis of Weyl_n, via a weighted coordinate system."""
    P = pairs(n); idx = {pq:a for a,pq in enumerate(P)}; D = len(P)
    coords = [(a,b) for a in range(D) for b in range(a,D)]
    cidx = {ab:t for t,ab in enumerate(coords)}
    wt = np.array([1.0 if a==b else np.sqrt(2.0) for (a,b) in coords])   # M -> wt*coord = Frobenius-orthonormal
    def add(row,i,j,k,l,val):
        if i==j or k==l: return
        s=val
        if i>j: i,j=j,i; s=-s
        if k>l: k,l=l,k; s=-s
        a,b = idx[(i,j)], idx[(k,l)]
        if a>b: a,b=b,a
        row[cidx[(a,b)]] += s
    rows=[]
    for (i,j,k,l) in itertools.combinations(range(n),4):
        r=np.zeros(len(coords)); add(r,i,j,k,l,1); add(r,i,k,l,j,1); add(r,i,l,j,k,1); rows.append(r)
    for i in range(n):
        for k in range(i,n):
            r=np.zeros(len(coords))
            for j in range(n): add(r,i,j,k,j,1)
            rows.append(r)
    Cst=np.array(rows)/wt[None,:]         # constraints in the weighted coordinates
    u,s,vt=np.linalg.svd(Cst)
    tol=max(Cst.shape)*np.finfo(float).eps*s[0]
    rank=int((s>tol).sum())
    N=vt[rank:]/wt[None,:]                # back to plain coords, orthonormal in Frobenius
    B=np.zeros((N.shape[0],D,D))
    for t,(a,b) in enumerate(coords):
        B[:,a,b]=N[:,t]; B[:,b,a]=N[:,t]
    return B, coords

def eps_of(p,q):
    n=p+q; out=[]
    for (i,j) in pairs(n):
        if i<p and j<p: out.append(q/((p-1)*(n-1)))
        elif i>=p and j>=p: out.append(p/((q-1)*(n-1)))
        else: out.append(-1.0/(n-1))
    return np.array(out)

def sharp_operator(n, eps):
    """sparse (D^2, D^2):  T[a,b] = sum_{m,qq} K[a,b,m,qq] Y[qq,m],  K = sum_r c_{a m r} eps_r c_{b r qq}."""
    C = cdict(n); D = n*(n-1)//2
    byam={}; brq={}
    for (a,m,r),v in C.items(): byam.setdefault((a,m),[]).append((r,v))
    for (b,r,qq),v in C.items(): brq.setdefault((r,qq),[]).append((b,v))
    rows=[]; cols=[]; vals=[]
    for (a,m),lst in byam.items():
        for (r,v1) in lst:
            w=v1*eps[r]
            if w==0: continue
            for qq in range(D):
                for (b,v2) in brq.get((r,qq),[]):
                    rows.append(a*D+b); cols.append(qq*D+m); vals.append(w*v2)
    M=spr.coo_matrix((vals,(rows,cols)),shape=(D*D,D*D)).tocsr()
    return M

def L_matrix(p,q,B=None):
    n=p+q; D=n*(n-1)//2
    eps=eps_of(p,q)
    if B is None: B,_=weyl_basis(n)
    dim=B.shape[0]
    M=sharp_operator(n,eps)
    Bf=B.reshape(dim,D*D)
    Tv=(M@Bf.T)                       # (D^2, dim)
    T=Tv.reshape(D,D,dim)
    Tsym=T+T.transpose(1,0,2)
    sharp=-0.25*Tsym                  # (D,D,dim)
    anti=0.5*(eps[:,None,None]+eps[None,:,None])*B.transpose(1,2,0)
    out=(anti+sharp).reshape(D*D,dim)
    return Bf@out

def s_m(m): return (m+2)*(m-1)//2
def c_m(m): return m*(m-1)//2

def predicted(p,q,dim):
    n=p+q; mu=(n-2)/(2*(p-1)*(q-1))
    lam=lambda m:(m-2)/(2*(m-1))
    d={}
    def put(v,k): d[round(v,12)]=d.get(round(v,12),0)+k
    put(-mu, s_m(p)*s_m(q)); put(mu, c_m(p)*c_m(q))
    put(lam(p), s_m(p)); put(lam(q), s_m(q))
    put(0.5, p*q); put(1.0, 1)
    named=sum(d.values())
    put(0.0, dim-named)
    return {k:v for k,v in d.items() if v>0}, named

def cluster(ev, tol=1e-7):
    ev=np.sort(ev); out=[]
    for x in ev:
        if out and abs(x-out[-1][0])<tol:
            out[-1]=( (out[-1][0]*out[-1][1]+x)/(out[-1][1]+1), out[-1][1]+1)
        else: out.append((x,1))
    return out

if __name__=="__main__":
    cases=[]
    for n in range(4,15):
        for p in range(2,n//2+1):
            cases.append((p,n-p))
    for (p,q) in cases:
        n=p+q
        B,_=weyl_basis(n); dim=B.shape[0]
        L=L_matrix(p,q,B)
        asym=np.max(np.abs(L-L.T))
        ev=np.linalg.eigvalsh((L+L.T)/2)
        cl=cluster(ev)
        pred,named=predicted(p,q,dim)
        # compare
        ok=True; report=[]
        pk=sorted(pred.items())
        ck=[(round(v,7),m) for v,m in cl]
        # match clusters to predicted
        used=[False]*len(ck)
        for v,m in pk:
            hit=None
            for i,(cv,cm) in enumerate(ck):
                if not used[i] and abs(cv-v)<1e-6: hit=i; break
            if hit is None or ck[hit][1]!=m:
                ok=False
                report.append(f"pred {v}^{m} -> got {ck[hit] if hit is not None else 'MISSING'}")
            else: used[hit]=True
        extra=[ck[i] for i in range(len(ck)) if not used[i]]
        if extra: ok=False; report.append(f"EXTRA clusters {extra}")
        mu=(n-2)/(2*(p-1)*(q-1))
        print(f"({p},{q}) n={n:2d} dim={dim:5d} mu={mu:.6f} |L-L^T|={asym:.1e} lam_max={ev[-1]:.9f} "
              f"2nd={ev[-2]:.9f} {'MATCH' if ok else 'MISMATCH'}", flush=True)
        if not ok:
            print("     spectrum:", [(round(v,6),m) for v,m in cl])
            for r in report: print("     ", r)
