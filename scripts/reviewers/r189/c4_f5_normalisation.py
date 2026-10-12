"""C4: the 3/2 and the 9 in run_n5_certificate.py's F5, in its own flat
convention.  F_5 is homogeneous of degree 6, so vanishing at the extremiser is
scale-free -- build W_0 (the padded CP^2 Weyl tensor) over Z and evaluate."""
import numpy as np, itertools
from fractions import Fraction as Fr

def two_form(terms,n=5):
    M=np.zeros((n,n),dtype=object)
    for (i,j),c in terms: M[i,j]+=c; M[j,i]-=c
    return M
w1=two_form([((0,1),1),((2,3),1)])
w2=two_form([((0,2),1),((1,3),-1)])
w3=two_form([((0,3),1),((1,2),1)])
W=np.zeros((5,5,5,5),dtype=object)
for w,s in ((w1,2),(w2,-1),(w3,-1)):
    W=W+s*np.einsum('ab,cd->abcd',w,w)
# the Lambda^+ forms are self-dual on R^4: the tensor above already satisfies
# the curvature symmetries?  check them.
print("antisym in 12 :", not np.any(W+W.transpose(1,0,2,3)))
print("pair symmetry :", not np.any(W-W.transpose(2,3,0,1)))
print("first Bianchi :", not np.any(W+W.transpose(0,2,3,1)+W.transpose(0,3,1,2)))
print("Ricci-flat    :", not np.any(np.einsum('abad->bd',W)))
q=int(np.einsum('abcd,abcd->',W,W))
M=W.reshape(25,25)
t3=int(np.trace(M@M@M))
print(f"\nflat q = <W,W> = {q}")
print(f"flat tr(M^3)   = {t3}")
print(f"(3/2) q^3 - 9 t3^2 = {Fr(3,2)*q**3 - 9*t3**2}")
for (a,b) in ((Fr(3,2),9),(Fr(1,1),9),(Fr(3,2),8),(Fr(3,2),10),(Fr(2,1),9)):
    print(f"   control  a={a} b={b}:  {a*q**3 - b*t3**2}")
# Lambda^2 operator convention, for the record's own numbers
PAIRS=[(a,b) for a in range(5) for b in range(a+1,5)]
A=np.zeros((10,10),dtype=object)
for i,(a,b) in enumerate(PAIRS):
    for j,(c,dd) in enumerate(PAIRS):
        A[i,j]=W[a,b,c,dd]
# eigen-structure via traces
tA2=int(np.trace(A@A)); tA3=int(np.trace(A@A@A))
print(f"\nLambda^2 operator: tr(A^2) = {tA2}, tr(A^3) = {tA3}")
print(f"  q_flat / tr(A^2) = {Fr(q,tA2)} (expected 4);  t3_flat / tr(A^3) = {Fr(t3,tA3)} (expected 8)")
print(f"  (3/2) tr(A^2)^3 - 9 tr(A^3)^2 = {Fr(3,2)*tA2**3 - 9*tA3**2}")
print(f"  ratio of the two F_5's = {Fr(Fr(3,2)*q**3 - 9*t3**2, 1) if (Fr(3,2)*tA2**3-9*tA3**2)==0 else 'n/a'} (both zero -> 64 factor untestable here)")
