"""Reviewer 293: the marginal/bracket relaxation, with and without the PER-ROW
criticality equations that D2 supplies.

Variables: t_{a<b<c} >= 0  (T totally symmetric, T_{aab}=0 since c' is antisymmetric).
Derived:   R_{ab} = sum_c t_{abc}                (a != b)
           theta  = sum_a lam_a^3 + 3 sum_{a<b<c} lam_a lam_b lam_c t
           Q_g    = 2 sum_{{g,b,c}} lam_b lam_c t

Constraint blocks
  M  marginal      sum_{triples containing a} t = n-2           (== sum_{bc} T_{abc} = 2(n-2))
  Pc pair cap      R_{ab} <= 2
  Tr trace         sum_g Q_g = -2                               (tr W^# = -1)
  V  vector id     sum_b lam_b R_{gb} = -2 lam_g   for every g  (A(W) = 2W, per row)
  C  criticality   Q_g = 2 theta lam_g - 2 lam_g^2 for every g  (D2, per row)
"""
import numpy as np, itertools
from scipy.optimize import linprog
from scipy.sparse import lil_matrix, csr_matrix


def triples(N):
    return list(itertools.combinations(range(N), 3))


class Relax:
    def __init__(self, n):
        self.n = n
        self.N = N = n * (n - 1) // 2
        self.tri = triples(N)
        self.K = len(self.tri)
        # incidence: which triples contain index a
        self.byidx = [[] for _ in range(N)]
        for k, (a, b, c) in enumerate(self.tri):
            self.byidx[a].append((k, b, c)); self.byidx[b].append((k, a, c)); self.byidx[c].append((k, a, b))
        self.bypair = {}
        for k, (a, b, c) in enumerate(self.tri):
            for (x, y, z) in ((a, b, c), (a, c, b), (b, c, a)):
                self.bypair.setdefault((x, y), []).append((k, z))
        # static blocks
        Am = lil_matrix((N, self.K))
        for a in range(N):
            for (k, _, _) in self.byidx[a]:
                Am[a, k] = 1.0
        self.Am = csr_matrix(Am); self.bm = np.full(N, n - 2.0)
        Ap = lil_matrix((len(self.bypair), self.K))
        self.pairlist = sorted(self.bypair)
        for r, pr in enumerate(self.pairlist):
            for (k, _) in self.bypair[pr]:
                Ap[r, k] = 1.0
        self.Ap = csr_matrix(Ap); self.bp = np.full(len(self.pairlist), 2.0)

    def coeffs(self, lam):
        """objective row (theta = s3 + w.t), Q rows (Q_g = Qrow[g].t), V rows."""
        K, N = self.K, self.N
        w = np.array([3.0 * lam[a] * lam[b] * lam[c] for (a, b, c) in self.tri])
        s3 = float((lam ** 3).sum())
        Qrow = np.zeros((N, K)); Vrow = np.zeros((N, K)); M2row = np.zeros((N, K))
        for g in range(N):
            for (k, b, c) in self.byidx[g]:
                Qrow[g, k] += 2.0 * lam[b] * lam[c]
                Vrow[g, k] += lam[b] + lam[c]
                M2row[g, k] += lam[b] ** 2 + lam[c] ** 2
        return w, s3, Qrow, Vrow, M2row

    def solve(self, lam, use_V=True, use_C=True, use_Tr=True, use_D=False, tol=1e-12):
        w, s3, Qrow, Vrow, M2row = self.coeffs(lam)
        Aeq = [self.Am]; beq = [self.bm]
        if use_Tr:
            Aeq.append(csr_matrix(Qrow.sum(axis=0)[None, :])); beq.append(np.array([-2.0]))
        if use_V:
            Aeq.append(csr_matrix(Vrow)); beq.append(-2.0 * lam)
        if use_C:
            # Q_g - 2 lam_g theta = -2 lam_g^2 ,  theta = s3 + w.t
            Ac = Qrow - 2.0 * lam[:, None] * w[None, :]
            Aeq.append(csr_matrix(Ac)); beq.append(-2.0 * lam ** 2 + 2.0 * lam * s3)
        from scipy.sparse import vstack
        A = vstack(Aeq).tocsr(); b = np.concatenate(beq)
        Aub, bub = self.Ap, self.bp
        if use_D:   # D3 rows only: M2_g >= 2 lam_g theta - 2 lam_g^2 at lam_g > 0
            pos = np.where(lam > tol)[0]
            if len(pos):
                Ad = -(M2row[pos] - 2.0 * lam[pos, None] * w[None, :])
                bd = -(2.0 * lam[pos] * s3 - 2.0 * lam[pos] ** 2)
                Aub = vstack([Aub, csr_matrix(Ad)]).tocsr(); bub = np.concatenate([bub, bd])
        res = linprog(-w, A_ub=Aub, b_ub=bub, A_eq=A, b_eq=b,
                      bounds=(0, None), method='highs')
        if not res.success:
            return None
        return s3 - res.fun
