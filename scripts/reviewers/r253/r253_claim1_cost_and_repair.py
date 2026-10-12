"""r253, claim 1 continued: the construction's motivation, and the direct route.

The file's reason for the U-trick is that the projector's "dense 8-index form at
n = 12 is 3.20 GB".  That is the cost of forming P as an OPERATOR.  The test
never needs the operator -- it needs P APPLIED TO TENSORS, which is what the
file's own weyl_random already does in O(n^5).  Measured here, with the direct
route run on the same three carriers as the eps-witness.
"""
import numpy as np, time
rng = np.random.default_rng(11)

def KN(A,B): return (np.einsum('ik,jl->ijkl',A,B)+np.einsum('jl,ik->ijkl',A,B)
                     -np.einsum('il,jk->ijkl',A,B)-np.einsum('jk,il->ijkl',A,B))
def P_weyl(X, n):
    X = 0.25*(X - X.transpose(1,0,2,3) - X.transpose(0,1,3,2) + X.transpose(1,0,3,2))
    X = 0.5*(X + X.transpose(2,3,0,1))
    X = X - (X + X.transpose(0,2,3,1) + X.transpose(0,3,1,2))/3.0
    g = np.eye(n); Ric = np.einsum('ikjk->ij', X); sc = np.trace(Ric); E = Ric - sc/n*g
    X = X - KN(E,g)/(n-2) - sc/(2*n*(n-1))*KN(g,g)
    return 0.5*(X + X.transpose(2,3,0,1))
def weyl_random(n, rng):
    R = rng.standard_normal((n,)*4)
    R = 0.25*(R - R.transpose(1,0,2,3) - R.transpose(0,1,3,2) + R.transpose(1,0,3,2))
    return P_weyl(0.5*(R + R.transpose(2,3,0,1)), n)

n = 12
print(f"cost of the object the file says it is avoiding, at n = {n}:")
print(f"   dense 8-index operator: {n**8} entries = {n**8*8/2**30:.2f} GB")
W = weyl_random(n, rng)
t = time.time(); [P_weyl(W, n) for _ in range(20)]; dt = (time.time()-t)/20
print(f"   P applied to ONE n^4 tensor: {dt*1e3:.1f} ms, {n**4*8/2**20:.2f} MB")
print("   -- the test only ever needs the second.\n")

D1 = lambda W: np.einsum('abef,cdgh,efgh->abcd', W, W, W)
D2 = lambda W: np.einsum('aecf,bgdh,egfh->abcd', W, W, W)
I1 = lambda W: float(np.einsum('abcd,cdef,efab->', W, W, W))
D3 = lambda W, n: D1(W) + np.einsum('ab,cd->abcd', np.eye(n), np.eye(n))*I1(W)

print("the DIRECT route on the same three carriers (F_3 = F_1, true rank 2):")
for n in (8, 12):
    t = time.time()
    rows = []
    for _ in range(6):
        W = weyl_random(n, rng)
        rows.append([P_weyl(D(W), n).ravel() for D in
                     (D1, D2, lambda W: D3(W, n))])
    M = np.array([np.concatenate([r[c] for r in rows]) for c in range(3)])
    sv = np.linalg.svd(M, compute_uv=False)
    r = int((sv > sv[0]*1e-10).sum())
    print(f"   n={n:>3}  rank {r}   sv = {sv[0]:.3e}, {sv[1]:.2e}, {sv[2]:.2e}"
          f"   ({time.time()-t:.2f} s, no test tensors, no eps)")
print("   -- same answer as the exact-U run, with no U to misalign.")
