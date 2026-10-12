"""The n=5 extremiser W_0, built and checked -- reviewer 178 listed it unchecked.

The record forces the trivial block to zero because tr(W_0^3) = 1/sqrt6 != 0,
and forces the vector block to zero by the same orbit constraint.  Both rest on
W_0 itself, which had never been built in this record.

W_0 is the padded Weyl tensor of CP^2: on R^4 with the standard complex
structure, Lambda^+ is spanned by w1 = e0^e1 + e2^e3, w2 = e0^e2 - e1^e3,
w3 = e0^e3 + e1^e2, each of squared norm 2, and W_{CP^2} acts as
diag(2,-1,-1)/sqrt6 on the normalised frame and zero elsewhere.
"""
from fractions import Fraction as F
import importlib.util, sys, os

d = os.path.dirname(os.path.abspath(__file__))
spec = importlib.util.spec_from_file_location("wm", os.path.join(d, "run_n5_weyl_module.py"))
wm = importlib.util.module_from_spec(spec)
out = sys.stdout; sys.stdout = open(os.devnull, "w")
spec.loader.exec_module(wm); sys.stdout = out
N, NP, PAIRS, PIDX = wm.N, wm.NP, wm.PAIRS, wm.PIDX
print(f"Weyl_5 loaded: dim {len(wm.BASIS)}, Casimir 16 exact")

def wed(i, j):
    return wm.wedge(i, j)

# --- W_0 as a symmetric operator on Lambda^2 R^5, in the PAIRS basis ---
def formvec(terms):
    v = [F(0)]*NP
    for (i, j), c in terms:
        for k, cc in wed(i, j).items(): v[k] += F(c)*cc
    return v

W1 = formvec([((0,1),1), ((2,3),1)])
W2 = formvec([((0,2),1), ((1,3),-1)])
W3 = formvec([((0,3),1), ((1,2),1)])
for nm, w in (("w1",W1),("w2",W2),("w3",W3)):
    print(f"  |{nm}|^2 = {sum(x*x for x in w)} (2)")

# W_0 = sum_s (s / |w|^2) w (x) w, with s = 2,-1,-1 and an overall 1/sqrt6.
# Work with S = sqrt6 * W_0, which is rational, and carry the sqrt6 symbolically.
S = [[F(0)]*NP for _ in range(NP)]
for w, s in ((W1, 2), (W2, -1), (W3, -1)):
    nrm = sum(x*x for x in w)
    for a in range(NP):
        for b in range(NP):
            if w[a] and w[b]: S[a][b] += F(s, 1)*w[a]*w[b]/nrm

# --- spectrum of S ---
def charpoly_eigs(M):
    """rational eigenvalues by testing the small integer candidates that occur."""
    import itertools
    eigs = []
    for cand in (F(2), F(-1), F(0)):
        # dim ker(M - cand I)
        A = [[M[i][j] - (cand if i == j else 0) for j in range(NP)] for i in range(NP)]
        r, piv = 0, []
        for c in range(NP):
            p = next((k for k in range(r, NP) if A[k][c]), None)
            if p is None: continue
            A[r], A[p] = A[p], A[r]
            inv = F(1,1)/A[r][c]; A[r] = [x*inv for x in A[r]]
            for k in range(NP):
                if k != r and A[k][c]:
                    f = A[k][c]; A[k] = [x - f*y for x, y in zip(A[k], A[r])]
            r += 1
        eigs.append((cand, NP - r))
    return eigs

print("\n=== spectrum of sqrt6 * W_0 on Lambda^2 R^5 ===")
tot = 0
for val, mult in charpoly_eigs(S):
    print(f"  eigenvalue {val}  multiplicity {mult}")
    tot += mult
print(f"  accounted for {tot} of {NP}  (record: (2,-1,-1,0^7))  match: {tot == NP}")

trS  = sum(S[i][i] for i in range(NP))
tr2  = sum(S[i][k]*S[k][i] for i in range(NP) for k in range(NP))
tr3  = sum(S[i][k]*S[k][l]*S[l][i]
           for i in range(NP) for k in range(NP) for l in range(NP))
print(f"\n  tr(S)   = {trS}   (0, since W_0 is trace-free on Lambda^2)")
print(f"  tr(S^2) = {tr2}   so |W_0|^2 = {tr2}/6 = {F(tr2,6)}  (1: {F(tr2,6)==1})")
print(f"  tr(S^3) = {tr3}   so tr(W_0^3) = {tr3}/6^(3/2) = {F(tr3,6)}/sqrt6")
print(f"  => tr(W_0^3) = 1/sqrt6 exactly: {F(tr3,6) == 1}")

# --- theta = 3 tr(W^3) at n <= 5, by the Lovelock collapse ---
print(f"\n  theta = 3 tr(W_0^3) = 3/sqrt6 = sqrt(9/6) = sqrt(3/2)"
      f"   (Lovelock collapse at n <= 5)")
print(f"  3/sqrt6 squared = {F(9,6)}  (3/2: {F(9,6)==F(3,2)})")

# --- is W_0 actually in Weyl_5? ---
# sym2_to_R reads the UNDOUBLED coordinate as the operator entry, so doubling
# the off-diagonals here tested 2S - diag(S) rather than W_0.  It passed only
# because diag(S) is itself a diagonal Weyl tensor -- a check that succeeds for
# the wrong reason (reviewer 184).  The conclusion was true; the test was not.
vec = [F(0)]*len(wm.SPAIRS)
for k, (a, b) in enumerate(wm.SPAIRS):
    vec[k] = S[a][b]
rows = wm.bianchi_rows() + wm.ricci_rows()
resid = [sum(r[i]*vec[i] for i in range(len(vec))) for r in rows]
print(f"\n  W_0 satisfies first Bianchi and Ric = 0 exactly: {not any(resid)}")

# That test alone CANNOT distinguish the two candidate vectors: diag(S) is
# itself a Weyl tensor, so 2S - diag(S) passes Bianchi and Ric = 0 as well
# (reviewer 185).  The discriminating check is the ROUND TRIP -- sym2_to_R must
# return S entrywise on the Lambda^2 index pairs.
R = wm.sym2_to_R({wm.SPAIRS[k]: c for k, c in enumerate(vec) if c})
back = all(R[i][j][k][l] == S[wm.PIDX[(i, j)]][wm.PIDX[(k, l)]]
           for (i, j) in PAIRS for (k, l) in PAIRS)
print(f"  round trip sym2_to_R -> Lambda^2 returns S entrywise: {back}")
bad = [F(0)]*len(wm.SPAIRS)
for k, (a, b) in enumerate(wm.SPAIRS):
    bad[k] = S[a][b] * (1 if a == b else 2)
Rb = wm.sym2_to_R({wm.SPAIRS[k]: c for k, c in enumerate(bad) if c})
backb = all(Rb[i][j][k][l] == S[wm.PIDX[(i, j)]][wm.PIDX[(k, l)]]
            for (i, j) in PAIRS for (k, l) in PAIRS)
residb = [sum(r[i]*bad[i] for i in range(len(bad))) for r in rows]
print(f"  the doubled vector also passes Bianchi and Ric = 0: {not any(residb)}"
      f"   <- why that test could not fail")
print(f"  but it FAILS the round trip: {not backb}   <- the test that separates them")

# The round trip is an ENCODING test and does not pin W_0 (reviewer 188): the
# (1,1,-2) frame passes Bianchi, Ric = 0 AND the round trip, with tr(S^3) = -6
# and theta negative.  What identifies W_0 is the SIGN and value of tr(W_0^3),
# which this script printed but never gated on.  It gates now.
assert trS == 0, f"W_0 must be Lambda^2-trace-free; got {trS}"
assert F(tr2, 6) == 1, f"|W_0|^2 must be 1; got {F(tr2, 6)}"
assert F(tr3, 6) == 1, ("tr(W_0^3) must be +1/sqrt6, not "
                        f"{F(tr3,6)}/sqrt6 -- a sign flip is the (1,1,-2) frame")
print("\n  GATED on tr = 0, |W_0|^2 = 1 and tr(W_0^3) = +1/sqrt6 WITH ITS SIGN.")
print("  The (1,1,-2) frame has tr(S^3) = -6 and theta < 0; it passes Bianchi,")
print("  Ric = 0 and the round trip, and fails only here.")
