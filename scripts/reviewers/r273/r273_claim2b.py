"""r273 Claim 2 follow-up: verify the optimiser's output is a genuine Weyl tensor,
and separately maximise theta itself over unit Weyl tensors."""
import sys, os
sys.path.insert(0, os.path.dirname(__file__))
import numpy as np, r273_core as K
from itertools import combinations
from r273_claim2 import setup, sharp, sharpbil, proj_weyl, SCRATCH

def check_weyl(M, idx, n):
    pos = {p: k for k, p in enumerate(idx)}
    b = max(abs(K.Rval(M,pos,i,j,k,l)+K.Rval(M,pos,i,k,l,j)+K.Rval(M,pos,i,l,j,k))
            for (i,j,k,l) in combinations(range(n),4))
    r = max(abs(sum(K.Rval(M,pos,i,j,k,j) for j in range(n))) for i in range(n) for k in range(n))
    return b, r

def ascend_theta(M0, A, B, triu, N, steps=3000, lr=0.2):
    M = M0/np.linalg.norm(M0); best=-9e9
    for t in range(steps):
        Ms = sharp(M, A)
        th = float(np.trace(M@M@M)) + float(np.sum(Ms*M))
        if th>best: best, Mb = th, M.copy()
        G = 3.0*(M@M) + 3.0*Ms          # grad of tr(M^3)+<M#,M> is 3M^2+3M^#
        G = proj_weyl(0.5*(G+G.T), B, triu, N); G = G - np.sum(G*M)*M
        ng = np.linalg.norm(G)
        if ng < 1e-12: break
        M = M + lr*G/ng
        M = proj_weyl(M, B, triu, N); M /= np.linalg.norm(M)
        if t % 400 == 0: lr *= 0.75
    Ms = sharp(M,A); th = float(np.trace(M@M@M))+float(np.sum(Ms*M))
    if th>best: best, Mb = th, M.copy()
    return best, Mb

if __name__ == "__main__":
    n = int(sys.argv[1]); nst = int(sys.argv[2])
    idx, N, c, A, B, triu = setup(n)
    th0 = np.sqrt(2*(n-1)*(n-2))/n
    Mb = np.load(os.path.join(SCRATCH, f"r273_best_{n}.npy"))
    b, r = check_weyl(Mb, idx, n)
    Ms = sharp(Mb, A); Ms2 = K.sharp(Mb, c)
    print(f"n={n} theta_0={th0:.6f}")
    print(f"g-optimiser output: |Bianchi|={b:.2e}  |Ric|={r:.2e}  |M|={np.linalg.norm(Mb):.12f}")
    print(f"  ad-form vs structure-constant sharp, rel diff = {np.linalg.norm(Ms-Ms2)/np.linalg.norm(Ms):.2e}")
    print(f"  ratio (tr+||M#||)/theta_0 = {(np.trace(Mb@Mb@Mb)+np.linalg.norm(Ms))/th0:.8f}")
    best = -9e9
    for s in range(nst):
        rs = np.random.RandomState(500+s)
        M0 = proj_weyl(K.from_vec(B @ rs.randn(B.shape[1]), triu, N), B, triu, N)
        th, M = ascend_theta(M0, A, B, triu, N)
        if th > best: best, MT = th, M
        print(f"  theta start {s}: {th:.8f}  ratio {th/th0:.8f}  (best {best/th0:.8f})", flush=True)
    bb, rr = check_weyl(MT, idx, n)
    print(f"MAX theta over unit Weyl_{n} (numerical) = {best:.8f} = {best/th0:.6f} * theta_0   [|Bianchi|={bb:.1e} |Ric|={rr:.1e}]")
    print(f"  sqrt(2)={np.sqrt(2):.6f}  theta_0={th0:.6f}  sqrt(3/2)={np.sqrt(1.5):.6f}")
    np.save(os.path.join(SCRATCH, f"r273_maxtheta_{n}.npy"), MT)
