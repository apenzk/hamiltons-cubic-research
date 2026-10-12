import HamiltonsCubic.Results.L127Dn
import HamiltonsCubic.Results.L126DF

set_option linter.style.longLine false

/-!
# L127's `𝒟ₙ` row in `L_e` units, with the mirror families

[findings/second-order.md](../../../findings/second-order.md), Lemma L127's table, `𝒟ₙ` row:
`σ(L_e|_{𝒟ₙ}) = {1, λ_p^{p−1}, λ_q^{q−1}, (−μ)^{(p−1)(q−1)}, 0^{rest}}`. [L127Dn.lean](L127Dn.lean) computes the weight
map `K` of `M ∘` on `𝒟ₙ` and three eigen-families at a block weight. This file completes the families and passes to
`L_e = M ∘ / θ` at the sphere product `M = diagOp (t • sphereWeight T)`, `p = |T|`, `q = |Tᶜ|`, `θ = t(p + q − 1)`:

* **`K_self`**: at any diagonally critical weight, `K w = θ w` off the diagonal, the eigenvalue `1`;
* **`blockW_compl`**: `blockW Tᶜ B A G = blockW T A B G`, so each family on `T` has its mirror on `Tᶜ`;
* **`sphere_eig`**: the one form every entry takes, `M ∘ diagOp u = θ λ · diagOp u` on every `φ_{ab}` once
  `K u = θ λ u` off the diagonal;
* **`sphere_self`**, **`sphere_cross`**, **`sphere_lam`**, **`sphere_lam_compl`**, **`sphere_zero`**,
  **`sphere_zero_compl`**: the eigenvalues `1`, `−μ = −(n − 2)/(2(p − 1)(q − 1))`, `λ_p = (p − 2)/(2(p − 1))`, `λ_q`,
  and `0` on both sides, with `n = p + q`.

[L127DnSpan.lean](L127DnSpan.lean) declares that the families lie in `𝒟ₙ`, that they span it at `p, q ≥ 2`, and the
lift from `φ_{ab}` to every bivector. [L127DnDim.lean](L127DnDim.lean),
[L127DnDirect.lean](L127DnDirect.lean), [L127DnCount.lean](L127DnCount.lean) and [L127DnMult.lean](L127DnMult.lean)
give the families' direct sum at `p, q ≥ 2`, their dimensions and their count `n(n − 3)/2` at `p, q ≥ 3`, and
[L127DnEig.lean](L127DnEig.lean) and [L127DnLam.lean](L127DnLam.lean) the eigenspaces at `t ≠ 0`. At `p = 2` the `λ_p` and `T`-side zero families are `{0}`, and at
`q = 2` the `λ_q` and `Tᶜ`-side zero families are `{0}` (L127DnSpan's `lamW_two_eq_zero`, `within_two_eq_zero`), with `λ_2 = 0` joining `0^{rest}`, as
[L127Dn.lean](L127Dn.lean)'s header records.
-/

namespace HamiltonsCubic.Results

open Finset HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer HamiltonsCubic.WeylRadical HamiltonsCubic.L126Assembly

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

omit [DecidableEq ι] in
/-- **The eigenvalue `1`**: at a diagonally critical weight, `K w = θ w` off the diagonal. -/
theorem K_self {w : Matrix ι ι ℝ} {θ : ℝ} (hw : HamiltonsCubic.L68Statement.IsDiagCritical w θ) {a c : ι}
    (hac : a ≠ c) : Kmat w w a c = θ * w a c := by
  have h := hw.2.2 a c hac
  simp only [Kmat, Matrix.of_apply]
  linear_combination h

/-- **The mirror**: exchanging `T` and `Tᶜ` exchanges `A` and `B`. -/
theorem blockW_compl (T : Finset ι) (A B G : ℝ) : blockW Tᶜ B A G = blockW T A B G := by
  ext a b
  simp only [blockW, Matrix.of_apply, Finset.mem_compl]
  by_cases hab : a = b
  · simp [hab]
  · by_cases ha : a ∈ T <;> by_cases hb : b ∈ T <;> simp [hab, ha, hb]

/-- **The one form every entry takes**: an eigenvector of `K` off the diagonal gives an eigenvector of `M ∘` on every
basis bivector. -/
theorem sphere_eig (w u : Matrix ι ι ℝ) (hw : ∀ p q, w p q = w q p) (hu : ∀ p q, u p q = u q p)
    (hhw : ∀ a, w a a = 0) (hhu : ∀ a, u a a = 0) (ν : ℝ) (hK : ∀ a c, a ≠ c → Kmat w u a c = ν * u a c) (a b : ι) :
    foxProd (diagOp w) (diagOp u) (phi a b) = ν • diagOp u (phi a b) := by
  rw [foxProd_diag w u hw hu hhw hhu a b, diagOp_phi u hu, smul_smul]
  by_cases hab : a = b
  · subst hab; simp [phi_self]
  · rw [hK a b hab]

/-- The sphere product's block values satisfy the two row-sum relations. -/
theorem sphere_rows {p q : ℝ} (hp : p - 1 ≠ 0) (hq : q - 1 ≠ 0) (t : ℝ) :
    (p - 1) * (t * (q / (p - 1))) + q * (-t) = 0 ∧ (q - 1) * (t * (p / (q - 1))) + p * (-t) = 0 := by
  constructor <;> field_simp <;> ring

section sphere

variable (T : Finset ι) (hp : 2 ≤ T.card) (hq : 2 ≤ Tᶜ.card) (t : ℝ)

include hp hq in
private theorem cards : (T.card : ℝ) - 1 ≠ 0 ∧ (Tᶜ.card : ℝ) - 1 ≠ 0 ∧ (T.card : ℝ) + Tᶜ.card - 1 ≠ 0 := by
  have hp' : (2 : ℝ) ≤ T.card := by exact_mod_cast hp
  have hq' : (2 : ℝ) ≤ Tᶜ.card := by exact_mod_cast hq
  refine ⟨?_, ?_, ?_⟩ <;> intro h <;> linarith

include hp hq in
/-- **`1`** at the sphere product: `M ∘ diagOp w = θ · diagOp w`. -/
theorem sphere_self (a b : ι) :
    foxProd (diagOp (t • sphereWeight T)) (diagOp (t • sphereWeight T)) (phi a b)
      = (t * ((T.card : ℝ) + Tᶜ.card - 1) * 1) • diagOp (t • sphereWeight T) (phi a b) := by
  have hc := sphere_diagCrit T hp hq t
  rw [mul_one]
  exact sphere_eig _ _ hc.1 hc.1 hc.2.1 hc.2.1 _ (fun a c hac => K_self hc hac) a b

include hp hq in
/-- **`−μ`** at the sphere product: the cross weights, eigenvalue `θ · (−(n − 2)/(2(p − 1)(q − 1)))`. -/
theorem sphere_cross (x y : ι → ℝ) (hx : ∑ b ∈ T, x b = 0) (hy : ∑ b ∈ Tᶜ, y b = 0) (a b : ι) :
    foxProd (diagOp (t • sphereWeight T)) (diagOp (crossW T x y)) (phi a b)
      = (t * ((T.card : ℝ) + Tᶜ.card - 1) * (-(((T.card : ℝ) + Tᶜ.card - 2)
          / (2 * ((T.card : ℝ) - 1) * ((Tᶜ.card : ℝ) - 1))))) • diagOp (crossW T x y) (phi a b) := by
  obtain ⟨h1, h2, _⟩ := cards T hp hq
  have hc := sphere_diagCrit T hp hq t
  have hsym : ∀ p q, crossW T x y p q = crossW T x y q p := fun p q => by
    unfold crossW; simp only [Matrix.of_apply]
    by_cases hp : p ∈ T <;> by_cases hq : q ∈ T <;> simp [hp, hq]
  have hhol : ∀ a, crossW T x y a a = 0 := fun a => by unfold crossW; by_cases ha : a ∈ T <;> simp [ha]
  refine sphere_eig _ _ hc.1 hsym hc.2.1 hhol _ (fun a c _ => ?_) a b
  rw [smul_sphereWeight_eq, K_cross T _ _ _ x y hx hy]
  congr 1
  field_simp
  ring

include hp hq in
/-- **`λ_p`** at the sphere product: eigenvalue `θ · (p − 2)/(2(p − 1))`, at `κ = −(p − 2)/q`. -/
theorem sphere_lam (h : ι → ℝ) (hh : ∑ b ∈ T, h b = 0) (a b : ι) :
    foxProd (diagOp (t • sphereWeight T)) (diagOp (lamW T (-((T.card : ℝ) - 2) / Tᶜ.card) h)) (phi a b)
      = (t * ((T.card : ℝ) + Tᶜ.card - 1) * (((T.card : ℝ) - 2) / (2 * ((T.card : ℝ) - 1))))
        • diagOp (lamW T (-((T.card : ℝ) - 2) / Tᶜ.card) h) (phi a b) := by
  obtain ⟨h1, h2, _⟩ := cards T hp hq
  have hq0 : (Tᶜ.card : ℝ) ≠ 0 := by linarith [show (2 : ℝ) ≤ Tᶜ.card by exact_mod_cast hq]
  have hc := sphere_diagCrit T hp hq t
  have hhol : ∀ a, lamW T (-((T.card : ℝ) - 2) / Tᶜ.card) h a a = 0 := fun a => by simp [lamW]
  refine sphere_eig _ _ hc.1 (lamW_symm T _ h) hc.2.1 hhol _ (fun a c hac => ?_) a b
  obtain ⟨r1, r2⟩ := sphere_rows h1 h2 t
  rw [smul_sphereWeight_eq, K_lam T _ _ _ _ h hh (by field_simp) r1 r2 hac]
  congr 1
  field_simp
  ring

include hp hq in
/-- **`λ_q`** at the sphere product, the mirror of `sphere_lam` on `Tᶜ`: eigenvalue `θ · (q − 2)/(2(q − 1))`. -/
theorem sphere_lam_compl (h : ι → ℝ) (hh : ∑ b ∈ Tᶜ, h b = 0) (a b : ι) :
    foxProd (diagOp (t • sphereWeight T)) (diagOp (lamW Tᶜ (-((Tᶜ.card : ℝ) - 2) / T.card) h)) (phi a b)
      = (t * ((T.card : ℝ) + Tᶜ.card - 1) * (((Tᶜ.card : ℝ) - 2) / (2 * ((Tᶜ.card : ℝ) - 1))))
        • diagOp (lamW Tᶜ (-((Tᶜ.card : ℝ) - 2) / T.card) h) (phi a b) := by
  obtain ⟨h1, h2, _⟩ := cards T hp hq
  have hp0 : (T.card : ℝ) ≠ 0 := by linarith [show (2 : ℝ) ≤ T.card by exact_mod_cast hp]
  have hc := sphere_diagCrit T hp hq t
  have hhol : ∀ a, lamW Tᶜ (-((Tᶜ.card : ℝ) - 2) / T.card) h a a = 0 := fun a => by simp [lamW]
  refine sphere_eig _ _ hc.1 (lamW_symm Tᶜ _ h) hc.2.1 hhol _ (fun a c hac => ?_) a b
  obtain ⟨r1, r2⟩ := sphere_rows h1 h2 t
  have hcc : (Tᶜᶜ.card : ℝ) = T.card := by rw [compl_compl]
  rw [smul_sphereWeight_eq, ← blockW_compl,
    K_lam Tᶜ _ _ _ _ h hh (by rw [hcc]; field_simp) (by rw [hcc]; linear_combination r2)
      (by rw [hcc]; linear_combination r1) hac]
  congr 1
  field_simp
  ring

include hp hq in
/-- **`0`** at the sphere product: a hollow symmetric weight inside `T` with zero row sums there. -/
theorem sphere_zero (u : Matrix ι ι ℝ) (hu : ∀ a b, u a b = u b a) (hhu : ∀ a, u a a = 0)
    (hsupp : ∀ a b, (a ∉ T ∨ b ∉ T) → u a b = 0) (hrow : ∀ a ∈ T, ∑ b ∈ T, u a b = 0) (a b : ι) :
    foxProd (diagOp (t • sphereWeight T)) (diagOp u) (phi a b) = (0 : ℝ) • diagOp u (phi a b) := by
  have hc := sphere_diagCrit T hp hq t
  refine sphere_eig _ _ hc.1 hu hc.2.1 hhu _ (fun a c _ => ?_) a b
  rw [smul_sphereWeight_eq, K_zero T _ _ _ u hu hhu hsupp hrow, zero_mul]

include hp hq in
/-- **`0`** on the mirror side: a hollow symmetric weight inside `Tᶜ` with zero row sums there. -/
theorem sphere_zero_compl (u : Matrix ι ι ℝ) (hu : ∀ a b, u a b = u b a) (hhu : ∀ a, u a a = 0)
    (hsupp : ∀ a b, (a ∉ Tᶜ ∨ b ∉ Tᶜ) → u a b = 0) (hrow : ∀ a ∈ Tᶜ, ∑ b ∈ Tᶜ, u a b = 0) (a b : ι) :
    foxProd (diagOp (t • sphereWeight T)) (diagOp u) (phi a b) = (0 : ℝ) • diagOp u (phi a b) := by
  have hc := sphere_diagCrit T hp hq t
  refine sphere_eig _ _ hc.1 hu hc.2.1 hhu _ (fun a c _ => ?_) a b
  rw [smul_sphereWeight_eq, ← blockW_compl, K_zero Tᶜ _ _ _ u hu hhu hsupp hrow, zero_mul]

end sphere

end HamiltonsCubic.Results
