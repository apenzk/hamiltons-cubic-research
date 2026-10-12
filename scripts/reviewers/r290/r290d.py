import numpy as np, io, contextlib
buf=io.StringIO()
with contextlib.redirect_stdout(buf): from r290 import *
def quiet(W,n,psi_diag=True):
    b=io.StringIO()
    with contextlib.redirect_stdout(b): r=analyse(W,n,psi_diag,verbose=True,name="")
    return r
print("point                theta    Mp       m        MAJ-bound  TRIVIAL 1.5(Mp+m)  POST33 p3min  P33-bound")
def row(name,W,n):
    r=quiet(W,n); M,_=Mmat(W,n); mu=np.linalg.eigvalsh(M)
    Ring,_,_=ring_op(W,n); om=np.linalg.eigvalsh(Ring)
    Mp,m_=r['Mp'],r['m']; N=n*(n+1)//2-1
    triv=1.5*Mp+1.5*m_
    p3min=9/(16*m_*N)-3*m_/4
    p33=1.5*Mp-0.5*p3min                       # same charity: p3(mu)<=Mp, p3(om)>=p3min
    p33true=1.5*np.sum(mu**3)-0.5*p3min        # maximal charity: true p3(mu)
    majmin=r['bnd']
    print(f"{name:20s} {r['th']:+.5f} {Mp:.5f} {m_:.5f}  {majmin:8.5f}   {triv:8.5f}        {p3min:+.5f}    {p33:8.5f} (true-p3mu: {p33true:.5f})")
    print(f"{'':20s} p3(om) true={np.sum(om**3):+.6f}  maj lower bd on p3(om)={-2*(r['bnd']-1.5*(np.sum(mu**3)+3*Mp*(1-np.sum(np.diag(M)**2))))if False else 0:.0f}")
W4=weyl_part(cp2(4),4)
for n in [8,12,16,24]:
    Wp=np.zeros((n,)*4); Wp[:4,:4,:4,:4]=W4; M,_=Mmat(Wp,n); Wp=Wp/np.linalg.norm(M)
    row(f"padded CP2 n={n}",Wp,n)
for (p,q) in [(4,4),(6,6),(5,7)]:
    n=p+q; W=weyl_part(prod_sphere(p,q),n); M,_=Mmat(W,n); W=W/np.linalg.norm(M)
    row(f"S^{p}xS^{q}",W,n)

print("\n=== direct comparison of the two LOWER BOUNDS on p3(omega) at padded CP2, n=12 ===")
n=12; Wp=np.zeros((n,)*4); Wp[:4,:4,:4,:4]=W4; M,_=Mmat(Wp,n); Wp=Wp/np.linalg.norm(M)
M,idx=Mmat(Wp,n); Ring,B,lab=ring_op(Wp,n); om=np.linalg.eigvalsh(Ring)
N2=len(idx); blk=Ring[N2:,N2:]; d=np.linalg.eigvalsh(blk)
Kp=np.concatenate([np.diag(Ring)[:N2],d]); m_=-om.min(); N=n*(n+1)//2-1
maj=np.sum(Kp**3)+3*m_*(np.sum(Kp**2)-3)
p33=9/(16*m_*N)-3*m_/4
print(f"  true p3(omega) = {np.sum(om**3):+.6f}")
print(f"  majorization lower bound  = {maj:+.6f}   (gap {np.sum(om**3)-maj:.6f})")
print(f"  post-33 moment lower bound= {p33:+.6f}   (gap {np.sum(om**3)-p33:.6f})")
print(f"  trivial -3m               = {-3*m_:+.6f}   (gap {np.sum(om**3)+3*m_:.6f})")

print("\n=== frame dependence of the CP2 off-diagonal masses (random rotations, n=8) ===")
from scipy.linalg import expm
rng=np.random.default_rng(4)
n=8; Wp=np.zeros((n,)*4); Wp[:4,:4,:4,:4]=W4; M,_=Mmat(Wp,n); Wp=Wp/np.linalg.norm(M)
def skew(v,n):
    A=np.zeros((n,n)); iu=np.triu_indices(n,1); A[iu]=v; return A-A.T
for k in range(5):
    O=expm(skew(rng.standard_normal(n*(n-1)//2),n))
    r=quiet(rot_tensor(Wp,O),n)
    print(f"   random frame {k}: |M_off|^2={r['offM']:.6f} |Ring_off|^2={r['offR']:.6f} bound={r['bnd']:.6f}")
