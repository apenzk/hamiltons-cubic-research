"""E2: Fox algebra at the balanced sphere product. Independent build."""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..'))
import numpy as np, sys, math, itertools
sys.path.insert(0,_os.path.join(_ROOT, 'scripts'))
from review_r26_core import *


def sphere_e(n):
    """e = W*/theta for the balanced sphere product; returns (e, theta, C, B)."""
    C = struct_const(n); B = weyl_basis(n)
    W = sphere_product_weyl(n, n//2)
    W = W/math.sqrt(np.trace(W@W))
    th = np.trace(W@Q(W,C))
    return W/th, th, C, B, W


def Lmap_on_weyl(u, C, B):
    """matrix of v -> u o v = 1/2(uv+vu) + u#v, in the orthonormal Weyl basis B."""
    N = C.shape[0]; K = B.shape[0]
    # sharp part:  (u#v)_ab = 1/2 sum_{cdef} c_acd u_ce c_bef v_df
    Y = np.einsum('acd,ce->ade', C, u, optimize=True)          # N^4
    Z = np.einsum('ade,bef->adbf', Y, C, optimize=True)        # N^5 -> [a,d,b,f]
    Zm = 0.5*np.transpose(Z, (0,2,1,3)).reshape(N*N, N*N)      # [(a,b),(d,f)]
    Bv = B.reshape(K, N*N)
    sh = Bv @ Zm.T                                             # careful: (u#v)_{ab} = sum_{df} Zm[(ab),(df)] v_df
    # we want for each basis v_l:  vec(u#v_l) = Zm @ vec(v_l)
    Sh = Zm @ Bv.T                                             # (N^2, K)
    # jordan part
    Jo = np.einsum('ac,lcb->lab', u, B, optimize=True)
    Jo = 0.5*(Jo + np.transpose(Jo,(0,2,1)))
    Jo = Jo.reshape(K, N*N).T                                  # (N^2, K)
    full = Sh + Jo
    return Bv @ full                                           # (K,K):  M[k,l] = <B_k, u o B_l>


def report_spectrum(n, tol=1e-8):
    e, th, C, B, W = sphere_e(n)
    K = B.shape[0]
    idem = np.abs(circ(e,e,C) - e).max()
    M = Lmap_on_weyl(e, C, B)
    asym = np.abs(M - M.T).max()
    ev = np.linalg.eigvalsh((M+M.T)/2)
    # cluster
    vals, mults = [], []
    for x in ev:
        if vals and abs(x - vals[-1]) < 1e-7:
            mults[-1] += 1
            vals[-1] = (vals[-1]*(mults[-1]-1)+x)/mults[-1]
        else:
            vals.append(x); mults.append(1)
    return dict(n=n, theta=th, dimW=K, idem=idem, asym=asym, vals=vals, mults=mults,
                e=e, C=C, B=B, M=M, W=W)


if __name__ == '__main__':
    import sys
    ns = [int(x) for x in sys.argv[1:]] or [6,8]
    for n in ns:
        r = report_spectrum(n)
        m = n//2
        print(f"n={n}  dim Weyl = {r['dimW']} (formula {weyl_dim_formula(n)})  theta={r['theta']:.10f} "
              f" theta0={math.sqrt(2*(n-1)*(n-2))/n:.10f}")
        print(f"   |e o e - e| = {r['idem']:.2e}   |L_e - L_e^T| = {r['asym']:.2e}")
        for v,mu in zip(r['vals'], r['mults']):
            print(f"     eigenvalue {v: .12f}   multiplicity {mu}")
        print(f"   predicted pattern (m={m}): 1, 1/2={0.5}, (m-2)/(2(m-1))={(m-2)/(2*(m-1)):.12f}, 0, "
              f"-1/(m-1)={-1/(m-1):.12f}")
        print()
