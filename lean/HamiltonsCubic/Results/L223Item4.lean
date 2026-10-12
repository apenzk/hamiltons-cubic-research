import HamiltonsCubic.Results.L223Items

set_option linter.style.longLine false

/-!
# L223, item 4: a near-critical diagonal tensor of value near `Θ̄` lies near a sphere product

[findings/problem.md](../../../findings/problem.md), Lemma L223 (4): *if `4√(n−2)√(Δ/Θ̄) < 2(1 − Δ/Θ̄)`, then
`p, q ≥ 2` and `|S − B| ≤ (√2 + 4√(n−2)/(1 − Δ/Θ̄))√(Δ/Θ̄)`, where `B` is the unit positive multiple of the
projection of `(w_i w_j)` onto `𝒟ₙ`, constant on the three classes of pairs of the sign partition and a positive
multiple of the vertex matrix of `S^p × S^q`.*

- `projD`: **the orthogonal projection onto `𝒟ₙ`**, a weight (`projD_isWeight`) with residual orthogonal to
  every weight (`projD_orth`), linear (`projD_sub`) and so non-expansive (`projD_nonexp`);
- `projD_outer`: **`Π(v vᵀ) = Z(v)`** at `∑ v = 0`, `∑ v² = 1`, and `outer_dist`: `|v vᵀ − w wᵀ| ≤ ‖v − w‖`;
- `projD_sign`, `projD_sign_sphere`, `projD_sign_zero`: **at the sign vector of a split, `Π(w wᵀ)` is
  `4(p−1)(q−1)/(n(n−1)(n−2))` times `sphereWeight`**, zero when a class has at most one element;
- `ipU`, `nrmU`, `nrmU_add_le`, `nrmU_normalize`: the pairing and norm over unordered pairs, the triangle
  inequality, and `|f/|f| − g/|g|| ≤ 2|f − g|/|f|`;
- `L223_item4`: **item 4 as stated.**
-/

namespace HamiltonsCubic.L57Critical

open Finset Matrix HamiltonsCubic.FamilyLayer

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **The orthogonal projection onto `𝒟ₙ`** of a hollow symmetric array, with `r_a` its row sums and
`T = ∑ r_a`: `Π(X)_ab = X_ab − (r_a + r_b)/(n−2) + T/((n−1)(n−2))` off the diagonal. -/
noncomputable def projD (X : ι → ι → ℝ) (a b : ι) : ℝ :=
  if a = b then 0 else
    X a b - ((∑ c, X a c) + (∑ c, X b c)) / ((Fintype.card ι : ℝ) - 2)
      + (∑ c, ∑ d, X c d) / (((Fintype.card ι : ℝ) - 1) * ((Fintype.card ι : ℝ) - 2))

theorem projD_isWeight (hn : 4 ≤ Fintype.card ι) (X : ι → ι → ℝ) (hsym : ∀ a b, X a b = X b a)
    (hhol : ∀ a, X a a = 0) : IsWeight (Matrix.of (projD X)) where
  symm a b := by
    simp only [Matrix.of_apply, projD]
    by_cases h : a = b
    · subst h; rfl
    · rw [if_neg h, if_neg (Ne.symm h), hsym a b]; ring
  hollow a := by simp [projD]
  rowSum a := by
    set n : ℝ := (Fintype.card ι : ℝ) with hndef
    have hn4 : (4 : ℝ) ≤ n := by rw [hndef]; exact_mod_cast hn
    have hn2 : n - 2 ≠ 0 := by linarith
    have hn1 : n - 1 ≠ 0 := by linarith
    simp only [Matrix.of_apply, projD]
    rw [← Finset.add_sum_erase _ _ (Finset.mem_univ a), if_pos rfl, zero_add]
    rw [Finset.sum_congr rfl fun b hb => if_neg (Ne.symm (Finset.ne_of_mem_erase hb))]
    simp only [Finset.sum_add_distrib, Finset.sum_sub_distrib, ← Finset.sum_div, Finset.sum_const,
      Finset.card_erase_of_mem (Finset.mem_univ a), Finset.card_univ, nsmul_eq_mul]
    have hr : ∑ b ∈ univ.erase a, X a b = ∑ c, X a c := by
      rw [← Finset.add_sum_erase _ _ (Finset.mem_univ a), hhol a, zero_add]
    have hT : ∑ b ∈ univ.erase a, ∑ c, X b c = ∑ c, ∑ d, X c d - ∑ c, X a c := by
      rw [← Finset.add_sum_erase _ _ (Finset.mem_univ a)]; ring
    rw [hr, hT]
    rw [← hndef]
    have hc : ((Fintype.card ι - 1 : ℕ) : ℝ) = n - 1 := by
      rw [hndef, Nat.cast_sub (by omega)]; simp
    rw [hc]
    field_simp; ring

/-- **The residual is orthogonal to `𝒟ₙ`**: `∑ (X − Π X)_ab Y_ab = 0` for every weight `Y`. -/
theorem projD_orth (X : ι → ι → ℝ) (hhol : ∀ a, X a a = 0) {Y : Matrix ι ι ℝ} (hY : IsWeight Y) :
    ∑ a, ∑ b, (X a b - projD X a b) * Y a b = 0 := by
  set f : ι → ℝ := fun a => (∑ c, X a c) / ((Fintype.card ι : ℝ) - 2) with hf
  set K : ℝ := (∑ c, ∑ d, X c d) / (((Fintype.card ι : ℝ) - 1) * ((Fintype.card ι : ℝ) - 2)) with hK
  have e : ∀ a b, (X a b - projD X a b) * Y a b = f a * Y a b + f b * Y a b - K * Y a b := by
    intro a b
    simp only [projD, hf, hK]
    split_ifs with h
    · subst h; rw [hhol a, hY.hollow a]; ring
    · ring
  have hrow : ∀ a, ∑ b, Y a b = 0 := hY.rowSum
  have hcol : ∀ b, ∑ a, Y a b = 0 := fun b => by simp only [hY.symm _ b]; exact hY.rowSum b
  have t1 : ∑ a, ∑ b, f a * Y a b = 0 :=
    Finset.sum_eq_zero fun a _ => by rw [← Finset.mul_sum, hrow a, mul_zero]
  have t2 : ∑ a, ∑ b, f b * Y a b = 0 := by
    rw [Finset.sum_comm]; exact Finset.sum_eq_zero fun b _ => by rw [← Finset.mul_sum, hcol b, mul_zero]
  have t3 : ∑ a, ∑ b, K * Y a b = 0 :=
    Finset.sum_eq_zero fun a _ => by rw [← Finset.mul_sum, hrow a, mul_zero]
  simp only [e, Finset.sum_add_distrib, Finset.sum_sub_distrib, t1, t2, t3]; ring

theorem projD_sub (X Y : ι → ι → ℝ) (a b : ι) :
    projD (fun a b => X a b - Y a b) a b = projD X a b - projD Y a b := by
  simp only [projD]
  split_ifs
  · ring
  · simp only [Finset.sum_sub_distrib]; ring

/-- **`Π` is non-expansive** on hollow symmetric arrays. -/
theorem projD_nonexp (hn : 4 ≤ Fintype.card ι) (X Y : ι → ι → ℝ) (hXs : ∀ a b, X a b = X b a)
    (hYs : ∀ a b, Y a b = Y b a) (hXh : ∀ a, X a a = 0) (hYh : ∀ a, Y a a = 0) :
    ∑ a, ∑ b, (projD X a b - projD Y a b) ^ 2 ≤ ∑ a, ∑ b, (X a b - Y a b) ^ 2 := by
  set D : ι → ι → ℝ := fun a b => X a b - Y a b with hD
  have hDs : ∀ a b, D a b = D b a := fun a b => by simp only [hD, hXs a b, hYs a b]
  have hDh : ∀ a, D a a = 0 := fun a => by simp only [hD, hXh a, hYh a, sub_self]
  have hW := projD_isWeight hn D hDs hDh
  have horth := projD_orth D hDh hW
  simp only [Matrix.of_apply] at horth
  have e : ∀ a b, projD X a b - projD Y a b = projD D a b := fun a b => (projD_sub X Y a b).symm
  simp only [e]
  have hsplit : ∑ a, ∑ b, D a b ^ 2 = ∑ a, ∑ b, projD D a b ^ 2 + ∑ a, ∑ b, (D a b - projD D a b) ^ 2
      + 2 * ∑ a, ∑ b, (D a b - projD D a b) * projD D a b := by
    simp only [Finset.mul_sum, ← Finset.sum_add_distrib]
    exact Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ => by ring
  have hnn : 0 ≤ ∑ a, ∑ b, (D a b - projD D a b) ^ 2 :=
    Finset.sum_nonneg fun a _ => Finset.sum_nonneg fun b _ => sq_nonneg _
  show ∑ a, ∑ b, projD D a b ^ 2 ≤ ∑ a, ∑ b, D a b ^ 2
  rw [hsplit, horth]; linarith

/-- The off-diagonal part of `v vᵀ`. -/
def outer (v : ι → ℝ) (a b : ι) : ℝ := if a = b then 0 else v a * v b

/-- **`Π(v vᵀ) = Z(v)`** at `∑ v = 0`, `∑ v² = 1`. -/
theorem projD_outer (hn : 4 ≤ Fintype.card ι) (v : ι → ℝ) (h1 : ∑ a, v a = 0) (h2 : ∑ a, v a ^ 2 = 1)
    (a b : ι) : projD (outer v) a b = Zp v (Fintype.card ι : ℝ) a b := by
  have hn4 : (4 : ℝ) ≤ (Fintype.card ι : ℝ) := by exact_mod_cast hn
  have hr : ∀ a, ∑ c, outer v a c = -v a ^ 2 := by
    intro a
    have : ∑ c, outer v a c = ∑ c, v a * v c - v a * v a := by
      rw [eq_sub_iff_add_eq, ← Finset.add_sum_erase _ _ (Finset.mem_univ a)]
      simp only [outer, if_true, zero_add]
      rw [← Finset.add_sum_erase _ _ (Finset.mem_univ a), add_comm]
      congr 1
      exact Finset.sum_congr rfl fun c hc => by rw [if_neg (Ne.symm (Finset.ne_of_mem_erase hc))]
    rw [this, ← Finset.mul_sum, h1]; ring
  have hT : ∑ c, ∑ d, outer v c d = -1 := by simp only [hr, Finset.sum_neg_distrib, h2]
  simp only [projD, Zp, hr, Finset.sum_neg_distrib, h2]
  split_ifs with h
  · rfl
  · simp only [outer, if_neg h]
    have hn2 : (Fintype.card ι : ℝ) - 2 ≠ 0 := by linarith
    have hn1 : (Fintype.card ι : ℝ) - 1 ≠ 0 := by linarith
    field_simp; ring

/-- **`|v vᵀ − w wᵀ| ≤ ‖v − w‖`** off the diagonal, over unordered pairs, for unit `v, w`. -/
theorem outer_dist (v w : ι → ℝ) (hv : ∑ a, v a ^ 2 = 1) (hw : ∑ a, w a ^ 2 = 1) :
    (1 / 2) * ∑ a, ∑ b, (outer v a b - outer w a b) ^ 2 ≤ ∑ a, (v a - w a) ^ 2 := by
  have hle : ∑ a, ∑ b, (outer v a b - outer w a b) ^ 2 ≤ ∑ a, ∑ b, (v a * v b - w a * w b) ^ 2 := by
    refine Finset.sum_le_sum fun a _ => Finset.sum_le_sum fun b _ => ?_
    simp only [outer]; split_ifs
    · nlinarith [sq_nonneg (v a * v b - w a * w b)]
    · exact le_refl _
  set c := ∑ a, v a * w a with hc
  have hfull : ∑ a, ∑ b, (v a * v b - w a * w b) ^ 2 = 2 - 2 * c ^ 2 := by
    have e : ∀ a b, (v a * v b - w a * w b) ^ 2
        = v a ^ 2 * v b ^ 2 + w a ^ 2 * w b ^ 2 - 2 * ((v a * w a) * (v b * w b)) := fun a b => by ring
    simp only [e, Finset.sum_add_distrib, Finset.sum_sub_distrib, ← Finset.mul_sum, ← Finset.sum_mul, hv, hw]
    rw [← hc]; ring
  have hvw : ∑ a, (v a - w a) ^ 2 = 2 - 2 * c := by
    have e : ∀ a, (v a - w a) ^ 2 = v a ^ 2 + w a ^ 2 - 2 * (v a * w a) := fun a => by ring
    simp only [e, Finset.sum_add_distrib, Finset.sum_sub_distrib, ← Finset.mul_sum, hv, hw]; rw [← hc]; ring
  have hc1 : c ≤ 1 := by
    have := sq_nonneg (∑ a, (v a - w a) ^ 2)
    have h0 : 0 ≤ ∑ a, (v a - w a) ^ 2 := Finset.sum_nonneg fun a _ => sq_nonneg _
    linarith
  have hcm : -1 ≤ c := by
    have h0 : 0 ≤ ∑ a, (v a + w a) ^ 2 := Finset.sum_nonneg fun a _ => sq_nonneg _
    have e : ∑ a, (v a + w a) ^ 2 = 2 + 2 * c := by
      have e : ∀ a, (v a + w a) ^ 2 = v a ^ 2 + w a ^ 2 + 2 * (v a * w a) := fun a => by ring
      simp only [e, Finset.sum_add_distrib, ← Finset.mul_sum, hv, hw]; rw [← hc]; ring
    linarith
  rw [hvw]
  nlinarith [hle, hfull]

/-- Row sums of `outer w`: `w_a ∑ w − w_a²`. -/
theorem outer_row (w : ι → ℝ) (a : ι) : ∑ c, outer w a c = w a * ∑ c, w c - w a ^ 2 := by
  have : ∑ c, outer w a c = ∑ c, w a * w c - w a * w a := by
    rw [eq_sub_iff_add_eq, ← Finset.add_sum_erase _ _ (Finset.mem_univ a)]
    simp only [outer, if_true, zero_add]
    rw [← Finset.add_sum_erase _ _ (Finset.mem_univ a), add_comm]
    congr 1
    exact Finset.sum_congr rfl fun c hc => by rw [if_neg (Ne.symm (Finset.ne_of_mem_erase hc))]
  rw [this, ← Finset.mul_sum]; ring

/-- **`Π(w wᵀ)` at the sign vector of a split `T`**, class by class, with `D = n(n−1)(n−2)`:
`4q(q−1)/D` inside `T`, `4p(p−1)/D` outside, `−4(p−1)(q−1)/D` across. -/
theorem projD_sign (hn : 4 ≤ Fintype.card ι) (T : Finset ι) (a b : ι) (hab : a ≠ b) :
    let n : ℝ := Fintype.card ι
    let p : ℝ := T.card
    let q : ℝ := Tᶜ.card
    let w : ι → ℝ := fun c => if c ∈ T then 1 / Real.sqrt n else -(1 / Real.sqrt n)
    projD (outer w) a b =
      (if a ∈ T then (if b ∈ T then 4 * q * (q - 1) else -(4 * (p - 1) * (q - 1)))
        else (if b ∈ T then -(4 * (p - 1) * (q - 1)) else 4 * p * (p - 1))) / (n * (n - 1) * (n - 2)) := by
  intro n p q w
  have hn4 : (4 : ℝ) ≤ n := by show (4 : ℝ) ≤ (Fintype.card ι : ℝ); exact_mod_cast hn
  have hn0 : 0 < n := by linarith
  have hsn : Real.sqrt n ^ 2 = n := Real.sq_sqrt hn0.le
  have hs0 : Real.sqrt n ≠ 0 := (Real.sqrt_pos.mpr hn0).ne'
  have hpq : p + q = n := by
    show (T.card : ℝ) + (Tᶜ.card : ℝ) = (Fintype.card ι : ℝ)
    exact_mod_cast (Finset.card_add_card_compl T).trans Finset.card_univ
  have hsum : ∑ c, w c = (p - q) / Real.sqrt n := by
    show ∑ c, (if c ∈ T then 1 / Real.sqrt n else -(1 / Real.sqrt n)) = _
    rw [Finset.sum_ite, Finset.sum_const, Finset.sum_const, nsmul_eq_mul, nsmul_eq_mul]
    have h1 : (univ.filter fun c => c ∈ T) = T := by ext; simp
    have h2 : (univ.filter fun c => c ∉ T) = Tᶜ := by ext; simp
    rw [h1, h2]; ring
  have hw2 : ∀ c, w c ^ 2 = 1 / n := fun c => by
    show (if c ∈ T then 1 / Real.sqrt n else -(1 / Real.sqrt n)) ^ 2 = _
    split_ifs <;> simp only [neg_sq, div_pow, one_pow, hsn]
  have hT : ∑ c, ∑ d, outer w c d = (p - q) ^ 2 / n - 1 := by
    simp only [outer_row, Finset.sum_sub_distrib, ← Finset.sum_mul, hsum, hw2, Finset.sum_const,
      Finset.card_univ, nsmul_eq_mul]
    have e : (p - q) / Real.sqrt n * ((p - q) / Real.sqrt n) = (p - q) ^ 2 / n := by
      rw [← sq, div_pow, hsn]
    rw [e]; show _ - n * (1 / n) = _; field_simp
  simp only [projD, if_neg hab]
  rw [outer_row, outer_row, hsum, hw2, hw2, hT]
  simp only [outer, if_neg hab]
  have hndef : (Fintype.card ι : ℝ) = n := rfl
  rw [hndef]
  have hn2 : n - 2 ≠ 0 := by linarith
  have hn1 : n - 1 ≠ 0 := by linarith
  have hwa : ∀ c, w c = (if c ∈ T then 1 else -1) / Real.sqrt n := fun c => by
    show (if c ∈ T then 1 / Real.sqrt n else -(1 / Real.sqrt n)) = _
    split_ifs <;> ring
  rw [hwa a, hwa b]
  have hsq : ∀ x y : ℝ, x / Real.sqrt n * (y / Real.sqrt n) = x * y / n := fun x y => by
    rw [div_mul_div_comm, ← sq, hsn]
  rw [hsq, hsq, hsq]
  rw [← hpq] at hn1 hn2 ⊢
  have hn0' : p + q ≠ 0 := by linarith
  split_ifs <;> field_simp <;> ring

/-- **At `p, q ≥ 2`, `Π(w wᵀ) = c · sphereWeight T`** with `c = 4(p−1)(q−1)/(n(n−1)(n−2)) > 0`. -/
theorem projD_sign_sphere (hn : 4 ≤ Fintype.card ι) (T : Finset ι) (hp : 2 ≤ T.card) (hq : 2 ≤ Tᶜ.card) :
    let n : ℝ := Fintype.card ι
    let w : ι → ℝ := fun c => if c ∈ T then 1 / Real.sqrt n else -(1 / Real.sqrt n)
    let c : ℝ := 4 * ((T.card : ℝ) - 1) * ((Tᶜ.card : ℝ) - 1) / (n * (n - 1) * (n - 2))
    0 < c ∧ ∀ a b, projD (outer w) a b = c * sphereWeight T a b := by
  intro n w c
  have hn4 : (4 : ℝ) ≤ n := by show (4 : ℝ) ≤ (Fintype.card ι : ℝ); exact_mod_cast hn
  have hpR : (2 : ℝ) ≤ T.card := by exact_mod_cast hp
  have hqR : (2 : ℝ) ≤ Tᶜ.card := by exact_mod_cast hq
  refine ⟨by
    show 0 < 4 * ((T.card : ℝ) - 1) * ((Tᶜ.card : ℝ) - 1) / (n * (n - 1) * (n - 2))
    apply div_pos
    · have : 0 < (T.card : ℝ) - 1 := by linarith
      have : 0 < (Tᶜ.card : ℝ) - 1 := by linarith
      positivity
    · have : 0 < n - 1 := by linarith
      have : 0 < n - 2 := by linarith
      positivity, fun a b => ?_⟩
  by_cases hab : a = b
  · subst hab; simp [projD, sphereWeight]
  have hv := projD_sign hn T a b hab
  simp only at hv
  rw [hv]
  have hp1 : (T.card : ℝ) - 1 ≠ 0 := by linarith
  have hq1 : (Tᶜ.card : ℝ) - 1 ≠ 0 := by linarith
  have hcdef : c = 4 * ((T.card : ℝ) - 1) * ((Tᶜ.card : ℝ) - 1) / (n * (n - 1) * (n - 2)) := rfl
  have hndef : (Fintype.card ι : ℝ) = n := rfl
  have hn0 : n ≠ 0 := by linarith
  have hn1 : n - 1 ≠ 0 := by linarith
  have hn2 : n - 2 ≠ 0 := by linarith
  rw [hcdef]
  try rw [hndef]
  by_cases ha : a ∈ T <;> by_cases hb : b ∈ T
  · rw [if_pos ha, if_pos hb, sphereWeight_in T ha hb hab]; field_simp
  · rw [if_pos ha, if_neg hb, sphereWeight_cross T ha hb]; ring
  · rw [if_neg ha, if_pos hb, sphereWeight_symm, sphereWeight_cross T hb ha]; ring
  · rw [if_neg ha, if_neg hb, sphereWeight_out T ha hb hab]
    have : (Tᶜ.card : ℝ) - 1 ≠ 0 := hq1
    field_simp

/-- **`Π(w wᵀ) = 0` when a class has at most one element.** -/
theorem projD_sign_zero (hn : 4 ≤ Fintype.card ι) (T : Finset ι) (hsmall : T.card ≤ 1 ∨ Tᶜ.card ≤ 1) :
    let n : ℝ := Fintype.card ι
    let w : ι → ℝ := fun c => if c ∈ T then 1 / Real.sqrt n else -(1 / Real.sqrt n)
    ∀ a b, projD (outer w) a b = 0 := by
  intro n w a b
  by_cases hab : a = b
  · subst hab; simp [projD]
  have hv := projD_sign hn T a b hab
  simp only at hv
  rw [hv]
  have two_le : ∀ (s : Finset ι) x y, x ∈ s → y ∈ s → x ≠ y → 2 ≤ s.card := fun s x y hx hy hxy =>
    Finset.one_lt_card.mpr ⟨x, hx, y, hy, hxy⟩
  by_cases ha : a ∈ T <;> by_cases hb : b ∈ T
  · have h2 := two_le T a b ha hb hab
    have hq : Tᶜ.card ≤ 1 := hsmall.resolve_left (by omega)
    rw [if_pos ha, if_pos hb]
    rcases Nat.le_one_iff_eq_zero_or_eq_one.mp hq with h | h <;> simp [h]
  · rw [if_pos ha, if_neg hb]
    rcases hsmall with h | h
    · have h1 : T.card = 1 := le_antisymm h (Finset.card_pos.mpr ⟨a, ha⟩)
      simp [h1]
    · have h1 : Tᶜ.card = 1 := le_antisymm h (Finset.card_pos.mpr ⟨b, Finset.mem_compl.mpr hb⟩)
      simp [h1]
  · rw [if_neg ha, if_pos hb]
    rcases hsmall with h | h
    · have h1 : T.card = 1 := le_antisymm h (Finset.card_pos.mpr ⟨b, hb⟩)
      simp [h1]
    · have h1 : Tᶜ.card = 1 := le_antisymm h (Finset.card_pos.mpr ⟨a, Finset.mem_compl.mpr ha⟩)
      simp [h1]
  · have h2 := two_le Tᶜ a b (Finset.mem_compl.mpr ha) (Finset.mem_compl.mpr hb) hab
    have hp : T.card ≤ 1 := hsmall.resolve_right (by omega)
    rw [if_neg ha, if_neg hb]
    rcases Nat.le_one_iff_eq_zero_or_eq_one.mp hp with h | h <;> simp [h]

/-! ## The pairing and norm over unordered pairs -/

/-- `⟨f, g⟩ = ½ ∑_{a,b} f_ab g_ab`. -/
noncomputable def ipU (f g : ι → ι → ℝ) : ℝ := (1 / 2) * ∑ a, ∑ b, f a b * g a b

/-- `|f| = √⟨f, f⟩`. -/
noncomputable def nrmU (f : ι → ι → ℝ) : ℝ := Real.sqrt (ipU f f)

omit [DecidableEq ι] in
theorem ipU_self_nonneg (f : ι → ι → ℝ) : 0 ≤ ipU f f := by
  unfold ipU; apply mul_nonneg (by norm_num)
  exact Finset.sum_nonneg fun a _ => Finset.sum_nonneg fun b _ => mul_self_nonneg _

omit [DecidableEq ι] in
theorem nrmU_sq (f : ι → ι → ℝ) : nrmU f ^ 2 = ipU f f := Real.sq_sqrt (ipU_self_nonneg f)

omit [DecidableEq ι] in
theorem nrmU_nonneg (f : ι → ι → ℝ) : 0 ≤ nrmU f := Real.sqrt_nonneg _

omit [DecidableEq ι] in
theorem ipU_le (f g : ι → ι → ℝ) : ipU f g ≤ nrmU f * nrmU g := by
  have hcs := cs_pairs f g
  have h : ipU f g ^ 2 ≤ ipU f f * ipU g g := by
    unfold ipU; simp only [sq] at hcs ⊢; nlinarith [hcs]
  rw [← nrmU_sq, ← nrmU_sq] at h
  have := abs_le_of_sq_le_sq' (by nlinarith [h] : ipU f g ^ 2 ≤ (nrmU f * nrmU g) ^ 2)
    (mul_nonneg (nrmU_nonneg f) (nrmU_nonneg g))
  exact this.2

omit [DecidableEq ι] in
theorem ipU_add_self (f g : ι → ι → ℝ) :
    ipU (fun a b => f a b + g a b) (fun a b => f a b + g a b) = ipU f f + 2 * ipU f g + ipU g g := by
  unfold ipU
  simp only [Finset.mul_sum, ← Finset.sum_add_distrib]
  exact Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ => by ring

omit [DecidableEq ι] in
/-- **The triangle inequality** for `|·|`. -/
theorem nrmU_add_le (f g : ι → ι → ℝ) : nrmU (fun a b => f a b + g a b) ≤ nrmU f + nrmU g := by
  have h := ipU_le f g
  have hsq : ipU (fun a b => f a b + g a b) (fun a b => f a b + g a b) ≤ (nrmU f + nrmU g) ^ 2 := by
    rw [ipU_add_self, add_sq, nrmU_sq, nrmU_sq]; linarith
  calc nrmU (fun a b => f a b + g a b) ≤ Real.sqrt ((nrmU f + nrmU g) ^ 2) := Real.sqrt_le_sqrt hsq
    _ = nrmU f + nrmU g := Real.sqrt_sq (add_nonneg (nrmU_nonneg f) (nrmU_nonneg g))

omit [DecidableEq ι] in
theorem nrmU_smul (c : ℝ) (f : ι → ι → ℝ) : nrmU (fun a b => c * f a b) = |c| * nrmU f := by
  unfold nrmU ipU
  rw [← Real.sqrt_sq_eq_abs, ← Real.sqrt_mul (sq_nonneg _)]
  congr 1
  simp only [Finset.mul_sum]
  exact Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ => by ring

omit [DecidableEq ι] in
theorem nrmU_sub_comm (f g : ι → ι → ℝ) : nrmU (fun a b => f a b - g a b) = nrmU (fun a b => g a b - f a b) := by
  have := nrmU_smul (-1) (fun a b => f a b - g a b)
  simp only [abs_neg, abs_one, one_mul] at this
  rw [← this]; congr 1; funext a b; ring

omit [DecidableEq ι] in
/-- **Normalising is `2/|f|`-Lipschitz**: `|f/|f| − g/|g|| ≤ 2|f − g|/|f|`. -/
theorem nrmU_normalize (f g : ι → ι → ℝ) (hf : 0 < nrmU f) (hg : 0 < nrmU g) :
    nrmU (fun a b => f a b / nrmU f - g a b / nrmU g) ≤ 2 * nrmU (fun a b => f a b - g a b) / nrmU f := by
  set d := nrmU (fun a b => f a b - g a b)
  -- `||g| − |f|| ≤ |f − g|`
  have h1 : nrmU g ≤ nrmU f + d := by
    have := nrmU_add_le f (fun a b => g a b - f a b)
    rw [← nrmU_sub_comm] at this
    simpa using this
  have h2 : nrmU f ≤ nrmU g + d := by
    have := nrmU_add_le g (fun a b => f a b - g a b)
    simpa using this
  have e : (fun a b => f a b / nrmU f - g a b / nrmU g)
      = fun a b => (fun a b => (1 / nrmU f) * (f a b - g a b)) a b
          + (fun a b => ((1 / nrmU f - 1 / nrmU g)) * g a b) a b := by
    funext a b; field_simp; ring
  rw [e]
  refine le_trans (nrmU_add_le _ _) ?_
  rw [nrmU_smul, nrmU_smul, abs_of_pos (by positivity)]
  have hk : |1 / nrmU f - 1 / nrmU g| * nrmU g = |nrmU g - nrmU f| / nrmU f := by
    rw [show 1 / nrmU f - 1 / nrmU g = (nrmU g - nrmU f) / (nrmU f * nrmU g) by field_simp, abs_div,
      abs_of_pos (mul_pos hf hg)]
    field_simp
  rw [hk]
  have habs : |nrmU g - nrmU f| ≤ d := abs_le.mpr ⟨by linarith, by linarith⟩
  have e2 : 1 / nrmU f * d + |nrmU g - nrmU f| / nrmU f = (d + |nrmU g - nrmU f|) / nrmU f := by ring
  rw [e2, div_le_div_iff_of_pos_right hf]; linarith

omit [DecidableEq ι] in
/-- A normalised array has unit norm. -/
theorem nrmU_normalized (f : ι → ι → ℝ) (hf : 0 < nrmU f) : nrmU (fun a b => f a b / nrmU f) = 1 := by
  have e : (fun a b => f a b / nrmU f) = fun a b => (1 / nrmU f) * f a b := by
    funext a b; ring
  rw [e, nrmU_smul, abs_of_pos (by positivity)]; field_simp

/-! ## Item 4 -/

/-- **L223, item 4**: if `4√(n−2)√(Δ/Θ̄) < 2(1 − Δ/Θ̄)`, the sign classes have `p, q ≥ 2`, and the unit positive
multiple `B` of `Π(w wᵀ)`, a positive multiple of `sphereWeight` of the split, has
`|S − B| ≤ (√2 + 4√(n−2)/(1 − Δ/Θ̄)) √(Δ/Θ̄)`. -/
theorem L223_item4 {S : Matrix ι ι ℝ} (hS : IsWeight S) (hn : 4 ≤ Fintype.card ι)
    (hunit : ∑ a, ∑ b, S a b ^ 2 = 2) (E : Matrix ι ι ℝ) (hE0 : ∀ a, E a a = 0) (lam : ℝ)
    (hnear : ∀ a b, a ≠ b → S a b ^ 2 + (S * S) a b = lam * S a b + E a b)
    (v : ι → ℝ) (μ : ℝ) (hv : S *ᵥ v = μ • v) (h2 : ∑ a, v a ^ 2 = 1) (hμ : 0 < μ) :
    let n : ℝ := Fintype.card ι
    let Θ := Real.sqrt (2 * (n - 1) * (n - 2)) / n
    let x := (Θ - lam + max 0 (-∑ a, ∑ b, E a b * v a * v b) / μ) / Θ
    let T := univ.filter fun a => 0 ≤ v a
    let w : ι → ℝ := fun c => if c ∈ T then 1 / Real.sqrt n else -(1 / Real.sqrt n)
    let B : ι → ι → ℝ := fun a b => projD (outer w) a b / nrmU (projD (outer w))
    4 * Real.sqrt (n - 2) * Real.sqrt x < 2 * (1 - x) →
      2 ≤ T.card ∧ 2 ≤ Tᶜ.card ∧ (∃ c, 0 < c ∧ ∀ a b, B a b = c * sphereWeight T a b) ∧
        nrmU (fun a b => S a b - B a b) ≤ (Real.sqrt 2 + 4 * Real.sqrt (n - 2) / (1 - x)) * Real.sqrt x := by
  intro n Θ x T w B hx4
  obtain ⟨hΔ0, hcos, -, hZn⟩ := L223_items12 hS hn hunit E hE0 lam hnear v μ hv h2 hμ
  obtain ⟨-, hvw, -⟩ := L223_item3 hS hn hunit E hE0 lam hnear v μ hv h2 hμ
  have hn4 : (4 : ℝ) ≤ n := by show (4 : ℝ) ≤ (Fintype.card ι : ℝ); exact_mod_cast hn
  have hn1 : 0 < n - 1 := by linarith
  have hn2 : 0 < n - 2 := by linarith
  have h1 : ∑ a, v a = 0 := sum_v_zero S hS v μ hv hμ.ne'
  have hΘ0 : 0 < Θ := div_pos (Real.sqrt_pos.mpr (by positivity)) (by linarith)
  have hx0 : 0 ≤ x := div_nonneg hΔ0 hΘ0.le
  have hx1 : x < 1 := by
    have : 0 ≤ 4 * Real.sqrt (n - 2) * Real.sqrt x := by positivity
    linarith
  set Zs := Real.sqrt ((n - 2) / (2 * (n - 1))) with hZsdef
  have hZs0 : 0 < Zs := Real.sqrt_pos.mpr (by positivity)
  have hZs2 : Zs ^ 2 = (n - 2) / (2 * (n - 1)) := Real.sq_sqrt (by positivity)
  -- the sign vector of item 3 is `w`
  have hw : w = fun a => if 0 ≤ v a then 1 / Real.sqrt n else -(1 / Real.sqrt n) := by
    funext c; simp [w, T]
  -- `Z = Π(v vᵀ)`, `W = Π(w wᵀ)`
  set Z : ι → ι → ℝ := Zp v n with hZ
  set W : ι → ι → ℝ := projD (outer w) with hW
  have hZproj : ∀ a b, Z a b = projD (outer v) a b := fun a b => (projD_outer hn v h1 h2 a b).symm
  have hZn_eq : nrmU Z = Real.sqrt ((1 / 2) * ∑ a, ∑ b, Zp v n a b ^ 2) := by
    unfold nrmU ipU; simp only [hZ, sq]
  -- `|Z − W| ≤ ‖v − w‖ ≤ 2√(n−2) Z* √x`
  have hw2 : ∑ a, w a ^ 2 = 1 := by
    have hsn : Real.sqrt n ^ 2 = n := Real.sq_sqrt (by linarith)
    have : ∀ a, w a ^ 2 = 1 / n := fun a => by
      simp only [w]; split_ifs <;> simp only [neg_sq, div_pow, one_pow, hsn]
    simp only [this, Finset.sum_const, Finset.card_univ, nsmul_eq_mul]
    show (Fintype.card ι : ℝ) * (1 / n) = 1
    have hnd : (Fintype.card ι : ℝ) = n := rfl
    rw [hnd]; field_simp
  have hosym : ∀ (u : ι → ℝ) a b, outer u a b = outer u b a := fun u a b => by
    simp only [outer]; split_ifs with h h' h' <;> [rfl; exact absurd h.symm h'; exact absurd h'.symm h; ring]
  have hohol : ∀ (u : ι → ℝ) a, outer u a a = 0 := fun u a => by simp [outer]
  have hZW : nrmU (fun a b => Z a b - W a b) ≤ Real.sqrt (∑ a, (v a - w a) ^ 2) := by
    have hne := projD_nonexp hn (outer v) (outer w) (hosym v) (hosym w) (hohol v) (hohol w)
    have hod := outer_dist v w h2 hw2
    unfold nrmU ipU
    apply Real.sqrt_le_sqrt
    simp only [hZproj, ← sq]
    have : (1 / 2) * ∑ a, ∑ b, (projD (outer v) a b - W a b) ^ 2
        ≤ (1 / 2) * ∑ a, ∑ b, (outer v a b - outer w a b) ^ 2 := by
      apply mul_le_mul_of_nonneg_left hne (by norm_num)
    linarith
  have hvwb : Real.sqrt (∑ a, (v a - w a) ^ 2) ≤ 2 * Real.sqrt (n - 2) * Zs * Real.sqrt x := by
    have hvw' : ∑ a, (v a - w a) ^ 2 ≤ 2 * (n - 2) ^ 2 / (n - 1) * x := by rw [hw]; exact hvw
    have hk : (2 * Real.sqrt (n - 2) * Zs * Real.sqrt x) ^ 2 = 2 * (n - 2) ^ 2 / (n - 1) * x := by
      rw [mul_pow, mul_pow, mul_pow, Real.sq_sqrt hn2.le, hZs2, Real.sq_sqrt hx0]
      field_simp
    rw [← hk] at hvw'
    calc Real.sqrt (∑ a, (v a - w a) ^ 2) ≤ Real.sqrt ((2 * Real.sqrt (n - 2) * Zs * Real.sqrt x) ^ 2) :=
          Real.sqrt_le_sqrt hvw'
      _ = 2 * Real.sqrt (n - 2) * Zs * Real.sqrt x := Real.sqrt_sq (by positivity)
  have hsmall : 2 * Real.sqrt (n - 2) * Real.sqrt x < 1 - x := by linarith
  have hdZW : nrmU (fun a b => Z a b - W a b) ≤ 2 * Real.sqrt (n - 2) * Zs * Real.sqrt x :=
    le_trans hZW hvwb
  have hZlow : Zs * (1 - x) ≤ nrmU Z := by rw [hZn_eq]; exact hZn
  have hZpos : 0 < nrmU Z := lt_of_lt_of_le (mul_pos hZs0 (by linarith)) hZlow
  have hlt : nrmU (fun a b => Z a b - W a b) < nrmU Z := by
    calc nrmU (fun a b => Z a b - W a b) ≤ 2 * Real.sqrt (n - 2) * Zs * Real.sqrt x := hdZW
      _ = Zs * (2 * Real.sqrt (n - 2) * Real.sqrt x) := by ring
      _ < Zs * (1 - x) := mul_lt_mul_of_pos_left hsmall hZs0
      _ ≤ nrmU Z := hZlow
  -- `|W| > 0`, hence `p, q ≥ 2`
  have hWpos : 0 < nrmU W := by
    have := nrmU_add_le (fun a b => Z a b - W a b) W
    have e : (fun a b => (fun a b => Z a b - W a b) a b + W a b) = Z := by funext a b; ring
    rw [e] at this; linarith
  have hpq : 2 ≤ T.card ∧ 2 ≤ Tᶜ.card := by
    by_contra hc
    have hs : T.card ≤ 1 ∨ Tᶜ.card ≤ 1 := by omega
    have h0 := projD_sign_zero hn T hs
    have h0' : ∀ a b, W a b = 0 := fun a b => h0 a b
    have : nrmU W = 0 := by
      unfold nrmU ipU; simp [h0']
    linarith
  obtain ⟨hc0, hcW⟩ := projD_sign_sphere hn T hpq.1 hpq.2
  refine ⟨hpq.1, hpq.2, ⟨_, div_pos hc0 hWpos, fun a b => ?_⟩, ?_⟩
  · show W a b / nrmU W = _
    rw [show W a b = _ from hcW a b]; ring
  -- `|S − Ẑ| ≤ √2 √x` and `|Ẑ − B| ≤ 4√(n−2)√x/(1 − x)`
  have hSS : ipU S S = 1 := by unfold ipU; simp only [← sq, hunit]; norm_num
  obtain ⟨hSZ, -⟩ := step23_parts S hS v μ hv h2 h1 hn
  have hSZ' : ipU S Z = μ / 2 := by unfold ipU; rw [hZ, hSZ]; ring
  have hSZhat : nrmU (fun a b => S a b - Z a b / nrmU Z) ≤ Real.sqrt 2 * Real.sqrt x := by
    have hsq : ipU (fun a b => S a b - Z a b / nrmU Z) (fun a b => S a b - Z a b / nrmU Z)
        = 2 - 2 * ((μ / 2) / nrmU Z) := by
      have hZZ : ipU Z Z = nrmU Z ^ 2 := (nrmU_sq Z).symm
      have e : ipU (fun a b => S a b - Z a b / nrmU Z) (fun a b => S a b - Z a b / nrmU Z)
          = ipU S S - 2 * ipU S Z / nrmU Z + ipU Z Z / nrmU Z ^ 2 := by
        unfold ipU
        simp only [Finset.mul_sum, ← Finset.sum_add_distrib, ← Finset.sum_sub_distrib, Finset.sum_div]
        refine Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ => ?_
        field_simp; ring
      rw [e, hSS, hSZ', hZZ]; field_simp; ring
    have hcos' : 1 - (μ / 2) / nrmU Z ≤ x := by
      rw [hZn_eq]; exact hcos
    rw [show nrmU (fun a b => S a b - Z a b / nrmU Z) = Real.sqrt (2 - 2 * ((μ / 2) / nrmU Z)) by
      rw [← hsq]; rfl, ← Real.sqrt_mul (by norm_num)]
    apply Real.sqrt_le_sqrt; linarith
  have hZB : nrmU (fun a b => Z a b / nrmU Z - B a b) ≤ 4 * Real.sqrt (n - 2) / (1 - x) * Real.sqrt x := by
    have h := nrmU_normalize Z W hZpos hWpos
    have hB : (fun a b => Z a b / nrmU Z - B a b) = (fun a b => Z a b / nrmU Z - W a b / nrmU W) := rfl
    rw [hB]
    refine le_trans h ?_
    rw [div_le_iff₀ hZpos]
    have hx' : 0 < 1 - x := by linarith
    calc 2 * nrmU (fun a b => Z a b - W a b) ≤ 2 * (2 * Real.sqrt (n - 2) * Zs * Real.sqrt x) := by linarith
      _ = 4 * Real.sqrt (n - 2) / (1 - x) * Real.sqrt x * (Zs * (1 - x)) := by field_simp; ring
      _ ≤ 4 * Real.sqrt (n - 2) / (1 - x) * Real.sqrt x * nrmU Z :=
          mul_le_mul_of_nonneg_left hZlow (by positivity)
  have htri := nrmU_add_le (fun a b => S a b - Z a b / nrmU Z) (fun a b => Z a b / nrmU Z - B a b)
  have e : (fun a b => (fun a b => S a b - Z a b / nrmU Z) a b + (fun a b => Z a b / nrmU Z - B a b) a b)
      = fun a b => S a b - B a b := by funext a b; ring
  rw [e] at htri
  calc nrmU (fun a b => S a b - B a b) ≤ Real.sqrt 2 * Real.sqrt x
        + 4 * Real.sqrt (n - 2) / (1 - x) * Real.sqrt x := le_trans htri (add_le_add hSZhat hZB)
    _ = (Real.sqrt 2 + 4 * Real.sqrt (n - 2) / (1 - x)) * Real.sqrt x := by ring

end HamiltonsCubic.L57Critical
