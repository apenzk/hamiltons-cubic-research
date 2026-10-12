import sys, numpy as np
sys.path.insert(0, 'scripts/lib')
from review_r33_spec import weyl_basis, L_matrix, s_m, c_m
import review_r33_core as R

p,q=2,2; n=4
B,_=weyl_basis(n); dim=B.shape[0]
L=L_matrix(p,q,B); L=(L+L.T)/2
ev,V=np.linalg.eigh(L)
print("n=4, (p,q)=(2,2): dim Weyl_4 =",dim)
print("  spectrum:",np.round(ev,10))
named = s_m(2)*s_m(2)+c_m(2)*c_m(2)+s_m(2)+s_m(2)+p*q+1
print(f"  N10 named multiplicities sum = s_p s_q + c_p c_q + s_p + s_q + pq + 1 = "
      f"{s_m(2)*s_m(2)}+{c_m(2)*c_m(2)}+{s_m(2)}+{s_m(2)}+{p*q}+1 = {named}   vs dim = {dim}")
print(f"  pq(pq+3)/2 = {p*q*(p*q+3)//2}")
print(f"  mu = (n-2)/(2(p-1)(q-1)) = {(n-2)/(2*(p-1)*(q-1))}")
# is e primitive?  eigenvalue-1 eigenspace
e1=V[:,np.abs(ev-1)<1e-9]
print("  dim E(1) =",e1.shape[1])
A=R.A_tensor(n); W=R.W_pq(2,2); th=(n-1)/(p*q); e=W/th
print("  <e,e> =",np.sum(e*e),"  Q(e)-e resid:",np.max(np.abs(R.Q_of(A,e)-e)))
# decompose e into the two idempotents:  self-dual / anti-self-dual projectors
idx=R.pair_index(4)
# Lambda^2 R^4 splits by the Hodge star; build star
D=6; star=np.zeros((D,D))
import itertools
perm={((0,1),(2,3)):1,((0,2),(1,3)):-1,((0,3),(1,2)):1}
for (a,b),s in perm.items():
    star[idx[a],idx[b]]=s; star[idx[b],idx[a]]=s
Pp=(np.eye(D)+star)/2; Pm=(np.eye(D)-star)/2
ep = Pp@e@Pp; em = Pm@e@Pm
print("  ||e - (P+ e P+ + P- e P-)|| =",np.linalg.norm(e-ep-em))
print("  Q(e+)-e+ :",np.max(np.abs(R.Q_of(A,ep)-ep)),"   Q(e-)-e- :",np.max(np.abs(R.Q_of(A,em)-em)))
print("  <e+,e-> =",np.sum(ep*em))
