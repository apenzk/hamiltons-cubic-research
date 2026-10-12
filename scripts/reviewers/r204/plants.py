"""r204 / claim 5.  Sabotage plants against the four repairs of 8d1bf88, and
what each still misses.

The definitions below are transcribed VERBATIM from run_n5_assemble.py
(PRIME, gp, gpmul, gpadd, gpconj, the three unit tests, _det_g) so that a
sabotage here is a sabotage of that file's arithmetic.
"""
from fractions import Fraction as F

PRIME = 1000033
IMOD = next(x for x in range(2, PRIME) if pow(x, 2, PRIME) == PRIME - 1)

def gp_ok(x):
    if hasattr(x, "r"): a, b = x.r, x.i
    else: (a, b) = x
    return (a.numerator * pow(a.denominator % PRIME, PRIME-2, PRIME) % PRIME,
            b.numerator * pow(b.denominator % PRIME, PRIME-2, PRIME) % PRIME)
def gpmul_ok(u, v):
    return ((u[0]*v[0] - u[1]*v[1]) % PRIME, (u[0]*v[1] + u[1]*v[0]) % PRIME)
def gpadd_ok(u, v): return ((u[0]+v[0]) % PRIME, (u[1]+v[1]) % PRIME)
def gpconj_ok(u):   return (u[0], (-u[1]) % PRIME)

_SAMPLE = [((F(1), F(2)), (F(3), F(-5))), ((F(-7, 3), F(4)), (F(0), F(11, 2))),
           ((F(5, 8), F(-1, 6)), (F(2, 9), F(7, 4)))]
def _cmul(x, y):
    return (x[0]*y[0] - x[1]*y[1], x[0]*y[1] + x[1]*y[0])

def unit_tests(gp, gpmul):
    """the THREE O(1) asserts the commit added.  Returns which of them fire."""
    fired = []
    if not gpmul((0, 1), (0, 1)) == (PRIME - 1, 0): fired.append("i^2 == -1")
    if not (gp((F(1), F(0))) == (1, 0) and gp((F(0), F(1))) == (0, 1)):
        fired.append("gp keeps re/im in their slots")
    if not all(gpmul(gp(x), gp(y)) == gp(_cmul(x, y)) for x, y in _SAMPLE):
        fired.append("gp is a ring map")
    return fired

def hermitian_assert(gp, gpmul, gpadd, gpconj):
    """the PRE-EXISTING check: h = h^*, on a small synthetic two-copy block.
    Two copies with 4 positions of Gaussian-rational coefficients; the assert
    only tests conjugate symmetry of the measured h."""
    import random
    rnd = random.Random(7)
    def rq(): return (F(rnd.randint(-9, 9), rnd.randint(1, 5)),
                      F(rnd.randint(-9, 9), rnd.randint(1, 5)))
    cop = [[[rq() for _ in range(4)] for _ in range(3)] for _ in range(2)]
    K = [[rq() for _ in range(4)] for _ in range(4)]            # the Sym^3 metric
    K = [[K[a][b] if a <= b else (K[b][a][0], -K[b][a][1])      # made Hermitian
          for b in range(4)] for a in range(4)]
    for a in range(4): K[a][a] = (K[a][a][0], F(0))
    def ip(u, v):
        tot = (0, 0)
        for a in range(4):
            ca = gp(u[a])
            for b in range(4):
                tot = gpadd(tot, gpmul(gpmul(ca, gpconj(gp(v[b]))), gp(K[a][b])))
        return tot
    h = [[ip(cop[i][0], cop[j][0]) for j in range(2)] for i in range(2)]
    return all(h[i][j] == gpconj(h[j][i]) for i in range(2) for j in range(2)), h

print("=" * 76)
print("A.  THE THREE gp/gpmul UNIT TESTS vs reviewer 201's two escapees")
print("=" * 76)
def gpmul_i2plus(u, v):      # split-complex: i^2 = +1
    return ((u[0]*v[0] + u[1]*v[1]) % PRIME, (u[0]*v[1] + u[1]*v[0]) % PRIME)
def gp_swap(x):
    a, b = gp_ok(x); return (b, a)
def gpmul_imflip(u, v):      # im = u0 v1 - u1 v0
    return ((u[0]*v[0] - u[1]*v[1]) % PRIME, (u[0]*v[1] - u[1]*v[0]) % PRIME)

rows = [("control (unsabotaged)", gp_ok, gpmul_ok, gpadd_ok, gpconj_ok),
        ("201-a  gpmul with i^2 = +1", gp_ok, gpmul_i2plus, gpadd_ok, gpconj_ok),
        ("201-b  gp swaps re and im", gp_swap, gpmul_ok, gpadd_ok, gpconj_ok),
        ("new-c  gpmul im = u0v1-u1v0", gp_ok, gpmul_imflip, gpadd_ok, gpconj_ok),
        ("new-d  gpadd subtracts im", gp_ok, gpmul_ok,
         lambda u, v: ((u[0]+v[0]) % PRIME, (u[1]-v[1]) % PRIME), gpconj_ok),
        ("new-d2 gpadd DROPS v's im", gp_ok, gpmul_ok,
         lambda u, v: ((u[0]+v[0]) % PRIME, u[1]), gpconj_ok),
        ("new-d3 gpadd doubles v's im", gp_ok, gpmul_ok,
         lambda u, v: ((u[0]+v[0]) % PRIME, (u[1]+2*v[1]) % PRIME), gpconj_ok),
        ("new-e  gpconj is identity", gp_ok, gpmul_ok, gpadd_ok, lambda u: u),
        ("new-f  gp drops denominators", lambda x: (x[0].numerator % PRIME,
                                                    x[1].numerator % PRIME),
         gpmul_ok, gpadd_ok, gpconj_ok)]
print(f"  {'sabotage':30s} {'unit tests fire':40s} {'h Herm':8s} {'h right':8s}")
_ctrl = None
for name, gp, gpm, gpa, gpc in rows:
    f = unit_tests(gp, gpm)
    ok, hh = hermitian_assert(gp, gpm, gpa, gpc)
    if _ctrl is None: _ctrl = hh
    print(f"  {name:30s} {(', '.join(f) if f else '-- NONE --'):40s} "
          f"{str(ok):8s} {str(hh == _ctrl):8s}")
print("""
  READ.  The three tests catch 201's two escapees (201-a, 201-b) and the im-sign
  flip.  They touch gpmul and gp only, so gpadd is untested -- and gpadd is the
  accumulator inside ip3_g, where every h entry is formed.

  THREE gpadd SABOTAGES PASS ALL THREE UNIT TESTS *AND* THE HERMITIAN ASSERT
  and produce a WRONG h.  The worst is new-d2, `gpadd` ignoring the second
  argument's imaginary part: the accumulator then never carries an imaginary
  part at all, so h comes out exactly Re(h) -- REAL SYMMETRIC.  That is the very
  observation the record reads as "the basis is / is not the real one", so this
  corruption does not merely escape the checks, it manufactures the evidence
  for the conclusion stage 4 draws.
""")

print("=" * 76)
print("B.  det h != 0 -- what it catches, and the whole class it cannot see")
print("=" * 76)
def _det_g(M):
    k = len(M)
    if k == 1: return M[0][0]
    tot = (0, 0)
    for c in range(k):
        minor = [[M[r][cc] for cc in range(k) if cc != c] for r in range(1, k)]
        term = gpmul_ok(M[0][c], _det_g(minor))
        tot = gpadd_ok(tot, term if c % 2 == 0 else gpmul_ok(term, (PRIME-1, 0)))
    return tot

# correctness of _det_g itself, against exact Gaussian determinants
import itertools, random
rnd = random.Random(11)
def cdet(M):
    k = len(M)
    if k == 1: return M[0][0]
    t = (0, 0)
    for c in range(k):
        mi = [[M[r][cc] for cc in range(k) if cc != c] for r in range(1, k)]
        d = cdet(mi); s = 1 if c % 2 == 0 else -1
        p = (M[0][c][0]*d[0] - M[0][c][1]*d[1], M[0][c][0]*d[1] + M[0][c][1]*d[0])
        t = (t[0] + s*p[0], t[1] + s*p[1])
    return t
bad = 0
for _ in range(300):
    k = rnd.choice([2, 3, 4])
    M = [[(rnd.randint(-9, 9), rnd.randint(-9, 9)) for _ in range(k)] for _ in range(k)]
    e = cdet(M)
    if _det_g([[ (x % PRIME, y % PRIME) for x, y in row] for row in M]) != (e[0] % PRIME, e[1] % PRIME):
        bad += 1
print(f"  _det_g reproduces the exact Gaussian determinant on 300 random matrices: "
      f"{300-bad}/300")
assert bad == 0

allones = [[(1, 0)]*3 for _ in range(3)]
print(f"  coincident copies (h = all-ones, m=3): det = {_det_g(allones)}  -> FIRES")
assert _det_g(allones) == (0, 0)
print(f"  m = 1 blocks: HMAT[lam] is the LITERAL [[(1,0)]] set by the m==1 branch,")
print(f"  so det = {_det_g([[(1,0)]])} unconditionally.  12 of the 24 blocks are")
print("  m = 1, so the printed 'det h nonzero on all 24' is a check on 12.")

# a NON-coincident change that passes det != 0 and every other check in the file
import cmath
h = [[complex(1), 55j/37], [-55j/37, 5075/1628]]
def congr(P, h):
    Pd = [[P[j][i].conjugate() for j in range(2)] for i in range(2)]
    t = [[sum(Pd[i][k]*h[k][l] for k in range(2)) for l in range(2)] for i in range(2)]
    return [[sum(t[i][k]*P[k][j] for k in range(2)) for j in range(2)] for i in range(2)]
for name, P in (("copy_2 -> i * copy_2", [[1, 0], [0, 1j]]),
                ("copy_2 -> copy_1 + copy_2", [[1, 1], [0, 1]]),
                ("copy_1 <-> copy_2", [[0, 1], [1, 0]])):
    g = congr(P, h)
    herm = abs(g[0][1] - g[1][0].conjugate()) < 1e-12
    det = g[0][0]*g[1][1] - g[0][1]*g[1][0]
    print(f"  {name:28s}  Hermitian {herm}, det {det.real:.5f}{det.imag:+.1e}i  -> PASSES")
print("""
  READ.  det h != 0 tests exactly one thing: that the copy list has full rank.
  Every element of GL(m, C) acting on the copies passes it, passes the Hermitian
  assert, and passes the multi-probe test (a linear change of copies is uniform
  across probes, so the Schur ratios stay consistent).  That is correct -- those
  ARE gauge for the mathematics -- but it is exactly the freedom under which
  stage 4's UNK/GAUGE labelling moves.  See gauge_split.py.
""")

print("=" * 76)
print("C.  the q00 guard and the post-orbit shape assert")
print("=" * 76)
q00 = (0, 0)
try:
    assert q00 != (0, 0), "q00 vanishes mod PRIME"
    print("  q00 = (0,0): NOT caught")
except AssertionError as e:
    print(f"  q00 = (0,0) planted: FIRES -- {e}")
    # and what it used to do:
    den = (q00[0]*q00[0] + q00[1]*q00[1]) % PRIME
    print(f"    (unguarded, den = {den}, pow(0, p-2, p) = {pow(den, PRIME-2, PRIME)}, "
          "so every h entry would be (0,0), which IS Hermitian)")

# the post-orbit shape, recomputed from the block table with NO repo input
MULTS = {(4,2):4,(2,2):4,(3,2):3,(5,2):2,(4,3):2,(4,4):2,(4,1):2,(3,1):2,(4,0):2,
         (2,1):2,(3,0):2,(2,0):2,(6,4):1,(6,3):1,(6,2):1,(6,6):1,(5,3):1,(5,4):1,
         (5,1):1,(6,0):1,(5,0):1,(3,3):1,(1,0):1,(0,0):1}
def shape(m):
    surv = {l: v - (1 if l[1] % 2 == 0 else 0) for l, v in m.items()}
    surv = {l: v for l, v in surv.items() if v > 0}
    sv = sorted(surv.values())
    return len(surv), sum(sv), sv.count(3), sv.count(2), sv.count(1), \
           sum(x*(x+1)//2 for x in sv), sum(x*x for x in sv)
print(f"  true multiplicities  -> {shape(MULTS)}   (blocks, mults, #3, #2, #1, sym, herm)")
for lam in [(3,2), (2,0), (4,3)]:
    m2 = dict(MULTS); m2[lam] += 1
    print(f"  m[{lam}] += 1          -> {shape(m2)}   -> shape assert FIRES: "
          f"{shape(m2)[2:5] != (2,5,9)}")
print("""
  READ.  The shape assert fires on any perturbation of the multiplicities, but
  it is derived from `lam[1] % 2 == 0` HARDCODED in the same file, so it tests
  the multiplicity table against the lambda_2-even rule and tests the rule
  against nothing.
""")

print("=" * 76)
print("D.  WHAT ALL FOUR REPAIRS STILL MISS: the pair form never reached stage 4")
print("=" * 76)
print("""  gp / gpmul / gpadd / gpconj -- the pair arithmetic adopted because folding
  i into a single residue makes re and im unrecoverable (r200) -- are used by
  ip3_g, and ip3_g is used ONLY to measure h and to run the multi-probe check.

  Q is built by ip3, the coordinates by solve_weight, and BOTH call to_p, which
  is the collapsing map  a + b*IMOD mod p.  So every quantity stage 4 needs --
  Q, the coefficients c^{lambda,i}, hence B_ij -- is computed in exactly the
  representation the pair form exists to avoid.  In particular

      Im B_ij(W) is not recoverable from the shipped arithmetic,

  and Im B_ij(W) is the measurement that decides whether stage 4's 24 GAUGE
  coordinates are gauge at all:  q(W) = sum_ij Re(G)_ij Re(B)_ij
                                       + sum_ij Im(G)_ij Im(B)_ij,
  so the im coordinates of G drop out precisely when Im B vanishes identically.
""")
