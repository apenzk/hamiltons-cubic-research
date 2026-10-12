import numpy as np, sys, os
sys.path.insert(0, os.path.dirname(__file__))
from core import *

def diagnose(W, n, tol=1e-8, name=''):
    N = n*(n-1)//2
    M = ad_mats(n); c = struct_const(n)
    W = W/np.linalg.norm(W)
    QW = Q(W, M); th = float(np.trace(W@QW))
    res = float(np.linalg.norm(QW - th*W))
    ev, U = np.linalg.eigh(W)
    lmin, lmax = ev[0], ev[-1]
    # eigenbasis structure constants
    ce = np.einsum('abc,ai,bj,ck->ijk', c, U, U, U)
    T = ce**2
    mmask = np.abs(ev-lmin)<tol; hmask = np.abs(ev-lmax)<tol
    rmask = ~(mmask|hmask)
    L = np.outer(ev,ev)
    # D(v) for each eigenvector v in E_min
    Dv = 0.5*np.einsum('ab,vab->v', L - lmin*lmax, T)
    Dmin = Dv[mmask]
    out = dict(name=name, n=n, theta=th, crit_res=res, distW=dist_weyl(W,n),
               trW=float(np.trace(W)), lmin=lmin, lmax=lmax,
               ratio=lmax/abs(lmin), spec=np.unique(np.round(ev,9)),
               dim_m=int(mmask.sum()), dim_h=int(hmask.sum()), dim_r=int(rmask.sum()),
               dim_ker=int((np.abs(ev)<tol).sum()),
               D_min=float(Dmin.min()), D_max=float(Dmin.max()),
               slack=float(lmin+(n-2)*lmax-th))
    # structural masses at saturation
    tot = T[mmask].sum()
    def blk(A,B,C): return float(T[np.ix_(A,B,C)].sum())
    out['mass_m_rows_total'] = tot
    out['mass_m_on_mxh'] = blk(mmask,mmask,hmask)+blk(mmask,hmask,mmask)
    out['mass_m_off'] = tot - out['mass_m_on_mxh']
    out['M_mmh'] = blk(mmask,mmask,hmask)
    out['h_rows_total'] = float(T[hmask].sum())
    out['h_residue'] = float(T[hmask].sum()) - blk(hmask,mmask,mmask)
    out['mm_off_h'] = float(T[np.ix_(mmask,mmask,~hmask)].sum())
    allm = np.ones(N,dtype=bool)
    out['m_r_bracket'] = float(T[np.ix_(mmask,rmask,allm)].sum())
    # h_1 = h \ [m,m] : compute [m,m] span dimension inside so(n)
    Um = U[:, mmask]
    br = []
    for i in range(Um.shape[1]):
        for j in range(i+1, Um.shape[1]):
            v = np.einsum('acd,c,d->a', M, Um[:,i], Um[:,j])
            br.append(v)
    if br:
        s = np.linalg.svd(np.array(br), compute_uv=False)
        out['dim_mm'] = int((s>1e-8*max(s.max(),1)).sum())
    else:
        out['dim_mm'] = 0
    return out

def show(d):
    print(f"[{d['name']}] n={d['n']} theta={d['theta']:.9f} crit_res={d['crit_res']:.1e} distWeyl={d['distW']:.1e}")
    print(f"   spec={d['spec']} dims m/h/r/ker={d['dim_m']}/{d['dim_h']}/{d['dim_r']}/{d['dim_ker']} ratio={d['ratio']:.6f} n/(n-2)={d['n']/(d['n']-2):.6f}")
    print(f"   slack={d['slack']:.3e} D on E_min in [{d['D_min']:.3e},{d['D_max']:.3e}] | m-mass off (m,h)={d['mass_m_off']:.3e} | [m,m] off h={d['mm_off_h']:.3e} | [m,r] mass={d['m_r_bracket']:.3e}")
    print(f"   dim[m,m]={d['dim_mm']} (dim h={d['dim_h']}) | M(m,m,h)={d['M_mmh']:.6f} vs dim_m*(n-2)={d['dim_m']*(d['n']-2)} | h-residue={d['h_residue']:.6f} vs dim_h*(n-4)={d['dim_h']*(d['n']-4)}")
