"""r212, claim 4: is the unbounded status 'feasibility plus a psd kernel direction'?

Two questions, asked under both block layouts:
  (a) uncapped, is max min-eigenvalue over the affine family really unbounded?
  (b) does the 34-dimensional homogeneous space contain a nonzero psd element?
      Feasibility of {A x = 0, every block psd, sum of traces = 1}, and the
      strict version {A x = 0, every block >= t I, sum of traces = 1, max t}.
"""
import os, pickle, sys
import numpy as np
import cvxpy as cp

HERE = os.path.dirname(os.path.abspath(__file__))
RUNS = os.path.join(HERE, "..", "..", "runs")
D = pickle.load(open(os.path.join(HERE, "exact_rows.pkl"), "rb"))
A, B = D["A"], D["B"]
ADAPTED = pickle.load(open(os.path.join(RUNS, "n5_adapted.pkl"), "rb"))
Mm = {l: len(c) for l, c in ADAPTED.items()}
live = dict(zip(D["blocks"], D["shape"]))
LAY = {"used": list(D["blocks"]),
       "true": [l for l in sorted(ADAPTED, key=lambda l: (-Mm[l], l)) if l in live]}

Af = np.array([[float(x) for x in r] for r in A])
Bf = np.array([float(x) for x in B])
rn = np.linalg.norm(Af, axis=1)
As, Bs = Af / rn[:, None], Bf / rn
print(f"kernel dimension of A: {As.shape[1] - np.linalg.matrix_rank(As, tol=1e-8)}")

def blocks(SHAPE):
    VARS, coord, cons = [], [], []
    for k in SHAPE:
        X = cp.Variable((k, k), hermitian=True); VARS.append(X)
        for i in range(k):
            coord.append(cp.real(X[i, i]))
            for j in range(i+1, k):
                coord.append(cp.real(X[i, j])); coord.append(cp.imag(X[i, j]))
    return VARS, cp.hstack(coord)

for mode, ORDER in LAY.items():
    SHAPE = [live[l] for l in ORDER]
    print(f"\n===== layout {mode}  shape {SHAPE} =====")

    # (a) uncapped
    V, vec = blocks(SHAPE)
    t = cp.Variable()
    cons = [X >> 0 for X in V] + [As @ vec == Bs] + \
           [X - t*np.eye(k) >> 0 for X, k in zip(V, SHAPE)]
    p = cp.Problem(cp.Maximize(t), cons); p.solve(solver=cp.CLARABEL)
    print(f"(a) uncapped max min-eigenvalue: status {p.status}, value {p.value}")

    # (b) psd element of the kernel: A x = 0, X psd, sum trace = 1
    V, vec = blocks(SHAPE)
    t = cp.Variable()
    cons = [X >> 0 for X in V] + [As @ vec == 0] + \
           [cp.sum([cp.real(cp.trace(X)) for X in V]) == 1] + \
           [X - t*np.eye(k) >> 0 for X, k in zip(V, SHAPE)]
    p = cp.Problem(cp.Maximize(t), cons); p.solve(solver=cp.CLARABEL)
    print(f"(b) psd kernel element, normalised trace 1: status {p.status}, "
          f"max uniform margin t = {p.value}")
    if p.status in ("optimal", "optimal_inaccurate"):
        w = [np.linalg.eigvalsh(X.value) for X in V]
        print(f"    worst eigenvalue over blocks: {min(x.min() for x in w):.3e}")
        print(f"    ranks: {[int((x > 1e-8).sum()) for x in w]} of {SHAPE}")
        nz = [ (l, np.round(x, 5)) for l, x in zip(ORDER, w) if x.max() > 1e-6 ]
        for l, x in nz[:6]: print(f"      {l}: {x}")
