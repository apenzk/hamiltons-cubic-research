import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import sys, time, numpy as np
sys.path.insert(0,_os.path.join(_ROOT, 'scripts'))
import review_r28_core as R, review_r28_critpoints as CP
LOG=_os.path.join(_ROOT, 'agent_logs/review_r28_trace.log')
def log(m):
    with open(LOG,'a') as f: f.write(time.strftime('%H:%M:%S ')+m+'\n')
cases=[]
for n,bl in [(6,[[0,1,2],[3,4,5]]),(7,[[0,1,2],[3,4,5,6]]),(8,[[0,1,2,3],[4,5,6,7]]),
             (8,[[0,1,2],[3,4,5,6,7]]),(9,[[0,1,2],[3,4,5],[6,7,8]]),(9,[[0,1,2],[3,4,5,6,7,8]]),
             (10,[[0,1,2],[3,4,5,6,7,8,9]]),(10,[[0,1,2,3],[4,5,6,7,8,9]]),(10,[list(range(5)),list(range(5,10))]),
             (10,[[0,1,2],[3,4,5],[6,7,8,9]]),(12,[[0,1,2],[3,4,5],[6,7,8],[9,10,11]]),
             (12,[list(range(6)),list(range(6,12))])]:
    cases.append((n,'Sprod'+str([len(b) for b in bl]), lambda n=n,bl=bl: CP.subalgebra_point(n,bl)))
for n,r,k in [(6,6,'C'),(6,4,'C'),(8,8,'C'),(8,4,'C'),(10,10,'C'),(10,4,'C'),(12,4,'C'),
              (8,8,'H'),(12,12,'H'),(12,8,'H'),(10,8,'H')]:
    cases.append((n,f'{"CP" if k=="C" else "HP"}^{r//(2 if k=="C" else 4)}@R{n}', lambda n=n,r=r,k=k: CP.kahler_type(n,r,k)))
print('name'); sys.stdout.flush()
for n,name,f in cases:
    t0=time.time()
    log(f'catalogue: building {name} at n={n}')
    W=f()
    if W is None: print(f'n={n} {name}: null'); continue
    o=CP.analyse(n,W,name)
    if o is None: print(f'n={n} {name}: theta=0'); continue
    ok='CRIT' if o['resid']<1e-9 else f"NOT({o['resid']:.1e})"
    print(f"n={n:2d} {name:16s} D={o['D']:4d} th={o['theta']:.6f} {ok:12s} orb={o['orb']:3d} "
          f"m1={o['mone']} mhalf={o['mhalf']:3d} sum={o['s1']:+.1e} th2S2={o['T3']:.9f} kap={o['kappa']:.2f} "
          f"dev={abs(o['T3']-o['kappa']):.2e} top={o['top']:.4f} [{time.time()-t0:.0f}s]")
    sys.stdout.flush()
    np.save(f'scratchpad/r28_{name.replace("/","_")}_{n}.npy', o['ev'])
log('catalogue done')
