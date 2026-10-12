"""J4: is dim ker M = 1 a theorem? and does a bigger kernel revive the deformation family?"""
import sys; sys.path.insert(0,'scripts/reviewers/r304')
import numpy as np, r304_core as C
np.set_printoptions(precision=5,suppress=True,linewidth=200)

def block4(c):
    """4-vertex diagonal critical point: M01=M23=2c, rest -c ; theta = 3c."""
    M=-c*np.ones((4,4)); np.fill_diagonal(M,0)
    M[0,1]=M[1,0]=2*c; M[2,3]=M[3,2]=2*c
    return M

def direct_sum(A,B):
    n=A.shape[0]+B.shape[0]; M=np.zeros((n,n))
    M[:A.shape[0],:A.shape[0]]=A; M[A.shape[0]:,A.shape[0]:]=B
    return M

# two copies of the 4-vertex point, each scaled to keep tr M^2 = 2
c=1/np.sqrt(12)/np.sqrt(2)
M=direct_sum(block4(c),block4(c)); n=8
print("direct sum of two 4-vertex critical points, n=8")
print(" tr M^2 =",np.sum(M*M)," rowsums=",np.abs(M.sum(1)).max())
print(" theta =",C.theta_of(M)," crit residual =",np.abs(C.crit_residual(M)).max())
ev=np.linalg.eigvalsh(M); ker=np.abs(ev)<1e-10
print(" spectrum:",np.round(ev,5)," dim ker M =",int(ker.sum()))
d,_=C.defect_delta(M); print(" Delta =",d)

# the deformation family on the kernel
V=np.linalg.eigh(M)[1][:,ker]
print(" kernel basis:"); print(V.T)
for k in range(V.shape[1]):
    a=V[:,k]; N=2*M*(a[:,None]+a[None,:])
    proj=np.sum(M*N)/2*M
    print(f"  a{k}: ||N||={np.linalg.norm(N):.5f}  rowsum={np.abs(N.sum(1)).max():.1e}  "
          f"||N - <M,N>M/2||={np.linalg.norm(N-proj):.5f}   (0 means N is radial)")

# explicit non-radial admissible member: a = 1_A
a=np.zeros(n); a[:4]=1.0
print(" M a =",np.abs(M@a).max())
N=2*M*(a[:,None]+a[None,:])
Np=N-np.sum(M*N)/2*M              # project off the radial direction
print(f" a=1_A: ||N||={np.linalg.norm(N):.5f} rowsum={np.abs(N.sum(1)).max():.1e} "
      f"||N_perp||={np.linalg.norm(Np):.5f} <M,N_perp>={np.sum(M*Np):.2e}")
th=C.theta_of(M)
R=float(np.sum(Np*C.calL(M,Np)))/float(np.sum(Np*Np))
print(f" Rayleigh(N_perp) = {R:.6f}  vs theta/2 = {th/2:.6f}   exceeds={R>th/2}")
# the withdrawn theta-free criterion, evaluated on this admissible direction
S1=sum((a[i]+a[j])**2*M[i,j]**3 for i in range(n) for j in range(n) if i!=j)
MdM=M@np.diag(a)@M
S2=2*sum(M[i,j]*(a[i]+a[j])*MdM[i,j] for i in range(n) for j in range(n) if i!=j)
print(f" theta-free criterion value on a=1_A: {S1+S2:+.6f}")
# also check the claimed identity (calL N)_ij = (a_i+a_j)(M_ij^2 + theta M_ij) + 2(M diag(a) M)_ij
lhs=C.calL(M,N); rhs=np.zeros((n,n))
for i in range(n):
    for j in range(n):
        if i!=j: rhs[i,j]=(a[i]+a[j])*(M[i,j]**2+th*M[i,j])+2*MdM[i,j]
print(" identity residual (hollow):",np.abs(C.hollow(lhs-rhs)).max())
