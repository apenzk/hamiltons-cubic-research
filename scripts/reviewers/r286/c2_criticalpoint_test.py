"""r286 claim 1(b) and claim 2/3 witness.

(A) Is the repo's confirming check -- run AT the balanced sphere product, a critical
    point -- capable of distinguishing grad P = 3Q(W) from a false identity?
    Test: run the same check for deliberately FALSE variants.
(B) Does Q preserve Weyl_n at several n (needed for the ODE to stay in Weyl_n)?
(C) The witness for route F's stated theorem: the ray R_+ W* is itself a Q-invariant
    cone containing the sphere-product ray and meeting the unit sphere only where
    P <= theta_0(n).
"""
import sys, os
import numpy as np
sys.path.insert(0, os.path.join(os.path.dirname(__file__), '..', '..'))
import review_r27_core as core

np.random.seed(2861)

def sphere_product(n):
    p = q = n // 2
    x, y, z = 1.0/(p*(p-1)), 1.0/(q*(q-1)), -1.0/(p*q)
    lam = np.zeros(n*(n-1)//2)
    for a, (i, j) in enumerate(core.pairs(n)):
        lam[a] = x if (i < p and j < p) else (y if (i >= p and j >= p) else z)
    W = np.diag(lam)
    return W/np.linalg.norm(W)

def theta0(n):
    return np.sqrt(2.0*(n-1)*(n-2)/n**2)

n = 8
B = core.weyl_basis(n)
dimW, N = B.shape[0], B.shape[1]
Wstar = sphere_product(n)
res, th = core.crit_residual(n, Wstar)
print(f"[A] n={n}: W* crit residual {res:.3e}, theta {th:.12f}, theta_0(n) {theta0(n):.12f}")

# tangential Weyl direction at W*
def tangent_dir():
    while True:
        V = np.einsum('k,kab->ab', np.random.randn(dimW), B)
        V = V - np.trace(V@Wstar)*Wstar
        if np.linalg.norm(V) > 1e-6:
            return V/np.linalg.norm(V)

CANDIDATES = {
    'TRUE   3Q(W)':        lambda W: 3.0*core.Q(n, W),
    'FALSE  7Q(W)':        lambda W: 7.0*core.Q(n, W),
    'FALSE  3W^2':         lambda W: 3.0*(W@W),
    'FALSE  3W#':          lambda W: 3.0*core.sharp(n, W),
    'FALSE  0':            lambda W: np.zeros_like(W),
    'FALSE  3Q(W)+W^3':    lambda W: 3.0*core.Q(n, W) + W@W@W,
}
print("\n[A] the check AT the critical point W* (what commit 10be9f8 ran):")
print("    for each candidate gradient G(W): predicted <G,V> vs FD dP[V], V tangential Weyl")
h = 1e-5
Vs = [tangent_dir() for _ in range(3)]
for name, G in CANDIDATES.items():
    preds, meass = [], []
    for V in Vs:
        preds.append(float(np.trace(G(Wstar) @ V)))
        meass.append((core.P(n, Wstar+h*V) - core.P(n, Wstar-h*V))/(2*h))
    print(f"   {name:18s} pred max|.| {max(abs(p) for p in preds):.3e}   "
          f"meas max|.| {max(abs(m) for m in meass):.3e}   "
          f"max|pred-meas| {max(abs(p-m) for p,m in zip(preds,meass)):.3e}")

print("\n[A] the SAME candidates at a random NON-critical Weyl point (a test with power):")
W = np.einsum('k,kab->ab', np.random.randn(dimW), B); W /= np.linalg.norm(W)
V = np.einsum('k,kab->ab', np.random.randn(dimW), B); V /= np.linalg.norm(V)
meas = (core.P(n, W+h*V) - core.P(n, W-h*V))/(2*h)
print(f"   FD dP[V] = {meas: .10e}")
for name, G in CANDIDATES.items():
    pred = float(np.trace(G(W) @ V))
    print(f"   {name:18s} pred {pred: .10e}   rel err {abs(pred-meas)/abs(meas):.3e}")

# ---------------- (B) Q preserves Weyl_n? ----------------
print("\n[B] does Q map Weyl_n into Weyl_n?")
for m in (6, 8, 10):
    Bm = core.weyl_basis(m)
    d = Bm.shape[0]
    for t in range(2):
        Wm = np.einsum('k,kab->ab', np.random.randn(d), Bm); Wm /= np.linalg.norm(Wm)
        QW = core.Q(m, Wm)
        dev = np.linalg.norm(QW - core.proj_weyl(m, QW))/np.linalg.norm(QW)
        print(f"   n={m:2d} sample {t}: relative deviation of Q(W) from Weyl_n = {dev:.3e}")

# ---------------- (C) the witness cone ----------------
print("\n[C] witness: C = R_+ W* satisfies route F's stated theorem verbatim")
for m in (8, 12):
    Ws = sphere_product(m)
    QW = core.Q(m, Ws)
    r, t0 = core.crit_residual(m, Ws)
    print(f"   n={m}: Q(W*) - theta W* = {r:.3e}  (so Q is TANGENT to the ray: the ray is invariant)")
    print(f"        C cap S = {{W*}}, P(W*) = {t0:.12f} = theta_0({m}) = {theta0(m):.12f}, so P <= theta_0 on C cap S")
    print(f"        and C contains the sphere-product ray by construction.")
