import sys; sys.path.insert(0,'scripts/reviewers/r336')
import numpy as np, fast, itertools
from scipy.optimize import minimize
np.random.seed(5336)
n=6; P,N,q=fast.weyl_ortho(n); D=q.shape[1]
def spec(x):
    W=(q@x).reshape(N,N); W=(W+W.T)/2; W/=np.linalg.norm(W); return np.linalg.eigvalsh(W),W
# sanity: is the fitted W genuinely Weyl?
x=np.random.randn(D); s,W=spec(x)
v=W.reshape(-1); print('Weyl membership check: ||W - P_Weyl W|| = %.2e ; ||W||=%.6f ; tr W = %.2e'
      %(np.linalg.norm(v-q@(q.T@v)),np.linalg.norm(W),np.trace(W)))
# DISCRIMINATION CONTROL: a trace-free unit spectrum violating Lemma 73 (ratio 6 > n-2 = 4)
def fitto(tgt,tries=15):
    def f(z):
        s,_=spec(z); return float(np.sum((s-tgt)**2))
    b=(1e9,None)
    for t in range(tries):
        r=minimize(f,np.random.randn(D),method='Nelder-Mead',options={'maxiter':40000,'maxfev':40000,'fatol':1e-14,'xatol':1e-12})
        if r.fun<b[0]: b=(r.fun,r.x)
    return b
bad=np.array([-1.0]*13+[0.0,6.5]); bad=bad-bad.mean(); bad/=np.linalg.norm(bad); bad=np.sort(bad)
print('unrealizable-by-Lemma73 target: lmax/|lmin| = %.4f  (n-2 = %d)'%(bad[-1]/abs(bad[0]),n-2))
d,_=fitto(bad); print('   best fit distance = %.6f  (should be BOUNDED AWAY from 0)'%np.sqrt(d))
# and one that satisfies Lemma 73 but is otherwise arbitrary
ok=np.array([-1.0]*12+[0.2,0.3,3.4]); ok=ok-ok.mean(); ok/=np.linalg.norm(ok); ok=np.sort(ok)
print('Lemma-73-admissible arbitrary target: lmax/|lmin| = %.4f'%(ok[-1]/abs(ok[0])))
d2,_=fitto(ok); print('   best fit distance = %.6f'%np.sqrt(d2))
