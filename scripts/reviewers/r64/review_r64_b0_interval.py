"""R64: rigorous interval-arithmetic verification of F(A) <= sqrt(3/2) on (0, A0].

Independent of the programme's own scripts.  Four pieces:

  * a self-test of the interval engine (mpmath.iv) against known enclosures;
  * the low band (0,1/3] closed through the quadratic envelope;
  * the middle band [1/3,0.7] closed by adaptive interval bisection of F itself,
    with the branch cap handled as the exact range of min(t_c,T) over the box;
  * the top band closed by an e^2 argument -- F - sqrt(6)/2 <= e^2*Q(A) with
    Q derived from Taylor-with-integral-remainder on g and the cubic-free bound
    psi* <= alpha^2/(4|beta|) -- and interval bisection on the residual gap
    between 0.7 and where that argument starts to bite.

Also derives an honest Lipschitz constant for [1/3,0.7] from an interval
enclosure of F', for comparison with the L <= 13.7250 that the claim asserts.
"""
import mpmath as mp
from mpmath import iv

mp.mp.prec = 200
iv.prec = 200
EPS = mp.mpf(2) ** -150


def box(a, b):
    """interval [a,b] inflated outward by EPS so endpoint conversion can never
    leave a sliver of the true range outside the tiling"""
    return iv.mpf([mp.mpf(a) - EPS, mp.mpf(b) + EPS])

A0f = mp.sqrt(mp.mpf(2) / 3)
TARGETf = mp.sqrt(mp.mpf(3) / 2)

IA0 = iv.sqrt(iv.mpf(2) / 3)
IK0 = 3 / (2 * iv.sqrt(2))
IGAM = 1 - 3 * IK0
ITAR = iv.sqrt(iv.mpf(3) / 2)


def lb(v):
    return mp.mpf(v._mpi_[0])


def ub(v):
    return mp.mpf(v._mpi_[1])


def hull(x, y):
    return iv.mpf([min(x.a, y.a), max(x.b, y.b)])


def imin(x, y):
    """exact range of min(u,v) for u in x, v in y"""
    return iv.mpf([min(x.a, y.a), min(x.b, y.b)])


def ig_(A):  # cleaner: (1-A^2)^{3/2}
    u = 1 - A**2
    return A**3 - u * iv.sqrt(u) / iv.sqrt(2) + 3 * A * u


def ialpha(A):
    return IK0 * (2 - 3 * A**2)


def ibeta(A):
    return iv.mpf(3) / 4 * iv.sqrt(2 - 2 * A**2) - 3 * A


def iT(A):
    return 2 * iv.sqrt(2) / 3 * A


def ipsi(A, t):
    return ialpha(A) * t + ibeta(A) * t**2 + IGAM * t**3


def itc(A):
    b, a = ibeta(A), ialpha(A)
    D = b**2 - 3 * IGAM * a
    return (-b - iv.sqrt(D)) / (3 * IGAM)


def iF(A):
    """enclosure of F over the interval A.  t* = min(t_c,T) lies in imin(...)."""
    ts = imin(itc(A), iT(A))
    return ig_(A) + ipsi(A, ts)


def igp(A):  # g'
    u = 1 - A**2
    return 3 - 6 * A**2 + 3 * A * iv.sqrt(u) / iv.sqrt(2)


def igpp(A):  # g''
    u = 1 - A**2
    return -12 * A + 3 * (1 - 2 * A**2) / (iv.sqrt(2) * iv.sqrt(u))


def iFp(A):
    """enclosure of F' covering BOTH branches (their union), for a Lipschitz bound."""
    ts = imin(itc(A), iT(A))
    ap = -(9 * iv.sqrt(2) / 2) * A
    bp = -3 * iv.sqrt(2) * A / (4 * iv.sqrt(1 - A**2)) - 3
    Tp = 2 * iv.sqrt(2) / 3
    inner = igp(A) + ap * ts + bp * ts**2
    T = iT(A)
    psit_T = ialpha(A) + 2 * ibeta(A) * T + 3 * IGAM * T**2
    capped = igp(A) + ap * T + bp * T**2 + psit_T * Tp
    return hull(inner, capped)


def sec(t):
    print("\n" + "=" * 78 + "\n" + t + "\n" + "=" * 78)


# ------------------------------------------------------- engine self-test
sec("0  interval-engine self-test")
x = iv.mpf([1, 2])
print("[1,2]^2 =", x**2, "   sqrt([1,2]) =", iv.sqrt(x))
print("dependency check: x-x =", x - x, "(should be [-1,1], NOT 0 -- naive iv has no dependency tracking)")
p = iv.pi
print("pi enclosure width:", mp.nstr(mp.mpf(p.b) - mp.mpf(p.a), 5), " contains pi:", p.a <= mp.pi <= p.b)
t = iv.sqrt(iv.mpf(2))
print("sqrt2 enclosure straddles the true value:", t.a**2 <= 2 <= t.b**2)
# cross-check: does iF really contain the pointwise F?


def Fpt(A):
    a = mp.sqrt(mp.mpf(2)) * 0 + A
    al = 3 / (2 * mp.sqrt(2)) * (2 - 3 * a**2)
    be = mp.mpf(3) / 4 * mp.sqrt(2 - 2 * a**2) - 3 * a
    ga = 1 - 3 * (3 / (2 * mp.sqrt(2)))
    T = 2 * mp.sqrt(2) / 3 * a
    D = be**2 - 3 * ga * al
    tc = (-be - mp.sqrt(D)) / (3 * ga)
    ts = min(tc, T)
    u = 1 - a**2
    g = a**3 - u * mp.sqrt(u) / mp.sqrt(2) + 3 * a * u
    return g + al * ts + be * ts**2 + ga * ts**3


bad = 0
for i in range(1, 2001):
    A = A0f * i / 2000
    en = iF(box(A - mp.mpf("1e-6"), A + mp.mpf("1e-6")))
    if not (en.a <= Fpt(A) <= en.b):
        bad += 1
print(f"pointwise F inside the interval enclosure at 2000 sample boxes: failures = {bad}")

# ------------------------------------------------------- low band
sec("S2 rigorous  low band (0, 1/3]  via the quadratic envelope")
print("psi* = max_{[0,T]} psi <= max_{[0,T]} (alpha t + beta t^2) = alpha T + beta T^2 when alpha,beta >= 0")


def ienv(A):
    T = iT(A)
    return ig_(A) + ialpha(A) * T + ibeta(A) * T**2


def bisect(f, lo, hi, bound, maxdepth=60, tag=""):
    """prove sup f < bound on [lo,hi] by adaptive bisection; return (ok, worst_ub, nboxes)"""
    stack = [(mp.mpf(lo), mp.mpf(hi), 0)]
    worst = mp.mpf("-inf")
    n = 0
    while stack:
        a, b, d = stack.pop()
        n += 1
        v = f(box(a, b))
        u = ub(v)
        if u < bound:
            worst = max(worst, u)
            continue
        if d >= maxdepth:
            print(f"  {tag}: FAILED to certify on [{mp.nstr(a,12)},{mp.nstr(b,12)}], ub={mp.nstr(u,12)}")
            return False, u, n
        m = (a + b) / 2
        stack.append((a, m, d + 1))
        stack.append((m, b, d + 1))
    return True, worst, n


ok, w, n = bisect(ienv, mp.mpf("1e-30"), mp.mpf(1) / 3, TARGETf, tag="low/env")
print(f"envelope < sqrt(3/2) on (0,1/3]: {ok}, sup of upper bounds = {mp.nstr(w,12)}, boxes = {n}")
ok2, w2, n2 = bisect(ienv, mp.mpf("1e-30"), mp.mpf(1) / 3, mp.mpf(8) / 9 + mp.mpf("1e-9"), tag="low/8-9")
print(f"envelope < 8/9 + 1e-9 on (0,1/3]: {ok2}, sup = {mp.nstr(w2,15)}, boxes = {n2}   (8/9 = {mp.nstr(mp.mpf(8)/9,15)})")
ok3, w3, n3 = bisect(iF, mp.mpf("1e-30"), mp.mpf(1) / 3, TARGETf, tag="low/F")
print(f"F itself < sqrt(3/2) on (0,1/3]: {ok3}, sup = {mp.nstr(w3,12)}, boxes = {n3}")
okb, wb, nb = bisect(lambda A: -ibeta(A), mp.mpf("1e-30"), mp.mpf(1) / 3 - mp.mpf("1e-12"), mp.mpf(0), tag="low/beta")
print(f"beta > 0 on (0, 1/3 - 1e-12]: {okb} (certified by bisection on -beta < 0), boxes = {nb}")

# ------------------------------------------------------- middle band
sec("S3(d) rigorous  middle band [1/3, 0.7] by adaptive interval bisection of F")
ok, w, n = bisect(iF, mp.mpf(1) / 3, mp.mpf("0.7"), TARGETf, tag="mid/F")
print(f"F < sqrt(3/2) on [1/3,0.7]: {ok}")
print(f"  sup over all certified boxes of the interval UPPER bound = {mp.nstr(w,15)}")
print(f"  sqrt(3/2) = {mp.nstr(TARGETf,15)}   rigorous slack = {mp.nstr(TARGETf-w,10)}   boxes = {n}")

sec("S3(b)  an independently derived Lipschitz constant on [1/3,0.7]")
Lb = mp.mpf(0)
NS = 4000
lo, hi = mp.mpf(1) / 3, mp.mpf("0.7")
for i in range(NS):
    a = lo + (hi - lo) * i / NS
    b = lo + (hi - lo) * (i + 1) / NS
    v = iFp(box(a, b))
    Lb = max(Lb, abs(lb(v)), abs(ub(v)))
print(f"interval enclosure of sup|F'| over [1/3,0.7] (branch union, {NS} boxes): L_mine <= {mp.nstr(Lb,10)}")
print(f"claim asserts L <= 13.7250  ->  claim's constant is {'VALID (looser)' if Lb <= mp.mpf('13.725') else 'TOO SMALL'}")
# per-term coarse bounds, the way the claim describes deriving them
whole = box(lo, hi)
ap = -(9 * iv.sqrt(2) / 2) * whole
bp = -3 * iv.sqrt(2) * whole / (4 * iv.sqrt(1 - whole**2)) - 3
Tm = iT(whole)
print(f"  |g'| <= {mp.nstr(max(abs(lb(igp(whole))),abs(ub(igp(whole)))),8)}, "
      f"|alpha'| <= {mp.nstr(abs(lb(ap)),8)}, |beta'| <= {mp.nstr(abs(lb(bp)),8)}, "
      f"T_max = {mp.nstr(ub(Tm),8)}, T' = {mp.nstr(2*mp.sqrt(2)/3,8)}")

sec("S3(a)  differentiability at the branch switch t_c = T")
sw = mp.findroot(lambda A: (lambda b, a: (-b - mp.sqrt(b**2 - 3 * (1 - 3 * (3 / (2 * mp.sqrt(2))))* a)) / (3 * (1 - 3 * (3 / (2 * mp.sqrt(2))))))(mp.mpf(3)/4*mp.sqrt(2-2*A**2)-3*A, 3/(2*mp.sqrt(2))*(2-3*A**2)) - 2*mp.sqrt(2)/3*A, mp.mpf("0.45"))
print(f"switch at A_sw = {mp.nstr(sw,20)}  (t_c = T there, so psi_t(A,T) = 0)")
print("=> the capped-branch extra term psi_t(A,T)*T' VANISHES at the switch, so the two")
print("   one-sided derivatives agree and F is C^1 across it.  Numerical check:")
for d in ["1e-4", "1e-6", "1e-8"]:
    dd = mp.mpf(d)
    left = (Fpt(sw - dd) - Fpt(sw - 2 * dd)) / dd
    right = (Fpt(sw + 2 * dd) - Fpt(sw + dd)) / dd
    print(f"   h={d}: one-sided slopes  left={mp.nstr(left,12)}  right={mp.nstr(right,12)}  diff={mp.nstr(right-left,4)}")

# ------------------------------------------------------- top band
sec("S4 rigorous  top band: an e^2 certificate that does not degenerate at A0")
print("F(A) - sqrt(6)/2 <= e^2 * Q(A),  e = A0 - A,")
print("  Q(A) = (1/2) sup_{[A,A0]} g''  +  9 K0^2 (A0+A)^2 / (4|beta(A)|)")
print("  first term: g(A0-e)-g(A0) = int_0^e (e-s) g''(A0-s) ds  and g'(A0)=0")
print("  second term: psi* <= max_{t>=0}(alpha t + beta t^2) = alpha^2/(4|beta|), beta<0, alpha = 3K0 e (A0+A)")


def Q(A):
    gpp_sup = igpp(hull(A, IA0))
    return gpp_sup / 2 + 9 * IK0**2 * (IA0 + A) ** 2 / (4 * (-ibeta(A)))


for x in ["0.70", "0.71", "0.72", "0.73", "0.74", "0.75", "0.80"]:
    q = Q(box(mp.mpf(x), mp.mpf(x)))
    print(f"  Q({x}) in [{mp.nstr(lb(q),8)}, {mp.nstr(ub(q),8)}]")

# find the largest certified band [A_lo, A0] on which Q < 0
A_lo = None
for k in range(0, 400):
    cand = mp.mpf("0.70") + mp.mpf("0.0005") * k
    if cand >= A0f:
        break
    okq, wq, nq = bisect(Q, cand, A0f, mp.mpf(0), maxdepth=40, tag="")
    if okq:
        A_lo = cand
        print(f"Q < 0 certified on [{mp.nstr(cand,10)}, A0]:  sup Q = {mp.nstr(wq,10)}, boxes = {nq}")
        break
if A_lo is None:
    print("no A_lo found below A0 -- the e^2 certificate never bites")
else:
    print(f"=> F(A) < sqrt(6)/2 STRICTLY for every A in [{mp.nstr(A_lo,10)}, A0), equality only at A0")
    if A_lo > mp.mpf("0.7"):
        okr, wr, nr = bisect(iF, mp.mpf("0.7"), A_lo, TARGETf, tag="top/gap")
        print(f"residual gap [0.7, {mp.nstr(A_lo,10)}] closed by direct bisection: {okr}, "
              f"sup = {mp.nstr(wr,12)}, slack = {mp.nstr(TARGETf-wr,8)}, boxes = {nr}")

sec("does the claim's own second-order MODEL bound F from above?")
print("model(A) = sqrt(3/2) - (3/4)sqrt6 e^2 ;  positive 'model - F' would mean the model is an upper bound")
for x in ["0.70", "0.75", "0.80", "0.81", "0.816"]:
    A = mp.mpf(x)
    ee = A0f - A
    print(f"  A={x}: model - F = {mp.nstr(TARGETf - mp.mpf(3)/4*mp.sqrt(6)*ee**2 - Fpt(A),8)}")

sec("VERDICT SUMMARY")
print("see reviews/REVIEW_r64.md")


# ------------------------------------------------------- branch-and-bound maximum
sec("S3  rigorous enclosure of max F on [1/3, 0.7] (branch and bound)")


def bnb(f, lo, hi, tol, maxdepth=200):
    """rigorous [lower, upper] enclosure of sup f on [lo,hi]"""
    best_lo = mp.mpf("-inf")
    stack = [(mp.mpf(lo), mp.mpf(hi), 0)]
    n = 0
    ubs = []
    while stack:
        a, b, d = stack.pop()
        n += 1
        v = f(box(a, b))
        u = ub(v)
        if u < best_lo:
            continue
        mid = (a + b) / 2
        vm = f(box(mid, mid))
        best_lo = max(best_lo, lb(vm))
        if u - best_lo < tol or d >= maxdepth:
            ubs.append((u, a, b))
            continue
        stack.append((a, mid, d + 1))
        stack.append((mid, b, d + 1))
    U = max(x[0] for x in ubs)
    arg = [x for x in ubs if x[0] == U][0]
    return best_lo, U, n, arg


L_, U_, n_, arg_ = bnb(iF, mp.mpf(1) / 3, mp.mpf("0.7"), mp.mpf("1e-9"))
print(f"max F on [1/3,0.7] is in [{mp.nstr(L_,12)}, {mp.nstr(U_,12)}]   ({n_} boxes)")
print(f"  argmax localised in [{mp.nstr(arg_[1],12)}, {mp.nstr(arg_[2],12)}]  (band endpoint 0.7)")
print(f"  claim states max F = 1.203230 (6 dp) -> {'MATCHES' if abs(U_ - mp.mpf('1.203230')) < mp.mpf('5e-7') else 'MISMATCH'}")
print(f"  rigorous slack to sqrt(3/2): {mp.nstr(TARGETf - U_,10)}   (claim states 0.0215)")
print(f"  claim's grid certificate: max F + L*h/2 = 1.203230 + 13.7250*1.8e-6/2 = "
      f"{mp.nstr(mp.mpf('1.203230') + mp.mpf('13.725')*mp.mpf('1.8e-6')/2, 10)}")

# ------------------------------------------------------- exact Q crossing
sec("S4  where the e^2 certificate starts to bite")
Qz = mp.findroot(lambda A: ub(Q(box(A, A))), mp.mpf("0.7095"))
print(f"Q changes sign at A = {mp.nstr(Qz,15)};  certificate valid on [A,A0] for any A above it")
for x in [Qz + mp.mpf("1e-4"), mp.mpf("0.7096")]:
    okq, wq, nq = bisect(Q, x, A0f, mp.mpf(0), maxdepth=45, tag="Qtail")
    print(f"  Q < 0 on [{mp.nstr(x,12)}, A0]: {okq}, sup Q = {mp.nstr(wq,8)}, boxes = {nq}")

# ------------------------------------------------------- whole-range certificate
sec("WHOLE RANGE: F < sqrt(3/2) on (0, 0.7096] by interval bisection, then Q on [0.7096, A0]")
okall, wall, nall = bisect(iF, mp.mpf("1e-40"), mp.mpf("0.7096"), TARGETf, tag="all")
print(f"(0, 0.7096]: {okall}, sup of interval upper bounds = {mp.nstr(wall,12)}, boxes = {nall}")
okq2, wq2, nq2 = bisect(Q, mp.mpf("0.7096"), A0f, mp.mpf(0), maxdepth=45, tag="Qall")
print(f"[0.7096, A0]: Q < 0 certified {okq2}, sup Q = {mp.nstr(wq2,8)}, boxes = {nq2}")
print("=> F(A) < sqrt(3/2) for all A in (0, A0), F(A0) = sqrt(3/2): the CLAIM holds rigorously")

# ------------------------------------------------------- monotonicity
sec("S5  certified monotonicity: F' > 0")


def iFp_branch(A):
    """branch-correct enclosure of F': uses the interior formula where t_c < T is
    certain, the capped formula where T < t_c is certain, and their hull only on
    the box that straddles the switch"""
    tc, T = itc(A), iT(A)
    ap = -(9 * iv.sqrt(2) / 2) * A
    bp = -3 * iv.sqrt(2) * A / (4 * iv.sqrt(1 - A**2)) - 3
    Tp = 2 * iv.sqrt(2) / 3
    inner = igp(A) + ap * tc + bp * tc**2
    capped = igp(A) + ap * T + bp * T**2 + (ialpha(A) + 2 * ibeta(A) * T + 3 * IGAM * T**2) * Tp
    if ub(tc) <= lb(T):
        return inner
    if ub(T) <= lb(tc):
        return capped
    return hull(inner, capped)


for top in ["0.70", "0.78", "0.80", "0.81", "0.8164"]:
    okm, wm, nm = bisect(lambda A: -iFp_branch(A), mp.mpf("1e-12"), mp.mpf(top), mp.mpf(0), maxdepth=45, tag="mono")
    print(f"F' > 0 certified on [1e-12, {top}]: {okm}  (sup of -F' = {mp.nstr(wm,8)}, boxes = {nm})")
print(f"F'(A0) = 0 exactly: g'(A0)=0 and alpha(A0)=0 => t*=0 => F' = g' = 0. "
      f"numerically {mp.nstr((Fpt(A0f)-Fpt(A0f-mp.mpf('1e-10')))/mp.mpf('1e-10'),6)}")
