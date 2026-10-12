"""Fast Q(W)=W^2+W^# on Lambda^2 R^n via precomputed so(n) structure constants."""
import numpy as np, itertools

def setup(n):
    pairs = [(i, j) for i in range(n) for j in range(i+1, n)]
    idx = {p: a for a, p in enumerate(pairs)}
    N = len(pairs)
    E = np.zeros((N, n, n))
    for a, (i, j) in enumerate(pairs):
        E[a, i, j] = 1.0; E[a, j, i] = -1.0
    # c[a,b,g] with [E_a,E_b] = sum_g c[a,b,g] E_g   (basis is orthogonal, <E,E>=2)
    c = np.zeros((N, N, N))
    for a in range(N):
        for b in range(N):
            C = E[a] @ E[b] - E[b] @ E[a]
            for g, (i, j) in enumerate(pairs):
                c[a, b, g] = C[i, j]
    return pairs, idx, N, E, c

def sharp(c, R):
    # (R^#)_{ab} = 1/2 c_{a g d} c_{b e z} R_{g e} R_{d z}
    return 0.5 * np.einsum('agd,bez,ge,dz->ab', c, c, R, R, optimize=True)

def Q(c, R):
    return R @ R + sharp(c, R)
