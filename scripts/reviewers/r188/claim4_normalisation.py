"""Is the record self-consistent now that it has committed to the TENSOR
normalisation?  Exact, at n=5, on the padded CP^2 extremiser and on random
Weyl tensors over Q.

Three questions, in order of how much they matter:
  Q1  does the choice move Theta?  (If it does, sqrt(3/2) is wrong in one of
      the two conventions and half the repo is mis-scaled.)
  Q2  does the choice move F_5 by anything worse than a positive scalar?
  Q3  where, concretely, would a MIXED use bite -- and does that place exist
      in the repo today?
"""
from fractions import Fraction as F
from itertools import combinations
import importlib.util, sys, os

d = os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "..", "runs")
spec = importlib.util.spec_from_file_location("wm", os.path.join(d, "run_n5_weyl_module.py"))
wm = importlib.util.module_from_spec(spec)
o = sys.stdout; sys.stdout = open(os.devnull, "w"); spec.loader.exec_module(wm); sys.stdout = o
N, NP, PAIRS, PIDX, SPAIRS = wm.N, wm.NP, wm.PAIRS, wm.PIDX, wm.SPAIRS
print(f"Weyl_5 rebuilt: dim {len(wm.BASIS)}")

def tensor_of(coefs):
    """rank-4 tensor of sum_k coefs[k] * BASIS[k]."""
    v = {}
    for k, c in enumerate(coefs):
        if not c: continue
        for j, x in enumerate(wm.BASIS[k]):
            if x: v[SPAIRS[j]] = v.get(SPAIRS[j], F(0)) + c*x
    return wm.sym2_to_R(v)

def A_of(R):
    return [[R[i][j][k][l] for (k, l) in PAIRS] for (i, j) in PAIRS]

def q_tensor(R):
    return sum(R[i][j][k][l]**2 for i in range(N) for j in range(N)
               for k in range(N) for l in range(N))
def tr_op(A, k):
    M = [row[:] for row in A]
    for _ in range(k-1):
        M = [[sum(M[i][t]*A[t][j] for t in range(NP)) for j in range(NP)] for i in range(NP)]
    return sum(M[i][i] for i in range(NP))
def tr_flat(R, k):
    """tr(M^k) for the FLAT n^2 x n^2 reshape M[(i,j),(k,l)] = R_ijkl."""
    idx = [(i, j) for i in range(N) for j in range(N)]
    M0 = [[R[i][j][k][l] for (k, l) in idx] for (i, j) in idx]
    M = [row[:] for row in M0]
    for _ in range(k-1):
        M = [[sum(M[i][t]*M0[t][j] for t in range(len(idx))) for j in range(len(idx))]
             for i in range(len(idx))]
    return sum(M[i][i] for i in range(len(idx)))

# ---- the extremiser, rebuilt here (S = sqrt6 W_0 as a Lambda^2 operator) ----
def formvec(terms):
    v = [F(0)]*NP
    for (i, j), c in terms:
        for k, cc in wm.wedge(i, j).items(): v[k] += F(c)*cc
    return v
W1 = formvec([((0,1),1), ((2,3),1)])
W2 = formvec([((0,2),1), ((1,3),-1)])
W3 = formvec([((0,3),1), ((1,2),1)])
def frame_op(spec):
    S = [[F(0)]*NP for _ in range(NP)]
    for w, s in zip((W1, W2, W3), spec):
        nrm = sum(x*x for x in w)
        for a in range(NP):
            for b in range(NP):
                if w[a] and w[b]: S[a][b] += F(s)*w[a]*w[b]/nrm
    return S
S = frame_op((2, -1, -1))
RS = wm.sym2_to_R({SPAIRS[k]: S[a][b] for k, (a, b) in enumerate(SPAIRS)})

print("\n=== Q1  does the normalisation move Theta? ===")
qt, qo = q_tensor(RS), tr_op(S, 2)
t3f, t3o = tr_flat(RS, 3), tr_op(S, 3)
print(f"  at S = sqrt6 W_0:  |S|^2_tensor = {qt}, tr(A^2) = {qo}, ratio {F(qt,qo)} (4)")
print(f"                     tr_flat(S^3) = {t3f}, tr_op(S^3) = {t3o}, ratio {F(t3f,t3o)} (8)")
print(f"  theta_operator = 3 tr_op(S^3)/tr(A^2)^(3/2) : squared = "
      f"{F(9*t3o*t3o, qo**3)}  (3/2: {F(9*t3o*t3o, qo**3)==F(3,2)})")
print(f"  theta_tensor   = 3 tr_flat(S^3)/|S|^3_tensor: squared = "
      f"{F(9*t3f*t3f, qt**3)}  (3/2: {F(9*t3f*t3f, qt**3)==F(3,2)})")
print("  => Theta^2 = 3/2 is the SAME number in both: |W|^2 scales by 4 and")
print("     tr(W^3) by 8, and 4^3 = 8^2 = 64, so the ratio is invariant.")

print("\n=== Q2  does it move F_5 by more than a positive scalar? ===")
import random
random.seed(188)
ratios = []
for t in range(6):
    co = [F(random.randint(-4, 4)) for _ in range(35)]
    R = tensor_of(co); A = A_of(R)
    Ft = F(3,2)*q_tensor(R)**3 - 9*tr_flat(R,3)**2
    Fo = F(3,2)*tr_op(A,2)**3   - 9*tr_op(A,3)**2
    r = None if Fo == 0 else F(Ft, Fo)
    print(f"  random Weyl #{t}: F_tensor/F_operator = {r}")
    ratios.append(r)
print(f"  the ratio is the constant 64 on every sample: "
      f"{set(ratios) == {F(64)}}")

print("\n=== Q3  where a MIXED use would bite ===")
print("  P_i(W) = <W^3, u_i> uses the Gram G on Weyl_5 three times, so")
print("  G -> 4G scales P_i by 4^3 and P_i conj(P_j) by 4^6.")
print("  F_5 is degree 6 in W and scales by 4^3 = 64 (Q2).")
print("  Residual mismatch in <P_i conj(P_j), J_b> = <F_5, J_b>: 4^6/4^3 = 64.")
print("  Reviewer 185's '4^3 leak' is therefore the right number.")

# who actually forms such a pairing today?
import subprocess
root = os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "..", "..")
out = subprocess.run(["grep", "-rln", "spec_from_file_location.*inner_product",
                      os.path.join(root, "scripts", "runs")],
                     capture_output=True, text=True).stdout.split()
print(f"\n  scripts under scripts/runs/ that IMPORT the invariant Gram: "
      f"{[os.path.basename(x) for x in out] or 'none'}")
print("  (run_n5_cubic_forms.py names it in prose only, and forms no P_i;")
print("   run_n5_dictionary.py is a scaffold that stops before the pairing.)")
print("  The normalisation decision therefore has no consumer in the repo:")
print("  the hazard is latent, and every object built so far is homogeneous of")
print("  a single degree, so the choice is a uniform positive scalar on each.")

print("\n=== Q4  the frame the record rejects, put through the SAME tests ===")
Sb = frame_op((1, 1, -2))
vecb = [Sb[a][b] for (a, b) in SPAIRS]
rows = wm.bianchi_rows() + wm.ricci_rows()
resid = [sum(r[i]*vecb[i] for i in range(len(vecb))) for r in rows]
Rb = wm.sym2_to_R({SPAIRS[k]: vecb[k] for k in range(len(SPAIRS))})
back = all(Rb[i][j][k][l] == Sb[PIDX[(i,j)]][PIDX[(k,l)]]
           for (i, j) in PAIRS for (k, l) in PAIRS)
print(f"  spec (1,1,-2): Bianchi and Ric = 0: {not any(resid)}")
print(f"                 passes the ROUND TRIP too: {back}")
print(f"                 tr(S^3) = {tr_op(Sb,3)} against {tr_op(S,3)} for (2,-1,-1)")
print(f"                 theta^2 = {F(9*tr_op(Sb,3)**2, tr_op(Sb,2)**3)}, sign of theta"
      f" is {'negative' if tr_op(Sb,3) < 0 else 'positive'}")
print("  => the round trip separates S from 2S-diag(S) (an ENCODING question)")
print("     and does NOT separate the two frames (a SPECTRUM question).")
