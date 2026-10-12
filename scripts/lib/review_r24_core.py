"""Reviewer 24 independent core: multi-block Weyl operators built from scratch.

Everything here is derived from the definitions rather than imported from the
scripts under audit.  R^# is built from so(n) structure constants; the
multi-block vertex point is a closed form derived by hand and then checked
against the full Q operator; RHS is assembled from the definition, with
sqrt(1-e^2) = <|W|, Ric^Ric>/||Ric^Ric|| (Ric = Ric(|W|)).
"""
import numpy as np
from itertools import combinations


# ------------------------------------------------------------------ Lambda^2
def pairs_of(n):
    return list(combinations(range(n), 2))


def struct_c(n):
    """c[a,b,g] = <[phi_a, phi_b], phi_g>, phi_ij = E_ij - E_ji, <A,B>=tr(A^T B)/2."""
    prs = pairs_of(n)
    pos = {p: t for t, p in enumerate(prs)}
    N = len(prs)
    c = np.zeros((N, N, N))
    for a, (i, j) in enumerate(prs):
        for b, (k, l) in enumerate(prs):
            terms = []
            if j == k: terms.append((1.0, (i, l)))
            if i == k: terms.append((-1.0, (j, l)))
            if j == l: terms.append((-1.0, (i, k)))
            if i == l: terms.append((1.0, (j, k)))
            for co, (p, q) in terms:
                if p == q:
                    continue
                s = 1.0
                if p > q:
                    p, q = q, p
                    s = -1.0
                c[a, b, pos[(p, q)]] += co * s
    return prs, pos, N, c


def rsharp_full(R, c):
    """R^#_{ab} = 1/2 sum c[a,g,d] c[b,e,z] R[g,e] R[d,z]   (basis-free, no eigen)."""
    T = np.einsum('agd,ge,dz->aez', c, R, R, optimize=True)
    return 0.5 * np.einsum('aez,bez->ab', T, c, optimize=True)


def Q_full(R, c):
    return R @ R + rsharp_full(R, c)


def rsharp_diag(lam, prs, pos, n):
    """R^# for R diagonal in the coordinate 2-plane basis (derived by hand)."""
    out = np.zeros(len(prs))
    for t, (i, j) in enumerate(prs):
        s = 0.0
        for k in range(n):
            if k == i or k == j:
                continue
            s += lam[pos[(min(i, k), max(i, k))]] * lam[pos[(min(j, k), max(j, k))]]
        out[t] = s
    return out


# ------------------------------------------------------------------ Ricci
def ric_diag(lam, prs, n):
    """Ric of a diagonal operator: Ric_ii = sum_{j!=i} lam_(ij); off-diagonal 0."""
    R = np.zeros(n)
    for t, (i, j) in enumerate(prs):
        R[i] += lam[t]
        R[j] += lam[t]
    return R


def ric_op(M, prs, n):
    """Ric of a general operator M on Lambda^2 (same convention as the repo)."""
    pos = {p: t for t, p in enumerate(prs)}
    def ent(i, j, k, l):
        if i == j or k == l:
            return 0.0
        s1 = 1.0
        if i > j:
            i, j, s1 = j, i, -1.0
        s2 = 1.0
        if k > l:
            k, l, s2 = l, k, -1.0
        return s1 * s2 * M[pos[(i, j)], pos[(k, l)]]
    Ric = np.zeros((n, n))
    for i in range(n):
        for k in range(n):
            Ric[i, k] = sum(ent(i, j, k, j) for j in range(n))
    return Ric


# ------------------------------------------------------- multi-block vertex
def block_vector(blocks):
    n = sum(blocks)
    blk = np.zeros(n, int)
    st = 0
    for a, sz in enumerate(blocks):
        blk[st:st + sz] = a
        st += sz
    return blk


def theta2_closed(blocks):
    """theta^2 from the normalisation of the hand-derived vertex point."""
    n, k = sum(blocks), len(blocks)
    D = (k - 1) * n * n + sum((n - a) ** 2 / (a - 1) for a in blocks)
    return 2.0 * (n - 1) ** 2 / D


def vertex_closed(blocks):
    """w[a,b] = -theta/(n-1) (a!=b),  w[a,a] = theta(n-n_a)/((n-1)(n_a-1))."""
    n, k = sum(blocks), len(blocks)
    th = np.sqrt(theta2_closed(blocks))
    w = np.full((k, k), -th / (n - 1))
    for a in range(k):
        w[a, a] = th * (n - blocks[a]) / ((n - 1) * (blocks[a] - 1))
    return w, th


def lam_from_blocks(blocks, w, prs):
    blk = block_vector(blocks)
    return np.array([w[blk[i], blk[j]] for (i, j) in prs])


# ------------------------------------------------------------------ the RHS
def rhs_from_definition(lam, prs, n, delta2=0.0):
    """RHS of the sharp (II)-side bound, from the definition, for diagonal W."""
    absl = np.abs(lam)
    negl = np.maximum(-lam, 0.0)
    rho = ric_diag(negl, prs, n)                    # Ric(W_-), diagonal
    nr2 = float(rho @ rho)
    Sh = rho / np.sqrt(nr2)
    trSh4 = float(np.sum(Sh ** 4))
    Ric = ric_diag(absl, prs, n)                    # Ric(|W|), diagonal
    RRd = np.array([Ric[i] * Ric[j] for (i, j) in prs])   # (Ric ^ Ric) diagonal
    sq1me2 = float(absl @ RRd) / np.linalg.norm(RRd)
    ricWm2 = ric_diag(negl ** 2, prs, n)            # Ric(W_-^2)
    Bt = float(ricWm2 @ rho) / nr2
    cap = 12.0 * delta2 * float(np.max(rho)) / nr2
    return (np.sqrt(2) * np.sqrt(max(1 - trSh4, 0.0)) * sq1me2 - Bt + cap,
            dict(nr2=nr2, trSh4=trSh4, sq1me2=sq1me2, Bt=Bt,
                 trWm=float(np.sum(negl)), trWm2=float(np.sum(negl ** 2))))


def slack_from_definition(lam, prs, n, theta, delta2=0.0):
    negl = np.maximum(-lam, 0.0)
    rho = ric_diag(negl, prs, n)
    return (float(rho @ rho) + 6 * delta2 - theta * float(np.sum(negl))
            - float(np.sum(negl ** 2)))


# ------------------------------------ my closed form for RHS on the family
def rhs_closed_r24(blocks):
    """RHS = mu (A3 + A1^2 - C2)/A2 - mu,  mu = theta/(n-1)."""
    n = sum(blocks)
    b = np.array(blocks, float)
    s = n - b
    A1 = float(np.sum(b * s))
    A2 = float(np.sum(b * s ** 2))
    A3 = float(np.sum(b * s ** 3))
    C2 = float(np.sum(b ** 2 * s ** 2))
    th = np.sqrt(theta2_closed(blocks))
    mu = th / (n - 1)
    return mu * (A3 + A1 ** 2 - C2) / A2 - mu


def j5_over_r2_closed(blocks):
    """RHS - theta = mu (A1^2 - 2 C2)/A2   on the multi-block family."""
    n = sum(blocks)
    b = np.array(blocks, float)
    s = n - b
    A1 = float(np.sum(b * s))
    A2 = float(np.sum(b * s ** 2))
    C2 = float(np.sum(b ** 2 * s ** 2))
    th = np.sqrt(theta2_closed(blocks))
    return (th / (n - 1)) * (A1 ** 2 - 2 * C2) / A2
