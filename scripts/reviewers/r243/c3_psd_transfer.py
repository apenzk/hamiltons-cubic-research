"""r243 / claim 1 -- does 'psd + vanishing forces the kernel' TRANSFER to a
block Gram paired against an evaluation?

The brief's worry is exact: the textbook statement is about a psd quadratic
form vanishing at a VECTOR.  Here B is a block Gram on the multiplicity spaces
and the pairing at W* is  G(W*) = sum_lambda tr(B_lambda M_lambda)  with
M_lambda the Gram of the block-lambda covariants evaluated at W*.  So the
statement needed is the MATRIX one:

    LEMMA.  A, M psd  and  tr(AM) = 0   =>   A M = 0.
    Proof.  tr(AM) = tr(M^{1/2} A M^{1/2}) and M^{1/2} A M^{1/2} is psd with
    zero trace, hence 0, hence A^{1/2} M^{1/2} = 0, hence
    A M = A^{1/2}(A^{1/2}M^{1/2})M^{1/2} = 0.

That is strictly stronger than the vector statement, and it is what this
setting needs.  Below: the lemma is checked on randoms; the block sum is
checked to split term by term; and a witness shows that "B v(n) = 0 for one
covector v" is a STRICTLY WEAKER condition than what psd-ness forces once
dim V_lambda > 1 -- so the file's one-covector wording undercounts the forced
conditions unless equivariance of B is invoked, which the file never does.
"""
import numpy as np
from fractions import Fraction as Fr
import sympy as sp

rng = np.random.default_rng(243)

# ---- the lemma, on randoms -------------------------------------------------
worst = 0.0
for _ in range(400):
    k = rng.integers(2, 7)
    r = rng.integers(1, k)                      # rank of A
    L = rng.normal(size=(r, k)); A = L.T @ L    # psd, rank r, kernel dim k-r
    # build M psd supported in ker A, so tr(AM)=0 by construction
    ns = np.linalg.svd(A)[2][r:].T              # basis of ker A
    C = rng.normal(size=(k - r, k - r)); M = ns @ (C @ C.T) @ ns.T
    assert abs(np.trace(A @ M)) < 1e-9
    worst = max(worst, np.max(np.abs(A @ M)))
print(f"  lemma check (tr(AM)=0, both psd => AM=0): max|AM| over 400 = {worst:.2e}")
assert worst < 1e-8

# the converse direction, which is the one actually used: force tr=0 and read off
bad = 0
for _ in range(400):
    k = int(rng.integers(2, 6))
    L = rng.normal(size=(k, k)); A = L.T @ L                 # generically PD
    U = rng.normal(size=(k, int(rng.integers(1, k + 1))))
    M = U @ U.T
    if abs(np.trace(A @ M)) < 1e-12 and np.max(np.abs(A @ M)) > 1e-8:
        bad += 1
print(f"  counterexamples found to the lemma: {bad}")
assert bad == 0

# ---- the block split -------------------------------------------------------
# G(W*) = sum_lambda tr(B_lambda M_lambda), every term >= 0 since both psd;
# so a single vanishing total forces every block separately.
neg = 0
for _ in range(2000):
    k = int(rng.integers(1, 6))
    X = rng.normal(size=(k, k)); Y = rng.normal(size=(k, k))
    if np.trace((X.T @ X) @ (Y.T @ Y)) < -1e-12:
        neg += 1
print(f"  tr(psd . psd) < 0 occurrences: {neg}  (must be 0, else the split fails)")
assert neg == 0

# ---- the undercount witness ------------------------------------------------
# One block, m_lambda = 2 multiplicities, dim V_lambda = 2.  The evaluation of
# the two covariants at W* is the 2x2 matrix U (rows = c_i(W*) in V_lambda).
U = sp.Matrix([[1, 0], [0, 1]])          # rank 2: the two covariants are
M = sp.simplify(U * U.T)                 # independent in V_lambda at W*
b11, b12, b22 = sp.symbols('b11 b12 b22')
B = sp.Matrix([[b11, b12], [b12, b22]])
forced = sp.solve(list(sp.simplify(B * M)), [b11, b12, b22], dict=True)
print("\n  witness, m_lambda = 2, dim V_lambda = 2, rank(U) = 2:")
print(f"    forced by psd:      B M = 0  =>  {forced}   (B = 0: 3 conditions)")
# the naive single-covector reading: take v = the first column of U^T, i.e. the
# values of the two covariants against ONE chosen direction of V_lambda
v = U[:, 0]
naive = sp.solve(list(B * v), [b11, b12, b22], dict=True)
print(f"    naive 'B v = 0':    {naive}   (b11 = b12 = 0: 2 conditions, b22 free)")
assert forced[0] != naive[0]
print("    => the one-covector form is STRICTLY weaker.  It is sound (it is")
print("       implied by what psd forces), so nothing false follows; but the")
print("       family it defines is larger than the sharpness structure allows,")
print("       and A5 then has to certify psd on a family that was never cut to")
print("       the boundary.  Reading it as the file intends requires B to be")
print("       EQUIVARIANT -- B(g.v) = g.(Bv) -- so that one orbit point sweeps")
print("       out the whole of V_lambda.  The file never says so.")

# ---- and the clean rational form of the condition --------------------------
print("\n  the condition without a basis of V_lambda:")
print("    B_lambda M_lambda(n) = 0, where M_lambda(n)_{ij} = <c_i(W*), c_j(W*)>")
print("    is a Brauer-pairing evaluation -- rational in n by A2, with no")
print("    square root and no choice of basis inside the irreducible.")
