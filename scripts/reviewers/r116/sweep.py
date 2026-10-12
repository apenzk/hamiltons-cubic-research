import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import numpy as np, collections, sys, time
from core import *; from weyl import *; from tools import *; from sub import *; from solve import *
n=6; pairs,B,bas=weyl_basis(n); C=structure(B)
cones={'sigma(1,5)':make_sigma(6,1),'sigma(2,4)':make_sigma(6,2),'sigma(3,3)':make_sigma(6,3),'J':make_J(6)}
NS=400
summary={}
log=open(_os.path.join(_ROOT, 'agent_logs/gate2_B.log'),'a')
for name,g in cones.items():
    sub=invariant_subspace(bas,pairs,g); P=Prob(sub,C)
    rng=np.random.default_rng(abs(hash(name))%2**31)
    conv=0; graded=0; ths=[]; best=None; near=[]
    t0=time.time()
    for t in range(NS):
        x,r,ok=P.solve(rng.normal(size=P.d)*0.5)
        if r>1e-10: continue
        Wn,th=P.normalise(x)
        if Wn is None: continue
        conv+=1; ths.append(th)
        rep=grading_report(Wn,C,tol=1e-8)
        s=rep['S_mmm']+rep['S_hhm']
        near.append(s)
        if rep['graded']: graded+=1
        if best is None or s<best[0]: best=(s,th,rep['S_mmm'],rep['S_hhm'],rep['dim_m'])
        if t%100==0:
            log.write('%s sweep %s %d/%d conv=%d graded=%d best_S=%.4f\n'%(time.strftime('%H:%M:%S'),name,t,NS,conv,graded,best[0] if best else -1)); log.flush()
    summary[name]=dict(dim=P.d,conv=conv,graded=graded,thmin=min(ths) if ths else None,thmax=max(ths) if ths else None,
                       distinct=len(np.unique(np.round(ths,6))),best=best, S_quantiles=np.percentile(near,[0,1,5,25,50]).tolist())
    print(name,'dim',P.d,'conv',conv,'graded',graded,'theta range %.6f..%.6f'%(min(ths),max(ths)),'distinct',len(np.unique(np.round(ths,6))))
    print('   min S_mmm+S_hhm over cone: %.6f at theta=%.6f (S_mmm=%.4f S_hhm=%.4f dim_m=%d)'%best)
    print('   S-sum percentiles [0,1,5,25,50]:', np.round(np.percentile(near,[0,1,5,25,50]),4))
    sys.stdout.flush()
tot=sum(v['conv'] for v in summary.values()); tg=sum(v['graded'] for v in summary.values())
print('TOTAL converged',tot,'graded',tg)
np.save('sweep_summary.npy', summary, allow_pickle=True)
