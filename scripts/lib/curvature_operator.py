import numpy as np
import itertools

def pair_index(n):
    pairs = list(itertools.combinations(range(n), 2))
    idx = {p: k for k, p in enumerate(pairs)}
    return pairs, idx

def so_n_basis_matrices(n):
    pairs, idx = pair_index(n)
    Es = []
    for (i, j) in pairs:
        E = np.zeros((n, n))
        E[j, i] = 1.0
        E[i, j] = -1.0
        Es.append(E)
    return Es, pairs, idx

class Lambda2:
    def __init__(self, n):
        self.n = n
        self.Es, self.pairs, self.idx = so_n_basis_matrices(n)
        self.N = len(self.pairs)

    def vec_to_matrix(self, v):
        A = np.zeros((self.n, self.n))
        for a in range(self.N):
            if v[a] != 0:
                A += v[a] * self.Es[a]
        return A

    def matrix_to_vec(self, A):
        v = np.zeros(self.N)
        for a, (i, j) in enumerate(self.pairs):
            v[a] = A[j, i]
        return v

    def bracket(self, a_vec, b_vec):
        A = self.vec_to_matrix(a_vec)
        B = self.vec_to_matrix(b_vec)
        C = A @ B - B @ A
        return self.matrix_to_vec(C)

    def R_sharp_quadform(self, Mop, eta):
        # <R^# eta, eta> = -1/2 sum_i <[eta, R([eta, R(omega_i)])], omega_i>
        total = 0.0
        for i in range(self.N):
            omega_i = np.zeros(self.N); omega_i[i] = 1.0
            R_omega = Mop @ omega_i
            br1 = self.bracket(eta, R_omega)
            R_br1 = Mop @ br1
            br2 = self.bracket(eta, R_br1)
            total += np.dot(br2, omega_i)
        return -0.5 * total

    def R_sharp_matrix(self, Mop):
        N = self.N
        diagvals = np.zeros(N)
        e = np.eye(N)
        for a in range(N):
            diagvals[a] = self.R_sharp_quadform(Mop, e[a])
        Out = np.diag(diagvals)
        for a in range(N):
            for b in range(a + 1, N):
                val = self.R_sharp_quadform(Mop, e[a] + e[b])
                off = 0.5 * (val - diagvals[a] - diagvals[b])
                Out[a, b] = off
                Out[b, a] = off
        return Out

def Q_op(L2, Mop):
    return Mop @ Mop + L2.R_sharp_matrix(Mop)

# ---- validate against known diagonal formula ----
def test_diagonal_formula(n, seed=0):
    rng = np.random.default_rng(seed)
    L2 = Lambda2(n)
    pairs, idx = L2.pairs, L2.idx
    N = L2.N
    lam = {p: rng.normal() for p in pairs}
    M = np.zeros((N, N))
    for p in pairs:
        M[idx[p], idx[p]] = lam[p]
    Q = Q_op(L2, M)
    ok = True
    worst = 0.0
    for (i, j) in pairs:
        known = lam[(i, j)] ** 2
        for k in range(n):
            if k == i or k == j:
                continue
            a, b = (min(i, k), max(i, k)), (min(j, k), max(j, k))
            known += lam[a] * lam[b]
        got = Q[idx[(i, j)], idx[(i, j)]]
        worst = max(worst, abs(got - known))
        if abs(got - known) > 1e-6:
            ok = False
    offmax = 0.0
    for a in range(N):
        for b in range(N):
            if a != b:
                offmax = max(offmax, abs(Q[a, b]))
    print(f"n={n}: diag match={ok}, worst err={worst:.2e}, max off-diag |Q|={offmax:.2e}")
    return ok

if __name__ == "__main__":
    for n in [4, 5, 6]:
        test_diagonal_formula(n)
