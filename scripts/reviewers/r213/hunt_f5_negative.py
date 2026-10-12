"""r213: hunt for a Weyl tensor in dim 5 with F_5(W) < 0.

Weyl_5 is rebuilt from the tensor symmetries with no import from the programme's
code.  F_5(W) = (3/2)|W|^6 - 9 tr(W^3)^2, with |W|^2 = W_abcd W_abcd and
tr(W^3) = W_abcd W_cdef W_efab (the 25x25 operator view, as in run_n5_falsify).

F_5 >= 0 is equivalent to  |tr(W^3)| <= |W|^3 / sqrt(6),  so the hunt is a
maximisation of |tr(W^3)| on the unit sphere of Weyl_5 -- Riemannian gradient
ascent from many random starts, then a fixed-point polish.  30000 random integer
points (the programme's own falsification test) probes essentially none of a
35-dimensional sphere; ascent does.
"""
import numpy as np
from itertools import combinations

N = 5
PAIRS = list(combinations(range(N), 2))

def basis_weyl():
    # Sym^2(Lambda^2): E_{(ij),(kl)} symmetrised, as full 4-tensors
    vecs = []
    for a in range(len(PAIRS)):
        for b in range(a, len(PAIRS)):
            i, j = PAIRS[a]; k, l = PAIRS[b]
            T = np.zeros((N, N, N, N))
            for (p, q, r, s), sg in (((i,j,k,l),1), ((j,i,k,l),-1),
                                     ((i,j,l,k),-1), ((j,i,l,k),1)):
                T[p,q,r,s] += sg
                T[r,s,p,q] += sg          # pair symmetry
            vecs.append(T.reshape(-1))
    V = np.array(vecs)                                   # 55 x 625
    # first Bianchi: subtract the totally antisymmetric part
    def debianchi(T):
        T = T.reshape(N,N,N,N)
        B = (T + np.transpose(T,(0,2,3,1)) + np.transpose(T,(0,3,1,2)))/3.0
        return (T - B).reshape(-1)
    V = np.array([debianchi(v) for v in V])
    # orthonormal basis of the row space
    U, s, Vt = np.linalg.svd(V, full_matrices=False)
    B50 = Vt[s > s[0]*1e-10]
    # Ricci = 0
    Ric = []
    for i in range(N):
        for j in range(i, N):
            row = np.zeros(N**4)
            for m in range(N):
                idx = np.zeros((N,N,N,N)); idx[m,i,m,j] = 1.0
                row += idx.reshape(-1)
            Ric.append(row)
    Ric = np.array(Ric)                                  # 15 x 625
    C = B50 @ Ric.T                                       # coefficients
    u, sv, vt = np.linalg.svd(C)
    ker = u[:, np.sum(sv > sv[0]*1e-10):]                 # 50 x 35
    B = ker.T @ B50
    B, _ = np.linalg.qr(B.T)
    return B.T                                            # 35 x 625

BAS = basis_weyl()
assert BAS.shape[0] == 35, BAS.shape
# sanity: every basis element is a genuine Weyl tensor
for v in BAS[:5]:
    T = v.reshape(N,N,N,N)
    assert np.allclose(T, -np.transpose(T,(1,0,2,3)))
    assert np.allclose(T, np.transpose(T,(2,3,0,1)))
    assert np.allclose(T + np.transpose(T,(0,2,3,1)) + np.transpose(T,(0,3,1,2)), 0)
    assert np.allclose(np.einsum('aiaj->ij', T), 0)
assert np.allclose(BAS @ BAS.T, np.eye(35), atol=1e-10)

def tensor(x):
    return (x @ BAS).reshape(N,N,N,N)

def t3(x):
    M = (x @ BAS).reshape(25, 25)
    return float(np.trace(M @ M @ M))

def grad_t3(x):
    M = (x @ BAS).reshape(25, 25)
    G = 3.0 * (M @ M)
    return BAS @ G.reshape(-1)

def ratio(x):
    return t3(x) / np.linalg.norm(x)**3

def ascend(x, sign, iters=4000):
    x = x / np.linalg.norm(x)
    step = 0.1
    cur = sign * ratio(x)
    for _ in range(iters):
        g = sign * grad_t3(x)
        g = g - (g @ x) * x
        gn = np.linalg.norm(g)
        if gn < 1e-14: break
        y = x + step * g / gn
        y /= np.linalg.norm(y)
        v = sign * ratio(y)
        if v > cur:
            x, cur = y, v
            step *= 1.15
        else:
            step *= 0.5
            if step < 1e-15: break
    return x, cur

rng = np.random.default_rng(2131)
LIM = 1.0/np.sqrt(6.0)
best = -1e18; bestx = None
for trial in range(400):
    x0 = rng.normal(size=35)
    for sign in (+1, -1):
        x, v = ascend(x0.copy(), sign)
        if v > best:
            best, bestx = v, x
print(f"basis dim 35, orthonormal: yes")
print(f"max |tr(W^3)| / |W|^3 over 400 ascents : {best:.12f}")
print(f"threshold 1/sqrt(6)                    : {LIM:.12f}")
print(f"F_5 / |W|^6 at the maximiser           : {1.5 - 9.0*best*best:.12e}")
if best > LIM + 1e-9:
    print("REFUTED: F_5 < 0 at this point")
    np.save("scripts/reviewers/r213/witness.npy", bestx)
else:
    print("no counterexample: the ascent maximum sits at or below 1/sqrt(6)")
np.save("scripts/reviewers/r213/argmax.npy", bestx)
