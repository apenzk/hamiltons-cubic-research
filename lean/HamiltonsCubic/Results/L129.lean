import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Positivity
import Mathlib.Algebra.Order.BigOperators.Group.Finset
import Mathlib.Algebra.BigOperators.Ring.Finset

/-!
# L129, the spectral gap is half-open

[diagonal-half.md](../../../findings/diagonal-half.md)'s Lemma L129: at every pure critical
point `spec(K) ∩ (0, λ] = ∅`. Hypotheses are hollowness, symmetry, `K1 = 0`, off-diagonal
criticality and `λ > 0`, no maximality, no normalisation, no connectivity.

**The proof here is shorter than the record's, and drops a hypothesis-shaped step.** The
record argues through `ker L(w)`, identifying it with the span of the indicators of the
connected components of `{w_ab > 0}` and then checking `K` annihilates each. That
identification is a theorem about graphs. What the argument actually needs is only that
`⟨L(w)x, x⟩ = 0` forces `x_a = x_b` **whenever `K_ab ≠ 0`**, a termwise consequence of the
sum of non-negative terms vanishing, after which `(Kx)_a = Σ_b K_ab x_b = x_a Σ_b K_ab = 0`
termwise, since every `b` contributing has `x_b = x_a`. No components are named.
-/

namespace HamiltonsCubic.HalfOpen

open Finset

variable {ι : Type*} [Fintype ι] [DecidableEq ι] {K : ι → ι → ℝ} {lam mu : ℝ} {x : ι → ℝ}

/-- The Laplacian weights `w_ab = K_ab²`, non-negative by construction. -/
def wt (K : ι → ι → ℝ) (a b : ι) : ℝ := K a b ^ 2

theorem wt_nonneg (K : ι → ι → ℝ) (a b : ι) : 0 ≤ wt K a b := sq_nonneg _

theorem wt_symm (hs : ∀ a b, K a b = K b a) (a b : ι) : wt K a b = wt K b a := by
  unfold wt; rw [hs]

/-- **The Laplacian rows.** For an eigenvector at `λ`, every row of `K² - λK` applied to `x`
vanishes, and that row is exactly `Σ_b w_ab (x_a - x_b)`.

The two faces of `K² - λK = L(w)` enter here: off the diagonal criticality gives `-w_ab`, and
on the diagonal hollowness gives `Σ_b w_ab`. -/
theorem laplacian_row (hh : ∀ a, K a a = 0) (hs : ∀ a b, K a b = K b a)
    (hcrit : ∀ a b, a ≠ b → (∑ c, K a c * K c b) + K a b ^ 2 = lam * K a b)
    (heig : ∀ a, ∑ b, K a b * x b = mu * x a) (a : ι) :
    ∑ b, wt K a b * (x a - x b) = (mu * mu - lam * mu) * x a := by
  classical
  -- `(K²x)_a = λ²x_a`, by reassociating the double sum through the eigen equation.
  have hK2 : ∑ b, (∑ c, K a c * K c b) * x b = mu * (mu * x a) := by
    have e1 : ∑ b, (∑ c, K a c * K c b) * x b = ∑ b, ∑ c, K a c * K c b * x b :=
      Finset.sum_congr rfl fun b _ => by rw [Finset.sum_mul]
    have e2 : ∀ c : ι, ∑ b, K a c * K c b * x b = K a c * ∑ b, K c b * x b := by
      intro c; rw [Finset.mul_sum]; exact Finset.sum_congr rfl fun b _ => by ring
    rw [e1, Finset.sum_comm, Finset.sum_congr rfl (fun c _ => e2 c)]
    rw [Finset.sum_congr rfl (fun c _ => by rw [heig c] : ∀ c ∈ univ,
      K a c * (∑ b, K c b * x b) = K a c * (mu * x c))]
    rw [Finset.sum_congr rfl (fun c _ => by ring : ∀ c ∈ univ,
      K a c * (mu * x c) = mu * (K a c * x c)), ← Finset.mul_sum, heig a]
  -- Row `a` of `K² - λK`, expanded against `x` using the two faces.
  have hrow : ∑ b, ((∑ c, K a c * K c b) - lam * K a b) * x b
      = (mu * mu - lam * mu) * x a := by
    have hlin : ∑ b, ((∑ c, K a c * K c b) - lam * K a b) * x b
        = (∑ b, (∑ c, K a c * K c b) * x b) - lam * ∑ b, K a b * x b := by
      rw [Finset.mul_sum, ← Finset.sum_sub_distrib]
      exact Finset.sum_congr rfl fun b _ => by ring
    rw [hlin, hK2, heig a]; ring
  -- The same row, rewritten as the Laplacian row: the difference sums to zero, the
  -- diagonal term supplying `Σ_c w_ac · x_a` and every other term `-w_ab · x_a`.
  have hdiag : ((∑ c, K a c * K c a) - lam * K a a) * x a - wt K a a * (x a - x a)
      = (∑ c, wt K a c) * x a := by
    have hsq : ∑ c, K a c * K c a = ∑ c, wt K a c := by
      refine Finset.sum_congr rfl fun c _ => ?_
      unfold wt; rw [hs c a]; ring
    rw [hsq, hh a]; ring
  have hoff : ∀ b ∈ univ.erase a,
      ((∑ c, K a c * K c b) - lam * K a b) * x b - wt K a b * (x a - x b)
        = -(wt K a b * x a) := by
    intro b hb
    have hba : a ≠ b := fun h => (Finset.ne_of_mem_erase hb) h.symm
    have hs2 := hcrit a b hba
    have hsub : (∑ c, K a c * K c b) - lam * K a b = -(wt K a b) := by
      unfold wt; linarith [hs2]
    rw [hsub]; ring
  have hwaa : wt K a a = 0 := by unfold wt; rw [hh a]; ring
  have hery : ∑ b ∈ univ.erase a, wt K a b = ∑ b, wt K a b := by
    rw [← Finset.add_sum_erase univ (fun b => wt K a b) (Finset.mem_univ a), hwaa, zero_add]
  have herase : ∑ b ∈ univ.erase a,
      (((∑ c, K a c * K c b) - lam * K a b) * x b - wt K a b * (x a - x b))
      = -((∑ b, wt K a b) * x a) := by
    rw [Finset.sum_congr rfl hoff, ← hery, Finset.sum_mul, ← Finset.sum_neg_distrib]
  have hdsum : ∑ b, (((∑ c, K a c * K c b) - lam * K a b) * x b - wt K a b * (x a - x b))
      = 0 := by
    rw [← Finset.add_sum_erase univ
      (fun b => ((∑ c, K a c * K c b) - lam * K a b) * x b - wt K a b * (x a - x b))
      (Finset.mem_univ a)]
    rw [hdiag, herase]; ring_nf
  have hdiff : ∑ b, (((∑ c, K a c * K c b) - lam * K a b) * x b)
      - ∑ b, wt K a b * (x a - x b) = 0 := by
    rw [← Finset.sum_sub_distrib]; exact hdsum
  linarith [hrow, hdiff]

/-- **The Dirichlet identity at an eigenvector**: `Σ_{a,b} w_ab (x_a - x_b)²` equals
`2μ(μ-λ)‖x‖²`. The left side is a sum of non-negative terms, which is the whole content. -/
theorem quad_identity (hh : ∀ a, K a a = 0) (hs : ∀ a b, K a b = K b a)
    (hcrit : ∀ a b, a ≠ b → (∑ c, K a c * K c b) + K a b ^ 2 = lam * K a b)
    (heig : ∀ a, ∑ b, K a b * x b = mu * x a) :
    ∑ a, ∑ b, wt K a b * (x a - x b) ^ 2
      = 2 * ((mu * mu - lam * mu) * ∑ a, (x a) ^ 2) := by
  classical
  have hone : ∑ a, x a * ∑ b, wt K a b * (x a - x b)
      = (mu * mu - lam * mu) * ∑ a, (x a) ^ 2 := by
    rw [Finset.mul_sum]
    exact Finset.sum_congr rfl fun a _ => by
      rw [laplacian_row hh hs hcrit heig a]; ring
  have hswap : ∑ a, ∑ b, wt K a b * x b * (x b - x a)
      = ∑ a, ∑ b, wt K a b * x a * (x a - x b) := by
    rw [Finset.sum_comm]
    exact Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ => by
      rw [wt_symm hs b a]
  have hexp : ∀ a, x a * ∑ b, wt K a b * (x a - x b)
      = ∑ b, wt K a b * x a * (x a - x b) := by
    intro a; rw [Finset.mul_sum]; exact Finset.sum_congr rfl fun b _ => by ring
  have hL : ∑ a, ∑ b, wt K a b * x a * (x a - x b)
      = (mu * mu - lam * mu) * ∑ a, (x a) ^ 2 := by
    rw [← hone]; exact (Finset.sum_congr rfl fun a _ => (hexp a)).symm
  have hR : ∑ a, ∑ b, wt K a b * x b * (x b - x a)
      = (mu * mu - lam * mu) * ∑ a, (x a) ^ 2 := by rw [hswap]; exact hL
  have hsum : ∑ a, ∑ b, wt K a b * (x a - x b) ^ 2
      = (∑ a, ∑ b, wt K a b * x a * (x a - x b))
        + ∑ a, ∑ b, wt K a b * x b * (x b - x a) := by
    rw [← Finset.sum_add_distrib]
    refine Finset.sum_congr rfl fun a _ => ?_
    rw [← Finset.sum_add_distrib]
    exact Finset.sum_congr rfl fun b _ => by ring
  rw [hsum, hL, hR]; ring

/-- The Dirichlet sum is non-negative, being a sum of squares against non-negative weights. -/
theorem quad_nonneg (K : ι → ι → ℝ) (x : ι → ℝ) :
    0 ≤ ∑ a, ∑ b, wt K a b * (x a - x b) ^ 2 :=
  Finset.sum_nonneg fun a _ => Finset.sum_nonneg fun b _ =>
    mul_nonneg (wt_nonneg K a b) (sq_nonneg _)

/-- **The interior of the gap.** At `0 < μ < λ` the identity's right side is strictly
negative unless `x = 0`, so no eigenvalue lies there, and this needs no edge argument at
all. The record leaves the interior to [L97](../../../findings/diagonal-half.md)'s
`K² - λK ⪰ 0`; here it falls out of the same identity as the boundary. -/
theorem interior_empty (hh : ∀ a, K a a = 0) (hs : ∀ a b, K a b = K b a)
    (hcrit : ∀ a b, a ≠ b → (∑ c, K a c * K c b) + K a b ^ 2 = lam * K a b)
    (heig : ∀ a, ∑ b, K a b * x b = mu * x a) (hmu : 0 < mu) (hlt : mu < lam) : x = 0 := by
  classical
  have hid := quad_identity hh hs hcrit heig
  have hnn := quad_nonneg K x
  have hS : (0:ℝ) ≤ ∑ a, (x a) ^ 2 := Finset.sum_nonneg fun a _ => sq_nonneg _
  have hcoef : mu * mu - lam * mu < 0 := by nlinarith [hmu, hlt]
  have hSzero : ∑ a, (x a) ^ 2 = 0 := by nlinarith [hid, hnn, hS, hcoef]
  funext a
  have := (Finset.sum_eq_zero_iff_of_nonneg (fun a' _ => sq_nonneg (x a'))).1 hSzero a
    (mem_univ a)
  have : x a = 0 := pow_eq_zero_iff (n := 2) (by norm_num) |>.1 this
  simpa using this

/-- **Every edge of `K` forces its endpoints to agree**, at the boundary `μ = λ`. The record
reaches this through the connected components of `{w > 0}`; it is a termwise consequence of
the Dirichlet identity, whose right side vanishes at `μ = λ`. -/
theorem eq_on_edges (hh : ∀ a, K a a = 0) (hs : ∀ a b, K a b = K b a)
    (hcrit : ∀ a b, a ≠ b → (∑ c, K a c * K c b) + K a b ^ 2 = lam * K a b)
    (heig : ∀ a, ∑ b, K a b * x b = lam * x a) {a b : ι} (hK : K a b ≠ 0) :
    x a = x b := by
  classical
  have hid := quad_identity (mu := lam) hh hs hcrit heig
  have hz : ∑ a', ∑ b', wt K a' b' * (x a' - x b') ^ 2 = 0 := by rw [hid]; ring
  have hinner : ∀ a' : ι, (0:ℝ) ≤ ∑ b', wt K a' b' * (x a' - x b') ^ 2 :=
    fun a' => Finset.sum_nonneg fun b' _ => mul_nonneg (wt_nonneg K a' b') (sq_nonneg _)
  have ha := (Finset.sum_eq_zero_iff_of_nonneg (fun a' _ => hinner a')).1 hz a (mem_univ a)
  have hab := (Finset.sum_eq_zero_iff_of_nonneg
    (fun b' _ => mul_nonneg (wt_nonneg K a b') (sq_nonneg _) :
      ∀ b' ∈ univ, (0:ℝ) ≤ wt K a b' * (x a - x b') ^ 2)).1 ha b (mem_univ b)
  have hw : wt K a b ≠ 0 := by unfold wt; exact pow_ne_zero 2 hK
  have hsq : (x a - x b) ^ 2 = 0 := by
    rcases mul_eq_zero.1 hab with h | h
    · exact absurd h hw
    · exact h
  have := pow_eq_zero_iff (n := 2) (by norm_num) |>.1 hsq
  linarith

/-- **The boundary.** `λ` itself is not an eigenvalue: every edge forces its endpoints to
agree, so `(Kx)_a = x_a Σ_b K_ab = 0` termwise by `K1 = 0`, and then `λx = 0`. -/
theorem boundary_empty (hh : ∀ a, K a a = 0) (hs : ∀ a b, K a b = K b a)
    (hr : ∀ a, ∑ b, K a b = 0)
    (hcrit : ∀ a b, a ≠ b → (∑ c, K a c * K c b) + K a b ^ 2 = lam * K a b)
    (hlam : 0 < lam) (heig : ∀ a, ∑ b, K a b * x b = lam * x a) : x = 0 := by
  classical
  have hKx : ∀ a, ∑ b, K a b * x b = 0 := by
    intro a
    have hrep : ∀ b ∈ univ, K a b * x b = K a b * x a := by
      intro b _
      by_cases hK : K a b = 0
      · rw [hK]; ring
      · rw [eq_on_edges hh hs hcrit heig hK]
    rw [Finset.sum_congr rfl hrep, ← Finset.sum_mul, hr a]; ring
  funext a
  have hh2 := heig a
  rw [hKx a] at hh2
  have hxa : x a = 0 := by
    rcases mul_eq_zero.1 hh2.symm with h | h
    · linarith
    · exact h
  simpa using hxa

/-- **L129.** `spec(K) ∩ (0, λ] = ∅`. The block's printed proof handles the endpoint `μ = λ`
alone; the half-open interval is assembled here from the two cases, both out of the one
Dirichlet identity. -/
theorem spec_gap_half_open (hh : ∀ a, K a a = 0) (hs : ∀ a b, K a b = K b a)
    (hr : ∀ a, ∑ b, K a b = 0)
    (hcrit : ∀ a b, a ≠ b → (∑ c, K a c * K c b) + K a b ^ 2 = lam * K a b)
    (hmu : 0 < mu) (hle : mu ≤ lam) (heig : ∀ a, ∑ b, K a b * x b = mu * x a) : x = 0 := by
  rcases lt_or_eq_of_le hle with hlt | heq
  · exact interior_empty hh hs hcrit heig hmu hlt
  · subst heq
    exact boundary_empty hh hs hr hcrit hmu heig

end HamiltonsCubic.HalfOpen
