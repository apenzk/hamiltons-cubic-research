"""Reviewer 55, K4d: blow-ups of triangle-free strongly regular graphs.

For an SRG(k, delta, lambda, mu) the 3-parameter ansatz C = d I + p A + q B
(B = J - I - A) CLOSES under the block criticality system, because A^2 =
delta I + lambda A + mu B.  Block equations (blocks all of size m):

  diagonal      m (C^2)_I - d^2 = t d
  G-adjacent    p^2 + m (C^2)_A - 2 d p = t p
  non-adjacent  q^2 + m (C^2)_B - 2 d q = t q
  Weyl          (m-1) d + m delta p + m (k-1-delta) q = 0

lambda = 0 is exactly triangle-freeness of G, so the blow-up's negative graph is
triangle-free (S = 0) whenever p < 0 <= d, q.
"""
import sympy as sp

def srg_ratio(k, delta, lam, mu, name):
    m, d, p, q, t = sp.symbols('m d p q t')
    CI = d**2 + p**2*delta + q**2*(k-1-delta)
    CA = p**2*lam + q**2*(k-2*delta+lam) + 2*d*p + 2*p*q*(delta-1-lam)
    CB = p**2*mu + q**2*(k-2-2*delta+mu) + 2*d*q + 2*p*q*(delta-mu)
    eqs = [m*CI - d**2 - t*d,
           p**2 + m*CA - 2*d*p - t*p,
           q**2 + m*CB - 2*d*q - t*q,
           (m-1)*d + m*delta*p + m*(k-1-delta)*q]
    eqs = [e.subs(d,1) for e in eqs]
    sols = sp.solve(eqs, [p,q,t], dict=True)
    out=[]
    for s in sols:
        pv, qv = sp.simplify(s[p]), sp.simplify(s[q])
        C = sp.zeros(3,3)
        # theta/theta_0 in closed form via the block-level formulas
        n = k*m
        # sum_{i!=j} lam_ij^3
        S3 = m*m*(k*1 + k*delta*pv**3 + k*(k-1-delta)*qv**3) - m*k*1
        nrm2 = sp.Rational(1,2)*(m*m*(k*1 + k*delta*pv**2 + k*(k-1-delta)*qv**2) - m*k*1)
        # tr(B^3) where B_ij = C_{a(i)a(j)} for all i,j: = m^3 tr(Cm^3) with Cm the k x k C
        Cm = sp.eye(k)  # placeholder; build numerically instead
        out.append((pv,qv,sp.simplify(s[t]),S3,nrm2))
    return sols

# numeric evaluation is easier and exact enough; do it with the k x k matrix
import numpy as np, itertools
def srg_adj(name):
    if name=='C5':
        A=np.zeros((5,5))
        for a in range(5): A[a,(a+1)%5]=A[(a+1)%5,a]=1
        return A,(5,2,0,1)
    if name=='Petersen':
        V=list(itertools.combinations(range(5),2)); k=10
        A=np.zeros((k,k))
        for i in range(k):
            for j in range(i+1,k):
                if not set(V[i])&set(V[j]): A[i,j]=A[j,i]=1
        return A,(10,3,0,1)
    if name=='Clebsch':
        # folded 5-cube: vertices = even-weight subsets of {0..4} mod complement
        V=[s for s in range(32) if bin(s).count('1')%2==0]
        # 16 vertices; adjacency: Hamming distance 4 in F_2^5 modulo complement -> use halved 5-cube
        k=16; A=np.zeros((k,k))
        for i in range(k):
            for j in range(i+1,k):
                x=V[i]^V[j]; w=bin(x).count('1')
                if w==4: A[i,j]=A[j,i]=1
        return A,(16,5,0,2)
    if name=='HoffmanSingleton':
        return None,(50,7,0,1)
    if name=='Gewirtz':  return None,(56,10,0,2)
    if name=='M22':      return None,(77,16,0,4)
    if name=='HigmanSims': return None,(100,22,0,6)
    raise KeyError(name)

def theta_ratio(k,delta,lam,mu,m,pv,qv,dv=1.0):
    """theta/theta_0 of the blow-up, from the (d,p,q) values, block level."""
    n=k*m
    # Lambda has: within-block off-diagonal entries d (k*m*(m-1) ordered pairs)
    #             G-adjacent blocks: p   (k*delta*m^2 ordered pairs)
    #             non-adjacent:      q   (k*(k-1-delta)*m^2 ordered pairs)
    nA=k*delta*m*m; nB=k*(k-1-delta)*m*m; nD=k*m*(m-1)
    nrm2=0.5*(nD*dv**2+nA*pv**2+nB*qv**2)
    s3=nD*dv**3+nA*pv**3+nB*qv**3
    # tr(Lambda^3): build the k x k matrix and blow up spectrally
    A,_=srg_adj_cached[k]
    C=dv*np.eye(k)+pv*A+qv*(np.ones((k,k))-np.eye(k)-A)
    # Lambda = C (x) J_m - d I_n   (Kronecker with all-ones m x m)
    muC=np.linalg.eigvalsh(C)*m          # eigenvalues of C (x) J_m (nonzero part)
    ev=np.concatenate([muC, np.zeros(k*(m-1))])-dv
    trL3=float((ev**3).sum())
    P=0.5*(s3+trL3); nrm=np.sqrt(nrm2)
    th=P/nrm**3; th0=np.sqrt(2*(n-1)*(n-2))/n
    return th/th0

srg_adj_cached={}
from scipy.optimize import fsolve
def solve_srg(k,delta,lam,mu,m):
    def F(x):
        d,p,q,t=1.0,x[0],x[1],x[2]
        CI=d**2+p**2*delta+q**2*(k-1-delta)
        CA=p**2*lam+q**2*(k-2*delta+lam)+2*d*p+2*p*q*(delta-1-lam)
        CB=p**2*mu+q**2*(k-2-2*delta+mu)+2*d*q+2*p*q*(delta-mu)
        return [m*CI-d**2-t*d, p**2+m*CA-2*d*p-t*p, q**2+m*CB-2*d*q-t*q]
    best=[]
    rng=np.random.default_rng(0)
    for _ in range(400):
        x0=rng.normal(scale=1.0,size=3)
        s,info,ier,msg=fsolve(F,x0,full_output=True)
        if ier!=1 or max(abs(np.array(F(s))))>1e-9: continue
        # Weyl row sum must hold too
        rs=(m-1)*1.0+m*delta*s[0]+m*(k-1-delta)*s[1]
        if abs(rs)>1e-8: continue
        if not any(np.allclose(s,b,atol=1e-7) for b in best): best.append(s)
    return best

if __name__=="__main__":
    print(f"{'graph':>18} {'(k,d,l,mu)':>16} {'m':>5} {'theta/theta0':>13} {'p<0?':>6}")
    for name in ('C5','Petersen','Clebsch'):
        A,par=srg_adj(name); k,delta,lam,mu=par
        srg_adj_cached[k]=(A,par)
        for m in (2,3,5,10,50,200,2000):
            sols=solve_srg(k,delta,lam,mu,m)
            rows=[]
            for s in sols:
                pv,qv,t=s
                r=theta_ratio(k,delta,lam,mu,m,pv,qv)
                rows.append((r,pv,qv))
            rows=[r for r in rows if r[1]<0]        # negative on G-edges => S=0
            if not rows: print(f"{name:>18} {str(par):>16} {m:5d}  no p<0 branch"); continue
            r=max(rows)
            print(f"{name:>18} {str(par):>16} {m:5d} {r[0]:13.9f} {'yes':>6}")
    print("\n--- larger triangle-free SRGs (adjacency not built; parameters only) ---")
    for name in ('HoffmanSingleton','Gewirtz','M22','HigmanSims'):
        _,par=srg_adj(name); k,delta,lam,mu=par
        # build the k x k C spectrally: SRG eigenvalues
        r_=0.5*((lam-mu)+np.sqrt((lam-mu)**2+4*(delta-mu)))
        s_=0.5*((lam-mu)-np.sqrt((lam-mu)**2+4*(delta-mu)))
        fmult=0.5*((k-1)-(2*delta+(k-1)*(lam-mu))/np.sqrt((lam-mu)**2+4*(delta-mu)))
        gmult=k-1-fmult
        print(f"{name:>18} {str(par):>16}  SRG eigenvalues r={r_:.3f} (mult {gmult:.0f}), s={s_:.3f} (mult {fmult:.0f})")
