from fractions import Fraction as Q
from math import isqrt, floor, ceil

D = 10**8          # grid for the square-root bounds, matching the file's existing surd lemmas
Dd = 10**9         # grid the derived (divided/multiplied) bounds are rounded out to

def sq_lo(x, D):
    m = isqrt((x.numerator * D * D) // x.denominator); assert Q(m,D)**2 <= x; return Q(m,D)
def sq_hi(x, D):
    n = -((-x.numerator * D * D) // x.denominator); m = isqrt(n)
    if m*m < n: m += 1
    assert Q(m,D)**2 >= x; return Q(m,D)
def rlo(x, D=Dd): return Q(floor(x*D), D)
def rhi(x, D=Dd): return Q(ceil(x*D), D)
def lit(q): return f"{q.numerator}/{q.denominator}" if q.denominator != 1 else f"{q.numerator}"

# base surds -- these are the file's EXISTING eight-digit lemmas, reproduced here so the
# chain below is computed from the same numerals the Lean proof cites.
S2  = (Q(35355339,25000000),  Q(141421357,100000000))
S32 = (Q(122474487,100000000), Q(15309311,12500000))
S6  = (Q(122474487,50000000),  Q(9797959,4000000))
T   = (Q(30900827,25000000),   Q(123603309,100000000))
for nm,(a,b),x in [("sqrt2",S2,Q(2)),("sqrt3/2",S32,Q(3,2)),("sqrt6",S6,Q(6)),("theta0_12",T,Q(55,36))]:
    assert a**2 <= x <= b**2, nm

G = (rlo(9*(T[0]-S32[1])), rhi(9*(T[1]-S32[0])))
R = (sq_lo(G[0],D), sq_hi(G[1],D))
LAM = (rlo(Q(2)/R[1]), rhi(Q(2)/R[0]))
BETA = (rlo(LAM[0]*Q(11,84)), rhi(LAM[1]*Q(11,84)))
X = (rlo(Q(3,10)*T[0] + (S6[0]-Q(7,5)*T[1])*Q(4,9)), rhi(Q(3,10)*T[1] + (S6[1]-Q(7,5)*T[0])*Q(4,9)))
S0 = (sq_lo(X[0],D), sq_hi(X[1],D))
Y = (rlo(4*BETA[0]*S0[0]+1), rhi(4*BETA[1]*S0[1]+1))
V = (sq_lo(Y[0],D), sq_hi(Y[1],D))
F = (rlo(4*S0[0]/(V[1]+1)**2), rhi(4*S0[1]/(V[0]+1)**2))
W = (rlo(9*(S2[0]-S32[1])), rhi(9*(S2[1]-S32[0])))
U = (sq_lo(W[0],D), sq_hi(W[1],D))
LI = (rlo(Q(2)/U[1]), rhi(Q(2)/U[0]))
P = LI[0]*F[0]
assert P > Q(5923,10000), "chain does not close"

for nm,iv in [("G",G),("R",R),("lam",LAM),("beta",BETA),("X",X),("s0",S0),("Y",Y),("V",V),("F",F),("W",W),("U",U),("lamInf",LI)]:
    print(f"{nm:8s} [{float(iv[0]):.12f}, {float(iv[1]):.12f}]   lo={lit(iv[0])}  hi={lit(iv[1])}")
print(f"\nlamInf_lo * F_lo = {float(P):.12f}, margin over 5923/10000 = {float(P-Q(5923,10000)):.3e}")

out = open("l182_floor.lean","w")
w = out.write
w(f"""
/-! ## The floor, carried through five nested square roots

**THE CHAIN IS INTERVAL ARITHMETIC DONE BY HAND, AND EVERY NUMERAL BELOW IS EMITTED FROM
[l182_emit.py](../../../scripts/misc/l182_emit.py) RATHER THAN TYPED.** *The margin is
`{float(P-Q(5923,10000)):.2e}`, so a bound rounded the wrong way loses the theorem rather than weakening it.*

The quantities, in dependency order: `G = 9(θ₀(12) - √(3/2))`, its root `R`, `λ(12) = 2/R`,
`β(12) = 11λ(12)/84`, the radicand `X` of `s₀(12)`, `s₀(12)`, the radicand `Y = 4βs₀ + 1` of `F`'s
own root, `V = √Y`, then `F(12) = 4s₀/(V+1)²`. `λ∞` needs only `W = 9(√2 - √(3/2))` and `U = √W`. -/

/-- **The one instrument the chain uses**: a rational interval for `x` gives one for `√x`. -/
theorem sqrt_bounds_of {{x a b : ℝ}} (ha : 0 ≤ a) (hb : 0 ≤ b) (h1 : a ^ 2 ≤ x) (h2 : x ≤ b ^ 2) :
    a ≤ Real.sqrt x ∧ Real.sqrt x ≤ b := by
  refine ⟨?_, ?_⟩
  · calc a = Real.sqrt (a ^ 2) := (Real.sqrt_sq ha).symm
      _ ≤ Real.sqrt x := Real.sqrt_le_sqrt h1
  · calc Real.sqrt x ≤ Real.sqrt (b ^ 2) := Real.sqrt_le_sqrt h2
      _ = b := Real.sqrt_sq hb

/-- `Cn(12) = 42/11`, so `β(12) = 11 λ(12) / 84` with no surd of its own. -/
theorem Cn_twelve : Cn 12 = 42 / 11 := by unfold Cn; norm_num

/-- `G = 9(θ₀(12) - √(3/2))`, the radicand under `λ(12)`. -/
theorem lam_radicand_twelve_bounds :
    ({lit(G[0])} : ℝ) ≤ 9 * (theta0 12 - Real.sqrt (3 / 2)) ∧
      9 * (theta0 12 - Real.sqrt (3 / 2)) ≤ {lit(G[1])} := by
  have h1 := lt_theta0_twelve
  have h2 := theta0_twelve_lt
  have h3 := lt_sqrt_three_halves
  have h4 := sqrt_three_halves_lt
  constructor <;> linarith

/-- `R = √G`. -/
theorem sqrt_lam_radicand_twelve_bounds :
    ({lit(R[0])} : ℝ) ≤ Real.sqrt (9 * (theta0 12 - Real.sqrt (3 / 2))) ∧
      Real.sqrt (9 * (theta0 12 - Real.sqrt (3 / 2))) ≤ {lit(R[1])} := by
  obtain ⟨h1, h2⟩ := lam_radicand_twelve_bounds
  exact sqrt_bounds_of (by norm_num) (by norm_num) (by nlinarith) (by nlinarith)

/-- `λ(12) = 2 / R`. -/
theorem lam_twelve_bounds : ({lit(LAM[0])} : ℝ) ≤ lam 12 ∧ lam 12 ≤ {lit(LAM[1])} := by
  obtain ⟨h1, h2⟩ := sqrt_lam_radicand_twelve_bounds
  have hpos : (0:ℝ) < Real.sqrt (9 * (theta0 12 - Real.sqrt (3 / 2))) := by linarith
  unfold lam
  constructor
  · rw [le_div_iff₀ hpos]; nlinarith
  · rw [div_le_iff₀ hpos]; nlinarith

/-- `β(12) = λ(12) / (2 Cn(12))`, which is `11 λ(12) / 84`. -/
theorem beta_twelve_bounds : ({lit(BETA[0])} : ℝ) ≤ beta 12 ∧ beta 12 ≤ {lit(BETA[1])} := by
  obtain ⟨h1, h2⟩ := lam_twelve_bounds
  unfold beta
  rw [Cn_twelve]
  constructor <;> [skip; skip] <;> rw [show (2 : ℝ) * (42 / 11) = 84 / 11 by norm_num] <;>
    rw [div_div_eq_mul_div] <;> [rw [le_div_iff₀ (by norm_num)]; rw [div_le_iff₀ (by norm_num)]] <;>
    linarith

/-- `X = cp(12) + ρ_eff(12) w₀(12)²`, the radicand under `s₀(12)`. -/
theorem s0_radicand_twelve_bounds :
    ({lit(X[0])} : ℝ) ≤ cp 12 + rhoEff 12 * w0 12 ^ 2 ∧
      cp 12 + rhoEff 12 * w0 12 ^ 2 ≤ {lit(X[1])} := by
  have h1 := lt_theta0_twelve
  have h2 := theta0_twelve_lt
  have h3 := lt_sqrt_six
  have h4 := sqrt_six_lt
  unfold cp rhoEff w0
  norm_num
  constructor <;> linarith

/-- `s₀(12) = √X`. -/
theorem s0_twelve_bounds : ({lit(S0[0])} : ℝ) ≤ s0 12 ∧ s0 12 ≤ {lit(S0[1])} := by
  obtain ⟨h1, h2⟩ := s0_radicand_twelve_bounds
  unfold s0
  exact sqrt_bounds_of (by norm_num) (by norm_num) (by nlinarith) (by nlinarith)

/-- `Y = 4 β(12) s₀(12) + 1`, the radicand inside `F(12)`. -/
theorem F_radicand_twelve_bounds :
    ({lit(Y[0])} : ℝ) ≤ 4 * beta 12 * s0 12 + 1 ∧ 4 * beta 12 * s0 12 + 1 ≤ {lit(Y[1])} := by
  obtain ⟨hb1, hb2⟩ := beta_twelve_bounds
  obtain ⟨hs1, hs2⟩ := s0_twelve_bounds
  constructor <;> nlinarith

/-- `V = √Y`. -/
theorem sqrt_F_radicand_twelve_bounds :
    ({lit(V[0])} : ℝ) ≤ Real.sqrt (4 * beta 12 * s0 12 + 1) ∧
      Real.sqrt (4 * beta 12 * s0 12 + 1) ≤ {lit(V[1])} := by
  obtain ⟨h1, h2⟩ := F_radicand_twelve_bounds
  exact sqrt_bounds_of (by norm_num) (by norm_num) (by nlinarith) (by nlinarith)

/-- **`F(12) > {float(F[0]):.9f}`**, the half of the product the record never bounded. -/
theorem F_twelve_gt : ({lit(F[0])} : ℝ) < F 12 := by
  obtain ⟨hv1, hv2⟩ := sqrt_F_radicand_twelve_bounds
  obtain ⟨hs1, hs2⟩ := s0_twelve_bounds
  unfold F
  rw [lt_div_iff₀ (by nlinarith)]
  nlinarith

/-- `W = 9(√2 - √(3/2))`, the radicand under `λ∞`. -/
theorem lamInf_radicand_bounds :
    ({lit(W[0])} : ℝ) ≤ 9 * (Real.sqrt 2 - Real.sqrt (3 / 2)) ∧
      9 * (Real.sqrt 2 - Real.sqrt (3 / 2)) ≤ {lit(W[1])} := by
  have h1 := lt_sqrt_two
  have h2 := sqrt_two_lt
  have h3 := lt_sqrt_three_halves
  have h4 := sqrt_three_halves_lt
  constructor <;> linarith

/-- `U = √W`. -/
theorem sqrt_lamInf_radicand_bounds :
    ({lit(U[0])} : ℝ) ≤ Real.sqrt (9 * (Real.sqrt 2 - Real.sqrt (3 / 2))) ∧
      Real.sqrt (9 * (Real.sqrt 2 - Real.sqrt (3 / 2))) ≤ {lit(U[1])} := by
  obtain ⟨h1, h2⟩ := lamInf_radicand_bounds
  exact sqrt_bounds_of (by norm_num) (by norm_num) (by nlinarith) (by nlinarith)

/-- **`λ∞ > {float(LI[0]):.9f}`.** *The record first wrote `1.53157`, which rounds the wrong way.* -/
theorem lamInf_gt : ({lit(LI[0])} : ℝ) < lamInf := by
  obtain ⟨h1, h2⟩ := sqrt_lamInf_radicand_bounds
  have hpos : (0:ℝ) < Real.sqrt (9 * (Real.sqrt 2 - Real.sqrt (3 / 2))) := by linarith
  unfold lamInf
  rw [lt_div_iff₀ hpos]
  nlinarith

/-- **`λ∞ F(12) > 5923/10000`**, the numeral the floor turns on, with `{float(P-Q(5923,10000)):.2e}` to spare. -/
theorem lamInf_mul_F_twelve_gt : (5923 : ℝ) / 10000 < lamInf * F 12 := by
  have h1 := lamInf_gt
  have h2 := F_twelve_gt
  nlinarith
""")
out.close()
print("\nwrote l182_floor.lean")
