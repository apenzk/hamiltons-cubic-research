"""r247 claim 2: is det M(n) one polynomial?  The diagram SET, examined.

The commit says: "M(n) is 184 x 184 ... so det M(n) is a single univariate
polynomial and independence at every n >= 12 is one Sturm question."

Three findings, in increasing severity.

A. THE COMBINATORIAL SET IS n-INDEPENDENT -- that much is right.  A contraction
   diagram on 12 Weyl legs with f of them free is a combinatorial object; only
   its EVALUATION sees n.  So the brief's worry, that the spanning set itself
   varies with n, does not bite at the level of the diagrams.

B. BUT NO SUCH SET EXISTS YET, AND THE 184 x 184 SHAPE PRESUPPOSES A BASIS.
   run_n24_via_diagrams.py's own last line: "OWED: the current construction
   emits VECTORS in a weight space, not diagrams."  And a 184 x 184 Gram is the
   Gram of a set ALREADY CUT TO A BASIS -- the file says so itself ("nonsingularity
   is its specialisation to a set already cut to a basis, which is what the 184
   are meant to be").  Cutting a spanning set to a basis IS the independence
   problem.  The reduction therefore offers det M(n) != 0 as the proof of a fact
   it must already possess to write M(n) down.

C. WITH A GENUINE SPANNING SET, det M(n) IS IDENTICALLY ZERO.  Demonstrated
   below at degree 2, where the whole invariant space is one-dimensional and the
   three natural diagrams give a 3 x 3 Gram of rank 1 at every n.  So the Sturm
   question is vacuous unless the basis has already been found, and the honest
   formulation -- rank 184 for all n -- is a statement about every 184 x 184
   minor of a much larger matrix, not about one polynomial.

D. AND IF THE PADDING LEMMA HOLDS, THE n-RANGE IS ALREADY SETTLED WITHOUT ANY
   POLYNOMIAL.  Verified below.
"""
import itertools, numpy as np
from math import comb, factorial

print(__doc__)
print("=" * 72)
print("A.  the size of the selection problem.")
m12 = factorial(12) // (factorial(6) * 2**6)
print(f"   perfect matchings on the 12 Weyl legs of a degree-3 diagram: {m12:,}")
print(f"   (that is the f = 0 block alone; blocks with free indices and bare")
print(f"    metrics add more).  The certificate needs 184 of them, one per")
print(f"    multiplicity, chosen so that the chosen set is INDEPENDENT.")
print(f"   subsets of size 184 to choose from, f=0 block scale: C({m12}, k)")
assert m12 == 10395

print()
print("=" * 72)
print("C.  a genuine spanning set makes det M(n) identically zero.")
print("   Degree 2 on Weyl_n: the invariant space is spanned by |W|^2 alone.")
print("   Three natural reduced/near-reduced diagrams:")
print("     A = W_abcd W_abcd,  C = W_abcd W_acbd,  T = W_abab W_cdcd")

def weyl_basis(n):
    d = n * (n + 1) * (n + 2) * (n - 3) // 12
    rng = np.random.default_rng(2470 + n)
    g = np.eye(n)
    cols = []
    while len(cols) < d:
        h1 = rng.standard_normal((n, n)); h1 = h1 + h1.T
        h2 = rng.standard_normal((n, n)); h2 = h2 + h2.T
        R = (np.einsum('ac,bd->abcd', h1, h2) + np.einsum('bd,ac->abcd', h1, h2)
             - np.einsum('ad,bc->abcd', h1, h2) - np.einsum('bc,ad->abcd', h1, h2))
        Ric = np.einsum('acbc->ab', R); scal = np.trace(Ric)
        P = (Ric - scal / (2 * (n - 1)) * g) / (n - 2)
        PoG = (np.einsum('ac,bd->abcd', P, g) + np.einsum('bd,ac->abcd', P, g)
               - np.einsum('ad,bc->abcd', P, g) - np.einsum('bc,ad->abcd', P, g))
        v = (R - PoG).reshape(-1)
        for u in cols:
            v = v - (u @ v) * u
        if np.linalg.norm(v) > 1e-8:
            cols.append(v / np.linalg.norm(v))
    return np.array(cols), d

for n in (6, 7, 8):
    B, d = weyl_basis(n)
    Bt = B.reshape((-1,) + (n,) * 4)
    # the three quadratic forms restricted to Weyl_n, as d x d matrices
    MA = np.einsum('iabcd,jabcd->ij', Bt, Bt)
    MC = np.einsum('iabcd,jacbd->ij', Bt, Bt)
    MT = np.einsum('iabab,jcdcd->ij', Bt, Bt)
    G = np.array([[np.einsum('ij,ij->', X, Y) for Y in (MA, MC, MT)]
                  for X in (MA, MC, MT)])
    r = np.linalg.matrix_rank(G, tol=1e-8)
    print(f"   n={n}: 3x3 spanning-set Gram rank = {r}, det = {np.linalg.det(G):.3e}"
          f"   (dim of the degree-2 invariant space = 1)")
    assert r == 1, f"n={n}: expected rank 1, got {r}"

print("   => det is 0 at every n.  A spanning set that is not a basis makes the")
print("      determinant vanish identically, so 'det M(n) != 0 on [12, inf)' is")
print("      only a question once the basis is in hand.")

print()
print("=" * 72)
print("D.  the padding lemma: independence at n = 12 already gives every n >= 12.")
print("   Weyl_n sits inside Weyl_{n'} by zero-padding (traces over the extra")
print("   directions vanish, first Bianchi is untouched), and a REDUCED diagram")
print("   takes the same value on a padded tensor as on the original -- no free")
print("   loop supplies a factor of n.  Checked on a degree-3 diagram:")

def pad(W, n, np_):
    Z = np.zeros((np_,) * 4)
    Z[:n, :n, :n, :n] = W
    return Z

B6, _ = weyl_basis(6)
W6 = (B6[0] + 0.7 * B6[3] - 1.3 * B6[7]).reshape((6,) * 4)
I3 = lambda W: float(np.einsum('abcd,cdef,efab->', W, W, W))
base = I3(W6)
for np_ in (7, 8, 9, 12, 13):
    Wp = pad(W6, 6, np_)
    ric = np.einsum('acbc->ab', Wp)
    assert np.abs(ric).max() < 1e-9, f"padded tensor is not trace-free at n={np_}"
    v = I3(Wp)
    assert abs(v - base) < 1e-8 * max(1.0, abs(base)), (
        f"the diagram value moved on padding to n={np_}: {v} vs {base}")
    print(f"   n' = {np_:>2}: padded tensor still trace-free, I_3 = {v:.10f}"
          f"  (unchanged)")

print()
print("   So if  sum x_c J_c = 0  as functions on Weyl_{n'},  restricting to the")
print("   padded copy gives  sum x_c J_c = 0  on Weyl_12.  Independence at 12")
print("   therefore implies independence at every n >= 12, WITHOUT any polynomial")
print("   and without Sturm.  This is step 2 of run_n24_via_diagrams.py, already")
print("   in the record.  Either that step is right -- and the Sturm framing buys")
print("   nothing over the n=12 statement -- or it is wrong, and the n=24 reuse")
print("   claim that fence-posts.md rests on falls with it.")
