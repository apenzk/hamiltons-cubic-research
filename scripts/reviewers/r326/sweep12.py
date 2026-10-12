import sys,os,time; sys.path.insert(0,os.path.dirname(__file__))
import numpy as np, diaglp
n=12; N=n*(n-1)//2
th0=np.sqrt(2*(n-1)*(n-2))/n
best=(-9,None)
log=open('agent_logs/r326-sweep12.log','w',buffering=1)
def ev(lam,tag):
    global best
    lam=np.sort(np.asarray(lam,float))
    r=diaglp.solve(lam,n,'max')
    v=-r.fun if r.status==0 else None
    if v is not None and v>best[0]:
        best=(v,tag); log.write('NEW BEST %.9f  %s   (theta0=%.9f, ratio %.4f)\n'%(v,tag,th0,v/th0))
    log.write('%-42s %s\n'%(tag, ('%.9f'%v) if v is not None else 'INFEASIBLE'))
    return v
def mk(vals,mults):
    lam=np.concatenate([np.full(m,v) for v,m in zip(vals,mults)])
    assert len(lam)==N
    return lam
# 3-value family: a (r), 0 (z), b (s);  traceless + unit norm
log.write('theta0(12)=%.9f\n'%th0)
for r in range(1,20):
    for s in range(1,40):
        if r+s>N: continue
        z=N-r-s
        # r a + s b = 0, r a^2 + s b^2 = 1  -> b = -r a/s ; r a^2 + r^2 a^2/s = 1
        a=np.sqrt(1.0/(r+r*r/s)); b=-r*a/s
        ev(mk([b,0.0,a],[s,z,r]),'3val r=%d s=%d z=%d'%(r,s,z))
log.write('BEST 3val %.9f %s\n'%best)
log.close()
