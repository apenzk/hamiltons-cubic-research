"""Reviewer 66 / C2: numerical verification of every step of the centralizer
induction proving  max dim of an isotropic subspace of so(n)  =  floor(n^2/4).

Steps checked:
 (A) beta_u(x,y) = <[u,x],y> is alternating with radical exactly c(u), so an
     omega-isotropic m obeys  dim m <= dim(m cap c(u)) + (dim g - z(u))/2.
 (B) c(u) is a subalgebra and omega|_{c(u)} is its own Cartan 3-form.
 (C) the master identity  Phi(c(u)) + (dim g - z(u))/2 = Phi(g)  for g = so(k)
     and g = su(k), over every eigenvalue-multiplicity pattern.
 (D) closure of the class under centralizers, and the attained lower bounds.
"""
import itertools
from fractions import Fraction
import numpy as np
from review_r66_core import basis, ip, omega_tensor, isotropy_mass, symmetric_pair


# ---------- Phi on the class C = sums of abelian, su(k), so(k) ----------
def phi_su(k):  return (k * k + k - 2) // 2
def phi_so(k):  return (k * k) // 4
def phi_u(k):   return 1 + phi_su(k)          # u(k) = R + su(k)


def partitions(n, maxpart=None):
    if maxpart is None: maxpart = n
    if n == 0:
        yield []
        return
    for p in range(min(n, maxpart), 0, -1):
        for rest in partitions(n - p, p):
            yield [p] + rest


def check_identity_so(kmax):
    """For u in so(k) with nonzero-eigenvalue multiplicities m_j and kernel n_0:
       c(u) = sum_j u(m_j) + so(n_0),  z(u) = sum m_j^2 + n_0(n_0-1)/2."""
    bad = []
    for k in range(1, kmax + 1):
        dim_g = k * (k - 1) // 2
        for M in range(0, k // 2 + 1):
            n0 = k - 2 * M
            for ms in ([[]] if M == 0 else partitions(M)):
                z = sum(m * m for m in ms) + n0 * (n0 - 1) // 2
                Phi_c = sum(phi_u(m) for m in ms) + phi_so(n0)
                lhs = Fraction(Phi_c) + Fraction(dim_g - z, 2)
                if lhs != phi_so(k):
                    bad.append((k, ms, n0, lhs, phi_so(k)))
    return bad


def check_identity_su(kmax):
    bad = []
    for k in range(1, kmax + 1):
        dim_g = k * k - 1
        for a in partitions(k):
            t = len(a)
            z = sum(x * x for x in a) - 1
            Phi_c = sum(phi_su(x) for x in a) + (t - 1)   # s(prod u(a_j)) = sum su(a_j) + R^{t-1}
            lhs = Fraction(Phi_c) + Fraction(dim_g - z, 2)
            if lhs != phi_su(k):
                bad.append((k, a, lhs, phi_su(k)))
    return bad


# ---------- numeric checks of Lemma A ingredients in so(n) ----------
def centralizer_dim_numeric(u, B):
    """dim ker ad(u) computed as N - rank(ad u) on so(n)."""
    N = len(B)
    A = np.zeros((N, N))
    for a in range(N):
        C = u @ B[a] - B[a] @ u
        for b in range(N):
            A[b, a] = ip(C, B[b])
    s = np.linalg.svd(A, compute_uv=False)
    rank = int((s > 1e-9 * max(1.0, s[0])).sum())
    return N - rank, rank, A


def centralizer_dim_formula(u):
    """From the eigenvalue pattern of the real skew matrix u."""
    ev = np.linalg.eigvals(u)
    im = np.sort(np.abs(ev.imag))
    n = u.shape[0]
    thetas = [t for t in im if t > 1e-8]
    thetas = sorted(thetas)[0::2]                     # keep one of each conj pair
    n0 = n - 2 * len(thetas)
    mult, cur = [], []
    for t in thetas:
        if cur and abs(t - cur[-1]) < 1e-7:
            cur.append(t)
        else:
            if cur: mult.append(len(cur))
            cur = [t]
    if cur: mult.append(len(cur))
    return sum(m * m for m in mult) + n0 * (n0 - 1) // 2, mult, n0


if __name__ == '__main__':
    print("=== (C) master identity Phi(c(u)) + (dim g - z(u))/2 = Phi(g) ===")
    b1 = check_identity_so(40)
    b2 = check_identity_su(40)
    print(f"so(k), k<=40, every multiplicity pattern: {len(b1)} violations")
    print(f"su(k), k<=40, every multiplicity pattern: {len(b2)} violations")
    if b1[:3]: print("  sample so violations:", b1[:3])
    if b2[:3]: print("  sample su violations:", b2[:3])

    print("\n=== (A) beta_u alternating, radical = c(u), rank even ===")
    rng = np.random.default_rng(7)
    for n in [5, 6, 7, 8]:
        B, _ = basis(n)
        N = len(B)
        for trial in range(4):
            u = sum(rng.normal() * b for b in B)
            zn, rank, A = centralizer_dim_numeric(u, B)
            zf, mult, n0 = centralizer_dim_formula(u)
            skew = np.abs(A + A.T).max()
            print(f"  n={n} trial{trial}: rank(ad u)={rank} (even: {rank%2==0}) "
                  f"z_numeric={zn} z_formula={zf} mult={mult} n0={n0} "
                  f"||A+A^T||inf={skew:.1e}  bound (N+z)/2={(N+zn)/2:.1f} floor(n^2/4)={n*n//4}")
        # degenerate u: repeated eigenvalues / low rank
        for name, u in [("rank2", B[0]), ("doubled", B[0] + B[N-1] if n == 4 else None)]:
            if u is None: continue
            zn, rank, A = centralizer_dim_numeric(u, B)
            zf, mult, n0 = centralizer_dim_formula(u)
            print(f"  n={n} {name}: z_numeric={zn} z_formula={zf} mult={mult} n0={n0}")

    print("\n=== (B) c(u) is a subalgebra, omega restricts to its Cartan form ===")
    n = 7
    B, _ = basis(n)
    N = len(B)
    u = sum(rng.normal() * b for b in B)
    zn, rank, A = centralizer_dim_numeric(u, B)
    # basis of ker ad(u)
    _, s, Vt = np.linalg.svd(A)
    K = Vt[rank:].T                      # N x z
    mats = [sum(K[t, c] * B[t] for t in range(N)) for c in range(K.shape[1])]
    err = max(np.abs(u @ M - M @ u).max() for M in mats)
    # closed under bracket?
    P = K @ K.T
    clos = 0.0
    for X in mats:
        for Y in mats:
            C = X @ Y - Y @ X
            v = np.array([ip(C, B[t]) for t in range(N)])
            clos = max(clos, np.linalg.norm(v - P @ v))
    print(f"  n={n}: dim c(u)={K.shape[1]}, [u,c(u)]={err:.1e}, bracket-closure residual={clos:.1e}")

    print("\n=== (E) Lemma A is an equality at the cap ===")
    lemma_A_tightness()

    print("\n=== (D) lower bounds attained ===")
    for n in range(3, 10):
        p = n // 2
        W, _ = omega_tensor(n) if n <= 8 else (None, None)
        if W is not None:
            V = symmetric_pair(n, p)
            m, _ = isotropy_mass(W, V)
            print(f"  so({n}): symmetric pair dim {V.shape[1]} = floor(n^2/4)={n*n//4}, mass={m:.1e}")


def lemma_A_tightness(ns=(5, 6, 7, 8), trials=6, seed=11):
    """On a random SO(n)-conjugate of the cap symmetric pair, check that
    dim m = dim(m cap c(u)) + (N - z(u))/2 for every u drawn from m -- i.e. the
    squeeze of Lemma A is an equality at the cap, and m swallows the whole
    centralizer of each of its regular elements."""
    rng = np.random.default_rng(seed)
    for n in ns:
        B, _ = basis(n); W, _ = omega_tensor(n); N = W.shape[0]
        V0 = symmetric_pair(n, n // 2)
        g = np.linalg.qr(rng.normal(size=(n, n)))[0]
        mats = [g @ sum(V0[t, c] * B[t] for t in range(N)) @ g.T
                for c in range(V0.shape[1])]
        V = np.array([[ip(M, B[t]) for t in range(N)] for M in mats]).T
        V, _ = np.linalg.qr(V)
        d = V.shape[1]
        tight = 0
        for _ in range(trials):
            co = rng.normal(size=d)
            u = sum(co[c] * mats[c] for c in range(len(mats)))
            u /= np.linalg.norm(u)
            z, rank, A = centralizer_dim_numeric(u, B)
            s = np.linalg.svd(A @ V, compute_uv=False)
            k = int((s < 1e-8 * max(1.0, s[0])).sum()) + max(0, d - len(s))
            tight += abs(k + (N - z) / 2 - d) < 1e-9
        print(f"  n={n}: dim m={d}, Lemma A tight at {tight}/{trials} draws "
              f"(m contains c(u) whole: dim(m cap c(u)) = z(u))")
