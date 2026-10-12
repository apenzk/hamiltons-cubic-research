"""Find the Z2-grading a critical point is graded for: minimise ||[Lambda^2(g), W]||^2
over g = I - 2 F F^T with F an orthonormal 8 x k frame (Grassmannian Gr(k,n))."""
import sys, numpy as np
sys.path.insert(0,'scripts/reviewers/r313')
import r313_lib as R

def lam2_of(n, g):
    P = R.pairs(n)
    return np.array([[g[k,i]*g[l,j]-g[l,i]*g[k,j] for (i,j) in P] for (k,l) in P])

def obj(n, W, F):
    g = np.eye(n) - 2*F@F.T
    L = lam2_of(n, g)
    return 0.25*np.linalg.norm(L@W - W@L)**2

def find(n, W, k, tries=40, seed=0, iters=800):
    rng = np.random.default_rng(seed); best=(1e9,None)
    for t in range(tries):
        F,_ = np.linalg.qr(rng.standard_normal((n,k)))
        step=0.15
        f0=obj(n,W,F)
        for it in range(iters):
            G=np.zeros_like(F); h=1e-6
            for a in range(n):
                for b in range(k):
                    E=np.zeros((n,k)); E[a,b]=h
                    Fp,_=np.linalg.qr(F+E); Fm,_=np.linalg.qr(F-E)
                    G[a,b]=(obj(n,W,Fp)-obj(n,W,Fm))/(2*h)
            Fn,_=np.linalg.qr(F-step*G)
            f1=obj(n,W,Fn)
            if f1<f0: F,f0=Fn,f1; step*=1.2
            else: step*=0.4
            if step<1e-12 or f0<1e-24: break
        if f0<best[0]: best=(f0,F.copy())
    return best

if __name__=='__main__':
    from r313_m3 import gauss_newton
    n=8
    def load(f):
        W=np.load(f"scripts/reviewers/r305/out/{f}.npy")
        W=gauss_newton(n,W); return W if R.theta_of(n,W)>0 else -W
    import r313_m56 as M
    tests = {"S3xS5": M.sphere_W(8,3), "witness(9015)": load("r305_n8_seed9015"),
             "9018": load("r305_n8_seed9018"), "9033": load("r305_n8_seed9033")}
    rng=np.random.default_rng(5)
    x=rng.standard_normal(R.weyl_basis(8).shape[0]); x/=np.linalg.norm(x)
    tests["random Weyl (control)"]=R.from_coords(8,x)
    for nm,W in tests.items():
        row=[]
        for k in (1,2,3,4):
            f,F=find(n,W,k,tries=12,seed=k)
            row.append(f"k={k}: {f:.3e}")
        print(f"{nm:22s} " + "   ".join(row), flush=True)
