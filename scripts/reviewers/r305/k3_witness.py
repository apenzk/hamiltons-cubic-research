"""K3: independent verification of the non-diagonal witness."""
import numpy as np, sys
sys.path.insert(0,'scripts/reviewers/r305')
from lib305 import *
W=np.load('scripts/data/w_n8_nondiagonal_witness.npy')
print("shape",W.shape,"symmetric?",np.abs(W-W.T).max())
n=8
idx,pos,N,c,B=weyl_basis(n)
W=W/np.sqrt(inner(W,W))
co=np.array([inner(b,W) for b in B])
print(f"|W|^2={inner(W,W):.12f}  in Weyl_8: err={np.abs(np.tensordot(co,B,axes=(0,0))-W).max():.2e}")
th=P(c,W); QW=Qmap(c,W)
print(f"theta = {th:.9f}    criticality residual ||Q(W)-thW|| = {np.abs(QW-th*W).max():.2e}")
print(f"Delta = {Delta(c,W):.6f}")
Lm=L_operator(c,B,W)/th
u=co/np.linalg.norm(co)
lmax,ev=lam_max_perp(Lm,u)
print(f"lambda_max(L_e|e-perp) = {lmax:.9f}   ratio lambda_max/theta = {lmax/th:.9f}")
evs=np.sort(np.linalg.eigvalsh(0.5*(Lm+Lm.T)))
print("top 8 eigenvalues:",np.round(evs[-8:],9))
print("dim E(1) =",int(np.sum(np.abs(evs-1)<1e-8)),"  mult(1/2) =",int(np.sum(np.abs(evs-0.5)<1e-8)))
# diagonality
ew,V=np.linalg.eigh(W)
print("W spectrum:",np.round(ew,6))
print("kernel dim:",int(np.sum(np.abs(ew)<1e-9)))
# max off-diagonal in the coordinate pair basis
print("max |off-diagonal| of the pair matrix:",np.abs(W-np.diag(np.diag(W))).max())
