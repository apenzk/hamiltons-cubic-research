import sys, os
sys.path.insert(0, os.path.dirname(__file__))
import numpy as np, core

def ric_op(n, Y):
    """Ricci of the curvature operator Y: Ric_ik = sum_j Y_{ijkj}."""
    P, idx = core.pairs_of(n)
    def R(i,j,k,l):
        if i==j or k==l: return 0.0
        s=1.0
        if i>j: i,j,s=j,i,-s
        if k>l: k,l,s=l,k,-s
        return s*Y[idx[(i,j)], idx[(k,l)]]
    return np.array([[sum(R(i,j,k,j) for j in range(n)) for k in range(n)] for i in range(n)])

def wedge_id(n, S):
    """(S wedge id) as an operator on Lambda^2: (S^id)(e_i^e_j) = Se_i^e_j + e_i^Se_j = deriv(S)."""
    return core.deriv(n, S)

for n in (4,5,6,7,8):
    P,_ = core.pairs_of(n); N = len(P)
    Id = np.eye(N)
    sh = core.sharp(n, Id)
    print(f"n={n}: Id^# = c*Id ? c={sh[0,0]:.6f} (n-2={n-2})  err={np.linalg.norm(sh-(n-2)*Id):.2e}")
    B = core.weyl_basis(n)
    rng = np.random.default_rng(3)
    co = rng.normal(size=B.shape[0]); Y = np.einsum('k,kij->ij', co, B); Y/=np.linalg.norm(Y)
    sb = core.sharp_bilin(n, Id, Y)
    print(f"     Weyl Y: ||sharp_bilin(Id,Y) + Y|| = {np.linalg.norm(sb+Y):.2e}   ||Id o Y||={np.linalg.norm(core.circ(n,Id,Y)):.2e}")
    # general Y in Sym^2(Lambda^2): fit sharp_bilin(Id,Y) = a Y + b tr(Y) Id + c (Ric_0(Y) wedge id) + d ...
    rows=[]; rhs=[]
    for _ in range(6):
        X = rng.normal(size=(N,N)); X = 0.5*(X+X.T); X/=np.linalg.norm(X)
        Rc = ric_op(n, X); Rc0 = Rc - np.trace(Rc)/n*np.eye(n)
        feats = [X, np.trace(X)*Id/N, wedge_id(n, Rc0), np.trace(Rc)*Id]
        target = core.sharp_bilin(n, Id, X)
        rows.append([f.reshape(-1) for f in feats]); rhs.append(target.reshape(-1))
    M = np.concatenate([np.array(r).T for r in rows], axis=0)
    y = np.concatenate(rhs)
    coef, res, rk, sv = np.linalg.lstsq(M, y, rcond=None)
    err = np.linalg.norm(M@coef - y)/np.linalg.norm(y)
    print(f"     fit sharp_bilin(Id,X) = {coef[0]:+.6f} X {coef[1]:+.6f} tr(X)Id/N {coef[2]:+.6f} (Ric_0^id) {coef[3]:+.6f} scal*Id ; relerr={err:.2e}")
    # tau over Weyl at n=4
    t = np.zeros((N,N))
    for k in range(B.shape[0]): t += core.circ(n, B[k], B[k])
    print(f"     ||tau_Weyl||={np.linalg.norm(t):.2e}  dimWeyl={B.shape[0]}")
