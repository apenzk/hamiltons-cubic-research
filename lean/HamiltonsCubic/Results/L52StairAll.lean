import Mathlib
import HamiltonsCubic.Results.L52Staircase
import HamiltonsCubic.Results.L54Basis

set_option linter.style.longLine false

/-!
# L52's staircase sentence at every `n`: a staircase diagonalising a Ricci-flat `K` forces `K = 0`

[findings/bispectral.md](../../../findings/bispectral.md), after Lemma L54: *"Nienhaus–Petersen–Wink's
staircase $\psi_k$ are fixed by the frame, and they diagonalise $K$ on $\mathbf1^\perp$ only when $K$
happens to be diagonal in them"*. The L52 row owes the sentence at every `n`, *"true (at a Ricci-flat
$W$ a staircase diagonalising $K$ on $\mathbf1^\perp$ forces $K=0$ by triangular induction, against
$\sum\mu^2=1$) with only $n=4$ declared"* ([L52Staircase.lean](L52Staircase.lean)). This file proves
`K = 0` at every `n`, for `K` symmetric, hollow and with zero row sums, and the contradiction with unit norm
in its coordinate-diagonal form, `K` then being the weight of `W` ([r1723](../../../reviews/REVIEW_r1723.md)):

* `stair k`: the unnormalised staircase vector `(1, …, 1, -k, 0, …, 0)`, `k` ones;
* `below_step`: `K ψ_k = λ ψ_k` read at a coordinate `i > k` gives `∑_{j<k} K_ij = k K_ik`, whatever `λ`;
* `row_const`: so every row is constant to the left of the diagonal, `K_ik = K_i0` for `0 < k < i`;
* `col0_zero`: zero row sums then give `K_t0 = 0` for every `t ≥ 1`, by downward induction on `t`;
* `stair_forces_zero`: `K = 0`;
* `no_unit_stair`: so no coordinate-diagonal `diagOp w` of unit norm with Ricci-flat weight has every
  staircase vector among `w`'s eigenvectors;
* `Kmat_diagOp`, `no_unit_stair_K`: `w` is the record's `K = (W_{abab})` of `diagOp w` at every `n`
  (L54Basis's `Kmat`), so the same statement with the staircase diagonalising `K`.

*The contradiction with unit norm needs `W` coordinate-diagonal*: at a general Ricci-flat `W` the
staircase still forces `K = 0`, and `K = 0` does not force `W = 0` ([r1721](../../../reviews/REVIEW_r1721.md)
G1, `A ⊕ (-A)` on `Λ⁺ ⊕ Λ⁻` at `n = 4`).
-/

namespace HamiltonsCubic.L52StairAll

open Finset Matrix HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer

variable {n : ℕ}

/-- The unnormalised staircase vector `ψ_k = (1, …, 1, -k, 0, …, 0)`. -/
noncomputable def stair (k : Fin (n + 1)) : Fin (n + 1) → ℝ := fun i => if i < k then 1 else if i = k then -(k : ℝ) else 0

theorem card_lt (k : Fin (n + 1)) : (univ.filter fun j : Fin (n + 1) => j < k).card = k := by
  have : (univ.filter fun j : Fin (n + 1) => j < k) = univ.filter fun j : Fin (n + 1) => (j : ℕ) < (k : ℕ) := by
    ext j
    simp only [Finset.mem_filter, Finset.mem_univ, true_and]
    exact Fin.lt_def
  rw [this, Fin.card_filter_val_lt]
  have := k.isLt
  omega

/-- **Below the step**: at `i > k`, `∑_{j<k} K_ij = k K_ik`. -/
theorem below_step (K : Matrix (Fin (n + 1)) (Fin (n + 1)) ℝ) (k : Fin (n + 1)) (lam : ℝ)
    (h : K *ᵥ stair k = lam • stair k) (i : Fin (n + 1)) (hki : k < i) :
    ∑ j ∈ univ.filter (fun j : Fin (n + 1) => j < k), K i j = (k : ℝ) * K i k := by
  have e := congrFun h i
  have hs : stair k i = 0 := by
    simp [stair, not_lt.mpr hki.le, ne_of_gt hki]
  rw [Pi.smul_apply, hs, smul_zero] at e
  have hexp : ∀ j, K i j * stair k j = (if j < k then K i j else 0) - (if j = k then (k : ℝ) * K i j else 0) := by
    intro j
    unfold stair
    by_cases h1 : j < k
    · simp [h1, ne_of_lt h1]
    · by_cases h2 : j = k
      · subst h2; simp; ring
      · simp [h1, h2]
  have : (K *ᵥ stair k) i = ∑ j, K i j * stair k j := rfl
  rw [this, Finset.sum_congr rfl fun j _ => hexp j, Finset.sum_sub_distrib, ← Finset.sum_filter,
    Finset.sum_ite_eq'] at e
  simp only [Finset.mem_univ, if_true] at e
  linarith

/-- **Every row is constant left of the diagonal**: `K_ik = K_i0` for `0 < k < i`. -/
theorem row_const (K : Matrix (Fin (n + 1)) (Fin (n + 1)) ℝ)
    (hst : ∀ k : Fin (n + 1), 0 < (k : ℕ) → ∃ lam : ℝ, K *ᵥ stair k = lam • stair k) :
    ∀ m : ℕ, ∀ i k : Fin (n + 1), (k : ℕ) = m → k < i → K i k = K i 0 := by
  intro m
  induction m using Nat.strong_induction_on with
  | _ m ih =>
    intro i k hkm hki
    rcases Nat.eq_zero_or_pos m with h0 | hpos
    · have : k = 0 := Fin.ext (by simp [hkm, h0])
      rw [this]
    · obtain ⟨lam, hl⟩ := hst k (by omega)
      have hb := below_step K k lam hl i hki
      have hconst : ∀ j ∈ univ.filter (fun j : Fin (n + 1) => j < k), K i j = K i 0 := by
        intro j hj
        rw [Finset.mem_filter] at hj
        exact ih j (by rw [← hkm]; exact hj.2) i j rfl (hj.2.trans hki)
      rw [Finset.sum_congr rfl hconst, Finset.sum_const, card_lt, nsmul_eq_mul] at hb
      have hk : (0 : ℝ) < k := by exact_mod_cast (show 0 < (k : ℕ) by omega)
      have := mul_left_cancel₀ (ne_of_gt hk) hb
      exact this.symm

/-- Below the diagonal the entries are the first column's: `K_ij = K_i0` for `j < i`; with symmetry
every off-diagonal entry is `a_{max(i,j)}`, `a_t = K_t0`. -/
theorem entry_eq (K : Matrix (Fin (n + 1)) (Fin (n + 1)) ℝ)
    (hst : ∀ k : Fin (n + 1), 0 < (k : ℕ) → ∃ lam : ℝ, K *ᵥ stair k = lam • stair k)
    (i j : Fin (n + 1)) (hij : j < i) : K i j = K i 0 :=
  row_const K hst j i j rfl hij

/-- **The first column vanishes below the top**: `K_t0 = 0` for `t ≥ 1`, by downward induction. -/
theorem col0_zero (K : Matrix (Fin (n + 1)) (Fin (n + 1)) ℝ) (hsym : ∀ a b, K a b = K b a)
    (hhol : ∀ a, K a a = 0) (hrow : ∀ a, ∑ b, K a b = 0)
    (hst : ∀ k : Fin (n + 1), 0 < (k : ℕ) → ∃ lam : ℝ, K *ᵥ stair k = lam • stair k) :
    ∀ d : ℕ, ∀ t : Fin (n + 1), n - (t : ℕ) = d → 1 ≤ (t : ℕ) → K t 0 = 0 := by
  intro d
  induction d using Nat.strong_induction_on with
  | _ d ih =>
    intro t htd ht1
    have hsplit : ∀ j, K t j = (if j < t then K t 0 else 0)
        + (if t < j then K j 0 else 0) := by
      intro j
      rcases lt_trichotomy j t with h | h | h
      · rw [if_pos h, if_neg (not_lt.mpr h.le), add_zero]
        exact entry_eq K hst t j h
      · subst h; simp [hhol]
      · rw [if_neg (not_lt.mpr h.le), if_pos h, zero_add, hsym]
        exact entry_eq K hst j t h
    have hr := hrow t
    rw [Finset.sum_congr rfl fun j _ => hsplit j, Finset.sum_add_distrib, ← Finset.sum_filter,
      ← Finset.sum_filter, Finset.sum_const, card_lt, nsmul_eq_mul] at hr
    have hz : ∑ j ∈ univ.filter (fun j : Fin (n + 1) => t < j), K j 0 = 0 := by
      refine Finset.sum_eq_zero fun j hj => ?_
      rw [Finset.mem_filter] at hj
      have hjt : (t : ℕ) < (j : ℕ) := hj.2
      have hjn : (j : ℕ) < n + 1 := j.isLt
      exact ih (n - (j : ℕ)) (by omega) j rfl (by omega)
    rw [hz, add_zero] at hr
    have ht : (0 : ℝ) < t := by exact_mod_cast (show 0 < (t : ℕ) by omega)
    rcases mul_eq_zero.mp hr with h | h
    · exact absurd h (ne_of_gt ht)
    · exact h

/-- **A staircase diagonalising a Ricci-flat `K` forces `K = 0`.** -/
theorem stair_forces_zero (K : Matrix (Fin (n + 1)) (Fin (n + 1)) ℝ) (hsym : ∀ a b, K a b = K b a)
    (hhol : ∀ a, K a a = 0) (hrow : ∀ a, ∑ b, K a b = 0)
    (hst : ∀ k : Fin (n + 1), 0 < (k : ℕ) → ∃ lam : ℝ, K *ᵥ stair k = lam • stair k) : K = 0 := by
  have hc := col0_zero K hsym hhol hrow hst
  have ha : ∀ t : Fin (n + 1), 1 ≤ (t : ℕ) → K t 0 = 0 := fun t ht =>
    hc (n - (t : ℕ)) t rfl ht
  ext i j
  rw [Matrix.zero_apply]
  rcases lt_trichotomy j i with h | h | h
  · rw [entry_eq K hst i j h]
    exact ha i (by have : (j : ℕ) < i := h; omega)
  · rw [h]; exact hhol i
  · rw [hsym, entry_eq K hst j i h]
    exact ha j (by have : (i : ℕ) < j := h; omega)

/-- **No unit-norm coordinate-diagonal `W` with Ricci-flat weight has its staircase diagonalising `K`**:
the weight would vanish, against `‖W‖² = 1`. -/
theorem no_unit_stair (w : Matrix (Fin (n + 1)) (Fin (n + 1)) ℝ) (hw : IsWeight w)
    (hst : ∀ k : Fin (n + 1), 0 < (k : ℕ) → ∃ lam : ℝ, w *ᵥ stair k = lam • stair k) :
    normSq (diagOp w) ≠ 1 := by
  have h0 := stair_forces_zero w hw.symm hw.hollow hw.rowSum hst
  subst h0
  unfold normSq innerOp
  simp [diagOp, inner2_eq_sum]

/-- **`K` of a diagonal operator is its weight**: `W_{abab} = w_ab` for symmetric hollow `w`. -/
theorem Kmat_diagOp (w : Matrix (Fin (n + 1)) (Fin (n + 1)) ℝ) (hsym : ∀ a b, w a b = w b a)
    (hhol : ∀ a, w a a = 0) (a b : Fin (n + 1)) :
    HamiltonsCubic.SecondKind.Kmat (diagOp w) a b = w a b := by
  show inner2 (diagOp w (phi a b)) (phi a b) = w a b
  rw [diagOp_phi w hsym, FamilyLayer.inner2_smul_left, inner2_phi_phi]
  by_cases h : a = b
  · subst h; simp [hhol]
  · simp [h, Ne.symm h]

/-- **The staircase diagonalising `K = (W_{abab})` of a unit-norm coordinate-diagonal `W`** with
Ricci-flat weight is impossible. -/
theorem no_unit_stair_K (w : Matrix (Fin (n + 1)) (Fin (n + 1)) ℝ) (hw : IsWeight w)
    (hst : ∀ k : Fin (n + 1), 0 < (k : ℕ) → ∃ lam : ℝ,
      HamiltonsCubic.SecondKind.Kmat (diagOp w) *ᵥ stair k = lam • stair k) :
    normSq (diagOp w) ≠ 1 := by
  have hK : HamiltonsCubic.SecondKind.Kmat (diagOp w) = w := by
    ext a b; exact Kmat_diagOp w hw.symm hw.hollow a b
  rw [hK] at hst
  exact no_unit_stair w hw hst

end HamiltonsCubic.L52StairAll
