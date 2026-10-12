"""r212: run the lift's SDP under the layout it uses and under the true one.

Usage: python3 r212_sdp.py [used|true]
"""
import os, sys, pickle, json
import numpy as np
import cvxpy as cp
from fractions import Fraction as Fr

HERE = os.path.dirname(os.path.abspath(__file__))
RUNS = os.path.join(HERE, "..", "..", "runs")
D = pickle.load(open(os.path.join(HERE, "exact_rows.pkl"), "rb"))
A, B, live_shape, live_blocks = D["A"], D["B"], D["shape"], D["blocks"]
ADAPTED = pickle.load(open(os.path.join(RUNS, "n5_adapted.pkl"), "rb"))
Mm = {l: len(c) for l, c in ADAPTED.items()}
live = dict(zip(live_blocks, live_shape))

USED = list(live_blocks)
TRUE = [l for l in sorted(ADAPTED, key=lambda l: (-Mm[l], l)) if l in live]

mode = sys.argv[1] if len(sys.argv) > 1 else "used"
ORDER = USED if mode == "used" else TRUE
SHAPE = [live[l] for l in ORDER]
print(f"layout: {mode}   shape {SHAPE}")

Af = np.array([[float(x) for x in r] for r in A])
Bf = np.array([float(x) for x in B])
NC = Af.shape[1]

sv = np.linalg.svd(Af, compute_uv=False)
print(f"singular values 11..15: {sv[10:15]}   numerical rank "
      f"{int(np.sum(sv > sv[0]*1e-10))}")

VARS, cons, coord = [], [], []
for k in SHAPE:
    X = cp.Variable((k, k), hermitian=True)
    VARS.append(X); cons.append(X >> 0)
    for i in range(k):
        coord.append(cp.real(X[i, i]))
        for j in range(i+1, k):
            coord.append(cp.real(X[i, j])); coord.append(cp.imag(X[i, j]))
assert len(coord) == NC
vec = cp.hstack(coord)
rn = np.linalg.norm(Af, axis=1)
As = Af / rn[:, None]; Bs = Bf / rn

t = cp.Variable()
cons.append(As @ vec == Bs)
for X, k in zip(VARS, SHAPE):
    cons.append(X - t*np.eye(k) >> 0)
cons.append(t <= 1)
prob = cp.Problem(cp.Maximize(t), cons)
prob.solve(solver=cp.CLARABEL, verbose=False)
print(f"status: {prob.status}   t = {prob.value}")
if prob.status in ("optimal", "optimal_inaccurate"):
    worst = min(float(np.linalg.eigvalsh(X.value).min()) for X in VARS)
    for l, X, k in zip(ORDER, VARS, SHAPE):
        print(f"   {l} k={k}: eig {np.round(np.linalg.eigvalsh(X.value), 6)}")
    print(f"WORST EIGENVALUE: {worst:.6e}")
    x = np.array([float(c.value) for c in coord])
    print(f"scaled affine residual: {np.linalg.norm(As @ x - Bs):.3e}")
    print(f"UNSCALED residual:      {np.linalg.norm(Af @ x - Bf):.3e}")
    print(f"|B| = {np.linalg.norm(Bf):.3e},  relative (unscaled) "
          f"{np.linalg.norm(Af @ x - Bf)/np.linalg.norm(Bf):.3e}")
    np.save(os.path.join(HERE, f"point_{mode}.npy"), x)
