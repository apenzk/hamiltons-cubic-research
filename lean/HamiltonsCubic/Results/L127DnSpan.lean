import HamiltonsCubic.Results.L127DnUnits
import HamiltonsCubic.Results.L127Within
import HamiltonsCubic.Results.L131Whole

set_option linter.style.longLine false

/-!
# L127's `𝒟ₙ` families span the weights

[findings/second-order.md](../../../findings/second-order.md), Lemma L127's table, `𝒟ₙ` row:
`σ(L_e|_{𝒟ₙ}) = {1, λ_p^{p−1}, λ_q^{q−1}, (−μ)^{(p−1)(q−1)}, 0^{rest}}`. [L127DnUnits.lean](L127DnUnits.lean) gives each
value an eigen-family. This file shows the families exhaust `𝒟ₙ`: every weight is a sum of one member of each at `p, q ≥ 2`,
so at `p, q ≥ 2` `M ∘` on `𝒟ₙ` is spanned by eigenvectors with these eigenvalues.

* **`IsCrossW`**, **`K_crossW`**: a symmetric weight supported across `T` with zero block row sums has
  `K u = (G − (A + B)/2) u`, the cross family taken as a whole subspace;
* **`IsWithinW`**: a symmetric hollow weight supported inside `T` with zero row sums there, `K_zero`'s family;
* **`dnM`**, **`dnH`**, **`dnR`**: the cross mean, the `λ_p` coefficients and the residual of a weight, all read off
  its entries;
* **`dnR_rows`**: the residual's block row sums vanish at `|S|, |Sᶜ| ≥ 2`;
* **`dn_decomp2`** (`dn_decomp` its `p, q ≥ 3` form): at `p, q ≥ 2` every weight `u` is `c · w₁ + λ_p-weight + λ_q-weight + cross + within T + within
  Tᶜ`, `w₁` the unit sphere weight;
* **`lamW_two_eq_zero`**, **`within_two_eq_zero`**: at `|S| = 2` the `λ` member and the zero family inside `S`
  vanish;
* **`dn_spectrum`**: at the sphere product with `p, q ≥ 2` each of the six summands is an eigenvector of `M ∘` on every `φ_{ab}`, with
  eigenvalue `θ` times `1`, `λ_p`, `λ_q`, `−μ`, `0`, `0`.

* **`lamW_isWeight`**, **`IsCrossW.isWeight`**, **`IsWithinW.isWeight`**: the families lie in `𝒟ₙ`'s weights;
* **`isLinOp_foxProd`**, **`eig_all_of_phi`**: `M ∘` is linear in the bivector, so each eigen-relation on the `φ_{ab}`
  holds on every bivector.

[L127DnExcl.lean](L127DnExcl.lean) draws the consequence that no other eigenvalue occurs. [L127DnDim.lean](L127DnDim.lean),
[L127DnEig.lean](L127DnEig.lean) and [L127DnLam.lean](L127DnLam.lean) give the families' dimensions and the eigenspaces. `dn_decomp2` and `dnR_rows` hold at `p, q ≥ 2`:
at `|S| = 2` the `λ` coefficients `dnH` divide by `0` and vanish, and the two rows of `S` force
`∑_{Sᶜ} u_{a·} = |Sᶜ| m`.
-/

namespace HamiltonsCubic.Results

open Finset HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer HamiltonsCubic.WeylRadical HamiltonsCubic.L126Assembly

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- The cross family as a subspace: symmetric, supported across `T`, zero block row sums. -/
def IsCrossW (T : Finset ι) (X : Matrix ι ι ℝ) : Prop :=
  (∀ a b, X a b = X b a) ∧ (∀ a b, (a ∈ T ↔ b ∈ T) → X a b = 0) ∧ (∀ a ∈ T, ∑ b ∈ Tᶜ, X a b = 0) ∧
    (∀ a ∉ T, ∑ b ∈ T, X a b = 0)

/-- The zero family inside `T`: symmetric, hollow, supported in `T`, zero row sums there. -/
def IsWithinW (T : Finset ι) (Z : Matrix ι ι ℝ) : Prop :=
  (∀ a b, Z a b = Z b a) ∧ (∀ a, Z a a = 0) ∧ (∀ a b, (a ∉ T ∨ b ∉ T) → Z a b = 0) ∧ (∀ a ∈ T, ∑ b ∈ T, Z a b = 0)

/-- **The whole cross family**: `K u = (G − (A + B)/2) u`. -/
theorem K_crossW (T : Finset ι) (A B G : ℝ) {X : Matrix ι ι ℝ} (hX : IsCrossW T X) (a c : ι) :
    Kmat (blockW T A B G) X a c = (G - (A + B) / 2) * X a c := by
  obtain ⟨hs, hsupp, hr1, hr2⟩ := hX
  have rT : ∀ a, ∑ b ∈ T, X a b = 0 := fun a => by
    by_cases ha : a ∈ T
    · exact Finset.sum_eq_zero fun b hb => hsupp a b (iff_of_true ha hb)
    · exact hr2 a ha
  have rTc : ∀ a, ∑ b ∈ Tᶜ, X a b = 0 := fun a => by
    by_cases ha : a ∈ T
    · exact hr1 a ha
    · exact Finset.sum_eq_zero fun b hb => hsupp a b (iff_of_false ha (Finset.mem_compl.mp hb))
  have cT : ∀ c, ∑ b ∈ T, X b c = 0 := fun c => by
    rw [Finset.sum_congr rfl fun b _ => hs b c]; exact rT c
  have cTc : ∀ c, ∑ b ∈ Tᶜ, X b c = 0 := fun c => by
    rw [Finset.sum_congr rfl fun b _ => hs b c]; exact rTc c
  simp only [Kmat, Matrix.of_apply, mul_blockW_left, mul_blockW_right, cT, cTc, rT, rTc]
  by_cases ha : a ∈ T <;> by_cases hc : c ∈ T
  · simp [ha, hc, hsupp a c (iff_of_true ha hc)]
  · have hac : a ≠ c := fun e => hc (e ▸ ha)
    simp [ha, hc, hac, blockW]; ring
  · have hac : a ≠ c := fun e => ha (e ▸ hc)
    simp [ha, hc, hac, blockW]; ring
  · simp [ha, hc, hsupp a c (iff_of_false ha hc)]

omit [Fintype ι] in
/-- The block row sums of a block weight: `(|S| − 1) A` within, `|Sᶜ| G` across. -/
theorem blockW_row_in (S : Finset ι) (A B G : ℝ) {a : ι} (ha : a ∈ S) :
    ∑ b ∈ S, blockW S A B G a b = ((S.card : ℝ) - 1) * A := by
  have e : ∀ b ∈ S, blockW S A B G a b = A - (if b = a then A else 0) := fun b hb => by
    by_cases hba : b = a
    · subst hba; simp [blockW]
    · simp [blockW, Ne.symm hba, ha, hb, hba]
  rw [Finset.sum_congr rfl e, Finset.sum_sub_distrib, Finset.sum_ite_eq' S a, if_pos ha, Finset.sum_const,
    nsmul_eq_mul]; ring

theorem blockW_row_out (S : Finset ι) (A B G : ℝ) {a : ι} (ha : a ∈ S) :
    ∑ b ∈ Sᶜ, blockW S A B G a b = (Sᶜ.card : ℝ) * G := by
  rw [Finset.sum_congr rfl fun b hb => (show blockW S A B G a b = G by
    have hbS := Finset.mem_compl.mp hb
    have hab : a ≠ b := fun e => hbS (e ▸ ha)
    simp [blockW, hab, ha, hbS]), Finset.sum_const, nsmul_eq_mul]

/-- The cross mean of a weight. -/
noncomputable def dnM (S : Finset ι) (u : Matrix ι ι ℝ) : ℝ :=
  (∑ a ∈ S, ∑ c ∈ Sᶜ, u a c) / ((S.card : ℝ) * Sᶜ.card)

/-- The `λ_p` coefficients of a weight: `(|Sᶜ| m − ∑_{Sᶜ} u_{a·})/(|S| − 2)`. -/
noncomputable def dnH (S : Finset ι) (u : Matrix ι ι ℝ) (a : ι) : ℝ :=
  ((Sᶜ.card : ℝ) * dnM S u - ∑ c ∈ Sᶜ, u a c) / ((S.card : ℝ) - 2)

/-- The `λ_p` ratio `κ = −(|S| − 2)/|Sᶜ|`. -/
noncomputable def dnK (S : Finset ι) : ℝ := -((S.card : ℝ) - 2) / Sᶜ.card

/-- The residual after the eigenvalue-`1` and both `λ` parts are removed. -/
noncomputable def dnR (S : Finset ι) (u : Matrix ι ι ℝ) : Matrix ι ι ℝ :=
  u - (-dnM S u) • sphereWeight S - lamW S (dnK S) (dnH S u) - lamW Sᶜ (dnK Sᶜ) (dnH Sᶜ u)

theorem dnM_compl (S : Finset ι) {u : Matrix ι ι ℝ} (hu : ∀ a b, u a b = u b a) : dnM Sᶜ u = dnM S u := by
  unfold dnM
  rw [compl_compl, mul_comm]
  congr 1
  exact Finset.sum_comm.trans (Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun c _ => hu c a)

theorem dnH_sum (S : Finset ι) (u : Matrix ι ι ℝ) (hS : (S.card : ℝ) * Sᶜ.card ≠ 0) :
    ∑ a ∈ S, dnH S u a = 0 := by
  obtain ⟨h1, h2⟩ := mul_ne_zero_iff.mp hS
  unfold dnH dnM
  rw [← Finset.sum_div, Finset.sum_sub_distrib, Finset.sum_const, nsmul_eq_mul]
  field_simp
  ring

theorem dnR_compl (S : Finset ι) {u : Matrix ι ι ℝ} (hu : ∀ a b, u a b = u b a) : dnR Sᶜ u = dnR S u := by
  unfold dnR
  rw [dnM_compl S hu, HamiltonsCubic.L121Block.sphereWeight_compl, compl_compl]
  abel

theorem dnR_symm (S : Finset ι) {u : Matrix ι ι ℝ} (hu : IsWeight u) (a b : ι) : dnR S u a b = dnR S u b a := by
  simp only [dnR, Matrix.sub_apply, Matrix.smul_apply, smul_eq_mul, hu.symm a b, sphereWeight_symm S a b,
    lamW_symm S _ _ a b, lamW_symm Sᶜ _ _ a b]

theorem dnR_hollow (S : Finset ι) {u : Matrix ι ι ℝ} (hu : IsWeight u) (a : ι) : dnR S u a a = 0 := by
  simp [dnR, hu.hollow a, sphereWeight_hollow, lamW]

/-- **The residual's block row sums vanish**, at `|S|, |Sᶜ| ≥ 2`. At `|S| = 2` the `λ` coefficients `dnH` divide by
`0` and vanish, and the two rows of `S` force `∑_{Sᶜ} u_{a·} = |Sᶜ| m`, which is what the sums need. -/
theorem dnR_rows (S : Finset ι) {u : Matrix ι ι ℝ} (hu : IsWeight u) (hp : 2 ≤ S.card) (hq : 2 ≤ Sᶜ.card) {a : ι}
    (ha : a ∈ S) : ∑ b ∈ S, dnR S u a b = 0 ∧ ∑ b ∈ Sᶜ, dnR S u a b = 0 := by
  have hp' : (2 : ℝ) ≤ S.card := by exact_mod_cast hp
  have hq' : (2 : ℝ) ≤ Sᶜ.card := by exact_mod_cast hq
  have hp1 : (S.card : ℝ) - 1 ≠ 0 := by intro h; linarith
  have hq0 : (Sᶜ.card : ℝ) ≠ 0 := by intro h; linarith
  have haS : a ∉ Sᶜ := fun h => (Finset.mem_compl.mp h) ha
  have hsumS := dnH_sum S u (mul_ne_zero (by intro h; linarith) hq0)
  have hsumSc : ∑ b ∈ Sᶜ, dnH Sᶜ u b = 0 := dnH_sum Sᶜ u (by rw [compl_compl]; exact mul_ne_zero hq0 (by intro h; linarith))
  have hsw : sphereWeight S = blockW S ((Sᶜ.card : ℝ) / ((S.card : ℝ) - 1)) ((S.card : ℝ) / ((Sᶜ.card : ℝ) - 1)) (-1) := by
    have := smul_sphereWeight_eq S 1; simpa using this
  have lamS : ∑ b ∈ S, lamW S (dnK S) (dnH S u) a b = ((S.card : ℝ) - 2) * dnH S u a := by
    rw [Finset.sum_congr rfl fun b _ => lamW_symm S _ _ a b, lamW_colT S _ _ hsumS a, if_pos ha]
  have lamSc : ∑ b ∈ Sᶜ, lamW S (dnK S) (dnH S u) a b = (Sᶜ.card : ℝ) * dnK S * dnH S u a := by
    rw [Finset.sum_congr rfl fun b _ => lamW_symm S _ _ a b, lamW_colTc S _ _ a, if_pos ha]
  have lam'S : ∑ b ∈ S, lamW Sᶜ (dnK Sᶜ) (dnH Sᶜ u) a b = 0 := by
    have h := lamW_colTc Sᶜ (dnK Sᶜ) (dnH Sᶜ u) a
    rw [compl_compl, if_neg haS] at h
    rw [Finset.sum_congr rfl fun b _ => lamW_symm Sᶜ _ _ a b]; exact h
  have lam'Sc : ∑ b ∈ Sᶜ, lamW Sᶜ (dnK Sᶜ) (dnH Sᶜ u) a b = 0 := by
    rw [Finset.sum_congr rfl fun b _ => lamW_symm Sᶜ _ _ a b, lamW_colT Sᶜ _ _ hsumSc a, if_neg haS]
  have uS : ∑ b ∈ S, u a b = -∑ b ∈ Sᶜ, u a b := by
    have := hu.rowSum a; rw [← Finset.sum_add_sum_compl S] at this; linarith
  have swS : ∑ b ∈ S, sphereWeight S a b = Sᶜ.card := by
    rw [hsw, blockW_row_in S _ _ _ ha]; field_simp
  have swSc : ∑ b ∈ Sᶜ, sphereWeight S a b = -(Sᶜ.card : ℝ) := by
    rw [hsw, blockW_row_out S _ _ _ ha]; ring
  unfold dnR
  simp only [Matrix.sub_apply, Matrix.smul_apply, smul_eq_mul, Finset.sum_sub_distrib, ← Finset.mul_sum]
  rw [swS, swSc, lamS, lamSc, lam'S, lam'Sc, uS]
  by_cases hp2 : (S.card : ℝ) - 2 = 0
  · have hc2 : S.card = 2 := by have : (S.card : ℝ) = 2 := by linarith
                                exact_mod_cast this
    have key : ∑ b ∈ Sᶜ, u a b = (Sᶜ.card : ℝ) * dnM S u := by
      obtain ⟨x, y, hxy, hS⟩ := Finset.card_eq_two.mp hc2
      subst hS
      have rS : ∀ a' ∈ ({x, y} : Finset ι), ∑ b ∈ ({x, y} : Finset ι)ᶜ, u a' b = -∑ b ∈ ({x, y} : Finset ι), u a' b :=
        fun a' _ => by
          have := hu.rowSum a'; rw [← Finset.sum_add_sum_compl ({x, y} : Finset ι)] at this; linarith
      have rx : ∑ b ∈ ({x, y} : Finset ι)ᶜ, u x b = -u x y := by
        rw [rS x (by simp), Finset.sum_pair hxy, hu.hollow]; ring
      have ry : ∑ b ∈ ({x, y} : Finset ι)ᶜ, u y b = -u x y := by
        rw [rS y (by simp), Finset.sum_pair hxy, hu.hollow, hu.symm y x]; ring
      have hc2' : (({x, y} : Finset ι).card : ℝ) = 2 := by exact_mod_cast hc2
      have hq0' : ((({x, y} : Finset ι)ᶜ).card : ℝ) ≠ 0 := hq0
      have hM : dnM {x, y} u = -u x y / ((({x, y} : Finset ι)ᶜ).card : ℝ) := by
        unfold dnM; rw [Finset.sum_pair hxy, rx, ry, hc2']; field_simp; ring
      rcases Finset.mem_insert.mp ha with rfl | hay
      · rw [rx, hM]; field_simp
      · rw [Finset.mem_singleton.mp hay, ry, hM]; field_simp
    unfold dnH dnK
    simp only [hp2, zero_mul, zero_div, neg_zero, mul_zero, div_zero, sub_zero]
    constructor <;> linarith [key]
  · unfold dnH dnK
    constructor <;> field_simp <;> ring

/-- **Every weight splits into the six families**, at `p, q ≥ 2`: the unit sphere weight's multiple, a `λ_p` weight,
a `λ_q` weight, a cross weight, and a zero weight inside each factor. At `p = 2` the `λ_p` weight and the zero weight
inside `T` vanish (`lamW_two_eq_zero`, `within_two_eq_zero`), and at `q = 2` their mirrors do. -/
theorem dn_decomp2 (T : Finset ι) {u : Matrix ι ι ℝ} (hu : IsWeight u) (hp : 2 ≤ T.card) (hq : 2 ≤ Tᶜ.card) :
    ∃ (c : ℝ) (h h' : ι → ℝ) (X Z Z' : Matrix ι ι ℝ), ∑ b ∈ T, h b = 0 ∧ ∑ b ∈ Tᶜ, h' b = 0 ∧ IsCrossW T X ∧
      IsWithinW T Z ∧ IsWithinW Tᶜ Z' ∧
      u = c • sphereWeight T + lamW T (dnK T) h + lamW Tᶜ (dnK Tᶜ) h' + X + Z + Z' := by
  have hp' : (2 : ℝ) ≤ T.card := by exact_mod_cast hp
  have hq' : (2 : ℝ) ≤ Tᶜ.card := by exact_mod_cast hq
  have hqc : 2 ≤ Tᶜᶜ.card := by rw [compl_compl]; exact hp
  have rowsT := fun {a} (ha : a ∈ T) => dnR_rows T hu hp hq ha
  have rowsTc : ∀ {a}, a ∈ Tᶜ → ∑ b ∈ Tᶜ, dnR T u a b = 0 ∧ ∑ b ∈ T, dnR T u a b = 0 := fun {a} ha => by
    have := dnR_rows Tᶜ hu hq hqc ha
    rwa [compl_compl, dnR_compl T hu.symm] at this
  have hR : ∀ a b, u a b = -dnM T u * sphereWeight T a b + lamW T (dnK T) (dnH T u) a b
      + lamW Tᶜ (dnK Tᶜ) (dnH Tᶜ u) a b + dnR T u a b := fun a b => by
    simp only [dnR, Matrix.sub_apply, Matrix.smul_apply, smul_eq_mul]; ring
  refine ⟨-dnM T u, dnH T u, dnH Tᶜ u, Matrix.of fun a b => if (a ∈ T ↔ b ∈ T) then 0 else dnR T u a b,
    Matrix.of fun a b => if a ∈ T ∧ b ∈ T then dnR T u a b else 0,
    Matrix.of fun a b => if a ∈ Tᶜ ∧ b ∈ Tᶜ then dnR T u a b else 0,
    dnH_sum T u (mul_ne_zero (by intro h; linarith) (by intro h; linarith)),
    dnH_sum Tᶜ u (by rw [compl_compl]; exact mul_ne_zero (by intro h; linarith) (by intro h; linarith)),
    ⟨fun a b => ?_, fun a b hab => ?_, fun a ha => ?_, fun a ha => ?_⟩,
    ⟨fun a b => ?_, fun a => ?_, fun a b hab => ?_, fun a ha => ?_⟩,
    ⟨fun a b => ?_, fun a => ?_, fun a b hab => ?_, fun a ha => ?_⟩, ?_⟩
  · simp only [Matrix.of_apply, dnR_symm T hu a b, Iff.comm]
  · simp [hab]
  · rw [← (rowsT ha).2]
    exact Finset.sum_congr rfl fun b hb => by
      simp [ha, Finset.mem_compl.mp hb]
  · rw [← (rowsTc (Finset.mem_compl.mpr ha)).2]
    exact Finset.sum_congr rfl fun b hb => by simp [ha, hb]
  · simp only [Matrix.of_apply, dnR_symm T hu a b, and_comm]
  · simp [dnR_hollow T hu a]
  · rcases hab with h | h <;> simp [h]
  · rw [← (rowsT ha).1]
    exact Finset.sum_congr rfl fun b hb => by simp [ha, hb]
  · simp only [Matrix.of_apply, dnR_symm T hu a b, and_comm]
  · simp [dnR_hollow T hu a]
  · rcases hab with h | h <;> simp only [Finset.mem_compl, not_not] at h <;> simp [h]
  · rw [← (rowsTc ha).1]
    exact Finset.sum_congr rfl fun b hb => by simp [Finset.mem_compl.mp ha, Finset.mem_compl.mp hb]
  · ext a b
    simp only [Matrix.add_apply, Matrix.smul_apply, smul_eq_mul, Matrix.of_apply, Finset.mem_compl]
    rw [hR a b]
    by_cases ha : a ∈ T <;> by_cases hb : b ∈ T <;> simp [ha, hb]

/-- **At `|S| = 2` the `λ` member vanishes**: `dnK S = 0` kills the cross entries, and `∑_S h = 0` on a pair makes the
within entry `h_x + h_y = 0`. -/
theorem lamW_two_eq_zero (S : Finset ι) (hS : S.card = 2) {h : ι → ℝ} (hh : ∑ b ∈ S, h b = 0) :
    lamW S (dnK S) h = 0 := by
  obtain ⟨x, y, hxy, rfl⟩ := Finset.card_eq_two.mp hS
  have hs : h x + h y = 0 := by rwa [Finset.sum_pair hxy] at hh
  have hK : dnK ({x, y} : Finset ι) = 0 := by
    unfold dnK; rw [hS]; norm_num
  ext a b
  simp only [lamW, hK, zero_mul, Matrix.of_apply, Matrix.zero_apply, Finset.mem_insert, Finset.mem_singleton]
  by_cases hab : a = b
  · simp [hab]
  · rw [if_neg hab]
    by_cases h1 : (a = x ∨ a = y) ∧ (b = x ∨ b = y)
    · rw [if_pos h1]
      rcases h1 with ⟨ha | ha, hb | hb⟩ <;> subst ha <;> subst hb
      · exact absurd rfl hab
      · exact hs
      · linarith
      · exact absurd rfl hab
    · rw [if_neg h1]; simp

omit [Fintype ι] in
/-- **At `|S| = 2` the zero family inside `S` is `{0}`**: row `x` gives `Z_xy = 0`. -/
theorem within_two_eq_zero (S : Finset ι) (hS : S.card = 2) {Z : Matrix ι ι ℝ} (hZ : IsWithinW S Z) : Z = 0 := by
  obtain ⟨x, y, hxy, rfl⟩ := Finset.card_eq_two.mp hS
  obtain ⟨hs, hh, hsupp, hrow⟩ := hZ
  have hxy0 : Z x y = 0 := by
    have := hrow x (by simp); rwa [Finset.sum_pair hxy, hh, zero_add] at this
  ext a b
  rw [Matrix.zero_apply]
  by_cases ha : a ∈ ({x, y} : Finset ι)
  · by_cases hb : b ∈ ({x, y} : Finset ι)
    · simp only [Finset.mem_insert, Finset.mem_singleton] at ha hb
      rcases ha with rfl | rfl <;> rcases hb with rfl | rfl
      · exact hh _
      · exact hxy0
      · rw [hs]; exact hxy0
      · exact hh _
    · exact hsupp a b (Or.inr hb)
  · exact hsupp a b (Or.inl ha)

/-- **Every weight splits into the six families**, at `p, q ≥ 3`. -/
theorem dn_decomp (T : Finset ι) {u : Matrix ι ι ℝ} (hu : IsWeight u) (hp : 3 ≤ T.card) (hq : 3 ≤ Tᶜ.card) :
    ∃ (c : ℝ) (h h' : ι → ℝ) (X Z Z' : Matrix ι ι ℝ), ∑ b ∈ T, h b = 0 ∧ ∑ b ∈ Tᶜ, h' b = 0 ∧ IsCrossW T X ∧
      IsWithinW T Z ∧ IsWithinW Tᶜ Z' ∧
      u = c • sphereWeight T + lamW T (dnK T) h + lamW Tᶜ (dnK Tᶜ) h' + X + Z + Z' :=
  dn_decomp2 T hu (by omega) (by omega)

/-- **The families lie in `𝒟ₙ`'s weights**: a `λ_p` weight is a weight. -/
theorem lamW_isWeight (T : Finset ι) (κ : ℝ) (h : ι → ℝ) (hh : ∑ b ∈ T, h b = 0)
    (hκ : κ * (Tᶜ.card : ℝ) = -((T.card : ℝ) - 2)) : IsWeight (lamW T κ h) where
  symm := lamW_symm T κ h
  hollow := fun a => by simp [lamW]
  rowSum := fun a => by
    have e1 : ∑ b ∈ T, lamW T κ h a b = ∑ b ∈ T, lamW T κ h b a :=
      Finset.sum_congr rfl fun b _ => lamW_symm T κ h a b
    have e2 : ∑ b ∈ Tᶜ, lamW T κ h a b = ∑ b ∈ Tᶜ, lamW T κ h b a :=
      Finset.sum_congr rfl fun b _ => lamW_symm T κ h a b
    rw [← Finset.sum_add_sum_compl T, e1, e2, lamW_colT T κ h hh a, lamW_colTc T κ h a]
    by_cases ha : a ∈ T
    · simp only [if_pos ha]; linear_combination h a * hκ
    · simp [ha]

/-- A cross weight is a weight. -/
theorem IsCrossW.isWeight {T : Finset ι} {X : Matrix ι ι ℝ} (hX : IsCrossW T X) : IsWeight X where
  symm := hX.1
  hollow := fun a => hX.2.1 a a Iff.rfl
  rowSum := fun a => by
    rw [← Finset.sum_add_sum_compl T]
    by_cases ha : a ∈ T
    · rw [hX.2.2.1 a ha, Finset.sum_eq_zero fun b hb => hX.2.1 a b (iff_of_true ha hb), add_zero]
    · rw [hX.2.2.2 a ha, Finset.sum_eq_zero fun b hb => hX.2.1 a b (iff_of_false ha (Finset.mem_compl.mp hb)),
        add_zero]

/-- A within weight is a weight. -/
theorem IsWithinW.isWeight {T : Finset ι} {Z : Matrix ι ι ℝ} (hZ : IsWithinW T Z) : IsWeight Z where
  symm := hZ.1
  hollow := hZ.2.1
  rowSum := fun a => by
    rw [← Finset.sum_add_sum_compl T, Finset.sum_eq_zero fun b hb => hZ.2.2.1 a b (Or.inr (Finset.mem_compl.mp hb)),
      add_zero]
    by_cases ha : a ∈ T
    · exact hZ.2.2.2 a ha
    · exact Finset.sum_eq_zero fun b _ => hZ.2.2.1 a b (Or.inl ha)

/-- `M ∘` at linear operators is linear in the bivector. -/
theorem isLinOp_foxProd {X Y : CurvOp ι} (hX : IsLinOp X) (hY : IsLinOp Y) : IsLinOp (foxProd X Y) := by
  have hs := HamiltonsCubic.L131Diag.isLinOp_sharpCross hX hY
  rw [foxProd_split X Y hX.1 hY.1]
  refine ⟨fun A B => ?_, fun c A => ?_⟩
  · unfold jordanProd; simp only [hY.1, hX.1, hs.1]; module
  · unfold jordanProd; simp only [hY.2, hX.2, hs.2]; module

/-- **From the basis to every bivector**: an eigen-relation of `M ∘ diagOp u` on every `φ_{ab}` holds on every
bivector. -/
theorem eig_all_of_phi (w u : Matrix ι ι ℝ) (ν : ℝ)
    (h : ∀ a b, foxProd (diagOp w) (diagOp u) (phi a b) = ν • diagOp u (phi a b)) {Z : Matrix ι ι ℝ} (hZ : IsSkew Z) :
    foxProd (diagOp w) (diagOp u) Z = ν • diagOp u Z :=
  HamiltonsCubic.L131Diag.eq_on_skew_of_phi (isLinOp_foxProd (isLinOp_diagOp w) (isLinOp_diagOp u))
    (HamiltonsCubic.L131Diag.isLinOp_smul_op ν (isLinOp_diagOp u)) h hZ

omit [DecidableEq ι] in
theorem Kmat_smul_left (w u : Matrix ι ι ℝ) (c : ℝ) (a b : ι) : Kmat (c • w) u a b = c * Kmat w u a b := by
  simp only [Kmat, Matrix.of_apply, Matrix.smul_apply, smul_eq_mul, Matrix.smul_mul, Matrix.mul_smul]; ring

omit [DecidableEq ι] in
theorem Kmat_smul_right (w u : Matrix ι ι ℝ) (c : ℝ) (a b : ι) : Kmat w (c • u) a b = c * Kmat w u a b := by
  simp only [Kmat, Matrix.of_apply, Matrix.smul_apply, smul_eq_mul, Matrix.smul_mul, Matrix.mul_smul]; ring

section sphere

variable (T : Finset ι) (hp : 2 ≤ T.card) (hq : 2 ≤ Tᶜ.card) (t : ℝ)

include hp hq in
/-- **`1` on the sphere-weight line**, at every multiple `c`. -/
theorem sphere_line (c : ℝ) (a b : ι) :
    foxProd (diagOp (t • sphereWeight T)) (diagOp (c • sphereWeight T)) (phi a b)
      = (t * ((T.card : ℝ) + Tᶜ.card - 1) * 1) • diagOp (c • sphereWeight T) (phi a b) := by
  have hc1 := sphere_diagCrit T (by omega) (by omega) 1
  have hc := sphere_diagCrit T (by omega) (by omega) t
  have hsym : ∀ p q, (c • sphereWeight T) p q = (c • sphereWeight T) q p := fun p q => by
    simp [sphereWeight_symm T p q]
  refine sphere_eig _ _ hc.1 hsym hc.2.1 (fun a => by simp [sphereWeight_hollow]) _ (fun a d had => ?_) a b
  have k := K_self hc1 had
  simp only [one_smul] at k
  rw [Kmat_smul_left, Kmat_smul_right, k, Matrix.smul_apply, smul_eq_mul]; ring

include hp hq in
/-- **`−μ` on the whole cross family.** -/
theorem sphere_crossW {X : Matrix ι ι ℝ} (hX : IsCrossW T X) (a b : ι) :
    foxProd (diagOp (t • sphereWeight T)) (diagOp X) (phi a b)
      = (t * ((T.card : ℝ) + Tᶜ.card - 1) * (-(((T.card : ℝ) + Tᶜ.card - 2)
          / (2 * ((T.card : ℝ) - 1) * ((Tᶜ.card : ℝ) - 1))))) • diagOp X (phi a b) := by
  have hp' : (2 : ℝ) ≤ T.card := by exact_mod_cast hp
  have hq' : (2 : ℝ) ≤ Tᶜ.card := by exact_mod_cast hq
  have h1 : (T.card : ℝ) - 1 ≠ 0 := by intro h; linarith
  have h2 : (Tᶜ.card : ℝ) - 1 ≠ 0 := by intro h; linarith
  have hc := sphere_diagCrit T (by omega) (by omega) t
  have hhol : ∀ a, X a a = 0 := fun a => hX.2.1 a a Iff.rfl
  refine sphere_eig _ _ hc.1 hX.1 hc.2.1 hhol _ (fun a c _ => ?_) a b
  rw [smul_sphereWeight_eq, K_crossW T _ _ _ hX]
  congr 1
  field_simp
  ring

include hp hq in
/-- **The spectrum of `M ∘` on `𝒟ₙ` at a sphere product**, `p, q ≥ 2`: every weight is a sum of six weights, each an
eigenvector on every `φ_{ab}` with eigenvalue `θ` times `1`, `λ_p`, `λ_q`, `−μ`, `0`, `0`, `θ = t(p + q − 1)`. -/
theorem dn_spectrum {u : Matrix ι ι ℝ} (hu : IsWeight u) :
    ∃ (c : ℝ) (h h' : ι → ℝ) (X Z Z' : Matrix ι ι ℝ),
      u = c • sphereWeight T + lamW T (dnK T) h + lamW Tᶜ (dnK Tᶜ) h' + X + Z + Z' ∧
      (∀ a b, foxProd (diagOp (t • sphereWeight T)) (diagOp (c • sphereWeight T)) (phi a b)
        = (t * ((T.card : ℝ) + Tᶜ.card - 1) * 1) • diagOp (c • sphereWeight T) (phi a b)) ∧
      (∀ a b, foxProd (diagOp (t • sphereWeight T)) (diagOp (lamW T (dnK T) h)) (phi a b)
        = (t * ((T.card : ℝ) + Tᶜ.card - 1) * (((T.card : ℝ) - 2) / (2 * ((T.card : ℝ) - 1))))
          • diagOp (lamW T (dnK T) h) (phi a b)) ∧
      (∀ a b, foxProd (diagOp (t • sphereWeight T)) (diagOp (lamW Tᶜ (dnK Tᶜ) h')) (phi a b)
        = (t * ((T.card : ℝ) + Tᶜ.card - 1) * (((Tᶜ.card : ℝ) - 2) / (2 * ((Tᶜ.card : ℝ) - 1))))
          • diagOp (lamW Tᶜ (dnK Tᶜ) h') (phi a b)) ∧
      (∀ a b, foxProd (diagOp (t • sphereWeight T)) (diagOp X) (phi a b)
        = (t * ((T.card : ℝ) + Tᶜ.card - 1) * (-(((T.card : ℝ) + Tᶜ.card - 2)
          / (2 * ((T.card : ℝ) - 1) * ((Tᶜ.card : ℝ) - 1))))) • diagOp X (phi a b)) ∧
      (∀ a b, foxProd (diagOp (t • sphereWeight T)) (diagOp Z) (phi a b) = (0 : ℝ) • diagOp Z (phi a b)) ∧
      (∀ a b, foxProd (diagOp (t • sphereWeight T)) (diagOp Z') (phi a b) = (0 : ℝ) • diagOp Z' (phi a b)) := by
  obtain ⟨c, h, h', X, Z, Z', hh, hh', hX, hZ, hZ', he⟩ := dn_decomp2 T hu hp hq
  have hK' : dnK Tᶜ = -((Tᶜ.card : ℝ) - 2) / T.card := by unfold dnK; rw [compl_compl]
  refine ⟨c, h, h', X, Z, Z', he, sphere_line T hp hq t c, fun a b => ?_, fun a b => ?_,
    sphere_crossW T hp hq t hX, sphere_zero T (by omega) (by omega) t Z hZ.1 hZ.2.1 hZ.2.2.1 hZ.2.2.2,
    sphere_zero_compl T (by omega) (by omega) t Z' hZ'.1 hZ'.2.1 hZ'.2.2.1 hZ'.2.2.2⟩
  · exact sphere_lam T (by omega) (by omega) t h hh a b
  · rw [hK']; exact sphere_lam_compl T (by omega) (by omega) t h' hh' a b

end sphere

end HamiltonsCubic.Results
