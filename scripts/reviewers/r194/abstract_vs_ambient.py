"""Claim 1: the abstract reading is right, and the ambient one is SOUND BUT
INCOMPLETE -- a sharper statement than "the feasible set moves".

DERIVATION.  Let I_lambda be an isotypic component of Sym^3(Weyl_5), and fix
equivariant phi_1..phi_m : V(lambda) -> I_lambda spanning Hom_G(V(lambda), .).
Every x in I_lambda is uniquely x = sum_i phi_i(y_i).  By Schur every INVARIANT
Hermitian form on I_lambda is

    Phi(x,x) = sum_{ij} G_ij <y_i, y_j>_{V(lambda)},        G Hermitian,

and Phi >= 0  <=>  G >= 0  (take y_i = xi_i v for a fixed unit v; the xi range
over C^m freely).  An SOS certificate for F_5 is exactly F_5(W) = Phi(W^3,W^3)
with Phi >= 0.  The code's c are defined by W^3 = sum_{i,t} c^i_t phi_i(b_t),
so y_i = sum_t c^i_t b_t and <y_i,y_j> = (c^i)^dagger Q c^j with Q the ABSTRACT
Gram of {b_t} in V(lambda).  That is the current text, and it is correct.

"Q read off copy 1" replaces Q by h_11 Q, one positive scalar per block, so
G -> G/h_11: PSD preserved.  Harmless, as the file says.

THE AMBIENT READING, PRICED.  Copy i's ambient pairing is
<phi_i(y), phi_j(y')> = h_ij <y,y'>, so using ambient Grams computes
B'_ij = h_ij B_ij and the true Gram of the certificate is G' o h (Hadamard).
  * Schur product theorem: G' >= 0 and h >= 0  =>  G' o h >= 0.
    So every ambient-feasible G' yields a GENUINE certificate -- SOUND.
  * The converse fails: G >= 0 does not give G (o) h^{-1} >= 0.
    So the ambient route can MISS certificates -- INCOMPLETE.
The error direction therefore matters: the h version can only produce false
NEGATIVES ("no certificate" when one exists), never a false positive.  The
witness below is explicit.
"""
import numpy as np
np.random.seed(194)
m = 3

def psd(X, tol=-1e-9): return np.min(np.linalg.eigvalsh(X)) >= tol
def rnd_psd(m, rank=None):
    r = rank or m
    A = np.random.randn(m, r) + 1j*np.random.randn(m, r)
    return A @ A.conj().T

print("=" * 74)
print("(A) Schur product theorem -- the ambient route is SOUND")
print("=" * 74)
bad = 0
for _ in range(3000):
    h, G = rnd_psd(m), rnd_psd(m)
    if not psd(G * h): bad += 1
print(f"  3000 random PSD pairs (h, G'):  G' o h failed PSD in {bad} of them")

print()
print("=" * 74)
print("(B) the converse FAILS -- the ambient route is INCOMPLETE")
print("=" * 74)
print("  explicit 2x2 witness, multiplicity two, no search needed.")
print("    h = [[1, 1/2], [1/2, 1]]   G = [[1, 9/10], [9/10, 1]]")
print("    G (o) h = [[1, 9/5], [9/5, 1]]")
h2 = np.array([[1.0, 0.5], [0.5, 1.0]])
G2 = np.array([[1.0, 0.9], [0.9, 1.0]])
Q2 = G2 / h2
print(f"    eig(h)       = {np.round(np.linalg.eigvalsh(h2), 4)}   PSD: {psd(h2)}")
print(f"    eig(G)       = {np.round(np.linalg.eigvalsh(G2), 4)}   PSD: {psd(G2)}")
print(f"    eig(G (o) h) = {np.round(np.linalg.eigvalsh(Q2), 4)}   PSD: {psd(Q2)}")
print("  In general for m = 2: G = [[1,g],[g,1]] and h = [[1,t],[t,1]] give")
print("  G (o) h PSD iff |g| <= t.  Any certificate whose copies correlate")
print("  more weakly than its Gram (t < |g| <= 1) is abstract-feasible and")
print("  ambient-infeasible.  Multiplicity two already suffices.")
print("  => the feasible set genuinely moves, and it moves INWARD.")

print()
print("=" * 74)
print("(C) the practical consequence for stage 3")
print("=" * 74)
print("  the two readings differ ONLY when some block has multiplicity >= 2 AND")
print("  its copies are non-orthogonal (h off-diagonal nonzero).  At n=5 the")
print("  block table gives multiplicities 4,4,3 and nine 2s -- twelve blocks of")
print("  multiplicity 1, where h_ii > 0 is a scalar and the readings agree.")
print("  So the dispute is live in exactly 12 of the 24 blocks, carrying")
print("  89 - 12 = 77 of the 89 real unknowns.")
