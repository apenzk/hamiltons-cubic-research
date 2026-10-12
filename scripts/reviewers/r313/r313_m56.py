"""M5 + M6 at the n=8 witness (r305 seed 9015, theta=1.088948) and the two new points."""
import sys, numpy as np, itertools
sys.path.insert(0,'scripts/reviewers/r313')
import r313_lib as R
from r313_m3 import gauss_newton, defect
n=8; P=R.pairs(n); N=len(P)

def lam2(g):
    """Lambda^2 of a diagonal orthogonal g = diag(s)."""
    return np.diag([g[i]*g[j] for (i,j) in P])

def coordinate_gradings(n, W, tol=1e-9):
    hits=[]
    for bits in range(1, 2**(n-1)):
        s = np.array([1.0]+[1.0 if (bits>>k)&1 else -1.0 for k in range(n-1)])
        G = lam2(s)
        if np.linalg.norm(G@W - W@G) < tol:
            k = int((s>0).sum()); hits.append((tuple(np.where(s>0)[0]), tuple(np.where(s<0)[0]), min(k,n-k)))
    return hits

pts = {}
for nm, f in (("witness(9015)","r305_n8_seed9015"),("9018","r305_n8_seed9018"),("9033","r305_n8_seed9033")):
    W = np.load(f"scripts/reviewers/r305/out/{f}.npy")
    W = gauss_newton(n, W)
    if R.theta_of(n,W) < 0: W = -W
    pts[nm] = W

# --- S^3 x S^5 control
def sphere_W(n,k):
    l=n-k; a=-l/(k-1); b=-k/(l-1); g=1.0
    M=np.zeros((n,n))
    for i in range(n):
        for j in range(n):
            if i==j: continue
            M[i,j]= a if (i<k and j<k) else (b if (i>=k and j>=k) else g)
    W=np.zeros((N,N))
    for t,(i,j) in enumerate(P): W[t,t]=M[i,j]
    W/=np.sqrt(np.tensordot(W,W,axes=2))
    return W if R.theta_of(n,W)>0 else -W
pts["S3xS5"] = sphere_W(8,3)

print("=== M6/M5 step 0: which coordinate Z2-gradings does each point admit? ===")
for nm,W in pts.items():
    h = coordinate_gradings(n,W)
    sizes = sorted(set(x[2] for x in h))
    print(f"  {nm}: theta={R.theta_of(n,W):.9f}  #coordinate involutions commuting with W = {len(h)}  block sizes {sizes}")
    if h: print(f"      e.g. split {h[0][0]} | {h[0][1]}")

# --- fix the so(3)+so(5) coordinate grading
idx1=[t for t,(i,j) in enumerate(P) if i<3 and j<3]        # so(3)
idx2=[t for t,(i,j) in enumerate(P) if i>=3 and j>=3]      # so(5)
idxm=[t for t,(i,j) in enumerate(P) if (i<3)!=(j<3)]       # m
print(f"  dims: so(3)={len(idx1)} so(5)={len(idx2)} m={len(idxm)}")

def block_masses(H):
    tot=np.sum(H*H)
    def m(I,J):
        s=np.sum(H[np.ix_(I,J)]**2)
        return s if I is J else 2*s
    return dict(mm=m(idxm,idxm)/tot, so5=m(idx2,idx2)/tot, cross=m(idx1,idx2)/tot,
                so3=m(idx1,idx1)/tot, pm=(m(idx1,idxm)+m(idx2,idxm))/tot)

print("\n=== M5(i): the mass route ===")
for nm in ("S3xS5","witness(9015)","9018","9033"):
    W=pts[nm]
    A = np.zeros_like(W); ip=idx1+idx2
    A[np.ix_(ip,ip)] = W[np.ix_(ip,ip)]
    B = np.zeros_like(W); B[np.ix_(idxm,idxm)] = W[np.ix_(idxm,idxm)]
    cross = np.linalg.norm(W-A-B)
    A1=W[np.ix_(idx1,idx1)]; A2=W[np.ix_(idx2,idx2)]
    Ax=W[np.ix_(idx1,idx2)]
    print(f"  {nm}: ||A||^2={np.sum(A*A):.6f}  ||W-A-B||={cross:.2e}  tr A|so(3)={np.trace(A1):.6f} tr A|so(5)={np.trace(A2):.6f}"
          f"  CS floor={np.trace(A1)**2/len(idx1)+np.trace(A2)**2/len(idx2):.6f}  ||p-cross||^2={2*np.sum(Ax*Ax):.6f}")
print(f"  dim p / C(n-1,2) = {13/21:.6f}")

print("\n=== M5(ii): the p-internal cross-block as a test direction ===")
for nm in ("witness(9015)","9018","9033"):
    W=pts[nm]; th=R.theta_of(n,W)
    Hc=np.zeros_like(W)
    Hc[np.ix_(idx1,idx2)]=W[np.ix_(idx1,idx2)]; Hc[np.ix_(idx2,idx1)]=W[np.ix_(idx2,idx1)]
    if np.linalg.norm(Hc)<1e-12: print(f"  {nm}: cross-block is zero"); continue
    Hp=R.proj_weyl(n,Hc)
    out=np.linalg.norm(Hc-Hp)/np.linalg.norm(Hc)
    v=R.coords(n,Hp); w=R.coords(n,W); w/=np.linalg.norm(w)
    v=v-np.dot(v,w)*w
    lam,evec,evs,Cp,Lm=R.lam_max_perp(n,W,th)
    rq=float(v@Lm@v/np.dot(v,v))
    print(f"  {nm}: fraction of cross-block outside Weyl_n = {out:.4f} ({out*100:.1f}%)  repaired Rayleigh = {rq:.6f}  (lambda_max={lam:.6f})")

print("\n=== M6: where the violating direction lives ===")
for nm in ("witness(9015)","9018","9033"):
    W=pts[nm]; th=R.theta_of(n,W)
    lam,evec,evs,Cp,Lm=R.lam_max_perp(n,W,th)
    mult=int((np.abs(evs-evs[-1])<1e-9).sum())
    H=R.from_coords(n,evec)
    bm=block_masses(H)
    print(f"  {nm}: lambda_max={lam:.9f} multiplicity={mult}")
    print(f"      mxm={bm['mm']:.4f}  so(5)={bm['so5']:.4f}  cross={bm['cross']:.4f}  so(3)={bm['so3']:.4f}  pxm={bm['pm']:.4f}")
