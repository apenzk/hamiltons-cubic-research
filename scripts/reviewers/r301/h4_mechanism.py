import sys, time; sys.path.insert(0,'scripts/reviewers/r301')
import numpy as np, core301 as C, points301 as PT, defect as DF, diag_census as DC, hunt as HN, h1_isotypic as H1
n=8
rows=[]; seen=[]
for s in range(300):
    r=DC.solve_diag(n,s)
    if r is None: continue
    L,th,res=r
    if th<1e-4: continue
    key=np.sort(np.linalg.eigvalsh(L))
    if any(np.allclose(key,k,atol=1e-6) for k in seen): continue
    seen.append(key)
    W=DC.to_operator(n,L)
    pos,tot,ev=DF.delta(n,W)
    st=HN.stats(n,W,th)
    kb=C.isotropy(n,W)
    a=H1.analyse('x',n,W)
    nonscalar=sum(1 for d,w in a['comps'] if w.max()-w.min()>1e-7)
    rows.append((th,pos,kb.shape[0],a['ncomp'],nonscalar,st['lam_full'],st['lam_sym0']))
rows.sort(key=lambda r:-r[0])
print(f"{'theta':>9} {'Delta':>9} {'dim k':>6} {'#isotypic':>10} {'#nonscalar':>11} {'lam_full':>9} {'lam_Sym0':>9}")
for r in rows:
    print(f"{r[0]:9.6f} {r[1]:9.5f} {r[2]:6d} {r[3]:10d} {r[4]:11d} {r[5]:9.6f} {r[6]:9.6f}")
