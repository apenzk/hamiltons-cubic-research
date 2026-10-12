import HamiltonsCubic.Results.L50Converse

set_option linter.style.longLine false

/-!
# L67 at the operator: `W̊` of a two-block diagonal Weyl tensor has the three eigenvalues

[findings/bispectral.md](../../../findings/bispectral.md), Lemma L67: at `S^m × S^m`, `W̊` on `S²₀` has exactly the
eigenvalues `mA` on the within-factor trace-free parts, `-(m-1)A` on the cross block and `-2m(m-1)A` on the line
`P₁ - P₂`. [L67Statement.lean](L67Statement.lean) proves the arithmetic of that list. **This file proves that the list
is the spectrum of `ringW`**, Li's `iklj` second-kind operator, on any coordinate-diagonal operator whose weight is
constant on the two blocks of a split `ι = S ⊔ Sᶜ`:

* **`ringW_diagOp`**: `(W̊h)_{ij} = w_{ij} h_{ji} - δ_{ij} Σ_k w_{ik} h_{kk}` for `W = diagOp w`;
* **`eig_within`**, **`eig_cross`**, **`eig_line`**: with `w = α` within a block and `β` across, `W̊` acts by `α` on a
  symmetric `h` supported in one block with zero trace there, by `β` on a symmetric `h` supported across, and by
  `mβ - (m-1)α` on `P_S - P_{Sᶜ}` when both blocks have `m` elements;
* **`decomp`**: every trace-free symmetric `h` is the sum of one of each, so these are the only eigenvalues;
* **`L67_values`**: at `α = mA`, `β = -(m-1)A` the three values are `mA`, `-(m-1)A`, `-2m(m-1)A`;
* **`sphereWeight_blocks`**, **`sphere_blocks_record`**: with `|S| = |Sᶜ| = m`, `t · sphereWeight S` is two-block with
  values `mA` and `-(m-1)A` at `A = t/(m-1)`.

The unit-norm Weyl tensor of `S^m × S^m` is `diagOp (t · sphereWeight S)` ([L2SphereWeyl.lean](L2SphereWeyl.lean)'s
`sphereProduct_weylPart`), whose block values are `tm/(m-1)` and `-t`, of this form with `A = t/(m-1)`; the
normalisation `Σω² = 3` fixing `A` is L67Statement's `spec_normalisation`.
-/

namespace HamiltonsCubic.SecondKind

open Finset HamiltonsCubic.RealLayer HamiltonsCubic.Results HamiltonsCubic.FamilyLayer

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **`W̊` of a diagonal operator.** -/
theorem ringW_diagOp (w : Matrix ι ι ℝ) (hw : ∀ a b, w a b = w b a) (h : Matrix ι ι ℝ) (i j : ι) :
    ringW (diagOp w) h i j = w i j * h j i - (if i = j then ∑ k, w i k * h k k else 0) := by
  unfold ringW
  simp only [R4_diagOp w hw, ite_and, mul_sub, sub_mul, mul_ite, ite_mul, mul_one, mul_zero, zero_mul,
    Finset.sum_sub_distrib]
  simp [Finset.sum_ite_irrel, Finset.sum_ite_eq, Finset.sum_ite_eq']

/-- The line `P_S - P_{Sᶜ}`. -/
def line (S : Finset ι) : Matrix ι ι ℝ := Matrix.diagonal fun k => if k ∈ S then 1 else -1

omit [Fintype ι] in
theorem line_apply (S : Finset ι) (i j : ι) : line S i j = if i = j then (if i ∈ S then 1 else -1) else 0 := by
  simp [line, Matrix.diagonal_apply]

theorem sum_split (S : Finset ι) (f : ι → ℝ) :
    ∑ k, f k = ∑ k ∈ S, f k + ∑ k ∈ Sᶜ, f k := by
  rw [← Finset.sum_add_sum_compl S f]

/-- **The three summands fill `S²₀`**: a trace-free symmetric `h` is a within-`S` part, a within-`Sᶜ` part, a cross
part and a multiple of the line, each of the shape `eig_within`, `eig_cross` and `eig_line` take. -/
theorem decomp (S : Finset ι) (m : ℕ) (hm : 0 < m) (hS : S.card = m) (hSc : Sᶜ.card = m)
    (h : Matrix ι ι ℝ) (hs : ∀ i j, h i j = h j i) (htr : ∑ k, h k k = 0) :
    ∃ (hA hB hX : Matrix ι ι ℝ) (c : ℝ), h = hA + hB + hX + c • line S ∧
      (∀ i j, hA i j = hA j i) ∧ (∀ i j, hA i j ≠ 0 → i ∈ S ∧ j ∈ S) ∧ ∑ k, hA k k = 0 ∧
      (∀ i j, hB i j = hB j i) ∧ (∀ i j, hB i j ≠ 0 → i ∈ Sᶜ ∧ j ∈ Sᶜ) ∧ ∑ k, hB k k = 0 ∧
      (∀ i j, hX i j = hX j i) ∧ (∀ i j, hX i j ≠ 0 → ¬(i ∈ S ↔ j ∈ S)) := by
  set c : ℝ := (∑ k ∈ S, h k k) / m with hc
  have hmR : (m : ℝ) ≠ 0 := by exact_mod_cast hm.ne'
  refine ⟨Matrix.of fun i j => if i ∈ S ∧ j ∈ S then h i j - (if i = j then c else 0) else 0,
    Matrix.of fun i j => if i ∉ S ∧ j ∉ S then h i j + (if i = j then c else 0) else 0,
    Matrix.of fun i j => if (i ∈ S ↔ j ∈ S) then 0 else h i j, c, ?_, ?_, ?_, ?_, ?_, ?_, ?_, ?_, ?_⟩
  · ext i j
    simp only [Matrix.add_apply, Matrix.smul_apply, smul_eq_mul, line_apply, Matrix.of_apply]
    by_cases hi : i ∈ S <;> by_cases hj : j ∈ S <;> by_cases hij : i = j <;> simp_all
  · intro i j; simp only [Matrix.of_apply]; by_cases hij : i = j
    · subst hij; rfl
    · simp only [if_neg hij, if_neg (Ne.symm hij), hs i j, and_comm]
  · intro i j hne; by_contra hn; exact hne (by simp only [Matrix.of_apply]; exact if_neg hn)
  · have e : ∀ k, (Matrix.of fun i j => if i ∈ S ∧ j ∈ S then h i j - (if i = j then c else 0) else 0) k k
        = if k ∈ S then h k k - c else 0 := fun k => by simp
    rw [Finset.sum_congr rfl (fun k _ => e k), Fintype.sum_ite_mem, Finset.sum_sub_distrib, Finset.sum_const, hS,
      nsmul_eq_mul, hc]
    field_simp; ring
  · intro i j; simp only [Matrix.of_apply]; by_cases hij : i = j
    · subst hij; rfl
    · simp only [if_neg hij, if_neg (Ne.symm hij), hs i j, and_comm]
  · intro i j hne; by_contra hn
    exact hne (by simp only [Matrix.of_apply]; exact if_neg (by simpa [Finset.mem_compl] using hn))
  · have e : ∀ k, (Matrix.of fun i j => if i ∉ S ∧ j ∉ S then h i j + (if i = j then c else 0) else 0) k k
        = if k ∈ Sᶜ then h k k + c else 0 := fun k => by simp [Finset.mem_compl]
    rw [Finset.sum_congr rfl (fun k _ => e k), Fintype.sum_ite_mem, Finset.sum_add_distrib, Finset.sum_const, hSc,
      nsmul_eq_mul, hc]
    have hsplit := sum_split S (fun k => h k k)
    rw [htr] at hsplit
    field_simp; linarith
  · intro i j; simp only [Matrix.of_apply, hs i j]; by_cases h1 : (i ∈ S ↔ j ∈ S)
    · rw [if_pos h1, if_pos h1.symm]
    · rw [if_neg h1, if_neg (fun h => h1 h.symm)]
  · intro i j hne hij; exact hne (by simp only [Matrix.of_apply]; exact if_pos hij)

/-- **`sphereWeight S` is two-block** with within value `m/(m-1)` and cross value `-1` when `|S| = |Sᶜ| = m`. -/
theorem sphereWeight_blocks (S : Finset ι) (m : ℕ) (hS : S.card = m) (hSc : Sᶜ.card = m) (a b : ι) (hab : a ≠ b) :
    sphereWeight S a b = if (a ∈ S ↔ b ∈ S) then (m : ℝ) / ((m : ℝ) - 1) else -1 := by
  simp only [sphereWeight, Matrix.of_apply, if_neg hab, hS, hSc]
  by_cases ha : a ∈ S <;> by_cases hb : b ∈ S <;> simp [ha, hb]

/-- **The record's values at the unit Weyl tensor of `S^m × S^m`**: `t · sphereWeight S` has block values `mA` and
`-(m-1)A` with `A = t/(m-1)`. -/
theorem sphere_blocks_record (S : Finset ι) (m : ℕ) (hm : 2 ≤ m) (hS : S.card = m) (hSc : Sᶜ.card = m) (t : ℝ)
    (a b : ι) (hab : a ≠ b) :
    (t • sphereWeight S) a b
      = if (a ∈ S ↔ b ∈ S) then (m : ℝ) * (t / ((m : ℝ) - 1)) else -((m : ℝ) - 1) * (t / ((m : ℝ) - 1)) := by
  have hm1 : (m : ℝ) - 1 ≠ 0 := by
    have : (2 : ℝ) ≤ m := by exact_mod_cast hm
    linarith
  rw [Matrix.smul_apply, sphereWeight_blocks S m hS hSc a b hab, smul_eq_mul]
  split_ifs <;> field_simp

section Blocks

variable (S : Finset ι) (w : Matrix ι ι ℝ) (α β : ℝ) (hw : ∀ a b, w a b = w b a) (hh : ∀ a, w a a = 0)
    (hwv : ∀ a b, a ≠ b → w a b = if (a ∈ S ↔ b ∈ S) then α else β)
include hw hh hwv

/-- **Within a block**: a symmetric `h` supported in `S × S` with zero trace is an `α`-eigenvector. -/
theorem eig_within (h : Matrix ι ι ℝ) (hs : ∀ i j, h i j = h j i) (hsupp : ∀ i j, h i j ≠ 0 → i ∈ S ∧ j ∈ S)
    (htr : ∑ k, h k k = 0) : ringW (diagOp w) h = α • h := by
  have hz : ∀ i j, ¬(i ∈ S ∧ j ∈ S) → h i j = 0 := fun i j hij => by
    by_contra hne; exact hij (hsupp i j hne)
  ext i j
  rw [ringW_diagOp w hw, Matrix.smul_apply, smul_eq_mul]
  by_cases hij : i = j
  · subst hij
    rw [if_pos rfl, hh, zero_mul, zero_sub]
    by_cases hi : i ∈ S
    · have e : ∀ k, w i k * h k k = α * h k k - (if k = i then α * h k k else 0) := fun k => by
        by_cases hk : k = i
        · subst hk; simp [hh]
        · rw [if_neg hk, hwv i k (Ne.symm hk)]
          by_cases hkS : k ∈ S
          · simp [hi, hkS]
          · simp [hz k k (fun h => hkS h.1)]
      rw [Finset.sum_congr rfl (fun k _ => e k), Finset.sum_sub_distrib, ← Finset.mul_sum, htr,
        Finset.sum_ite_eq']
      simp
    · have e : ∀ k, w i k * h k k = β * h k k := fun k => by
        by_cases hkS : k ∈ S
        · have hki : k ≠ i := fun h => hi (h ▸ hkS)
          rw [hwv i k (Ne.symm hki), if_neg (by tauto)]
        · simp [hz k k (fun h => hkS h.1)]
      rw [Finset.sum_congr rfl (fun k _ => e k), ← Finset.mul_sum, htr, hz i i (fun h => hi h.1)]; ring
  · rw [if_neg hij, sub_zero, hs j i]
    by_cases hS : i ∈ S ∧ j ∈ S
    · rw [hwv i j hij, if_pos (by tauto)]
    · rw [hz i j hS]; ring

omit hh in
/-- **Across the blocks**: a symmetric `h` supported where exactly one index is in `S` is a `β`-eigenvector. -/
theorem eig_cross (h : Matrix ι ι ℝ) (hs : ∀ i j, h i j = h j i) (hsupp : ∀ i j, h i j ≠ 0 → ¬(i ∈ S ↔ j ∈ S)) :
    ringW (diagOp w) h = β • h := by
  have hz : ∀ i j, (i ∈ S ↔ j ∈ S) → h i j = 0 := fun i j hij => by
    by_contra hne; exact hsupp i j hne hij
  ext i j
  rw [ringW_diagOp w hw, Matrix.smul_apply, smul_eq_mul]
  by_cases hij : i = j
  · subst hij
    have : ∀ k, w i k * h k k = 0 := fun k => by rw [hz k k Iff.rfl, mul_zero]
    rw [if_pos rfl, Finset.sum_congr rfl (fun k _ => this k), Finset.sum_const_zero, hz i i Iff.rfl]; ring
  · rw [if_neg hij, sub_zero, hs j i]
    by_cases hS : (i ∈ S ↔ j ∈ S)
    · rw [hz i j hS]; ring
    · rw [hwv i j hij, if_neg hS]

/-- **The line**: with `|S| = |Sᶜ| = m`, `P_S - P_{Sᶜ}` is an eigenvector with eigenvalue `mβ - (m-1)α`. -/
theorem eig_line (m : ℕ) (hS : S.card = m) (hSc : Sᶜ.card = m) :
    ringW (diagOp w) (line S) = ((m : ℝ) * β - ((m : ℝ) - 1) * α) • line S := by
  -- `Σ_k w_ik L_kk = Σ_{k ∈ S} w_ik - Σ_{k ∉ S} w_ik`
  have hsum : ∀ i, ∑ k, w i k * line S k k = (if i ∈ S then ((m : ℝ) - 1) * α - m * β else m * β - ((m : ℝ) - 1) * α) := by
    intro i
    have e : ∀ k, w i k * line S k k = (if k ∈ S then w i k else 0) - (if k ∈ Sᶜ then w i k else 0) := fun k => by
      rw [line_apply, if_pos rfl]; by_cases hk : k ∈ S <;> simp [hk]
    rw [Finset.sum_congr rfl (fun k _ => e k), Finset.sum_sub_distrib, Fintype.sum_ite_mem, Fintype.sum_ite_mem]
    have hin : ∀ T : Finset ι, (∀ k ∈ T, k ≠ i → w i k = (if (i ∈ S ↔ k ∈ S) then α else β)) →
        ∑ k ∈ T, w i k = ∑ k ∈ T, (if k = i then 0 else if (i ∈ S ↔ k ∈ S) then α else β) := fun T hT =>
      Finset.sum_congr rfl fun k hk => by
        by_cases hki : k = i
        · subst hki; simp [hh]
        · rw [if_neg hki, hT k hk hki]
    rw [hin S (fun k _ hki => hwv i k (Ne.symm hki)), hin Sᶜ (fun k _ hki => hwv i k (Ne.symm hki))]
    by_cases hi : i ∈ S
    · have h1 : ∑ k ∈ S, (if k = i then (0 : ℝ) else if (i ∈ S ↔ k ∈ S) then α else β)
          = ∑ k ∈ S, α - α := by
        rw [← Finset.add_sum_erase S _ hi, ← Finset.add_sum_erase S (fun _ => α) hi]
        rw [Finset.sum_congr rfl (fun k hk => by
          rw [if_neg (Finset.ne_of_mem_erase hk), if_pos (by simp [hi, Finset.mem_of_mem_erase hk])])]
        simp
      have h2 : ∑ k ∈ Sᶜ, (if k = i then (0 : ℝ) else if (i ∈ S ↔ k ∈ S) then α else β) = ∑ k ∈ Sᶜ, β :=
        Finset.sum_congr rfl fun k hk => by
          have hkS : k ∉ S := Finset.mem_compl.mp hk
          rw [if_neg (by rintro rfl; exact hkS hi), if_neg (by tauto)]
      rw [h1, h2, Finset.sum_const, Finset.sum_const, hS, hSc, if_pos hi]; simp; ring
    · have h1 : ∑ k ∈ S, (if k = i then (0 : ℝ) else if (i ∈ S ↔ k ∈ S) then α else β) = ∑ k ∈ S, β :=
        Finset.sum_congr rfl fun k hk => by
          rw [if_neg (by rintro rfl; exact hi hk), if_neg (by tauto)]
      have hic : i ∈ Sᶜ := Finset.mem_compl.mpr hi
      have h2 : ∑ k ∈ Sᶜ, (if k = i then (0 : ℝ) else if (i ∈ S ↔ k ∈ S) then α else β)
          = ∑ k ∈ Sᶜ, α - α := by
        rw [← Finset.add_sum_erase Sᶜ _ hic, ← Finset.add_sum_erase Sᶜ (fun _ => α) hic]
        rw [Finset.sum_congr rfl (fun k hk => by
          have hkS : k ∉ S := Finset.mem_compl.mp (Finset.mem_of_mem_erase hk)
          rw [if_neg (Finset.ne_of_mem_erase hk), if_pos (by tauto)])]
        simp
      rw [h1, h2, Finset.sum_const, Finset.sum_const, hS, hSc, if_neg hi]; simp; ring
  ext i j
  rw [ringW_diagOp w hw, Matrix.smul_apply, smul_eq_mul]
  by_cases hij : i = j
  · subst hij
    rw [if_pos rfl, hsum i, line_apply, if_pos rfl, hh, zero_mul, zero_sub]
    split_ifs <;> ring
  · rw [if_neg hij, sub_zero, line_apply, line_apply, if_neg (Ne.symm hij), if_neg hij]; ring

omit hw hh hwv in
/-- **The three values at the record's block weights** `α = mA`, `β = -(m-1)A`. -/
theorem L67_values (m A : ℝ) :
    m * (-(m - 1) * A) - (m - 1) * (m * A) = -2 * m * (m - 1) * A := by ring

end Blocks

end HamiltonsCubic.SecondKind
