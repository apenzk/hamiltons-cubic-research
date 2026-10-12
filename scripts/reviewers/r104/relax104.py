"""Reviewer 104: the both-sided Schur-Horn relaxation, solved side by side.

max (3/2) p3(mu) - (1/2) p3(om)  s.t.  ||mu||^2=1, ||om||^2=3, sum=0,
                                        mu >- d_phi(K),  om >- d(K).
The objective SEPARATES: the two sides share only K.
"""
import numpy as np
from scipy.optimize import minimize, linprog

def okumura_max(N, S):
    """max p3 over {sum x =0, ||x||^2=S}: attained at (c(N-1),-c,...,-c)."""
    return (N-2)/np.sqrt(N*(N-1))*S**1.5

def inner_opt(d, S, sign, nstarts=60, seed=0):
    """max sign*p3(x) s.t. sum x = 0, ||x||^2 = S, x >- d.  Returns (value, x).
    x parametrised sorted descending; majorization = linear cumsum inequalities."""
    d = np.sort(np.asarray(d, float))[::-1]
    N = len(d)
    cd = np.cumsum(d)
    rng = np.random.default_rng(seed)

    def negobj(x): return -sign*np.sum(x**3)
    def negjac(x): return -sign*3*x**2

    cons = [
        {'type':'eq','fun':lambda x: np.sum(x),        'jac':lambda x: np.ones(N)},
        {'type':'eq','fun':lambda x: np.sum(x**2)-S,   'jac':lambda x: 2*x},
        {'type':'ineq','fun':lambda x: np.cumsum(x)[:-1]-cd[:-1],
         'jac':lambda x: np.tril(np.ones((N-1,N)))[:, :N]},
        {'type':'ineq','fun':lambda x: x[:-1]-x[1:],
         'jac':lambda x: np.eye(N-1,N)-np.eye(N-1,N,1)},
    ]
    best=(-np.inf,None)
    c = np.sqrt(S/max(np.sum(d**2),1e-300))
    # deterministic starts: scaled diagonal, Okumura shapes, flat-ish
    ok_pos = np.concatenate([[ (N-1)],-np.ones(N-1)]); ok_pos*= np.sqrt(S/np.sum(ok_pos**2))
    ok_neg = -ok_pos[::-1]
    starts=[c*d, ok_pos, np.sort(ok_neg)[::-1]]
    for k in range(2,min(N,8)):
        v=np.concatenate([np.ones(k)*(N-k), -np.ones(N-k)*k]).astype(float)
        v*=np.sqrt(S/np.sum(v**2)); starts.append(v)
        starts.append(np.sort(-v)[::-1])
    for _ in range(nstarts):
        z=np.sort(rng.standard_normal(N))[::-1]; z=z-z.mean(); z*=np.sqrt(S/np.sum(z**2))
        starts.append(z)
    for x0 in starts:
        try:
            r=minimize(negobj,x0,jac=negjac,constraints=cons,method='SLSQP',
                       options={'maxiter':500,'ftol':1e-12})
        except Exception:
            continue
        x=r.x
        # strict feasibility audit
        if abs(np.sum(x))>1e-7: continue
        if abs(np.sum(x**2)-S)>1e-7: continue
        xs=np.sort(x)[::-1]
        if (np.cumsum(xs)[:-1]-cd[:-1]).min()<-1e-7: continue
        v=sign*np.sum(x**3)
        if v>best[0]: best=(v,xs)
    return best

def d_from_K(K):
    n=K.shape[0]
    P=[(i,j) for i in range(n) for j in range(i+1,n)]
    dphi=np.array([K[i,j] for (i,j) in P])
    # psi block: eigenvalues of K on 1^perp; K1=0 so spec(K) = {0} u spec(K|1perp)
    ev=np.linalg.eigvalsh(K)
    # drop one zero eigenvalue (the one for vector 1)
    i0=np.argmin(np.abs(ev)); ev=np.delete(ev,i0)
    d=np.concatenate([dphi,-ev])
    return dphi,d

def relax_for_K(K,seed=0,nstarts=40):
    dphi,d=d_from_K(K)
    a,_=inner_opt(dphi,1.0,+1,nstarts=nstarts,seed=seed)
    b,_=inner_opt(d,3.0,-1,nstarts=nstarts,seed=seed+1)
    return 1.5*a+0.5*b, 1.5*a, 0.5*b

def random_vertex_matrix(n,t,rng):
    A=rng.standard_normal((n,n)); K=(A+A.T)/2; np.fill_diagonal(K,0)
    for _ in range(500):
        rs=K.sum(axis=1)
        K=K-(np.add.outer(rs,rs))/(n-2)+(rs.sum()/((n-1)*(n-2)))*(np.ones((n,n))-np.eye(n))
        np.fill_diagonal(K,0); K=(K+K.T)/2
        if np.abs(K.sum(axis=1)).max()<1e-15: break
    return K/np.linalg.norm(K)*np.sqrt(t)
