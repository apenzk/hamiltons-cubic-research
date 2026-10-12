"""r228, claim 1: are p_1(omega)=0 and p_2(omega)=3/4 actually pinned, and in WHICH
normalisation?

The claim under review (scripts/runs/run_second_kind_moment.py) is
    p_1(omega) = 0                    trace-freeness
    p_2(omega) = (3/4)|W|^2 = 3/4     at a Ricci-flat point
measured only at the balanced sphere product.

DERIVATION (re-done here, not quoted).  The second-kind operator on Sym^2 has the
symmetrised kernel A_{ijkl} = (1/2)(R_{ikjl} + R_{iljk}); for such an operator
    tr A   = sum_{ij} A_{ijij},      tr A^2 = sum_{ijkl} A_{ijkl} A_{klij}.
With a = |R|^2, b = R_{ijkl}R_{iklj}, c = R_{ijkl}R_{iljk}, the first Bianchi identity
contracted against R gives a+b+c = 0 and the pair symmetries give b = c, so b = c = -a/2.
Then
    tr A^2 = (1/4)[ sum R_{ikjl}^2 + 2 sum R_{ikjl}R_{iljk} + sum R_{iljk}^2 ]
           = (1/4)[ a + 2(a/2) + a ] = (3/4) a,
using sum_{ijkl} R_{ikjl}R_{iljk} = -R_{pqrs}R_{psqr} = -c = +a/2.
So tr(Wring^2) = (3/4)|W|^2 for EVERY algebraic curvature tensor -- Bianchi and the pair
symmetries are the whole input.  Ricci-flatness is not used; nor is any symmetry of the
point.  Likewise tr A = sum_{ij} (1/2)(R_{iijj} + R_{ijji}) = -(1/2) sum_{ij} R_{ijij},
which vanishes iff the scalar curvature does -- automatic for a Weyl tensor.

This script tests that at points WITHOUT the sphere product's symmetry.
"""
import numpy as np, itertools
rng = np.random.default_rng(228)

def proj_weyl(A, n):
    R = A - A.transpose(1,0,2,3); R = R - R.transpose(0,1,3,2); R = R + R.transpose(2,3,0,1)
    R = R - (R + R.transpose(1,2,0,3) + R.transpose(2,0,1,3))/3
    g = np.eye(n); Ric = np.einsum('ikjk->ij', R); s = np.trace(Ric); E = Ric - s/n*g
    KN = lambda A,B: (np.einsum('ik,jl->ijkl',A,B)+np.einsum('jl,ik->ijkl',A,B)
                      -np.einsum('il,jk->ijkl',A,B)-np.einsum('jk,il->ijkl',A,B))
    return R - KN(E,g)/(n-2) - s/(2*n*(n-1))*KN(g,g)

def proj_acurv(A, n):
    """an algebraic curvature tensor WITHOUT removing the Ricci part -- to expose the
    (n-1)^2 lambdabar^2 correction the stored references carry."""
    R = A - A.transpose(1,0,2,3); R = R - R.transpose(0,1,3,2); R = R + R.transpose(2,3,0,1)
    return R - (R + R.transpose(1,2,0,3) + R.transpose(2,0,1,3))/3

def pairs(n): return list(itertools.combinations(range(n), 2))

def toM(W, n):
    pr = pairs(n); return np.array([[W[i,j,k,l] for (k,l) in pr] for (i,j) in pr])

def from_lam2(M, n):
    """rebuild the 4-tensor from its Lambda^2 matrix (used for the padded CP^2)."""
    pr = pairs(n); pos = {p: a for a, p in enumerate(pr)}
    W = np.zeros((n,n,n,n))
    for (i,j) in pr:
        for (k,l) in pr:
            v = M[pos[(i,j)], pos[(k,l)]]
            for (a,b,sa) in ((i,j,1),(j,i,-1)):
                for (c,d,sc) in ((k,l,1),(l,k,-1)):
                    W[a,b,c,d] = sa*sc*v
    return W

def ring_sym2(W, n):
    """Wring on ALL of Sym^2, repo convention (W_{iklj}), orthonormal basis."""
    idx = [(i,j) for i in range(n) for j in range(i,n)]
    def bs(i,j):
        h = np.zeros((n,n))
        if i == j: h[i,i] = 1
        else: h[i,j] = h[j,i] = 1/np.sqrt(2)
        return h
    B = [bs(i,j) for (i,j) in idx]; m = len(idx); Op = np.zeros((m,m))
    for a,h in enumerate(B):
        Wh = np.einsum('iklj,kl->ij', W, h)
        for b,hb in enumerate(B): Op[a,b] = np.sum(Wh*hb)
    return Op

def ring_sym20(W, n):
    """the same operator restricted to Sym^2_0 (dimension n(n+1)/2 - 1)."""
    Op = ring_sym2(W, n)
    idx = [(i,j) for i in range(n) for j in range(i,n)]
    gv = np.array([1.0 if i == j else 0.0 for (i,j) in idx]); gv /= np.linalg.norm(gv)
    P = np.eye(len(idx)) - np.outer(gv, gv)
    Bas = np.linalg.svd(P)[0][:, :len(idx)-1]
    return Bas.T @ Op @ Bas

def sphere_product(p, q, n):
    Lam = np.zeros((n,n)); b = 1.0; a1 = -q*b/(p-1); a2 = -p*b/(q-1)
    for i in range(n):
        for j in range(n):
            if i != j: Lam[i,j] = a1 if (i<p and j<p) else a2 if (i>=p and j>=p) else b
    I = np.eye(n)
    return -(np.einsum('ij,ik,jl->ijkl',Lam,I,I) - np.einsum('ij,il,jk->ijkl',Lam,I,I))

def cp2_padded(n):
    """the padded CP^2 Weyl tensor: diag(2,-1,-1) on Lambda^+(R^4) inside Lambda^2(R^n)."""
    pr = pairs(n); K = len(pr)
    def bi(i,j,s,k,l,t):
        v = np.zeros(K); v[pr.index((i,j))] = s; v[pr.index((k,l))] = t
        return v/np.linalg.norm(v)
    plus = [bi(0,1,1,2,3,1), bi(0,2,1,1,3,-1), bi(0,3,1,1,2,1)]
    D = 2*np.outer(plus[0],plus[0]) - np.outer(plus[1],plus[1]) - np.outer(plus[2],plus[2])
    return from_lam2(D, n)

def theta0(n): return np.sqrt(2*(n-1)*(n-2))/n

def report(label, W, n):
    ric = np.abs(np.einsum('ikjk->ij', W)).max()
    bia = np.abs(W + W.transpose(1,2,0,3) + W.transpose(2,0,1,3)).max()
    W1 = W/np.sqrt(np.einsum('ijkl,ijkl', W, W))            # |W| = 1
    om2 = np.linalg.eigvalsh(ring_sym2(W1, n))              # on all of Sym^2
    om0 = np.linalg.eigvalsh(ring_sym20(W1, n))             # on Sym^2_0
    M = toM(W1, n)
    p1, p2, p3 = om0.sum(), (om0**2).sum(), (om0**3).sum()
    mu = -om0.min()
    print(f"{label:26s} n={n:3d} Ric={ric:7.1e} Bia={bia:7.1e} | |M|_F^2/|W|^2={np.linalg.norm(M)**2:8.5f} "
          f"| p1={p1:+9.2e} p2(Sym2_0)={p2:.9f} p2(Sym2)={(om2**2).sum():.9f} "
          f"| p3={p3:+.6f} mu={mu:.6f} cap={n*theta0(n)/(n-1)/2:.6f}")
    return p1, p2, p3, mu

print("=== all quantities at the |W| = 1 normalisation; 'cap' is the projection")
print("=== estimate n*theta_0(n)/(n-1) rescaled to |W|=1 (i.e. divided by 2)\n")
for n in (6, 8, 12):
    report(f"S^{n//2}xS^{n//2} balanced", sphere_product(n//2, n//2, n), n)
for (p,q) in ((2,4),(3,5),(2,6),(4,8)):
    n = p+q; report(f"S^{p}xS^{q} UNbalanced", sphere_product(p,q,n), n)
for n in (6, 8, 12):
    report("padded CP^2", cp2_padded(n), n)
for n in (5, 6, 7, 8, 9):
    for t in range(3):
        report(f"random Weyl #{t}", proj_weyl(rng.standard_normal((n,n,n,n)), n), n)

print("\n=== PLANTED VIOLATIONS -- these must FIRE ===")
n = 6
# (a) an algebraic curvature tensor with Ricci part kept: p_2 must MISS 3/4 by exactly
#     (n-1)^2 lambdabar^2 measured on Sym^2_0, and p_1 must be non-zero.
R = proj_acurv(rng.standard_normal((n,n,n,n)), n)
R1 = R/np.sqrt(np.einsum('ijkl,ijkl', R, R))
om0 = np.linalg.eigvalsh(ring_sym20(R1, n)); om2 = np.linalg.eigvalsh(ring_sym2(R1, n))
Ric = np.einsum('ikjk->ij', R1); s = np.trace(Ric)
print(f"  (a) non-Ricci-flat R: p_1(Sym2_0)={om0.sum():+.6f} (should be nonzero), "
      f"p_2(Sym2_0)={(om0**2).sum():.6f}, p_2(Sym2)={(om2**2).sum():.6f} vs 3/4")
print(f"      Ricci not zero: max|Ric|={np.abs(Ric).max():.4f}, this is the term the")
print(f"      references' -(n-1)^2 lambdabar^2 accounts for at Einstein points.")
# (b) break Bianchi: take a random pair-symmetric, doubly-antisymmetric tensor with no
#     Bianchi and check tr(A^2) != (3/4)|R|^2.
A = rng.standard_normal((n,n,n,n))
B = A - A.transpose(1,0,2,3); B = B - B.transpose(0,1,3,2); B = B + B.transpose(2,3,0,1)
B1 = B/np.sqrt(np.einsum('ijkl,ijkl', B, B))
bia = np.abs(B1 + B1.transpose(1,2,0,3) + B1.transpose(2,0,1,3)).max()
print(f"  (b) Bianchi BROKEN (residual {bia:.3f}): p_2(Sym2)={(np.linalg.eigvalsh(ring_sym2(B1,n))**2).sum():.6f}"
      f" vs 3/4 -- the identity is Bianchi's, and drops out without it")
# (c) wrong normalisation: |M|_F = 1 instead of |W| = 1
W = sphere_product(3, 3, 6); M = toM(W, 6); W2 = W/np.linalg.norm(M)
om = np.linalg.eigvalsh(ring_sym20(W2, 6))
print(f"  (c) |M|_F=1 normalisation at S^3xS^3: p_2={(om**2).sum():.6f}, p_3={(om**3).sum():+.6f}, "
      f"mu={-om.min():.6f} -- p_2 is 3, NOT 3/4")
