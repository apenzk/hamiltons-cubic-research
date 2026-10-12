import sys, os, itertools, numpy as np
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import lib310 as L
from blowups import run

best=[]
shapes=[]
for m in [4,5,6]:
    for ks in itertools.combinations_with_replacement([1,2,3,4,5], m):
        if sum(ks)<6 or sum(ks)>16: continue
        shapes.append(list(ks))
print('shapes',len(shapes))
rows=[]
for ks in shapes:
    for M in run(ks, 24, seed0=7):
        W=L.W_from_M(M); th=L.P(W)
        if th<=1e-6: continue
        if np.abs(L.Q(W)-th*W).max()>1e-11: continue
        d=L.defect_diag(M, tol=1e-9)
        if d<=1e-8: continue
        dl,_=L.diag_L_eigs(M)
        rows.append((M.shape[0],tuple(ks),th,d,dl[-1]/th,M))
seen={}
for r in rows: seen[(r[0],round(r[2],9),round(r[3],6),round(r[4],8))]=r
rows=list(seen.values()); rows.sort(key=lambda r:r[4])
print('Delta>0 distinct',len(rows))
for r in rows[:20]:
    print(f'  n={r[0]} ks={r[1]} theta={r[2]:.6f} Delta={r[3]:.4f} diag_lam_e={r[4]:.8f}')
np.save('scripts/reviewers/r310/low_M.npy', rows[0][5])
