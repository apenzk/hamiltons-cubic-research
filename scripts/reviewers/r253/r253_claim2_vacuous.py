"""r253, claim 2: is the degree-2 validation vacuous?

The file asserts rank 1 "because Weyl_n is O(n)-irreducible".  Three things are
established here:

  (A) the three carriers are POINTWISE proportional on any tensor with the
      Riemann symmetries -- pair symmetry gives c3 = c1 and the first Bianchi
      identity gives c2 = c1/2.  Neither uses tracelessness, so rank 1 survives
      on Riemann tensors that are NOT in Weyl_n and on n < 5 where Weyl_n is
      not O(n)-irreducible.  The measured 1 is an identity of the symmetries.

  (B) a WRONG evaluation scheme -- one that reads only the DEGREE of a diagram
      and discards its index matching entirely -- reproduces both of the file's
      checks: rank 1 on the three degree-2 carriers AND rank 2 on the
      quadratic-versus-quartic control.

  (C) the control that does catch it: two carriers of the SAME degree that are
      independent as functions on Weyl_n.
"""
import numpy as np

def riemann_random(n, rng, traceless):
    R = rng.standard_normal((n, n, n, n))
    R = 0.25*(R - R.transpose(1,0,2,3) - R.transpose(0,1,3,2) + R.transpose(1,0,3,2))
    R = 0.5*(R + R.transpose(2,3,0,1))
    R = R - (R + R.transpose(0,2,3,1) + R.transpose(0,3,1,2))/3.0
    if not traceless:
        return R
    g = np.eye(n)
    Ric = np.einsum('ikjk->ij', R); sc = np.trace(Ric); E = Ric - sc/n*g
    def KN(A,B): return (np.einsum('ik,jl->ijkl',A,B)+np.einsum('jl,ik->ijkl',A,B)
                         -np.einsum('il,jk->ijkl',A,B)-np.einsum('jk,il->ijkl',A,B))
    W = R - KN(E,g)/(n-2) - sc/(2*n*(n-1))*KN(g,g)
    return 0.5*(W + W.transpose(2,3,0,1))

CARRIERS = [lambda W: np.einsum('abcd,abcd->', W, W),
            lambda W: np.einsum('abcd,acbd->', W, W),
            lambda W: np.einsum('abcd,cdab->', W, W)]

def rank_of(carriers, tensors):
    M = np.array([[c(T) for c in carriers] for T in tensors])
    sv = np.linalg.svd(M, compute_uv=False)
    return int((sv > sv[0]*1e-10).sum()), sv

print("(A)  the rank-1 result is a POINTWISE identity, not irreducibility")
rng = np.random.default_rng(0)
for n in (4, 5, 6, 12):
    for traceless in (True, False):
        if n == 4 and traceless: continue
        Ts = [riemann_random(n, rng, traceless) for _ in range(12)]
        r, sv = rank_of(CARRIERS, Ts)
        ratios = [np.array([c(T) for c in CARRIERS])/CARRIERS[0](T) for T in Ts[:1]]
        lab = "Weyl (traceless)" if traceless else "Riemann (traces intact)"
        print(f"   n={n:>3}  {lab:<24} rank {r}   column ratios {np.round(ratios[0],9)}")
print("   -- c3/c1 = 1 by pair symmetry, c2/c1 = 1/2 by the first Bianchi identity.")
print("   Rank 1 holds on Riemann tensors, which are NOT in Weyl_n, and at n = 4,")
print("   where Weyl_n is not O(n)-irreducible.  The validation cannot see the")
print("   property it says it is testing.\n")

print("(B)  a WRONG evaluation scheme passing BOTH of the file's checks")
print("   S(D)(W) := ||W||^(2*deg D) -- reads the degree, discards the diagram.")
DEG = {id(CARRIERS[0]): 1, id(CARRIERS[1]): 1, id(CARRIERS[2]): 1}
def S(deg):
    return lambda W: float(np.einsum('abcd,abcd->', W, W))**deg
WRONG3 = [S(1), S(1), S(1)]
Ts = [riemann_random(6, rng, True) for _ in range(12)]
r, sv = rank_of(WRONG3, Ts)
print(f"   check 1, the three degree-2 carriers under S: rank {r}  "
      f"(file demands 1, asserts on it)")
WRONG_CTRL = [S(1), S(2)]
r2, _ = rank_of(WRONG_CTRL, Ts)
print(f"   check 2, the quadratic-vs-quartic control under S: rank {r2}  "
      f"(file demands 2, asserts on it)")
print("   Both asserts pass.  S is wrong in the way that matters at n = 12: it")
print("   returns rank 1 for ANY set of same-degree carriers, so it would report")
print("   the 184 degree-3 covariants as spanning ONE dimension.\n")

print("(C)  the control that catches S: two SAME-degree independent invariants")
def I1(W): return np.einsum('abcd,cdef,efab->', W, W, W)
def I2(W): return np.einsum('abcd,aecf,bedf->', W, W, W)
for n in (6, 8, 12):
    Ts = [riemann_random(n, rng, True) for _ in range(12)]
    r, sv = rank_of([I1, I2], Ts)
    rw, _ = rank_of([S(3), S(3)], Ts)
    print(f"   n={n:>3}  true scheme on two degree-3 invariants: rank {r}   "
          f"wrong scheme S: rank {rw}")
print("   -- varying the DEGREE tests degree-sensitivity; only varying the")
print("      DIAGRAM at fixed degree tests what the n=12 run depends on.")
