"""C7, C8, C9 at diagonal critical points, plus the vacuity and contraction probes."""
import sys, numpy as np
sys.path.insert(0,'scripts/lib'); sys.path.insert(0,'scripts/reviewers/r291')
from r291_core import *
from r291_c6 import ascent
from review_r30_core import sphere_product_W
from b_c5_blowup import c5_operator

def rows(M):
    return np.sum(M*M, axis=1)

def crit_res(M, th):
    n=M.shape[0]
    return float(np.abs(M*M + M@M - th*M - np.diag(rows(M))).max())

def report(n, M, lbl):
    M = M/np.sqrt(0.5*np.sum(M*M))
    th = theta_diag(M); s = rows(M)
    D,tot,S,g,lam = defect_diag(n, M)
    prs = pairs_of(n)
    gC7 = np.array([2*(s[a]+s[b]) - 4*th*M[a,b] for (a,b) in prs])
    e7 = np.abs(g - gC7).max()
    # C8
    slack = np.array([s[a]+s[b]-2*th*M[a,b] for (a,b) in prs])
    twins = np.array([all(abs(M[a,d]-M[b,d])<1e-9 for d in range(n) if d not in (a,b))
                      for (a,b) in prs])
    e8 = max(abs(slack[twins]).max() if twins.any() else 0.0, 0.0)
    pos = np.array([M[a,b]>0 for (a,b) in prs])
    cap = min((s[a]+s[b])/(2*M[a,b]) for (a,b) in prs if M[a,b]>0)
    # C9
    dplus = np.array([np.sum(M[a]>0) for a in range(n)])
    L1 = sum(abs(M[a,b]) for (a,b) in prs)
    e9 = th*L1 - (dplus@s - D/2)
    print(f"  {lbl:26s} th={th:+.6f} crit={crit_res(M,th):.1e} |C7|={e7:.2e} "
          f"minslack={slack.min():+.3e} eq@twins={e8:.1e} cap={cap:.6f} cap-th={cap-th:+.3e} "
          f"|C9|={abs(e9):.2e} Delta={D:.4f} S={S:.1f}")
    return th, cap, D, S

print("=== C7/C8/C9 at catalogued diagonal critical points ===")
for blocks in ([3,3],[6,6],[4,8],[5,7],[2,2],[2,4],[4,4],[5,5]):
    n=sum(blocks); W,_=sphere_product_W(blocks)
    M=np.zeros((n,n))
    for a,(i,j) in enumerate(pairs_of(n)): M[i,j]=M[j,i]=W[a,a]
    report(n,M,f"S^{blocks[0]}xS^{blocks[1]} n={n}")
Wc,_=c5_operator([2]*5); n=10
Mc=np.zeros((n,n))
for a,(i,j) in enumerate(pairs_of(n)): Mc[i,j]=Mc[j,i]=Wc[a,a]
report(10,Mc,"C_5 blow-up n=10")

print("\n=== C7/C8/C9 at critical points found by ascent (incl. non-maximal) ===")
rng=np.random.default_rng(77)
seen=[]
for n in (5,6,7,8):
    B=locus_basis(n)
    for r in range(12):
        v=ascent(n,B,rng.normal(size=B.shape[0])@B, iters=6000, step=0.08)
        M=vec_to_M(n,v); M=M/np.sqrt(0.5*np.sum(M*M))
        th=theta_diag(M)
        if crit_res(M,th)>1e-7: continue
        key=(n,round(th,6))
        if key in seen: continue
        seen.append(key)
        report(n,M,f"ascent n={n} #{r}")

print("\n=== is C8 vacuous?  max over the NON-critical locus of 2 theta M_ab - (s_a+s_b) ===")
def viol(n, v):
    M=vec_to_M(n,v); M=M/np.sqrt(0.5*np.sum(M*M))
    th=theta_diag(M); s=rows(M)
    return max(2*th*M[a,b]-(s[a]+s[b]) for (a,b) in pairs_of(n))
for n in (5,6,8,10,12):
    B=locus_basis(n); best=-9; bM=None
    for r in range(3000):
        v=rng.normal(size=B.shape[0])@B; v/=np.linalg.norm(v)
        x=viol(n,v)
        if x>best: best=x; bv=v.copy()
    # polish by random local search
    for t in range(6000):
        w=bv+0.05*(rng.normal(size=B.shape[0])@B); w/=np.linalg.norm(w)
        x=viol(n,w)
        if x>best: best=x; bv=w
    print(f"  n={n}: max violation of C8 off criticality = {best:+.4f}")

print("\n=== entry-free push: sup over the unit locus of min_+ (s_a+s_b)/(2 M_ab) ===")
def cap_of(n,v):
    M=vec_to_M(n,v); M=M/np.sqrt(0.5*np.sum(M*M)); s=rows(M)
    c=[(s[a]+s[b])/(2*M[a,b]) for (a,b) in pairs_of(n) if M[a,b]>1e-12]
    return min(c) if c else -9
for n in (4,6,8,10):
    B=locus_basis(n); best=-9
    for r in range(2000):
        v=rng.normal(size=B.shape[0])@B; v/=np.linalg.norm(v)
        x=cap_of(n,v)
        if x>best: best=x; bv=v.copy()
    for t in range(8000):
        w=bv+0.08*(rng.normal(size=B.shape[0])@B); w/=np.linalg.norm(w)
        x=cap_of(n,w)
        if x>best: best=x; bv=w
    print(f"  n={n}: sup of the cap over the locus >= {best:.6f}   theta_0={np.sqrt(2*(n-1)*(n-2))/n:.6f}")
