"""Reviewer 293, independent build from the definitions.  D1, D2, D3.

Conventions taken from the definitions only:
  Lambda^2 R^n, phi_{ij} = E_ij - E_ji (i<j),  <X,Y> = 1/2 tr(X^T Y)  -> phi orthonormal
  c_{abg} = <[phi_a,phi_b],phi_g>,  (A_a)_{mn} = c_{amn}
  (W^#)_{ab} = -1/2 tr(A_a W A_b W),  Q(W) = W^2 + W^#,  theta = <W,Q(W)> = tr(W Q(W))
  eigenpairs (lam_a, v_a) of W;  c'_{abg} = <[v_a,v_b],v_g>;  T_{abg} = c'^2_{abg}
  R_{ga} = sum_b T_{gab};  Q_g = sum_{ab} lam_a lam_b T_{gab}
  g_g = sum_{ab} (lam_a-lam_b)^2 T_{gab};  Delta = sum_{lam_g>0} g_g
"""
import numpy as np, sys, itertools
sys.path.insert(0, 'scripts/lib')

def pairs_of(n):
    return [(i, j) for i in range(n) for j in range(i + 1, n)]

def phi(n):
    P = np.zeros((len(pairs_of(n)), n, n))
    for a, (i, j) in enumerate(pairs_of(n)):
        P[a, i, j], P[a, j, i] = 1.0, -1.0
    return P

def cstruct(n):
    """c[a,b,g] = <[phi_a,phi_b],phi_g> with <X,Y> = 1/2 tr(X^T Y)."""
    P = phi(n)
    br = np.einsum('aik,bkj->abij', P, P) - np.einsum('bik,akj->abij', P, P)
    return 0.5 * np.einsum('abij,gij->abg', br, P)

def sharp_mine(n, W):
    c = cstruct(n)                       # A_a = c[a]
    M = np.einsum("amn,np->amp", c, W)
    return -0.5 * np.einsum("amn,bnm->ab", M, M)

def theta_of(n, W):
    return float(np.trace(W @ (W @ W + sharp_mine(n, W))))

def crit_res(n, W):
    Qw = W @ W + sharp_mine(n, W)
    th = float(np.trace(W @ Qw))
    return th, float(np.linalg.norm(Qw - th * W))

def quantities(n, W):
    """Everything in the eigenbasis, built from the eigenvectors as so(n) elements."""
    W = W / np.linalg.norm(W)
    lam, V = np.linalg.eigh(W)
    P = phi(n)
    v = np.einsum('ag,gij->aij', V.T, P)          # v[a] = a-th eigenvector as a matrix
    br = np.einsum('aik,bkj->abij', v, v) - np.einsum('bik,akj->abij', v, v)
    cp = 0.5 * np.einsum('abij,gij->abg', br, v)  # c'_{abg}
    T = cp ** 2
    R = T.sum(axis=2)                             # R[g,a] = sum_b T[g,a,b]
    Qg = np.einsum('gab,a,b->g', T, lam, lam)
    gg = np.einsum('gab,ab->g', T, (lam[:, None] - lam[None, :]) ** 2)
    M2 = np.einsum('ga,a->g', R, lam ** 2)        # sum_a lam_a^2 R_{ga}
    Sh = V.T @ sharp_mine(n, W) @ V               # sharp in the eigenbasis
    return dict(lam=lam, T=T, R=R, Qg=Qg, gg=gg, M2=M2, sharp_diag=np.diag(Sh),
                theta=theta_of(n, W), W=W)
