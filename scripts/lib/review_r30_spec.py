import numpy as np, sys, time, json
sys.path.insert(0, 'scripts/lib')
from review_r30_core import *

def le_matrix(n, e, B=None, chunk=32, want_leak=True):
    """matrix of X -> Pi(e o X) on the orthonormal Weyl basis B."""
    if B is None: B = weyl_basis(n)
    A = adj(n); N = A.shape[0]; d = B.shape[0]
    A2 = A.reshape(N*N, N)                       # (N*N, N)
    Ae = (A2 @ e).reshape(N, N, N)               # Ae[a] = A_a e
    AeT = Ae.transpose(0,2,1).reshape(N, N*N)    # (A_a e)^T flattened
    Bf = B.reshape(d, N*N)
    L = np.empty((d, d))
    leak = 0.0
    for s in range(0, d, chunk):
        Xs = B[s:s+chunk]
        for t, X in enumerate(Xs):
            AX = (A2 @ X).reshape(N, N, N)
            T = AX.reshape(N, N*N) @ AeT.T       # T[a,b] = tr(A_a X A_b e)
            # want T'_ab = tr(A_a e A_b X) = T[b,a]; symmetric combo same either way
            pol = -0.25*(T + T.T)
            Y = 0.5*(e @ X + X @ e) + pol
            yf = Y.reshape(-1)
            col = Bf @ yf
            L[:, s+t] = col
            if want_leak:
                leak = max(leak, np.linalg.norm(yf - Bf.T @ col))
    return L, leak

def analyze(blocks, tol=1e-8, verbose=True):
    n = sum(blocks)
    W,_ = sphere_product_W(blocks); W = normalize(W)
    th = float(np.tensordot(W, Q(n,W)))
    e = W/th
    B = weyl_basis(n)
    t0=time.time()
    L, leak = le_matrix(n, e, B)
    asym = np.abs(L-L.T).max()
    ev = np.linalg.eigvalsh(0.5*(L+L.T))
    return dict(blocks=blocks, n=n, theta=th, leak=leak, asym=asym, ev=ev,
                dimW=B.shape[0], secs=time.time()-t0)

def cluster(ev, tol=1e-7):
    out=[]
    for v in ev:
        if out and abs(v-out[-1][0])<tol:
            out[-1][1]+=1; out[-1][0]=(out[-1][0]*(out[-1][1]-1)+v)/out[-1][1]
        else: out.append([v,1])
    return out

if __name__=="__main__":
    import ast
    cases = ast.literal_eval(sys.argv[1])
    for blocks in cases:
        r = analyze(tuple(blocks))
        print(f"--- {blocks} n={r['n']} dimWeyl={r['dimW']} theta={r['theta']:.12f} "
              f"leak={r['leak']:.2e} asym={r['asym']:.2e} t={r['secs']:.1f}s")
        cl = cluster(r['ev'])
        print("  spectrum (value, mult):", "  ".join(f"{v:.9f}^{m}" for v,m in cl))
        p,q = blocks
        # half eigenspace details
        ev=r['ev']
        half = np.abs(ev-0.5)
        n_half = int((half<1e-8).sum())
        others = ev[half>=1e-8]
        below = others[others<0.5]; above = others[others>0.5]
        print(f"  dim E(1/2)={n_half}  pq={p*q}  nearest-below={below.max() if below.size else None:.12f} "
              f"gap_below={0.5-(below.max() if below.size else 0):.6e}")
        if above.size: print(f"  eigenvalues ABOVE 1/2 (excluding 1/2): {sorted(set(np.round(above,10)))}")
