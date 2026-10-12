"""The sharp form of G4: tr_{Weyl_n}(L_Y) = c_n tr(Y) for EVERY symmetric Y on Lambda^2."""
import sys; sys.path.insert(0,'scripts/reviewers/r300')
import numpy as np, core300 as C
rng = np.random.default_rng(7)
print(" n  dim   N   c_n(fit)      max|tr(L_Y)-c_n tr Y| over 6 random Y   c_n predicted?")
for n in (5,6,7,8):
    B=C.weyl_basis(n); D=len(B); N=B.shape[1]
    def F(Y):
        return sum(float(np.tensordot(Bk, C.circ(n,Y,Bk))) for Bk in B)
    # fit c from Y = I
    cI = F(np.eye(N))/N
    err=0.0
    for _ in range(6):
        Y=rng.standard_normal((N,N)); Y=0.5*(Y+Y.T)
        err=max(err, abs(F(Y)-cI*np.trace(Y)))
    print(f"{n:2d} {D:4d} {N:3d}  {cI:+.9f}   {err:.2e}   dim/N={D/N:.6f}  (n+... )")
