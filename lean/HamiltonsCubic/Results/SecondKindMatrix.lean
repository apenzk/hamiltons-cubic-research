import HamiltonsCubic.Results.SpectralTrace

set_option linter.style.longLine false

/-!
# `W̊` as a matrix on `S²`

[findings/bispectral.md](../../../findings/bispectral.md), Lemma L50 reads `tr W̊³` as `p₃(ω)` with
`ω` the spectrum of the second-kind operator. [SecondKind.lean](SecondKind.lean) proves the trace
identities as `trS2`, a trace over `S²` written as a sum over all `(a,b)`. **This file writes `W̊`
as a real symmetric matrix on `S²`** and identifies its power traces with `trS2`:

- `e`: the orthonormal basis `{√2 · symB a b}_{a<b} ∪ {E_aa}` of `S²` for the Frobenius pairing,
  indexed by `S2Idx n = Pairs n ⊕ Fin n`;
- `expand_sym`: a symmetric `h` is `∑_u ⟨h, e_u⟩ e_u`;
- `frob_e`: `e` is orthonormal;
- `Bmat L u v = ⟨L e_u, e_v⟩`, with `Bmat_comp`: `Bmat (W̊ ∘ L') = Bmat L' * Bmat W̊` for `L'`
  mapping the basis to symmetric matrices, and `trace_Bmat`: `tr (Bmat L) = trS2 L`;
- `sum_omega_sq`, `sum_omega_cube`: for `ω` the spectrum of `Bmat W̊`,
  `∑ ω² = tr_{S²} W̊² = 3‖R‖²` and `∑ ω³ = tr_{S²} W̊³`.

The spectrum on `S²` is the record's `ω` on `S²₀` with one more eigenvalue, `0` on `g`, at a
Ricci-flat `R` (`ringW_one`). Power sums do not see it.
-/

namespace HamiltonsCubic.SecondKind

open Finset Matrix HamiltonsCubic.RealLayer HamiltonsCubic.Results

variable {n : ℕ}

/-- **An ordered-pair sum, with its diagonal**: `∑_{i,j} g = 2 ∑_{a<b} g + ∑_i g i i` for a
symmetric `g`. -/
theorem sum_pairs_diag (g : Fin n → Fin n → ℝ) (hsym : ∀ i j, g i j = g j i) :
    ∑ i, ∑ j, g i j = 2 * ∑ p : Pairs n, g p.1.1 p.1.2 + ∑ i, g i i := by
  set g' : Fin n → Fin n → ℝ := fun i j => if i = j then 0 else g i j
  have h' := sum_pairs g' (fun i => by simp [g']) (fun i j => by
    simp only [g']; by_cases h : i = j
    · subst h; rfl
    · rw [if_neg h, if_neg (Ne.symm h), hsym])
  have hp : ∀ p : Pairs n, g' p.1.1 p.1.2 = g p.1.1 p.1.2 := fun p => by
    simp only [g']; rw [if_neg (ne_of_lt p.2)]
  have hsplit : ∀ i j, g i j = g' i j + (if i = j then g i j else 0) := fun i j => by
    simp only [g']; split_ifs <;> simp_all
  calc ∑ i, ∑ j, g i j = ∑ i, ∑ j, g' i j + ∑ i, ∑ j, (if i = j then g i j else 0) := by
        rw [← Finset.sum_add_distrib]
        refine Finset.sum_congr rfl fun i _ => ?_
        rw [← Finset.sum_add_distrib]
        exact Finset.sum_congr rfl fun j _ => hsplit i j
    _ = 2 * ∑ p : Pairs n, g p.1.1 p.1.2 + ∑ i, g i i := by
        rw [h', Finset.sum_congr rfl fun p _ => hp p]
        congr 1
        exact Finset.sum_congr rfl fun i _ => by simp

/-- The index of the basis of `S²`: off-diagonal pairs and diagonal slots. -/
abbrev S2Idx (n : ℕ) := Pairs n ⊕ Fin n

/-- **The orthonormal basis of `S²`**: `√2 · symB a b = (E_ab + E_ba)/√2` for `a < b`, and `E_aa`. -/
noncomputable def e : S2Idx n → Matrix (Fin n) (Fin n) ℝ
  | Sum.inl p => (Real.sqrt 2) • symB p.1.1 p.1.2
  | Sum.inr a => symB a a

theorem symB_symm (a b : Fin n) : symB b a = symB a b := by
  unfold symB; rw [add_comm]

theorem symB_apply (a b i j : Fin n) :
    symB a b i j = (1 / 2) * ((if a = i ∧ b = j then 1 else 0) + (if b = i ∧ a = j then 1 else 0)) := by
  unfold symB; simp [Matrix.single_apply]

/-- `⟨h, s_ab⟩ = h_ab` at a symmetric `h`. -/
theorem frob_symB (h : Matrix (Fin n) (Fin n) ℝ) (hh : h.IsSymm) (a b : Fin n) :
    frob h (symB a b) = h a b := by
  have hba : h b a = h a b := by
    have := congrFun (congrFun hh a) b; simpa [Matrix.transpose_apply] using this
  unfold frob
  simp only [symB_apply, mul_add, Finset.sum_add_distrib, ite_and, mul_ite, mul_one, mul_zero]
  simp [Finset.sum_ite_eq, Finset.sum_ite_eq', ← Finset.sum_add_distrib]
  rw [hba]; ring

/-- **A symmetric matrix expands in the basis `e`**: `h = ∑_u ⟨h, e_u⟩ e_u`. -/
theorem expand_sym (h : Matrix (Fin n) (Fin n) ℝ) (hh : h.IsSymm) :
    ∑ u : S2Idx n, frob h (e u) • e u = h := by
  have hsq : Real.sqrt 2 * Real.sqrt 2 = 2 := Real.mul_self_sqrt (by norm_num)
  have hfs : ∀ (c : ℝ) (X Y : Matrix (Fin n) (Fin n) ℝ), frob X (c • Y) = c * frob X Y := by
    intro c X Y; unfold frob; rw [Finset.mul_sum]
    refine Finset.sum_congr rfl fun i _ => ?_
    rw [Finset.mul_sum]; refine Finset.sum_congr rfl fun j _ => ?_
    simp only [Matrix.smul_apply, smul_eq_mul]; ring
  ext i j
  rw [Fintype.sum_sum_type, Matrix.add_apply, Matrix.sum_apply, Matrix.sum_apply]
  simp only [e, Matrix.smul_apply, smul_eq_mul, hfs, frob_symB h hh]
  have hba : ∀ a b, h b a = h a b := fun a b => by
    have := congrFun (congrFun hh a) b; simpa [Matrix.transpose_apply] using this
  have key := sum_pairs_diag (fun a b => h a b * symB a b i j)
    (fun a b => by rw [hba a b, symB_symm])
  have hall : ∑ a, ∑ b, h a b * symB a b i j = h i j := by
    simp only [symB_apply, mul_add, Finset.sum_add_distrib, ite_and, mul_ite, mul_one, mul_zero]
    simp [Finset.sum_ite_eq, Finset.sum_ite_eq', ← Finset.sum_add_distrib]
    rw [hba i j]; ring
  rw [hall] at key
  rw [key]
  congr 1
  rw [Finset.mul_sum]
  exact Finset.sum_congr rfl fun p _ => by
    rw [show Real.sqrt 2 * h (↑p : Fin n × Fin n).1 (↑p : Fin n × Fin n).2
        * (Real.sqrt 2 * symB (↑p : Fin n × Fin n).1 (↑p : Fin n × Fin n).2 i j)
        = (Real.sqrt 2 * Real.sqrt 2) * (h (↑p : Fin n × Fin n).1 (↑p : Fin n × Fin n).2
          * symB (↑p : Fin n × Fin n).1 (↑p : Fin n × Fin n).2 i j) by ring, hsq]

theorem symB_isSymm (a b : Fin n) : (symB a b).IsSymm := by
  unfold Matrix.IsSymm symB
  rw [Matrix.transpose_smul, Matrix.transpose_add, Matrix.transpose_single, Matrix.transpose_single,
    add_comm]

theorem e_isSymm (u : S2Idx n) : (e u).IsSymm := by
  cases u with
  | inl p => exact (symB_isSymm _ _).smul _
  | inr a => exact symB_isSymm a a

theorem frob_smul_left (c : ℝ) (X Y : Matrix (Fin n) (Fin n) ℝ) : frob (c • X) Y = c * frob X Y := by
  unfold frob; rw [Finset.mul_sum]
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [Finset.mul_sum]; refine Finset.sum_congr rfl fun j _ => ?_
  simp only [Matrix.smul_apply, smul_eq_mul]; ring

theorem frob_sum_left {κ : Type*} (s : Finset κ) (X : κ → Matrix (Fin n) (Fin n) ℝ)
    (Y : Matrix (Fin n) (Fin n) ℝ) : frob (∑ k ∈ s, X k) Y = ∑ k ∈ s, frob (X k) Y := by
  unfold frob
  simp only [Matrix.sum_apply, Finset.sum_mul]
  rw [Finset.sum_congr rfl fun x _ => Finset.sum_comm]
  exact Finset.sum_comm

/-- `W̊` is linear. -/
theorem ringW_sum_smul (R : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ) {κ : Type*}
    (s : Finset κ) (c : κ → ℝ) (X : κ → Matrix (Fin n) (Fin n) ℝ) :
    ringW R (∑ k ∈ s, c k • X k) = ∑ k ∈ s, c k • ringW R (X k) := by
  ext i j
  simp only [ringW, Matrix.sum_apply, Matrix.smul_apply, smul_eq_mul, Finset.mul_sum]
  rw [Finset.sum_congr rfl fun x _ => Finset.sum_comm, Finset.sum_comm]
  refine Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun x _ =>
    Finset.sum_congr rfl fun y _ => ?_
  ring

/-- **`e` is orthonormal** for the Frobenius pairing. -/
theorem frob_e (u v : S2Idx n) : frob (e u) (e v) = if u = v then 1 else 0 := by
  have hsq : Real.sqrt 2 * Real.sqrt 2 = 2 := Real.mul_self_sqrt (by norm_num)
  have hfs : ∀ (c : ℝ) (X Y : Matrix (Fin n) (Fin n) ℝ), frob X (c • Y) = c * frob X Y := by
    intro c X Y; unfold frob; rw [Finset.mul_sum]
    refine Finset.sum_congr rfl fun i _ => ?_
    rw [Finset.mul_sum]; refine Finset.sum_congr rfl fun j _ => ?_
    simp only [Matrix.smul_apply, smul_eq_mul]; ring
  have hsmulA : ∀ (c : ℝ) (X : Matrix (Fin n) (Fin n) ℝ) i j, (c • X) i j = c * X i j := fun _ _ _ _ => rfl
  cases v with
  | inl q =>
    show frob (e u) ((Real.sqrt 2) • symB q.1.1 q.1.2) = _
    rw [hfs, frob_symB _ (e_isSymm u)]
    cases u with
    | inl p =>
      simp only [e, hsmulA, symB_apply]
      have hq := q.2; have hp := p.2
      by_cases hpq : p = q
      · subst hpq
        have hne : ¬(p.1.2 = p.1.1 ∧ p.1.1 = p.1.2) := fun h => absurd (h.2 ▸ hp) (lt_irrefl _)
        simp only [and_self, if_true, if_neg hne]
        rw [← mul_assoc, hsq]; norm_num
      · have h1 : ¬(p.1.1 = q.1.1 ∧ p.1.2 = q.1.2) := fun h => hpq (Subtype.ext (Prod.ext h.1 h.2))
        have h2 : ¬(p.1.2 = q.1.1 ∧ p.1.1 = q.1.2) := fun h => by
          have := h.1 ▸ h.2 ▸ hp; exact absurd (lt_trans hq this) (lt_irrefl _)
        rw [if_neg h1, if_neg h2, if_neg (fun h => hpq (Sum.inl_injective h))]; ring
    | inr a =>
      simp only [e, symB_apply]
      have hq := q.2
      have h1 : ¬(a = q.1.1 ∧ a = q.1.2) := fun h => absurd (h.1 ▸ h.2 ▸ hq) (lt_irrefl _)
      simpa using fun h h' => h1 ⟨h, h'⟩
  | inr b =>
    show frob (e u) (symB b b) = _
    rw [frob_symB _ (e_isSymm u)]
    cases u with
    | inl p =>
      simp only [e, hsmulA, symB_apply]
      have hp := p.2
      have h1 : ¬(p.1.1 = b ∧ p.1.2 = b) := fun h => absurd (h.1 ▸ h.2 ▸ hp) (lt_irrefl _)
      have h2 : ¬(p.1.2 = b ∧ p.1.1 = b) := fun h => h1 ⟨h.2, h.1⟩
      rw [if_neg h1, if_neg h2]; simp
    | inr a =>
      simp only [e, symB_apply]
      by_cases hab : a = b
      · subst hab; simp; norm_num
      · have : ¬(a = b ∧ a = b) := fun h => hab h.1
        simp [hab]

/-- **A map on matrices, as a matrix in the basis `e`**: `Bmat L u v = ⟨L e_u, e_v⟩`. -/
noncomputable def Bmat (L : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ) :
    Matrix (S2Idx n) (S2Idx n) ℝ :=
  fun u v => frob (L (e u)) (e v)

section W

variable (R : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ) (hR : IsLinOp R)
    (hskew : ∀ X, IsSkew X → IsSkew (R X))
    (hsym : ∀ X Y, IsSkew X → IsSkew Y → inner2 (R X) Y = inner2 X (R Y))
/-- **Composition is matrix product**: `Bmat (W̊ ∘ L') = Bmat L' * Bmat W̊` when `L'` maps the
basis to symmetric matrices. -/
theorem Bmat_comp (L' : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ)
    (hL' : ∀ u, (L' (e u)).IsSymm) :
    Bmat (fun h => ringW R (L' h)) = Bmat L' * Bmat (ringW R) := by
  ext u v
  simp only [Bmat, Matrix.mul_apply]
  conv_lhs => rw [← expand_sym (L' (e u)) (hL' u), ringW_sum_smul, frob_sum_left]
  exact Finset.sum_congr rfl fun w _ => by rw [frob_smul_left]

/-- **The trace of `Bmat` is `trS2`** for a homogeneous map sending each `symB a b` to a
symmetric matrix. -/
theorem trace_Bmat (L : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ)
    (hLs : ∀ a b, (L (symB a b)).IsSymm) (hL : ∀ (c : ℝ) X, L (c • X) = c • L X) :
    (Bmat L).trace = trS2 L := by
  have hsq : Real.sqrt 2 * Real.sqrt 2 = 2 := Real.mul_self_sqrt (by norm_num)
  have hfs : ∀ (c : ℝ) (X Y : Matrix (Fin n) (Fin n) ℝ), frob X (c • Y) = c * frob X Y := by
    intro c X Y; unfold frob; rw [Finset.mul_sum]
    refine Finset.sum_congr rfl fun i _ => ?_
    rw [Finset.mul_sum]; refine Finset.sum_congr rfl fun j _ => ?_
    simp only [Matrix.smul_apply, smul_eq_mul]; ring
  have key := sum_pairs_diag (fun a b => frob (L (symB a b)) (symB a b))
    (fun a b => by rw [symB_symm])
  have hts : trS2 L = ∑ a, ∑ b, frob (L (symB a b)) (symB a b) := by
    unfold trS2
    exact Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ =>
      (frob_symB _ (hLs a b) a b).symm
  rw [hts, key, Matrix.trace, Fintype.sum_sum_type]
  simp only [Matrix.diag, Bmat, e, hL, frob_smul_left, hfs]
  congr 1
  rw [Finset.mul_sum]
  exact Finset.sum_congr rfl fun p _ => by rw [← mul_assoc, hsq]

theorem ringW_smul (c : ℝ) (X : Matrix (Fin n) (Fin n) ℝ) : ringW R (c • X) = c • ringW R X := by
  ext i j
  simp only [ringW, Matrix.smul_apply, smul_eq_mul, Finset.mul_sum]
  exact Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ => by ring

include hR hskew hsym

theorem ringW_isSymm_of (X : Matrix (Fin n) (Fin n) ℝ) (hX : X.IsSymm) : (ringW R X).IsSymm :=
  ringW_symm R hR hskew hsym X hX

/-- **`W̊` on `S²` is a real symmetric matrix.** -/
theorem Bmat_isHermitian : (Bmat (ringW R)).IsHermitian := by
  ext u v
  simp only [Matrix.conjTranspose_apply, star_trivial, Bmat]
  rw [ringW_selfAdjoint R hR hskew hsym]
  unfold frob
  exact Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => mul_comm _ _

theorem Bmat_sq : Bmat (ringW R) ^ 2 = Bmat (fun h => ringW R (ringW R h)) := by
  rw [pow_two, Bmat_comp R (ringW R) fun u => ringW_isSymm_of R hR hskew hsym _ (e_isSymm u)]

theorem Bmat_cube : Bmat (ringW R) ^ 3 = Bmat (fun h => ringW R (ringW R (ringW R h))) := by
  rw [pow_succ, Bmat_sq R hR hskew hsym,
    Bmat_comp R (fun h => ringW R (ringW R h)) fun u =>
      ringW_isSymm_of R hR hskew hsym _ (ringW_isSymm_of R hR hskew hsym _ (e_isSymm u))]

/-- **`∑ ω³ = tr_{S²} W̊³`** for `ω` the spectrum of `W̊` on `S²`. -/
theorem sum_omega_cube :
    ∑ j, (Bmat_isHermitian R hR hskew hsym).eigenvalues j ^ 3
      = trS2 (fun h => ringW R (ringW R (ringW R h))) := by
  rw [← trace_pow_eq_sum_eigenvalues, Bmat_cube R hR hskew hsym]
  refine trace_Bmat _ (fun a b => ?_) (fun c X => by rw [ringW_smul, ringW_smul, ringW_smul])
  exact ringW_isSymm_of R hR hskew hsym _ (ringW_isSymm_of R hR hskew hsym _
    (ringW_isSymm_of R hR hskew hsym _ (symB_isSymm a b)))

/-- **`∑ ω² = tr_{S²} W̊² = 3‖R‖²`**, so `∑ ω² = 3` at unit norm. -/
theorem sum_omega_sq (hB : ∀ i j k l, bianchi R i j k l = 0) :
    ∑ j, (Bmat_isHermitian R hR hskew hsym).eigenvalues j ^ 2 = 3 * normSq R := by
  rw [← trace_pow_eq_sum_eigenvalues, Bmat_sq R hR hskew hsym, ← L50Spectra.L50_norm R hR hskew hsym hB]
  refine trace_Bmat _ (fun a b => ?_) (fun c X => by rw [ringW_smul, ringW_smul])
  exact ringW_isSymm_of R hR hskew hsym _ (ringW_isSymm_of R hR hskew hsym _ (symB_isSymm a b))

/-- **L50, SPECTRAL ON BOTH SIDES**: `P = (3/2) ∑ μ³ − (1/2) ∑ ω³`, `μ` the spectrum of `M` on
`Λ²` and `ω` that of `W̊` on `S²`, with `∑ μ² = ‖R‖²` and `∑ ω² = 3‖R‖²`. -/
theorem L50_spectral (hB : ∀ i j k l, bianchi R i j k l = 0) :
    Pcubic R = (3 / 2) * ∑ j, (Mpair_isHermitian R hR hskew hsym).eigenvalues j ^ 3
      - (1 / 2) * ∑ j, (Bmat_isHermitian R hR hskew hsym).eigenvalues j ^ 3 := by
  rw [sum_omega_cube R hR hskew hsym]
  exact L50_mu_spectral R hR hskew hsym hB

end W

end HamiltonsCubic.SecondKind
