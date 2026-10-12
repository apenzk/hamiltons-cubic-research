import HamiltonsCubic.Results.L116Witness

set_option linter.style.longLine false

/-!
# L116: `R^#` alone does not preserve first Bianchi

[findings/bounds-relaxations.md](../../../findings/bounds-relaxations.md), Lemma L116: *"`R^#` alone does not"* preserve
Bianchi, the sum `R² + R^#` does. The record witnesses it numerically at `ℂP³` and `ℂP⁴`. **This file proves it at
`n = 4` with `W_{ℂP²}`'s shape**, `R = Σ_a μ_a ω_a ⊗ ω_a` over the three self-dual forms `ω_a` with `μ = (2, -1, -1)`:

* **`Rcp_bianchi`**: `R` satisfies first Bianchi, `Σ μ_a = 0` cancelling the three equal `ω_a ∧ ω_a`;
* **`Rcp_sq_0123`**: `b(R²)_{0123} = 12`;
* **`sharp_not_bianchi`**: `b(R^#)_{0123} = -12`, through [L116Statement.lean](L116Statement.lean)'s `L116`, so `R^#` fails
  first Bianchi at a Bianchi `R`;
* **`diagT_bianchi`**, **`comp_diagT`**, **`degenerate_diag`**: the block's degenerate point on the whole
  coordinate-diagonal locus, `S³ × S³` among it: a diagonal tensor with symmetric hollow weight satisfies first Bianchi,
  squaring it squares its weights, so `b(W²) = 0` and, through `L116`, `b(W^#) = 0` there;
* **`degenerate_S3S3`**: the same at `S³ × S³`'s weight, `3/5` within a factor and `-2/5` across.
-/

namespace HamiltonsCubic.L116Statement

open Finset

/-- The three self-dual forms on `ℝ⁴`, `e₁₂ + e₃₄`, `e₁₃ + e₄₂`, `e₁₄ + e₂₃`. -/
def omSD : Fin 3 → Bivector 4 :=
  ![!![0, 1, 0, 0; -1, 0, 0, 0; 0, 0, 0, 1; 0, 0, -1, 0],
    !![0, 0, 1, 0; 0, 0, 0, -1; -1, 0, 0, 0; 0, 1, 0, 0],
    !![0, 0, 0, 1; 0, 0, 1, 0; 0, -1, 0, 0; -1, 0, 0, 0]]

/-- `μ = (2, -1, -1)`. -/
def muSD : Fin 3 → ℝ := ![2, -1, -1]

/-- `R = Σ_a μ_a ω_a ⊗ ω_a`. -/
def Rcp : Tensor4 4 := fun i j k l => ∑ a, muSD a * (omSD a i j * omSD a k l)

set_option maxHeartbeats 8000000 in
-- Two hundred and fifty-six index cases, each a three-term sum of literal entries.
theorem Rcp_bianchi : FirstBianchi Rcp := by
  unfold FirstBianchi
  funext i j k l
  simp only [bianchi, Rcp, Pi.zero_apply, Fin.sum_univ_three]
  fin_cases i <;> fin_cases j <;> fin_cases k <;> fin_cases l <;> simp [omSD, muSD] <;> norm_num

theorem Rcp_skew₁ (i j k l : Fin 4) : Rcp i j k l = -Rcp j i k l := by
  simp only [Rcp, Fin.sum_univ_three]
  fin_cases i <;> fin_cases j <;> simp [omSD]

theorem Rcp_skew₂ (i j k l : Fin 4) : Rcp i j k l = -Rcp i j l k := by
  simp only [Rcp, Fin.sum_univ_three]
  fin_cases k <;> fin_cases l <;> simp [omSD]

theorem Rcp_pair (i j k l : Fin 4) : Rcp i j k l = Rcp k l i j := by
  simp only [Rcp]; exact Finset.sum_congr rfl fun a _ => by ring

theorem Rcp_sq_0123 : bianchi (comp Rcp Rcp) 0 1 2 3 = 12 := by
  simp only [bianchi, comp, Rcp, Fin.sum_univ_four, Fin.sum_univ_three]
  simp [omSD, muSD]
  norm_num

/-- **`R^#` alone fails first Bianchi at a Bianchi `R`.** -/
theorem sharp_not_bianchi : bianchi (sharp Rcp) 0 1 2 3 = -12 ∧ ¬ FirstBianchi (sharp Rcp) := by
  have h := congrFun (congrFun (congrFun (congrFun
    (L116 Rcp Rcp_skew₁ Rcp_skew₂ Rcp_pair Rcp_bianchi) 0) 1) 2) 3
  simp only [Pi.neg_apply] at h
  rw [Rcp_sq_0123] at h
  refine ⟨h, fun hB => ?_⟩
  have := congrFun (congrFun (congrFun (congrFun hB 0) 1) 2) 3
  simp only [Pi.zero_apply] at this
  rw [h] at this; norm_num at this

section Diag

variable {n : ℕ}

/-- A coordinate-diagonal tensor, `D_w = Σ_{a<b} w_{ab} e_{ab} ⊗ e_{ab}` in components. -/
def diagT (w : Fin n → Fin n → ℝ) : Tensor4 n := fun i j k l =>
  w i j * ((if i = k ∧ j = l then 1 else 0) - (if i = l ∧ j = k then 1 else 0))

/-- **A coordinate-diagonal tensor with a symmetric hollow weight satisfies first Bianchi.** -/
theorem diagT_bianchi (w : Fin n → Fin n → ℝ) (hw : ∀ a b, w a b = w b a) (hh : ∀ a, w a a = 0) :
    FirstBianchi (diagT w) := by
  unfold FirstBianchi
  funext i j k l
  simp only [bianchi, diagT, Pi.zero_apply]
  by_cases h1 : i = k <;> by_cases h2 : j = l <;> by_cases h3 : j = k <;> by_cases h4 : i = l <;>
    by_cases h5 : i = j <;> by_cases h6 : k = l <;> subst_vars <;>
      simp_all <;> (try (intro h; subst h; simp_all))

/-- **`D_w² = D_{w ∘ w}`**: squaring a coordinate-diagonal tensor squares its weights. -/
theorem comp_diagT (w : Fin n → Fin n → ℝ) (hw : ∀ a b, w a b = w b a) (hh : ∀ a, w a a = 0) :
    comp (diagT w) (diagT w) = diagT (fun a b => w a b * w a b) := by
  funext i j k l
  simp only [comp, diagT, mul_sub, sub_mul, mul_ite, ite_mul, mul_one, mul_zero, zero_mul, ite_and,
    Finset.sum_sub_distrib]
  simp [Finset.sum_ite_eq', Finset.sum_ite_irrel]
  by_cases h1 : i = k <;> by_cases h2 : j = l <;> by_cases h3 : j = k <;> by_cases h4 : i = l <;>
    by_cases h5 : i = j <;> subst_vars <;> simp_all <;> (try rw [hw]) <;> ring

theorem diagT_skew₁ (w : Fin n → Fin n → ℝ) (hw : ∀ a b, w a b = w b a) (i j k l : Fin n) :
    diagT w i j k l = -diagT w j i k l := by
  simp only [diagT]
  by_cases h1 : i = k <;> by_cases h2 : j = l <;> by_cases h3 : j = k <;> by_cases h4 : i = l <;>
    subst_vars <;> simp_all

theorem diagT_skew₂ (w : Fin n → Fin n → ℝ) (i j k l : Fin n) : diagT w i j k l = -diagT w i j l k := by
  simp only [diagT]
  by_cases h1 : i = k ∧ j = l <;> by_cases h3 : i = l ∧ j = k <;> simp only [h1, h3, if_false] <;> ring

theorem diagT_pair (w : Fin n → Fin n → ℝ) (hw : ∀ a b, w a b = w b a) (i j k l : Fin n) :
    diagT w i j k l = diagT w k l i j := by
  simp only [diagT]
  by_cases h1 : i = k ∧ j = l
  · obtain ⟨rfl, rfl⟩ := h1; rfl
  · by_cases h3 : i = l ∧ j = k
    · obtain ⟨rfl, rfl⟩ := h3
      rw [hw i j]
      by_cases hij : i = j
      · subst hij; rfl
      · simp [hij, Ne.symm hij]
    · have h1' : ¬(k = i ∧ l = j) := fun h => h1 ⟨h.1.symm, h.2.symm⟩
      have h3' : ¬(k = j ∧ l = i) := fun h => h3 ⟨h.2.symm, h.1.symm⟩
      rw [if_neg h1, if_neg h3, if_neg h1', if_neg h3']; ring

/-- **The degenerate point, on the whole coordinate-diagonal locus**: there `b(W²) = 0`, and at first Bianchi also
`b(W^#) = 0`, so a screen run only on this locus (`S³ × S³` among it) returns zero twice. -/
theorem degenerate_diag (w : Fin n → Fin n → ℝ) (hw : ∀ a b, w a b = w b a) (hh : ∀ a, w a a = 0) :
    bianchi (comp (diagT w) (diagT w)) = 0 ∧ bianchi (sharp (diagT w)) = 0 := by
  have h2 : bianchi (comp (diagT w) (diagT w)) = 0 := by
    rw [comp_diagT w hw hh]
    exact diagT_bianchi _ (fun a b => by rw [hw a b]) (fun a => by rw [hh a, mul_zero])
  refine ⟨h2, ?_⟩
  rw [L116 (diagT w) (diagT_skew₁ w hw) (diagT_skew₂ w) (diagT_pair w hw) (diagT_bianchi w hw hh), h2, neg_zero]

/-- **`S³ × S³` is on the locus**: its Weyl tensor's weight, `3/5` within a factor and `-2/5` across (unit-sphere
product up to scale), is symmetric and hollow, so `degenerate_diag` applies to it. -/
theorem degenerate_S3S3 :
    let w : Fin 6 → Fin 6 → ℝ := fun a b =>
      if a = b then 0 else if ((a : ℕ) < 3 ↔ (b : ℕ) < 3) then 3 / 5 else -2 / 5
    bianchi (comp (diagT w) (diagT w)) = 0 ∧ bianchi (sharp (diagT w)) = 0 := by
  intro w
  refine degenerate_diag w (fun a b => ?_) (fun a => by simp [w])
  simp only [w]
  by_cases hab : a = b
  · subst hab; rfl
  · rw [if_neg hab, if_neg (Ne.symm hab)]
    by_cases h : ((a : ℕ) < 3 ↔ (b : ℕ) < 3)
    · rw [if_pos h, if_pos h.symm]
    · rw [if_neg h, if_neg (fun h' => h h'.symm)]

end Diag

end HamiltonsCubic.L116Statement
