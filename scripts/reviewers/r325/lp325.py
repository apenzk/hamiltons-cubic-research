"""Reviewer 325's own LPs, built from the constraint statements alone."""
import numpy as np
from itertools import combinations
from scipy.optimize import linprog
from scipy.sparse import coo_matrix


def diag_criticality_lp(lams, n, sense='max'):
    """max/min theta over T >= 0 indexed by unordered triples of distinct indices, with
         sum_{al<be} T_{k al be} = n-2                        (all k)
         sum_{al<be} lam_al lam_be T_{k al be} = lam_k(theta-lam_k)  (all k)
    Variables: [T (C(N,3)), theta].  theta free."""
    lams = np.asarray(lams, float)
    N = len(lams)
    trips = list(combinations(range(N), 3))
    nT = len(trips)
    rows, cols, vals = [], [], []
    b = np.zeros(2 * N)
    for t, (a, bb, cc) in enumerate(trips):
        for k, (x, y) in ((a, (bb, cc)), (bb, (a, cc)), (cc, (a, bb))):
            rows.append(k); cols.append(t); vals.append(1.0)
            rows.append(N + k); cols.append(t); vals.append(lams[x] * lams[y])
    for k in range(N):
        b[k] = n - 2
        b[N + k] = -lams[k] ** 2
        rows.append(N + k); cols.append(nT); vals.append(-lams[k])
    A = coo_matrix((vals, (rows, cols)), shape=(2 * N, nT + 1)).tocsr()
    c = np.zeros(nT + 1)
    c[nT] = -1.0 if sense == 'max' else 1.0
    bounds = [(0, None)] * nT + [(None, None)]
    r = linprog(c, A_eq=A, b_eq=b, bounds=bounds, method='highs')
    if not r.success:
        return None, r.message
    return float(r.x[nT]), r


def marginal_deficiency_lp(lams, n):
    """min 1/2 sum_{a,b} lam_a lam_b C_ab over symmetric C>=0, zero diagonal,
    row sums <= 2, total sum_{a,b} C_ab = 2(n-2).  Variables: unordered pairs, U_{ab}=C_ab.
    Then sum_{a,b}C_ab = 2 sum_{a<b} U_ab, row sum_a = sum_{b!=a} U_ab."""
    lams = np.asarray(lams, float)
    N = len(lams)
    prs = list(combinations(range(N), 2))
    nU = len(prs)
    obj = np.array([lams[a] * lams[b] for (a, b) in prs])  # 1/2 * 2 * lam_a lam_b
    Aub = np.zeros((N, nU)); bub = np.full(N, 2.0)
    Aeq = np.zeros((1, nU)); beq = np.array([float(n - 2)])
    for t, (a, b) in enumerate(prs):
        Aub[a, t] = 1.0; Aub[b, t] = 1.0
        Aeq[0, t] = 1.0
    r = linprog(obj, A_ub=Aub, b_ub=bub, A_eq=Aeq, b_eq=beq,
                bounds=[(0, None)] * nU, method='highs')
    if not r.success:
        return None, r
    return float(r.fun), r
