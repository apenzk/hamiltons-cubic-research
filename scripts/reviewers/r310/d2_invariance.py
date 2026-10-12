import sys, os, numpy as np
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import lib310 as L
rng = np.random.default_rng(2310)
print("=== D2: is the diagonal locus L_W-invariant at NON-critical diagonal W? ===")
for n in [5,6,7,8]:
    P_ = L.pairs(n); D=len(P_)
    for tag, mk in [
        ("random diagonal W, Weyl (hollow sym, zero row sums), NON-critical", True),
        ("random diagonal W, NOT Ricci-flat (row sums non-zero)", False)]:
        M = rng.normal(size=(n,n)); M=(M+M.T)/2; np.fill_diagonal(M,0)
        if mk:
            # project to zero row sums, hollow, symmetric
            for _ in range(200):
                r = M.sum(1)/(n-2)
                M = M - (np.add.outer(r,np.zeros(n))+np.add.outer(np.zeros(n),r))/1.0*0 - (r[:,None]+r[None,:])/2*0
                # explicit projector: subtract u1^T+1u^T then hollow
                u = np.linalg.lstsq(np.eye(n)+np.ones((n,n)) - 2*np.eye(n)*0, M.sum(1), rcond=None)[0]
                M = M - (u[:,None]+u[None,:]); np.fill_diagonal(M,0)
                if np.abs(M.sum(1)).max()<1e-14: break
        W = L.W_from_M(M)
        th = L.P(W)
        crit = np.abs(L.Q(W)-th*W).max()
        # H diagonal, random
        N = rng.normal(size=(n,n)); N=(N+N.T)/2; np.fill_diagonal(N,0)
        H = L.W_from_M(N)
        LH = L.L_W(W,H,n)
        off = np.linalg.norm(LH - np.diag(np.diag(LH)))
        # compare with closed form  M o N + (MN+NM)/2, hollowed
        cf = M*N + (M@N+N@M)/2
        pv = np.array([cf[a,b] for (a,b) in P_])
        print(f"n={n} [{tag}] rowsum={np.abs(M.sum(1)).max():.1e} critresid={crit:.3e} "
              f"offdiag(L_W H)={off:.3e} |diag(L_W H)-closed form|={np.abs(np.diag(LH)-pv).max():.3e}")
print()
print("=== is L_W self-adjoint on Weyl_n (so Rayleigh gives the inequality with no invariance)? ===")
for n in [6,7]:
    B = L.weyl_basis(n)
    M = rng.normal(size=(n,n)); M=(M+M.T)/2; np.fill_diagonal(M,0)
    W = L.W_from_M(M)
    Lm, res = L.L_matrix(W,n,B)
    print(f"n={n} non-critical diagonal W: ||L-L^T|| = {np.abs(Lm-Lm.T).max():.3e}, "
          f"L_W(Weyl) subset Weyl residual = {res:.3e}")
    # generic non-diagonal W in Weyl_n
    c = rng.normal(size=len(B)); Wg = np.tensordot(c,B,axes=([0],[0])); Wg/=np.sqrt(L.ip(Wg,Wg))
    Lm2,res2 = L.L_matrix(Wg,n,B)
    print(f"      generic non-diagonal W: ||L-L^T|| = {np.abs(Lm2-Lm2.T).max():.3e}, closure residual = {res2:.3e}")
print()
print("=== the inequality lam_max(locus) <= lam_max(full) at NON-critical diagonal W ===")
for n in [6,7,8]:
    B = L.weyl_basis(n)
    M = rng.normal(size=(n,n)); M=(M+M.T)/2; np.fill_diagonal(M,0)
    u = np.linalg.solve(np.eye(n)*(n-2)+np.ones((n,n)), M.sum(1))
    M = M-(u[:,None]+u[None,:]); np.fill_diagonal(M,0)
    W = L.W_from_M(M); W/=np.sqrt(L.ip(W,W)); M = L.M_from_W(W)
    th = L.P(W)
    full,_,_ = L.lam_max_perp(W,n,B)
    dl,_ = L.diag_L_eigs(M)
    print(f"n={n} rowsum={np.abs(M.sum(1)).max():.1e} theta={th:.6f} critresid={np.abs(L.Q(W)-th*W).max():.2e} "
          f"diag lam_max(L_W)={dl[-1]:.8f}  full lam_max(L_W|Wperp)={full:.8f}  ok={dl[-1]<=full+1e-12}")
