import numpy as np
from weyl import build_structure_constants

def Rsharp_full(Rmat, c):
    """Basis-free formula: (R#)_{ab} = -1/2 tr(A_a R A_b R), A_a[m,n]=c[a,m,n].
    Returns the FULL NxN matrix (R#), valid for any self-adjoint R (not just diagonal)."""
    N = Rmat.shape[0]
    # S_a = A_a @ R  (N x N x N): S[a,m,p] = sum_n c[a,m,n] R[n,p]
    S = np.einsum('amn,np->amp', c, Rmat, optimize=True)
    # (R#)_{ab} = -1/2 sum_{m,p} S[a,m,p] S[b,p,m]
    Rsharp = -0.5*np.einsum('amp,bpm->ab', S, S, optimize=True)
    return Rsharp

def Q_full(Rmat, c):
    return Rmat @ Rmat + Rsharp_full(Rmat, c)

if __name__ == "__main__":
    n = 8
    idx, pos, N, c = build_structure_constants(n)

    # Test 1: coordinate-diagonal W*, check Q(W*) proportional to W*
    p=4;q=4
    x=1.0/(p*(p-1)); y=1.0/(q*(q-1)); z=-1.0/(p*q)
    lam = np.zeros(N)
    for a,(i,j) in enumerate(idx):
        if i<p and j<p: lam[a]=x
        elif i>=p and j>=p: lam[a]=y
        else: lam[a]=z
    Wmat = np.diag(lam)
    Q = Q_full(Wmat, c)
    ratio = np.diag(Q)/lam
    print("Q(W*)/W* diag ratios:", sorted(set(np.round(ratio,8))))
    print("offdiag norm of Q(W*):", np.linalg.norm(Q-np.diag(np.diag(Q))))

    # Test 2: full trilinear symmetry on random diagonal-coordinate lambdas (sanity, matches old formula)
    np.random.seed(1)
    lam2 = np.random.randn(N); lam2 -= lam2.mean()
    R2 = np.diag(lam2)
    Q2 = Q_full(R2, c)
    P2 = np.sum(lam2 * np.diag(Q2))
    print("P via new Rsharp_full (coordinate-diagonal random):", P2)
    print("expected (verify3.py, correct-normalization = old/2 on sharp part... recompute):")
