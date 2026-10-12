"""I121 screen (not evidence): max of P(f) on unit surviving +c_* modes at m = 6..12, with an identity start, against the endpoint bound. The identity overtakes the so(4) value 5/6 at m = 9. Run from the repo root with sage -python."""
import numpy as np, itertools
exec(open('scripts/misc/screen_I121_double_sharp_norm.py').read().split('rng=np.random.default_rng(1)')[0])
kap=5*np.sqrt(3)/24
def Fval(s,A,S): return np.sum(S*s[A[:,0]]*s[A[:,1]]*s[A[:,2]])
for m in (6,8,9,10,12):
    nv,A,S=build(m); rng=np.random.default_rng(m); best=0
    # identity start: sigma_(pi,ka) = 1 when ka is pi shifted by m
    Vl=[(pi,ka) for pi in itertools.combinations(range(m),2) for ka in itertools.combinations(range(m,2*m),2)]
    starts=[np.array([1.0 if (ka[0]-m,ka[1]-m)==pi else 0.0 for pi,ka in Vl])]+[rng.standard_normal(nv) for _ in range(12)]
    for s in starts:
        s=s/np.linalg.norm(s)
        for it in range(300):
            s=s+0.5*grad(s,A,S,nv); s/=np.linalg.norm(s)
        best=max(best,6*kap*Fval(s,A,S))
    d=np.sqrt(2*(2*m-1)*(2*m-2))/(2*m); bound=d*m*np.sqrt(m-3)/(m-1)**1.5
    ident=6*kap*(m*(m-1)*(m-2)/6)/(m*(m-1)/2)**1.5
    print(f'm={m}: screened max q {best:.4f}, identity {ident:.4f}, endpoint bound {bound:.4f}')
