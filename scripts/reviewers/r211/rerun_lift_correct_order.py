"""r211, claim 2 (and the coordinates behind claim 3): the lift's SDP is blocked
on the WRONG column partition.

run_n5_assemble.py's herm_row emits the 47 columns block by block in the order
    sorted(ADAPTED, key=lambda l: (-len(ADAPTED[l]), l))          [by multiplicity]
but the dump records blocks/shape in the order
    [l for l in sorted(TR) if TR[l]]                              [lexicographic]
and run_n5_lift.py partitions the columns with the DUMPED shape.  Measured
(check_block_order.py, from the real ADAPTED):

    column order : [3, 3, 2, 1, 2, 1, 2, 1, 2, 2, 1, 1, 1, 1, 1, 1]
    dumped shape : [1, 2, 3, 1, 2, 2, 1, 1, 2, 3, 2, 1, 1, 1, 1, 1]

Both sum to 47 in squares, which is why `assert len(coord) == NC` passes and the
error is invisible.  This reruns the same SDP under both partitions.
"""
import os, json, glob, pickle
import numpy as np, cvxpy as cp

here = os.path.dirname(os.path.abspath(__file__))
L = pickle.load(open(os.path.join(here, "lifted.pkl"), "rb"))
A, B = L["A"], L["B"]
Af = np.array([[float(x) for x in r] for r in A])
Bf = np.array([float(x) for x in B])
NR, NC = Af.shape

SHAPE_DUMP = L["shape"]
ORDER_ROW = [(2,2),(4,2),(3,2),(2,0),(2,1),(3,0),(3,1),(4,0),(4,1),(4,3),(4,4),
             (5,2),(3,3),(5,1),(5,3),(6,3)]
size = dict(zip([tuple(b) for b in L["blocks"]], SHAPE_DUMP))
SHAPE_TRUE = [size[l] for l in ORDER_ROW]
print("dumped shape (what run_n5_lift.py uses):", SHAPE_DUMP)
print("true column partition                 :", SHAPE_TRUE)
assert sum(k*k for k in SHAPE_DUMP) == sum(k*k for k in SHAPE_TRUE) == NC

rn = np.linalg.norm(Af, axis=1)
As = Af / rn[:, None]; Bs = Bf / rn

def solve(shape, tag):
    VARS, cons, coord = [], [], []
    for k in shape:
        X = cp.Variable((k, k), hermitian=True)
        VARS.append(X); cons.append(X >> 0)
        for i in range(k):
            coord.append(cp.real(X[i, i]))
            for j in range(i+1, k):
                coord.append(cp.real(X[i, j])); coord.append(cp.imag(X[i, j]))
    assert len(coord) == NC
    vec = cp.hstack(coord)
    t = cp.Variable()
    cons.append(As @ vec == Bs)
    for X, k in zip(VARS, shape):
        cons.append(X - t*np.eye(k) >> 0)
    cons.append(t <= 1)
    prob = cp.Problem(cp.Maximize(t), cons)
    prob.solve(solver=cp.CLARABEL, verbose=False)
    print(f"\n[{tag}] status {prob.status}   t = {prob.value}")
    if prob.status in ("optimal", "optimal_inaccurate"):
        worst = min(float(np.linalg.eigvalsh(X.value).min()) for X in VARS)
        cv = np.array([float(c.value) for c in coord])
        res = np.linalg.norm(As @ cv - Bs)
        print(f"[{tag}] worst eigenvalue {worst:.6e}   affine residual {res:.3e}")
        return cv, worst
    return None, None

cv_dump, w_dump = solve(SHAPE_DUMP, "dumped shape -- what cc1cabd reports")
cv_true, w_true = solve(SHAPE_TRUE, "TRUE column partition")

# Cross-evaluation: is the reported point psd under the true blocking?
def blocks_of(vec, shape):
    out, o = [], 0
    for k in shape:
        Mx = np.zeros((k, k), dtype=complex)
        for i in range(k):
            Mx[i, i] = vec[o]; o += 1
            for j in range(i+1, k):
                Mx[i, j] = vec[o] + 1j*vec[o+1]; Mx[j, i] = vec[o] - 1j*vec[o+1]; o += 2
        out.append(Mx)
    assert o == len(vec)
    return out

if cv_dump is not None:
    print("\nthe point the dumped-shape solve returns, read under the TRUE partition:")
    ev = [np.linalg.eigvalsh(M).min() for M in blocks_of(cv_dump, SHAPE_TRUE)]
    print(f"  worst eigenvalue of the true blocks: {min(ev):.6e}")
    for l, k, e in zip(ORDER_ROW, SHAPE_TRUE, ev):
        if k > 1: print(f"    {l} ({k}x{k}): min eig {e:.6e}")
