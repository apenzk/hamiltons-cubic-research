import HamiltonsCubic.Results.L131Diag
import HamiltonsCubic.Results.L120Diag

set_option linter.style.longLine false

/-!
# L127's `𝒟ₙ` row, without representation theory

[findings/second-order.md](../../../findings/second-order.md), Lemma L127's table, `𝒟ₙ` row:
`σ(L_e|_{𝒟ₙ}) = {1, λ_p^{p−1}, λ_q^{q−1}, (−μ)^{(p−1)(q−1)}, 0^{rest}}`, which the record takes from L27's `O(p) × O(q)`
summands. On `𝒟ₙ` the operator `M ∘` acts on weights, and this file computes that action directly:

* **`Kmat`**, **`foxProd_diag`**: `diagOp w ∘ diagOp u = diagOp (K u)` on bivectors, `K u = w ⊙ u + ½(wu + uw)`, the
  Jordan half `w ⊙ u` and the `#` half from [L131Diag.lean](L131Diag.lean)'s `sharpCross_diag`;
* **`blockW`**, **`smul_sphereWeight_eq`**, **`sum_blockW_mul`**: a block weight (`A` within `T`, `B` within `Tᶜ`, `G`
  across), of which the sphere weight is one, and its row sums against any vector;
* **`crossW`**, **`K_cross`**: the cross weights `u_{ac} = x_a y_c` (`a ∈ T`, `c ∉ T`, zero sums) are eigenvectors of
  `K` with eigenvalue `G − (A + B)/2`, the record's `−μ` in `L_e` units at a sphere product;
* **`K_zero`**: a hollow symmetric weight supported inside `T` with zero row sums there has `K u = 0`;
* **`lamW`**, **`K_lam`**: the weights `h_a + h_b` within `T` and `κ h_a` across, `∑_T h = 0`, `κ q = −(p − 2)`, are
  eigenvectors off the diagonal with eigenvalue `½(p − 2)(A − G)`, the record's `λ_p` in `L_e` units, at a block
  weight with the sphere product's row-sum relations.

[L127DnUnits.lean](L127DnUnits.lean) adds the eigenvalue-`1` vector, the mirror families on `Tᶜ` and the passage to
`L_e` units. [L127DnSpan.lean](L127DnSpan.lean) shows the families span `𝒟ₙ` at `p, q ≥ 2`, and
[L127DnEig.lean](L127DnEig.lean) and [L127DnLam.lean](L127DnLam.lean) give the eigenspaces at `p, q ≥ 3`,
`t ≠ 0`. At `p, q ≥ 3` their dimensions `1 + (p − 1) + (q − 1) +
(p − 1)(q − 1) + p(p − 3)/2 + q(q − 3)/2` sum to `n(n − 3)/2`. At `p = 2` the `λ_p` weights vanish (`h_a = −h_b` and
`κ = 0`) and the zero family inside `T` is `{0}`, so both count `0`, and the pair `(p − 1) + p(p − 3)/2 = 0` keeps the
total, with `λ_2 = 0` joining `0^{rest}`. At `q = 2` the mirror holds: the `λ_q` weights and the zero family inside `Tᶜ`
are `{0}`, and `(q − 1) + q(q − 3)/2 = 0`. L127DnSpan's `lamW_two_eq_zero` and `within_two_eq_zero` declare
both vanishings.
-/

namespace HamiltonsCubic.Results

open Finset HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer HamiltonsCubic.WeylRadical

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- The weight map of `M ∘` on `𝒟ₙ`: `K u = w ⊙ u + ½(wu + uw)`. -/
noncomputable def Kmat (w u : Matrix ι ι ℝ) : Matrix ι ι ℝ :=
  Matrix.of fun a b => w a b * u a b + (1 / 2) * ((w * u) a b + (u * w) a b)

/-- **`M ∘` on a diagonal operator is diagonal**: `diagOp w ∘ diagOp u` sends `φ_{ab}` to `(K u)_{ab} φ_{ab}`. -/
theorem foxProd_diag (w u : Matrix ι ι ℝ) (hw : ∀ p q, w p q = w q p) (hu : ∀ p q, u p q = u q p)
    (hhw : ∀ a, w a a = 0) (hhu : ∀ a, u a a = 0) (a b : ι) :
    foxProd (diagOp w) (diagOp u) (phi a b) = Kmat w u a b • phi a b := by
  have hsplit := congrFun (foxProd_split (diagOp w) (diagOp u) (isLinOp_diagOp w).1 (isLinOp_diagOp u).1) (phi a b)
  rw [hsplit, HamiltonsCubic.L131Diag.sharpCross_diag w u hw hu hhw hhu a b]
  unfold jordanProd
  simp only [diagOp_phi u hu, diagOp_phi w hw, (isLinOp_diagOp w).2, (isLinOp_diagOp u).2, smul_smul,
    Kmat, Matrix.of_apply, ← add_smul]
  congr 1
  ring

/-- A block weight: `A` within `T`, `B` within `Tᶜ`, `G` across, hollow. -/
noncomputable def blockW (T : Finset ι) (A B G : ℝ) : Matrix ι ι ℝ :=
  Matrix.of fun a b => if a = b then 0 else if a ∈ T then (if b ∈ T then A else G) else (if b ∈ T then G else B)

omit [Fintype ι] in
theorem blockW_symm (T : Finset ι) (A B G : ℝ) (a b : ι) : blockW T A B G a b = blockW T A B G b a := by
  unfold blockW; simp only [Matrix.of_apply]
  by_cases hab : a = b
  · subst hab; rfl
  · by_cases ha : a ∈ T <;> by_cases hb : b ∈ T <;> simp [hab, Ne.symm hab, ha, hb]

omit [Fintype ι] in
theorem blockW_hollow (T : Finset ι) (A B G : ℝ) (a : ι) : blockW T A B G a a = 0 := by simp [blockW]

/-- The sphere weight is a block weight. -/
theorem smul_sphereWeight_eq (T : Finset ι) (t : ℝ) :
    t • sphereWeight T = blockW T (t * ((Tᶜ.card : ℝ) / ((T.card : ℝ) - 1))) (t * ((T.card : ℝ) / ((Tᶜ.card : ℝ) - 1)))
      (-t) := by
  ext a b
  simp only [Matrix.smul_apply, smul_eq_mul, sphereWeight, blockW, Matrix.of_apply]
  by_cases hab : a = b
  · simp [hab]
  · by_cases ha : a ∈ T <;> by_cases hb : b ∈ T <;> simp [hab, ha, hb]

/-- **The row sums of a block weight against `f`.** -/
theorem sum_blockW_mul (T : Finset ι) (A B G : ℝ) (f : ι → ℝ) (a : ι) :
    ∑ b, blockW T A B G a b * f b
      = if a ∈ T then A * (∑ b ∈ T, f b - f a) + G * ∑ b ∈ Tᶜ, f b
        else G * ∑ b ∈ T, f b + B * (∑ b ∈ Tᶜ, f b - f a) := by
  rw [← Finset.sum_add_sum_compl T]
  by_cases ha : a ∈ T
  · rw [if_pos ha]
    have h1 : ∑ b ∈ T, blockW T A B G a b * f b = A * (∑ b ∈ T, f b - f a) := by
      have e : ∀ b ∈ T, blockW T A B G a b * f b = A * f b - (if b = a then A * f b else 0) := fun b hb => by
        by_cases hba : b = a
        · subst hba; simp [blockW]
        · simp [blockW, Ne.symm hba, ha, hb, hba]
      rw [Finset.sum_congr rfl e, Finset.sum_sub_distrib, Finset.sum_ite_eq' T a, if_pos ha, ← Finset.mul_sum]; ring
    have h2 : ∑ b ∈ Tᶜ, blockW T A B G a b * f b = G * ∑ b ∈ Tᶜ, f b := by
      rw [Finset.mul_sum]
      refine Finset.sum_congr rfl fun b hb => ?_
      have hbT := Finset.mem_compl.mp hb
      have hab : a ≠ b := fun e => hbT (e ▸ ha)
      simp [blockW, hab, ha, hbT]
    rw [h1, h2]
  · rw [if_neg ha]
    have h1 : ∑ b ∈ T, blockW T A B G a b * f b = G * ∑ b ∈ T, f b := by
      rw [Finset.mul_sum]
      refine Finset.sum_congr rfl fun b hb => ?_
      have hab : a ≠ b := fun e => ha (e ▸ hb)
      simp [blockW, hab, ha, hb]
    have h2 : ∑ b ∈ Tᶜ, blockW T A B G a b * f b = B * (∑ b ∈ Tᶜ, f b - f a) := by
      have haT : a ∈ Tᶜ := Finset.mem_compl.mpr ha
      have e : ∀ b ∈ Tᶜ, blockW T A B G a b * f b = B * f b - (if b = a then B * f b else 0) := fun b hb => by
        have hbT := Finset.mem_compl.mp hb
        by_cases hba : b = a
        · subst hba; simp [blockW]
        · simp [blockW, Ne.symm hba, ha, hbT, hba]
      rw [Finset.sum_congr rfl e, Finset.sum_sub_distrib, Finset.sum_ite_eq' Tᶜ a, if_pos haT, ← Finset.mul_sum]; ring
    rw [h1, h2]

/-- `(w u)_{ac}` and `(u w)_{ac}` for a block weight, through `sum_blockW_mul`. -/
theorem mul_blockW_left (T : Finset ι) (A B G : ℝ) (u : Matrix ι ι ℝ) (a c : ι) :
    (blockW T A B G * u) a c = if a ∈ T then A * (∑ b ∈ T, u b c - u a c) + G * ∑ b ∈ Tᶜ, u b c
      else G * ∑ b ∈ T, u b c + B * (∑ b ∈ Tᶜ, u b c - u a c) := by
  rw [Matrix.mul_apply]; exact sum_blockW_mul T A B G (fun b => u b c) a

theorem mul_blockW_right (T : Finset ι) (A B G : ℝ) (u : Matrix ι ι ℝ) (a c : ι) :
    (u * blockW T A B G) a c = if c ∈ T then A * (∑ b ∈ T, u a b - u a c) + G * ∑ b ∈ Tᶜ, u a b
      else G * ∑ b ∈ T, u a b + B * (∑ b ∈ Tᶜ, u a b - u a c) := by
  rw [Matrix.mul_apply]
  rw [show ∑ b, u a b * blockW T A B G b c = ∑ b, blockW T A B G c b * u a b from
    Finset.sum_congr rfl fun b _ => by rw [blockW_symm, mul_comm]]
  exact sum_blockW_mul T A B G (fun b => u a b) c

/-- The cross weights `u_{ac} = x_a y_c` across `T`, symmetric. -/
noncomputable def crossW (T : Finset ι) (x y : ι → ℝ) : Matrix ι ι ℝ :=
  Matrix.of fun a b => if a ∈ T ∧ b ∉ T then x a * y b else if a ∉ T ∧ b ∈ T then x b * y a else 0

/-- **The cross family**: with `∑_T x = ∑_{Tᶜ} y = 0`, `K (crossW) = (G − (A + B)/2) crossW`. -/
theorem K_cross (T : Finset ι) (A B G : ℝ) (x y : ι → ℝ) (hx : ∑ b ∈ T, x b = 0) (hy : ∑ b ∈ Tᶜ, y b = 0)
    (a c : ι) : Kmat (blockW T A B G) (crossW T x y) a c = (G - (A + B) / 2) * crossW T x y a c := by
  -- the four column and row sums of `crossW`
  have cT : ∀ c, ∑ b ∈ T, crossW T x y b c = if c ∉ T then (∑ b ∈ T, x b) * y c else 0 := fun c => by
    by_cases hc : c ∈ T
    · rw [if_neg (not_not.mpr hc)]; exact Finset.sum_eq_zero fun b hb => by simp [crossW, hb, hc]
    · rw [if_pos hc, Finset.sum_mul]; exact Finset.sum_congr rfl fun b hb => by simp [crossW, hb, hc]
  have cTc : ∀ c, ∑ b ∈ Tᶜ, crossW T x y b c = if c ∈ T then (∑ b ∈ Tᶜ, y b) * x c else 0 := fun c => by
    by_cases hc : c ∈ T
    · rw [if_pos hc, Finset.sum_mul]
      exact Finset.sum_congr rfl fun b hb => by simp [crossW, Finset.mem_compl.mp hb, hc, mul_comm]
    · rw [if_neg hc]
      exact Finset.sum_eq_zero fun b hb => by simp [crossW, Finset.mem_compl.mp hb, hc]
  have rT : ∀ a, ∑ b ∈ T, crossW T x y a b = if a ∉ T then (∑ b ∈ T, x b) * y a else 0 := fun a => by
    by_cases ha : a ∈ T
    · rw [if_neg (not_not.mpr ha)]; exact Finset.sum_eq_zero fun b hb => by simp [crossW, hb, ha]
    · rw [if_pos ha, Finset.sum_mul]; exact Finset.sum_congr rfl fun b hb => by simp [crossW, hb, ha]
  have rTc : ∀ a, ∑ b ∈ Tᶜ, crossW T x y a b = if a ∈ T then (∑ b ∈ Tᶜ, y b) * x a else 0 := fun a => by
    by_cases ha : a ∈ T
    · rw [if_pos ha, Finset.sum_mul]
      exact Finset.sum_congr rfl fun b hb => by simp [crossW, Finset.mem_compl.mp hb, ha, mul_comm]
    · rw [if_neg ha]
      exact Finset.sum_eq_zero fun b hb => by simp [crossW, Finset.mem_compl.mp hb, ha]
  simp only [Kmat, Matrix.of_apply, mul_blockW_left, mul_blockW_right, cT, cTc, rT, rTc, hx, hy, zero_mul]
  by_cases ha : a ∈ T <;> by_cases hc : c ∈ T <;> by_cases hac : a = c <;>
    simp [ha, hc, hac, blockW, crossW] <;> ring

/-- **The zero family**: a symmetric weight supported inside `T` with zero row sums there has `K u = 0`. -/
theorem K_zero (T : Finset ι) (A B G : ℝ) (u : Matrix ι ι ℝ) (hu : ∀ a b, u a b = u b a) (hhu : ∀ a, u a a = 0)
    (hsupp : ∀ a b, (a ∉ T ∨ b ∉ T) → u a b = 0) (hrow : ∀ a ∈ T, ∑ b ∈ T, u a b = 0) (a c : ι) :
    Kmat (blockW T A B G) u a c = 0 := by
  have cT : ∀ c, ∑ b ∈ T, u b c = 0 := fun c => by
    by_cases hc : c ∈ T
    · rw [Finset.sum_congr rfl (fun b _ => hu b c)]; exact hrow c hc
    · exact Finset.sum_eq_zero fun b _ => hsupp b c (Or.inr hc)
  have cTc : ∀ c, ∑ b ∈ Tᶜ, u b c = 0 := fun c =>
    Finset.sum_eq_zero fun b hb => hsupp b c (Or.inl (Finset.mem_compl.mp hb))
  have rT : ∀ a, ∑ b ∈ T, u a b = 0 := fun a => by
    rw [Finset.sum_congr rfl (fun b _ => hu a b)]; exact cT a
  have rTc : ∀ a, ∑ b ∈ Tᶜ, u a b = 0 := fun a => by
    rw [Finset.sum_congr rfl (fun b _ => hu a b)]; exact cTc a
  simp only [Kmat, Matrix.of_apply, mul_blockW_left, mul_blockW_right, cT, cTc, rT, rTc]
  by_cases ha : a ∈ T <;> by_cases hc : c ∈ T
  · by_cases hac : a = c
    · subst hac; simp [ha, blockW, hhu]
    · simp [ha, hc, hac, blockW]; ring
  · simp [ha, hc, hsupp a c (Or.inr hc)]
  · simp [ha, hc, hsupp a c (Or.inl ha)]
  · simp [ha, hc, hsupp a c (Or.inl ha)]

/-- The `λ_p` weights: `h_a + h_b` within `T`, `κ h_a` across, zero within `Tᶜ`. -/
noncomputable def lamW (T : Finset ι) (κ : ℝ) (h : ι → ℝ) : Matrix ι ι ℝ :=
  Matrix.of fun a b => if a = b then 0 else if a ∈ T ∧ b ∈ T then h a + h b
    else if a ∈ T ∧ b ∉ T then κ * h a else if a ∉ T ∧ b ∈ T then κ * h b else 0

omit [Fintype ι] in
theorem lamW_symm (T : Finset ι) (κ : ℝ) (h : ι → ℝ) (a b : ι) : lamW T κ h a b = lamW T κ h b a := by
  unfold lamW; simp only [Matrix.of_apply]
  by_cases hab : a = b
  · subst hab; rfl
  · by_cases ha : a ∈ T <;> by_cases hb : b ∈ T <;> simp [hab, Ne.symm hab, ha, hb, add_comm]

omit [Fintype ι] in
/-- The column sums of the `λ_p` weights. -/
theorem lamW_colT (T : Finset ι) (κ : ℝ) (h : ι → ℝ) (hh : ∑ b ∈ T, h b = 0) (c : ι) :
    ∑ b ∈ T, lamW T κ h b c = if c ∈ T then ((T.card : ℝ) - 2) * h c else 0 := by
  by_cases hc : c ∈ T
  · rw [if_pos hc]
    have e : ∀ b ∈ T, lamW T κ h b c = (h b + h c) - (if b = c then h c + h c else 0) := fun b hb => by
      by_cases hbc : b = c
      · subst hbc; simp [lamW]
      · simp [lamW, hbc, hb, hc]
    rw [Finset.sum_congr rfl e, Finset.sum_sub_distrib, Finset.sum_add_distrib, hh, Finset.sum_const, nsmul_eq_mul,
      Finset.sum_ite_eq' T c, if_pos hc]
    ring
  · rw [if_neg hc]
    have e : ∀ b ∈ T, lamW T κ h b c = κ * h b := fun b hb => by
      have hbc : b ≠ c := fun e => hc (e ▸ hb)
      simp [lamW, hbc, hb, hc]
    rw [Finset.sum_congr rfl e, ← Finset.mul_sum, hh, mul_zero]

theorem lamW_colTc (T : Finset ι) (κ : ℝ) (h : ι → ℝ) (c : ι) :
    ∑ b ∈ Tᶜ, lamW T κ h b c = if c ∈ T then (Tᶜ.card : ℝ) * κ * h c else 0 := by
  by_cases hc : c ∈ T
  · rw [if_pos hc]
    have e : ∀ b ∈ Tᶜ, lamW T κ h b c = κ * h c := fun b hb => by
      have hbT := Finset.mem_compl.mp hb
      have hbc : b ≠ c := fun e => hbT (e ▸ hc)
      simp [lamW, hbc, hbT, hc]
    rw [Finset.sum_congr rfl e, Finset.sum_const, nsmul_eq_mul]; ring
  · rw [if_neg hc]
    exact Finset.sum_eq_zero fun b hb => by
      have hbT := Finset.mem_compl.mp hb
      by_cases hbc : b = c
      · subst hbc; simp [lamW]
      · simp [lamW, hbc, hbT, hc]

/-- **The `λ_p` family**: with `∑_T h = 0`, `κ q = −(p − 2)` and the two row-sum relations `(p − 1)A + qG = 0`,
`(q − 1)B + pG = 0`, the `λ_p` weights satisfy `K u = ½(p − 2)(A − G) u` off the diagonal. -/
theorem K_lam (T : Finset ι) (A B G κ : ℝ) (h : ι → ℝ) (hh : ∑ b ∈ T, h b = 0)
    (hκ : κ * (Tᶜ.card : ℝ) = -((T.card : ℝ) - 2)) (hr1 : ((T.card : ℝ) - 1) * A + (Tᶜ.card : ℝ) * G = 0)
    (hr2 : ((Tᶜ.card : ℝ) - 1) * B + (T.card : ℝ) * G = 0) {a c : ι} (hac : a ≠ c) :
    Kmat (blockW T A B G) (lamW T κ h) a c = (1 / 2) * ((T.card : ℝ) - 2) * (A - G) * lamW T κ h a c := by
  have rT : ∀ a, ∑ b ∈ T, lamW T κ h a b = if a ∈ T then ((T.card : ℝ) - 2) * h a else 0 := fun a => by
    rw [Finset.sum_congr rfl (fun b _ => lamW_symm T κ h a b)]; exact lamW_colT T κ h hh a
  have rTc : ∀ a, ∑ b ∈ Tᶜ, lamW T κ h a b = if a ∈ T then (Tᶜ.card : ℝ) * κ * h a else 0 := fun a => by
    rw [Finset.sum_congr rfl (fun b _ => lamW_symm T κ h a b)]; exact lamW_colTc T κ h a
  simp only [Kmat, Matrix.of_apply, mul_blockW_left, mul_blockW_right, lamW_colT T κ h hh, lamW_colTc T κ h, rT, rTc]
  by_cases ha : a ∈ T <;> by_cases hc : c ∈ T
  · simp [ha, hc, hac, blockW, lamW]
    linear_combination ((1 / 2 : ℝ) * G * (h a + h c)) * hκ
  · simp [ha, hc, hac, blockW, lamW]
    linear_combination (-(1 / 2 : ℝ) * κ * h a) * hr1 + ((1 / 2 : ℝ) * κ * h a) * hr2
      + ((1 / 2 : ℝ) * G * h a) * hκ
  · simp [ha, hc, hac, blockW, lamW]
    linear_combination (-(1 / 2 : ℝ) * κ * h c) * hr1 + ((1 / 2 : ℝ) * κ * h c) * hr2
      + ((1 / 2 : ℝ) * G * h c) * hκ
  · simp [ha, hc, hac, blockW, lamW]

end HamiltonsCubic.Results
