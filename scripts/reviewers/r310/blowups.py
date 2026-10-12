import sys, os, itertools, numpy as np
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import lib310 as L
from scipy.optimize import least_squares

def build(B, ks):
    n = sum(ks); lab = np.concatenate([[c]*k for c,k in enumerate(ks)])
    M = B[np.ix_(lab,lab)].astype(float).copy()
    np.fill_diagonal(M, 0.0)
    return M

def pack(m, ks):
    idx = [(c,d) for c in range(m) for d in range(c,m) if not (c==d and ks[c]==1)]
    return idx

def unpack(x, m, idx):
    B = np.zeros((m,m))
    for v,(c,d) in zip(x, idx):
        B[c,d]=B[d,c]=v
    return B

def resid(x, m, idx, ks):
    B = unpack(x, m, idx)
    M = build(B, ks)
    nrm = np.sqrt(0.5*np.sum(M**2))
    if nrm < 1e-12: return np.ones(len(x)+1)*10
    M = M/nrm
    Phi = M*M + M@M
    th = 0.5*(np.sum(M**3)+np.trace(M@M@M))
    R = Phi - th*M
    np.fill_diagonal(R, 0.0)
    rs = M.sum(1)
    # reduce to block-level equations
    out=[]
    lab = np.concatenate([[c]*k for c,k in enumerate(ks)])
    for (c,d) in idx:
        a = int(np.where(lab==c)[0][0]); b = int(np.where(lab==d)[0][-1])
        out.append(R[a,b])
    for c in range(m):
        a = int(np.where(lab==c)[0][0]); out.append(rs[a])
    out.append(nrm-1.0)
    return np.array(out)

def run(ks, ntrial, seed0=0):
    m=len(ks); idx=pack(m,ks); res=[]
    rng=np.random.default_rng(seed0)
    for t in range(ntrial):
        x0=rng.normal(size=len(idx))
        s=least_squares(resid,x0,args=(m,idx,ks),xtol=1e-15,ftol=1e-15,gtol=1e-15)
        if np.max(np.abs(s.fun))>1e-11: continue
        B=unpack(s.x,m,idx); M=build(B,ks)
        nrm=np.sqrt(0.5*np.sum(M**2))
        if nrm<1e-9: continue
        M=M/nrm
        res.append(M)
    return res

if __name__=="__main__":
    rows=[]
    shapes=[]
    for m in [3,4,5]:
        for ks in itertools.combinations_with_replacement([1,2,3,4], m):
            if sum(ks)<5 or sum(ks)>12: continue
            shapes.append(list(ks))
    for ks in shapes:
        for M in run(ks, 30):
            n=M.shape[0]
            W=L.W_from_M(M); th=L.P(W)
            if th<=1e-6: continue
            if np.abs(L.Q(W)-th*W).max()>1e-11: continue
            d=L.defect_diag(M, tol=1e-9)
            dl,_=L.diag_L_eigs(M); dlam=dl[-1]
            rows.append((n,tuple(ks),th,d,dlam,dlam/th,M))
    # dedup by (n, sorted spectrum of M, theta)
    seen={}
    for r in rows:
        key=(r[0],round(r[2],9),round(r[3],6),round(r[5],7))
        seen[key]=r
    rows=list(seen.values())
    pos=[r for r in rows if r[3]>1e-8]
    print('total distinct',len(rows),'Delta>0',len(pos))
    pos.sort(key=lambda r:r[5])
    for r in pos[:15]:
        print(f'  n={r[0]} ks={r[1]} theta={r[2]:.6f} Delta={r[3]:.4f} diag_lam_e={r[5]:.6f}')
    print('--- highest theta Delta>0 ---')
    pos.sort(key=lambda r:-r[2])
    for r in pos[:12]:
        print(f'  n={r[0]} ks={r[1]} theta={r[2]:.6f} Delta={r[3]:.4f} diag_lam_e={r[5]:.6f}')
    np.save('scripts/reviewers/r310/blowup_M.npy', np.array([r[6] for r in rows],dtype=object), allow_pickle=True)
    np.save('scripts/reviewers/r310/blowup_stats.npy', np.array([[r[0],r[2],r[3],r[4],r[5]] for r in rows]))
