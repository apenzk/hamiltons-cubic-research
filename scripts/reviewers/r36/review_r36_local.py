"""Is the constant local?  Replace I_p by I_S for subsets S, on the explicit V."""
import numpy as np, sys
sys.path.insert(0, 'scripts/lib')
from review_r36_core import *
from review_r36_k6 import explicit_V

def I_set(n,S):
    prs,_=pairs_of(n); N=len(prs)
    M=np.zeros((N,N))
    for a,(i,j) in enumerate(prs):
        if i in S and j in S: M[a,a]=1.0
    return M

for (p,q) in [(5,5),(4,6),(6,6)]:
    n=p+q; A=struct(n); V=explicit_V(p,q); V/=np.linalg.norm(V)
    print(f"\n(p,q)=({p},{q}), V supported on indices {{0,1,2,{p}}}")
    for S in [set(range(3)), set(range(4)), set(range(p)), set(range(p))|{p},
              set(range(3))|{p}, set(range(n)), {0,1}, {0,1,2,3,4}]:
        Y=sharp_bilin(A,I_set(n,S),V)
        c=np.tensordot(Y,V)
        print(f"   S={sorted(S)}: <sb(I_S,V),V> = {c:9.5f}   ||sb(I_S,V)-cV|| = {np.linalg.norm(Y-c*V):.2e}")

print("\n=== K1 variants: what counts as a 'generic V on the (pp,mix) support' ===")
def masks(n,p):
    prs,_=pairs_of(n); N=len(prs)
    ty=lambda a: 0 if prs[a][1]<p else (2 if prs[a][0]>=p else 1)
    m=np.zeros((N,N))
    for a in range(N):
        for b in range(N):
            if tuple(sorted((ty(a),ty(b))))==(0,1): m[a,b]=1.0
    return m
rng=np.random.default_rng(31)
print(f"{'(p,q)':>7} {'variant':>26} {'best c':>9} {'||Y-cV||/||Y||':>15} {'||Y-cV||/||V||':>15} {'||Y+V/2||/||V||':>16}")
for (p,q) in [(3,4),(3,5),(4,4),(4,5),(5,5)]:
    n=p+q; A=struct(n); Ip=I_block(n,0,p); M=masks(n,p); N=A.shape[0]
    B=weyl_basis(n); D=len(B)
    for tag,gen in [("random symmetric*mask", lambda: (lambda R:(R+R.T)/2*M)(rng.normal(size=(N,N)))),
                    ("mask(random Weyl elt)", lambda: np.tensordot(rng.normal(size=D),B,axes=1)*M),
                    ("single entry pair",     lambda: (lambda Z:(Z+Z.T))(np.eye(N)[:,[0]]@np.eye(N)[[np.argmax(M[0])],:]) )]:
        vals=[]
        for t in range(6):
            V=gen()
            if np.linalg.norm(V)<1e-12: continue
            V=V/np.linalg.norm(V); Y=sharp_bilin(A,Ip,V)
            c=np.tensordot(Y,V)
            vals.append((c,np.linalg.norm(Y-c*V)/np.linalg.norm(Y),np.linalg.norm(Y-c*V),
                         np.linalg.norm(Y+0.5*V)))
        a=np.mean([v[0] for v in vals]); b=np.mean([v[1] for v in vals])
        cc=np.mean([v[2] for v in vals]); dd=np.mean([v[3] for v in vals])
        print(f"{str((p,q)):>7} {tag:>26} {a:9.4f} {b:15.3f} {cc:15.3f} {dd:16.3f}")
