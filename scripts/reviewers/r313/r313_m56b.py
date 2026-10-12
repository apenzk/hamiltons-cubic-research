"""M5 + M6 redone in the frame where the so(3)+so(5) grading is coordinate."""
import sys, numpy as np, itertools
sys.path.insert(0,'scripts/reviewers/r313')
import r313_lib as R
from r313_m3 import gauss_newton, support_op
from r313_grading import lam2_of
import r313_m56 as M
n=8; P=R.pairs(n); N=len(P)

def load(f):
    W=np.load(f"scripts/reviewers/r305/out/{f}.npy")
    W=gauss_newton(n,W); return W if R.theta_of(n,W)>0 else -W

def rotate(W, Rot):
    L = lam2_of(n, Rot)          # Lambda^2 of the rotation, orthogonal on Lambda^2
    return L.T @ W @ L

def all_dim3_frames(W):
    T=support_op(n,W); ev,V=np.linalg.eigh(T)
    groups=[]; i=0
    while i<len(ev):
        j=i
        while j+1<len(ev) and abs(ev[j+1]-ev[i])<1e-8: j+=1
        groups.append(list(range(i,j+1))); i=j+1
    out=[]
    for r in range(1,len(groups)+1):
        for sub in itertools.combinations(range(len(groups)),r):
            cols=[c for s in sub for c in groups[s]]
            if len(cols)!=3: continue
            g=np.eye(n)-2*V[:,cols]@V[:,cols].T
            L=lam2_of(n,g)
            if np.linalg.norm(L@W-W@L)<1e-7:
                rest=[c for c in range(n) if c not in cols]
                Rot=np.column_stack([V[:,cols],V[:,rest]])
                if np.linalg.det(Rot)<0: Rot[:,-1]*=-1
                out.append((ev[cols[0]], Rot))
    return out

idx1=[t for t,(i,j) in enumerate(P) if i<3 and j<3]
idx2=[t for t,(i,j) in enumerate(P) if i>=3 and j>=3]
idxm=[t for t,(i,j) in enumerate(P) if (i<3)!=(j<3)]
ip=idx1+idx2

def report(nm, W):
    th=R.theta_of(n,W)
    lam,evec,evs,Cp,Lm=R.lam_max_perp(n,W,th)
    A=np.zeros_like(W); A[np.ix_(ip,ip)]=W[np.ix_(ip,ip)]
    B=np.zeros_like(W); B[np.ix_(idxm,idxm)]=W[np.ix_(idxm,idxm)]
    A1=W[np.ix_(idx1,idx1)]; A2=W[np.ix_(idx2,idx2)]; Ax=W[np.ix_(idx1,idx2)]
    Hc=np.zeros_like(W); Hc[np.ix_(idx1,idx2)]=Ax; Hc[np.ix_(idx2,idx1)]=Ax.T
    outfrac=rq=float('nan')
    if np.linalg.norm(Hc)>1e-12:
        Hp=R.proj_weyl(n,Hc); outfrac=np.linalg.norm(Hc-Hp)/np.linalg.norm(Hc)
        v=R.coords(n,Hp); w=R.coords(n,W); w/=np.linalg.norm(w); v=v-np.dot(v,w)*w
        rq=float(v@Lm@v/np.dot(v,v))
    H=R.from_coords(n,evec); tot=np.sum(H*H)
    def m(I,J):
        s=np.sum(H[np.ix_(I,J)]**2); return s if I is J else 2*s
    print(f"  {nm}: theta={th:.9f} lam_max={lam:.9f}  ||W-A-B||={np.linalg.norm(W-A-B):.2e}")
    print(f"      ||A||^2={np.sum(A*A):.6f}  trA|so(3)={np.trace(A1):.6f} trA|so(5)={np.trace(A2):.6f}"
          f"  CS floor={np.trace(A1)**2/3+np.trace(A2)**2/10:.6f}  ||p-cross||^2={2*np.sum(Ax*Ax):.6f}")
    print(f"      cross-block: outside Weyl_n = {outfrac*100:.1f}%   repaired Rayleigh = {rq:.6f}")
    print(f"      eigenvector mass: mxm={m(idxm,idxm)/tot:.4f} so(5)={m(idx2,idx2)/tot:.4f} "
          f"cross={m(idx1,idx2)/tot:.4f} so(3)={m(idx1,idx1)/tot:.4f} pxm={(m(idx1,idxm)+m(idx2,idxm))/tot:.4f}")

print("=== control: S^3 x S^5 in its own coordinate frame ===")
report("S3xS5", M.sphere_W(8,3))
for nm,f in (("witness(9015)","r305_n8_seed9015"),("9018","r305_n8_seed9018"),("9033","r305_n8_seed9033")):
    W=load(f)
    print(f"=== {nm}: dim-3 gradings found: ===")
    for k,(evv,Rot) in enumerate(all_dim3_frames(W)):
        Wr=rotate(W,Rot)
        report(f"{nm} frame#{k} (T-eig {evv:.6f})", Wr)
