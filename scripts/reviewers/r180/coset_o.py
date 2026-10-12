"""dim V^{O(2r)} from dim V^{SO(2r)} plus the integral over the OTHER component.

g in O(2r)^- has eigenvalues {t_j, t_j^-1}_{j<r} together with +1 and -1.
Ad(g) on so(2r) = Lambda^2 of that, so the twisted Weyl density on the coset is
   prod_{alpha in D_{r-1}}(1-t^a) * prod_j (1-t_j^2)(1-t_j^-2)  =  prod_{alpha in C_{r-1}}(1-t^a),
i.e. the coset integral is a Weyl integration for the root system C_{r-1}:
   int_{O(2r)^-} f  =  sum_{w in W(C_{r-1})} det(w) * f_{rho_C - w rho_C}.
"""
import sys, os
sys.path.insert(0, os.path.dirname(__file__))
from wtlib import *
from dominant_sym import dominant_set


def coset_q(m, kmax):
    """q_k = chi_V(g^k) as a Laurent polynomial in t_1..t_m (m = r-1)."""
    out = {}
    for k in range(1, kmax+1):
        d = {}
        for j in range(m):
            for s in (k, -k):
                w = [0]*m; w[j] = s
                d[tuple(w)] = d.get(tuple(w), 0) + 1
        z = tuple([0]*m)
        d[z] = d.get(z, 0) + 1 + (-1)**k
        out[k] = {w: c for w, c in d.items() if c}
    return out


def newton_e(q, k, kmul=1):
    """e_k of the eigenvalues raised to the power kmul, from power sums q."""
    e = {0: {(0,)*len(next(iter(q[1]))): 1}}
    for m in range(1, k+1):
        acc = {}
        for j in range(1, m+1):
            acc = add(acc, mul(q[j*kmul], e[m-j]), 1 if (j-1) % 2 == 0 else -1)
        e[m] = divide(acc, m)
    return e[k]


def coset_weyl_char(r, kmax):
    """chi_{W_2r}(g^k) on the coset, k = 1..kmax."""
    m = r-1
    q = coset_q(m, 4*kmax + 4)
    L2 = {}      # chi_{Lambda^2 V}(g^k)
    for k in range(1, 2*kmax+3):
        L2[k] = divide(add(mul(q[k], q[k]), q[2*k], -1), 2)
    out = {}
    for k in range(1, kmax+1):
        s2l2 = divide(add(mul(L2[k], L2[k]), L2[2*k]), 2)
        l4 = newton_e(q, 4, k)
        s2v = divide(add(mul(q[k], q[k]), q[2*k]), 2)
        out[k] = add(add(s2l2, l4, -1), s2v, -1)
    return out


def coset_integral(r, kmax):
    """int_{O(2r)^-} chi_{Sym^k W_2r}, k = 1..kmax."""
    m = r-1
    P = coset_weyl_char(r, kmax)
    dominate = lambda w: tuple(sorted((abs(x) for x in w), reverse=True))
    plist = {j: list(P[j].items()) for j in P}
    h = {0: {(0,)*m: 1}}
    for k in range(1, kmax+1):
        cur = {}
        for mu in dominant_set(m, 'B', 4*k):
            s = 0
            for j in range(1, k+1):
                hj = h[k-j]
                for nu, c in plist[j]:
                    v = hj.get(dominate(tuple(a-b for a, b in zip(mu, nu))))
                    if v:
                        s += c*v
            if s:
                assert s % k == 0
                cur[mu] = s//k
        h[k] = cur
    WC = weyl_elements(m, 'B')          # W(C_m) = W(B_m)
    rhoC = tuple(m-i for i in range(m))  # (m, m-1, ..., 1)
    out = []
    for k in range(1, kmax+1):
        tot = 0
        for perm, signs, det in WC:
            d = tuple(a-b for a, b in zip(rhoC, act(rhoC, perm, signs)))
            v = h[k].get(dominate(d))
            if v:
                tot += det*v
        out.append(tot)
    return out


def coset_integral_generic(r, kmax, build):
    """same, for an arbitrary module given by k -> chi(g^k) on the coset."""
    m = r-1
    P = build(r, kmax)
    dominate = lambda w: tuple(sorted((abs(x) for x in w), reverse=True))
    plist = {j: list(P[j].items()) for j in P}
    B = max([max([sum(abs(x) for x in w) for w in P[j]] + [0]) for j in P] + [1])
    h = {0: {(0,)*m: 1}}
    for k in range(1, kmax+1):
        cur = {}
        for mu in dominant_set(m, 'B', B*k):
            s = 0
            for j in range(1, k+1):
                hj = h[k-j]
                for nu, c in plist[j]:
                    v = hj.get(dominate(tuple(a-b for a, b in zip(mu, nu))))
                    if v:
                        s += c*v
            if s:
                assert s % k == 0
                cur[mu] = s//k
        h[k] = cur
    WC = weyl_elements(m, 'B')
    rhoC = tuple(m-i for i in range(m))
    out = []
    for k in range(1, kmax+1):
        tot = 0
        for perm, signs, det in WC:
            d = tuple(a-b for a, b in zip(rhoC, act(rhoC, perm, signs)))
            v = h[k].get(dominate(d))
            if v:
                tot += det*v
        out.append(tot)
    return out
