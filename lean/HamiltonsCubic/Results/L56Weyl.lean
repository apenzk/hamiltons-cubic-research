import Mathlib
import HamiltonsCubic.Results.L2SphereWeyl
import HamiltonsCubic.Results.L56Statement

set_option linter.style.longLine false

/-!
# L56: the Weyl operator of a product of spheres is the diagonal operator carrying the recorded weights

[findings/ungraded-slack.md](../../../findings/ungraded-slack.md), Lemma L56, and
[L56Multi.lean](L56Multi.lean), which takes the multi-block weights as definitions and owes *"that the
Weyl operator of each product is the diagonal operator carrying these weights"*. The two-factor case is
[L2SphereWeyl.lean](L2SphereWeyl.lean)'s `sphereProduct_weylPart`; this file does every product.

A product of spheres is a labelling `β : ι → κ` of the coordinates by factor, each factor of size at
least `2`. At the record's Einstein normalisation (`Ric = 1`, each factor `S^{pᵢ}` of radius
`√(pᵢ-1)`) its curvature operator is `diagOp (sectE β)`, sectional curvature `1/(pᵢ-1)` within a factor
and `0` across. Then:

* `sectE_split`: `sectE = weylE + KN(½ · 1/(n-1))`, with `weylE` the record's Einstein weights,
  `1/(pᵢ-1) - 1/(n-1)` within a factor and `-1/(n-1)` across;
* `weylE_isWeight`: `weylE` is symmetric, hollow and has zero row sums at **every** block sizes, so
  `diagOp weylE` is a linear Weyl operator;
* `product_weylPart_unique`: any split of the product's curvature into a linear Weyl operator plus a part
  orthogonal to every Ricci-flat linear operator has Weyl summand `diagOp weylE` on bivectors, so it is
  the Weyl projection;
* `unit_weights`: at equal factors `S^p` of unit radius the Weyl weights are `(p-1)·weylE`, which are
  L56Multi's `1-c` within and `-c` across, `c = (p-1)/(n-1)`;
* `vertex_entries`, `vertex_min`: the vertex-entry mechanism. The entries are `-(n-1)·weylE`, which at
  `S^p × S^q` are `-q/(p-1)`, `-p/(q-1)` and `1`, and at `2 ≤ p < q` the smallest modulus is `p/(q-1)`;
* `vertex_normSq`, `gapSq_eq_vertex`: the pair count of the squared vertex entries is
  `pq(n-1)(n-2)/(2(p-1)(q-1))`, and L56Statement's `gapSq` is `(p/(q-1))²` over it. That this count is
  `normSq` of `diagOp` at the vertex weights is [L56Norm.lean](L56Norm.lean)'s `normSq_two`.
-/

namespace HamiltonsCubic.L56Weyl

open Finset HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer HamiltonsCubic.L2SphereWeyl

variable {ι : Type*} [Fintype ι] [DecidableEq ι] {κ : Type*} [DecidableEq κ]

/-- The size of the factor containing `a`. -/
def bs (β : ι → κ) (a : ι) : ℕ := (Finset.univ.filter fun b => β b = β a).card

/-- The product's sectional weights at the Einstein normalisation: `1/(pᵢ-1)` within a factor,
`0` across. -/
noncomputable def sectE (β : ι → κ) : Matrix ι ι ℝ :=
  Matrix.of fun a b => if a = b then 0 else if β a = β b then 1 / ((bs β a : ℝ) - 1) else 0

/-- The record's Einstein Weyl weights: `1/(pᵢ-1) - 1/(n-1)` within a factor, `-1/(n-1)` across. -/
noncomputable def weylE (β : ι → κ) : Matrix ι ι ℝ :=
  Matrix.of fun a b => if a = b then 0 else
    if β a = β b then 1 / ((bs β a : ℝ) - 1) - 1 / ((Fintype.card ι : ℝ) - 1)
    else -(1 / ((Fintype.card ι : ℝ) - 1))

omit [DecidableEq ι] in
theorem bs_eq {β : ι → κ} {a b : ι} (h : β a = β b) : bs β a = bs β b := by
  unfold bs; rw [h]

/-- **The split**: sectional weights are the Weyl weights plus the Kulkarni–Nomizu weight of the
constant `½ · 1/(n-1)`. -/
theorem sectE_split (β : ι → κ) (a b : ι) :
    sectE β a b = weylE β a b + knWeight (fun _ => (1 / 2) * (1 / ((Fintype.card ι : ℝ) - 1))) a b := by
  unfold sectE weylE knWeight
  simp only [Matrix.of_apply]
  by_cases hab : a = b
  · simp [hab]
  · by_cases hβ : β a = β b
    · simp only [hab, hβ, if_false, if_true]; ring
    · simp only [hab, hβ, if_false]; ring

/-- **The Einstein Weyl weights are a weight** at every block sizes `≥ 2`: symmetric, hollow, zero row
sums. -/
theorem weylE_isWeight (β : ι → κ) (hbs : ∀ a, 2 ≤ bs β a) (hn : 2 ≤ Fintype.card ι) :
    IsWeight (weylE β) where
  symm a b := by
    unfold weylE
    simp only [Matrix.of_apply]
    by_cases hab : a = b
    · subst hab; rfl
    · by_cases hβ : β a = β b
      · simp [hab, Ne.symm hab, hβ, bs_eq hβ]
      · simp [hab, Ne.symm hab, hβ, Ne.symm hβ]
  hollow a := by unfold weylE; simp
  rowSum a := by
    have hb : (2 : ℝ) ≤ bs β a := by exact_mod_cast hbs a
    have hnR : (2 : ℝ) ≤ Fintype.card ι := by exact_mod_cast hn
    set p : ℝ := (bs β a : ℝ) with hp
    set N : ℝ := (Fintype.card ι : ℝ) with hN
    have e : ∀ b, weylE β a b = (if β b = β a then 1 / (p - 1) else 0) - 1 / (N - 1)
        - (if a = b then 1 / (p - 1) - 1 / (N - 1) else 0) := fun b => by
      unfold weylE
      simp only [Matrix.of_apply]
      by_cases hab : a = b
      · subst hab; simp
      · by_cases hβ : β a = β b
        · simp [hab, hβ, bs_eq hβ, hp, hN]
        · simp [hab, hβ, Ne.symm hβ, hN]
    simp only [e, Finset.sum_sub_distrib, Finset.sum_ite_eq, Finset.mem_univ, if_true,
      Finset.sum_const, Finset.card_univ, nsmul_eq_mul]
    rw [Finset.sum_ite, Finset.sum_const_zero, add_zero, Finset.sum_const, nsmul_eq_mul]
    have hc : ((Finset.univ.filter fun b => β b = β a).card : ℝ) = p := by rw [hp]; rfl
    rw [hc, ← hN]
    have h1 : p - 1 ≠ 0 := by linarith
    have h2 : N - 1 ≠ 0 := by linarith
    field_simp
    ring

/-- **The Weyl operator of a product of spheres**, at the Einstein normalisation: the curvature
`diagOp (sectE β)` is the linear Weyl operator `diagOp (weylE β)` plus a Kulkarni–Nomizu part
orthogonal to every Ricci-flat linear operator. -/
theorem product_weylPart (β : ι → κ) (hbs : ∀ a, 2 ≤ bs β a) (hn : 2 ≤ Fintype.card ι) :
    (∀ X, diagOp (sectE β) X = diagOp (weylE β) X
        + diagOp (knWeight (fun _ => (1 / 2) * (1 / ((Fintype.card ι : ℝ) - 1)))) X) ∧
      IsWeylOp (diagOp (weylE β)) ∧
      ∀ R : Matrix ι ι ℝ → Matrix ι ι ℝ, IsLinOp R → (∀ a b, Ric R a b = 0) →
        innerOp (diagOp (knWeight (fun _ => (1 / 2) * (1 / ((Fintype.card ι : ℝ) - 1))))) R = 0 := by
  refine ⟨fun X => ?_, ⟨isLinOp_diagOp _, diagOp_isWeyl (weylE_isWeight β hbs hn)⟩,
    fun R hR hRic => ?_⟩
  · ext a b
    simp only [diagOp, Matrix.of_apply, Matrix.add_apply, sectE_split β a b]
    ring
  · rw [innerOp_knWeight _ R hR]
    simp [hRic]

/-- **It is the Weyl projection**: any split of the product's curvature into a linear Weyl operator
and a part orthogonal to every Ricci-flat linear operator has Weyl summand `diagOp weylE` on
bivectors. -/
theorem product_weylPart_unique (β : ι → κ) (hbs : ∀ a, 2 ≤ bs β a) (hn : 2 ≤ Fintype.card ι)
    (W K : Matrix ι ι ℝ → Matrix ι ι ℝ) (hW : IsWeylOp W)
    (hK : ∀ R, IsLinOp R → (∀ a b, Ric R a b = 0) → innerOp K R = 0)
    (hsplit : ∀ X, diagOp (sectE β) X = W X + K X) (i j : ι) :
    W (phi i j) = diagOp (weylE β) (phi i j) := by
  obtain ⟨h1, h2, h3⟩ := product_weylPart β hbs hn
  refine weylPart_unique hW h2 hK h3 (fun X => ?_) i j
  rw [← hsplit X, h1 X]

/-- **Unit spheres of equal dimension**: when every factor has size `p`, `(p-1)·weylE` is L56Multi's
multi-block weight, `1 - c` within a factor and `-c` across, `c = (p-1)/(n-1)`. -/
theorem unit_weights (β : ι → κ) {p : ℕ} (hp : ∀ a, bs β a = p) (hp2 : 2 ≤ p)
    (a b : ι) (hab : a ≠ b) :
    ((p : ℝ) - 1) * weylE β a b =
      if β a = β b then 1 - ((p : ℝ) - 1) / ((Fintype.card ι : ℝ) - 1)
      else -(((p : ℝ) - 1) / ((Fintype.card ι : ℝ) - 1)) := by
  have hp1 : (p : ℝ) - 1 ≠ 0 := by
    have : (2 : ℝ) ≤ p := by exact_mod_cast hp2
    linarith
  unfold weylE
  simp only [Matrix.of_apply, hab, if_false, hp a]
  by_cases hβ : β a = β b
  · simp only [hβ, if_true]; field_simp
  · simp only [hβ, if_false]; ring

/-- **The vertex-entry mechanism**: the vertex entries are the Weyl weights rescaled by `-(n-1)`, so
`-(n-p)/(p-1)` within a factor of size `p` and `1` across. At two factors `S^p × S^q` these are the
record's `-q/(p-1)`, `-p/(q-1)` and `1`. -/
theorem vertex_entries (β : ι → κ) (hbs : ∀ a, 2 ≤ bs β a) (hn : 2 ≤ Fintype.card ι)
    (a b : ι) (hab : a ≠ b) :
    -((Fintype.card ι : ℝ) - 1) * weylE β a b =
      if β a = β b then -(((Fintype.card ι : ℝ) - bs β a) / ((bs β a : ℝ) - 1)) else 1 := by
  have hb : (2 : ℝ) ≤ bs β a := by exact_mod_cast hbs a
  have hnR : (2 : ℝ) ≤ Fintype.card ι := by exact_mod_cast hn
  have h1 : (bs β a : ℝ) - 1 ≠ 0 := by linarith
  have h2 : (Fintype.card ι : ℝ) - 1 ≠ 0 := by linarith
  unfold weylE
  simp only [Matrix.of_apply, hab, if_false]
  by_cases hβ : β a = β b
  · simp only [hβ, if_true]; field_simp; ring
  · simp only [hβ, if_false]; field_simp

/-- **The smallest modulus is `p/(q-1)`** among the two-factor vertex entries `-q/(p-1)`,
`-p/(q-1)` and `1`, at `2 ≤ p < q`. -/
theorem vertex_min {p q : ℕ} (hp : 2 ≤ p) (hpq : p < q) :
    (p : ℝ) / ((q : ℝ) - 1) ≤ 1 ∧ (p : ℝ) / ((q : ℝ) - 1) ≤ (q : ℝ) / ((p : ℝ) - 1) := by
  have hpq' : (p : ℝ) + 1 ≤ q := by exact_mod_cast hpq
  have hpR : (2 : ℝ) ≤ p := by exact_mod_cast hp
  have hq1 : 0 < (q : ℝ) - 1 := by linarith
  have hp1 : 0 < (p : ℝ) - 1 := by linarith
  refine ⟨?_, ?_⟩
  · rw [div_le_one hq1]; linarith
  · rw [div_le_div_iff₀ hq1 hp1]; nlinarith

/-- **The squared vertex norm at `S^p × S^q`**: `p(p-1)/2` pairs carrying `-q/(p-1)`, `q(q-1)/2`
carrying `-p/(q-1)` and `pq` carrying `1` sum to `pq(n-1)(n-2)/(2(p-1)(q-1))`. -/
theorem vertex_normSq {p q : ℝ} (hp : p - 1 ≠ 0) (hq : q - 1 ≠ 0) :
    p * (p - 1) / 2 * (q / (p - 1)) ^ 2 + q * (q - 1) / 2 * (p / (q - 1)) ^ 2 + p * q =
      p * q * (p + q - 1) * (p + q - 2) / (2 * (p - 1) * (q - 1)) := by
  field_simp
  ring

/-- **The recorded gap is the smallest vertex modulus over the vertex norm**:
`gap(p,q)² = (p/(q-1))² / (pq(n-1)(n-2)/(2(p-1)(q-1)))`, L56Statement's `gapSq`. -/
theorem gapSq_eq_vertex {p q : ℝ} (hp0 : p ≠ 0) (hq0 : q ≠ 0) (hp : p - 1 ≠ 0) (hq : q - 1 ≠ 0)
    (hn1 : p + q - 1 ≠ 0) (hn2 : p + q - 2 ≠ 0) :
    HamiltonsCubic.L56Statement.gapSq p q =
      (p / (q - 1)) ^ 2 / (p * q * (p + q - 1) * (p + q - 2) / (2 * (p - 1) * (q - 1))) := by
  unfold HamiltonsCubic.L56Statement.gapSq
  field_simp

end HamiltonsCubic.L56Weyl
