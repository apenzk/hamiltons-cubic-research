"""r204 / claim 3.  The 65-24-89 SPLIT IS RIGHT AS A DIMENSION AND WRONG AS A
COORDINATE LABELLING.

run_n5_assemble.py stage 4 builds

    HERM  = all m^2 real Hermitian coordinates per block          (89)
    UNK   = the "re" coordinates                                 (65)
    GAUGE = the "im" off-diagonal coordinates                    (24)

and calls GAUGE "the Lambda^2 part", "in the kernel", "to be quotiented out".

SETUP.  U = Sym^3(Weyl_5) is REAL; U_C its complexification.  An invariant
Hermitian form H on U_C restricts to U x U as h_R = S + iA with S real
symmetric and A real antisymmetric, both O(5)-invariant, and

    q(W) := H(W^3, W^3) = S(W^3, W^3)          because W^3 is REAL.

So ker(H -> q) = {H : S = 0} = i * (Lambda^2 U*)^{O(5)}, of real dimension 24,
and the quotient is (Sym^2 U*)^{O(5)}, of dimension 65.  That is the theorem,
and it is basis-free.

WHICH 24 COORDINATES the kernel occupies in a chosen C-basis of the
multiplicity space M_lambda is NOT basis-free.  Let xi_a be a basis real for
the real structure sigma on M_lambda (it exists: real type).  In THAT basis
the kernel is exactly {i * real antisymmetric} -- the "im" coordinates -- and
the Hermitian multiplicity Gram is h = ||w||^2 * b(xi_a, xi_b), REAL SYMMETRIC.

The code's basis is the Q(i) highest-weight basis, in which h is measured with
NONZERO IMAGINARY OFF-DIAGONALS (r192/r201/r202, lambda = (2,0)).  So the code's
basis is not sigma-real, and the identification of GAUGE with the kernel has no
warrant.  This file proves it fails, in the m = 2 case that was measured.

m = 2 ALGEBRA.  Write the change of basis as Q in GL(2,C): h = Q^dag h_R Q with
h_R real symmetric positive definite, and the kernel direction is
K = i * Q^dag J Q with J = [[0,1],[-1,0]].  Absorbing the Cholesky factor of
h_R into Q (X^T J X = det(X) J for 2x2, so J is only rescaled) we may take
h_R = I.  With Q = A + iB, A, B real:

    K   = i(det A + det B) J  -  S,      S = A^T J B + (A^T J B)^T,
    h   = (A^T A + B^T B) + i(A^T B - B^T A).

K is proportional to the code's GAUGE direction iJ  <=>  S = 0
                                                    <=>  A^T J B is antisymmetric
                                                    <=>  B = a A                (2x2)
                                                    =>   Im h = 0.

CONTRAPOSITIVE: Im h != 0 forces the kernel direction OFF the code's GAUGE
coordinate.  h is measured non-real on lambda = (2,0), so the labelling is
wrong there.  The implication is ONE-WAY: Im h = 0 does not rescue it, and
part 3 exhibits a basis with h = I whose kernel direction is real symmetric,
i.e. sits inside the 65 the code keeps.
"""
import numpy as np, itertools, random
np.set_printoptions(precision=4, suppress=True)
J = np.array([[0, 1], [-1, 0]], dtype=complex)

def kernel_dir(Q):
    """the 1-dim kernel of {invariant Hermitian forms on block lambda} -> quadratic
    forms, expressed in the basis Q maps the sigma-real basis to."""
    return 1j * Q.conj().T @ J @ Q

def gram(Q):
    return Q.conj().T @ Q

def is_prop(M, N, tol=1e-9):
    """M proportional to N by a REAL scalar (the coordinate spaces are real)."""
    n = np.linalg.norm(N)
    c = np.vdot(N, M) / (n * n)
    return abs(c.imag) < tol and np.linalg.norm(M - c.real * N) < tol * max(1, np.linalg.norm(M))

print("=" * 74)
print("1.  SYMBOLIC: S = 0  <=>  B = a A  =>  Im h = 0.  ONE-DIRECTIONAL.")
print("=" * 74)
import sympy as sp
a1,b1,c1,d1,a2,b2,c2,d2 = sp.symbols("a1 b1 c1 d1 a2 b2 c2 d2", real=True)
A = sp.Matrix([[a1,b1],[c1,d1]]); B = sp.Matrix([[a2,b2],[c2,d2]])
Js = sp.Matrix([[0,1],[-1,0]])
M  = A.T*Js*B
S  = sp.simplify(M + M.T)                       # the real symmetric part of K
Imh = sp.simplify(A.T*B - B.T*A)                # the imaginary part of h
print("  S      =", sp.simplify(S[0,0]), ",", sp.simplify(S[0,1]), ",", sp.simplify(S[1,1]))
print("  Im h   =", sp.simplify(Imh[0,1]), "  (antisymmetric, one entry)")
# S = 0 forces B proportional to A (2x2, A invertible): adj(X) = X with X = A^-1 B
X = sp.symbols("x11 x12 x21 x22", real=True)
Xm = sp.Matrix([[X[0],X[1]],[X[2],X[3]]])
cond = sp.simplify(Js*Xm - Xm.T*Js)             # S = 0  <=>  J X = X^T J
print("  S = 0 rewrites as J X = X^T J with X = A^-1 B; that matrix is")
print("   ", cond.tolist(), " -> x12 = x21 = 0 and x11 = x22, i.e. X = a I.")
print("  Then Im h = A^T(aA) - (aA)^T A = 0.  So  S = 0  =>  Im h = 0.")
print("  CONTRAPOSITIVE, which is what the measured block needs:")
print("      Im h != 0  =>  S != 0  =>  the kernel direction is NOT i*J.")
print("  The converse FAILS -- part 3 exhibits Im h = 0 with S != 0.")
sub = {X[0]: sp.Integer(1), X[3]: sp.Integer(1), X[1]: 0, X[2]: 0}
assert cond.subs(sub) == sp.zeros(2,2)

print("\n" + "=" * 74)
print("2.  THE MEASURED BLOCK lambda = (2,0):  h = [[1, 55i/37], [-55i/37, 5075/1628]]")
print("=" * 74)
rng = np.random.default_rng(204)
h = np.array([[1, 55j / 37], [-55j / 37, 5075 / 1628]], dtype=complex)
w, _ = np.linalg.eigh(h)
print(f"  h is Hermitian: {np.allclose(h, h.conj().T)},  eigenvalues {w}, positive definite: {all(w > 0)}")
# every Q with Q^dag Q = h differs by a left unitary; sample many of them.
L = np.linalg.cholesky(h)            # h = L L^dag
best = 1e9
for _ in range(4000):
    X = rng.normal(size=(2, 2)) + 1j * rng.normal(size=(2, 2))
    U, _r = np.linalg.qr(X)          # Haar-ish unitary
    Q = U @ L.conj().T               # Q^dag Q = L L^dag = h
    assert np.allclose(gram(Q), h)
    K = kernel_dir(Q)
    # distance from K to the real span of the code's GAUGE direction iJ
    G = 1j * J
    c = (np.vdot(G, K) / np.vdot(G, G)).real
    best = min(best, np.linalg.norm(K - c * G) / np.linalg.norm(K))
print(f"  over 4000 admissible bases Q with Q^dag Q = h (Q -> UQ, U unitary, is the")
print(f"  whole freedom), the MINIMUM relative distance from the kernel direction to")
print(f"  the code's GAUGE direction i*J is {best:.3f}")
print("  -- and it is never 0.  The code's GAUGE coordinate is NOT in the kernel")
print("  on this block, for ANY basis consistent with the measured h.")
assert best > 0.1

print("\n" + "=" * 74)
print("3.  THE CONVERSE FAILURE: h REAL does not make the labelling right either")
print("=" * 74)
Q = np.diag([1, 1j]).astype(complex)
print(f"  Q = diag(1, i):   h = Q^dag Q = \n{gram(Q).real}   (real, = I)")
K = kernel_dir(Q)
print(f"  kernel direction K = \n{K.real}   (REAL SYMMETRIC)")
print("  so here the kernel sits INSIDE the 65 'UNK' coordinates and the 24")
print("  'GAUGE' coordinates contain none of it: dropping the im coordinates")
print("  keeps a direction that maps to zero, and the surviving 65 parametrise")
print("  only 64 distinct quadratic forms on this block's contribution.")
assert np.allclose(K, K.real) and np.allclose(K, K.T)

print("\n" + "=" * 74)
print("4.  THE SPLIT IS NOT EVEN GAUGE-INVARIANT: rephase one copy by i")
print("=" * 74)
# the pipeline is free to rephase a copy -- nothing in run_n5_assemble.py pins the
# phase of a highest-weight vector.  Every check in that file survives it.
P = np.diag([1, 1j]).astype(complex)
h2 = P.conj().T @ h @ P
print(f"  h            off-diagonal {h[0,1]}")
print(f"  h after v2 -> i v2:  off-diagonal {h2[0,1]}   (now REAL)")
print(f"  still Hermitian: {np.allclose(h2, h2.conj().T)}, det unchanged in modulus: "
      f"{abs(np.linalg.det(h2)):.6f} vs {abs(np.linalg.det(h)):.6f}")
print("  Hermitian assert: passes.  det h != 0: passes.  multi-probe h: passes")
print("  (a uniform rescaling of a copy is consistent across every probe).")
print("  But UNK/GAUGE now name a DIFFERENT 65-dimensional subspace of the 89.")
print("\n  A relabelling that a free phase choice moves cannot be 'the Lambda^2 part'.")
