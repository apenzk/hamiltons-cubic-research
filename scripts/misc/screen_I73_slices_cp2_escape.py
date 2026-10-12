# I73, D3 follow-up at padded W_CP2, n = 12: where the escaping direction D* (towards the S^5 x S^5 product, P = 1.23603 > theta) lives, and whether
# the O(E0)-orbit average of the great-circle inequality keeps it. D* lies wholly in Pi(pair directions of E0) (generic basis), a = 0, b = P(D*);
# the orbit average drops b to about 0.03 and max_t to theta. /usr/bin/python3, a few minutes.
import sys, numpy as np
sys.path.insert(0,'scripts/misc')
from screen_I73_pair_direction import pairs, structure_constants, weyl_projector, sharp_mat
from screen_I73_pair_blindness import padded_cp2
from screen_I66_sphere_product_anchor import sphere_weight
n=12; N=len(pairs(n)); Pi,_=weyl_projector(n)
W=padded_cp2(n); W/=np.linalg.norm(W); w=W.ravel()
sw=sphere_weight(n,6); X=np.diag([sw[i,j] for (i,j) in pairs(n)]); X/=np.linalg.norm(X)
D=X.ravel()-(X.ravel()@w)*w
ev,Q=np.linalg.eigh(W); E0=Q[:,np.abs(ev)<1e-6]
rng=np.random.default_rng(1); R=np.linalg.qr(rng.normal(size=(63,63)))[0]; E0=E0@R  # generic basis of E0
def span_frac(vecs):
    A=np.array(vecs).T; U,S,_=np.linalg.svd(A,full_matrices=False); B=U[:,S>1e-8*S[0]]
    return np.linalg.norm(B.T@D)**2/np.linalg.norm(D)**2, B.shape[1]
off=[Pi@(0.5*(np.outer(E0[:,i],E0[:,j])+np.outer(E0[:,j],E0[:,i]))).ravel() for i in range(63) for j in range(i+1,63)]
dia=[Pi@np.outer(E0[:,i],E0[:,i]).ravel() for i in range(63)]
print('D* in Pi(off-diagonal Sym2 E0), generic basis:',span_frac(off))
print('D* in Pi(full Sym2 E0):',span_frac(off+dia))
c=structure_constants(n)
P=lambda Y: np.trace(Y@Y@Y)+np.sum(Y*sharp_mat(c,Y,Y))
LW=lambda V: 0.5*(W@V+V@W)+sharp_mat(c,W,V)
Dm=(D/np.linalg.norm(D)).reshape(N,N); th=P(W)
Pe=np.eye(N)-E0@E0.T
aa=[];bb=[]
for _ in range(300):
    g=np.linalg.qr(rng.normal(size=(63,63)))[0]; G=Pe+E0@g@E0.T   # rotation of Lambda^2 acting on E0 only
    V=(Pi@(G@Dm@G.T).ravel()); V=V-(V@w)*w; V=(V/np.linalg.norm(V)).reshape(N,N)
    aa.append(np.sum(V*LW(V))); bb.append(P(V))
a0,b0=np.sum(Dm*LW(Dm)),P(Dm); ts=np.linspace(0,np.pi,4001)
f=lambda a,b: (th*np.cos(ts)**3+3*a*np.cos(ts)*np.sin(ts)**2+b*np.sin(ts)**3).max()
print('theta',th,'D* itself: a,b',a0,b0,'max',f(a0,b0))
print('O(E0)-orbit average: a,b',np.mean(aa),np.mean(bb),'max',f(np.mean(aa),np.mean(bb)),' orbit max b',max(bb))
