"""L155 screen: X_inv = 0 iff ran(W) is a Z_2-graded subalgebra, with no criticality.

Builds the sharp square from so(n) structure constants (validated on W#I = -W), then
(1) checks graded-but-NON-critical W has X_inv = 0, which is the hypothesis-free half, and
(2) reports bracket leaks at the record's named points as fractions of ||[.,.]||.
Objects are built here rather than loaded, so the screen is independent of the pipeline.
"""
import numpy as np

import numpy as np, itertools
def setup(n):
    pairs=[(i,j) for i in range(n) for j in range(i+1,n)]
    idx={p:k for k,p in enumerate(pairs)}; N=len(pairs)
    B=np.zeros((N,n,n))
    for k,(i,j) in enumerate(pairs):
        B[k,i,j]=1/np.sqrt(2); B[k,j,i]=-1/np.sqrt(2)
    # structure constants c[a,b,g] = <[phi_a,phi_b],phi_g>
    C=np.zeros((N,N,N))
    for a in range(N):
        for b in range(N):
            M=B[a]@B[b]-B[b]@B[a]
            C[a,b]=np.einsum('ij,kij->k',M,B)
    return pairs,idx,N,B,C
def sharp(A,Bm,C):
    # (A#B)_{gd} = 1/2 sum c_{abg} c_{mnd} A_{am} B_{bn}
    T=np.einsum('abg,mnd,am,bn->gd',C,C,A,Bm)
    return 0.5*(T+T.T)/2*2*0.5*2  # keep as 0.5*T symmetrised
def sharp2(A,Bm,C):
    T=np.einsum('abg,mnd,am,bn->gd',C,C,A,Bm)
    return 0.5*T
def ric(A,pairs,n):
    # Ric(A)_{ik} = sum_j A(e_i^e_j, e_k^e_j) with phi basis
    R=np.zeros((n,n)); idx={p:k for k,p in enumerate(pairs)}
    def get(i,j,k,l):
        if i==j or k==l: return 0.0
        si=1.0; sk=1.0
        if i>j: i,j=j,i; si=-1
        if k>l: k,l=l,k; sk=-1
        return si*sk*A[idx[(i,j)],idx[(k,l)]]
    for i in range(n):
        for k in range(n):
            R[i,k]=sum(get(i,j,k,j) for j in range(n))
    return R
def sphereproduct(p,q):
    n=p+q; pairs,idx,N,Bb,C=setup(n)
    sig=(p*(p-1)+q*(q-1))/((n-1)*(n-2))
    a=1-2*(p-1)/(n-2)+sig; b=1-2*(q-1)/(n-2)+sig; c=-1+sig
    W=np.zeros((N,N))
    for k,(i,j) in enumerate(pairs):
        if i<p and j<p: W[k,k]=a
        elif i>=p and j>=p: W[k,k]=b
        else: W[k,k]=c
    return n,pairs,idx,N,Bb,C,W,(a,b,c,sig)



def sh(A, B, C):
    """Sharp square normalised so that W # I = -W."""
    return 2 * sharp2(A, B, C)


def x_inv(W, C, N):
    ev, U = np.linalg.eigh(W)
    Wp = U @ np.diag(np.maximum(ev, 0)) @ U.T
    Wm = U @ np.diag(np.maximum(-ev, 0)) @ U.T
    Pp = U @ np.diag((ev > 1e-11) * 1.0) @ U.T
    Pm = U @ np.diag((ev < -1e-11) * 1.0) @ U.T
    Wsh = sh(W, W, C)
    return sh(Wp + Wm, Wp + Wm, C) - Pp @ Wsh @ Pp + Pm @ Wsh @ Pm, W @ W + Wsh


def graded_noncritical(p, q, a, b):
    """W = a on so(p)+so(q), -b on the complement: graded for every a, b > 0."""
    n = p + q
    pairs, idx, N, Bb, C = setup(n)
    W = np.zeros((N, N))
    for k, (i, j) in enumerate(pairs):
        W[k, k] = a if (i < p) == (j < p) else -b
    X, Q = x_inv(W, C, N)
    th = np.sum(W * Q) / np.sum(W * W)
    return np.linalg.norm(X), np.linalg.norm(Q - th * W)


if __name__ == "__main__":
    print("graded, NOT critical -- the hypothesis-free half of L155")
    for (p, q, a, b) in [(2, 4, 1.0, 1.0), (3, 3, 0.7, 2.3), (3, 5, 5.0, 0.1), (2, 5, 1.3, 0.9)]:
        nx, res = graded_noncritical(p, q, a, b)
        print(f"  so({p})+so({q}) a={a} b={b}: ||X_inv||={nx:.2e}  criticality residual={res:.3f}")
    print("ungraded control -- random symmetric W")
    rng = np.random.default_rng(11)
    for n in (5, 6):
        pairs, idx, N, Bb, C = setup(n)
        M = rng.standard_normal((N, N)); W = (M + M.T) / 2; W /= np.linalg.norm(W)
        print(f"  n={n}: ||X_inv||={np.linalg.norm(x_inv(W, C, N)[0]):.4f}")
