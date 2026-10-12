# I73 (c) off L173's ray: is the capped three-value system (pair caps, Ky Fan caps, T7 <= 54.064)
# feasible at theta = 1.2248 > sqrt(3/2) for ANY multiplicity triple and eigenvalue direction?
# Usage: python3 screen_I73c_capped_offray.py N [workers] [T7, a rational, default 54064/1000] [sec5] [gauss]. Screen only; a feasible point is a lead.
import sys, time, numpy as np, sympy as sp
from multiprocessing import Pool
N=int(sys.argv[1]); W=int(sys.argv[2]) if len(sys.argv)>2 else 8
T7ARG=sys.argv[3] if len(sys.argv)>3 else '54064/1000'
SEC5=len(sys.argv)>4 and 'sec5' in sys.argv[4:]
GAUSS='gauss' in sys.argv[4:]
SPREAD='spread' in sys.argv[4:]
here=__file__.rsplit('/',1)[0]
src=open(here+'/screen_I73c_kyfan_lp.py').read().split("R = sp.Rational\nn, m = 12")[0]
src=src.replace("__file__.rsplit('/', 1)[0] + '/screen_I73c_I1_rowspan.py'","'"+here+"/screen_I73c_I1_rowspan.py'")
src=src.replace("def system(n, m, eps, kyfan=True, window=True):","def system(n, m, eps, kyfan=True, window=True, T7=None):")
# every seven-frame drawn from the eigenbasis, composition (k0,k1,k2) with sum 7 and k_a <= m_a:
# sum_a k_a(k_a-1)P(a,a) + 2 sum_{a<b} k_a k_b P(a,b) <= T7 (class averages of L240's bound)
# section 5 of the summed-pair note, at the proved cap mu <= n Theta_n/((n-1) theta), Theta_n = theta_0(n) at even n
src=src.replace("def system(n, m, eps, kyfan=True, window=True, T7=None):","def system(n, m, eps, kyfan=True, window=True, T7=None, mu=None):")
# the Gaussian subspace cap (L238 (ii) at any k): for V a union S of whole classes, k = sum m_a,
# sum_{a,b in S, c} tau_abc <= (1 - 1/r)(4k^2 + 2 sum_{a,b in S} G_ab) - 4k(k-1), r = min(k, n-1)
src=src.replace("def system(n, m, eps, kyfan=True, window=True, T7=None, mu=None):","def system(n, m, eps, kyfan=True, window=True, T7=None, mu=None, gauss=False):")
# the Gaussian cap for frames drawn partly from classes, averaged over random k_a-subsets (L243 at composition k):
# E T = sum k_a(k_a-1)P_aa + 2 sum_{a<b} k_a k_b P_ab; E tr P^2 = sum_a [k_a(k_a-1)/(m_a(m_a-1))(G_aa - D_a) + k_a/m_a D_a]
#       + sum_{a != b} k_a k_b/(m_a m_b) G_ab, with D_a <= 2 m_a (tr(Psi Psi^T)^2 <= 2) entering with a nonnegative coefficient
src=src.replace("def system(n, m, eps, kyfan=True, window=True, T7=None, mu=None, gauss=False):","def system(n, m, eps, kyfan=True, window=True, T7=None, mu=None, gauss=False, gaussK=0):")
# R39's spread caps: averaged over a Haar-random basis of E_c, sum_{alpha in c} ||P_a-part of ad_{psi_alpha}||^2 = tau_{ca.}
# <= m_c * hull_r(q_c), r = m_a - [a==c], q_c = (3 G_cc - tau_cc.)/(2 m_c (m_c+2)), hull = concave envelope of kappa_r in
# q = sum s^4 (agent_logs/spread_envelope.npz); each hull segment's line is a valid linear cap. Only r < 30 can bind.
_env=np.load(here+'/../../agent_logs/spread_envelope.npz'); _Q=_env['Q']; _H=_env['hull']
def _segments(r):
    h=_H[r-1]; return [((h[k+1]-h[k])/(_Q[k+1]-_Q[k]), h[k]-(h[k+1]-h[k])/(_Q[k+1]-_Q[k])*_Q[k]) for k in range(len(_Q)-1)]
SEGS={r:_segments(r) for r in range(1,30)}
src=src.replace("def system(n, m, eps, kyfan=True, window=True, T7=None, mu=None, gauss=False, gaussK=0):","def system(n, m, eps, kyfan=True, window=True, T7=None, mu=None, gauss=False, gaussK=0, spread=False):")
src=src.replace("    if window:\n","    if spread:\n        for c_ in cls:\n            mc=m[c_]; qc=(3*G[c_,c_]-sum(tau(c_,c_,d) for d in cls))/(2*mc*(mc+2))\n            for a_ in cls:\n                r=m[a_]-(a_==c_)\n                if 1<=r<30:\n                    lhs=sum(tau(c_,a_,d) for d in cls)\n                    for (bet,alp) in SEGS[r]:\n                        ineq.append(lhs-mc*(sp.Rational(alp).limit_denominator(10**6)+sp.Rational(bet).limit_denominator(10**6)*qc)-sp.Rational(1,10**4))\n    if window:\n",1)

src=src.replace("    if window:\n","    if gaussK:\n        for k in itertools.product(*[range(0, min(gaussK, m[a])+1) for a in cls]):\n            K=sum(k)\n            if 2<=K<=gaussK:\n                r=min(K,n-1)\n                ET=sum(k[a]*(k[a]-1)*P(a,a) for a in cls)+2*sum(k[a]*k[b]*P(a,b) for a in cls for b in cls if a<b)\n                EP2=sum((sp.Rational(k[a]*(k[a]-1),m[a]*(m[a]-1)) if m[a]>1 else 0)*(G[a,a]-2*m[a])+sp.Rational(k[a],m[a])*2*m[a] for a in cls)+sum(sp.Rational(k[a]*k[b],m[a]*m[b])*G[a,b] for a in cls for b in cls if a!=b)\n                ineq.append(ET-(1-sp.Rational(1,r))*(4*K**2+2*EP2)+4*K*(K-1))\n    if window:\n",1)

src=src.replace("    if window:\n","    if gauss:\n        for S in ((0,),(1,),(2,),(0,1),(0,2),(1,2)):\n            k=sum(m[a] for a in S); r=min(k,n-1)\n            lhs=sum(tau(a,b,c) for a in S for b in S for c in cls)\n            ineq.append(lhs-(1-sp.Rational(1,r))*(4*k**2+2*sum(G[a,b] for a in S for b in S))+4*k*(k-1))\n    if window:\n",1)

src=src.replace("    if window:\n","    if mu is not None:\n        for a in cls:\n            for b in cls:\n                if a<b:\n                    tab=sum(tau(a,b,c) for c in cls)\n                    lhs=sp.Rational(1,4)*m[a]*m[b]*(eps[a]+eps[b]-1)-sp.Rational(1,4)*sum(eps[c]*tau(a,b,c) for c in cls)\n                    ineq.append(lhs-(mu-1)/(2*(n-2))*(G[a,b]-tab/2)-(3*max(eps)-sp.Rational(1,2))*(m[a]*m[b]-G[a,b])/6)\n    if window:\n",1)
src=src.replace("    if window:\n","    if T7 is not None:\n        for k in itertools.product(range(8),repeat=3):\n            if sum(k)==7 and all(k[a]<=m[a] for a in cls):\n                ineq.append(sum(k[a]*(k[a]-1)*P(a,a) for a in cls)+2*sum(k[a]*k[b]*P(a,b) for a in cls for b in cls if a<b)-T7)\n    if window:\n")
exec(src)
import os
R=sp.Rational; TH=float(os.environ.get('THETA','1.2248'))   # at n=12 use just above theta_0(12)=1.23603: S^5xS^7 sits at 1.228239 (trap W7)
def job(m):
    out=[]
    # directions: eps = (-1, t, s) with sum m*eps = 0, t in (-1, s); five interior positions of t
    for frac in (0.1,0.3,0.5,0.7,0.9):
        # solve for s given t = -1 + frac*(s+1): m0*(-1) + m1*t + m2*s = 0
        # t = -1 + frac*(s+1) -> -m0 + m1*(-1+frac*(s+1)) + m2*s = 0
        a=m[1]*frac+m[2]; b=-m[0]-m[1]+m[1]*frac
        s=-b/a; t=-1+frac*(s+1)
        if not (-1<t<s): continue
        d=np.array([-1.0,t,s]); d=d/np.sqrt(np.dot(m,d**2))/TH
        eps=[R(x).limit_denominator(10**9) for x in d]
        try:
            mu=None
            if SEC5:
                Th=np.sqrt(2*(N-1)*(N-2))/N if N%2==0 else np.sqrt(2*(N-1)*(N-3)/((N+1)*(N-2)))
                mu=R(N*Th/((N-1)*TH)).limit_denominator(10**6)
                while mu>N*Th/((N-1)*TH): mu-=R(1,10**6)
            if system(N,list(m),eps,kyfan=True,window=True,T7=R(T7ARG),mu=mu,gauss=GAUSS,spread=SPREAD): out.append(frac)
        except Exception as e:
            out.append('err:'+str(e)[:40])
    return (m,out)
if __name__=='__main__':
    # control (Gate 1): L173's ray just above sqrt(3/2) is feasible without T7 and infeasible with it
    m0=[4,59,3]; d0=np.array([-1.0,0.0,4/3]); d0=d0/np.sqrt(np.dot(m0,d0**2))/TH; e0=[R(x).limit_denominator(10**9) for x in d0]
    c1=system(12,m0,e0,kyfan=True,window=True); c2=system(12,m0,e0,kyfan=True,window=True,T7=R(54064,1000))
    print('control on L173 ray at n=12: without T7',c1,'with T7',c2,flush=True)
    if not (c1 and not c2): sys.exit('CONTROL FAILED')
    D=N*(N-1)//2
    triples=[(a,b,D-a-b) for a in range(1,D) for b in range(1,D-a)]
    t0=time.time(); hits=[]
    with Pool(W) as p:
        for k,(m,out) in enumerate(p.imap_unordered(job,triples,chunksize=8)):
            if out: hits.append((m,out)); print('FEASIBLE',m,out,flush=True)
            if k%200==0: print(f'progress {k}/{len(triples)} {time.time()-t0:.0f}s',flush=True)
    print(f'DONE n={N} T7={T7ARG} sec5={SEC5} gauss={GAUSS} spread={SPREAD}: {len(triples)} triples, {len(hits)} with a feasible direction at theta={TH}, {time.time()-t0:.0f}s')
