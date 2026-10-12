"""r249 / claim 2, part b: the file's fourth check is CIRCULAR.

run_weyl_projector.py builds its test tensor as w = sum c_k B_k over the SAME
orthonormal list ON that defines P.  Every orthogonal projector fixes every
vector of its own range, so |Pw - w| = 0 is an identity, not evidence.

Here the test tensor is built WITHOUT wm.BASIS: an algebraic curvature tensor
R = h (KN) h for random symmetric h, with its Ricci and scalar parts removed by
solving for the two coefficients that make Ric(W) = 0.  Its Weyl-hood is
certified by symmetries + Bianchi + Ric = 0, none of which uses the module.
"""
import importlib.util as _il, io as _io, contextlib as _cl
import numpy as np

def _load(p, n):
    sp = _il.spec_from_file_location(n, p); m = _il.module_from_spec(sp)
    with _cl.redirect_stdout(_io.StringIO()): sp.loader.exec_module(m)
    return m
wm = _load("scripts/runs/run_n5_weyl_module.py", "wm"); N = 5

def kn(h, k):
    return (np.einsum('ac,bd->abcd', h, k) + np.einsum('bd,ac->abcd', h, k)
            - np.einsum('ad,bc->abcd', h, k) - np.einsum('bc,ad->abcd', h, k))

g = np.eye(N)
rg = np.random.default_rng(11)
h = rg.standard_normal((N, N)); h = h + h.T
R = kn(h, h)
ric = lambda T: np.einsum('ambm->ab', T)
Ric = ric(R); s = np.trace(Ric)
Ric0 = Ric - (s/N)*g
X1, X2 = kn(Ric0, g), kn(g, g)
# solve alpha,beta with Ric(R + a X1 + b X2) = 0 (least squares on the 15 entries)
M = np.stack([ric(X1).ravel(), ric(X2).ravel()], axis=1)
ab, *_ = np.linalg.lstsq(M, -Ric.ravel(), rcond=None)
W = R + ab[0]*X1 + ab[1]*X2
nrm = np.abs(W).max()
print("independently built W:")
print(f"  antisym {np.abs(W+W.transpose(1,0,2,3)).max()/nrm:.1e}  "
      f"pairsym {np.abs(W-W.transpose(2,3,0,1)).max()/nrm:.1e}  "
      f"bianchi {np.abs(W+W.transpose(0,2,3,1)+W.transpose(0,3,1,2)).max()/nrm:.1e}  "
      f"ricci {np.abs(ric(W)).max()/nrm:.1e}   -> a genuine Weyl tensor")

def orthonormalise(B):
    out = []
    for v in B:
        w = v.copy()
        for u in out: w = w - np.einsum('abcd,abcd->', w, u)*u
        n2 = np.sqrt(np.einsum('abcd,abcd->', w, w))
        if n2 > 1e-9: out.append(w/n2)
    return out
def proj(B):
    P = np.zeros((N,)*8)
    for b in B: P += np.einsum('abcd,efgh->abcdefgh', b, b)
    return P
def t(v):
    T = wm.sym2_to_R({wm.SPAIRS[i]: v[i] for i in range(len(v)) if v[i]})
    return np.array([[[[float(T[a][b][c][d]) for d in range(N)] for c in range(N)]
                      for b in range(N)] for a in range(N)])

ONW = orthonormalise([t(v) for v in wm.BASIS]); PW = proj(ONW)
CURV = orthonormalise([t(v) for v in wm.nullspace(wm.bianchi_rows(), wm.NS)])
PC = proj(orthonormalise(ONW[:30] + CURV)[:35])          # witness C from part a

for lbl, P in (("TRUE Weyl_5", PW), ("witness C (30 Weyl + 5 Ricci)", PC)):
    d = np.abs(np.einsum('abcdefgh,efgh->abcd', P, W) - W).max()/nrm
    print(f"  |P W - W|_max/|W|_max for {lbl:30s} = {d:.3e}  "
          f"-> {'fixes it' if d < 1e-9 else 'DOES NOT fix it'}")
