"""Reviewer 57: independent rebuild of the Weyl/Q machinery, from definitions.

Nothing here imports the repository's own modules; the point is to have a second
implementation to compare against.  Conventions fixed and validated in main():

  Lambda^2 R^n  has orthonormal basis  phi_ij = e_i ^ e_j  (i<j), realised as the
  antisymmetric matrix  X_ij = e_i e_j^T - e_j e_i^T  with inner product
  <X,Y> = 1/2 tr(X^T Y).   [X_ab, X_cd] is the so(n) bracket, and the induced
  action of A in so(n) on Lambda^2 is  X -> [A, X].

  R# is defined basis-free by   <R# xi, eta> = sum_{a<b} <xi,[w_a,w_b]> <[R w_a, R w_b], eta>,
  equivalently  (R#)_{ef} = 1/2 sum_{abcd} c_{abe} R_{ac} R_{bd} c_{cdf},
  and is validated against (i) Id# = (n-2) Id, (ii) Hamilton's diagonal formula.

  Q(R) = R^2 + R#,  P(W) = <W, Q(W)>,  T(X,Y,Z) the full polarisation.
"""
import itertools
import numpy as np

# ---------------------------------------------------------------- basis / brackets

def pairs_of(n):
    return list(itertools.combinations(range(n), 2))


def basis_matrices(n):
    """X_ij = e_i e_j^T - e_j e_i^T, orthonormal under <X,Y> = 1/2 tr(X^T Y)."""
    P = pairs_of(n)
    B = np.zeros((len(P), n, n))
    for a, (i, j) in enumerate(P):
        B[a, i, j] = 1.0
        B[a, j, i] = -1.0
    return B


def structure_constants(n):
    """c[a,b,e] = <[w_a, w_b], w_e>."""
    B = basis_matrices(n)
    N = B.shape[0]
    c = np.zeros((N, N, N))
    P = pairs_of(n)
    idx = {p: k for k, p in enumerate(P)}
    for a in range(N):
        for b in range(N):
            C = B[a] @ B[b] - B[b] @ B[a]
            for e, (i, j) in enumerate(P):
                v = C[i, j]
                if v != 0.0:
                    c[a, b, e] = v
    return c


class Alg:
    """Everything that depends only on n."""

    _cache = {}

    def __init__(self, n):
        self.n = n
        self.pairs = pairs_of(n)
        self.idx = {p: k for k, p in enumerate(self.pairs)}
        self.N = len(self.pairs)
        self.B = basis_matrices(n)
        self.c = structure_constants(n)

    @classmethod
    def get(cls, n):
        if n not in cls._cache:
            cls._cache[n] = cls(n)
        return cls._cache[n]

    # ------------------------------------------------------------ sharp and Q
    def sharp(self, R):
        c = self.c
        U = np.einsum('ac,cdf->adf', R, c, optimize=True)
        T = np.einsum('bd,adf->abf', R, U, optimize=True)
        S = 0.5 * np.einsum('abe,abf->ef', c, T, optimize=True)
        return 0.5 * (S + S.T)

    def sharp_bilinear(self, R, S):
        return 0.5 * (self.sharp(R + S) - self.sharp(R) - self.sharp(S))

    def Q(self, R):
        return R @ R + self.sharp(R)

    def P(self, W):
        return float(np.sum(W * self.Q(W)))

    def T3(self, X, Y, Z):
        """Full polarisation of P: T(X,X,X) = P(X)."""
        B = 0.5 * (X @ Y + Y @ X) + self.sharp_bilinear(X, Y)
        return float(np.sum(Z * B))

    def L(self, e, v):
        """L_e v = 1/2(e v + v e) + e # v -- the derivative of Q/2 at e."""
        return 0.5 * (e @ v + v @ e) + self.sharp_bilinear(e, v)

    # ------------------------------------------------------------ so(n) action
    def ad(self, A):
        """Matrix of X -> [A,X] on Lambda^2 in the phi basis."""
        M = np.zeros((self.N, self.N))
        for b in range(self.N):
            C = A @ self.B[b] - self.B[b] @ A
            for e, (i, j) in enumerate(self.pairs):
                M[e, b] = C[i, j]
        return M

    def lam2(self, R):
        """Matrix of the Lambda^2 action of R in O(n) on the phi basis."""
        M = np.zeros((self.N, self.N))
        for b, (k, l) in enumerate(self.pairs):
            C = R @ self.B[b] @ R.T
            for e, (i, j) in enumerate(self.pairs):
                M[e, b] = C[i, j]
        return M


# ---------------------------------------------------------------- Weyl space

def sym_basis(N):
    """Orthonormal basis of Sym^2(R^N) under the Frobenius product."""
    out = []
    for a in range(N):
        E = np.zeros((N, N)); E[a, a] = 1.0
        out.append(E)
    for a in range(N):
        for b in range(a + 1, N):
            E = np.zeros((N, N)); E[a, b] = E[b, a] = 1.0 / np.sqrt(2.0)
            out.append(E)
    return out


def four_tensor(alg, M):
    """R_ijkl from the operator matrix, antisymmetric in (ij) and (kl)."""
    n, N = alg.n, alg.N
    E = np.zeros((n, n, N))
    for a, (i, j) in enumerate(alg.pairs):
        E[i, j, a] = 1.0
        E[j, i, a] = -1.0
    return np.einsum('ija,ab,klb->ijkl', E, M, E, optimize=True)


def bianchi_defect(alg, M):
    R = four_tensor(alg, M)
    return R + np.transpose(R, (0, 2, 3, 1)) + np.transpose(R, (0, 3, 1, 2))


def ricci(alg, M):
    R = four_tensor(alg, M)
    return np.einsum('ijkj->ik', R)


class Weyl:
    """The Weyl space of algebraic curvature operators: symmetric, Ricci-flat,
    first Bianchi.  Built as the null space of the two constraint maps."""

    _cache = {}

    def __init__(self, n):
        self.alg = Alg.get(n)
        alg = self.alg
        n, N = alg.n, alg.N
        SB = sym_basis(N)
        rows = []
        quad = list(itertools.combinations(range(n), 4))
        sympairs = [(i, k) for i in range(n) for k in range(i, n)]
        for E in SB:
            b = bianchi_defect(alg, E)
            r = ricci(alg, E)
            rows.append([b[i, j, k, l] for (i, j, k, l) in quad] +
                        [r[i, k] for (i, k) in sympairs])
        A = np.array(rows).T                      # constraints x dim Sym^2
        u, s, vt = np.linalg.svd(A)
        rank = int(np.sum(s > 1e-9 * max(1.0, s[0])))
        Vs = vt[rank:].T                          # dim Sym^2 x dim Weyl
        self.SB = np.array([E.ravel() for E in SB]).T    # N^2 x dim Sym^2
        self.basis_flat = self.SB @ Vs            # N^2 x dimW  (orthonormal cols)
        self.dim = self.basis_flat.shape[1]

    @classmethod
    def get(cls, n):
        if n not in cls._cache:
            cls._cache[n] = cls(n)
        return cls._cache[n]

    def project(self, M):
        N = self.alg.N
        M = 0.5 * (M + M.T)
        v = M.ravel()
        return (self.basis_flat @ (self.basis_flat.T @ v)).reshape(N, N)

    def coords(self, M):
        return self.basis_flat.T @ (0.5 * (M + M.T)).ravel()

    def from_coords(self, x):
        N = self.alg.N
        return (self.basis_flat @ x).reshape(N, N)


# ---------------------------------------------------------------- slack

def negative_eigenspace(W, tol=1e-9):
    ev, V = np.linalg.eigh(W)
    return V[:, ev < -tol], ev


def slack_structural(alg, W, tol=1e-9):
    """The Z_2-grading condition [m,m] subset h, measured on the NEGATIVE
    eigenspace m of W.  Returns (absolute leakage, fraction of ||[m,m]||^2).
    This is the structural quantity; it is basis-free and needs no criticality."""
    cols, ev = negative_eigenspace(W, tol)
    if cols.shape[1] == 0:
        return 0.0, 0.0
    Pm = cols @ cols.T
    k = cols.shape[1]
    mats = [sum(cols[a, i] * alg.B[a] for a in range(alg.N)) for i in range(k)]
    inside = tot = 0.0
    for i in range(k):
        for j in range(k):
            C = mats[i] @ mats[j] - mats[j] @ mats[i]
            v = np.array([C[p[0], p[1]] for p in alg.pairs])
            tot += float(v @ v)
            inside += float(v @ (Pm @ v))
    return inside, inside / max(tot, 1e-300)


def slack_theta_identity(alg, W):
    """S = ||Ric(W-)||^2 + 6 delta^2 - theta tr(W-) - tr(W-^2), the quantity
    review_r11_grading_slack.py calls the slack.  delta^2 = ||Alt(W)||^2 with
    Alt the totally antisymmetric part -- zero on Weyl operators."""
    th = alg.P(W)
    ev, V = np.linalg.eigh(W)
    neg = ev < 0
    Wm = (V[:, neg] * (-ev[neg])) @ V[:, neg].T
    r = ricci(alg, Wm)
    b = bianchi_defect(alg, Wm)                  # delta^2 is measured on W_-
    d2 = float(np.sum((b / 3.0) ** 2)) / 4.0     # ||Alt(W_-)||^2, Frobenius on the pair matrix
    return float(np.sum(r * r)) + 6 * d2 - th * float(np.trace(Wm)) - float(np.trace(Wm @ Wm))


# ---------------------------------------------------------------- validation

def main():
    print("== Reviewer 57 validation gates ==")
    for n in (4, 5, 6, 7, 8, 10, 12):
        alg = Alg.get(n)
        Id = np.eye(alg.N)
        s = alg.sharp(Id)
        err = np.abs(s - (n - 2) * Id).max()
        # Hamilton's diagonal formula
        rng = np.random.default_rng(7)
        lam = rng.normal(size=alg.N)
        M = np.diag(lam)
        S = alg.sharp(M)
        worst = 0.0
        for a, (i, j) in enumerate(alg.pairs):
            known = 0.0
            for k in range(n):
                if k in (i, j):
                    continue
                p = alg.idx[(min(i, k), max(i, k))]
                q = alg.idx[(min(j, k), max(j, k))]
                known += lam[p] * lam[q]
            worst = max(worst, abs(S[a, a] - known))
        offd = np.abs(S - np.diag(np.diag(S))).max()
        print(f"  n={n:2d} N={alg.N:3d}  Id#=(n-2)Id err={err:.2e}  "
              f"diag-# formula err={worst:.2e}  #-offdiag={offd:.2e}")

    print("\n-- dim Weyl_n --")
    for n in (4, 5, 6, 7, 8, 10, 12):
        w = Weyl.get(n)
        pred = n * (n + 1) * (n + 2) * (n - 3) // 12
        print(f"  n={n:2d}: dim={w.dim:5d}  formula={pred:5d}  {'OK' if w.dim == pred else 'MISMATCH'}")

    print("\n-- trilinear symmetry and tr(L_x)=0 on Weyl --")
    rng = np.random.default_rng(3)
    for n in (6, 8):
        w = Weyl.get(n); alg = w.alg
        X, Y, Z = [w.from_coords(rng.normal(size=w.dim)) for _ in range(3)]
        vals = [alg.T3(*p) for p in itertools.permutations((X, Y, Z))]
        print(f"  n={n}: T symmetric to {max(vals)-min(vals):.2e}; "
              f"T(X,X,X)-P(X) = {alg.T3(X,X,X)-alg.P(X):.2e}")
        # tr(L_x) over the Weyl space
        tr = 0.0
        for i in range(w.dim):
            v = w.from_coords(np.eye(w.dim)[i])
            tr += float(np.sum(v * w.project(alg.L(X, v))))
        print(f"       tr(L_X) on Weyl_{n} = {tr:.3e}   (||X||={np.linalg.norm(X):.3f})")


if __name__ == "__main__":
    main()
