"""r216, claim 4b, part 4.  The block the route was closed on.

`the tail contains the TRIVIAL block, which no certificate can skip`.  The
trivial block of Sym^3(Weyl_12) has multiplicity 2 -- and its multiplicity space
is the space of CUBIC O(12)-INVARIANTS of the Weyl tensor.  By the first
fundamental theorem for O(n) that space is spanned by complete contractions of
three Weyl tensors with the metric, i.e. by exactly the diagram construction the
commit switches to.  So the one block whose weight space is prohibitive is the
one block where the highest-weight machinery is unnecessary and where the diagram
family's completeness is a THEOREM rather than an obligation.

This file exhibits the two diagrams and shows they are independent, so together
with m_0 = 2 they span the multiplicity space exactly.
"""
import numpy as np
n = 12
rng = np.random.default_rng(216)
g = np.eye(n)

def random_weyl():
    R = rng.standard_normal((n,)*4)
    R = R - R.transpose(1, 0, 2, 3)
    R = R - R.transpose(0, 1, 3, 2)
    R = R + R.transpose(2, 3, 0, 1)
    A = (R + R.transpose(0, 2, 3, 1) + R.transpose(0, 3, 1, 2))/3.0   # R_{a[bcd]}
    R = R - A                                                          # first Bianchi
    Ric = np.einsum('abad->bd', R)
    s = np.trace(Ric)
    W = R.copy()
    W -= (np.einsum('ac,bd->abcd', g, Ric) - np.einsum('ad,bc->abcd', g, Ric)
          - np.einsum('bc,ad->abcd', g, Ric) + np.einsum('bd,ac->abcd', g, Ric))/(n-2)
    W += s*(np.einsum('ac,bd->abcd', g, g) - np.einsum('ad,bc->abcd', g, g))/((n-1)*(n-2))
    return W

W = random_weyl()
print("the projector lands in Weyl_12:")
print(f"  antisymmetry ab   {np.abs(W + W.transpose(1,0,2,3)).max():.2e}")
print(f"  antisymmetry cd   {np.abs(W + W.transpose(0,1,3,2)).max():.2e}")
print(f"  pair swap         {np.abs(W - W.transpose(2,3,0,1)).max():.2e}")
print(f"  first Bianchi     {np.abs(W + W.transpose(0,2,3,1) + W.transpose(0,3,1,2)).max():.2e}")
print(f"  Ricci trace       {np.abs(np.einsum('abad->bd', W)).max():.2e}")

def I1(W): return np.trace(np.linalg.matrix_power(W.reshape(n*n, n*n), 3))
def I2(W): return np.trace(np.linalg.matrix_power(W.transpose(0,2,1,3).reshape(n*n, n*n), 3))

V = np.array([[I1(w), I2(w)] for w in (random_weyl() for _ in range(8))]).T
V = V/np.abs(V).max()
print(f"\nthe two contraction diagrams at 8 random Weyl tensors:")
print(f"  I1 = W_abcd W_cdef W_efab")
print(f"  I2 = W_acbd W_cedf W_eafb")
sv = np.linalg.svd(V, compute_uv=False)
print(f"  singular values of the 2 x 8 value matrix: {sv}")
print(f"  rank {np.sum(sv > 1e-9*sv[0])}  ->  the two diagrams are linearly independent")
print(f"\n  m_0 = 2 from the character, and two independent invariant diagrams:")
print(f"  the trivial multiplicity space is spanned by contraction diagrams, exactly.")

# equivariance guard: an invariant must not move under O(12)
Q, _ = np.linalg.qr(rng.standard_normal((n, n)))
Wr = np.einsum('ai,bj,ck,dl,ijkl->abcd', Q, Q, Q, Q, W)
print(f"\n  under a random O(12) rotation, |I1| relative change "
      f"{abs(I1(Wr)-I1(W))/abs(I1(W)):.2e}, |I2| {abs(I2(Wr)-I2(W))/abs(I2(W)):.2e}")
