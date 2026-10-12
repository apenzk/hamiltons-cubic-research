"""Commutant dim at larger n using 3 random elements of so(n) (upper-bounds the true
commutant: the commutant of a subset contains the commutant of the whole algebra, so a
value of 1 here already proves absolute irreducibility)."""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import sys, time, numpy as np
sys.path.insert(0,_os.path.join(_ROOT, 'scripts'))
import review_r28_core as R, review_r28_irred as IR
from scipy.sparse.linalg import LinearOperator, eigsh
LOG=_os.path.join(_ROOT, 'agent_logs/review_r28_trace.log')
def log(m):
    with open(LOG,'a') as f: f.write(time.strftime('%H:%M:%S ')+m+'\n')
n=int(sys.argv[1]); seed=int(sys.argv[2]) if len(sys.argv)>2 else 0
G=IR.so_gens_on_weyl(n); D=G.shape[1]
rng=np.random.default_rng(seed)
Gs=np.array([np.einsum('a,aij->ij',rng.normal(size=G.shape[0]),G) for _ in range(3)])
log(f'irred_big n={n}: D={D}, 3 random so(n) elements, starting Lanczos')
res={}
for part in ('sym','alt'):
    iu=np.triu_indices(D,1) if part=='alt' else np.triu_indices(D,0)
    dim=len(iu[0])
    def to_mat(v):
        T=np.zeros((D,D)); T[iu]=v
        return T-T.T if part=='alt' else T+T.T-np.diag(np.diag(T))
    def mv(v):
        T=to_mat(v)
        Cm=np.einsum('aij,jk->aik',Gs,T)-np.einsum('ij,ajk->aik',T,Gs)
        H=np.einsum('aij,ajk->ik',Gs,Cm)-np.einsum('aij,ajk->ik',Cm,Gs)
        return (-H)[iu]
    op=LinearOperator((dim,dim),matvec=mv,dtype=float)
    vals=eigsh(op,k=4,which='SA',tol=1e-8,maxiter=50000,return_eigenvectors=False)
    vals=np.sort(vals); res[part]=vals
    log(f'irred_big n={n} {part}: 4 smallest {np.array2string(vals,precision=4)}')
print(f'n={n} D={D} sym-smallest {np.array2string(res["sym"],precision=5)} alt-smallest {np.array2string(res["alt"],precision=5)}')
