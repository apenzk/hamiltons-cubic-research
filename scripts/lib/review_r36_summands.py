"""Independent construction of the ten O(p)xO(q) summands of Weyl_n.

Built as joint eigenspaces of a commuting family of manifestly O(p)xO(q)-invariant
symmetric operators (Casimirs of so(p), so(q), so(n) plus operators made from the
invariant projections I_p, I_q).  Uses projectors, never a filtered eigenbasis, and
never L_e -- so it is independent of the claims under test.
"""
import numpy as np, sys
sys.path.insert(0, 'scripts/lib')
from review_r36_core import *


def adjoint_action(A, X):
    """ad_X on Lambda^2 for X = phi_a: matrix M with M_{cb} = c_abc.  Here we take
    X in so(n) as an n x n matrix and return the induced map on Lambda^2."""
    n = X.shape[0]
    P = phi_matrices(n)
    N = P.shape[0]
    XP = np.einsum('ij,ajk->aik', X, P) - np.einsum('aij,jk->aik', P, X)
    M = np.zeros((N, N))
    for b in range(N):
        for c in range(N):
            M[c, b] = 0.5*np.trace(P[c].T @ XP[b])
    return M


def drho_matrix(B, adX):
    """d/dt of V -> rho V rho^T is V -> [adX, V]."""
    D = B.shape[0]; N = B.shape[1]
    Bf = B.reshape(D, N*N)
    out = np.zeros((D, D))
    for j in range(D):
        Y = adX@B[j] - B[j]@adX
        out[:, j] = Bf @ Y.reshape(N*N)
    return out


def casimir(B, n, lo, hi):
    """-sum drho(phi_a)^2 over so of the coordinate block [lo,hi)."""
    D = B.shape[0]
    C = np.zeros((D, D))
    for i in range(lo, hi):
        for j in range(i+1, hi):
            X = np.zeros((n, n)); X[i, j] = 1.0; X[j, i] = -1.0
            M = drho_matrix(B, adjoint_action(None if False else np.eye(n)*0+X, X)*0 + adjoint_action_X(n, X))
            C -= M@M
    return C


def adjoint_action_X(n, X):
    P = phi_matrices(n)
    N = P.shape[0]
    XP = np.einsum('ij,ajk->aik', X, P) - np.einsum('aij,jk->aik', P, X)
    M = np.zeros((N, N))
    for b in range(N):
        for c in range(N):
            M[c, b] = 0.5*np.trace(P[c].T @ XP[b])
    return M


def invariant_ops(B, n, p):
    """Manifestly O(p)xO(q)-invariant symmetric operators on Weyl_n."""
    D = B.shape[0]; N = B.shape[1]
    Bf = B.reshape(D, N*N)
    Ip = I_block(n, 0, p); Iq = I_block(n, p, n)
    ops = []
    for nm, f in [("IpV+VIp", lambda V: Ip@V + V@Ip),
                  ("IpVIp",   lambda V: Ip@V@Ip),
                  ("IqVIq",   lambda V: Iq@V@Iq),
                  ("IpVIq+",  lambda V: Ip@V@Iq + Iq@V@Ip)]:
        M = np.zeros((D, D))
        for j in range(D):
            M[:, j] = Bf @ f(B[j]).reshape(N*N)
        ops.append((nm, 0.5*(M+M.T)))
    return ops


def predicted_dims(p, q):
    s = lambda m: (m+2)*(m-1)//2
    c = lambda m: m*(m-1)//2
    X = lambda m: m*(m*m-4)//3
    return {
        "<W>": 1,
        "Weyl_p": dim_weyl(p) if p >= 4 else 0,
        "Weyl_q": dim_weyl(q) if q >= 4 else 0,
        "R^p (x) R^q": p*q,
        "S2_0(R^p)": s(p),
        "S2_0(R^q)": s(q),
        "S2_0 (x) S2_0": s(p)*s(q),
        "L2 (x) L2": c(p)*c(q),
        "X_p (x) R^q": X(p)*q,
        "X_q (x) R^p": X(q)*p,
    }


def summands(p, q, verbose=True):
    n = p+q
    B = weyl_basis(n); D = len(B); N = B.shape[1]
    Cp = casimir_block(B, n, 0, p)
    Cq = casimir_block(B, n, p, n)
    Cn = casimir_block(B, n, 0, n)
    ops = [("Cas_p", Cp), ("Cas_q", Cq), ("Cas_n", Cn)] + invariant_ops(B, n, p)
    rng = np.random.default_rng(3)
    M = sum(r*O for r, (_, O) in zip(rng.normal(size=len(ops)), ops))
    M = 0.5*(M+M.T)
    w, U = np.linalg.eigh(M)
    # group eigenvalues
    groups = []
    start = 0
    for i in range(1, D+1):
        if i == D or abs(w[i]-w[start]) > 1e-7*max(1.0, abs(w[start])):
            groups.append((w[start:i].mean(), U[:, start:i]))
            start = i
    return B, ops, groups, D


def casimir_block(B, n, lo, hi):
    D = B.shape[0]
    C = np.zeros((D, D))
    for i in range(lo, hi):
        for j in range(i+1, hi):
            X = np.zeros((n, n)); X[i, j] = 1.0; X[j, i] = -1.0
            M = drho_matrix(B, adjoint_action_X(n, X))
            C -= M@M
    return C


if __name__ == "__main__":
    for (p, q) in [(3,4),(4,4),(3,5)]:
        B, ops, groups, D = summands(p, q)
        pred = predicted_dims(p, q)
        print(f"\n(p,q)=({p},{q})  dim Weyl={D}  #eigenspaces of random invariant = {len(groups)}")
        print("  measured dims:", sorted(g[1].shape[1] for g in groups))
        print("  predicted   :", sorted(v for v in pred.values() if v > 0), " sum",
              sum(pred.values()))
