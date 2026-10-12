import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..'))
import sys; sys.path.insert(0,_os.path.join(_ROOT, 'scripts'))
import numpy as np
import review_r127_lib as L
from review_r127_pts import sphere_pair, mop_from_vertex, cpm_tensor

def rotate(R, O):
    return np.einsum('ai,bj,ck,dl,ijkl->abcd', O, O, O, O, R, optimize=True)

def diag_stats(M, n):
    M = M/np.linalg.norm(M)
    Qm = L.Q(M, n); lam = float((Qm*M).sum())
    K = L.vertex(M, n)
    ev = np.sort(np.linalg.eigvalsh(K))[::-1]
    pos = ev[ev>1e-9]; inside = pos[pos<lam-1e-9]
    return lam, float((K*K).sum()), float(np.linalg.eigvalsh(K@K-lam*K).min()), len(pos), len(inside), float(np.abs(Qm-lam*M).max())

def sweep(name, R0, n, trials=200, seed=0):
    rng = np.random.default_rng(seed)
    M0 = L.mop_from_tensor(R0, n)
    lam0,t0,psd0,r0,in0,res0 = diag_stats(M0, n)
    print(f"{name}: base lam={lam0:.6f} t={t0:.5f} minEig={psd0:+.5f} r={r0} inside={in0} crit-res={res0:.1e}")
    bad=0; tmax=0.0; tmin=9.9; worst=0.0
    for _ in range(trials):
        A = rng.normal(size=(n,n)); O,_ = np.linalg.qr(A); O = O*np.sign(np.linalg.det(O))
        R = rotate(R0, O)
        M = L.mop_from_tensor(R, n)
        lam,t,psd,r,ins,res = diag_stats(M, n)
        assert abs(lam-lam0)<1e-8 and res<1e-8, (lam, res)
        tmax=max(tmax,t); tmin=min(tmin,t); worst=min(worst,psd)
        if psd < -1e-9 or ins>0: bad+=1
    print(f"   over {trials} random frames: PSD fails in {bad}/{trials};  t in [{tmin:.5f},{tmax:.5f}];  worst minEig={worst:+.5f}")

if __name__ == "__main__":
    for (p,q) in [(3,3),(4,4)]:
        n=p+q
        R0 = L.tensor_from_mop(mop_from_vertex(sphere_pair(p,q)), n)
        sweep(f"S^{p}xS^{q} (DIAGONAL critical pt)", R0, n, trials=120, seed=7)
    for m in [2,3]:
        n=2*m
        R0 = L.weyl_part(cpm_tensor(m,n), n)
        sweep(f"CP^{m}", R0, n, trials=120, seed=11)
    # zero-padded CP^2 at n=6,8: is it literally the same tensor?
    print()
    R4 = L.weyl_part(cpm_tensor(2,4), 4)
    for n in [6,8,10,12]:
        Rp = np.zeros((n,n,n,n)); Rp[:4,:4,:4,:4] = R4
        print(f"padded W_CP2 into n={n}: |Ric|={L.traces(Rp,n):.1e} ", end="")
        M = L.mop_from_tensor(Rp, n)
        lam,t,psd,r,ins,res = diag_stats(M, n)
        print(f"lam={lam:.6f} crit-res={res:.1e} t={t:.5f} minEig={psd:+.5f} r={r} inside={ins}")
    # alternative reading: pad the raw CP^2 curvature, THEN Weyl-project in dim n
    print()
    Rraw = cpm_tensor(2,4)
    for n in [6,8,12]:
        Rp = np.zeros((n,n,n,n)); Rp[:4,:4,:4,:4] = Rraw
        Wt = L.weyl_part(Rp, n)
        M = L.mop_from_tensor(Wt, n)
        lam,t,psd,r,ins,res = diag_stats(M, n)
        print(f"pad-then-project n={n}: lam={lam:.6f} crit-res={res:.1e} (critical? {'yes' if res<1e-8 else 'NO'}) t={t:.5f} minEig={psd:+.5f} r={r} inside={ins}")
