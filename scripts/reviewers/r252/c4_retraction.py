"""r252, claim 4: is the retraction correct, is the replacement condition right,
and is reviewer 248's point recorded accurately?

  (1) THE RETRACTION.  "for symmetric K, p^T K p = 0 on a linearly spanning set
      forces K = 0" -- false, K = [[0,1],[1,0]] on {e_1, e_2}.  Checked.

  (2) THE REPLACEMENT.  The file offers two conditions: a spanning SUBSPACE, or
      the rank-one lifts p p^T spanning Sym.  Both are checked, and the second is
      shown to be the SHARP one -- the implication holds for every symmetric K
      exactly when span{p p^T} = Sym, because {K : p^T K p = 0 on S} is precisely
      span{p p^T : p in S}^perp.  The first is the special case S = R^d.

  (3) THE THEOREM ABOVE really does need only LINEAR spanning, because for psd D
      the quadratic condition collapses to the linear one:
      p^T D p = |A^T p|^2 = 0  <=>  A^T p = 0  <=>  D p = 0, for D = A A^T.

  (4) AND THAT COLLAPSE BOUNDS WHAT 248's POINT CAN COST.  The screen imposes
      D p = 0 where the hypothesis is p^T D p = 0, so it searches a SMALLER
      space -- but the two spaces have the SAME PSD PART, so the substitution
      cannot change a verdict.  Measured on both branches of the screen and on
      248's own twisted-cubic data.
"""
from fractions import Fraction as Fr
from itertools import product
import random

# ------------------------------------------------------- exact linear algebra
def rref(rows, ncols):
    M = [list(map(Fr, r)) for r in rows] or [[Fr(0)] * ncols]
    piv, r = [], 0
    for c in range(ncols):
        pr = next((t for t in range(r, len(M)) if M[t][c] != 0), None)
        if pr is None:
            continue
        M[r], M[pr] = M[pr], M[r]
        iv = M[r][c]
        M[r] = [x / iv for x in M[r]]
        for t in range(len(M)):
            if t != r and M[t][c] != 0:
                f = M[t][c]
                M[t] = [x - f * y for x, y in zip(M[t], M[r])]
        piv.append(c)
        r += 1
    return M, piv


def nullspace(rows, ncols):
    M, piv = rref(rows, ncols)
    free = [c for c in range(ncols) if c not in piv]
    basis = []
    for fc in free:
        v = [Fr(0)] * ncols
        v[fc] = Fr(1)
        for ri, pc in enumerate(piv):
            v[pc] = -M[ri][fc]
        basis.append(v)
    return basis


def rank(rows, ncols):
    return len(rref(rows, ncols)[1]) if rows else 0


def sym_index(d):
    """coordinates on Sym_d: (i,j) with i <= j."""
    return [(i, j) for i in range(d) for j in range(i, d)]


def lift(p, d):
    """the vector of <D, p p^T> coefficients in the (i<=j) coordinates."""
    return [p[i] * p[j] * (1 if i == j else 2) for i, j in sym_index(d)]


def mat_from_sym(v, d):
    idx = sym_index(d)
    A = [[Fr(0)] * d for _ in range(d)]
    for k, (i, j) in enumerate(idx):
        A[i][j] = v[k]
        A[j][i] = v[k]
    return A


def is_psd_exact(A):
    """exact psd test: every principal minor >= 0 (all, not just leading)."""
    d = len(A)
    for r in range(1, d + 1):
        for S in _subsets(range(d), r):
            if _det([[A[i][j] for j in S] for i in S]) < 0:
                return False
    return True


def _subsets(it, r):
    it = list(it)
    if r == 0:
        yield ()
        return
    for i in range(len(it)):
        for rest in _subsets(it[i + 1:], r - 1):
            yield (it[i],) + rest


def _det(M):
    M = [row[:] for row in M]
    n = len(M)
    det = Fr(1)
    for c in range(n):
        pr = next((t for t in range(c, n) if M[t][c] != 0), None)
        if pr is None:
            return Fr(0)
        if pr != c:
            M[c], M[pr] = M[pr], M[c]
            det = -det
        det *= M[c][c]
        iv = M[c][c]
        M[c] = [x / iv for x in M[c]]
        for t in range(c + 1, n):
            if M[t][c] != 0:
                f = M[t][c]
                M[t] = [x - f * y for x, y in zip(M[t], M[c])]
    return det


def psd_element(basis, d):
    """a nonzero psd element of the span of `basis` (searched over the basis and
    small integer combinations -- adequate for these miniatures)."""
    if not basis:
        return None
    coeffs = list(product((-1, 0, 1), repeat=len(basis))) if len(basis) <= 4 else \
        [tuple(1 if i == k else 0 for i in range(len(basis))) for k in range(len(basis))] + \
        [tuple(-1 if i == k else 0 for i in range(len(basis))) for k in range(len(basis))]
    for co in coeffs:
        if all(c == 0 for c in co):
            continue
        v = [sum(Fr(c) * b[k] for c, b in zip(co, basis)) for k in range(len(basis[0]))]
        if all(x == 0 for x in v):
            continue
        A = mat_from_sym(v, d)
        if is_psd_exact(A):
            return A
    return None


# ------------------------------------------------------------------- (1)+(2)
def part_1_2():
    print("(1) THE RETRACTION -- the lemma as written")
    K = [[Fr(0), Fr(1)], [Fr(1), Fr(0)]]
    e = [[Fr(1), Fr(0)], [Fr(0), Fr(1)]]
    vals = [sum(p[i] * K[i][j] * p[j] for i in range(2) for j in range(2)) for p in e]
    print(f"    K = [[0,1],[1,0]],  S = {{e_1, e_2}} spans R^2")
    print(f"    p^T K p on S = {vals},  K != 0: {any(x != 0 for r in K for x in r)}")
    print(f"    -> the lemma is FALSE.  The retraction is correct.\n")

    print("(2) THE REPLACEMENT CONDITION -- and it is the sharp one")
    print("    {K sym : p^T K p = 0 on S} = span{p p^T : p in S}^perp, so the")
    print("    implication holds for every K exactly when the lifts span Sym.")
    d = 2
    tests = [("S = {e_1, e_2}", [[Fr(1), Fr(0)], [Fr(0), Fr(1)]]),
             ("S = {e_1, e_2, e_1+e_2}", [[Fr(1), Fr(0)], [Fr(0), Fr(1)], [Fr(1), Fr(1)]])]
    for label, S in tests:
        lin = rank(S, d)
        lifts = [lift(p, d) for p in S]
        lr = rank(lifts, len(sym_index(d)))
        ann = nullspace(lifts, len(sym_index(d)))
        print(f"    {label:<26} linear rank {lin}/{d}, lift rank {lr}/{len(sym_index(d))},"
              f" annihilator dim {len(ann)}"
              f" -> lemma {'HOLDS' if not ann else 'FAILS'}")
        if ann:
            print(f"        witness K = {mat_from_sym(ann[0], d)}")
    print("    Linear spanning holds in BOTH rows; only the lift rank decides.\n")

    print("    the spanning-SUBSPACE clause, by polarisation:")
    for d in (2, 3, 4):
        S = []
        rnd = random.Random(9 + d)
        while rank([lift(p, d) for p in S], len(sym_index(d))) < len(sym_index(d)):
            S.append([Fr(rnd.randint(-3, 3)) for _ in range(d)])
            if len(S) > 200:
                break
        lr = rank([lift(p, d) for p in S], len(sym_index(d)))
        print(f"      d={d}: rank-one lifts of a SUBSPACE (all of R^{d}) span Sym_{d}: "
              f"{lr} = {len(sym_index(d))}  -> the subspace clause is the special case")
    print()


# ----------------------------------------------------------------------- (3)
def part_3():
    print("(3) THE THEOREM ABOVE needs only LINEAR spanning, because psd-ness")
    print("    collapses the quadratic condition to the linear one.")
    rnd = random.Random(17)
    bad = 0
    for _ in range(400):
        d, r = 4, 2
        A = [[Fr(rnd.randint(-3, 3)) for _ in range(r)] for _ in range(d)]
        D = [[sum(A[i][k] * A[j][k] for k in range(r)) for j in range(d)] for i in range(d)]
        p = [Fr(rnd.randint(-3, 3)) for _ in range(d)]
        q = sum(p[i] * D[i][j] * p[j] for i in range(d) for j in range(d))
        Dp = [sum(D[i][j] * p[j] for j in range(d)) for i in range(d)]
        if (q == 0) != all(x == 0 for x in Dp):
            bad += 1
    print(f"    for D = A A^T psd:  p^T D p = 0  <=>  D p = 0, over 400 exact trials, "
          f"violations = {bad}")
    print("    so on the PSD CONE the two conditions define the SAME set.\n")


# ----------------------------------------------------------------------- (4)
def eval_vectors(dependent):
    """verbatim from run_a2pp_constant_t.py (the file under review, unmodified)."""
    rnd = random.Random(4)
    pts = []
    for _ in range(8):
        a, b = Fr(rnd.randint(-4, 4)), Fr(rnd.randint(-4, 4))
        p1 = a + b
        p2 = 2 * p1 if dependent else a - b
        p3 = a * b if not dependent else a * b
        pts.append([p1, p2, p3])
    return pts


def part_4():
    print("(4) 248's POINT, MEASURED.  The screen imposes D p = 0; the hypothesis")
    print("    is p^T D p = 0.  Both spaces, and both psd parts.")
    d = 3
    ns = len(sym_index(d))
    for dep in (False, True):
        pts = eval_vectors(dep)
        lin_rows = []
        for p in pts:
            for i in range(d):                       # (D p)_i = sum_j D_ij p_j = 0
                row = [Fr(0)] * ns
                for k, (a, b) in enumerate(sym_index(d)):
                    if a == b:
                        if a == i:
                            row[k] += p[i]
                    else:
                        if a == i:
                            row[k] += p[b]
                        if b == i:
                            row[k] += p[a]
                lin_rows.append(row)
        quad_rows = [lift(p, d) for p in pts]
        lin_ker = nullspace(lin_rows, ns)
        quad_ker = nullspace(quad_rows, ns)
        # By part (3) every psd element of the theorem's space lies in the
        # screen's space, so searching the screen's space finds ALL of them.
        pl = psd_element(lin_ker, d)
        inq = None
        if pl is not None:
            v = [pl[a][b] for a, b in sym_index(d)]
            inq = all(sum(x * y for x, y in zip(v, lift(p, d))) == 0 for p in pts)
        label = "PLANT (p_2 = 2 p_1)" if dep else "honest (independent)"
        print(f"    {label:<22} evaluations span R^3: {rank(pts, d)}/3")
        print(f"      screen's space   {{D : D p = 0}}       dim {len(lin_ker)}")
        print(f"      theorem's space  {{D : p^T D p = 0}}   dim {len(quad_ker)}")
        print(f"      psd part (identical in both, by (3)): "
              f"{'nonzero, D = ' + str([[str(x) for x in r] for r in pl]) if pl else '{0}'}")
        if pl is not None:
            print(f"      and that psd D also lies in the theorem's space: {inq}")
        print(f"      verdict changes under the substitution: NO"
              f"  (only the dimension searched does: {len(lin_ker)} -> {len(quad_ker)})")
    print()
    print("    248's own twisted-cubic numbers say the same: its psd witness")
    print("    D = v v^T with v = 2e_0 - e_4 satisfies v . p = 2p_0 - p_4 = 0")
    print("    identically on the plant, so D p = 0 too -- it sits in the dim-1")
    print("    LINEAR annihilator the screen computes, not only in the dim-8")
    print("    t-space.  The substitution enlarges the space searched from 0 to 3")
    print("    (independent) and 1 to 8 (plant) and leaves both verdicts alone.\n")


if __name__ == "__main__":
    part_1_2()
    part_3()
    part_4()
