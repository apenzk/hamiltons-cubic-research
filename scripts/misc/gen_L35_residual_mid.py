"""Generate lean/HamiltonsCubic/Results/L35ResidualMid.lean: L35's residual inequality on [1/3, 0.6733].

Each of 32 uniform pieces [A1, A2] gets rational upper bounds on alpha, beta, gamma, the cap T, the cubic's
maximum on [0, T], and g, every constant rounded outward to denominator 10^6; piece() asserts the rational
check before lean_piece() emits the Lean. Run: python3 scripts/misc/gen_L35_residual_mid.py > /dev/null prints
the 32 piece theorems; the file's header, the Fres definition and the combining theorem `middle` wrap them.
"""
from fractions import Fraction as Fr
import math
qlo,qhi=Fr(141421,100000),Fr(141422,100000)
clo=Fr(122474,100000)           # sqrt(3/2)=1.2247448...
def sqrt_lo(x,den=10**6): return Fr(math.isqrt(int(x*den*den)),den)          # <= sqrt(x)
def sqrt_hi(x,den=10**6): return Fr(math.isqrt(int(x*den*den))+1,den)        # >= sqrt(x)
def piece(A1,A2):
    s_hi=sqrt_hi(1-A1*A1); s_lo=sqrt_lo(1-A2*A2)
    al=3*qhi/4*(2-3*A1*A1); be=Fr(3,4)*qhi*s_hi-3*A1; ga=1-9*qlo/4; T=2*qhi*A2/3
    # max of al t + be t^2 + ga t^3 on [0,T]
    cands=[Fr(0),T]
    disc=be*be-3*ga*al
    if disc>=0:
        r=(-be-Fr(math.sqrt(float(disc))))/(3*ga)
        if 0<r<T: cands.append(r)
    f=lambda t: al*t+be*t*t+ga*t**3
    M=max(f(t) for t in cands)
    M=M+Fr(1,10**5)
    # crude g bound: A^3 <= A2^3 ; -q s^3/2 <= -qlo s_lo^3/2 ; 3A(1-A^2) <= max on [A1,A2]
    h=lambda A: 3*A*(1-A*A)
    top=Fr(1,1)/Fr(math.sqrt(3)).limit_denominator(10**6)
    hm=max(h(A1),h(A2)) if not (A1<top<A2) else Fr(2,1)/Fr(math.sqrt(3)).limit_denominator(10**6)+Fr(1,10**5)
    gb=A2**3-qlo*s_lo**3/2+hm
    return al,be,ga,T,M,s_lo,s_hi,gb,clo-gb-M
def partition(n,Astar):
    A0=Fr(1,3)
    return [A0+(Astar-A0)*Fr(i,n) for i in range(n+1)]

def L(x):
    x=Fr(x)
    if x.denominator==1: return f"({x.numerator} : ℝ)"
    return f"({x.numerator} / {x.denominator} : ℝ)"

def crit(al,be,ga,T):
    disc=be*be-3*ga*al
    r=(-be-Fr(math.sqrt(float(disc))))/(3*ga)
    return Fr(r).limit_denominator(10**4) if 0<r<T else None

def up(x,d=10**6): return Fr(math.ceil(Fr(x)*d),d)
def dn(x,d=10**6): return Fr(math.floor(Fr(x)*d),d)
def lean_piece(k,A1,A2):
    al,be,ga,T,M,slo,shi,gb,marg=piece(A1,A2)
    al,be,ga,T=up(al),up(be),up(ga),up(T)
    cands=[Fr(0),T]
    disc=be*be-3*ga*al
    if disc>=0:
        r0=(-be-Fr(math.sqrt(float(disc))))/(3*ga)
        if 0<r0<T: cands.append(r0)
    M=up(max(al*t+be*t*t+ga*t**3 for t in cands)+Fr(1,10**5))
    r=crit(al,be,ga,T)
    h=lambda A: 3*A*(1-A*A)
    top=Fr(1,1)/Fr(math.sqrt(3)).limit_denominator(10**6)
    hm=up(max(h(A1),h(A2)) if not (A1<top<A2) else Fr(2,1)/Fr(math.sqrt(3)).limit_denominator(10**6)+Fr(1,10**5))
    A23=up(A2**3); qs3=dn(qlo*slo**3/2)
    assert A23-qs3+hm+M<=clo, (k, float(clo-(A23-qs3+hm+M)))
    hints=["mul_nonneg ht0 (sub_nonneg.mpr hT)","mul_nonneg (mul_nonneg ht0 ht0) (sub_nonneg.mpr hT)","mul_nonneg ht0 ht0"]
    if r is not None:
        hints+= [f"sq_nonneg (t - {L(r)})", f"mul_nonneg ht0 (sq_nonneg (t - {L(r)}))", f"mul_nonneg (sub_nonneg.mpr hT) (sq_nonneg (t - {L(r)}))"]
    return f'''
set_option maxHeartbeats 800000 in
theorem piece{k} (A s q t : ℝ) (hq1 : {L(qlo)} ≤ q) (hq2 : q ≤ {L(qhi)}) (hs : s ^ 2 = 1 - A ^ 2) (hs0 : 0 ≤ s)
    (hA1 : {L(A1)} ≤ A) (hA2 : A ≤ {L(A2)}) (ht0 : 0 ≤ t) (ht1 : t ≤ 2 * q / 3 * A) :
    Fres A s q t ≤ {L(clo)} := by
  unfold Fres
  have hs1 : s ≤ {L(shi)} := by nlinarith
  have hs2 : {L(slo)} ≤ s := by nlinarith
  have hT : t ≤ {L(T)} := by nlinarith
  have hal : 3 * q / 4 * (2 - 3 * A ^ 2) ≤ {L(al)} := by nlinarith
  have hbe : 3 / 4 * q * s - 3 * A ≤ {L(be)} := by nlinarith
  have hga : 1 - 9 * q / 4 ≤ {L(ga)} := by linarith
  have hpsi : 3 * q / 4 * (2 - 3 * A ^ 2) * t + (3 / 4 * q * s - 3 * A) * t ^ 2 + (1 - 9 * q / 4) * t ^ 3
      ≤ {L(al)} * t + {L(be)} * t ^ 2 + {L(ga)} * t ^ 3 := by
    have h1 := mul_le_mul_of_nonneg_right hal ht0
    have h2 := mul_le_mul_of_nonneg_right hbe (sq_nonneg t)
    have h3 := mul_le_mul_of_nonneg_right hga (pow_nonneg ht0 3)
    linarith
  have hcub : {L(al)} * t + {L(be)} * t ^ 2 + {L(ga)} * t ^ 3 ≤ {L(M)} := by
    nlinarith [{", ".join(hints)}]
  have hA0 : 0 ≤ A := le_trans (by norm_num) hA1
  have hA3 : A ^ 3 ≤ {L(A23)} := by
    have := pow_le_pow_left₀ hA0 hA2 3
    linarith [show ({L(A2)}) ^ 3 ≤ {L(A23)} by norm_num]
  have hsq : {L(qs3)} ≤ s ^ 3 * q / 2 := by
    have h3 : ({L(slo)}) ^ 3 ≤ s ^ 3 := pow_le_pow_left₀ (by norm_num) hs2 3
    have h4 := mul_le_mul h3 hq1 (by norm_num) (pow_nonneg hs0 3)
    linarith [show {L(qs3)} ≤ ({L(slo)}) ^ 3 * {L(qlo)} / 2 by norm_num]
  have hh : 3 * A * s ^ 2 ≤ {L(hm)} := by
    rw [hs]
    nlinarith [mul_nonneg (sub_nonneg.mpr hA1) (sub_nonneg.mpr hA2), sq_nonneg (A - {L(top)}),
      mul_nonneg (mul_nonneg (sub_nonneg.mpr hA1) (sub_nonneg.mpr hA2)) hA0]
  have hsum : {L(A23)} - {L(qs3)} + {L(hm)} + {L(M)} ≤ {L(clo)} := by norm_num
  linarith
'''

if __name__ == '__main__':
    n = 32
    pts = partition(n, Fr(6733, 10000))
    for k in range(n):
        print(lean_piece(k, pts[k], pts[k + 1]))
