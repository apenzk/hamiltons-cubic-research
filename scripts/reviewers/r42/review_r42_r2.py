import numpy as np, sys
sys.path.insert(0, 'scripts/lib')
from review_r42_core import *
for m in range(3,9):
    n=2*m; P=pairs(n); N=len(P); J=Jmat(n); Id=np.eye(N)
    # claim A: P_omega_{ab} = omega_a omega_b/|omega|^2
    w=omega_vec(n); PA=np.outer(w,w)/(w@w)
    # independent: projection onto the line R.J inside Lambda^2 with <X,Y>=1/2 tr(X^T Y)
    cols=[]
    for (i,j) in P:
        E=phi(n,i,j); coef=0.5*np.trace(J.T@E)/(0.5*np.trace(J.T@J))
        F=coef*J; cols.append(np.array([F[k,l] for (k,l) in P]))
    PB=np.array(cols).T
    # claim B: index formula, contracted over k<l  vs over all k,l
    Pkl=np.zeros((N,N)); Pall=np.zeros((N,N))
    for a,(i,j) in enumerate(P):
        for b,(k,l) in enumerate(P):
            v=0.5*((int(i==k)*int(j==l)-int(i==l)*int(j==k)) + J[i,k]*J[j,l]-J[i,l]*J[j,k])
            Pkl[a,b]=v
    Pall=2*Pkl   # summing over all k,l doubles the k<l sum for an ij-kl antisymmetric kernel
    Ptrue=P_u(n)
    print(f"m={m}: |Pomega(index)-Pomega(line)|={np.abs(PA-PB).max():.1e}  |omega|^2={w@w:.1f}  "
          f"|Pu(k<l)-Pu(true)|={np.abs(Pkl-Ptrue).max():.1e}  |Pu(all k,l)-Pu|={np.abs(Pall-Ptrue).max():.1e}  "
          f"Pu idem={np.abs(Ptrue@Ptrue-Ptrue).max():.1e} tr Pu={np.trace(Ptrue):.1f} (m^2={m*m}) "
          f"tr Pm={np.trace(np.eye(N)-Ptrue):.1f} (m(m-1)={m*(m-1)}) tr Psu={np.trace(P_su(n)):.1f}")
