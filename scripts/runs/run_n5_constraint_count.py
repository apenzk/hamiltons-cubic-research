"""How many constraints an SOS certificate for F_5 actually faces.

The record carries '36 unknowns against 14 constraints' with the 14 never
derived.  The constraint count is dim (Sym^k Weyl_5)^{O(5)}: the Gram entries
map into the invariant sextics, and matching F_5 is one equation per basis
invariant.

Computed by Weyl integration, exactly, in Laurent polynomials over Z:
  dim V^G = (1/|W|) CT[ chi_V(t) * prod_{alpha in Phi} (1 - t^alpha) ].
Sym^k characters come from the power sums p_j(t) = chi(t^j) by Newton, so
nothing of dimension 3838380 is ever materialised -- the whole computation
lives on a weight lattice of a few hundred points.
"""
from fractions import Fraction as F
from itertools import product

# --- Laurent polynomials in two variables, as dicts {(a,b): coeff} ---
def mul(P, Q):
    R = {}
    for k1, c1 in P.items():
        for k2, c2 in Q.items():
            k = (k1[0]+k2[0], k1[1]+k2[1]); R[k] = R.get(k, 0) + c1*c2
    return {k: c for k, c in R.items() if c}
def add(P, Q):
    R = dict(P)
    for k, c in Q.items():
        R[k] = R.get(k, 0) + c
    return {k: c for k, c in R.items() if c}
def scal(a, P): return {k: a*c for k, c in P.items() if a*c}
def subst(P, j):  return {(j*k[0], j*k[1]): c for k, c in P.items()}   # t -> t^j

# --- Weyl character formula for B_2, exponents DOUBLED to clear rho ---
# W(B_2): signed permutations of two coordinates, |W| = 8.
WEYL = []
for sw in (0, 1):
    for s1, s2 in product((1, -1), repeat=2):
        # w(a,b) = (s1*a, s2*b) then optionally swap
        det = s1 * s2 * (-1 if sw else 1)
        WEYL.append((sw, s1, s2, det))
def act(w, v):
    sw, s1, s2, _ = w
    a, b = (v[1], v[0]) if sw else (v[0], v[1])
    return (s1*a, s2*b)

RHO2 = (3, 1)                     # 2*rho = (3,1) in doubled exponents
def alternant(mu2):               # mu2 already doubled
    P = {}
    for w in WEYL:
        k = act(w, mu2); P[k] = P.get(k, 0) + w[3]
    return {k: c for k, c in P.items() if c}

def divide(N, D):                 # exact Laurent division, D a unit-content alternant
    N = dict(N); Q = {}
    dlead = max(D, key=lambda k: (k[0], k[1])); dc = D[dlead]
    while N:
        nlead = max(N, key=lambda k: (k[0], k[1]))
        k = (nlead[0]-dlead[0], nlead[1]-dlead[1]); c = F(N[nlead], dc)
        Q[k] = Q.get(k, 0) + c
        for dk, dcv in D.items():
            kk = (dk[0]+k[0], dk[1]+k[1]); N[kk] = N.get(kk, 0) - c*dcv
        N = {a: b for a, b in N.items() if b}
    return {k: (int(c) if c.denominator == 1 else c) for k, c in Q.items()}

def character(lam):               # lam = (l1, l2) integral dominant
    lam2 = (2*lam[0] + RHO2[0], 2*lam[1] + RHO2[1])
    return divide(alternant(lam2), alternant(RHO2))

CHI = character((2, 2))
print(f"chi_(2,2) at t=1 -> dim = {sum(CHI.values())}   (Weyl_5 = 35)")
assert sum(CHI.values()) == 35

# --- Sym^k characters from power sums, Newton's identity ---
def sym_powers(chi, K):
    p = {j: subst(chi, j) for j in range(1, K+1)}
    h = {0: {(0, 0): F(1)}}
    for k in range(1, K+1):
        acc = {}
        for j in range(1, k+1):
            acc = add(acc, mul(p[j], h[k-j]))
        h[k] = scal(F(1, k), acc)
    return h

# --- Weyl integration: multiply by prod (1 - t^alpha), take constant term ---
ROOTS = [(1,0),(-1,0),(0,1),(0,-1),(1,1),(1,-1),(-1,1),(-1,-1)]
def invariants(P):
    Q = dict(P)
    for a in ROOTS:
        Q = add(Q, scal(-1, {(k[0]+2*a[0], k[1]+2*a[1]): c for k, c in Q.items()}))
    return Q.get((0, 0), 0) / 8

K = 6
H = sym_powers(CHI, K)
print("\n=== O(5)-invariants of Weyl_5 by degree ===")
print("  NOTE: this is the SO(5) integration; O(5) = SO(5) x {+-Id} and -Id acts")
print("  trivially on Weyl_5, so the two agree here.")
for k in range(1, K+1):
    d = invariants(H[k])
    print(f"  degree {k}:  dim (Sym^{k} Weyl_5)^O(5) = {d}")
