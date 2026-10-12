import sys, time; sys.path.insert(0,'scripts/reviewers/r301')
import numpy as np, core301 as C, points301 as PT, defect as DF, hunt as HN, diag_census as DC
n = int(sys.argv[1]); NS = int(sys.argv[2])
seen=[]; t0=time.time()
for s in range(NS):
    r = DC.solve_diag(n,s)
    if r is None: continue
    L,th,res = r
    if th < 1e-4: continue
    key = np.sort(np.linalg.eigvalsh(L))
    if any(np.allclose(key,k,atol=1e-6) for k in seen): continue
    seen.append(key)
    W = DC.to_operator(n,L)
    pos,tot,ev = DF.delta(n,W)
    st = HN.stats(n,W,th) if n<=8 else dict(lam_full=float('nan'),lam_sym0=float('nan'))
    lab,nb = DC.blocks_of(L); G = DC.neg_block_graph(L,lab,nb)
    As = DF.edge_family(n,W,th,lab,G,'edge')
    e2,U = DF.compress_on(n,W,th,As)
    edge = "empty" if U is None else f"dim{U.shape[0]:3d} avg={e2.mean():.6f} max={e2.max():.6f}"
    flag=""
    if pos>1e-7 and st['lam_sym0']<=0.5+1e-9: flag=" <<< H4 COUNTEREXAMPLE"
    if pos>1e-7 and U is not None and e2.mean()<=0.5+1e-9: flag+=" <<< H5 COUNTEREXAMPLE"
    print(f"n={n} th={th:.6f} Delta={pos:9.5f} lamfull={st['lam_full']:9.6f} lamSym0={st['lam_sym0']:9.6f} blk={nb} edge:{edge}{flag}", flush=True)
print(f"-- n={n}: {len(seen)} distinct classes in {time.time()-t0:.0f}s", flush=True)
