"""Reviewer 43: split each summand eigenvalue into its three pieces, on the h.w. vectors.

  L_e = C + a*sb(Id,.) + (b-a)*sb(P_u,.) + (c-b)*sb(P_om,.),  C(X) = 1/2(eX+Xe)
On Weyl, sb(Id,.) = -Id, so   lambda = c_X - a + (b-a) u_X + (c-b) w_X
with c_X, u_X, w_X the Rayleigh quotients of the three operators on the summand.
"""
import sys, numpy as np
from fractions import Fraction
sys.path.insert(0, 'scripts/lib')
from review_r43_core import Ambient
from review_r43_cpm import Umat, build_e
from review_r43_hw import HW, analyse


def rq(x, y):
    return (np.vdot(x.ravel(), y.ravel()) / np.vdot(x.ravel(), x.ravel())).real


def pieces(m):
    H = HW(m); amb = H.amb; U = H.U; e = H.e; N = amb.N
    a, b, c = [Fraction(t) for t in __import__('review_r43_cpm').e_closed(m)]
    om = U.omega.astype(complex)
    f, fb = H.f, H.fb
    cases = {
        'trivial': H.e.astype(complex),
        'su(m)':   H.odot(H.wedge(f[0], fb[m-1]), om),
        'orbit':   H.odot(H.wedge(f[0], f[1]), om),
        'V22;0':   H.odot(H.wedge(f[0], f[1]), H.wedge(f[0], f[1])),
        'V2;2':    H.odot(H.wedge(f[0], fb[m-1]), H.wedge(f[0], fb[m-1])),
        'V21;1':   H.odot(H.wedge(f[0], f[1]), H.wedge(f[0], fb[m-1])),
    }
    if m >= 4:
        cases['V11;11'] = H.odot(H.wedge(f[0], f[1]), H.wedge(fb[m-2], fb[m-1]))
    out = {}
    for name, v0 in cases.items():
        v = H.pw(v0)
        if np.linalg.norm(v) < 1e-12:
            continue
        v /= np.linalg.norm(v)
        C = 0.5 * (e @ v + v @ e)
        SU = amb.sharp(U.P_u, v.real) + 1j * amb.sharp(U.P_u, v.imag)
        SW = amb.sharp(U.P_omega, v.real) + 1j * amb.sharp(U.P_omega, v.imag)
        SI = amb.sharp(np.eye(N), v.real) + 1j * amb.sharp(np.eye(N), v.imag)
        out[name] = (rq(v, C), rq(v, SI), rq(v, SU), rq(v, SW),
                     rq(v, C) + float(a) * rq(v, SI) + float(b - a) * rq(v, SU) + float(c - b) * rq(v, SW))
    return out, (a, b, c)


if __name__ == '__main__':
    R = lambda x: Fraction(x).limit_denominator(5000)
    for m in [int(x) for x in sys.argv[1:]] or [3, 4, 5, 6, 7]:
        d, (a, b, c) = pieces(m)
        print(f'\n=== m={m} ===   a={a} b-a={b-a} c-b={c-b}')
        print(f'{"summand":9} {"C":>12} {"sb(Id)":>8} {"sb(P_u)":>12} {"sb(P_om)":>12} {"lambda":>12}')
        for k, (cq, iq, uq, wq, lam) in d.items():
            print(f'{k:9} {str(R(cq)):>12} {str(R(iq)):>8} {str(R(uq)):>12} {str(R(wq)):>12} {str(R(lam)):>12}')
