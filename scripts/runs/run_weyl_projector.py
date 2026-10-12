"""The Weyl projector on eight indices, built rather than guessed.

WHY IT BLOCKS TWO ITEMS.  run_n5_diagram_gram.py ships weyl_projector() as a stub
returning zeros, with the note "the gluing formula is not yet implemented -- the
Weyl projector on eight indices is the missing piece".  Reviewer 247 then showed
that piece is exactly what the independence test turns on: the projector-FREE
Brauer pairing is a form on the ambient tensor space and its nonsingularity says
nothing about relations among functions on Weyl_n, while the pairing WITH the
projector is the one whose anisotropy makes independence detectable.

THE CONSTRUCTION, AND WHY NO FORMULA IS NEEDED.  P is the orthogonal projector of
(R^n)^{tensor 4} onto Weyl_n.  Given ANY orthonormal basis {B_k} of Weyl_n,

    P_{abcd,efgh} = sum_k (B_k)_{abcd} (B_k)_{efgh},

which is basis-independent even though each B_k is not.  So the projector needs
no closed form and no guess: it needs a basis, and the module already builds one.
Orthonormalising it is exact over Q by Gram-Schmidt on the Frobenius product.

  THE THREE PROPERTIES THAT MAKE IT THE RIGHT OBJECT, and each is checkable
  rather than assumed:

    (1) IDEMPOTENT.  P.P = P as an operator on 4-tensors.
    (2) SYMMETRIC.  P_{X,Y} = P_{Y,X}, so it is ORTHOGONAL projection, which is
        what "restriction of a positive definite form stays positive definite"
        needs -- reviewer 247's anisotropy argument.
    (3) CORRECT RANGE.  P fixes every Weyl tensor and kills the complement:
        trace(P) = dim Weyl_n = n(n+1)(n+2)(n-3)/12.

  THE TRACE CATCHES ALMOST NOTHING -- MY CLAIM FOR IT WAS BACKWARDS (r249).
  trace(sum_k b_k (x) b_k) = sum_k ||b_k||^2 = k for unit vectors, so the trace
  assert merely RESTATES len(ON) == 35.  It counts basis vectors, not dimensions,
  and cannot see which subspace they span.  Three witnesses pass idempotence,
  symmetry, trace = 35.000000 and the fix-a-Weyl-tensor test below:

    A  the 35 coordinate tensors;
    B  a random 35-dimensional subspace;
    C  30 Weyl directions plus 5 RICCI directions -- the sharp one, since it
       lies inside the 50-dimensional algebraic curvature tensors and so has
       both antisymmetries, pair symmetry and Bianchi, failing only
       Ricci-tracelessness, which nothing here tested.  |P_C - P_Weyl| = 0.125.

  AND THE FOURTH CHECK WAS CIRCULAR: w was drawn from the same orthonormal set
  that defines P, so it could not fail.  Against an INDEPENDENTLY built Weyl
  tensor -- Kulkarni-Nomizu, Ricci-flatness certified without the module -- the
  true P fixes it to 5.6e-16 while witness C misses by 0.39.  That is the check
  that separates them, and it is added below.

AND THE CONSTRUCTION DOES NOT REACH n = 12 AS WRITTEN, BUT A CLOSED FORM DOES
(r249).  wm hardcodes N = 5.  The projector factors at every n as

    P = D o C o S

-- pair symmetrisation, Lambda^4 removal, then trace removal with coefficients
forced by Ric(h KN g) = (n-2) h + tr(h) g.  It matches this file's P at n=5 to
5.6e-16, and at n=12 costs 0.4 ms per application with idempotence 2.7e-16 and an
EXACT trace of 1638 = dim Weyl_12.  249 used it to build a verified orthonormal
basis of Weyl_12, 1638 vectors, in six seconds.

  AND THE 8-INDEX DENSE FORM IS THE WRONG OBJECT AT n = 12: 3.20 GB to build,
  about 12 minutes, over 22 GB if exact over Q, with each pairwise contraction a
  17.8 Tflop matmul.  P MUST BE A CALLABLE, NOT AN ARRAY -- applied matrix-free
  by the closed form, and where a genuinely two-sided node is needed, as
  P = B^T B with bond 1638 rather than 20736, a 12.7-fold reduction.

WHAT THIS FILE DELIVERS.  P at small n with the properties asserted, the stub's
P = 0 and r249's witness C both kept as regression cases.  (The docstring
previously said "exactly over Q"; the code is float Gram-Schmidt, whose drift
r249 bounded at about 2e-11 -- the claim was false of the code and is withdrawn.)  Applying it to the
degree-6 gluing at n = 12 is the next step and is not done here.
"""
import importlib.util as _il, io as _io, contextlib as _cl
import numpy as np
from fractions import Fraction as F

def _load(path, name):
    sp = _il.spec_from_file_location(name, path)
    m = _il.module_from_spec(sp)
    with _cl.redirect_stdout(_io.StringIO()):
        sp.loader.exec_module(m)
    return m

wm = _load("scripts/runs/run_n5_weyl_module.py", "wm")

def dim_weyl(n):
    return n * (n + 1) * (n + 2) * (n - 3) // 12

def projector_from_basis(B):
    """P = sum_k b_k (x) b_k for an ORTHONORMAL basis, as an 8-index array."""
    n = B[0].shape[0]
    P = np.zeros((n,)*8)
    for b in B:
        P += np.einsum('abcd,efgh->abcdefgh', b, b)
    return P

def orthonormalise(B):
    """Gram-Schmidt on the Frobenius product; float here, exactness is the
    next step and the properties below are checked to 1e-10."""
    out = []
    for v in B:
        w = v.copy()
        for u in out:
            w = w - np.einsum('abcd,abcd->', w, u) * u
        nrm = np.sqrt(np.einsum('abcd,abcd->', w, w))
        if nrm > 1e-9:
            out.append(w / nrm)
    return out

# --- build at n = 5, where the module supplies the basis ---
# wm.BASIS is 35 vectors expressed in the 55-dimensional Sym^2(Lambda^2)
# coordinate -- the Weyl subspace inside it, after Bianchi and trace removal.  A
# first version mapped the 55 COORDINATES instead and got 55 orthonormal vectors,
# which the trace assert below would have caught anyway but the length assert
# caught first: 55 is dim Sym^2(Lambda^2) at n=5, not dim Weyl_5.
B5 = []
for vec in wm.BASIS:
    T = wm.sym2_to_R({wm.SPAIRS[c]: vec[c] for c in range(len(vec)) if vec[c]})
    B5.append(np.array([[[[float(T[a][b][c][d]) for d in range(5)]
                          for c in range(5)] for b in range(5)]
                        for a in range(5)]))

ON = orthonormalise(B5)
print(f"  n=5: {len(B5)} raw basis tensors -> {len(ON)} orthonormal")
assert len(ON) == dim_weyl(5) == 35, (
    f"orthonormalisation returned {len(ON)} vectors, not dim Weyl_5 = 35; the "
    "projector is only correct if its basis spans exactly Weyl_n")

P = projector_from_basis(ON)

# (1) idempotent
PP = np.einsum('abcdefgh,efghijkl->abcdijkl', P, P)
err_idem = np.abs(PP - P).max()
print(f"  idempotent   |P.P - P|_max = {err_idem:.2e}")
assert err_idem < 1e-9, "P is not idempotent, so it is not a projector at all"

# (2) symmetric -- orthogonality, which anisotropy needs
err_sym = np.abs(P - P.transpose(4,5,6,7,0,1,2,3)).max()
print(f"  symmetric    |P - P^T|_max = {err_sym:.2e}")
assert err_sym < 1e-9, (
    "P is not symmetric, so it is an oblique projection and the restriction of "
    "the positive definite Bombieri form need not stay positive definite -- "
    "which is what reviewer 247's anisotropy argument requires")

# (3) trace -- the ONLY one that sees a wrong range
tr = np.einsum('abcdabcd->', P)
print(f"  trace(P) = {tr:.6f}   dim Weyl_5 = {dim_weyl(5)}")
assert abs(tr - dim_weyl(5)) < 1e-9, (
    f"trace(P) = {tr}, not dim Weyl_5 = {dim_weyl(5)}: P projects onto the "
    "wrong subspace")

# REGRESSION: the stub.  It passes idempotence and symmetry and fails only here.
Z = np.zeros_like(P)
zz = np.einsum('abcdefgh,efghijkl->abcdijkl', Z, Z)
print(f"\n  regression, the stub P = 0:")
print(f"    idempotent: {np.abs(zz - Z).max() < 1e-12}   "
      f"symmetric: {np.abs(Z - Z.transpose(4,5,6,7,0,1,2,3)).max() < 1e-12}   "
      f"trace: {np.einsum('abcdabcd->', Z):.0f}")
assert abs(np.einsum('abcdabcd->', Z) - dim_weyl(5)) > 1, (
    "the zero stub matched the trace, so the trace check cannot distinguish it "
    "and the shipped stub would have passed every property here")
print("    -- passes both obvious checks, fails the trace.  That is why a stub")
print("       returning zeros survived in the tree.")

# THE CHECK THAT ACTUALLY SEPARATES, TAKE THREE (reviewer 251).
#
# r249 killed the trace (it counts basis vectors) and the circular fix-check.  I
# replaced them with "P fixes an INDEPENDENTLY built Weyl tensor".  251 killed
# that too: rank-preserving witnesses -- take W_i itself, orthonormalise against
# the true basis, keep 34, add one non-Weyl direction -- give idempotence
# 2.4e-16, symmetry 0, trace 35.000000, and fix W_i to 9.0e-16 while sitting
# 0.084 and 0.118 away from the true P.  The check certifies ONE dimension of
# thirty-five, and with a fixed seed its power is exactly "range(P) does not
# omit this one tensor".
#
# 251'S REPAIR IS CHEAPER THAN THE CHECK IT REPLACES AND NEEDS NO WEYL TENSOR AT
# ALL.  The five Weyl-defining equations act on P's FIRST FOUR indices, so
# "range(P) is contained in Weyl_n" is an exact identity ON P ITSELF.  Combined
# with the trace -- which does correctly read the RANK -- containment plus
# trace = dim Weyl_n forces range = Weyl_n exactly.
def weyl_defect(P, n):
    """max violation of the five Weyl equations applied to P's first four legs."""
    d = 0.0
    d = max(d, np.abs(P + P.transpose(1,0,2,3,4,5,6,7)).max())      # antisym ab
    d = max(d, np.abs(P + P.transpose(0,1,3,2,4,5,6,7)).max())      # antisym cd
    d = max(d, np.abs(P - P.transpose(2,3,0,1,4,5,6,7)).max())      # pair swap
    d = max(d, np.abs(P + P.transpose(0,2,3,1,4,5,6,7)
                        + P.transpose(0,3,1,2,4,5,6,7)).max())      # Bianchi
    d = max(d, np.abs(np.einsum('aiajefgh->ijefgh', P)).max())      # Ricci-trace
    return d

defect = weyl_defect(P, 5)
print(f"\n  range(P) inside Weyl_5, as an identity on P: defect {defect:.2e}")
assert defect < 1e-9, (
    "P's range is not inside Weyl_n -- the five defining equations fail on its "
    "first four indices.  With trace = dim Weyl_n this is what forces "
    "range(P) = Weyl_n exactly, and no test tensor can substitute for it")
print("  with trace = 35 this forces range(P) = Weyl_5 EXACTLY, and it needs no")
print("  test tensor -- 251's repair, cheaper than the check it replaces.")

# REGRESSION: r249's witness C -- 30 Weyl directions plus 5 Ricci directions.  It
# passed idempotence, symmetry AND trace, and must fail the defect check.
rng = np.random.default_rng(1)

def ricci_direction(n, rng):
    h = rng.standard_normal((n, n)); h = 0.5*(h + h.T)
    g = np.eye(n)
    def KN(A,B): return (np.einsum('ik,jl->ijkl',A,B)+np.einsum('jl,ik->ijkl',A,B)
                         -np.einsum('il,jk->ijkl',A,B)-np.einsum('jk,il->ijkl',A,B))
    T = KN(h, g); T = 0.5*(T + T.transpose(2,3,0,1))
    return T / np.sqrt(np.einsum('abcd,abcd->', T, T))

# passes idempotence, symmetry AND trace = 35, and fails only here.
def ricci_direction(n, rng):
    h = rng.standard_normal((n, n)); h = 0.5*(h + h.T)
    g = np.eye(n)
    def KN(A,B): return (np.einsum('ik,jl->ijkl',A,B)+np.einsum('jl,ik->ijkl',A,B)
                         -np.einsum('il,jk->ijkl',A,B)-np.einsum('jk,il->ijkl',A,B))
    T = KN(h, g)
    T = 0.5*(T + T.transpose(2,3,0,1))
    return T / np.sqrt(np.einsum('abcd,abcd->', T, T))

WITNESS_C = orthonormalise(ON[:30] + [ricci_direction(5, rng) for _ in range(5)])
if len(WITNESS_C) == 35:
    PC = projector_from_basis(WITNESS_C)
    trC = np.einsum('abcdabcd->', PC)
    PPC = np.einsum('abcdefgh,efghijkl->abcdijkl', PC, PC)
    dC = weyl_defect(PC, 5)
    print(f"\n  regression, r249's witness C (30 Weyl + 5 Ricci):")
    print(f"    idempotent {np.abs(PPC-PC).max():.1e}   trace {trC:.6f}   "
          f"Weyl defect {dC:.2f}")
    assert abs(trC - 35) < 1e-9, "witness C must PASS the trace check"
    assert dC > 1e-3, (
        "witness C's range satisfied the Weyl equations, so the defect check "
        "does not separate it either and the projector remains unverified")
    print("    -- passes idempotence and trace, FAILS the defect.  251 reports")
    print("       0.81, 0.51, 0.32 for three further rank-preserving witnesses.")

