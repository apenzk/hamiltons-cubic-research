"""The one place the 3! in sym3_ip is OBSERVABLE: the trivial block.

run_n5_evaluate.py names its own falsifier -- on the trivial block B must
reproduce  144^2 tr(W^3)^2, the value the pointwise route gets as |P_1|^2 with
P_1 = 144 tr(W^3)  (reviewer 189/190).  The evaluation route instead computes
B_11 = c^dag M c with c the coordinate of W^3 on the invariant line, i.e.

        B_11 = |<W^3, u>_M|^2 / <u,u>_M,

which is homogeneous of degree ONE in M.  So B_11 scales with whatever global
constant sym3_ip carries, and the ratio B_11 / |P_1|^2 measures it directly.
"""
import sys, os, random, itertools
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from common import *

H = build_H()
Hm = Hfull(H)

def sym3_ip(t, s):
    tot = Z
    for perm in itertools.permutations(range(3)):
        term = ONE; ok = True
        for i in range(3):
            e = H.get((t[i], s[perm[i]]))
            if e is None: ok = False; break
            term = cmul(term, e)
        if ok: tot = cadd(tot, term)
    return tot

# --- the trivial-block highest weight vector, from the cache ---
hw0 = C["hw"]["0,0"]
cols = hw0["cols"]; vecs = hw0["vecs"] if "vecs" in hw0 else hw0[[k for k in hw0 if k != "cols"][0]]
assert len(vecs) == 1, len(vecs)
u = {cols[i]: gq(v) for i, v in enumerate(vecs[0]) if gq(v) != Z}
print(f"trivial block: weight-0 space {len(cols)}, hw vectors {len(vecs)}, "
      f"support of u = {len(u)} monomials")
print(f"  every monomial of u has weight (0,0): {all(MW[i]==(0,0) for i in u)}")

# --- a real W inside the span, and its coordinates ---
Tq = [[[[[gq(T[a][i][j][k][l]) for l in range(5)] for k in range(5)]
        for j in range(5)] for i in range(5)] for a in range(35)]
random.seed(3191)

def real_W(seed):
    random.seed(seed)
    r = [F(random.randint(-4, 4), random.randint(1, 3)) for _ in range(35)]
    out = [[[[F(0)]*5 for _ in range(5)] for _ in range(5)] for _ in range(5)]
    for a in range(35):
        if r[a] == 0: continue
        Ta = Tq[a]
        for i in range(5):
            for j in range(5):
                for k in range(5):
                    for l in range(5):
                        y = Ta[i][j][k][l]
                        if y != Z: out[i][j][k][l] += 2*r[a]*y[0]      # f_a + conj f_a
    return out

def coords(Wt):
    rhs = {}
    for b in range(35):
        re = im = F(0); Tb = Tq[b]
        for i in range(5):
            for j in range(5):
                for k in range(5):
                    for l in range(5):
                        y = Tb[i][j][k][l]; x = Wt[i][j][k][l]
                        if x: re += x*y[0]; im += -x*y[1]
        rhs[b] = (re, im)
    w = {}
    for mu, idxs in BYW.items():
        n = len(idxs)
        A = [[H.get((a, b), Z) for a in idxs] for b in idxs]
        M = [A[r][:] + [rhs[idxs[r]]] for r in range(n)]
        for c in range(n):
            p = next(r for r in range(c, n) if M[r][c] != Z)
            M[c], M[p] = M[p], M[c]
            iv = cinv(M[c][c]); M[c] = [cmul(iv, z) for z in M[c]]
            for r in range(n):
                if r != c and M[r][c] != Z:
                    f = M[r][c]
                    M[r] = [csub(z, cmul(f, y)) for z, y in zip(M[r], M[c])]
        for r, a in enumerate(idxs): w[a] = M[r][n]
    return w, rhs

W0 = [i for i, m in enumerate(MW) if m == (0, 0)]
uu = None
for seed in (11, 12, 13):
    Wt = real_W(seed)
    w, rhs = coords(Wt)
    # P_1 by evaluation at w  (the pointwise route)
    P1 = Z
    for i, c in u.items():
        t = MONO[i]; z = c
        for a in t: z = cmul(z, w[a])
        P1 = cadd(P1, z)
    # <W^3, u> with M = sym3_ip, by the honest double sum over the weight-0 space
    q = {}
    for i in W0:
        t = MONO[i]; z = (F(multinom(t)), F(0))
        for a in t: z = cmul(z, w[a])
        if z != Z: q[i] = z
    ip = Z
    for i, qt in q.items():
        for j, cs in u.items():
            m = sym3_ip(MONO[i], MONO[j])
            if m != Z: ip = cadd(ip, cmul(qt, cmul(cconj(cs), m)))
    if uu is None:
        uu = Z
        for i, ci in u.items():
            for j, cj in u.items():
                m = sym3_ip(MONO[i], MONO[j])
                if m != Z: uu = cadd(uu, cmul(ci, cmul(cconj(cj), m)))
        print(f"  <u,u>_sym3_ip = ({uu[0]}) + ({uu[1]})i")
    B11 = cdiv(cmul(ip, cconj(ip)), uu)
    P1sq = cmul(P1, cconj(P1))
    print(f"\nseed {seed}: P_1 = ({P1[0]}) + ({P1[1]})i")
    print(f"  B_11 (M = sym3_ip)      = ({B11[0]}) + ({B11[1]})i")
    print(f"  B_11 / |P_1|^2          = {cdiv(B11, P1sq)}")
    print(f"  B_11 / |P_1|^2 with M/3! = {cdiv(cdiv(B11,(F(6),F(0))), P1sq)}")
