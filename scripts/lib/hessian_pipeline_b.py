import numpy as np, time
from weyl import build_structure_constants, vec_to_mat, bianchi_constraint_matrix, mat_to_vec, R_val
from rsharp_basis_free import Q_full

def run(n, p, q, verbose=True):
    idx,pos,N,c = build_structure_constants(n)
    Bmat, triu_idx, tpos = bianchi_constraint_matrix(idx,pos,n,N)
    U,S,Vt = np.linalg.svd(Bmat)
    tol = 1e-9*S[0]
    rank = np.sum(S>tol)
    null_basis = Vt[rank:,:].T
    D0 = null_basis.shape[1]
    Rmat_ds = [vec_to_mat(null_basis[:,d], triu_idx, N) for d in range(D0)]
    ric_rows=[]
    for i in range(n):
        for k in range(i,n):
            row = np.zeros(D0)
            for j in range(n):
                if j==i or j==k: continue
                for d in range(D0):
                    row[d]+= R_val(Rmat_ds[d],pos,n,i,j,k,j)
            ric_rows.append(row)
    RicMat = np.array(ric_rows)
    Ur,Sr,Vtr = np.linalg.svd(RicMat)
    tolr = 1e-9*Sr[0] if len(Sr)>0 else 1e-9
    rankr = np.sum(Sr>tolr)
    weyl_coeffs = Vtr[rankr:,:].T
    weyl_basis = null_basis @ weyl_coeffs
    D = weyl_basis.shape[1]
    if verbose: print(f"n={n} N={N} dim(AlgCurv)={D0} dim(Weyl)={D}")

    mats = [vec_to_mat(weyl_basis[:,i], triu_idx, N) for i in range(D)]
    G = np.array([[np.sum(mats[i]*mats[j]) for j in range(D)] for i in range(D)])
    w,V = np.linalg.eigh(G)
    w = np.maximum(w, 1e-14)
    Ginvhalf = V @ np.diag(1/np.sqrt(w)) @ V.T
    E = []
    for a in range(D):
        Ea = np.zeros((N,N))
        for i in range(D):
            if abs(Ginvhalf[i,a])>1e-13:
                Ea += Ginvhalf[i,a]*mats[i]
        E.append(Ea)

    x = 1.0/(p*(p-1)); y = 1.0/(q*(q-1)); z = -1.0/(p*q)
    lam = np.zeros(N)
    for a,(i,j) in enumerate(idx):
        if i<p and j<p: lam[a]=x
        elif i>=p and j>=p: lam[a]=y
        else: lam[a]=z
    Wmat = np.diag(lam)
    Wnorm = np.sqrt(np.sum(Wmat*Wmat))
    Wunit = Wmat/Wnorm
    if verbose: print("|W*| (Frobenius, raw) =", Wnorm)

    def T_quad(Xmat, Hmat):
        return float(np.sum(Xmat * Q_full(Hmat, c)))

    lam_P = T_quad(Wunit, Wunit)
    if verbose: print("lambda = P(W*) [unit] =", lam_P)
    Qw = Q_full(Wunit,c)
    if verbose:
        print("Q(W*)/W* ratio:", sorted(set(np.round(np.diag(Qw)/np.diag(Wunit),8))))
        print("offdiag(Q(W*)) norm:", np.linalg.norm(Qw-np.diag(np.diag(Qw))))

    coeffs_on_W = [np.sum(E[a]*Wunit) for a in range(D)]
    Tmats = [E[a] - coeffs_on_W[a]*Wunit for a in range(D)]
    Gt = np.array([[np.sum(Tmats[i]*Tmats[j]) for j in range(D)] for i in range(D)])
    wt, Vt2 = np.linalg.eigh(Gt)
    order = np.argsort(-wt); wt = wt[order]; Vt2 = Vt2[:,order]
    keep = wt > 1e-8*wt[0]
    Dt = np.sum(keep)
    if verbose: print("tangent space dim (should be D-1 =", D-1, "):", Dt)
    Vt2k = Vt2[:,:Dt]; wtk = wt[:Dt]
    Ginvhalf_t = Vt2k @ np.diag(1/np.sqrt(wtk))
    Etan = []
    for a in range(Dt):
        Ea = np.zeros((N,N))
        for i in range(D):
            if abs(Ginvhalf_t[i,a])>1e-13:
                Ea += Ginvhalf_t[i,a]*Tmats[i]
        Etan.append(Ea)

    t0=time.time()
    diagT = np.array([T_quad(Wunit, Etan[a]) for a in range(Dt)])
    M = np.zeros((Dt,Dt))
    for a in range(Dt):
        M[a,a] = diagT[a]
    for a in range(Dt):
        for b in range(a+1,Dt):
            val = T_quad(Wunit, Etan[a]+Etan[b])
            Mab = 0.5*(val - diagT[a]-diagT[b])
            M[a,b]=Mab; M[b,a]=Mab
    t1=time.time()
    if verbose: print("Hessian build time:", t1-t0)

    Hess = 6*M - 3*lam_P*np.eye(Dt)   # CORRECTED coefficient: -3 lambda, not -2 lambda
    evals = np.linalg.eigvalsh(Hess)
    return evals, lam_P, Dt, Etan

if __name__=="__main__":
    import sys
    n=int(sys.argv[1]) if len(sys.argv)>1 else 8
    p=int(sys.argv[2]) if len(sys.argv)>2 else n//2
    q=int(sys.argv[3]) if len(sys.argv)>3 else n-p
    evals, lam_P, Dt, Etan = run(n,p,q)
    print("lambda=",lam_P)
    print("Hessian eigenvalues: min=",evals[0]," max=",evals[-1])
    print("num positive:", np.sum(evals>1e-6), " num ~zero:", np.sum(np.abs(evals)<1e-6), " num negative:", np.sum(evals<-1e-6))
    print("top 10 eigenvalues:", evals[-10:])
