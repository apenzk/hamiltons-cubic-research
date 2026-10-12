import sys; sys.path.insert(0,'scripts/reviewers/r323')
import numpy as np, core, lem70
rng=np.random.default_rng(31)
n=6; c=core.Ctx(n)
print('--- (a) ingredients of L1 OFF Weyl_n and at NON-critical points ---')
for lab,gen in [('random Weyl (non-critical)',lambda: np.einsum('k,kab->ab',rng.normal(size=c.W.shape[0]),c.W)),
                ('random symmetric, NOT Weyl',lambda: (lambda A:(A+A.T))(rng.normal(size=(c.N,c.N))))]:
    for t in range(3):
        W=gen(); W/=np.sqrt(np.trace(W@W))
        lam,Phi=np.linalg.eigh(W); v=Phi[:,0]      # lambda_min eigenvector
        A=core.ad_of(c,v); Ae=(Phi.T@A@Phi).T; x=Ae**2
        s_mass=x.sum(); s_sharp=0.5*float(np.sum(np.outer(lam,lam)*x))
        true=float(v@core.sharp(c,W)@v)
        th,res=core.crit_residual(c,W)
        D=0.5*float(np.sum((np.outer(lam,lam)-lam[0]*lam[-1])*x))
        idres=abs(lam[0]+(n-2)*lam[-1]-D/abs(lam[0])-th)
        print(f'  {lab:28s} mass={s_mass:.9f} (2(n-2)={2*(n-2)})  <v,W#v>: expansion-vs-direct={abs(s_sharp-true):.1e}  critres={res:.1e}  L1 identity gap={idres:.6f}')
print('--- (b) Weyl-only marginal identity sum_a lambda_a m_a = -2 lambda_min ---')
for lab,gen in [('Weyl',lambda: np.einsum('k,kab->ab',rng.normal(size=c.W.shape[0]),c.W)),
                ('NOT Weyl',lambda: (lambda A:(A+A.T))(rng.normal(size=(c.N,c.N))))]:
    W=gen(); W/=np.sqrt(np.trace(W@W)); lam,Phi=np.linalg.eigh(W); v=Phi[:,0]
    A=core.ad_of(c,v); Ae=(Phi.T@A@Phi).T; x=Ae**2
    print(f'  {lab:10s} sum lambda_a m_a = {float(np.sum(lam*x.sum(1))):.9f}   -2*lambda_min = {-2*lam[0]:.9f}')
print('--- (c) D>=0 needs lambda_max>=0: an all-negative-spectrum symmetric operator ---')
Wneg=-np.diag(np.arange(1,c.N+1,dtype=float)); Wneg/=np.sqrt(np.trace(Wneg@Wneg))
lam,Phi=np.linalg.eigh(Wneg); v=Phi[:,0]
A=core.ad_of(c,v); Ae=(Phi.T@A@Phi).T; x=Ae**2
D=0.5*float(np.sum((np.outer(lam,lam)-lam[0]*lam[-1])*x))
print(f'  spectrum all negative: lmin={lam[0]:.6f} lmax={lam[-1]:.6f}  D = {D:.9f}  (NEGATIVE => the D>=0 step fails)')
