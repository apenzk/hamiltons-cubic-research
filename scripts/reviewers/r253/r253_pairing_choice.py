"""r253, claim 1, the sub-question 'is it the same pairing the covariants are
defined with?'.  O(n)-invariance does NOT pin the pairing down: the (2,2) block
sits in the 4-fold tensor power with multiplicity 2, so the invariant symmetric
forms are a multi-parameter family.  Here is a one-parameter family of invariant
pairings for which P is NOT self-adjoint, and the identity fails.
"""
import numpy as np
rng = np.random.default_rng(5); n = 6
def KN(A,B): return (np.einsum('ik,jl->ijkl',A,B)+np.einsum('jl,ik->ijkl',A,B)
                     -np.einsum('il,jk->ijkl',A,B)-np.einsum('jk,il->ijkl',A,B))
def P(X):
    X = 0.25*(X - X.transpose(1,0,2,3) - X.transpose(0,1,3,2) + X.transpose(1,0,3,2))
    X = 0.5*(X + X.transpose(2,3,0,1))
    X = X - (X + X.transpose(0,2,3,1) + X.transpose(0,3,1,2))/3.0
    g = np.eye(n); Ric = np.einsum('ikjk->ij', X); sc = np.trace(Ric); E = Ric - sc/n*g
    X = X - KN(E,g)/(n-2) - sc/(2*n*(n-1))*KN(g,g)
    return 0.5*(X + X.transpose(2,3,0,1))
B = lambda X: X.transpose(0,2,1,3)          # invariant, self-adjoint
ip = lambda A, C: float(np.einsum('abcd,abcd->', A, C))
X = rng.standard_normal((n,)*4); Y = rng.standard_normal((n,)*4)
U = P(rng.standard_normal((n,)*4))
print(f"||P B X - B P X|| / ||P B X|| = "
      f"{np.linalg.norm(P(B(X))-B(P(X)))/np.linalg.norm(P(B(X))):.3e}   (P and B do not commute)")
print("\n  invariant pairing <A,C>_t = <A,C> + t<A,B C>, positive definite for small |t|:")
print("     t       |<P X,U>_t - <X,U>_t| / |<P X,U>_t|")
for t in (0.0, 1e-3, 0.1, 0.5):
    q = lambda A, C: ip(A, C) + t*ip(A, B(C))
    lhs, rhs = q(P(X), U), q(X, U)
    print(f"     {t:<6}  {abs(lhs-rhs)/abs(lhs):.3e}")
print("\n  -- at t = 0 (full contraction) the identity holds; at any t != 0 it")
print("     fails, on a pairing that is still O(n)-invariant and still positive")
print("     definite.  What the identity needs is the pairing for which the")
print("     target is ORTHOGONAL to its complement, which is a choice, not a given.")
