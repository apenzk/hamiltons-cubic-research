"""Claim 3: is F_5 = 3/2 q^3 - 9 tr(M^3)^2 the right polynomial in the certificate's
convention, with q = einsum('abcd,abcd->') and M = W.reshape(25,25)?

Two things are separable.
  (i) A GLOBAL constant in front of F_5 cannot affect the verdict.  The system is
      A x = b in the Gram unknowns x; A x = c b is consistent iff A x = b is, for any
      c != 0.  So the 64 the record worries about is inert here, and so is any
      rescaling of the u_i or of the weight basis (those rescale COLUMNS of A).
  (ii) What could break the verdict is q and tr in DIFFERENT conventions, because that
      changes the polynomial rather than scaling it.  The test that can fail: F_5 must
      vanish identically on the n=5 extremiser, and it does so only for the matched pair.
Built over Q, no floating point.
"""
from fractions import Fraction as Fr
import numpy as np

N = 5
def two_form(pairs):
    w = np.zeros((N, N), dtype=object)
    for (a, b), c in pairs:
        w[a, b] += Fr(c); w[b, a] -= Fr(c)
    return w

w1 = two_form([((0, 1), 1), ((2, 3), 1)])
w2 = two_form([((0, 2), 1), ((1, 3), -1)])
w3 = two_form([((0, 3), 1), ((1, 2), 1)])

W = np.zeros((N,)*4, dtype=object)
for w, s in ((w1, 2), (w2, -1), (w3, -1)):
    W = W + Fr(s) * np.einsum('ab,cd->abcd', w, w)

chk = {
 "antisym in (a,b)":   not (W + W.transpose(1,0,2,3)).any(),
 "antisym in (c,d)":   not (W + W.transpose(0,1,3,2)).any(),
 "pair symmetric":     not (W - W.transpose(2,3,0,1)).any(),
 "first Bianchi":      not (W + W.transpose(0,2,3,1) + W.transpose(0,3,1,2)).any(),
 "Ricci-trace free":   not np.einsum('abad->bd', W).any(),
}
for k, v in chk.items(): print(f"  {k}: {v}")
assert all(chk.values()), "the built tensor is not a Weyl tensor"

q  = np.einsum('abcd,abcd->', W, W)
M  = W.reshape(25, 25)
t3 = np.trace(M @ M @ M)
# operator convention: A on Lambda^2 with <f_a,f_b> = 2 delta  =>  tr(M^k) = 2^k tr(A^k)
t3_op = Fr(t3, 8)
q_op  = Fr(q, 4)
print(f"\n  q  (tensor) = {q}     tr(M^3) (tensor) = {t3}")
print(f"  q  (operator) = {q_op}   tr(A^3) (operator) = {t3_op}")

def F5(qq, tt): return Fr(3, 2)*qq**3 - 9*tt**2
print(f"\n  F_5 with BOTH tensor      : {F5(q, t3)}")
print(f"  F_5 with BOTH operator    : {F5(q_op, t3_op)}")
print(f"  F_5 with q tensor, tr op  : {F5(q, t3_op)}")
print(f"  F_5 with q op, tr tensor  : {F5(q_op, t3)}")
print(f"\n  the certificate script pairs q=einsum and tr(reshape(25,25)^3): both tensor.")
# the record's stated numbers, on the scaling where |W_0|^2 = 24
sc = Fr(24, q)                      # W -> lam W scales q by lam^2, t3 by lam^3
lam2 = sc
q_s  = q * lam2
t3_s = t3 * lam2**Fr(3, 2) if False else None
print(f"  record's quoted pair (q,tr) = (24,48): 3/2*24^3 - 9*48^2 = {F5(Fr(24), Fr(48))}")
print(f"  same ratio here: tr^2/q^3 = {Fr(t3*t3, q**3)}  vs 48^2/24^3 = {Fr(48*48, 24**3)}"
      f"   equal = {Fr(t3*t3, q**3) == Fr(48*48, 24**3)}")
