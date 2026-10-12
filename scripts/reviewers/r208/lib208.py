"""r208 shared machinery: Weyl_5 coordinates, W_0, the orbit, and C = span{(gW_0)^3}.

Everything about C is handled through 35-dimensional inner products, because the
apolar form on Sym^3 satisfies <a^3, b^3> = <a,b>^3.  So the 7770-dimensional
Sym^3 never has to be built:

    P_C v^3 = sum_k c_k u_k^3   with   G c = b,
    G_kl = <u_k,u_l>^3,   b_k = <v,u_k>^3,
    rho(v) = |P_C v^3|^2 / |v^3|^2 = (b^T G^+ b) / <v,v>^3.
"""
import importlib.util, os, sys, numpy as np

RUNS = "scripts/runs"

def _load(n):
    sp = importlib.util.spec_from_file_location(n[:-3], os.path.join(RUNS, n))
    m = importlib.util.module_from_spec(sp); o = sys.stdout
    sys.stdout = open(os.devnull, "w")
    try: sp.loader.exec_module(m)
    finally: sys.stdout.close(); sys.stdout = o
    return m

wm = _load("run_n5_weyl_module.py")
ex = _load("run_n5_extremiser.py")
NP, SPAIRS, PAIRS = wm.NP, wm.SPAIRS, wm.PAIRS

def _vec2sym(v):
    M = np.zeros((NP, NP))
    for k, (a, b) in enumerate(SPAIRS): M[a, b] = M[b, a] = float(v[k])
    return M

_raw = [_vec2sym(b) for b in wm.BASIS]
_B = []
for M in _raw:
    for X in _B: M = M - np.sum(M*X)*X
    _B.append(M/np.sqrt(np.sum(M*M)))
B = np.array(_B)                                   # (35,10,10) orthonormal

def coords(M):  return np.einsum('aij,ij->a', B, M)
def expand(c):  return np.einsum('a,aij->ij', c, B)

S  = np.array([[float(x) for x in row] for row in ex.S])
W0 = S/np.sqrt(6.0)
w0 = coords(W0); w0 = w0/np.linalg.norm(w0)        # unit vector in R^35

def lam2(g):
    """the Lambda^2 R^5 action of g in O(5), as a 10x10 matrix."""
    L = np.empty((NP, NP))
    for a, (i, j) in enumerate(PAIRS):
        for b, (k, l) in enumerate(PAIRS):
            L[a, b] = g[i, k]*g[j, l] - g[i, l]*g[j, k]
    return L

def rot35(g):
    """the induced orthogonal action on Weyl_5 in the B-coordinates (35x35)."""
    L = lam2(g)
    return np.array([coords(L @ expand(np.eye(35)[a]) @ L.T) for a in range(35)]).T

def rand_o5(rng, det=None):
    q, r = np.linalg.qr(rng.standard_normal((5, 5)))
    q = q*np.sign(np.diag(r))
    if det is not None and np.linalg.det(q)*det < 0: q[:, 0] = -q[:, 0]
    return q

def orbit(nsample, seed=0):
    """nsample unit points on the O(5)-orbit of w0, as an (nsample,35) array."""
    rng = np.random.default_rng(seed)
    U = np.empty((nsample, 35))
    for k in range(nsample):
        L = lam2(rand_o5(rng))
        U[k] = coords(L @ W0 @ L.T)
    return U/np.linalg.norm(U, axis=1, keepdims=True)

class Cone:
    """the projector data for C = span{(g W_0)^3}, from a spanning orbit sample."""
    def __init__(self, U, tol=1e-9):
        self.U = U
        G = (U @ U.T)**3
        w, V = np.linalg.eigh(G)
        keep = w > tol*w.max()
        self.dimC = int(keep.sum())
        self.w, self.V = w[keep], V[:, keep]
        self.spec = w

    def rho(self, v):
        """|P_C v^3|^2/|v^3|^2 in [0,1]; 1 exactly when v^3 lies in C."""
        n2 = float(v @ v)
        b = (self.U @ v)**3
        y = self.V.T @ b
        return float((y*y/self.w).sum()/n2**3)

    def grad_rho(self, v):
        n2 = float(v @ v)
        b = (self.U @ v)**3
        y = self.V.T @ b
        c = self.V @ (y/self.w)                     # G^+ b
        num = float(b @ c)
        dnum = 3.0*(self.U.T @ (c*(self.U @ v)**2))*2.0/2.0
        # d/dv [b^T G^+ b] = 2 c^T db/dv = 2 * 3 * U^T (c * (Uv)^2)
        dnum = 6.0*(self.U.T @ (c*(self.U @ v)**2))
        return (dnum*n2**3 - num*3*n2**2*2*v)/n2**6
