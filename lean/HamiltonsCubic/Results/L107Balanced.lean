import HamiltonsCubic.Results.L107
import HamiltonsCubic.Results.L130Statement

set_option linter.style.longLine false

/-!
# L107's balanced-product step: `λ_min` of `S^m × S^m` is the `B`-block value

[findings/bounds.md](../../../findings/bounds.md), Lemma L107: `(n − 1)|λ_min| = θ₀(n)` exactly at the balanced
product. [L107.lean](L107.lean) proves `(n − 1)² λ_min² = θ₀(n)²` as an identity in `n` for the value
`λ_min² = 2(n − 2)/(n²(n − 1))` and matches it to L67's `B`-block at `n = 6`. **This file proves that value is
the balanced product's least eigenvalue**, on the layer's operator `diagOp (t • sphereWeight S)`:

- `sphere_lamMin`: at every sphere product, `⟨W X, X⟩ ≥ −t⟨X, X⟩` with equality at a cross bivector `φ_ab`,
  `a ∈ S`, `b ∉ S`, so `λ_min = −t` as a Rayleigh minimum, every weight being at least `−1` (`sphereWeight_ge`);
- `balanced_lamMinSq`: at `|S| = |Sᶜ|` and unit norm, `t² = 2(n − 2)/(n²(n − 1))`, from `sphereWeight_scale`;
- **`balanced_tight`**: `((n − 1) t)² = θ₀(n)²` there, through `tightness`;
- **`sphere_tight`**: `((n − 1) t)² = θ_{p,q}²` at every unit sphere product, the bound's equality at every
  `S^p × S^q`.
-/

namespace HamiltonsCubic.SpectralTarget

open Matrix HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

theorem sphereWeight_ge (S : Finset ι) (hp : 2 ≤ S.card) (hq : 2 ≤ Sᶜ.card) (a b : ι) :
    -1 ≤ sphereWeight S a b := by
  have hpR : (2 : ℝ) ≤ (S.card : ℝ) := by exact_mod_cast hp
  have hqR : (2 : ℝ) ≤ (Sᶜ.card : ℝ) := by exact_mod_cast hq
  unfold sphereWeight
  simp only [Matrix.of_apply]
  split_ifs
  · norm_num
  · exact le_trans (by norm_num) (div_nonneg (by linarith) (by linarith))
  · exact le_refl _
  · exact le_refl _
  · exact le_trans (by norm_num) (div_nonneg (by linarith) (by linarith))

/-- **`λ_min = −t` at a sphere product, as a Rayleigh minimum**: `⟨W X, X⟩ ≥ −t⟨X, X⟩` for every `X`, with
equality at the cross bivector `φ_ab`, `a ∈ S`, `b ∉ S`. -/
theorem sphere_lamMin (S : Finset ι) (hp : 2 ≤ S.card) (hq : 2 ≤ Sᶜ.card) (t : ℝ) (ht : 0 ≤ t) :
    (∀ X, -t * inner2 X X ≤ inner2 (diagOp (t • sphereWeight S) X) X) ∧
      ∃ a b, a ≠ b ∧ inner2 (diagOp (t • sphereWeight S) (phi a b)) (phi a b) = -t * inner2 (phi a b) (phi a b) := by
  constructor
  · intro X
    have key : ∀ a b : ι, -t * (X a b * X a b) ≤ diagOp (t • sphereWeight S) X a b * X a b := by
      intro a b
      simp only [diagOp, Matrix.of_apply, Matrix.smul_apply, smul_eq_mul]
      have hw := sphereWeight_ge S hp hq a b
      have hx : 0 ≤ X a b * X a b := mul_self_nonneg _
      nlinarith [mul_nonneg (mul_nonneg ht hx) (by linarith : (0:ℝ) ≤ sphereWeight S a b + 1)]
    have hsum : ∑ a, ∑ b, -t * (X a b * X a b) ≤ ∑ a, ∑ b, diagOp (t • sphereWeight S) X a b * X a b :=
      Finset.sum_le_sum fun a _ => Finset.sum_le_sum fun b _ => key a b
    have hpull : ∑ a : ι, ∑ b : ι, -t * (X a b * X a b) = -t * ∑ a : ι, ∑ b : ι, X a b * X a b := by
      simp only [Finset.mul_sum]
    rw [inner2_eq_sum, inner2_eq_sum]
    linarith
  · obtain ⟨a, ha⟩ : S.Nonempty := Finset.card_pos.mp (by omega)
    obtain ⟨b, hb⟩ : Sᶜ.Nonempty := Finset.card_pos.mp (by omega)
    have hb' : b ∉ S := Finset.mem_compl.mp hb
    have hab : a ≠ b := fun h => hb' (h ▸ ha)
    refine ⟨a, b, hab, ?_⟩
    have hsym : ∀ x y, (t • sphereWeight S) x y = (t • sphereWeight S) y x := fun x y => by
      simp only [Matrix.smul_apply, sphereWeight_symm S x y]
    rw [diagOp_phi _ hsym, Matrix.smul_apply]
    have hw : sphereWeight S a b = -1 := by simp [sphereWeight, hab, ha, hb']
    rw [hw, RealLayer.inner2_smul_left]
    simp

/-- **At the balanced product, `λ_min² = lamMinSq(n)`**: with `|S| = |Sᶜ|` and unit norm, `t² = 2(n−2)/(n²(n−1))`,
the value L107's tightness identity and L67's `B`-block carry. -/
theorem balanced_lamMinSq (S : Finset ι) (hp : 2 ≤ S.card) (hbal : S.card = Sᶜ.card) (t : ℝ)
    (hnorm : normSq (diagOp (t • sphereWeight S)) = 1) :
    t ^ 2 = ((lamMinSq (Fintype.card ι : ℚ) : ℚ) : ℝ) := by
  have hq : 2 ≤ Sᶜ.card := hbal ▸ hp
  have h := HamiltonsCubic.L130Statement.sphereWeight_scale S hp hq t hnorm
  have hn : (Fintype.card ι : ℝ) = (S.card : ℝ) + (Sᶜ.card : ℝ) := by
    rw [← Nat.cast_add, Finset.card_add_card_compl]
  rw [← hbal] at h hn
  unfold lamMinSq
  push_cast
  rw [hn]
  have hm : (2 : ℝ) ≤ (S.card : ℝ) := by exact_mod_cast hp
  set m := (S.card : ℝ)
  have h1 : m - 1 ≠ 0 := by linarith
  have h2 : 2 * m - 1 ≠ 0 := by linarith
  have hm0 : m ≠ 0 := by linarith
  have hc : t ^ 2 * (m ^ 2 * (2 * m - 1)) = m - 1 := by
    have e : (m - 1) * (t ^ 2 * (m ^ 2 * (2 * m - 1))) = (m - 1) * (m - 1) := by linear_combination (1 / 2) * h
    exact mul_left_cancel₀ h1 e
  have hden : (m + m) ^ 2 * (m + m - 1) ≠ 0 := by
    apply mul_ne_zero (pow_ne_zero _ (by linarith)); linarith
  rw [eq_div_iff hden]
  linear_combination 4 * hc

/-- **L107's equality at the balanced product, on the operator**: `((n − 1)|λ_min|)² = θ₀(n)²` with `|λ_min| = t`
the unit scale, from `balanced_lamMinSq` and `tightness`. -/
theorem balanced_tight (S : Finset ι) (hp : 2 ≤ S.card) (hbal : S.card = Sᶜ.card) (t : ℝ)
    (hnorm : normSq (diagOp (t • sphereWeight S)) = 1) :
    (((Fintype.card ι : ℝ) - 1) * t) ^ 2 = ((theta0Sq (Fintype.card ι : ℚ) : ℚ) : ℝ) := by
  have h3 : (3 : ℚ) ≤ (Fintype.card ι : ℚ) := by
    have : S.card + Sᶜ.card = Fintype.card ι := Finset.card_add_card_compl S
    exact_mod_cast (show 3 ≤ Fintype.card ι by omega)
  have ht := tightness (Fintype.card ι : ℚ) h3
  rw [mul_pow, balanced_lamMinSq S hp hbal t hnorm, ← ht]
  push_cast; ring

/-- **Equality at EVERY sphere product**: `((n − 1) t)² = θ_{p,q}²` at unit norm, `t = |λ_min|`, so L107's
bound `θ ≤ (n − 1)|λ_min|` is attained at every `S^p × S^q`, as the block's isotropy remark says. -/
theorem sphere_tight (S : Finset ι) (hp : 2 ≤ S.card) (hq : 2 ≤ Sᶜ.card) (t : ℝ)
    (hnorm : normSq (diagOp (t • sphereWeight S)) = 1) :
    (((Fintype.card ι : ℝ) - 1) * t) ^ 2 = thetaSplitSq (S.card : ℝ) (Sᶜ.card : ℝ) := by
  have h := HamiltonsCubic.L130Statement.sphereWeight_scale S hp hq t hnorm
  have hn : (Fintype.card ι : ℝ) = (S.card : ℝ) + (Sᶜ.card : ℝ) := by
    rw [← Nat.cast_add, Finset.card_add_card_compl]
  have hpR : (2 : ℝ) ≤ (S.card : ℝ) := by exact_mod_cast hp
  have hqR : (2 : ℝ) ≤ (Sᶜ.card : ℝ) := by exact_mod_cast hq
  rw [hn]
  unfold thetaSplitSq
  set p := (S.card : ℝ)
  set q := (Sᶜ.card : ℝ)
  have hden : (p + q - 2) * (p * q) ≠ 0 := by
    apply mul_ne_zero (by linarith); positivity
  rw [eq_div_iff hden]
  linear_combination (p + q - 1) * h

end HamiltonsCubic.SpectralTarget
