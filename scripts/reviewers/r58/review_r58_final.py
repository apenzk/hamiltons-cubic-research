import numpy as np, sympy as sp, sys
sys.path.insert(0, 'scripts/lib')
from review_r58_core import *
from review_r58_sk2 import Rring_mat, sigma_and_b
from review_r58_iii import weyl4_12
from scipy.optimize import brentq

print('=== A. exact crossover for the reduced item (iii):  2 b Sigma <= theta  on the padded Weyl_4 stratum ===')
q,r=sp.symbols('q r',positive=True)
nrm2=(q+r)**2+q**2+r**2
th=9*q*r*(q+r)/nrm2**sp.Rational(3,2)
bb=sp.Max(q,r)/sp.sqrt(nrm2)
ineq=sp.simplify(sp.expand(2*nrm2-9*r*(q+r)))          # 2bSigma<=theta  <=>  2*nrm2 <= 9 r (q+r)   (q>r, Sigma=1)
print('   with Sigma=1 and b=q/|W| (q>r): condition is  2*(|W|^2) <= 9 r (q+r), i.e.', sp.factor(ineq), '<= 0')
sol=sp.solve(sp.Eq(ineq.subs(q,1),0),r); print('   at q=1 the root is r* =',[sp.nsimplify(s) for s in sol if s.is_real and s>0],'=',[float(s) for s in sol if s.is_real and s>0])
rstar=float([s for s in sol if s.is_real and s>0][0])
th_star=float(th.subs({q:1,r:rstar}))
print('   r*/q = %.6f  ->  theta = %.6f  = %.4f * sqrt(3/2)'%(rstar,th_star,th_star/np.sqrt(1.5)))

print()
print('=== B. exact crossover for item (iii) itself:  lam_max(Rring_e) <= 1 ===')
def g(rr):
    W=pad(weyl4_12(1.0,rr),4,6); return np.linalg.eigvalsh(Rring_mat(W,6))[-1]/theta(W,6)-1.0
rc=brentq(g,0.25,0.45,xtol=1e-13)
W=pad(weyl4_12(1.0,rc),4,6)
print('   r_c/q = %.9f  ->  theta = %.6f = %.4f * sqrt(3/2) ;  lam_max(Rring_e) = %.9f'%(
    rc,theta(W,6),theta(W,6)/np.sqrt(1.5),np.linalg.eigvalsh(Rring_mat(W,6))[-1]/theta(W,6)))
print('   => item (iii) holds on the stratum only for theta >~ %.4f*sqrt(3/2); the REDUCTION 2bSigma<=theta'%(theta(W,6)/np.sqrt(1.5)))
print('      already fails at %.4f*sqrt(3/2), so the reduction discards a band where item (iii) is true.'%(th_star/np.sqrt(1.5)))

print()
print('=== C. Claim 2 (padding reduction), verified and strengthened ===')
print('    proof: Ric = sum_a lam_a v_a v_a^T = 0  =>  sum_{lam>0} lam_a M_a = sum_{lam<0}|lam_a| M_a =: S,')
print('    both sides psd, so every eigenvector image lies in U := im v_{N-1} + im v_N, dim U <= r1+r2.')
rng=np.random.default_rng(3)
for (q_,r_) in [(1,1),(1,0.4),(2,0.3)]:
    for n in [6,8,9]:
        W=pad(weyl4_12(q_,r_),4,n); N=n*(n-1)//2; P=phis(n)
        lam,V=np.linalg.eigh(W)
        nz=[i for i in range(N) if abs(lam[i])>1e-10]
        neg=[i for i in nz if lam[i]<0]
        rk=lambda M:int(np.sum(np.linalg.svd(M,compute_uv=False)>1e-8))
        vs=[np.einsum('p,pij->ij',V[:,i],P) for i in neg]
        U=np.hstack([v for v in vs]); dU=np.linalg.matrix_rank(U,tol=1e-8)
        # kernel of W on u ^ u-perp for u orthogonal to U
        uu,ss,vv=np.linalg.svd(U); u=uu[:,dU:]
        worst=0.0
        for c in range(u.shape[1]):
            for j in range(n):
                M=np.outer(u[:,c],np.eye(n)[j])-np.outer(np.eye(n)[j],u[:,c])
                bv=np.array([0.5*np.trace(M.T@P[p]) for p in range(N)])
                worst=max(worst,np.max(np.abs(W@bv)))
        nzero=int(np.sum(np.abs(lam)<1e-10))
        print('   q=%.0f r=%.1f n=%d : ranks(neg)=%s  sum=%d  dim U=%d  #zero eigenvalues=%d (>= n-1 = %d)  max|W(u^w)|=%.1e'%(
            q_,r_,n,[rk(v) for v in vs],sum(rk(v) for v in vs),dU,nzero,n-1,worst))

print()
print('=== D. Lemma 29 equality case: is the reverse direction of the "iff" true on the stratum? ===')
for n in [5,6,8]:
    W=pad(wcp2(),4,n)
    print('   n=%d: spectrum (2,-1,-1)/sqrt6 -> theta = %.12f (= sqrt(3/2)? %s)'%(n,theta(W,n),abs(theta(W,n)-np.sqrt(1.5))<1e-12))
