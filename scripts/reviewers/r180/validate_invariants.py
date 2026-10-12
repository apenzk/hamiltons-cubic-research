import sys, os, time
sys.path.insert(0, os.path.dirname(__file__))
from wtlib import *
from dominant_sym import dominant_set

def invariants_of(ch, r, typ, kmax):
    dominate = dominant_D if typ == 'D' else dominant_B
    plist = {j: list(adams(ch, j).items()) for j in range(1, kmax+1)}
    B = max(sum(abs(x) for x in w) for w in ch)
    h = {0: {tuple([0]*r): 1}}
    for k in range(1, kmax+1):
        cur = {}
        for mu in dominant_set(r, typ, B*k):
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
    W = weyl_elements(r, typ); rh = rho(r, typ)
    out = []
    for k in range(1, kmax+1):
        tot = 0
        for perm, signs, det in W:
            d = tuple(a-b for a, b in zip(rh, act(rh, perm, signs)))
            if all(float(x).is_integer() for x in d):
                v = h[k].get(dominate(tuple(int(x) for x in d)))
                if v:
                    tot += det*v
        out.append(tot)
    return out

def npart(k, parts):
    # number of partitions of k into parts from the given list
    dp = [0]*(k+1); dp[0] = 1
    for p in parts:
        for x in range(p, k+1):
            dp[x] += dp[x-p]
    return dp[k]

K = 8
for r, odd, n in [(2, True, 5), (3, False, 6), (4, False, 8), (5, False, 10)]:
    typ = 'B' if odd else 'D'
    V = char_vector(r, odd)
    S2 = add(sym_power(V, 2), {tuple([0]*r): 1}, -1)          # Sym^2_0
    L2 = ext_power_char(V, 2)
    gS = invariants_of(S2, r, typ, K)
    gL = invariants_of(L2, r, typ, K)
    pS = [npart(k, list(range(2, n+1))) for k in range(1, K+1)]
    pL = [npart(k, list(range(2, 2*(n//2)+1, 2))) for k in range(1, K+1)]
    print('n=%2d  Sym^k(Sym^2_0)^O : %s   predicted %s   %s' % (n, gS, pS, 'OK' if gS == pS else 'FAIL'))
    print('      Sym^k(Lambda^2)^O: %s   predicted %s   %s' % (gL, pL, 'OK' if gL == pL else 'FAIL'))
