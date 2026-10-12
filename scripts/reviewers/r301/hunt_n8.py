import sys, time; sys.path.insert(0,'scripts/reviewers/r301')
import numpy as np, core301 as C, points301 as PT, defect as DF, hunt as HN
n=8; seen=[]
for s in range(400,600):
    try:
        th,W,res = HN.find_critical(n,s)
    except Exception as e:
        continue
    if res>1e-11 or th<1e-4: continue
    key=np.sort(np.linalg.eigvalsh(W))
    if any(np.allclose(key,k,atol=1e-6) for k in seen): continue
    seen.append(key)
    st=HN.stats(n,W,th)
    flag=" <<< H4 COUNTEREXAMPLE" if st['Delta']>1e-7 and st['lam_sym0']<=0.5+1e-9 else ""
    print(f"n=8 s={s} th={th:.6f} Delta={st['Delta']:9.5f} lam_full={st['lam_full']:.6f} lam_Sym0={st['lam_sym0']:.6f}{flag}", flush=True)
print("done", len(seen), flush=True)
