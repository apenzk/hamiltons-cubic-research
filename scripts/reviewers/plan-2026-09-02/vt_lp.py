import numpy as np, itertools, sys
from fractions import Fraction as Fr
from scipy.optimize import linprog
def vt_lp(n, mu, mult, cap=True):
    mu=np.array(mu,float); mult=np.array(mult,int); d=len(mu)
    assert abs(mult@mu)<1e-9 and abs(mult@mu**2-1)<1e-9, (mult@mu, mult@mu**2)
    types=list(itertools.combinations_with_replacement(range(d),3))
    def coeff(i,t,w):
        return sum(w(p[1],p[2]) for p in set(itertools.permutations(t)) if p[0]==i)
    rows=[];rhs=[]
    for i in range(d):
        if mult[i]==0: continue
        rows.append([coeff(i,t,lambda j,k:1) for t in types]+[0]); rhs.append(2*(n-2)*mult[i])
        rows.append([coeff(i,t,lambda j,k:mu[j]) for t in types]+[0]); rhs.append(-2*mu[i]*mult[i])
        rows.append([coeff(i,t,lambda j,k:mu[j]*mu[k]) for t in types]+[-2*mu[i]*mult[i]]); rhs.append(-2*mu[i]**2*mult[i])
    A=np.array(rows,float); b=np.array(rhs,float)
    # hollow: type (i,i,i) needs mult>=3, (i,i,j) needs mult_i>=2
    ub=[]
    for t in types:
        c=1
        for i in range(d):
            k=t.count(i)
            for r in range(k): c*=max(mult[i]-r,0)
        ub.append(0 if c==0 else None)
    bounds=[(0,u) for u in ub]+[(None,None)]
    Aub=None;bub=None
    if cap:
        # pair cap: for ordered pair classes (i,j): sum_k N_{ijk} <= 2 * #ordered distinct pairs
        Aub=[];bub=[]
        for i in range(d):
            for j in range(d):
                if mult[i]==0 or mult[j]==0: continue
                row=[0]*(len(types)+1)
                for ti,t in enumerate(types):
                    row[ti]=sum(1 for p in set(itertools.permutations(t)) if p[0]==i and p[1]==j)
                npairs=mult[i]*mult[j] if i!=j else mult[i]*(mult[i]-1)
                Aub.append(row); bub.append(2*npairs)
    c=np.zeros(len(types)+1); c[-1]=-1
    r=linprog(c,A_eq=A,b_eq=b,A_ub=Aub,b_ub=bub,bounds=bounds,method='highs')
    return (-r.fun if r.status==0 else None), np.linalg.matrix_rank(A), r
def sphere(p,q):
    n=p+q; a=1/(p-1)-1/(n-1); b=1/(q-1)-1/(n-1); c=-1/(n-1)
    mult=[p*(p-1)//2,q*(q-1)//2,p*q]; mu=np.array([a,b,c]); nrm=np.sqrt(np.array(mult)@mu**2)
    return n, mu/nrm, mult, 1/nrm
if __name__=="__main__":
    for (p,q) in [(6,6),(5,7),(4,8),(3,9),(2,10),(4,4),(3,5),(5,5)]:
        n,mu,mult,th=sphere(p,q)
        for cap in (False,True):
            v,rk,_=vt_lp(n,mu,mult,cap)
            print(f"S^{p}xS^{q} n={n} true theta={th:.6f} theta0={np.sqrt(2*(n-1)*(n-2))/n:.6f} LPmax={v:.6f} rank={rk} cap={cap}")
    # padded CP2 at n=5 and n=12
    for n in (5,8,12):
        N=n*(n-1)//2; mu=[2/np.sqrt(6),-1/np.sqrt(6),0]; mult=[1,2,N-3]
        for cap in (False,True):
            v,rk,_=vt_lp(n,mu,mult,cap); print(f"padded CP2 n={n} true={np.sqrt(1.5):.6f} LPmax={v} rank={rk} cap={cap}")
    m=1/np.sqrt(61.05)
    for cap in (False,True):
        v,rk,_=vt_lp(12,[-m,1.2*m,0.375*m],[30,20,16],cap); print(f"n=12 witness LPmax={v} rank={rk} cap={cap}")
