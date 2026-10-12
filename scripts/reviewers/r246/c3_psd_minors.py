"""r246 claim 3 -- the screen's psd criterion, adversarially.

Three questions.
(1) Is "all principal minors >= 0" a CORRECT criterion for positive
    SEMIdefiniteness of a symmetric 3x3?  (Sylvester's leading-minor test is
    for definiteness only.)  Argument: det(tI + A) = t^3 + E1 t^2 + E2 t + E3
    with E_k the sum of the k x k principal minors.  If all E_k >= 0 the
    polynomial is positive for every t > 0, so A has no eigenvalue < 0; the
    converse is monotonicity of principal minors under psd.  Tested here
    exactly against sympy's eigenvalue-based is_positive_semidefinite.
(2) Does the screen's is_psd (copied VERBATIM from run_a2pp_constant_t.py)
    implement that criterion -- all seven principal minors, correct det?
(3) Do leading minors alone let a non-psd matrix through?  Two plants, plus a
    random hunt for disagreements, every one adjudicated by eigenvalues.

Rider checked at the end: the screen scans only +/- basis vectors of the
kernel span.  On a span of dimension >= 2 that scan is INCOMPLETE (witness
below), so the screen's honest-branch soundness rests on the honest nullspace
being empty and the plant's being 1-dimensional -- both verified exactly on
the screen's own points (same seed, same draw order).
"""
from fractions import Fraction as F
import random, sympy as sp

# --- the screen's is_psd, verbatim from scripts/runs/run_a2pp_constant_t.py ---
def is_psd(A):
    m1 = [A[0][0], A[1][1], A[2][2]]
    m2 = [A[0][0]*A[1][1]-A[0][1]**2, A[0][0]*A[2][2]-A[0][2]**2,
          A[1][1]*A[2][2]-A[1][2]**2]
    det = (A[0][0]*(A[1][1]*A[2][2]-A[1][2]**2)
           - A[0][1]*(A[0][1]*A[2][2]-A[1][2]*A[0][2])
           + A[0][2]*(A[0][1]*A[1][2]-A[1][1]*A[0][2]))
    return all(x >= 0 for x in m1+m2) and det >= 0

def leading_only(A):
    """Sylvester's LEADING minors, the wrong test for psd."""
    d1 = A[0][0]
    d2 = A[0][0]*A[1][1]-A[0][1]**2
    d3 = (A[0][0]*(A[1][1]*A[2][2]-A[1][2]**2)
          - A[0][1]*(A[0][1]*A[2][2]-A[1][2]*A[0][2])
          + A[0][2]*(A[0][1]*A[1][2]-A[1][1]*A[0][2]))
    return d1 >= 0 and d2 >= 0 and d3 >= 0

def ref_psd(A):
    """independent exact reference: sympy eigenvalue-based psd."""
    return sp.Matrix(3, 3, lambda i, j: sp.Rational(A[i][j])).is_positive_semidefinite

# (1)+(2): the screen's test agrees with the eigenvalue definition, exactly.
rnd = random.Random(246)
def rnd_sym(low=-4, high=4, den=3):
    e = [F(rnd.randint(low, high), rnd.randint(1, den)) for _ in range(6)]
    return [[e[0], e[1], e[2]], [e[1], e[3], e[4]], [e[2], e[4], e[5]]]
def rnd_gram(r):
    """rank <= r psd: G = sum of r outer products -- exercises the BOUNDARY."""
    A = [[F(0)]*3 for _ in range(3)]
    for _ in range(r):
        v = [F(rnd.randint(-3, 3), rnd.randint(1, 2)) for _ in range(3)]
        for i in range(3):
            for j in range(3):
                A[i][j] += v[i]*v[j]
    return A

cases = [rnd_sym() for _ in range(1500)]
cases += [rnd_gram(r) for r in (0, 1, 1, 2, 2, 3) for _ in range(150)]
# targeted boundary structures
cases += [[[0,0,0],[0,0,0],[0,0,0]], [[0,0,0],[0,-1,0],[0,0,0]],
          [[1,1,1],[1,1,1],[1,1,0]], [[0,0,1],[0,1,0],[1,0,0]],
          [[0,1,0],[1,0,0],[0,0,1]], [[1,2,0],[2,4,0],[0,0,0]],
          [[F(1,3),F(1,3),0],[F(1,3),F(1,3),0],[0,0,0]]]
cases = [[[F(x) for x in row] for row in A] for A in cases]

mismatch = [A for A in cases if is_psd(A) != ref_psd(A)]
assert not mismatch, f"screen's is_psd disagrees with eigenvalue psd on {mismatch[0]}"
print(f"  (1)+(2) screen is_psd == eigenvalue psd on all {len(cases)} exact cases,")
print(f"          including rank-0/1/2 boundary Grams -- the criterion is CORRECT.")

# (3) the plants: non-psd, yet every LEADING minor is >= 0.
plants = [
    ("diag(0,-1,0)", [[0,0,0],[0,-1,0],[0,0,0]]),
    ("[[1,1,1],[1,1,1],[1,1,0]]", [[1,1,1],[1,1,1],[1,1,0]]),
]
for name, P in plants:
    P = [[F(x) for x in row] for row in P]
    assert leading_only(P), f"plant {name} was meant to pass leading minors"
    assert not is_psd(P), f"plant {name} slipped past the screen's full test"
    assert ref_psd(P) is False, f"plant {name} is actually psd?!"
    ev = sp.Matrix(3,3, lambda i,j: sp.Rational(P[i][j])).eigenvals()
    neg = [e for e in ev if e.is_negative]
    print(f"  (3) PLANT {name}: leading minors PASS, screen REJECTS, "
          f"negative eigenvalue {neg[0]} confirms non-psd")

# and the hunt: every random disagreement between the two tests is a matrix
# where leading-only is WRONG and the screen is RIGHT.
disagree = 0
for _ in range(4000):
    A = rnd_gram(rnd.randint(0, 2))          # boundary psd...
    k = rnd.randint(0, 2); A[k][k] -= F(rnd.randint(0, 1))   # ...sometimes dented
    if leading_only(A) != is_psd(A):
        disagree += 1
        assert ref_psd(A) == is_psd(A), f"screen wrong on {A}"
assert disagree > 0, "the hunt found no case separating the two tests"
print(f"  (3) random hunt: {disagree} matrices pass leading-only and fail the full")
print(f"      test; eigenvalues side with the screen in every one.")

# --- rider: the +/- basis-vector scan is incomplete on spans of dim >= 2 ---
A1 = [[F(1),F(0),F(0)],[F(0),F(-1),F(0)],[F(0),F(0),F(0)]]
A2 = [[F(-1),F(0),F(0)],[F(0),F(2),F(0)],[F(0),F(0),F(0)]]
S = [[a+b for a,b in zip(r1,r2)] for r1,r2 in zip(A1,A2)]   # A1+A2 = diag(0,1,0)
assert not any(is_psd(M) for M in
               (A1, A2, [[-x for x in r] for r in A1], [[-x for x in r] for r in A2]))
assert is_psd(S)
print("  rider: span{diag(1,-1,0), diag(-1,2,0)} has NO psd +/- basis vector yet")
print("         contains psd diag(0,1,0) -- the scan is incomplete in dim >= 2 ...")

# ... so verify the screen never enters that regime: nullspace dims on ITS points.
rnd2 = random.Random(4)                       # the screen's seed and draw order
def eval_vectors(dependent):
    pts = []
    for _ in range(8):
        a, b = F(rnd2.randint(-4, 4)), F(rnd2.randint(-4, 4))
        p1 = a + b
        p2 = 2*p1 if dependent else a - b
        p3 = a*b
        pts.append([p1, p2, p3])
    return pts
def null_dim(pts):
    rows = []
    for p in pts:
        rows.append([p[0], p[1], p[2], 0, 0, 0])
        rows.append([0, p[0], 0, p[1], p[2], 0])
        rows.append([0, 0, p[0], 0, p[1], p[2]])
    M = sp.Matrix([[sp.Rational(x) for x in r] for r in rows])
    return len(M.nullspace()), M.nullspace()

h = eval_vectors(False); d = eval_vectors(True)
nh, _ = null_dim(h); nd, ns = null_dim(d)
assert nh == 0, f"honest nullspace has dim {nh}: the +/- scan gap would be LIVE"
assert nd == 1, f"plant nullspace has dim {nd}, expected 1"
v = ns[0]
D = sp.Matrix([[v[0],v[1],v[2]],[v[1],v[3],v[4]],[v[2],v[4],v[5]]])
r1 = sp.Matrix([2,-1,0])
assert D.rank() == 1 and (D * sp.Matrix([1,2,0])).norm() == 0
print(f"  rider: on the screen's own points the honest nullspace is 0-dimensional")
print(f"         and the plant's is 1-dimensional (rank-1, kernel contains (1,2,0)),")
print(f"         so the incomplete scan is COMPLETE in both regimes it actually meets.")
print("\n  CLAIM 3: CONFIRMED, with the rider above.")
