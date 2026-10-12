"""Falsifier screen for E(W) <= C t_max(W) on unit Weyl W (reviews/2026-09-28d-I121-smallmass-direct.md), run from the repository root as sage -python scripts/misc/screen_I121_E_vs_tmax.py <n> <rounds> <seed>: alternate (1) ascent of t^2 over O(n) from the frames found so far plus random ones, (2) a gradient step on W raising E(W) - mu * softmax_i t^2(g_i W). Report E and a thorough final t_max."""
import numpy as np, itertools, sys, runpy
import scipy.linalg as sla
n=int(sys.argv[1]); rounds=int(sys.argv[2]); seed=int(sys.argv[3]) if len(sys.argv)>3 else 0
sys.argv=['x',str(n)]
g=runpy.run_path('scripts/misc/check_I121_rectangle_cubic.py')
Qb=g['Qb']; idx=g['idx']; N=g['N']
# Weyl basis: reuse the screen construction
S=runpy.run_path('scripts/misc/screen_I121_matching_feasible.py',run_name='notmain') if False else None
pairs=list(idx.keys())
# build W_n basis by projection: symmetric N x N, Bianchi, Ricci-free (as in the screen scripts)
def ent(a,b,c,d):
    s=1
    if a>b: a,b=b,a; s=-s
    if c>d: c,d=d,c; s=-s
    return s,idx[(a,b)],idx[(c,d)]
sym=[]
for i in range(N):
    for j in range(i,N):
        M=np.zeros((N,N)); M[i,j]=M[j,i]=1; sym.append(M)
rows=[]
for a,b,c,d in itertools.combinations(range(n),4):
    for M in []: pass
def constraints(R):
    out=[]
    for a,b,c,d in itertools.combinations(range(n),4):
        v=0
        for (x,y,z,w) in [(a,b,c,d),(b,c,a,d),(c,a,b,d)]:
            s,i,j=ent(x,y,z,w); v+=s*R[i,j]
        out.append(v)
    for a in range(n):
        for b in range(a,n):
            v=0
            for k in range(n):
                if k in (a,b): continue
                s,i,j=ent(a,k,b,k); v+=s*R[i,j]
            out.append(v)
    return out
Amat=np.array([constraints(M) for M in sym]).T
_,sv,vt=np.linalg.svd(Amat); r=(sv>1e-9).sum(); null=vt[r:]
Wb=[sum(c*M for c,M in zip(v,sym)) for v in null]
G=np.array([M.ravel() for M in Wb]).T; Qo,_=np.linalg.qr(G)
def toW(c): return (Qo@c).reshape(N,N)
def proj(X): return Qo.T@X.ravel()
def rot_op(gm):
    Lg=np.zeros((N,N))
    for (p1,q1),col in idx.items():
        for (p2,q2),row in idx.items():
            Lg[row,col]=gm[p2,p1]*gm[q2,q1]-gm[q2,p1]*gm[p2,q1]
    return Lg
gens=[]
for a_ in range(n):
    for b_ in range(a_+1,n):
        X=np.zeros((n,n)); X[a_,b_]=1; X[b_,a_]=-1; gens.append(X)
def t2(W,gm): L=rot_op(gm); return np.sum(np.diag(L@W@L.T)**2)
def ascend(W,gm,its=60):
    f=t2(W,gm)
    for it in range(its):
        h=1e-5; grad=np.array([(t2(W,sla.expm(h*X)@gm)-f)/h for X in gens])
        if np.linalg.norm(grad)<1e-6: break
        gm=sla.expm(0.3*sum(c*X for c,X in zip(grad,gens)))@gm; f=t2(W,gm)
    return gm,f
def E(W): return np.sum(Qb(W,W)*W)-1.5*np.trace(W@W@W)
rng=np.random.default_rng(seed)
c=rng.standard_normal(Qo.shape[1]); c/=np.linalg.norm(c)
frames=[]
for rd in range(rounds):
    W=toW(c)
    # (1) refresh frames: ascend from the old ones and two random ones
    starts=frames+[np.linalg.qr(rng.standard_normal((n,n)))[0] for _ in range(2)]
    frames=[]; vals=[]
    for gm in starts:
        gm,f=ascend(W,gm); frames.append(gm); vals.append(f)
    order=np.argsort(vals)[::-1][:6]; frames=[frames[i] for i in order]; vals=[vals[i] for i in order]
    # (2) gradient step on c: raise E - mu*softmax t^2 over the kept frames
    mu=8.0; tau=40.0
    gE=proj(3*Qb(W,W)-4.5*(W@W))
    w=np.exp(tau*(np.array(vals)-max(vals))); w/=w.sum()
    gT=np.zeros_like(c)
    for wi,gm in zip(w,frames):
        L=rot_op(gm); D=np.diag(np.diag(L@W@L.T)); gT+=wi*proj(2*L.T@D@L)
    step=gE-mu*gT; step-= (step@c)*c
    c=c+0.05*step/(np.linalg.norm(step)+1e-12); c/=np.linalg.norm(c)
    if rd%5==0 or rd==rounds-1:
        print(f"round {rd}: E={E(toW(c)):.4f}  t^2 in best kept frame={max(vals):.4f}",flush=True)
W=toW(c)
best=0
for s in range(8):
    gm,f=ascend(W,np.linalg.qr(rng.standard_normal((n,n)))[0],its=120); best=max(best,f)
for gm in frames:
    gm,f=ascend(W,gm,its=120); best=max(best,f)
e=E(W)
print(f"n={n} seed={seed}: final E={e:.4f}, t_max^2 >= {best:.4f} (t_max >= {np.sqrt(best):.4f}), E/t_max <= {e/np.sqrt(best):.4f}  [theta_0={np.sqrt(2*(n-1)*(n-2))/n:.4f}]",flush=True)
