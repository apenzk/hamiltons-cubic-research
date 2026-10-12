"""r248, claim 5: the FAILED-repair record in run_a2pp_constant_t.py is wrong.

WHAT THE RECORD SAYS.  Under "WHY THE TWO CANNOT BE RECONCILED IN THIS
MINIATURE":

  "The t-space is the kernel of the CONSTRAINT map ..., whose elements are
   nonzero matrices representing the zero sextic -- possible only because the
   evaluations p(W) range over the image of a cubic map, a proper subvariety,
   rather than over a linearly spanning set.  ... for a symmetric K, p^T K p = 0
   on a linearly spanning set forces K = 0 outright.  So in a miniature where the
   samples span, the t-space is necessarily zero and the interesting case cannot
   arise at all."

TWO THINGS ARE WRONG.

  (1) It CONTRADICTS the theorem in the same file.  The theorem's step is "the
      evaluations {p(W)} span the full coordinate space exactly when the
      covariants are linearly independent as functions".  Independence is the
      hypothesis; spanning is what it gives.  The repair note explains the
      nonzero t-space by the image FAILING to span linearly -- i.e. by the
      hypothesis failing.  Both cannot hold.

  (2) "p^T K p = 0 on a linearly spanning set forces K = 0" is FALSE for a SET.
      It is true on a spanning SUBSPACE (polarise: q(u+v)-q(u)-q(v) = 2u^T K v).
      For a set, what is needed is that the rank-one lifts {p p^T} span Sym --
      and that is exactly what the image of a cubic map fails to do while still
      spanning R^k linearly.  The failure is QUADRATIC, not linear.

SO THE INTERESTING CASE DOES ARISE IN A MINIATURE, and this file builds it, in
four dimensions, from the image of a genuine cubic map -- the thing the record
lists as OWED and not built.

  p(w) = (w1^3, w1^2 w2, w1 w2^2, w2^3),  the twisted cubic in R^4.

  * the evaluations SPAN R^4 (the covariants are independent as functions);
  * the t-space {D symmetric : p(w)^T D p(w) = 0 for all w} is 3-DIMENSIONAL,
    nonzero, exactly the record's "matrices representing the zero sextic";
  * its psd part is {0}, by the theorem's own mechanism -- so the screen has
    something to test after all.

  And the PLANT (a dependent fifth covariant, p_4 = 2 p_0) puts a nonzero psd
  element in the t-space, which is the failure mode the hypothesis excludes.

Everything exact over Q.
"""
from fractions import Fraction as F
from itertools import combinations_with_replacement

def nullspace(rows, ncols):
    M = [r[:] for r in rows]; piv = []; r = 0
    for c in range(ncols):
        pr = next((t for t in range(r, len(M)) if M[t][c] != 0), None)
        if pr is None: continue
        M[r], M[pr] = M[pr], M[r]
        iv = M[r][c]; M[r] = [x/iv for x in M[r]]
        for t in range(len(M)):
            if t != r and M[t][c] != 0:
                f0 = M[t][c]; M[t] = [x - f0*y for x, y in zip(M[t], M[r])]
        piv.append(c); r += 1
    basis = []
    for fc in [c for c in range(ncols) if c not in piv]:
        v = [F(0)]*ncols; v[fc] = F(1)
        for ri, pc in enumerate(piv): v[pc] = -M[ri][fc]
        basis.append(v)
    return basis

def rank(rows, ncols):
    return ncols - len(nullspace(rows, ncols))

def sym_index(k):
    return list(combinations_with_replacement(range(k), 2))

def quad_row(p, k, IDX):
    """coefficients of p^T D p in the unknowns D_ij (i<=j), off-diagonal x2."""
    return [(p[i]*p[j] if i == j else 2*p[i]*p[j]) for (i, j) in IDX]

def lin_rows(p, k, IDX):
    """coefficients of (D p)_a = 0, one row per a."""
    out = []
    for a in range(k):
        row = [F(0)]*len(IDX)
        for t, (i, j) in enumerate(IDX):
            if i == a: row[t] += p[j]
            if j == a and i != j: row[t] += p[i]
        out.append(row)
    return out

def cubic_image(k, plant=False):
    pts = []
    for w1 in range(-4, 5):
        for w2 in range(-4, 5):
            if (w1, w2) == (0, 0): continue
            a, b = F(w1), F(w2)
            p = [a**3, a*a*b, a*b*b, b**3]
            if plant: p = p + [2*p[0]]
            pts.append(p)
    return pts

def psd_part_is_zero(basis, k, IDX):
    """exact: iterate 'a psd matrix with D_ii = 0 has row i zero'.  If the
    closure reaches {0}, the psd part of the space is {0} -- a proof, since
    every step is a valid consequence of psd-ness."""
    extra, done, steps = [], set(), []
    pos = {ij: t for t, ij in enumerate(IDX)}
    cur = basis
    while cur:
        killed = None
        for i in range(k):
            if i in done: continue
            if all(v[pos[(i, i)]] == 0 for v in cur):
                killed = i; break
        if killed is None:
            return False, steps
        done.add(killed); steps.append(killed)
        for j in range(k):
            row = [F(0)]*len(IDX); row[pos[tuple(sorted((killed, j)))]] = F(1)
            extra.append(row)
        cur = intersect(basis, extra, len(IDX))
    return True, steps

def intersect(basis, rows, ncols):
    """elements of span(basis) satisfying rows.x = 0, returned in coordinates."""
    if not basis: return []
    m = len(basis)
    sys = [[sum(r[t]*basis[s][t] for t in range(ncols)) for s in range(m)]
           for r in rows]
    co = nullspace(sys, m)
    return [[sum(c[s]*basis[s][t] for s in range(m)) for t in range(ncols)]
            for c in co]

def report(k, plant):
    IDX = sym_index(k)
    pts = cubic_image(k, plant)
    tag = "PLANT (p_4 = 2 p_0)" if plant else "twisted cubic, independent"
    print(f"\n--- {tag}:  k = {k}, {len(pts)} evaluation points ---")
    print(f"  evaluations span R^{k}?  rank = {rank(pts, k)}"
          f"   ({'YES -- independent as functions' if rank(pts,k)==k else 'NO'})")
    quad = [quad_row(p, k, IDX) for p in pts]
    tsp = nullspace(quad, len(IDX))
    print(f"  t-space  {{D sym : p^T D p = 0 on the image}}:  dim {len(tsp)}"
          f"  of dim Sym = {len(IDX)}")
    lin = [r for p in pts for r in lin_rows(p, k, IDX)]
    ann = nullspace(lin, len(IDX))
    print(f"  linear annihilator {{D : D p = 0 on the image}}: dim {len(ann)}"
          f"   <- this is what the screen computes")
    ok, steps = psd_part_is_zero(tsp, k, IDX)
    if ok:
        print(f"  psd part of the t-space = {{0}}, proved by the zero-diagonal"
              f" closure on rows {steps}")
    else:
        # exhibit one
        cand = [F(0)]*len(IDX)
        print(f"  psd part of the t-space is NONTRIVIAL")
    return tsp, IDX

def main():
    print("THE RECORD'S CLAIM: 'in a miniature where the samples span, the")
    print("t-space is necessarily zero and the interesting case cannot arise.'")
    tsp, IDX = report(4, False)

    print("\n  the record's stated reason -- p^T K p = 0 on a spanning SET forces")
    print("  K = 0 -- refuted by the smallest possible witness:")
    K = [[F(0), F(1)], [F(1), F(0)]]
    e1, e2 = [F(1), F(0)], [F(0), F(1)]
    for v, nm in ((e1, 'e1'), (e2, 'e2')):
        q = sum(v[i]*K[i][j]*v[j] for i in range(2) for j in range(2))
        print(f"    {nm}^T K {nm} = {q}")
    print("    {e1,e2} spans R^2, K = [[0,1],[1,0]] != 0.  The true statement")
    print("    needs the SUBSPACE (polarisation) or the rank-one lifts p p^T to")
    print("    span Sym -- which the image of a cubic map does NOT.")

    tsp2, IDX2 = report(5, True)
    # exhibit the psd annihilator explicitly for the plant
    k = 5; pos = {ij: t for t, ij in enumerate(IDX2)}
    v = [F(2), F(0), F(0), F(0), F(-1)]
    D = [[v[i]*v[j] for j in range(k)] for i in range(k)]
    coords = [D[i][j] for (i, j) in IDX2]
    pts = cubic_image(5, True)
    bad = [p for p in pts
           if sum(p[i]*D[i][j]*p[j] for i in range(k) for j in range(k)) != 0]
    print(f"    explicit psd element D = vv^T, v = 2e_0 - e_4:  rank 1, hence psd,")
    print(f"    nonzero, and p^T D p vanishes at all {len(pts)} points "
          f"({len(bad)} violations)")
    print(f"    -> it IS in the t-space, so the recession cone is nontrivial.")
    print(f"    This is the failure mode independence excludes.")

    print("\nCONCLUSION.  A four-dimensional miniature over the image of a genuine")
    print("cubic map has a NONZERO t-space whose psd part is {0}: the theorem's")
    print("own step, tested.  The record's 'cannot arise at all' is false, and the")
    print("owed screen is twenty lines, not a blocked item.  What the screen in")
    print("run_a2pp_constant_t.py imposes -- D p = 0 -- is the theorem's")
    print("CONCLUSION; the hypothesis to impose is p^T D p = 0.")

if __name__ == '__main__':
    main()
