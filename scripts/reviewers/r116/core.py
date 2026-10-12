import numpy as np, itertools

def so_basis(n):
    """orthonormal basis of so(n) w.r.t. <A,B> = tr(A^T B)/2 ; E_ij for i<j"""
    pairs = [(i,j) for i in range(n) for j in range(i+1,n)]
    B = []
    for (i,j) in pairs:
        X = np.zeros((n,n)); X[i,j]=1.0; X[j,i]=-1.0
        B.append(X)
    return pairs, np.array(B)

def structure(B):
    """C[a,b,c] = <[X_a,X_b],X_c>"""
    N = len(B)
    C = np.zeros((N,N,N))
    for a in range(N):
        for b in range(N):
            M = B[a]@B[b] - B[b]@B[a]
            for c in range(N):
                C[a,b,c] = np.tensordot(M, B[c], axes=([0,1],[0,1]))/2.0
    return C

def sharp(W, C):
    """W#_{ab} = 1/2 sum C_{a g d} C_{b e z} W_{g e} W_{d z}"""
    T = np.einsum('agd,ge->aed', C, W, optimize=True)   # a,e,d
    return 0.5*np.einsum('aed,bdz->ab', T, np.einsum('bez,dz->bed', C, W, optimize=True).transpose(0,2,1), optimize=True)

def sharp2(W,C):
    return 0.5*np.einsum('agd,bez,ge,dz->ab', C,C,W,W, optimize=True)

def Q(W,C):
    return W@W + sharp2(W,C)

def ip(A,B):
    return float(np.sum(A*B))
