import Mathlib
import HamiltonsCubic.Base.AltPart

set_option linter.style.longLine false

/-!
# The `Λ²` loss of the `E` route, `tr(W²#W²)`

[The working note](../../../reviews/2026-09-28d-I121-smallmass-direct.md) on I121, "The `Λ²` loss is
`tr(W²#W²)`, and its index-concentration bound fails on Weyl tensors".

**The source's statement.** At a unit critical point with `θ > 0`, weighting L198's rows by `λ_k²`
gives `θ p₃ = p₄ + ½S`, `S = ∑ c²_{kαγ} λ_k² λ_α λ_γ`; `p₄ ≤ 1/θ²`; `½S ≤ tr(W²#W²)`; hence
`θ² ≤ 3/(2θ²) + (3/2) tr(W²#W²) + θ C t_max`.

**What is typed.**
* `weighted_sign_drop`: for a nonnegative weight `c k a g`, symmetric in `a, g`, and `w ≥ 0`,
  `∑ c k a g w_k x_a x_g ≤ ∑_{k,a} w_k x_a² ∑_g c k a g`, the step `½S ≤ tr(W²#W²)` with `w = λ²`.
* `p4_le`: `∑ x⁴ ≤ m² ∑ x²` when every `|x_k| ≤ m`, the step `p₄ ≤ 1/θ²` at `m = 1/θ`.
* `theta_sq_le`: the scalar combination, for any bound `τ` on the `Λ²` term.
* `sigma4_eq`: for a four-index array antisymmetric in its first pair and symmetric under the
  pair swap, `∑ T_{ijkl} T_{jkli} = 2‖T‖² − 6‖Alt T‖²` in the record's norm `¼∑`, and
  `sigma4_comp`, the same at `comp R` for a linear symmetric `R`, which at `R = W²` is
  `Σ₄ = 2 tr W⁴ − 6‖Alt(W²)‖²`.

**Not typed**: L198's rows themselves (the statement row of [lean/INDEX.md](../../INDEX.md) is
partial), the identity `tr(G#G) = ‖N‖²_F/8 − Σ₄/2`, and `E ≤ C t_max`, which is `E_le_tmax_sharp` in
[SecondKindSharp.lean](SecondKindSharp.lean). The bound `tr(W²#W²) ≤ ‖N‖²_F/8` is false on Weyl
tensors from `n = 5`, so `τ = ‖N‖²_F/8` is available only where `Σ₄ ≥ 0`.
-/

namespace HamiltonsCubic.IndexConcentration

open Finset

variable {κ : Type*} [Fintype κ]

/-- **Dropping the signs of a symmetric nonnegative form.** -/
theorem weighted_sign_drop (c : κ → κ → κ → ℝ) (hc : ∀ k a g, 0 ≤ c k a g)
    (hsym : ∀ k a g, c k a g = c k g a) (w : κ → ℝ) (hw : ∀ k, 0 ≤ w k) (x : κ → ℝ) :
    (∑ k, ∑ a, ∑ g, c k a g * w k * x a * x g)
      ≤ ∑ k, ∑ a, w k * x a ^ 2 * ∑ g, c k a g := by
  refine Finset.sum_le_sum fun k _ => ?_
  have hsplit : (∑ a, ∑ g, c k a g * w k * x a * x g)
      ≤ ∑ a, ∑ g, c k a g * w k * ((x a ^ 2 + x g ^ 2) / 2) :=
    Finset.sum_le_sum fun a _ => Finset.sum_le_sum fun g _ => by
      have h1 : 0 ≤ c k a g * w k := mul_nonneg (hc k a g) (hw k)
      have h2 : x a * x g ≤ (x a ^ 2 + x g ^ 2) / 2 := by nlinarith [sq_nonneg (x a - x g)]
      calc c k a g * w k * x a * x g = c k a g * w k * (x a * x g) := by ring
        _ ≤ c k a g * w k * ((x a ^ 2 + x g ^ 2) / 2) := mul_le_mul_of_nonneg_left h2 h1
  have hswap : (∑ a, ∑ g, c k a g * w k * (x g ^ 2 / 2))
      = ∑ a, ∑ g, c k a g * w k * (x a ^ 2 / 2) := by
    rw [Finset.sum_comm]
    exact Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun g _ => by rw [hsym k g a]
  have e : (∑ a, ∑ g, c k a g * w k * ((x a ^ 2 + x g ^ 2) / 2))
      = ∑ a, w k * x a ^ 2 * ∑ g, c k a g := by
    have : (∑ a, ∑ g, c k a g * w k * ((x a ^ 2 + x g ^ 2) / 2))
        = (∑ a, ∑ g, c k a g * w k * (x a ^ 2 / 2)) + ∑ a, ∑ g, c k a g * w k * (x g ^ 2 / 2) := by
      rw [← Finset.sum_add_distrib]
      exact Finset.sum_congr rfl fun a _ => by
        rw [← Finset.sum_add_distrib]; exact Finset.sum_congr rfl fun g _ => by ring
    rw [this, hswap, ← two_mul]
    rw [Finset.mul_sum]
    refine Finset.sum_congr rfl fun a _ => ?_
    rw [Finset.mul_sum, Finset.mul_sum]
    exact Finset.sum_congr rfl fun g _ => by ring
  linarith

/-- **`p₄ ≤ m² p₂`** when every entry has `|x_k| ≤ m`. -/
theorem p4_le (x : κ → ℝ) (m : ℝ) (hm : ∀ k, |x k| ≤ m) :
    ∑ k, x k ^ 4 ≤ m ^ 2 * ∑ k, x k ^ 2 := by
  rw [Finset.mul_sum]
  refine Finset.sum_le_sum fun k _ => ?_
  have h := hm k
  have hsq : x k ^ 2 ≤ m ^ 2 := by
    have := sq_abs (x k); nlinarith [abs_nonneg (x k)]
  nlinarith [sq_nonneg (x k)]

/-- **The scalar combination.** With `θ = (3/2) p₃ + E`, `θ p₃ ≤ p₄ + D`, `p₄ ≤ 1/θ²`,
`D ≤ τ` and `E ≤ C t`, `θ² ≤ 3/(2θ²) + (3/2) τ + θ C t`. -/
theorem theta_sq_le (θ p3 p4 D E τ C t : ℝ) (hθ : 0 < θ) (hP : θ = 3 / 2 * p3 + E)
    (hrow : θ * p3 ≤ p4 + D) (hp4 : p4 ≤ 1 / θ ^ 2) (hD : D ≤ τ) (hE : E ≤ C * t) :
    θ ^ 2 ≤ 3 / (2 * θ ^ 2) + 3 / 2 * τ + θ * (C * t) := by
  have h1 : θ ^ 2 = 3 / 2 * (θ * p3) + θ * E := by rw [hP]; ring
  have h2 : θ * E ≤ θ * (C * t) := mul_le_mul_of_nonneg_left hE hθ.le
  have h3 : 3 / (2 * θ ^ 2) = 3 / 2 * (1 / θ ^ 2) := by field_simp
  calc θ ^ 2 = 3 / 2 * (θ * p3) + θ * E := h1
    _ ≤ 3 / 2 * (p4 + D) + θ * (C * t) := by nlinarith
    _ ≤ 3 / 2 * (1 / θ ^ 2 + τ) + θ * (C * t) := by nlinarith
    _ = 3 / (2 * θ ^ 2) + 3 / 2 * τ + θ * (C * t) := by rw [h3]; ring

/-- Non-vacuity: the hypotheses hold at `θ = 1`, `p₃ = 2/3`, `E = 0`, `p₄ = 2/3`, `D = 0`, `τ = 0`. -/
example : (1 : ℝ) ^ 2 ≤ 3 / (2 * 1 ^ 2) + 3 / 2 * 0 + 1 * (0 * 0) :=
  theta_sq_le 1 (2 / 3) (2 / 3) 0 0 0 0 0 one_pos (by norm_num) (by norm_num) (by norm_num)
    le_rfl (by norm_num)


section Sigma4

open HamiltonsCubic.AltLayer HamiltonsCubic.RealLayer

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **`Σ₄ = 2‖T‖² − 6‖Alt T‖²`.** The three cyclic terms of `alt4 T` have equal squares and equal
cross sums by relabelling, and `T_{jkli} = −T_{iljk}` makes `Σ₄` minus one cross sum. -/
theorem sigma4_eq (T : ι → ι → ι → ι → ℝ) (hL : ∀ i j k l, T j i k l = -T i j k l)
    (hP : ∀ i j k l, T k l i j = T i j k l) :
    (∑ i : ι, ∑ j : ι, ∑ k : ι, ∑ l : ι, T i j k l * T j k l i)
      = 2 * fourNormSq T - 6 * fourNormSq (alt4 T) := by
  have hS4 : (∑ i : ι, ∑ j : ι, ∑ k : ι, ∑ l : ι, T i j k l * T j k l i)
      = (-1) * ∑ i : ι, ∑ j : ι, ∑ k : ι, ∑ l : ι, T i l j k * T i j k l := by
    rw [← sum4_const_mul]
    refine sum4_congr fun i j k l => ?_
    rw [show T j k l i = T l i j k from hP l i j k, hL i l j k]
    ring
  have hCA : (∑ i : ι, ∑ j : ι, ∑ k : ι, ∑ l : ι, T i l j k * T i j k l)
      = ∑ i : ι, ∑ j : ι, ∑ k : ι, ∑ l : ι, T i j k l * T i k l j :=
    sum4_cycle (fun i j k l => T i l j k * T i j k l)
  have hAB : (∑ i : ι, ∑ j : ι, ∑ k : ι, ∑ l : ι, T i j k l * T i k l j)
      = ∑ i : ι, ∑ j : ι, ∑ k : ι, ∑ l : ι, T i k l j * T i l j k :=
    sum4_cycle (fun i j k l => T i j k l * T i k l j)
  have hAA : (∑ i : ι, ∑ j : ι, ∑ k : ι, ∑ l : ι, T i j k l * T i j k l)
      = ∑ i : ι, ∑ j : ι, ∑ k : ι, ∑ l : ι, T i k l j * T i k l j :=
    sum4_cycle (fun i j k l => T i j k l * T i j k l)
  have hBB : (∑ i : ι, ∑ j : ι, ∑ k : ι, ∑ l : ι, T i k l j * T i k l j)
      = ∑ i : ι, ∑ j : ι, ∑ k : ι, ∑ l : ι, T i l j k * T i l j k :=
    sum4_cycle (fun i j k l => T i k l j * T i k l j)
  have hsum2 : ∀ f g : ι → ι → ι → ι → ℝ,
      (∑ i : ι, ∑ j : ι, ∑ k : ι, ∑ l : ι, (f i j k l + g i j k l))
        = (∑ i : ι, ∑ j : ι, ∑ k : ι, ∑ l : ι, f i j k l)
          + ∑ i : ι, ∑ j : ι, ∑ k : ι, ∑ l : ι, g i j k l := by
    intro f g; simp [Finset.sum_add_distrib]
  have hAlt : fourNormSq (alt4 T) = (1/4) * ((1/9) *
      ((∑ i : ι, ∑ j : ι, ∑ k : ι, ∑ l : ι, T i j k l * T i j k l)
        + (∑ i : ι, ∑ j : ι, ∑ k : ι, ∑ l : ι, T i k l j * T i k l j)
        + ∑ i : ι, ∑ j : ι, ∑ k : ι, ∑ l : ι, T i l j k * T i l j k)
      + (2/9) *
      ((∑ i : ι, ∑ j : ι, ∑ k : ι, ∑ l : ι, T i j k l * T i k l j)
        + (∑ i : ι, ∑ j : ι, ∑ k : ι, ∑ l : ι, T i k l j * T i l j k)
        + ∑ i : ι, ∑ j : ι, ∑ k : ι, ∑ l : ι, T i l j k * T i j k l)) := by
    unfold fourNormSq fourInner alt4
    congr 1
    rw [sum4_congr (g := fun i j k l =>
        (1/9) * (T i j k l * T i j k l + T i k l j * T i k l j + T i l j k * T i l j k)
        + (2/9) * (T i j k l * T i k l j + T i k l j * T i l j k + T i l j k * T i j k l))
        (fun i j k l => by ring),
      hsum2, sum4_const_mul, sum4_const_mul, sum4_add3, sum4_add3]
  have hT : fourNormSq T = (1/4) * ∑ i : ι, ∑ j : ι, ∑ k : ι, ∑ l : ι, T i j k l * T i j k l := rfl
  rw [hS4, hAlt, hT, ← hBB, ← hAA, ← hAB, hCA]
  ring

/-- **`Σ₄` at the record's operators**: for a linear symmetric `R` on skew matrices,
`∑ R_{ijkl} R_{jkli} = 2‖R‖² − 6‖Alt(R)‖²`. At `R = W²` this is `Σ₄ = 2 tr W⁴ − 6‖Alt(W²)‖²`, so
`Σ₄ ≥ 0` exactly when `‖Alt(W²)‖² ≤ ⅓ tr W⁴`. -/
theorem sigma4_comp (R : Matrix ι ι ℝ → Matrix ι ι ℝ) (hneg : ∀ X, R (-X) = -R X)
    (hsym : ∀ X Y, IsSkew X → IsSkew Y → inner2 (R X) Y = inner2 X (R Y)) :
    (∑ i : ι, ∑ j : ι, ∑ k : ι, ∑ l : ι, comp R i j k l * comp R j k l i)
      = 2 * fourNormSq (comp R) - 6 * altNormSq R :=
  sigma4_eq (comp R) (comp_antisym_left R hneg) (comp_pair_symm R hsym)

/-- Non-vacuity: at `R = id`, `Σ₄ = 2‖id‖²`, since `Alt(id) = 0`. -/
example : (∑ i : Fin 4, ∑ j : Fin 4, ∑ k : Fin 4, ∑ l : Fin 4,
      comp (fun M : Matrix (Fin 4) (Fin 4) ℝ => M) i j k l
        * comp (fun M : Matrix (Fin 4) (Fin 4) ℝ => M) j k l i)
      = 2 * fourNormSq (comp (fun M : Matrix (Fin 4) (Fin 4) ℝ => M)) := by
  rw [sigma4_comp (fun M : Matrix (Fin 4) (Fin 4) ℝ => M) (fun _ => rfl) (fun _ _ _ _ => rfl)]
  have h0 : altNormSq (fun M : Matrix (Fin 4) (Fin 4) ℝ => M) = 0 := by
    unfold altNormSq
    rw [altCoeff_id_eq_zero]
    simp [fourNormSq, fourInner]
  rw [h0]
  ring

end Sigma4

end HamiltonsCubic.IndexConcentration
