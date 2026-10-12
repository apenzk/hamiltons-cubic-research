import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith
import Mathlib.Algebra.Order.BigOperators.Group.Finset
import Mathlib.Algebra.BigOperators.Ring.Finset

/-!
# L97, the vertex Laplacian is PSD, and PSD gives the OPEN interval

[diagonal-half.md](../../../findings/diagonal-half.md)'s Lemma L97: at a diagonal critical
point `K² - λK = L(K_ab²)` entrywise, so `vᵀ(K² - λK)v = ½ Σ_{a,b} K_ab²(v_a - v_b)² ≥ 0`
for an **arbitrary** `v`.

**The hypotheses are exactly three**, and the block is right to insist on the list:
hollowness, symmetry and the off-diagonal criticality equation. **Ricci-flatness, maximality
and `λ > 0` are not used**, the statement holds at every diagonal critical point, saddles
included. Each is absent from every signature below.

**The `½` is the double-count price** under the ordered-pair convention, which the block
notes is unstated where the factor appears. Here the sums run over ordered pairs throughout,
so the factor is forced rather than chosen.

**PSD is equivalent to the OPEN interval `(0, λ)` being empty.** The record corrects an
earlier "equivalently" that read the interval as closed: the endpoint `κ = λ` gives
`κ² - λκ = 0`, which PSD permits. That is proved in both directions below, the exclusion of
the interior, and the endpoint's compatibility. Closing the endpoint is
[L129](L129.lean)'s work and consumes `K1 = 0` and `λ > 0`, which L97 never sees.
-/

namespace HamiltonsCubic.VertexLaplacian

open Finset

variable {ι : Type*} [Fintype ι] [DecidableEq ι] {K : ι → ι → ℝ} {lam : ℝ}

/-- The Laplacian weights `w_ab = K_ab²`. -/
def wt (K : ι → ι → ℝ) (a b : ι) : ℝ := K a b ^ 2

theorem wt_nonneg (K : ι → ι → ℝ) (a b : ι) : 0 ≤ wt K a b := sq_nonneg _

theorem wt_symm (hs : ∀ a b, K a b = K b a) (a b : ι) : wt K a b = wt K b a := by
  unfold wt; rw [hs]

/-- The entry of `K² - λK`. -/
def Q (K : ι → ι → ℝ) (lam : ℝ) (a b : ι) : ℝ := (∑ c, K a c * K c b) - lam * K a b

/-! ## The entrywise identity `K² - λK = L(w)`, both faces -/

/-- **Off the diagonal**: criticality gives `-w_ab` directly. -/
theorem Q_offdiag (hcrit : ∀ a b, a ≠ b → (∑ c, K a c * K c b) + K a b ^ 2 = lam * K a b)
    {a b : ι} (hab : a ≠ b) : Q K lam a b = -(wt K a b) := by
  unfold Q wt; linarith [hcrit a b hab]

/-- **On the diagonal**: hollowness makes `D` simultaneously `diag(K²)` and the degree
matrix, so the `a = b` row is a tautology, which the block names as `D`'s whole role. -/
theorem Q_diag (hh : ∀ a, K a a = 0) (hs : ∀ a b, K a b = K b a) (a : ι) :
    Q K lam a a = ∑ c, wt K a c := by
  unfold Q wt
  rw [hh a, mul_zero, sub_zero]
  exact Finset.sum_congr rfl fun c _ => by rw [hs c a]; ring

/-- `w` is hollow too. -/
theorem wt_diag (hh : ∀ a, K a a = 0) (a : ι) : wt K a a = 0 := by
  unfold wt; rw [hh a]; ring

/-! ## The quadratic form against an arbitrary vector -/

/-- One row of the pairing, against an arbitrary `v`. -/
theorem row_pairing (hh : ∀ a, K a a = 0) (hs : ∀ a b, K a b = K b a)
    (hcrit : ∀ a b, a ≠ b → (∑ c, K a c * K c b) + K a b ^ 2 = lam * K a b)
    (v : ι → ℝ) (a : ι) :
    ∑ b, Q K lam a b * (v a * v b) = ∑ b, wt K a b * (v a ^ 2 - v a * v b) := by
  classical
  have hwaa := wt_diag hh a
  have hery : ∑ b ∈ univ.erase a, wt K a b = ∑ b, wt K a b := by
    rw [← Finset.add_sum_erase univ (fun b => wt K a b) (Finset.mem_univ a), hwaa, zero_add]
  have hoff : ∀ b ∈ univ.erase a,
      Q K lam a b * (v a * v b) - wt K a b * (v a ^ 2 - v a * v b)
        = -(wt K a b * v a ^ 2) := by
    intro b hb
    have hab : a ≠ b := fun h => (Finset.ne_of_mem_erase hb) h.symm
    rw [Q_offdiag hcrit hab]; ring
  have hdiag : Q K lam a a * (v a * v a) - wt K a a * (v a ^ 2 - v a * v a)
      = (∑ c, wt K a c) * v a ^ 2 := by
    rw [Q_diag hh hs a, hwaa]; ring
  have herase : ∑ b ∈ univ.erase a,
      (Q K lam a b * (v a * v b) - wt K a b * (v a ^ 2 - v a * v b))
      = -((∑ b, wt K a b) * v a ^ 2) := by
    rw [Finset.sum_congr rfl hoff, ← hery, Finset.sum_mul, ← Finset.sum_neg_distrib]
  have hzero : ∑ b, (Q K lam a b * (v a * v b) - wt K a b * (v a ^ 2 - v a * v b)) = 0 := by
    rw [← Finset.add_sum_erase univ
      (fun b => Q K lam a b * (v a * v b) - wt K a b * (v a ^ 2 - v a * v b))
      (Finset.mem_univ a)]
    rw [hdiag, herase]; ring_nf
  have := Finset.sum_sub_distrib (s := (univ : Finset ι))
    (f := fun b => Q K lam a b * (v a * v b))
    (g := fun b => wt K a b * (v a ^ 2 - v a * v b))
  linarith [hzero, this]

/-- **The identity, with the `½` forced by the ordered-pair convention.**
`vᵀ(K² - λK)v = ½ Σ_{a,b} w_ab (v_a - v_b)²`, for an arbitrary `v`. -/
theorem quad_identity (hh : ∀ a, K a a = 0) (hs : ∀ a b, K a b = K b a)
    (hcrit : ∀ a b, a ≠ b → (∑ c, K a c * K c b) + K a b ^ 2 = lam * K a b) (v : ι → ℝ) :
    2 * ∑ a, ∑ b, Q K lam a b * (v a * v b)
      = ∑ a, ∑ b, wt K a b * (v a - v b) ^ 2 := by
  classical
  have hrow : ∑ a, ∑ b, Q K lam a b * (v a * v b)
      = ∑ a, ∑ b, wt K a b * (v a ^ 2 - v a * v b) :=
    Finset.sum_congr rfl fun a _ => row_pairing hh hs hcrit v a
  have hswap : ∑ a, ∑ b, wt K a b * (v b ^ 2 - v b * v a)
      = ∑ a, ∑ b, wt K a b * (v a ^ 2 - v a * v b) := by
    rw [Finset.sum_comm]
    exact Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ => by
      rw [wt_symm hs b a]
  have hsum : ∑ a, ∑ b, wt K a b * (v a - v b) ^ 2
      = (∑ a, ∑ b, wt K a b * (v a ^ 2 - v a * v b))
        + ∑ a, ∑ b, wt K a b * (v b ^ 2 - v b * v a) := by
    rw [← Finset.sum_add_distrib]
    refine Finset.sum_congr rfl fun a _ => ?_
    rw [← Finset.sum_add_distrib]
    exact Finset.sum_congr rfl fun b _ => by ring
  rw [hsum, hswap, hrow]; ring

/-- **`K² - λK ⪰ 0`**, the matrix statement, at every diagonal critical point. -/
theorem psd (hh : ∀ a, K a a = 0) (hs : ∀ a b, K a b = K b a)
    (hcrit : ∀ a b, a ≠ b → (∑ c, K a c * K c b) + K a b ^ 2 = lam * K a b) (v : ι → ℝ) :
    0 ≤ ∑ a, ∑ b, Q K lam a b * (v a * v b) := by
  have hid := quad_identity hh hs hcrit v
  have hnn : 0 ≤ ∑ a, ∑ b, wt K a b * (v a - v b) ^ 2 :=
    Finset.sum_nonneg fun a _ => Finset.sum_nonneg fun b _ =>
      mul_nonneg (wt_nonneg K a b) (sq_nonneg _)
  linarith [hid, hnn]

/-! ## PSD gives the OPEN interval, and permits the endpoint -/

/-- At an eigenvector the form is `(κ² - λκ)‖v‖²`. -/
theorem quad_at_eigen (hh : ∀ a, K a a = 0) {κ : ℝ} {v : ι → ℝ}
    (heig : ∀ a, ∑ b, K a b * v b = κ * v a) :
    ∑ a, ∑ b, Q K lam a b * (v a * v b) = (κ * κ - lam * κ) * ∑ a, (v a) ^ 2 := by
  classical
  have hrow : ∀ a, ∑ b, Q K lam a b * (v a * v b)
      = (κ * κ - lam * κ) * (v a) ^ 2 := by
    intro a
    have hlin : ∑ b, Q K lam a b * v b
        = (∑ b, (∑ c, K a c * K c b) * v b) - lam * ∑ b, K a b * v b := by
      unfold Q
      rw [Finset.mul_sum, ← Finset.sum_sub_distrib]
      exact Finset.sum_congr rfl fun b _ => by ring
    have e2 : ∑ b, (∑ c, K a c * K c b) * v b = κ * (κ * v a) := by
      have s1 : ∑ b, (∑ c, K a c * K c b) * v b = ∑ b, ∑ c, K a c * K c b * v b :=
        Finset.sum_congr rfl fun b _ => by rw [Finset.sum_mul]
      have s2 : ∀ c : ι, ∑ b, K a c * K c b * v b = K a c * ∑ b, K c b * v b := by
        intro c; rw [Finset.mul_sum]; exact Finset.sum_congr rfl fun b _ => by ring
      rw [s1, Finset.sum_comm, Finset.sum_congr rfl (fun c _ => s2 c)]
      rw [Finset.sum_congr rfl (fun c _ => by rw [heig c] : ∀ c ∈ univ,
        K a c * (∑ b, K c b * v b) = K a c * (κ * v c))]
      rw [Finset.sum_congr rfl (fun c _ => by ring : ∀ c ∈ univ,
        K a c * (κ * v c) = κ * (K a c * v c)), ← Finset.mul_sum, heig a]
    have key : ∑ b, Q K lam a b * v b = (κ * κ - lam * κ) * v a := by
      rw [hlin, e2, heig a]; ring
    have hpull : ∑ b, Q K lam a b * (v a * v b) = v a * ∑ b, Q K lam a b * v b := by
      rw [Finset.mul_sum]; exact Finset.sum_congr rfl fun b _ => by ring
    rw [hpull, key]; ring
  rw [Finset.sum_congr rfl (fun a _ => hrow a), ← Finset.mul_sum]

/-- **The open interval is empty.** PSD forces `κ ≤ 0` or `κ ≥ λ` at every eigenvalue with a
nonzero eigenvector, so nothing lies strictly between. -/
theorem open_interval_empty (hh : ∀ a, K a a = 0) (hs : ∀ a b, K a b = K b a)
    (hcrit : ∀ a b, a ≠ b → (∑ c, K a c * K c b) + K a b ^ 2 = lam * K a b)
    {κ : ℝ} {v : ι → ℝ} (heig : ∀ a, ∑ b, K a b * v b = κ * v a)
    (hv : ∃ a, v a ≠ 0) (hpos : 0 < κ) (hlt : κ < lam) : False := by
  classical
  obtain ⟨a₀, ha₀⟩ := hv
  have hS : 0 < ∑ a, (v a) ^ 2 := by
    refine Finset.sum_pos' (fun a _ => sq_nonneg _) ⟨a₀, mem_univ a₀, ?_⟩
    positivity
  have hq := quad_at_eigen (lam := lam) hh heig
  have hp := psd hh hs hcrit v
  rw [hq] at hp
  have hneg : κ * κ - lam * κ < 0 := by nlinarith [hpos, hlt]
  nlinarith [hp, hS, hneg]

/-- **And PSD permits the endpoint.** At `κ = λ` the form vanishes identically, so no
contradiction arises and PSD alone cannot close the interval. This is the record's correction
of *"equivalently"*: closing it is [L129](L129.lean)'s work, which additionally consumes
`K1 = 0` and `λ > 0`. -/
theorem endpoint_permitted (hh : ∀ a, K a a = 0) {v : ι → ℝ}
    (heig : ∀ a, ∑ b, K a b * v b = lam * v a) :
    ∑ a, ∑ b, Q K lam a b * (v a * v b) = 0 := by
  rw [quad_at_eigen (lam := lam) (κ := lam) hh heig]; ring

end HamiltonsCubic.VertexLaplacian
