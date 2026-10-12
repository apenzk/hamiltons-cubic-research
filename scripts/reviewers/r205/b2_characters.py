"""r205: independent B2 character arithmetic -- no repo code reused.

Exact Laurent polynomials in doubled exponents (so lambda+rho is integral).
Verifies, from the Weyl character formula alone:
  * the 24-block decomposition of Sym^3(W_(2,2)) claimed in findings/sym3-blocks.md
  * dim (Sym^6 W)^{O(5)} = 14 and the degree 2..6 sequence
  * dim Sym^2(Sym^3 W)^{O(5)} = 65, dim Lambda^2(...) = 24
  * the 65 = 36 + 29 split arithmetic under the lambda_2-parity rule
  * dim V_lambda^{U(2)} for every block, by Weyl integration over U(2)
"""
from collections import defaultdict
from fractions import Fraction

def mul(p, q):
    r = defaultdict(Fraction)
    for a, ca in p.items():
        for b, cb in q.items():
            r[(a[0]+b[0], a[1]+b[1])] += ca*cb
    return {k: v for k, v in r.items() if v != 0}

def add(p, q, s=1):
    r = defaultdict(Fraction, p)
    for k, v in q.items():
        r[k] += s*v
    return {k: v for k, v in r.items() if v != 0}

def scal(p, c):
    return {k: c*v for k, v in p.items() if c*v != 0}

def subst(p, j):
    """t -> t^j on the torus: exponents scale."""
    r = defaultdict(Fraction)
    for (a, b), c in p.items():
        r[(j*a, j*b)] += c
    return dict(r)

WEYL = []
for perm, sgn in (((0, 1), 1), ((1, 0), -1)):
    for s1 in (1, -1):
        for s2 in (1, -1):
            WEYL.append((perm, (s1, s2), sgn*s1*s2))

def alternant(v):
    """sum_w det(w) e^{w(v)}, v in DOUBLED coordinates."""
    r = defaultdict(Fraction)
    for perm, sg, det in WEYL:
        w = (sg[0]*v[perm[0]], sg[1]*v[perm[1]])
        r[w] += det
    return {k: c for k, c in r.items() if c != 0}

RHO2 = (3, 1)                      # rho = (3/2, 1/2), doubled
DELTA = alternant(RHO2)

def lexmax(p):
    return max(p)

def divide(num, den):
    """Exact Laurent division; den's lex-leading monomial has coefficient 1."""
    lead = lexmax(den)
    assert den[lead] == 1, den[lead]
    q, r = {}, dict(num)
    while r:
        m = lexmax(r)
        c = r[m]
        t = (m[0]-lead[0], m[1]-lead[1])
        q[t] = q.get(t, Fraction(0)) + c
        r = add(r, scal(den, c), s=-1)
        r = {k: v for k, v in r.items() if v != 0}
    return q

def character(lam):
    """chi_lambda for B2, lambda = (l1,l2) integral dominant."""
    return divide(alternant((2*lam[0]+3, 2*lam[1]+1)), DELTA)

def decompose(chi):
    """multiplicities of irreducibles in a W-invariant character."""
    prod = mul(chi, DELTA)
    out = {}
    for (i, j), c in prod.items():
        if i > j > 0 and i % 2 == 1 and j % 2 == 1:
            lam = ((i-3)//2, (j-1)//2)
            if lam[0] >= lam[1] >= 0 and c != 0:
                out[lam] = c
    return out

def dim(lam):
    a, b = lam[0]+Fraction(3, 2), lam[1]+Fraction(1, 2)
    d = Fraction(2, 3)*(a*a-b*b)*a*b
    assert d.denominator == 1
    return int(d)

def sym_powers(chi, kmax):
    """h_0..h_kmax of the character, by Newton's identity."""
    p = {j: subst(chi, j) for j in range(1, kmax+1)}
    h = {0: {(0, 0): Fraction(1)}}
    for k in range(1, kmax+1):
        acc = {}
        for j in range(1, k+1):
            acc = add(acc, mul(p[j], h[k-j]))
        h[k] = scal(acc, Fraction(1, k))
    return h

def trivial_mult(chi):
    return decompose(chi).get((0, 0), 0)

CHI_W = character((2, 2))
print(f"dim W_(2,2) = {sum(CHI_W.values())}  (expect 35)")
assert sum(CHI_W.values()) == 35

H = sym_powers(CHI_W, 6)

print("\n--- invariants of Sym^k(W), k = 2..6 ---")
seq = [trivial_mult(H[k]) for k in range(2, 7)]
print(f"  {seq}   (record claims 1,1,4,5,14)")

S3 = H[3]
blocks = decompose(S3)
print(f"\n--- Sym^3(W): {len(blocks)} blocks, mult sum {sum(blocks.values())}, "
      f"dim sum {sum(int(m)*dim(l) for l, m in blocks.items())} ---")

MULT_REPO = {(0,0):1,(1,0):1,(2,0):2,(3,0):2,(2,1):2,(2,2):4,(4,0):2,(3,1):2,
             (3,3):1,(5,0):1,(3,2):3,(6,0):1,(4,1):2,(4,4):2,(4,2):4,(4,3):2,
             (5,1):1,(5,2):2,(5,4):1,(5,3):1,(6,6):1,(6,2):1,(6,3):1,(6,4):1}
mine = {l: int(m) for l, m in blocks.items()}
print("  matches the repo table:", mine == MULT_REPO)
if mine != MULT_REPO:
    print("   repo-only:", {k: v for k, v in MULT_REPO.items() if mine.get(k) != v})
    print("   mine-only:", {k: v for k, v in mine.items() if MULT_REPO.get(k) != v})

# Sym^2 and Lambda^2 of Sym^3
sq = subst(S3, 2)
sym2 = scal(add(mul(S3, S3), sq), Fraction(1, 2))
alt2 = scal(add(mul(S3, S3), sq, s=-1), Fraction(1, 2))
print(f"\n  dim Sym^2(Sym^3 W)^G  = {trivial_mult(sym2)}   (repo 65)")
print(f"  dim Lambda^2(Sym^3 W)^G = {trivial_mult(alt2)}   (repo 24)")
print(f"  sum m(m+1)/2 = {sum(m*(m+1)//2 for m in mine.values())}, "
      f"sum m(m-1)/2 = {sum(m*(m-1)//2 for m in mine.values())}, "
      f"sum m^2 = {sum(m*m for m in mine.values())}")

# --- U(2)-invariants, block by block, by Weyl integration over U(2) -----
# roots of u(2) are +-(e1-e2); |W(U(2))| = 2.
U2FAC = mul({(2, -2): Fraction(-1), (0, 0): Fraction(1)},
            {(-2, 2): Fraction(-1), (0, 0): Fraction(1)})

def u2_invariants(lam):
    prod = mul(character(lam), U2FAC)
    c = prod.get((0, 0), Fraction(0))
    assert (c/2).denominator == 1, (lam, c)
    return int(c/2)

print("\n--- dim V_lambda^{U(2)} for each of the 24 blocks ---")
bad = []
for lam in sorted(mine):
    d = u2_invariants(lam)
    if d != 1:
        bad.append((lam, d))
print("  all equal 1:", not bad, bad if bad else "")

even = {l: m for l, m in mine.items() if l[1] % 2 == 0}
odd = {l: m for l, m in mine.items() if l[1] % 2 == 1}
print(f"\n  lambda_2 even: {len(even)} blocks, dim sum {sum(dim(l) for l in even)}"
      f" (record 3570), mult sum {sum(even.values())}")
print(f"  lambda_2 odd : {len(odd)} blocks, dim sum {sum(dim(l) for l in odd)},"
      f" mult sum {sum(odd.values())}")
onk = sum((m-1)*m//2 for m in even.values()) + sum(m*(m+1)//2 for m in odd.values())
ann = sum(even.values())
print(f"  65 = {onk} + {ann}")
