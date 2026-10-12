"""Can the MARGINALS of ad(v) supply the deficiency bound?  A decisive no, with a witness.

THE DERIVATION THIS TESTS.  Lemma 70 reduces the conjecture to bounding D(v) below.  Two
exact rewritings say what D is made of.  With m_a = ||[v, phi_a]||^2 the row masses of
ad(v) in W's eigenbasis:

    ||ad(v) W||^2_HS = sum_a lambda_a^2 m_a        -- the lambda^2-weighted MEAN of m,
                                                      since sum_a lambda_a^2 = ||W||^2 = 1
    g_v = 2 ||ad(v)W||^2 - 4 <v, W# v>

so the whole of D is a functional of the joint law of (lambda_a lambda_b, c_vab^2).  The
only constraints the record has on that law are MARGINAL: the total mass
sum_ab c_vab^2 = 2(n-2), and the proved row cap m_a <= 2, independent of n.

THE QUESTION.  Is that enough?  Minimise (1/2) sum lambda_a lambda_b C_ab over symmetric
C >= 0 with row sums m_a <= 2 and total 2(n-2), at the TRUE spectrum of a given critical
point.  If the LP optimum saturates Lemma 70 where the actual point is strictly slack,
then no bound written in the marginals can produce that slack, and the deficiency bound
must come from the Jacobi identity instead -- which is post 10's lesson, localised.

The maximal torus is the witness to watch: it is a genuine critical point (residual
1e-16) with slack 1.29 at n=6 rising to 3.43 at n=12, and roughly half its bracket mass
lands off E_min x E_max.  Nothing in its marginals says so.
"""
import sys
import numpy as np
from scipy.optimize import linprog
from scipy.sparse import coo_matrix

sys.path.insert(0, 'scripts/reviewers/r319')
import build


def lp_min(ev, n):
    """Exact LP minimum of (1/2) sum_ab lambda_a lambda_b C_ab over symmetric C >= 0 with
    ZERO DIAGONAL -- c_vaa = <[v,phi_a],phi_a> = 0 by antisymmetry of the bracket -- row
    sums m_a <= 2, and total sum_ab C_ab = 2(n-2).  Variables y_ab = C_ab for a < b, so
    the total reads sum y = n-2 and each row reads sum_{b != a} y_ab <= 2.

    A GREEDY FILL BY INCREASING lambda_a lambda_b IS NOT THE OPTIMUM and must not be used:
    it returned 0.408248 against a true theta of 1.224745 at padded W_CP2, i.e. a claimed
    upper bound BELOW the quantity it bounds.  Degree-capped minimum-cost matching does
    not submit to greedy; this solves the LP.
    """
    N = len(ev)
    idx = [(a, b) for a in range(N) for b in range(a + 1, N)]
    cost = np.array([ev[a] * ev[b] for a, b in idx])
    r, c, d = [], [], []
    for k, (a, b) in enumerate(idx):
        r += [a, b]; c += [k, k]; d += [1.0, 1.0]
    A_ub = coo_matrix((d, (r, c)), shape=(N, len(idx)))
    res = linprog(cost, A_ub=A_ub, b_ub=np.full(N, 2.0),
                  A_eq=np.ones((1, len(idx))), b_eq=[n - 2.0],
                  bounds=(0, None), method='highs')
    assert res.status == 0, res.message
    return res.fun


def row(name, n, W):
    A = build.Arena(n)
    W = build.unit(W)
    th = A.P3(W)
    res = float(np.linalg.norm(A.Q(W) - th * W))
    ev, U = np.linalg.eigh(W)
    mu, Lam = float(ev[0]), float(ev[-1])
    v = U[:, 0]
    ad = A.ad(v)
    m = np.sum(ad ** 2, axis=0)
    true_X = float(v @ (A.Q(W) - W @ W) @ v)                 # <v, W# v>
    termwise = (n - 2) * mu * Lam                            # Lemma 70's bound
    lp = lp_min(ev, n)                                       # marginals + row cap
    assert mu + lp / mu >= th - 1e-9, 'LP is not a valid relaxation at ' + name
    th_true, th_term, th_lp = th, mu + termwise / mu, mu + lp / mu
    print(f"  {name:22s} n={n:3d} res={res:.0e}  max row m_a={m.max():.4f}  "
          f"theta={th_true:10.6f} | Lemma70 bound {th_term:10.6f} "
          f"(slack {th_term-th_true:9.6f}) | marginal LP {th_lp:10.6f} "
          f"(slack {th_lp-th_true:9.6f})", flush=True)
    return th_true, th_term, th_lp


if __name__ == '__main__':
    print("Does the marginal LP -- total mass 2(n-2) plus the proved row cap m_a <= 2 --\n"
          "explain any of Lemma 70's slack?  Both columns are UPPER bounds on theta.\n"
          "A marginal LP no tighter than the termwise bound proves the marginals are inert.\n", flush=True)
    print("[saturating points: Lemma 70 is exact, so nothing is owed]", flush=True)
    for n in (6, 8, 10, 12):
        row(f"so({n//2})+so({n//2})", n, build.subalg_casimir(n, build.so_pq_basis(n, n // 2)))
    print("\n[slack points: this is where a deficiency bound has to do work]", flush=True)
    for n in (6, 8, 10, 12):
        row(f"torus so(2)^{n//2}", n, build.subalg_casimir(n, build.torus_basis(n)))
    row("ad(su(3)) so(8)", 8, build.subalg_casimir(8, build.adjoint_basis(8, build.su3_adjoint())))
    for n in (6, 8, 10):
        row("CP^2 padded", n, build.cp2(n))
    print("\nDONE", flush=True)
