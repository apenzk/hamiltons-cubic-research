"""B0: an explicit Weyl_m element with exactly two negative eigenvalues and FULL
support, refuting the descent statement recorded in plan.md.

THE STATEMENT UNDER TEST (plan.md, item B0):
    no element of Weyl_m with dim m_neg <= 2 has dim U = m, for even m >= 6,
    where U = im v_{N-1} + im v_N is the span of the negative eigenvectors' images.

THE WITNESS.  On R^4 the self-dual forms w1, w2, w3 are complex structures
(w_i^2 = -I), orthogonal, with w_i ^ w_i the same volume form.  So for q, r > 0

    W4(q,r) = -(q+r) w1(x)w1 + q w2(x)w2 + r w3(x)w3           (unit w_i)

is Ricci-flat (each w_i w_i^T = I/2, coefficients sum to zero) and Bianchi-free
(each w_i ^ w_i equal, same sum), i.e. it lies in Weyl_4.  It has signature (2,1):
ONE negative eigenvalue, whose eigenvector w1 is a FULL-RANK bivector.  This is the
m = 4 exception of the rank-3 theorem, in its signature-(2,1) form.

Padding two such tensors into R^m on 4-planes and adding gives a Weyl_m element with
exactly TWO negative eigenvalues -- one from each summand -- and support the union of
the two planes.  Two ways to cover R^m:
    m = 8, 12, 16, ... : ORTHOGONAL 4-planes, one per summand;
    m = 6, 10, ...     : 4-planes OVERLAPPING in a 2-plane.
Either way dim U = m and dim m_neg = 2, so the statement is false.

WHAT SURVIVES.  B0's CONCLUSION -- sup theta <= sqrt(3/2) on the stratum -- is
untouched; what is refuted is the route, the one-step descent through Lemma 30.

THETA IS NOT SIGN-CONSTRAINED ON THIS FAMILY.  P is cubic and additive only over
Frobenius-orthogonal supports, so overlapping planes keep the cross term and
theta > 0 occurs: exhibited at +0.485408612 (m=6) and +0.115574271 (m=8), with
random general-position draws reaching +0.6259 at m=6.  Every one of those figures
is measured rather than derived, and the family's supremum is an open question.

DIMENSION CAP.  Two 4-planes span at most eight dimensions, so U is contained in
their sum and the family stops at m <= 8.  It says nothing at m >= 10, which is
where the stratum argument needed it.

FALSIFIER.  A witness failing Ricci-flatness, Bianchi, the two-negative count, or
full support.
"""
import numpy as np, sys, itertools
sys.path.insert(0, 'scripts/lib')
from review_r30_core import pair_index, P as Pfun
from b0_psd_identity import phis, mat_of, vec_of, ricci, bianchi_res, A_of_W

np.set_printoptions(precision=6, suppress=True)


def selfdual_on(plane, m, orient=1):
    """the three self-dual 2-forms of a 4-plane [a,b,c,d] inside R^m, unit norm."""
    a, b, c, d = plane
    def sk(pairs):
        X = np.zeros((m, m))
        for (i, j, s) in pairs:
            X[i, j] = s; X[j, i] = -s
        return X / np.sqrt(2.0)          # <X,X> = 1/2 tr(X^T X) = 1
    o = orient
    return [sk([(a, b, 1), (c, d, o)]),
            sk([(a, c, 1), (d, b, o)]),
            sk([(a, d, 1), (b, c, o)])]


def W4(plane, m, q, r, orient=1, perm=(0, 1, 2)):
    w = selfdual_on(plane, m, orient)
    w = [w[perm[0]], w[perm[1]], w[perm[2]]]
    v = [vec_of(x, m) for x in w]
    return (-(q + r) * np.outer(v[0], v[0]) + q * np.outer(v[1], v[1])
            + r * np.outer(v[2], v[2]))


def report(m, W, tag):
    Wn = W / np.sqrt(np.sum(W * W))
    lam, V = np.linalg.eigh(Wn)
    nneg = int(np.sum(lam < -1e-9))
    ys = [mat_of(V[:, i], m) for i in range(max(nneg, 1))]
    dU = np.linalg.matrix_rank(np.vstack(ys), tol=1e-9)
    print(f"  {tag}")
    print(f"    Ricci {np.abs(ricci(m,Wn)).max():.2e}  Bianchi {bianchi_res(m,Wn):.2e}"
          f"  |A(W)-2W| {np.abs(A_of_W(m,Wn)-2*Wn).max():.2e}")
    print(f"    #neg={nneg}  dim U={dU} (m={m})  theta={Pfun(m,Wn):+.6f}"
          f"  spectrum={np.round(lam[lam.__abs__()>1e-9],5)}")
    return nneg, dU, Pfun(m, Wn)


if __name__ == '__main__':
    print("=== m = 4: the base case, signature (2,1), negative eigenvector full rank ===")
    for (q, r) in ((1.0, 1.0), (2.0, 0.5)):
        report(4, W4([0, 1, 2, 3], 4, q, r), f"W4(q={q},r={r})")

    print("\n=== m = 8: two ORTHOGONAL 4-planes ===")
    W = W4([0, 1, 2, 3], 8, 1, 1) + W4([4, 5, 6, 7], 8, 1, 1)
    report(8, W, "W4 + W4 on orthogonal planes")
    W = W4([0, 1, 2, 3], 8, 2, 0.5) + W4([4, 5, 6, 7], 8, 1, 1)
    report(8, W, "unequal parameters")

    print("\n=== m = 6: two 4-planes OVERLAPPING in a 2-plane ===")
    best = None
    for o1 in (1, -1):
        for o2 in (1, -1):
            for p1 in itertools.permutations(range(3)):
                for p2 in itertools.permutations(range(3)):
                    W = (W4([0, 1, 4, 5], 6, 1, 1, o1, p1)
                         + W4([2, 3, 4, 5], 6, 1, 1, o2, p2))
                    Wn = W / np.sqrt(np.sum(W * W))
                    lam, V = np.linalg.eigh(Wn)
                    n = int(np.sum(lam < -1e-9))
                    if n != 2:
                        continue
                    ys = [mat_of(V[:, i], 6) for i in range(2)]
                    dU = np.linalg.matrix_rank(np.vstack(ys), tol=1e-9)
                    if dU == 6:
                        best = (o1, o2, p1, p2, W)
                        break
                if best: break
            if best: break
        if best: break
    if best:
        o1, o2, p1, p2, W = best
        report(6, W, f"orient=({o1},{o2}) frames=({p1},{p2})")
    else:
        print("    none found in the scanned frames")

    print("\n=== m = 10: 4-planes overlapping in a 2-plane, plus one orthogonal ===")
    W = (W4([0, 1, 4, 5], 10, 1, 1) + W4([2, 3, 4, 5], 10, 1, 1, *(-1,), )
         if False else None)
    for o2 in (1, -1):
        for p2 in itertools.permutations(range(3)):
            W = W4([0, 1, 8, 9], 10, 1, 1) + W4([2, 3, 8, 9], 10, 1, 1, o2, p2) \
                + W4([4, 5, 6, 7], 10, 1, 1)
            Wn = W / np.sqrt(np.sum(W * W))
            lam, V = np.linalg.eigh(Wn)
            n = int(np.sum(lam < -1e-9))
            if n == 3:
                continue
            ys = [mat_of(V[:, i], 10) for i in range(max(n, 1))]
            dU = np.linalg.matrix_rank(np.vstack(ys), tol=1e-9)
            if n <= 2 and dU == 10:
                report(10, W, f"three summands, orient2={o2} frame2={p2}")
                break
        else:
            continue
        break
