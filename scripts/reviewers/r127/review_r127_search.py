import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..'))
import sys; sys.path.insert(0,_os.path.join(_ROOT, 'scripts'))
import numpy as np, itertools
import review_r127_lib as L

def bianchi_proj(R):
    b = (R + np.einsum('acdb->abcd', R) + np.einsum('adbc->abcd', R))/3.0
    return R - b

def rand_curv(n, rng):
    M = rng.normal(size=(len(L.pairs_of(n)),)*2); M = M+M.T
    R = L.tensor_from_mop(M, n)
    R = bianchi_proj(R)
    return R

def P_weyl_mop(M, n):
    R = L.tensor_from_mop(M, n)
    R = bianchi_proj(R)
    W = L.weyl_part(R, n)
    return L.mop_from_tensor(W, n)

def stats(M, n, tag="", verbose=True):
    M = M/np.linalg.norm(M)
    Qm = L.Q(M, n)
    lam = float((Qm*M).sum())
    res = float(np.abs(Qm - lam*M).max())
    K = L.vertex(M, n)
    ev = np.sort(np.linalg.eigvalsh(K))[::-1]
    pos = ev[ev > 1e-9]
    inside = pos[pos < lam-1e-9]
    psd = float(np.linalg.eigvalsh(K@K - lam*K).min())
    t = float((K*K).sum())
    off = float(np.abs(M-np.diag(np.diag(M))).max())
    if verbose:
        print(f"{tag:22s} lam={lam:+.6f} res={res:.1e} t={t:.5f} lam^2={lam*lam:.5f} "
              f"lam^2<=t? {'Y' if lam*lam<=t+1e-9 else 'N'} offdiag={off:.2e} "
              f"r={len(pos)} inside={len(inside)} minEig={psd:+.5f}")
    return dict(lam=lam,res=res,t=t,off=off,psd=psd,r=len(pos),inside=len(inside),ev=ev,M=M)

if __name__ == "__main__":
    n = int(sys.argv[1]) if len(sys.argv)>1 else 6
    trials = int(sys.argv[2]) if len(sys.argv)>2 else 60
    rng = np.random.default_rng(1270+n)
    # sanity: Q preserves Weyl
    R = rand_curv(n, rng); Wt = L.weyl_part(R, n); M = L.mop_from_tensor(Wt, n)
    Qm = L.Q(M, n); Rq = L.tensor_from_mop(Qm, n)
    print(f"n={n}: |Ric(W)|={L.traces(Wt,n):.1e}  |Ric(Q(W))|={L.traces(Rq,n):.1e} "
          f" |Bianchi(Q)|={np.abs((Rq+np.einsum('acdb->abcd',Rq)+np.einsum('adbc->abcd',Rq))).max():.1e}")
    seen = {}
    for tr in range(trials):
        R = rand_curv(n, rng); Wt = L.weyl_part(R, n)
        M = L.mop_from_tensor(Wt, n); M = M/np.linalg.norm(M)
        for it in range(4000):
            Mn = L.Q(M, n)
            Mn = P_weyl_mop(Mn, n)
            nn = np.linalg.norm(Mn)
            if nn < 1e-12: M=None; break
            Mn = Mn/nn
            d = np.linalg.norm(Mn-M); M = Mn
            if d < 1e-14: break
        if M is None: continue
        s = stats(M, n, verbose=False)
        if s['res'] > 1e-8: continue
        key = round(s['lam'], 6)
        if key not in seen: seen[key] = s
    for k in sorted(seen, reverse=True):
        s = seen[k]
        stats(s['M'], n, f"n={n} attractor")
