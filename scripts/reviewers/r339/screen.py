import numpy as np, itertools
def srg_M(v,k,lam,mu,A,sign=1.0):
    w=v-1-k
    a=sign*np.sqrt(2.0*w/(v*k*(v-1)))
    b=-a*k/w
    M=a*A+b*(np.ones((v,v))-np.eye(v)-A)
    return M
def check(M,name):
    v=M.shape[0]
    s=(M*M).sum(1)
    R=M*M+M@M-np.diag(s)          # = theta*M off-diagonal
    # theta by contraction: 2*theta = <M^o2+M^2, M> since M1=0
    th=0.5*np.sum((M*M+M@M)*M)
    res=np.abs(R-th*M).max()
    nrm=np.sqrt((M**2).sum()/2)
    ev=np.array([M[i,j] for i in range(v) for j in range(i+1,v)])
    lmax,lmin=ev.max(),ev.min()
    l70=lmin+(v-2)*lmax
    print(f"{name:22s} |W|={nrm:.9f} theta={th:.9f} crit_res={res:.2e} rowsum={np.abs(M.sum(1)).max():.1e} "
          f"lmax={lmax:.6f} lmin={lmin:.6f} ratio={lmax/abs(lmin):.6f} n/(n-2)={v/(v-2):.6f} n-2={v-2} "
          f"L70={l70:.9f} slack={l70-th:.9f} theta0={np.sqrt(2*(v-1)*(v-2))/v:.9f}")
# octahedron K_{2,2,2}: complement of perfect matching on 6
v=6; A=np.ones((6,6))-np.eye(6)
for i in range(0,6,2): A[i,i+1]=A[i+1,i]=0
for sg in (1,-1): check(srg_M(6,4,2,4,A,sg), f"octahedron a{'>' if sg>0 else '<'}0")
# K_{3,3}
A=np.zeros((6,6))
for i in range(3):
    for j in range(3,6): A[i,j]=A[j,i]=1
for sg in (1,-1): check(srg_M(6,3,0,3,A,sg), f"K33 a{'>' if sg>0 else '<'}0")
# C5
A=np.zeros((5,5))
for i in range(5): A[i,(i+1)%5]=A[(i+1)%5,i]=1
check(srg_M(5,2,0,1,A,1), "C5")
# Petersen SRG(10,3,0,1)
import networkx
