import sys, numpy as np
sys.path.insert(0, 'scripts/reviewers/r307')
from core307 import *

n = 8
W = np.load('scripts/data/w_n8_nondiagonal_witness.npy')
print('shape', W.shape, 'sym err', np.abs(W-W.T).max(), 'norm', np.linalg.norm(W))
W = W/np.linalg.norm(W)
# is it Weyl?
print('weyl proj err', np.abs(project_weyl(n, W) - W).max())
th = float(np.tensordot(Q(n, W), W))
print('theta', th, 'crit resid', np.abs(Q(n,W)-th*W).max())
lam = np.linalg.eigvalsh(W)
print('eigs', np.round(lam, 6))
print('n pos', (lam>1e-9).sum(), 'n neg', (lam<-1e-9).sum(), 'n zero', (np.abs(lam)<1e-9).sum())
for p in range(2, 7):
    ip, im = pm_index(n, p)
    off = max(np.abs(W[np.ix_(ip, im)]).max(), 0)
    print(f'  p={p} dim p={len(ip)} dim m={len(im)} offblock={off:.2e}')
