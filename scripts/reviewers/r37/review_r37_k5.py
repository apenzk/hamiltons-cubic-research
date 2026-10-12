"""K5 + the decisive K4 test.  On each L_e-eigenspace, compare
  RAW scalarity      : sup_{V in E} |sb(I_p,V) - cV| / |V|      (c = best fit)
  COMPRESSED scalarity: same after projecting sb(I_p,V) back onto Weyl_n
A gap between the two is the signature of the leak out of Weyl_n."""
import sys; sys.path.insert(0, 'scripts/lib')
import numpy as np
from review_r37_core import *

def run(p,q,tol=1e-7):
    n=p+q; A=struct_A(n); B=weyl_basis(n); D=B.shape[0]; N=A.shape[0]
    W=W_pq(p,q); theta=ip(Qop(W,A),W)/ip(W,W); e=W/theta
    Ip=I_block(p,q,'p')
    Me=operator_matrix(B, lambda V: circ(e,V,A)); Me=0.5*(Me+Me.T)
    w,v=np.linalg.eigh(Me)
    # cluster eigenvalues
    groups=[]; cur=[0]
    for i in range(1,D):
        if w[i]-w[cur[-1]]<tol: cur.append(i)
        else: groups.append(cur); cur=[i]
    groups.append(cur)
    Msb=operator_matrix(B, lambda V: sharp_bilin(Ip,V,A))   # compressed (projects onto Weyl)
    Msb=0.5*(Msb+Msb.T)
    print(f"  ({p},{q}) n={n} dim Weyl={D}")
    print(f"    {'L_e eig':>10} {'mult':>5} {'best c':>10} {'RAW dev':>10} {'COMPRESSED dev':>15} {'leak':>9}")
    for g in groups:
        lam=float(np.mean(w[g])); m=len(g)
        U=v[:,g]                       # orthonormal coords of the eigenspace
        E=np.einsum('kd,dij->kij', U.T, B)
        G=U.T@Msb@U
        c=float(np.trace(G)/m)
        compdev=np.linalg.norm(G-c*np.eye(m))/max(1.0,np.sqrt(m)*abs(c) if abs(c)>1e-12 else 1.0)
        compdev=np.linalg.norm(G-c*np.eye(m))
        # raw deviation over the eigenspace: max over an orthonormal basis
        rawdev=0.0; leak=0.0
        for V in E:
            S=sharp_bilin(Ip,V,A)
            rawdev=max(rawdev, np.linalg.norm(S-c*V))
            leak=max(leak, np.linalg.norm(S-expand(B,coords(B,S))))
        print(f"    {lam:10.6f} {m:5d} {c:10.6f} {rawdev:10.3e} {compdev:15.3e} {leak:9.3e}", flush=True)

for pq in [(3,4),(4,4),(4,5)]:
    run(*pq)
