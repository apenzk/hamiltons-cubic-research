import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import numpy as np
exec(open(_os.path.join(_ROOT, 'scripts/reviewers/r121/r121_core.py')).read().split('# ---------- checks')[0])

def Q(W): return W2(W)+Wsharp_tensor(W)

def pieces(W,h):
    n=W.shape[0]
    u = np.einsum('ikpq->pqik',W)          # u[p,q] = matrix (ik)
    C = np.einsum('ipjq->pqij',W)          # C[p,q]_{ij}=W_ipjq
    N = np.einsum('impq,kmpq->ik',W,W)
    comm = u@h - h@u                        # (p,q,i,k)
    t1 = 0.25*np.einsum('pqij,pqij->',comm,comm)
    t2 = np.einsum('pqij,pqji->', C@h, C@h)   # sum tr((Ch)^2)
    t3 = -0.5*np.trace(N@h@h)
    return t1,t2,t3,N,u,C

for n in [4,5,6,7]:
  rng=np.random.default_rng(n)
  B=so_basis(n); S0=s20_basis(n)
  W=rand_weyl(n,rng); W/=np.sqrt(op_norm2(W))
  QW=Q(W)
  print(f"--- n={n} ---")
  print("  Bianchi(Q(W)) resid", np.abs(QW+QW.transpose(0,2,3,1)+QW.transpose(0,3,1,2)).max(),
        " |Ric(Q(W))|", np.abs(ricci(QW)).max(), " |Q(W)|", np.abs(QW).max())
  # ring spectrum
  Rm = ring_matrix(W,S0); Rm=(Rm+Rm.T)/2
  ev,evec=np.linalg.eigh(Rm)
  print("  ring spectrum trace", ev.sum(), " min", ev.min(), " max", ev.max())
  # step 2 for a random symmetric traceless h  (identity, no criticality)
  hh = rng.standard_normal((n,n)); hh=(hh+hh.T)/2; hh-=np.trace(hh)/n*np.eye(n); hh/=np.linalg.norm(hh)
  lhs = np.einsum('ij,ij->',ring(W2(W),hh),hh)
  t1,t2,t3,N,u,C = pieces(W,hh)
  print("  STEP2 lhs-rhs", lhs-(t1+t3))
  lhs4 = np.einsum('ij,ij->',ring(Wsharp_tensor(W),hh),hh)
  ip = np.einsum('pqij,ij->pq',C,hh)
  print("  STEP4 lhs-rhs", lhs4-(t2-np.einsum('pq,pq->',ip,ip)))
  print("  STEP3 N psd? min eig", np.linalg.eigvalsh(N).min(), " trN", np.trace(N), " |W|^2_tensor", np.einsum('ijkl,ijkl->',W,W),
        " N multiple of I?", np.abs(N-np.trace(N)/n*np.eye(n)).max())
  # step 5 with a genuine eigenvector
  for idx in [0,len(ev)-1]:
      h = sum(evec[a,idx]*S0[a] for a in range(len(S0)))
      h/=np.linalg.norm(h)
      nu = ev[idx]
      ip = np.einsum('pqij,ij->pq',C,h)
      print(f"   STEP5 nu={nu:+.5f}  |<C,h>-(-ring h)|", np.abs(ip+ring(W,h)).max(), " sum<C,h>^2 - nu^2", np.einsum('pq,pq->',ip,ip)-nu**2)
