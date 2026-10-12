import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import sys, numpy as np
sys.path.insert(0,_os.path.join(_ROOT, 'scripts/reviewers/r99'))
from wlib import *
rng = np.random.default_rng(1301)

def iota_star(X, n):
    B = s20_basis(n)
    Y = np.einsum('cb,cij,bkl->ijkl', X, B, B, optimize=True)
    return Y.transpose(0,2,3,1)

def J(X, n):            # sign extension of a pairs matrix to a 4-tensor
    return tensor_of_M(X, n)

for n in [5,6,7,8]:
    print(f"--- n={n} ---")
    # adjointness checks
    T = rng.standard_normal((n,)*4); T = pr(T)
    X = rng.standard_normal((len(s20_basis(n)),)*2); X = 0.5*(X+X.T)
    lhs = np.sum(ringW(T)*X); rhs = np.sum(T*iota_star(X,n))
    Y = rng.standard_normal((len(pairs(n)),)*2); Y = 0.5*(Y+Y.T)
    lhs1 = np.sum(M_of(T)*Y); rhs1 = np.sum(T*(J(Y,n)/4.0))
    print(f"  adjoint iota*: {lhs:.10f} vs {rhs:.10f}   adjoint (J/4): {lhs1:.10f} vs {rhs1:.10f}")
    errs=[]; fits=[]
    for trial in range(6):
        W = rand_weyl(n, rng); W = W/np.linalg.norm(M_of(W))
        M = M_of(W); rw = ringW(W)
        X1 = pr(J(M@M, n)/4.0)              # pr(W^2) with W^2 := iota_1^*(M^2)
        X2 = pr(iota_star(rw@rw, n))        # pr(iota^*(ringW^2))
        tgt = pr(J(sharp(M,n), n)/4.0)      # W^# := iota_1^*(M^#)
        A = np.array([X1.reshape(-1), X2.reshape(-1)]).T
        coef, res, rk, sv = np.linalg.lstsq(A, tgt.reshape(-1), rcond=None)
        resid = np.linalg.norm(A@coef - tgt.reshape(-1))/np.linalg.norm(tgt)
        fits.append(coef); errs.append(resid)
        # exact claim residual with (1/2,-1/2)
        e = np.linalg.norm(0.5*X1 - 0.5*X2 - tgt)/np.linalg.norm(tgt)
        errs.append(e)
        if trial<3:
            print(f"   fit alpha,beta = {coef[0]:+.6f},{coef[1]:+.6f}  lsq_rel_resid={resid:.3e}   "
                  f"rel_resid at (1/2,-1/2) = {e:.3e}")
    # gradient check: Q vs (1/3) grad theta
    W = rand_weyl(n, rng); W = W/np.linalg.norm(M_of(W))
    B = None
    # build orthonormal basis of W_n by sampling
    d = dim_W(n)
    S = np.array([pr(rng.standard_normal((n,)*4)).reshape(-1) for _ in range(d+20)])
    U,s,Vt = np.linalg.svd(S, full_matrices=False)
    Bas = Vt[:d]
    def th(v):
        Wv = v.reshape((n,)*4)
        Mv = M_of(Wv); rv = ringW(Wv)
        return 1.5*p3(Mv) - 0.5*p3(rv)
    h=1e-5; g=np.zeros(d); w0=W.reshape(-1)
    for a in range(d):
        g[a] = (th(w0+h*Bas[a]) - th(w0-h*Bas[a]))/(2*h)
    G = (Bas.T@g).reshape((n,)*4)
    M=M_of(W); rw=ringW(W)
    Q = 1.5*pr(J(M@M,n)/4.0) - 0.5*pr(iota_star(rw@rw,n))
    print(f"   grad check: ||(1/3)grad(theta) - Q||/||Q|| = {np.linalg.norm(G/3-Q)/np.linalg.norm(Q):.3e}")
    # PSD survival through pr
    ev1 = np.linalg.eigvalsh(M_of(pr(J(M@M,n))))
    ev2 = np.linalg.eigvalsh(ringW(pr(iota_star(rw@rw,n))))
    print(f"   PSD after pr?  pr(W^2) as Lambda^2 op: min eig {ev1.min():+.4f} max {ev1.max():+.4f}")
    print(f"                  pr(iota*(rW^2)) as S^2_0 op: min eig {ev2.min():+.4f} max {ev2.max():+.4f}")
    print(f"   norm kept by pr: J(M^2) {np.linalg.norm(pr(J(M@M,n)))/np.linalg.norm(J(M@M,n)):.4f}, "
          f"iota*(rW^2) {np.linalg.norm(pr(iota_star(rw@rw,n)))/np.linalg.norm(iota_star(rw@rw,n)):.4f}")

print("=== collinearity of X1,X2 at each n ===")
for n in [5,6,7,8]:
    W = rand_weyl(n, rng); W=W/np.linalg.norm(M_of(W))
    M=M_of(W); rw=ringW(W)
    X1 = pr(J(M@M,n)/4.0); X2 = pr(iota_star(rw@rw,n))
    A=np.array([X1.reshape(-1),X2.reshape(-1)])
    c = np.sum(X1*X2)/np.linalg.norm(X1)/np.linalg.norm(X2)
    print(f"  n={n}: cos(X1,X2)={c:+.6f}  ||X1||={np.linalg.norm(X1):.4f} ||X2||={np.linalg.norm(X2):.4f} rank={np.linalg.matrix_rank(A,tol=1e-9)}")
