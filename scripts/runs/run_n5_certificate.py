"""The n=5 certificate by EVALUATION -- no Reynolds average, no apolarity pairing.

The route the record was building needed <P_i conj(P_j), J_b>, an apolarity
pairing, because a general Gram gives an invariant only after averaging.  That
cost 6.5 hours and needed the Gram of the 14 diagrams, which is worse.

It is unnecessary.  Reviewer 182 already noted that sum_ij G_ij P_i conj(P_j) is
a genuine real sum of squares: a Hermitian PSD form in (P_1(W), ..., P_m(W)) is
sum_k |L_k(W)|^2 = sum_k (Re L_k)^2 + (Im L_k)^2.  So if such a form equals F_5
POINTWISE, that is already a certificate -- the averaging was only ever needed
to force invariance, and F_5 is invariant to begin with.

Pointwise equality is testable by evaluation: each sample point gives one linear
equation in the Gram unknowns.  This is a STRICTLY STRONGER demand than the
averaged version, so failure here does not refute the averaged route.

RESULT: INCONSISTENT.  Coefficient rank 89 -- full -- against augmented rank 90
over 140 sample points.  Reviewers 189 and 190 both replicated it and extended
it to the FULL Hermitian G on all 41 covariants: 1681 unknowns, also
inconsistent, so the verdict never rested on block-diagonality, which nothing in
the pointwise demand forces.

Block-diagonality, which the shipped test imposed without argument, is WLOG:
P_i conj(P_j) is torus-trivial exactly when lambda_i = lambda_j, so the
block-diagonal part of any solution is itself a solution (189, premise verified
328/328).  The restriction was sound and the justification was missing.

Two notes on how to read that.  "Rank deficit of exactly 1" explains nothing --
appending a column raises rank by at most one, so the 1 is forced and carries a
single bit (190).  And the mod-p verdict transfers to Q only because
random_weyl is a purely rational construction and this script carries (re, im)
separately; collapsing the Gaussian part first would void it.

A SINGLE POINT REFUTES IT, with no sampling and no mod p -- reviewer 189.
P_1 = 144 tr(W^3) exactly and it is the ONLY invariant covariant, so every
reachable invariant Hermitian form is a real multiple of tr(W^3)^2.  The padded
tensor with Lambda^+ spectrum (1,-1,0) has tr(W^3) = 0 and |W|^2 = 32, so every
reachable form vanishes there while F_5 = 49152.  Exact integers.  The failure
is entirely the |W|^6 term.

AND THE REASON IS STRUCTURAL, not numerical.  P_i(gW) = <(gW)^3, u_i> =
<W^3, g^{-1} u_i>, and g^{-1} u_i does NOT lie in the span of the u_j: the
highest-weight vectors span a Cartan-graded slice, not a g-stable subspace.  So
sum_ij G_ij P_i conj(P_j) is invariant only when G is supported where the
covariant is ITSELF invariant -- which is NOT a general principle, and reviewer
189 is right to flag it: summing |P_k|^2 over a FULL irrep basis is invariant
with no invariant summand.  It holds here only because the u_i are one
highest-weight vector per copy rather than a basis of each copy.  At n = 5 that is the trivial block alone, whose
P_1 is an invariant cubic -- verified real at four samples, as an invariant must
be -- so |P_1|^2 is an invariant sextic and the earlier claim "invariant for no
nonzero G" was FALSE.  What the rank measurement establishes is the weaker and
correct statement: the invariant Hermitian forms available in the P_i are
confined to that one block, and F_5 is not among them.

That is exactly what the Reynolds average in reviewer 182's identity repairs,
and it is why the apolarity pairing cannot be shortcut this way.  The test cost
ten minutes against the 6.5 hours of the route it was trying to avoid, which is
why it was worth running before committing to that route.
"""
import sys, os, json, random, itertools
from fractions import Fraction as F

d = os.path.dirname(os.path.abspath(__file__))
P = 65537                      # 1 mod 4, so i exists: 256^2 = -1
assert pow(256, 2, P) == P - 1
I_ = 256

C = json.load(open(os.path.join(d, "n5_hw_cache.json")))
MONO = list(itertools.combinations_with_replacement(range(35), 3))
WTS = [tuple(w) for w in C["weights"]]

def gq(pair):
    """Gaussian rational [[rn,rd],[in,id]] -> F_p, using i = 256."""
    (rn, rd), (inn, idd) = pair
    r = rn * pow(rd % P, P-2, P) % P
    im = inn * pow(idd % P, P-2, P) % P
    return (r + im*I_) % P

hw = {}
for key, v in C["hw"].items():
    lam = tuple(int(x) for x in key.split(","))
    cols = v["cols"]
    hw[lam] = [{cols[j]: gq(x) for j, x in enumerate(vec) if gq(x)} for vec in v["vecs"]]
NV = sum(len(v) for v in hw.values())
print(f"loaded {NV} highest-weight vectors over F_{P}")

# weight basis as tensors over F_p
WB = [[[[[gq(C["wbasis_tensors"][a][i][j][k][l]) for l in range(5)]
         for k in range(5)] for j in range(5)] for i in range(5)] for a in range(35)]
print(f"weight basis: {len(WB)} tensors")

# --- the conjugation index: weight w <-> weight -w ---
neg = {}
for a, w in enumerate(WTS):
    cands = [b for b, w2 in enumerate(WTS) if w2 == (-w[0], -w[1])]
    neg[a] = cands
print(f"weight-negation classes computed; every index has a partner: "
      f"{all(neg[a] for a in range(35))}")
print(f"\n  next: evaluate P_i at sample Weyl tensors and assemble the pointwise system.")

# --- Gaussian arithmetic mod p, tracked as (re, im) so conjugation is exact ---
def gmul(x, y): return ((x[0]*y[0] - x[1]*y[1]) % P, (x[0]*y[1] + x[1]*y[0]) % P)
def gadd(x, y): return ((x[0]+y[0]) % P, (x[1]+y[1]) % P)
def gconj(x):   return (x[0], (-x[1]) % P)

def gq2(pair):
    (rn, rd), (inn, idd) = pair
    return (rn*pow(rd % P, P-2, P) % P, inn*pow(idd % P, P-2, P) % P)

HW2 = {}
for key, v in C["hw"].items():
    lam = tuple(int(x) for x in key.split(","))
    cols = v["cols"]
    HW2[lam] = [{cols[j]: gq2(x) for j, x in enumerate(vec) if gq2(x) != (0, 0)}
                for vec in v["vecs"]]
WB2 = [[[[[gq2(C["wbasis_tensors"][a][i][j][k][l]) for l in range(5)]
          for k in range(5)] for j in range(5)] for i in range(5)] for a in range(35)]

sys.path.insert(0, os.path.join(d, "..", "reviewers", "r179"))
import numpy as np, weyl_invariants as WI

def omegas(W):
    """omega_a = <W, f_a>, a Gaussian scalar, by direct contraction."""
    out = []
    for a in range(35):
        re = im = 0
        Ba = WB2[a]
        for i in range(5):
            for j in range(5):
                for k in range(5):
                    Bi = Ba[i][j][k]
                    Wi = W[i][j][k]
                    for l in range(5):
                        w = int(Wi[l]) % P
                        if w:
                            re += w*Bi[l][0]; im += w*Bi[l][1]
        out.append((re % P, im % P))
    return out

def Pval(u, om):
    """P_i(W) = sum_t u[t] * omega_{t1} omega_{t2} omega_{t3}."""
    tot = (0, 0)
    for idx, c in u.items():
        a, b, cc = MONO[idx]
        tot = gadd(tot, gmul(c, gmul(om[a], gmul(om[b], om[cc]))))
    return tot

rng = np.random.default_rng(3)
W0 = WI.random_weyl(5, P, rng)
om = omegas(W0)
print(f"\n  omega vector computed for one sample: {sum(1 for x in om if x != (0,0))}/35 nonzero")
lam0 = sorted(HW2)[0]
p0 = Pval(HW2[lam0][0], om)
print(f"  P_1 at that sample, block {lam0}: {p0}")
print(f"  conj is exact by construction: conj(conj(x)) == x: {gconj(gconj(p0)) == p0}")

# --- assemble the pointwise system ---
# G is Hermitian and block-diagonal: m^2 real unknowns per block of multiplicity m.
BL = sorted(HW2, key=lambda l: (-len(HW2[l]), l))
UNK = []          # (block, i, j, part) with part in {'re','im'}, i <= j
for lam in BL:
    m = len(HW2[lam])
    for i in range(m):
        UNK.append((lam, i, i, 're'))
        for j in range(i+1, m):
            UNK.append((lam, i, j, 're')); UNK.append((lam, i, j, 'im'))
print(f"\n  Hermitian block-diagonal unknowns: {len(UNK)}")

def F5(W):
    q = int(np.einsum('abcd,abcd->', W, W)) % P
    M = W.reshape(25, 25).astype(object) % P
    t3 = int(np.trace(M @ M @ M)) % P
    return (3*pow(2, P-2, P)*pow(q, 3, P) - 9*pow(t3, 2, P)) % P

NPTS = 140
rows, rhs = [], []
for s in range(NPTS):
    W = WI.random_weyl(5, P, np.random.default_rng(100+s))
    om = omegas(W)
    pv = {lam: [Pval(u, om) for u in HW2[lam]] for lam in BL}
    row = []
    for (lam, i, j, part) in UNK:
        z = gmul(pv[lam][i], gconj(pv[lam][j]))
        if i == j:            row.append(z[0] % P)
        elif part == 're':    row.append((2*z[0]) % P)
        else:                 row.append((-2*z[1]) % P)
    rows.append(row); rhs.append(F5(W))
    if (s+1) % 40 == 0: print(f"    {s+1}/{NPTS} points", flush=True)

def rank_aug(rows, rhs, p):
    m, n = len(rows), len(rows[0])
    M = [rows[t][:] + [rhs[t]] for t in range(m)]
    r = 0; piv = []
    for c in range(n+1):
        s = next((t for t in range(r, m) if M[t][c] % p), None)
        if s is None: continue
        M[r], M[s] = M[s], M[r]
        inv = pow(M[r][c] % p, p-2, p); M[r] = [(z*inv) % p for z in M[r]]
        for t in range(m):
            if t != r and M[t][c] % p:
                f = M[t][c]; M[t] = [(z - f*w) % p for z, w in zip(M[t], M[r])]
        piv.append(c); r += 1
        if r == m: break
    return r, piv

rA, _ = rank_aug(rows, [0]*len(rhs), P)
rAug, pivAug = rank_aug(rows, rhs, P)
print(f"\n  rank of the coefficient matrix : {rA}")
print(f"  rank of the augmented matrix   : {rAug}")
print(f"  CONSISTENT (F_5 is a pointwise Hermitian form in the P_i): {rA == rAug}")
print(f"  solution space dimension: {len(UNK) - rA}" if rA == rAug else
      "  INCONSISTENT -- the pointwise demand is too strong; the averaged route stands")
