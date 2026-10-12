"""r249 / claim 1(c): the construction DOES generalise to n = 12, without wm.

wm is hardcoded to N = 5, so the file's route ("the module already builds one")
stops at n = 5.  The closed-form action of P (c15_matrix_free.py) supplies a
basis at any n: project random 4-tensors and orthonormalise the range.  Here at
n = 12, with the result certified by rank, by the Weyl conditions, and by
reproducing the projector.
"""
import numpy as np, time
import importlib.util as _il
sp=_il.spec_from_file_location("mf","scripts/reviewers/r249/c15_matrix_free.py")
# import weyl_apply without running the module's __main__ prints
src=open("scripts/reviewers/r249/c15_matrix_free.py").read()
ns={}
exec(src[:src.index("# ---- agreement")], ns)
weyl_apply, dim_weyl = ns["weyl_apply"], ns["dim_weyl"]

n=12; D=n**4; d=dim_weyl(n)
print(f"n={n}: ambient {D}, dim Weyl_{n} = {d}")
rg=np.random.default_rng(0)
t0=time.time()
S=np.stack([weyl_apply(rg.standard_normal((n,)*4), n).ravel() for _ in range(d+60)])
print(f"  {S.shape[0]} projected random samples in {time.time()-t0:.1f} s")
t0=time.time()
U,sv,_=np.linalg.svd(S, full_matrices=False)
rank=int((sv>sv[0]*1e-10).sum())
print(f"  numerical rank of the projected samples = {rank}  (expect {d}) "
      f"[svd {time.time()-t0:.1f} s]")
Q=(S.T@U[:,:rank])/sv[:rank]                 # 20736 x rank orthonormal columns
print(f"  |Q^T Q - I|_max = {np.abs(Q.T@Q-np.eye(rank)).max():.2e}")
B=Q.T.reshape((rank,)+(n,)*4)
nrm=np.abs(B).max()
print(f"  Weyl conditions on the basis: "
      f"antisym={np.abs(B+B.transpose(0,2,1,3,4)).max()/nrm:.1e} "
      f"pairsym={np.abs(B-B.transpose(0,3,4,1,2)).max()/nrm:.1e} "
      f"bianchi={np.abs(B+B.transpose(0,1,3,4,2)+B.transpose(0,1,4,2,3)).max()/nrm:.1e} "
      f"ricci={np.abs(np.einsum('kambm->kab',B)).max()/nrm:.1e}")
X=rg.standard_normal((n,)*4)
PX_basis=np.einsum('ki,i->k',Q.T,X.ravel()) @ Q.T
print(f"  basis-built P X vs closed-form P X: "
      f"{np.abs(PX_basis.reshape((n,)*4)-weyl_apply(X,n)).max():.2e}")
print(f"  storage of the basis as a matrix: {rank}x{D} = {rank*D*8/2**20:.0f} MB,"
      f" against {n**8*8/2**30:.2f} GB for the 8-index P")
