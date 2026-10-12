import sys, numpy as np
sys.path.insert(0, 'scripts/misc')
from screen_I73_pair_direction import pairs, structure_constants, weyl_projector, sharp_mat, circ
from screen_I73_pair_blindness import padded_cp2
n=8; N=len(pairs(n)); c=structure_constants(n); Pi,_=weyl_projector(n)
W=padded_cp2(n); W=W/np.sqrt(np.trace(W@W))
th=np.trace(W@W@W)+np.sum(W*sharp_mat(c,W,W)); E=W/th
lam,V=np.linalg.eigh(E); vals=sorted(set(np.round(lam,9))); cls=[int(np.argmin([abs(l-v) for v in vals])) for l in lam]
S=np.zeros((3,3))
for a in range(N):
    for b in range(N):
        if cls[a]>=cls[b]: continue
        Y0=0.5*(np.outer(V[:,a],V[:,b])+np.outer(V[:,b],V[:,a])); X=(Pi@Y0.ravel()).reshape(N,N)
        S[cls[a],cls[b]]+=np.sum(X*circ(c,E,X))-0.5*np.sum(X*X)
p=vals[1]-vals[0]; q=vals[2]-vals[1]
I1=p*S[0,1]+(p+q)*S[0,2]; I2=q*S[1,2]+(p+q)*S[0,2]
m=[cls.count(k) for k in range(3)]; E2=sum(lam**2); E3=sum(lam**3)
Gam=(n+4)/12*((n-1)*E3-(n-3)*E2)
print("theta",th,"vals",vals,"m",m); print("S",S[0,1],S[0,2],S[1,2]); print("I1",I1,"(-38/9=",-38/9,") I2",I2,"pI1+qI2",p*I1+q*I2,"Gamma",Gam,"Gamma/p",Gam/p)
