"""C7: an explicit witness that kills the pointwise ansatz with no rank
computation.  Any Hermitian form in the P_i that equals F_5 is invariant; the
invariant ones are exactly R.|P_1|^2 = R.(144 tr W^3)^2 (C2), so they all vanish
wherever tr(W^3) = 0.  A Weyl tensor at n=5 with tr(W^3) = 0 and W != 0 is
therefore a single-point refutation."""
import numpy as np
from fractions import Fraction as Fr
def two_form(terms,n=5):
    M=np.zeros((n,n),dtype=object)
    for (i,j),c in terms: M[i,j]+=c; M[j,i]-=c
    return M
w1=two_form([((0,1),1),((2,3),1)])
w2=two_form([((0,2),1),((1,3),-1)])
w3=two_form([((0,3),1),((1,2),1)])
W=np.zeros((5,5,5,5),dtype=object)
for w,s in ((w1,1),(w2,-1),(w3,0)):
    W=W+s*np.einsum('ab,cd->abcd',w,w)
print("W is a Weyl tensor at n=5:")
print("  antisym  :",not np.any(W+W.transpose(1,0,2,3)))
print("  pair sym :",not np.any(W-W.transpose(2,3,0,1)))
print("  Bianchi  :",not np.any(W+W.transpose(0,2,3,1)+W.transpose(0,3,1,2)))
print("  Ric = 0  :",not np.any(np.einsum('abad->bd',W)))
q=int(np.einsum('abcd,abcd->',W,W)); M=W.reshape(25,25); t3=int(np.trace(M@M@M))
print(f"\n  |W|^2 = {q},  tr(W^3) = {t3}")
print(f"  every invariant Hermitian form in the P_i evaluates to 0 here")
print(f"  F_5(W) = (3/2)*{q}^3 - 9*{t3}^2 = {Fr(3,2)*q**3-9*t3**2}  != 0")
