import numpy as np, sys
sys.path.insert(0,'scripts/reviewers/r101')
from wcore import *; from wopt import *
rng=np.random.default_rng(5)
n=6; W=normalise(random_weyl(n,rng)); W=W*2/np.linalg.norm(W)*np.linalg.norm(W)/np.linalg.norm(W)
print("||W||",np.linalg.norm(W),"|M|",np.linalg.norm(Mmat(W)))
th,G=theta_grad(W)
th0,_=theta_of(W); print("theta",th,th0)
# finite difference of theta along random W_n direction
E=proj_W(random_weyl(n,rng)); E/= np.linalg.norm(E); eps=1e-6
fd=(theta_of(W+eps*E)[0]-theta_of(W-eps*E)[0])/(2*eps)
print("theta grad fd",fd,"analytic",np.sum(G*E))
F,_=np.linalg.qr(rng.standard_normal((n,n)))
k,Gk=k2_grad_W(W,F)
fd2=(kfro2(W+eps*E,F)-kfro2(W-eps*E,F))/(2*eps)
print("k2 gradW fd",fd2,"analytic",np.sum(Gk*E), " k2",k, kfro2(W,F))
