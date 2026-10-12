"""Reviewer 25, structural checks: does Q preserve the Weyl space?  Is criticality
automatic for a family member?  Is h ~ m ever possible?"""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import sys; sys.path.insert(0,_os.path.join(_ROOT, 'scripts'))
import numpy as np, itertools
import review_r25_core as R, review_r25_tests as T

def weyl_projector(n):
    """orthonormal basis of the Weyl subspace of Sym^2(Lambda^2 R^n)."""
    N = n*(n-1)//2
    # basis of Sym^2(Lambda^2)
    B = []
    for a in range(N):
        E = np.zeros((N,N)); E[a,a]=1; B.append(E)
    for a in range(N):
        for b in range(a+1,N):
            E = np.zeros((N,N)); E[a,b]=1; E[b,a]=1; B.append(E/np.sqrt(2))
    rows = []
    for E in B:
        ric = R.ricci(n, E).flatten()
        alt = np.array([np.tensordot(E, M) for M in R.lam4_basis(n)])
        rows.append(np.concatenate([ric, alt]))
    A = np.array(rows)                       # (dim Sym2, constraints)
    U, s, Vt = np.linalg.svd(A, full_matrices=True)
    rk = int((s > 1e-9*s[0]).sum())
    ker = U[:, rk:]                          # coefficient vectors of Weyl elements
    basis = []
    for c in ker.T:
        basis.append(sum(ci*Ei for ci, Ei in zip(c, B)))
    return basis

def check_Q_preserves_weyl(n, trials=6, seed=0):
    rng = np.random.default_rng(seed)
    WB = weyl_projector(n)
    print(f"n={n}: dim Weyl = {len(WB)} (expected {n*(n+1)*(n+2)*(n-3)//12})")
    # projector onto Weyl inside Sym^2
    G = np.array([[np.tensordot(A,B) for B in WB] for A in WB])
    Gi = np.linalg.inv(G)
    def proj(X):
        co = np.array([np.tensordot(X, A) for A in WB])
        co = Gi @ co
        return sum(c*A for c,A in zip(co, WB))
    worst_tr = 0.0; worst = 0.0
    for _ in range(trials):
        c = rng.normal(size=len(WB))
        W = sum(ci*A for ci,A in zip(c, WB)); W /= np.linalg.norm(W)
        QW = R.Q(n, W)
        worst = max(worst, np.linalg.norm(QW - proj(QW)))
        worst_tr = max(worst_tr, abs(np.trace(QW)))
    print(f"   max || Q(W) - proj_Weyl Q(W) || over random unit Weyl W: {worst:.3e}")
    print(f"   max |tr Q(W)|                                         : {worst_tr:.3e}")

if __name__ == "__main__":
    for n in [5,6,7,8]:
        check_Q_preserves_weyl(n)

def slack_closed_form(n, N, r):
    return (r / (n * N)) * (4 * (N - r) - n * n)
