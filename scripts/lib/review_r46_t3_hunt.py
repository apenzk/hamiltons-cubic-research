"""Reviewer 46, T3: is S = 0 at W_CP2 'near-automatic', and does 'large dim m'
rescue the implication  S = 0  =>  Z_2-graded?

Three separate attacks:
  (A) the exact count of scalar conditions in S = 0, from total antisymmetry;
  (B) coordinate-diagonal critical points <-> graphs, where S = 0 is exactly
      'the negative-support graph is triangle free' and graded is exactly
      'that graph is a cut';
  (C) explicit ungraded S = 0 critical points with LARGE dim m, from
      triangle-free strongly regular graphs.
"""
import itertools
import numpy as np
from review_r46_core import (pairs_of, pair_index, structure_constants, Q_of,
                             P_of, ricci, bianchi_vec, slack_structural,
                             slack_hhm, slack_weighted, negative_part)


# ------------------------------------------------------ (A) counting conditions

def count_conditions(N, d, c=None, Pm=None):
    """Number of independent scalar equations in Pi_m [m,m] = 0.
    Total antisymmetry of c makes c_{abg} vanish unless a,b,g are distinct,
    so the equations are indexed by 3-subsets of an orthonormal basis of m."""
    return d * (d - 1) * (d - 2) // 6


def demo_A():
    print("(A)  S = 0 is  c_{abg} = 0  for all triples inside m.")
    print("     c is TOTALLY antisymmetric, so the conditions are indexed by")
    print("     3-element subsets of m: exactly C(dim m, 3) scalar equations.")
    print()
    print("      dim m :  0   1   2   3   4   5   6  16  36  40")
    print("     C(d,3) : " + "  ".join(
        f"{d*(d-1)*(d-2)//6:3d}" for d in (0, 1, 2, 3, 4, 5, 6, 16, 36, 40)))
    print()
    print("     dim m <= 2  =>  ZERO conditions: S vanishes identically, for")
    print("     every operator whose negative eigenspace has dimension <= 2,")
    print("     critical or not.  T2's 'single scalar condition' is off by one.")
    print()
    # empirical: random operators with a 2-dimensional negative eigenspace
    rng = np.random.default_rng(11)
    for n in (6, 8, 10):
        c = structure_constants(n)
        N = n * (n - 1) // 2
        worst = 0.0
        for _ in range(200):
            M = rng.normal(size=(N, N)); M = M + M.T
            ev, V = np.linalg.eigh(M)
            # force exactly two negative eigenvalues
            ev = np.abs(ev); ev[0] = -ev[0]; ev[1] = -ev[1]
            W = (V * ev) @ V.T
            worst = max(worst, slack_structural(c, W))
        print(f"     n={n}: 200 random SYMMETRIC (non-critical, non-Weyl) operators with"
              f" dim m = 2 -> max S_mmm = {worst:.3e}")
    print()


# ---------------------------------------------- (B) diagonal points are graphs

def diag_operator(n, lam_dict):
    idx = pair_index(n)
    lam = np.zeros(len(idx))
    for p, v in lam_dict.items():
        lam[idx[p]] = v
    return np.diag(lam)


def diag_critical_residual(n, lam):
    """lam is the vertex matrix Lambda (n x n, hollow, symmetric).
    Criticality: lam_ij^2 + (Lambda^2)_ij = theta lam_ij for all i != j."""
    L2 = lam @ lam
    num, den = 0.0, 0.0
    for i in range(n):
        for j in range(n):
            if i != j:
                num += (lam[i, j] ** 2 + L2[i, j]) * lam[i, j]
                den += lam[i, j] ** 2
    th = num / den
    res = 0.0
    for i in range(n):
        for j in range(n):
            if i != j:
                res = max(res, abs(lam[i, j] ** 2 + L2[i, j] - th * lam[i, j]))
    return th, res


def graph_of(lam, tol=1e-9):
    n = lam.shape[0]
    return {(i, j) for i in range(n) for j in range(i + 1, n) if lam[i, j] < -tol}


def triangle_free(n, E):
    Eset = set(E)
    for (i, j, k) in itertools.combinations(range(n), 3):
        if (i, j) in Eset and (i, k) in Eset and (j, k) in Eset:
            return False
    return True


def is_cut(n, E):
    """E is a cut iff every triangle of K_n meets E in an even number of edges,
    iff the vertex set splits so that E = E(A, A^c).  Tested by 2-colouring."""
    Eset = set(E)
    col = {0: 0}
    stack = [0]
    seen = {0}
    while stack:
        v = stack.pop()
        for u in range(n):
            if u == v:
                continue
            e = (min(u, v), max(u, v))
            want = col[v] ^ (1 if e in Eset else 0)
            if u in col:
                if col[u] != want:
                    return False
            else:
                col[u] = want
                stack.append(u)
    return True


def demo_B():
    print("(B)  Coordinate-diagonal critical points.  For a diagonal W the")
    print("     structure constant <[E_ij,E_kl],E_pq> is nonzero only on")
    print("     triangles {ij, jk, ik}.  Hence, with G = {ij : lambda_ij < 0}:")
    print("        S_mmm = 0   <=>   G is triangle free")
    print("        graded      <=>   every triangle meets G evenly  <=>  G is a cut")
    print()


# -------------------------------------- (C) triangle-free SRG critical points

def petersen():
    V = list(itertools.combinations(range(5), 2))
    n = len(V)
    A = np.zeros((n, n))
    for a in range(n):
        for b in range(n):
            if a != b and not (set(V[a]) & set(V[b])):
                A[a, b] = 1.0
    return A


def clebsch():
    V = [tuple((k >> t) & 1 for t in range(4)) for k in range(16)]
    S = {(1, 0, 0, 0), (0, 1, 0, 0), (0, 0, 1, 0), (0, 0, 0, 1), (1, 1, 1, 1)}
    n = 16
    A = np.zeros((n, n))
    for a in range(n):
        for b in range(n):
            d = tuple((V[a][t] ^ V[b][t]) for t in range(4))
            if d in S:
                A[a, b] = 1.0
    return A


def perfect_matching(n):
    A = np.zeros((n, n))
    for a in range(0, n, 2):
        A[a, a + 1] = A[a + 1, a] = 1.0
    return A


def complete_bipartite(p, q):
    n = p + q
    A = np.zeros((n, n))
    for a in range(p):
        for b in range(p, n):
            A[a, b] = A[b, a] = 1.0
    return A


def srg_point(A):
    """Two-value diagonal ansatz on a regular graph: alpha on edges, beta off.
    Row sums zero fixes alpha/beta; criticality then holds iff the graph is
    strongly regular.  Returns (Lambda, theta, residual)."""
    n = A.shape[0]
    d = int(A[0].sum())
    beta = 1.0
    alpha = -(n - 1 - d) * beta / d
    lam = alpha * A + beta * (np.ones((n, n)) - np.eye(n) - A)
    th, res = diag_critical_residual(n, lam)
    return lam, th, res


def full_report(name, A):
    n = A.shape[0]
    lam, th_raw, res = srg_point(A)
    E = {(i, j) for i in range(n) for j in range(i + 1, n) if lam[i, j] < 0}
    tf = triangle_free(n, E)
    cut = is_cut(n, E)
    W = diag_operator(n, {(i, j): lam[i, j] for i in range(n) for j in range(i + 1, n)})
    nrm = np.linalg.norm(W)
    W = W / nrm
    c = structure_constants(n)
    QW = Q_of(c, W)
    th = P_of(c, W)
    cres = np.abs(QW - th * W).max()
    Smmm = slack_structural(c, W)
    Shhm = slack_hhm(c, W)
    Sw = slack_weighted(c, W)
    ric = np.abs(ricci(n, W)).max()
    bia = np.abs(bianchi_vec(n, W)).max()
    _, Pm, ev, V = negative_part(W, 1e-9)
    dm = int((ev < -1e-9).sum())
    th0 = np.sqrt(2 * (n - 1) * (n - 2)) / n
    print(f"  {name:22s} n={n:3d} deg={int(A[0].sum()):3d} |E|={len(E):4d} "
          f"trianglefree={str(tf):5s} cut={str(cut):5s}")
    print(f"  {'':22s} theta={th:+.9f} (theta_0={th0:.6f})  crit.res={cres:.2e} "
          f"|Ric|={ric:.1e} |Bianchi|={bia:.1e}")
    print(f"  {'':22s} dim m={dm}  C(dim m,3)={dm*(dm-1)*(dm-2)//6}  "
          f"S_mmm={Smmm:.3e}  S_hhm={Shhm:.6f}  S_w={Sw:.3e}")
    verdict = ("GRADED" if (Smmm < 1e-16 and Shhm < 1e-16)
               else "UNGRADED with S=0" if Smmm < 1e-16
               else "S > 0")
    print(f"  {'':22s} => {verdict}")
    print()
    return dict(n=n, theta=th, dm=dm, Smmm=Smmm, Shhm=Shhm, tf=tf, cut=cut, res=cres)


if __name__ == "__main__":
    demo_A()
    demo_B()
    print("(C)  Explicit critical points from regular graphs.")
    print()
    rows = []
    rows.append(full_report("K_{4,4}  (S^4xS^4)", complete_bipartite(4, 4)))
    rows.append(full_report("K_{6,6}  (S^6xS^6)", complete_bipartite(6, 6)))
    rows.append(full_report("perfect matching n=8", perfect_matching(8)))
    rows.append(full_report("perfect matching n=12", perfect_matching(12)))
    rows.append(full_report("Petersen (10,3,0,1)", petersen()))
    rows.append(full_report("Clebsch (16,5,0,2)", clebsch()))
