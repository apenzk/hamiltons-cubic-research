"""r203: (A) plants against run_n5_order2.py's asserts, (B) the witness hunt.

(A) The file runs three asserts.  Two of them are identities that hold for any
    input whatsoever, so no corruption of W_0 can make them fire.
(B) An O(5)-invariant sextic vanishing at W_0 with nonzero gradient there would
    refute the whole claim.  The four trace sextics give a 3-dimensional space
    of invariant sextics vanishing at W_0; every gradient is exactly zero.  A
    sextic that merely VANISHES at W_0, without invariance, has a nonzero
    gradient -- which is what shows the check has teeth.
"""
import importlib.util, os, sys, random
from fractions import Fraction as F

RUNS = "scripts/runs"
def load(n):
    sp = importlib.util.spec_from_file_location(n[:-3], os.path.join(RUNS, n))
    m = importlib.util.module_from_spec(sp); o = sys.stdout
    sys.stdout = open(os.devnull, "w"); sp.loader.exec_module(m); sys.stdout = o
    return m
wm, ex = load("run_n5_weyl_module.py"), load("run_n5_extremiser.py")
NP, NS, SPAIRS, BASIS = wm.NP, wm.NS, wm.SPAIRS, wm.BASIS
S = ex.S

def opmul(A, B): return [[sum(A[i][k]*B[k][j] for k in range(NP) if A[i][k])
                          for j in range(NP)] for i in range(NP)]
def ip(A, B): return sum(A[i][j]*B[i][j] for i in range(NP) for j in range(NP))

print("=== (A) PLANTS AGAINST run_n5_order2.py ===\n")
print("A1. `assert ip(R, S) == 0` with c = ip(S2,S)/ip(S,S), R = S2 - c*S.")
print("    ip(R,S) = ip(S2,S) - c*ip(S,S) = 0 is c's defining equation.")
random.seed(203)
for tag, M in (("the real S", S),
               ("S with one entry corrupted",
                [[S[i][j] + (F(7,3) if (i, j) == (0, 0) else 0) for j in range(NP)]
                 for i in range(NP)]),
               ("a random symmetric matrix", None),
               ("a random NON-symmetric matrix", None)):
    if M is None:
        M = [[F(random.randint(-9, 9), random.randint(1, 5)) for _ in range(NP)]
             for _ in range(NP)]
        if "NON" not in tag:
            M = [[M[i][j] + M[j][i] for j in range(NP)] for i in range(NP)]
    M2 = opmul(M, M)
    c = F(ip(M2, M), ip(M, M))
    R = [[M2[i][j] - c*M[i][j] for j in range(NP)] for i in range(NP)]
    print(f"    {tag:34s} ip(R,M) == 0 -> {ip(R, M) == 0}")
print("    => the assert cannot fire.  It tests no property of W_0.\n")

print("A2. `assert 9 - F(54, 6) == 0` is 9 - 9 == 0: a constant.")
print("    The printed line uses tr(S^3); the assert does not.  Corrupting")
print("    tr(S^3) changes the printout and leaves the assert passing.")
tr3 = ip(opmul(S, S), S)
for scale in (F(1), F(5), F(0)):
    fake = F(tr3, 6)*scale
    print(f"    tr(W_0^3)*sqrt6 = {str(fake):>5}: printed 9 - {54*fake*fake}/6,"
          f"   assert 9-F(54,6)==0 -> {9 - F(54,6) == 0}")
print()
print("A3. `assert F(tr2,6) == 1 and F(tr3,6) == 1` DOES have content:")
print(f"    tr(S^2) = {ip(S,S)}, tr(S^3) = {tr3}; corrupting S breaks it.")
bad = [[S[i][j] + (F(1) if (i, j) == (0, 0) else 0) for j in range(NP)] for i in range(NP)]
print(f"    corrupted: tr = {ip(bad,bad)}, {ip(opmul(bad,bad),bad)} -> assert fires:"
      f" {not (F(ip(bad,bad),6) == 1 and F(ip(opmul(bad,bad),bad),6) == 1)}")

# ---------------------------------------------------------------- (B) -----
print("\n\n=== (B) WITNESS HUNT ===\n")
FREE = []
for k, b in enumerate(BASIS):
    FREE.append(next(c for c in range(NS)
                     if b[c] == 1 and all(BASIS[m][c] == 0 for m in range(len(BASIS)) if m != k)))
coords = lambda v: [v[f] for f in FREE]
sym2vec = lambda M: [M[a][b] for (a, b) in SPAIRS]
wgt = [F(1) if a == b else F(2) for (a, b) in SPAIRS]
def ip55(u, v): return sum(wgt[k]*u[k]*v[k] for k in range(NS))
Gram = [[ip55(BASIS[i], BASIS[j]) for j in range(35)] for i in range(35)]
def rref(M):
    M = [r[:] for r in M]; piv = []; r = 0; n = len(M[0])
    for c in range(n):
        p = next((k for k in range(r, len(M)) if M[k][c]), None)
        if p is None: continue
        M[r], M[p] = M[p], M[r]
        inv = F(1)/M[r][c]; M[r] = [x*inv for x in M[r]]
        for k in range(len(M)):
            if k != r and M[k][c]:
                f = M[k][c]; M[k] = [x - f*y for x, y in zip(M[k], M[r])]
        piv.append(c); r += 1
        if r == len(M): break
    return M, piv
def proj(v55):
    rhs = [ip55(BASIS[i], v55) for i in range(35)]
    R, piv = rref([Gram[i][:] + [rhs[i]] for i in range(35)])
    return [R[i][35] for i in range(35)]

# powers of W_0 = S/sqrt6.  Work with S and carry sqrt6 as an exponent of 6.
Spow = {1: S}
for m in range(2, 7): Spow[m] = opmul(Spow[m-1], S)
def tr(m): return sum(Spow[m][i][i] for i in range(NP))
# t_k(W_0) = tr(S^k)/6^(k/2).  Store as (rational, half-powers of 6) -> use
# exact values: 6^(k/2) is rational for even k, and sqrt6 appears only in t_3,
# which enters the sextics squared.
t2 = F(tr(2), 6); t4 = F(tr(4), 36); t6 = F(tr(6), 216)
t3sq = F(tr(3)*tr(3), 216)          # t_3^2, rational
w0 = coords(sym2vec(S))             # coords of S = sqrt6 W_0
# grad t_k (W_0) = k pi(W_0^{k-1}) = k pi(S^{k-1})/6^{(k-1)/2}
# express every gradient as a multiple of S (= sqrt6 W_0) so all is rational.
def pi_S(m): return proj(sym2vec(Spow[m]))
print(f"  t_2 = {t2}, t_3^2 = {t3sq}, t_4 = {t4}, t_6 = {t6}")
print(f"  F_5(W_0) = 3/2*t_2^3 - 9*t_3^2 = {F(3,2)*t2**3 - 9*t3sq}")

# gradients in the basis "multiple of S", i.e. grad = g * S with g rational
# grad(t_2^3) = 3 t_2^2 * 2 pi(W_0) = 6 W_0 = S  (since pi(S)=S, W_0=S/sqrt6)
#   we compute everything as: grad p (W_0) = G_p * W_0, G_p rational.
def coeff_of_S(vec):
    """vec must be a rational multiple of w0; return the multiple."""
    j = next((i for i in range(35) if w0[i]), None)
    lam = F(vec[j], 1)/w0[j]
    assert all(vec[i] == lam*w0[i] for i in range(35)), "NOT proportional to W_0"
    return lam
# pi(S^m) = a_m S
a = {m: coeff_of_S(pi_S(m)) for m in range(1, 6)}
print(f"  pi(S^m) = a_m S with a_m = {[str(a[m]) for m in range(1,6)]}")
# grad t_k (W_0) = k pi(S^{k-1}) / 6^{(k-1)/2} = k a_{k-1} S / 6^{(k-1)/2}
#               = k a_{k-1} 6^{1/2} W_0 / 6^{(k-1)/2} = k a_{k-1} 6^{(2-k)/2} W_0
# For the sextics we only need k = 2,3,4,6 and the sqrt6 cancels in every
# invariant sextic, so track G in units of W_0:
G_t2 = 2*a[1]*F(1)          # k=2: 2 a_1 6^0 = 2
G_t4 = 4*a[3]*F(1, 6)       # k=4: 4 a_3 6^{-1}
G_t6 = 6*a[5]*F(1, 36)      # k=6: 6 a_5 6^{-2}
G_t3_over_sqrt6 = 3*a[2]*F(1, 6)   # grad t_3 = (3 a_2/6) S = (3 a_2)/sqrt6 * W_0
print(f"  grad t_2 = {G_t2} W_0,  grad t_4 = {G_t4} W_0,  grad t_6 = {G_t6} W_0"
      f"   (Euler predicts k*t_k = {2*t2}, {4*t4}, {6*t6})")
print(f"  grad t_3 = {G_t3_over_sqrt6} * S = {3*a[2]}/sqrt6 * W_0"
      f"   (Euler: <grad t_3, W_0> = 3 t_3 = 3/sqrt6: {3*a[2] == 3})")
cands = {
    "t_2 t_4 - (1/2) t_2^3":  (t2*t4 - F(1,2)*t2**3,
                               t4*G_t2 + t2*G_t4 - F(1,2)*3*t2**2*G_t2),
    "t_3^2 - (1/6) t_2^3":    (t3sq - F(1,6)*t2**3,
                               2*F(tr(3),6)*G_t3_over_sqrt6 - F(1,6)*3*t2**2*G_t2),
    "t_6 - (11/36) t_2^3":    (t6 - F(11,36)*t2**3,
                               G_t6 - F(11,36)*3*t2**2*G_t2),
    "F_5 = 3/2 t_2^3 - 9 t_3^2": (F(3,2)*t2**3 - 9*t3sq,
                               F(3,2)*3*t2**2*G_t2 - 9*2*F(tr(3),6)*G_t3_over_sqrt6),
}
print("\n  invariant sextic            p(W_0)   grad p(W_0) as a multiple of W_0")
for nm, (val, g) in cands.items():
    print(f"   {nm:28s} {str(val):>5}    {str(g):>5}     Euler 6p = {6*val}")
print("  every invariant sextic vanishing at W_0 has gradient exactly 0 there.")

print("\n  the same test on a sextic that is NOT invariant (the control):")
random.seed(7)
v55 = [F(random.randint(-5, 5)) for _ in range(NS)]
v = proj(v55)                         # a random direction inside Weyl_5
# p(W) = <W,v>^6 - <W_0,v>^6 |W|^6 vanishes at W_0; grad = 6<W_0,v>^5 v - 6<W_0,v>^6 W_0
def ipc(x, y): return sum(Gram[i][j]*x[i]*y[j] for i in range(35) for j in range(35))
n0 = ipc(w0, w0)                       # = |S|^2 = 6
b = F(ipc(w0, v), 1)/6                 # <W_0, v> with W_0 = S/sqrt6 -> b/sqrt6
grad = [6*b**5*v[i] - 6*b**6*w0[i] for i in range(35)]   # up to powers of sqrt6
prop = all(grad[i]*w0[0] == grad[0]*w0[i] for i in range(35))
print(f"   p(W) = <W,v>^6 - <W_0,v>^6|W|^6 : p(W_0) = 0, grad proportional to W_0: {prop}")
print(f"   grad is the zero vector: {not any(grad)}")
print("   => vanishing at W_0 alone gives nothing; O(5)-invariance (in fact only")
print("      H-invariance) is what forces the gradient into span(W_0).")
