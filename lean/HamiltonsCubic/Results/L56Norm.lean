import Mathlib
import HamiltonsCubic.Results.L56Weyl
import HamiltonsCubic.Results.L99Statement

set_option linter.style.longLine false

/-!
# L56: the gap is the smallest vertex modulus over the norm of the vertex operator

[L56Weyl.lean](L56Weyl.lean) proves that the Weyl operator of every product of spheres is
`diagOp weylE`, that the vertex entries are `-(n-1)·weylE`, and that L56Statement's `gapSq` is
`(p/(q-1))²` over the pair count `pq(n-1)(n-2)/(2(p-1)(q-1))`. It owes *"that this pair count is
`normSq` of `diagOp` at the vertex weights"*. This file proves it, through L99Statement's
`innerOp_diagOp` (`⟨diagOp v, diagOp w⟩ = ½ ∑_{a,b} v_{ab} w_{ab}`):

* `vW`: the vertex weights `-(n-1)·weylE`, symmetric and hollow;
* `row_sq`: the row of `a` carries `∑_b vW_{ab}² = (n-p)²/(p-1) + (n-p)`, `p` the size of `a`'s factor;
* `normSq_vertex`: `normSq (diagOp vW) = ½ ∑_a ((n-p_a)²/(p_a-1) + (n-p_a))` at every product;
* `normSq_two`: at two factors of sizes `p` and `q`, this is `pq(n-1)(n-2)/(2(p-1)(q-1))`;
* `gapSq_eq_normalised`: so `gap(p,q)² = (p/(q-1))² / normSq (diagOp vW)`, the smallest vertex
  modulus of the unit-normalised Weyl operator, squared;
* `vertex_min_balanced`, `balancedGapSq_eq_normalised`: at `p = q` the smallest modulus is `1`, and
  `1 / normSq (diagOp vW)` is L56Statement's balanced display `2(n-2)/(n²(n-1))`.
-/

namespace HamiltonsCubic.L56Norm

open Finset HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer HamiltonsCubic.L56Weyl

variable {ι : Type*} [Fintype ι] [DecidableEq ι] {κ : Type*} [DecidableEq κ]

/-- The vertex weights, `-(n-1)·weylE`. -/
noncomputable def vW (β : ι → κ) : Matrix ι ι ℝ :=
  Matrix.of fun a b => -((Fintype.card ι : ℝ) - 1) * weylE β a b

theorem vW_symm (β : ι → κ) (hbs : ∀ a, 2 ≤ bs β a) (hn : 2 ≤ Fintype.card ι) (a b : ι) :
    vW β a b = vW β b a := by
  simp only [vW, Matrix.of_apply, (weylE_isWeight β hbs hn).symm a b]

theorem vW_hollow (β : ι → κ) (hbs : ∀ a, 2 ≤ bs β a) (hn : 2 ≤ Fintype.card ι) (a : ι) :
    vW β a a = 0 := by
  simp only [vW, Matrix.of_apply, (weylE_isWeight β hbs hn).hollow a, mul_zero]

/-- **The row of `a`**: `∑_b vW_{ab}² = (n-p)²/(p-1) + (n-p)`, `p = bs β a`. -/
theorem row_sq (β : ι → κ) (hbs : ∀ a, 2 ≤ bs β a) (hn : 2 ≤ Fintype.card ι) (a : ι) :
    ∑ b, vW β a b ^ 2 =
      ((Fintype.card ι : ℝ) - bs β a) ^ 2 / ((bs β a : ℝ) - 1)
        + ((Fintype.card ι : ℝ) - bs β a) := by
  have hb : (2 : ℝ) ≤ bs β a := by exact_mod_cast hbs a
  have h1 : (bs β a : ℝ) - 1 ≠ 0 := by linarith
  set c : ℝ := ((Fintype.card ι : ℝ) - bs β a) / ((bs β a : ℝ) - 1) with hc
  have e : ∀ b, vW β a b ^ 2 = (if β b = β a then c ^ 2 else 1) - (if a = b then c ^ 2 else 0) := by
    intro b
    by_cases hab : a = b
    · subst hab; simp [vW_hollow β hbs hn a]
    · have hv : vW β a b = if β a = β b then -c else 1 := by
        simp only [vW, Matrix.of_apply]
        rw [vertex_entries β hbs hn a b hab]
      rw [hv, if_neg hab, sub_zero]
      by_cases hβ : β a = β b
      · rw [if_pos hβ, if_pos hβ.symm]; ring
      · rw [if_neg hβ, if_neg (Ne.symm hβ)]; ring
  simp only [e, Finset.sum_sub_distrib, Finset.sum_ite_eq, Finset.mem_univ, if_true]
  rw [Finset.sum_ite, Finset.sum_const, Finset.sum_const, nsmul_eq_mul, nsmul_eq_mul, mul_one]
  have hcard := Finset.card_filter_add_card_filter_not (s := Finset.univ) (fun b => β b = β a)
  have hp : ((Finset.univ.filter fun b => β b = β a).card : ℝ) = bs β a := rfl
  have hq : ((Finset.univ.filter fun b => ¬ β b = β a).card : ℝ) =
      (Fintype.card ι : ℝ) - bs β a := by
    rw [← hp, eq_sub_iff_add_eq, add_comm]
    exact_mod_cast hcard
  rw [hp, hq, hc]
  field_simp
  ring

/-- **The norm of the vertex operator** at every product of spheres. -/
theorem normSq_vertex (β : ι → κ) (hbs : ∀ a, 2 ≤ bs β a) (hn : 2 ≤ Fintype.card ι) :
    normSq (diagOp (vW β)) =
      (1 / 2) * ∑ a, (((Fintype.card ι : ℝ) - bs β a) ^ 2 / ((bs β a : ℝ) - 1)
        + ((Fintype.card ι : ℝ) - bs β a)) := by
  unfold normSq
  rw [HamiltonsCubic.L99Statement.innerOp_diagOp _ _ (vW_symm β hbs hn) (vW_symm β hbs hn) (vW_hollow β hbs hn)]
  congr 1
  refine Finset.sum_congr rfl fun a _ => ?_
  rw [← row_sq β hbs hn a]
  exact Finset.sum_congr rfl fun b _ => by ring

/-- **Two factors**: `normSq (diagOp vW) = pq(n-1)(n-2)/(2(p-1)(q-1))`, with `p` and `q` the sizes
of the two factors, the pair count of L56Weyl's `vertex_normSq`. -/
theorem normSq_two (β : ι → Bool) (hbs : ∀ a, 2 ≤ bs β a) (hn : 2 ≤ Fintype.card ι)
    {a₁ a₂ : ι} (h1 : β a₁ = true) (h2 : β a₂ = false) :
    normSq (diagOp (vW β)) =
      (bs β a₁ : ℝ) * bs β a₂ * ((bs β a₁ : ℝ) + bs β a₂ - 1) * ((bs β a₁ : ℝ) + bs β a₂ - 2)
        / (2 * ((bs β a₁ : ℝ) - 1) * ((bs β a₂ : ℝ) - 1)) := by
  have hcard := Finset.card_filter_add_card_filter_not (s := Finset.univ) (fun b => β b = true)
  have hP : (Finset.univ.filter fun b => β b = true).card = bs β a₁ := by
    unfold bs; rw [h1]
  have hQ : (Finset.univ.filter fun b => ¬ β b = true).card = bs β a₂ := by
    unfold bs; rw [h2]; congr 1; ext b; simp
  have hN : (Fintype.card ι : ℝ) = bs β a₁ + bs β a₂ := by
    rw [← hP, ← hQ]; exact_mod_cast hcard.symm
  set f : ℕ → ℝ := fun p => ((Fintype.card ι : ℝ) - p) ^ 2 / ((p : ℝ) - 1)
    + ((Fintype.card ι : ℝ) - p) with hf
  have hsum : ∑ a, f (bs β a) = bs β a₁ * f (bs β a₁) + bs β a₂ * f (bs β a₂) := by
    rw [← Finset.sum_filter_add_sum_filter_not Finset.univ (fun b => β b = true)]
    have e1 : ∀ a ∈ Finset.univ.filter (fun b => β b = true), f (bs β a) = f (bs β a₁) := by
      intro a ha
      rw [Finset.mem_filter] at ha
      rw [bs_eq (ha.2.trans h1.symm)]
    have e2 : ∀ a ∈ Finset.univ.filter (fun b => ¬ β b = true), f (bs β a) = f (bs β a₂) := by
      intro a ha
      rw [Finset.mem_filter] at ha
      have : β a = false := by simpa using ha.2
      rw [bs_eq (this.trans h2.symm)]
    rw [Finset.sum_congr rfl e1, Finset.sum_congr rfl e2, Finset.sum_const, Finset.sum_const,
      nsmul_eq_mul, nsmul_eq_mul, hP, hQ]
  have hv := normSq_vertex β hbs hn
  have hs : ∑ a, (((Fintype.card ι : ℝ) - bs β a) ^ 2 / ((bs β a : ℝ) - 1)
      + ((Fintype.card ι : ℝ) - bs β a)) = ∑ a, f (bs β a) := rfl
  rw [hv, hs, hsum, hf]
  simp only
  have hp : (2 : ℝ) ≤ bs β a₁ := by exact_mod_cast hbs a₁
  have hq : (2 : ℝ) ≤ bs β a₂ := by exact_mod_cast hbs a₂
  have hp1 : (bs β a₁ : ℝ) - 1 ≠ 0 := by linarith
  have hq1 : (bs β a₂ : ℝ) - 1 ≠ 0 := by linarith
  rw [hN]
  field_simp
  ring

/-- **The recorded gap is the smallest vertex modulus of the unit-normalised Weyl operator**:
`gap(p,q)² = (p/(q-1))² / normSq (diagOp vW)` at two factors of sizes `p` and `q`. The identity holds
at every sizes; `p/(q-1)` is the smallest modulus at `p < q` (L56Weyl's `vertex_min`), which is the
record's range for `gapSq`. -/
theorem gapSq_eq_normalised (β : ι → Bool) (hbs : ∀ a, 2 ≤ bs β a) (hn : 2 ≤ Fintype.card ι)
    {a₁ a₂ : ι} (h1 : β a₁ = true) (h2 : β a₂ = false) :
    HamiltonsCubic.L56Statement.gapSq (bs β a₁) (bs β a₂) =
      ((bs β a₁ : ℝ) / ((bs β a₂ : ℝ) - 1)) ^ 2 / normSq (diagOp (vW β)) := by
  have hp : (2 : ℝ) ≤ bs β a₁ := by exact_mod_cast hbs a₁
  have hq : (2 : ℝ) ≤ bs β a₂ := by exact_mod_cast hbs a₂
  rw [normSq_two β hbs hn h1 h2]
  exact gapSq_eq_vertex (by linarith) (by linarith) (by linarith) (by linarith) (by linarith)
    (by linarith)

/-- **At `p = q` the smallest vertex modulus is `1`**: the entries are `-p/(p-1)` twice and `1`, and
`p/(p-1) ≥ 1`. -/
theorem vertex_min_balanced {p : ℕ} (hp : 2 ≤ p) : (1 : ℝ) ≤ (p : ℝ) / ((p : ℝ) - 1) := by
  have hpR : (2 : ℝ) ≤ p := by exact_mod_cast hp
  rw [le_div_iff₀ (by linarith)]
  linarith

/-- **The balanced display**: at two factors of equal size `p`, `n = 2p`, the smallest vertex modulus
`1` over the norm gives L56Statement's `balancedGapSq`, `2(n-2)/(n²(n-1))`. -/
theorem balancedGapSq_eq_normalised (β : ι → Bool) (hbs : ∀ a, 2 ≤ bs β a)
    (hn : 2 ≤ Fintype.card ι) {a₁ a₂ : ι} (h1 : β a₁ = true) (h2 : β a₂ = false)
    (heq : bs β a₁ = bs β a₂) :
    HamiltonsCubic.L56Statement.balancedGapSq (Fintype.card ι) = 1 ^ 2 / normSq (diagOp (vW β)) := by
  have hcard := Finset.card_filter_add_card_filter_not (s := Finset.univ) (fun b => β b = true)
  have hP : (Finset.univ.filter fun b => β b = true).card = bs β a₁ := by
    unfold bs; rw [h1]
  have hQ : (Finset.univ.filter fun b => ¬ β b = true).card = bs β a₂ := by
    unfold bs; rw [h2]; congr 1; ext b; simp
  have hN : (Fintype.card ι : ℝ) = bs β a₁ + bs β a₁ := by
    rw [← hP]
    nth_rewrite 2 [hP]
    rw [heq, ← hQ]
    exact_mod_cast hcard.symm
  have hp : (2 : ℝ) ≤ bs β a₁ := by exact_mod_cast hbs a₁
  rw [normSq_two β hbs hn h1 h2, ← heq, HamiltonsCubic.L56Statement.balancedGapSq, hN]
  set x : ℝ := (bs β a₁ : ℝ) with hx
  have d1 : (x + x) ^ 2 * (x + x - 1) ≠ 0 :=
    mul_ne_zero (pow_ne_zero _ (by linarith)) (by linarith)
  have d2 : x * x * (x + x - 1) * (x + x - 2) ≠ 0 :=
    mul_ne_zero (mul_ne_zero (mul_ne_zero (by linarith) (by linarith)) (by linarith)) (by linarith)
  rw [one_pow, one_div_div, div_eq_div_iff d1 d2]
  ring

end HamiltonsCubic.L56Norm
