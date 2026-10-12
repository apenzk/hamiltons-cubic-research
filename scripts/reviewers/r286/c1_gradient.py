"""r286 claim 1: is grad P = 3 Q(W)?

Independent of the repo's own F1 test.  Uses scripts/review_r27_core.py only for
the structure constants / Weyl basis, but re-derives # from the definition here
and cross-checks it against the core's sharp_bilinear.

Definitions used (all from the record):
  phi_{ij} = E_ij - E_ji, i<j;  <X,Y> = 1/2 tr(X^T Y)  =>  {phi} orthonormal
  c[a,b,g] = <[phi_a,phi_b],phi_g>  (totally antisymmetric)
  (A#B)_{ab} = -(1/2) tr( A_a X A_b Y ) symmetrised, A_a[m,n] = c[a,m,n]
  Q(W) = W^2 + W#,  P(W) = <W,Q(W)> = tr(W Q(W))
"""
import sys, os
import numpy as np
sys.path.insert(0, os.path.join(os.path.dirname(__file__), '..', '..'))
import review_r27_core as core
from weyl import build_structure_constants, Q_general

np.random.seed(286)
n = 8
B = core.weyl_basis(n)
dimW = B.shape[0]
N = B.shape[1]
print(f"n={n} N={N} dim Weyl={dimW} (formula {core.weyl_dim(n)})")

def rand_weyl(scale=1.0):
    co = np.random.randn(dimW)
    W = np.einsum('k,kab->ab', co, B)
    return scale * W / np.linalg.norm(W)

# ---------------- 1a: full trilinear symmetry of #  ----------------
def T(X, Y, Z):
    return float(np.trace(core.sharp_bilinear(n, X, Y) @ Z))

Xs = [rand_weyl() for _ in range(3)]
X, Y, Z = Xs
vals = {
    'T(X,Y,Z)': T(X, Y, Z), 'T(Y,X,Z)': T(Y, X, Z), 'T(Z,Y,X)': T(Z, Y, X),
    'T(X,Z,Y)': T(X, Z, Y), 'T(Y,Z,X)': T(Y, Z, X), 'T(Z,X,Y)': T(Z, X, Y),
}
print("\n[1a] trilinear symmetry on Weyl_n (3 random Weyl tensors):")
for k, v in vals.items():
    print(f"   {k} = {v: .12e}")
print("   max spread =", max(vals.values()) - min(vals.values()))

# same on GENERIC symmetric matrices (no Bianchi, no trace-free), to see how far
# the symmetry really extends
G = [np.random.randn(N, N) for _ in range(3)]
G = [0.5 * (g + g.T) for g in G]
gv = [T(G[0], G[1], G[2]), T(G[1], G[0], G[2]), T(G[2], G[1], G[0]), T(G[0], G[2], G[1])]
print("[1a'] same on generic symmetric NxN (not curvature ops):", gv,
      "spread", max(gv) - min(gv))

# ---------------- 1b: does Q(W) stay in Weyl_n? ----------------
print("\n[1b] is Q(W) in Weyl_n for W in Weyl_n?")
for t in range(3):
    W = rand_weyl()
    QW = core.Q(n, W)
    PQ = core.proj_weyl(n, QW)
    print(f"   sample {t}: |Q(W)|={np.linalg.norm(QW):.6f} "
          f"|Q(W)-proj_Weyl Q(W)|={np.linalg.norm(QW-PQ):.6e} "
          f"|Ric(Q(W))|={np.linalg.norm(core.ricci(QW,n,core.struct(n)[1])):.6e} "
          f"bianchi={core.alt_norm(QW,n,core.struct(n)[1]):.6e}")
# and at the sphere product
p = q = n // 2
idx = core.struct(n)[1]
x, y, z = 1.0 / (p * (p - 1)), 1.0 / (q * (q - 1)), -1.0 / (p * q)
lam = np.zeros(N)
for a, (i, j) in enumerate(core.pairs(n)):
    lam[a] = x if (i < p and j < p) else (y if (i >= p and j >= p) else z)
Wstar = np.diag(lam) / np.linalg.norm(np.diag(lam))
QS = core.Q(n, Wstar)
print(f"   W* (sphere product): |Q-projW Q| = {np.linalg.norm(QS-core.proj_weyl(n,QS)):.3e}"
      f"  crit residual {core.crit_residual(n,Wstar)[0]:.3e}  theta {core.crit_residual(n,Wstar)[1]:.9f}")

# ---------------- 1c: the decisive derivative test, AWAY from critical points ----
print("\n[1c] directional derivative of P at RANDOM (non-critical) Weyl W")
print("     dP[V] measured by central differences vs 3<Q(W),V>, V in Weyl_n")
worst = 0.0
for t in range(4):
    W = rand_weyl()
    res, th = core.crit_residual(n, W)
    for s in range(2):
        Vc = np.random.randn(dimW)
        V = np.einsum('k,kab->ab', Vc, B)
        V /= np.linalg.norm(V)
        pred = 3.0 * float(np.trace(core.Q(n, W) @ V))
        h = 1e-5
        meas = (core.P(n, W + h * V) - core.P(n, W - h * V)) / (2 * h)
        rel = abs(meas - pred) / max(abs(pred), 1e-30)
        worst = max(worst, rel)
        print(f"   W#{t} crit-res={res:.3e} | pred {pred: .10e}  meas {meas: .10e}  rel {rel:.2e}")
print("   worst relative error:", worst)

# ---------------- 1d: general (non-Weyl) directions, and the ambient gradient ----
print("\n[1d] same test with AMBIENT symmetric directions (V not Weyl):")
W = rand_weyl()
for s in range(3):
    V = np.random.randn(N, N); V = 0.5 * (V + V.T); V /= np.linalg.norm(V)
    pred = 3.0 * float(np.trace(core.Q(n, W) @ V))
    h = 1e-5
    meas = (core.P(n, W + h * V) - core.P(n, W - h * V)) / (2 * h)
    print(f"   pred {pred: .10e}  meas {meas: .10e}  rel {abs(meas-pred)/abs(pred):.2e}")

# ---------------- 1e: is the repo's OLD Q_general the fault? ----------------
print("\n[1e] scripts/weyl.py Q_general vs basis-free Q (the suspected fault):")
idxs, pos, Nn, c = build_structure_constants(n)
for t in range(2):
    W = rand_weyl()
    Qg = Q_general(W, c)
    Qc = core.Q(n, W)
    print(f"   sample {t}: |Qg - Qc| = {np.linalg.norm(Qg-Qc):.6e}   |Qc| = {np.linalg.norm(Qc):.6e}")
    print(f"      <W,Qg> = {np.trace(W@Qg):.12e}   <W,Qc> = {np.trace(W@Qc):.12e}")
    # what a FD test built on Q_general would report
    V = rand_weyl()
    predg = 3.0 * float(np.trace(Qg @ V))
    h = 1e-5
    measg = (float(np.trace((W+h*V) @ Q_general(W+h*V, c))) - float(np.trace((W-h*V) @ Q_general(W-h*V, c)))) / (2*h)
    print(f"      Q_general-based: pred {predg: .8e} meas {measg: .8e} rel {abs(measg-predg)/abs(predg):.2e}")
    # is W# diagonal in W's eigenbasis?
    w, U = np.linalg.eigh(W)
    Sh = U.T @ core.sharp(n, W) @ U
    off = np.linalg.norm(Sh - np.diag(np.diag(Sh)))
    print(f"      off-diagonal mass of W# in W's own eigenbasis: {off:.6e} (|W#|={np.linalg.norm(Sh):.6e})")
