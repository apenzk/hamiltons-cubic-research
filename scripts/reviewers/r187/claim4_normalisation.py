"""Reviewer 187, claim 4.  Is the record self-consistent under the TENSOR
normalisation?  Three things are checked on one object, W_0:

  (i)  the 2^d grading run_n5_sextic_basis.py asserts, tr(M^k) = 2^k tr(A^k) for
       the flat n^2 x n^2 reshape M against the Lambda^2 operator A;
  (ii) F_5 in the two normalisations, and the claimed uniform factor 64;
  (iii) whether F_5(W_0) = 0 survives in both, which is the only property the
       downstream SOS argument uses.
"""
from fractions import Fraction as F
import importlib.util, sys, os
import numpy as np

d = os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "..", "runs")
spec = importlib.util.spec_from_file_location("wm", os.path.join(d, "run_n5_weyl_module.py"))
wm = importlib.util.module_from_spec(spec)
_o = sys.stdout; sys.stdout = open(os.devnull, "w"); spec.loader.exec_module(wm); sys.stdout = _o
N, NP, PAIRS, PIDX, SPAIRS = wm.N, wm.NP, wm.PAIRS, wm.PIDX, wm.SPAIRS

def formvec(terms):
    v = [F(0)]*NP
    for (i, j), c in terms:
        for k, cc in wm.wedge(i, j).items(): v[k] += F(c)*cc
    return v
W1 = formvec([((0,1),1), ((2,3),1)])
W2 = formvec([((0,2),1), ((1,3),-1)])
W3 = formvec([((0,3),1), ((1,2),1)])
S = [[F(0)]*NP for _ in range(NP)]
for w, s in ((W1,2), (W2,-1), (W3,-1)):
    nrm = sum(x*x for x in w)
    for a in range(NP):
        for b in range(NP):
            if w[a] and w[b]: S[a][b] += F(s)*w[a]*w[b]/nrm
# S = sqrt6 * W_0 as a Lambda^2 operator ("A" below)

R = wm.sym2_to_R({SPAIRS[k]: S[a][b] for k, (a, b) in enumerate(SPAIRS) if S[a][b]})
Rn = np.array([[[[float(R[i][j][k][l]) for l in range(N)] for k in range(N)]
                for j in range(N)] for i in range(N)])
M = Rn.reshape(N*N, N*N)
A = np.array([[float(S[a][b]) for b in range(NP)] for a in range(NP)])

print("=== (i) the 2^k grading, on sqrt6 * W_0 and on random Weyl tensors ===")
def trk(X, k):
    Y = np.eye(X.shape[0])
    for _ in range(k): Y = Y @ X
    return np.trace(Y)
print(f"{'k':>2} {'tr(M^k)':>14} {'2^k tr(A^k)':>14} {'match':>7}")
for k in range(2, 7):
    a_, b_ = trk(M, k), 2**k * trk(A, k)
    print(f"{k:>2} {a_:>14.4f} {b_:>14.4f} {str(abs(a_-b_) < 1e-6*max(1,abs(b_))):>7}")

rng = np.random.default_rng(187)
sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)),
                                "..", "..", "reviewers", "r179"))
import weyl_invariants as WI
print("\n  the same on 4 random Weyl_5 tensors over Q (p = 10007 lifted to ints):")
allok = True
for t in range(4):
    Wt = WI.random_weyl(N, 10007, rng).astype(float)
    Wt = Wt - 10007*(Wt > 5003)          # centre the residues to keep magnitudes small
    Mt = Wt.reshape(25, 25)
    At = np.array([[Wt[i][j][k][l] for (k, l) in PAIRS] for (i, j) in PAIRS])
    row = []
    for k in range(2, 5):
        a_, b_ = trk(Mt, k), 2**k * trk(At, k)
        ok = abs(a_-b_) <= 1e-6*max(1.0, abs(b_)); allok &= ok
        row.append(f"k={k}:{'ok' if ok else 'FAIL'}")
    print("   ", " ".join(row))
print(f"  grading holds on every sample: {allok}")

print("\n=== (ii)/(iii) F_5 in the two normalisations ===")
q_flat = float(np.einsum('abcd,abcd->', Rn, Rn))
tr3_flat = float(np.trace(M @ M @ M))
q_op = float(trk(A, 2)); tr3_op = float(trk(A, 3))
print(f"  |sqrt6 W_0|^2 : flat/tensor {q_flat:.4f}, operator {q_op:.4f}, "
      f"ratio {q_flat/q_op:.4f} (4)")
print(f"  tr(.^3)       : flat/tensor {tr3_flat:.4f}, operator {tr3_op:.4f}, "
      f"ratio {tr3_flat/tr3_op:.4f} (8)")
F5_flat = 1.5*q_flat**3 - 9*tr3_flat**2
F5_op   = 1.5*q_op**3   - 9*tr3_op**2
print(f"  F_5 (flat) = {F5_flat:.6f}, F_5 (operator) = {F5_op:.6f}")
print(f"  ratio: {'both zero' if abs(F5_op) < 1e-9 and abs(F5_flat) < 1e-9 else F5_flat/F5_op}")
print(f"  F_5(W_0) = 0 in BOTH normalisations: "
      f"{abs(F5_flat) < 1e-6 and abs(F5_op) < 1e-6}")
print("\n  and the 64 on a point where F_5 does NOT vanish (so the ratio is visible):")
for t in range(3):
    Wt = WI.random_weyl(N, 10007, rng).astype(float)
    Wt = Wt - 10007*(Wt > 5003)
    Mt = Wt.reshape(25, 25)
    At = np.array([[Wt[i][j][k][l] for (k, l) in PAIRS] for (i, j) in PAIRS])
    qf = float(np.einsum('abcd,abcd->', Wt, Wt)); t3f = float(np.trace(Mt@Mt@Mt))
    qo = float(trk(At, 2)); t3o = float(trk(At, 3))
    Ff = 1.5*qf**3 - 9*t3f**2; Fo = 1.5*qo**3 - 9*t3o**2
    print(f"    sample {t}: F_5 flat / F_5 operator = {Ff/Fo:.6f}   (64)")
