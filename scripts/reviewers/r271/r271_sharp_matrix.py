"""r271: (a) matrix ad-form vs the primitive structure-constant definition of #;
(b) does # preserve the Bianchi subspace (Lambda^4 component)?; (c) total antisymmetry of c."""
import numpy as np, sys
sys.path.insert(0, "scripts/lib")
from weyl import (build_structure_constants, Q_general, bianchi_constraint_matrix,
                  vec_to_mat, mat_to_vec, R_val)
from rsharp_basis_free import Rsharp_full

def sharp_primitive(M, c):
    """(R#)_{pq} = 1/2 sum c[p,a,cc] c[q,b,d] M[a,b] M[cc,d]  -- Boehm-Wilking structure-constant form."""
    return 0.5*np.einsum('pac,qbd,ab,cd->pq', c, c, M, M, optimize=True)

def weyl_basis_for(n):
    idx, pos, N, c = build_structure_constants(n)
    Bmat, triu_idx, tpos = bianchi_constraint_matrix(idx, pos, n, N)
    U,S,Vt = np.linalg.svd(Bmat); rank=int(np.sum(S>1e-9*S[0]))
    nb = Vt[rank:,:].T; D=nb.shape[1]
    Rd=[vec_to_mat(nb[:,d],triu_idx,N) for d in range(D)]
    rows=[]
    for i in range(n):
        for k in range(i,n):
            row=np.zeros(D)
            for j in range(n):
                if j==i or j==k: continue
                for d in range(D): row[d]+=R_val(Rd[d],pos,n,i,j,k,j)
            rows.append(row)
    Ur,Sr,Vtr=np.linalg.svd(np.array(rows)); rr=int(np.sum(Sr>1e-9*Sr[0]))
    return idx,pos,N,c,triu_idx,Bmat,nb,nb@Vtr[rr:,:].T

for n in (5,6,7):
    idx,pos,N,c,triu_idx,Bmat,nullb,wb = weyl_basis_for(n)
    print(f"\n=== n={n} N={N} dimWeyl={wb.shape[1]} ===")
    print(f"  c totally antisymmetric? max|c+c^T(last two)|={np.abs(c+np.transpose(c,(0,2,1))).max():.1e}"
          f"  cyclic max|c-perm|={np.abs(c-np.transpose(c,(1,2,0))).max():.1e}")
    rng=np.random.default_rng(99+n)
    for t in range(3):
        v = wb @ rng.standard_normal(wb.shape[1])
        M = vec_to_mat(v,triu_idx,N); M/=np.linalg.norm(M)
        Sf = Rsharp_full(M,c)          # -1/2 tr(A_a M A_b M)   (Wilking ad-form)
        Sp = sharp_primitive(M,c)      # 1/2 c c M M            (structure-constant #)
        Qg = Q_general(M,c)            # record's eigenbasis routine
        d1 = np.linalg.norm(Sf-Sp)/np.linalg.norm(Sp)
        d2 = np.linalg.norm(np.diag(Sf) - np.diag(Qg - M@M))/np.linalg.norm(np.diag(Sp))
        # off-diagonal mass Q_general throws away, measured in M's eigenbasis
        w,V = np.linalg.eigh(M); Se = V.T@Sf@V
        offfrac = np.linalg.norm(Se-np.diag(np.diag(Se)))/np.linalg.norm(Se)
        # Bianchi component of M#
        rs = np.linalg.norm(Bmat@mat_to_vec(Sf,triu_idx))/np.linalg.norm(mat_to_vec(Sf,triu_idx))
        rM = np.linalg.norm(Bmat@mat_to_vec(M,triu_idx))/np.linalg.norm(mat_to_vec(M,triu_idx))
        # also for a NON-Bianchi random symmetric X
        X = rng.standard_normal((N,N)); X=(X+X.T)/2; X/=np.linalg.norm(X)
        rX = np.linalg.norm(Bmat@mat_to_vec(Rsharp_full(X,c),triu_idx))/np.linalg.norm(mat_to_vec(Rsharp_full(X,c),triu_idx))
        print(f"  t{t}: |adform - ccMM|/| |={d1:.2e}  diag vs Q_general={d2:.2e}  offdiag frac of M# in M-eigbasis={offfrac:.4f}"
              f"  Bianchi resid: M={rM:.1e} M#={rs:.2e}  (random X#: {rX:.3f})")
