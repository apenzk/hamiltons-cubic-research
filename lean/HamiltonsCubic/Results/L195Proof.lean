import HamiltonsCubic.Results.PhiSphereN
import HamiltonsCubic.Results.L186Proof

set_option linter.style.longLine false

/-!
# L195: a common square with two distinct eigenvalues forces two forms equal up to sign

[diagonal-half.md](../../../findings/diagonal-half.md), Lemma L195: *"Let `ω₁, ω₂` be `2`-forms with
`ω₁² = ω₂² = −A` for `A` positive definite, and `ω₁ ∧ ω₁ = ω₂ ∧ ω₂`. If `A` has at least two distinct eigenvalues then
`ω₂ = ±ω₁`."*

- `bf`, `bf_eq`, **`wedge_eval`**: `(ω ∧ ω)(x, y, z, v) = 2(B(x,y)B(z,v) − B(x,z)B(y,v) + B(x,v)B(y,z))` with
  `B(p, q) = pᵀ ω q`, through [PhiSphereN.lean](PhiSphereN.lean)'s relabellings;
- `Aop`, `dot_skew`, `eigen_preserve`, `Aop_symm`, `eigen_orth`, `dot_sq`, `bf_self`, `dot_self_pos`, `eigen_pos`:
  `ω` preserves every eigenspace of `A = −ω²`, the eigenspaces are orthogonal, and every eigenvalue is positive when
  `ω₁` is injective;
- **`mixed_eq`**: on `E_μ × E_ν` with `μ ≠ ν` the cross pairings vanish, so equal wedges give
  `B₁(x,y)B₁(z,v) = B₂(x,y)B₂(z,v)`, the record's rank-one component;
- **`scale`**: `ω₂ = s ω₁` on `E_μ` with `s² = 1`;
- `eq_zero_of_eigenbasis`, **`L195`**: pairing two distinct eigenspaces forces one sign for all of them, and the
  eigenvectors of the symmetric `A` span, so `ω₂ = ±ω₁`.

Positive definiteness of `A` is taken as injectivity of `ω₁`, which is equivalent since `xᵀ A x = ‖ω₁ x‖²`. Only `ω₁`
needs to be skew: `ω₂² = ω₁²` and the wedge equality carry the rest, and `ω₂ = ±ω₁` makes it skew.
-/

namespace HamiltonsCubic.L195Proof

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.SelfDualLayer

variable {n : ℕ}

/-- The bilinear form `B(p, q) = pᵀ ω q`. -/
def bf (w : Matrix (Fin n) (Fin n) ℝ) (p q : Fin n → ℝ) : ℝ := p ⬝ᵥ (w *ᵥ q)

theorem bf_eq (w : Matrix (Fin n) (Fin n) ℝ) (p q : Fin n → ℝ) : bf w p q = ∑ a, ∑ b, p a * w a b * q b := by
  simp only [bf, dotProduct, Matrix.mulVec, Finset.mul_sum]
  refine Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ => by ring

/-- **The wedge evaluated on four vectors**: `(ω ∧ ω)(x, y, z, w) = 2(B(x,y)B(z,w) − B(x,z)B(y,w) + B(x,w)B(y,z))`. -/
theorem wedge_eval (w : Matrix (Fin n) (Fin n) ℝ) (x y z v : Fin n → ℝ) :
    ∑ a, ∑ b, ∑ c, ∑ d, wedgeSelf w a b c d * (x a * y b * z c * v d) =
      2 * (bf w x y * bf w z v - bf w x z * bf w y v + bf w x v * bf w y z) := by
  have hw : ∀ a b c d, wedgeSelf w a b c d = 2 * (w a b * w c d - w a c * w b d + w a d * w b c) := fun a b c d => by
    simp only [wedgeSelf, wedge2, halfw, Pi.add_apply]; ring
  have t1 : ∑ a, ∑ b, ∑ c, ∑ d, w a b * w c d * (x a * y b * z c * v d) = bf w x y * bf w z v := by
    rw [bf_eq, bf_eq, ← sum4_prod]
    refine Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ => Finset.sum_congr rfl fun c _ =>
      Finset.sum_congr rfl fun d _ => by ring
  have t2 : ∑ a, ∑ b, ∑ c, ∑ d, w a c * w b d * (x a * y b * z c * v d) = bf w x z * bf w y v := by
    rw [sum4_swap_bc, bf_eq, bf_eq, ← sum4_prod]
    refine Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ => Finset.sum_congr rfl fun c _ =>
      Finset.sum_congr rfl fun d _ => by ring
  have t3 : ∑ a, ∑ b, ∑ c, ∑ d, w a d * w b c * (x a * y b * z c * v d) = bf w x v * bf w y z := by
    rw [sum4_swap_cd, sum4_swap_bc, bf_eq, bf_eq, ← sum4_prod]
    refine Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ => Finset.sum_congr rfl fun c _ =>
      Finset.sum_congr rfl fun d _ => by ring
  have hexp : ∀ a b c d, wedgeSelf w a b c d * (x a * y b * z c * v d) =
      2 * (w a b * w c d * (x a * y b * z c * v d)) - 2 * (w a c * w b d * (x a * y b * z c * v d))
        + 2 * (w a d * w b c * (x a * y b * z c * v d)) := fun a b c d => by rw [hw]; ring
  simp only [hexp, Finset.sum_add_distrib, Finset.sum_sub_distrib, ← Finset.mul_sum]
  rw [t1, t2, t3]; ring

section Eigen

variable {w₁ w₂ : Matrix (Fin n) (Fin n) ℝ} (hs₁ : w₁ᵀ = -w₁) (hsq : w₁ * w₁ = w₂ * w₂)
  (hinj : ∀ x, w₁ *ᵥ x = 0 → x = 0)

/-- `A = −ω²`, common to both forms. -/
def Aop (w : Matrix (Fin n) (Fin n) ℝ) : Matrix (Fin n) (Fin n) ℝ := -(w * w)

theorem dot_skew {w : Matrix (Fin n) (Fin n) ℝ} (hs : wᵀ = -w) (p q : Fin n → ℝ) : p ⬝ᵥ (w *ᵥ q) = -(q ⬝ᵥ (w *ᵥ p)) := by
  rw [Matrix.dotProduct_mulVec, ← Matrix.mulVec_transpose, hs, Matrix.neg_mulVec, neg_dotProduct, dotProduct_comm]

/-- `ω` preserves every eigenspace of `−ω²`. -/
theorem eigen_preserve (w : Matrix (Fin n) (Fin n) ℝ) {μ : ℝ} {x : Fin n → ℝ} (hx : Aop w *ᵥ x = μ • x) :
    Aop w *ᵥ (w *ᵥ x) = μ • (w *ᵥ x) := by
  unfold Aop at *
  rw [Matrix.mulVec_mulVec, show -(w * w) * w = w * -(w * w) by rw [neg_mul, mul_neg, Matrix.mul_assoc],
    ← Matrix.mulVec_mulVec, hx, Matrix.mulVec_smul]

theorem Aop_symm {w : Matrix (Fin n) (Fin n) ℝ} (hs : wᵀ = -w) : (Aop w)ᵀ = Aop w := by
  simp only [Aop, transpose_neg, transpose_mul, hs, neg_mul_neg]

/-- **Eigenspaces of the symmetric `A` for distinct eigenvalues are orthogonal.** -/
theorem eigen_orth {w : Matrix (Fin n) (Fin n) ℝ} (hs : wᵀ = -w) {μ ν : ℝ} {x y : Fin n → ℝ} (hμν : μ ≠ ν)
    (hx : Aop w *ᵥ x = μ • x) (hy : Aop w *ᵥ y = ν • y) : x ⬝ᵥ y = 0 := by
  have h1 : (Aop w *ᵥ x) ⬝ᵥ y = x ⬝ᵥ (Aop w *ᵥ y) := by
    rw [dotProduct_comm, Matrix.dotProduct_mulVec, ← Matrix.mulVec_transpose, Aop_symm hs, dotProduct_comm]
  rw [hx, hy, smul_dotProduct, dotProduct_smul, smul_eq_mul, smul_eq_mul] at h1
  have : (μ - ν) * (x ⬝ᵥ y) = 0 := by linarith
  exact (mul_eq_zero.mp this).resolve_left (sub_ne_zero.mpr hμν)

/-- `x ⬝ ω(ωx) = −(ωx) ⬝ (ωx)`. -/
theorem dot_sq {w : Matrix (Fin n) (Fin n) ℝ} (hs : wᵀ = -w) (x : Fin n → ℝ) :
    x ⬝ᵥ (w *ᵥ (w *ᵥ x)) = -((w *ᵥ x) ⬝ᵥ (w *ᵥ x)) := by
  rw [dot_skew hs]

/-- `B(x, ωx) = −μ |x|²` on the `μ`-eigenspace. -/
theorem bf_self {w : Matrix (Fin n) (Fin n) ℝ} {μ : ℝ} {x : Fin n → ℝ} (hx : Aop w *ᵥ x = μ • x) :
    bf w x (w *ᵥ x) = -(μ * (x ⬝ᵥ x)) := by
  have : w *ᵥ (w *ᵥ x) = -(μ • x) := by
    rw [Matrix.mulVec_mulVec, ← neg_neg ((w * w) *ᵥ x), ← Matrix.neg_mulVec]; unfold Aop at hx; rw [hx]
  rw [bf, this, dotProduct_neg, dotProduct_smul, smul_eq_mul]

theorem dot_self_pos {v : Fin n → ℝ} (hv : v ≠ 0) : 0 < v ⬝ᵥ v :=
  lt_of_le_of_ne (Finset.sum_nonneg fun i _ => mul_self_nonneg (v i)) (Ne.symm (mt dotProduct_self_eq_zero.mp hv))

/-- **Positivity**: an eigenvalue of `A = −ω²` at an injective `ω` is positive. -/
theorem eigen_pos {w : Matrix (Fin n) (Fin n) ℝ} (hs : wᵀ = -w) (hinj : ∀ x, w *ᵥ x = 0 → x = 0) {μ : ℝ}
    {x : Fin n → ℝ} (hx0 : x ≠ 0) (hx : Aop w *ᵥ x = μ • x) : 0 < μ := by
  have e := bf_self hx
  rw [bf, dot_sq hs] at e
  have hwx : w *ᵥ x ≠ 0 := fun h => hx0 (hinj x h)
  have p1 : 0 < (w *ᵥ x) ⬝ᵥ (w *ᵥ x) := dot_self_pos hwx
  have p2 : 0 < x ⬝ᵥ x := dot_self_pos hx0
  nlinarith

/-- A matrix killing every vector of a basis-indexed family that spans is zero. -/
theorem eq_zero_of_eigenbasis {D : Matrix (Fin n) (Fin n) ℝ} (b : OrthonormalBasis (Fin n) ℝ (EuclideanSpace ℝ (Fin n)))
    (h : ∀ j, D *ᵥ (b j : Fin n → ℝ) = 0) : D = 0 := by
  have hL : Matrix.toEuclideanLin D = 0 := b.toBasis.ext fun j => by
    simp only [OrthonormalBasis.coe_toBasis, LinearMap.zero_apply]
    ext i
    rw [Matrix.ofLp_toLpLin]
    simpa using congrFun (h j) i
  exact Matrix.toEuclideanLin.injective (hL.trans (map_zero _).symm)

include hs₁ hsq

omit hs₁ in
theorem Aop_eq : Aop w₂ = Aop w₁ := by unfold Aop; rw [hsq]

/-- **The mixed component**: on `E_μ × E_ν` with `μ ≠ ν`, equal wedges give `B₁(x,y)B₁(z,v) = B₂(x,y)B₂(z,v)`. -/
theorem mixed_eq (hwedge : ∀ a b c d, wedgeSelf w₁ a b c d = wedgeSelf w₂ a b c d) {μ ν : ℝ} (hμν : μ ≠ ν)
    {x y z v : Fin n → ℝ} (hx : Aop w₁ *ᵥ x = μ • x) (hy : Aop w₁ *ᵥ y = μ • y) (hz : Aop w₁ *ᵥ z = ν • z)
    (hv : Aop w₁ *ᵥ v = ν • v) : bf w₁ x y * bf w₁ z v = bf w₂ x y * bf w₂ z v := by
  have hA := Aop_eq hsq
  have cross : ∀ (w : Matrix (Fin n) (Fin n) ℝ), Aop w = Aop w₁ → ∀ p q, Aop w₁ *ᵥ p = μ • p →
      Aop w₁ *ᵥ q = ν • q → bf w p q = 0 := fun w hw p q hp hq => by
    have hwq : Aop w₁ *ᵥ (w *ᵥ q) = ν • (w *ᵥ q) := by rw [← hw] at hq ⊢; exact eigen_preserve w hq
    exact eigen_orth hs₁ hμν hp hwq
  have e1 := wedge_eval w₁ x y z v
  have e2 := wedge_eval w₂ x y z v
  simp only [hwedge] at e1
  rw [e1] at e2
  rw [cross w₁ rfl x z hx hz, cross w₁ rfl y v hy hv, cross w₁ rfl x v hx hv, cross w₁ rfl y z hy hz,
    cross w₂ hA x z hx hz, cross w₂ hA y v hy hv, cross w₂ hA x v hx hv, cross w₂ hA y z hy hz] at e2
  linarith

/-- **On one eigenspace `ω₂` is `s ω₁` with `s² = 1`**, given a nonzero eigenvector of a second eigenvalue. -/
theorem scale (hinj : ∀ x, w₁ *ᵥ x = 0 → x = 0)
    (hwedge : ∀ a b c d, wedgeSelf w₁ a b c d = wedgeSelf w₂ a b c d) {μ ν : ℝ} (hμν : μ ≠ ν) {x₀ z : Fin n → ℝ}
    (hx₀ : x₀ ≠ 0) (hx : Aop w₁ *ᵥ x₀ = μ • x₀) (hz₀ : z ≠ 0) (hz : Aop w₁ *ᵥ z = ν • z) :
    ∃ s : ℝ, s ^ 2 = 1 ∧ ∀ x, Aop w₁ *ᵥ x = μ • x → w₂ *ᵥ x = s • (w₁ *ᵥ x) := by
  have hA := Aop_eq hsq
  have hμ := eigen_pos hs₁ hinj hx₀ hx
  have hν := eigen_pos hs₁ hinj hz₀ hz
  have hzz := dot_self_pos hz₀
  have hxx := dot_self_pos hx₀
  have hwz : Aop w₁ *ᵥ (w₁ *ᵥ z) = ν • (w₁ *ᵥ z) := eigen_preserve w₁ hz
  set c := bf w₁ z (w₁ *ᵥ z) with hc
  set d := bf w₂ z (w₁ *ᵥ z) with hd
  have hc0 : c ≠ 0 := by rw [hc, bf_self hz]; exact neg_ne_zero.mpr (by positivity)
  have key : ∀ x y, Aop w₁ *ᵥ x = μ • x → Aop w₁ *ᵥ y = μ • y → bf w₁ x y * c = bf w₂ x y * d :=
    fun x y hx' hy' => mixed_eq hs₁ hsq hwedge hμν hx' hy' hz hwz
  have hwx₀ : Aop w₁ *ᵥ (w₁ *ᵥ x₀) = μ • (w₁ *ᵥ x₀) := eigen_preserve w₁ hx
  have hd0 : d ≠ 0 := by
    intro h0
    have := key x₀ (w₁ *ᵥ x₀) hx hwx₀
    rw [h0, mul_zero, bf_self hx] at this
    have : μ * (x₀ ⬝ᵥ x₀) * c = 0 := by linarith
    rcases mul_eq_zero.mp this with h | h
    · exact (mul_pos hμ hxx).ne' h
    · exact hc0 h
  set s := c / d with hsdef
  have hB : ∀ x y, Aop w₁ *ᵥ x = μ • x → Aop w₁ *ᵥ y = μ • y → bf w₂ x y = s * bf w₁ x y := fun x y hx' hy' => by
    have := key x y hx' hy'
    rw [hsdef]; field_simp; linarith
  have hvec : ∀ x, Aop w₁ *ᵥ x = μ • x → w₂ *ᵥ x = s • (w₁ *ᵥ x) := fun x hx' => by
    set u := w₂ *ᵥ x - s • (w₁ *ᵥ x) with hu
    have hu_e : Aop w₁ *ᵥ u = μ • u := by
      have h2 : Aop w₁ *ᵥ (w₂ *ᵥ x) = μ • (w₂ *ᵥ x) := by rw [← hA] at hx' ⊢; exact eigen_preserve w₂ hx'
      rw [hu, Matrix.mulVec_sub, Matrix.mulVec_smul, h2, eigen_preserve w₁ hx', smul_sub, smul_comm]
    have huu : u ⬝ᵥ u = 0 := by
      have e : u ⬝ᵥ u = bf w₂ u x - s * bf w₁ u x := by
        simp only [bf]; rw [hu, dotProduct_sub, dotProduct_smul, smul_eq_mul]
      rw [e, hB u x hu_e hx']; ring
    exact sub_eq_zero.mp (dotProduct_self_eq_zero.mp huu)
  refine ⟨s, ?_, hvec⟩
  -- `s² = 1` from `ω₂² = ω₁²` on `x₀`
  have h1 := hvec x₀ hx
  have h2 := hvec (w₁ *ᵥ x₀) hwx₀
  have hsq' : (w₂ * w₂) *ᵥ x₀ = s ^ 2 • ((w₁ * w₁) *ᵥ x₀) := by
    rw [← Matrix.mulVec_mulVec, h1, Matrix.mulVec_smul, h2, smul_smul, ← Matrix.mulVec_mulVec, sq]
  rw [← hsq] at hsq'
  have hAx : (w₁ * w₁) *ᵥ x₀ = -(μ • x₀) := by
    unfold Aop at hx; rw [Matrix.neg_mulVec] at hx; rw [← hx, neg_neg]
  rw [hAx] at hsq'
  have e : μ • x₀ = s ^ 2 • (μ • x₀) := by rw [smul_neg] at hsq'; exact neg_inj.mp hsq'
  have : (1 - s ^ 2) • (μ • x₀) = 0 := by rw [sub_smul, one_smul, ← e, sub_self]
  rw [smul_smul, smul_eq_zero] at this
  rcases this with h | h
  · rcases mul_eq_zero.mp h with h | h
    · linarith
    · exact absurd h hμ.ne'
  · exact absurd h hx₀

/-- **L195**: two `2`-forms with a common square `−A`, `A` positive definite (here `ω₁` injective), and equal
self-wedges are equal up to sign once `A` has two distinct eigenvalues. -/
theorem L195 (hinj : ∀ x, w₁ *ᵥ x = 0 → x = 0)
    (hwedge : ∀ a b c d, wedgeSelf w₁ a b c d = wedgeSelf w₂ a b c d)
    (hdist : ∃ μ ν : ℝ, ∃ x₀ z₀ : Fin n → ℝ, μ ≠ ν ∧ x₀ ≠ 0 ∧ z₀ ≠ 0 ∧ Aop w₁ *ᵥ x₀ = μ • x₀ ∧
      Aop w₁ *ᵥ z₀ = ν • z₀) :
    w₂ = w₁ ∨ w₂ = -w₁ := by
  obtain ⟨μ, ν, x₀, z₀, hμν, hx₀, hz₀, hx, hz⟩ := hdist
  obtain ⟨s, hs2, hvec⟩ := scale hs₁ hsq hinj hwedge hμν hx₀ hx hz₀ hz
  have hμ := eigen_pos hs₁ hinj hx₀ hx
  have hwx₀ : Aop w₁ *ᵥ (w₁ *ᵥ x₀) = μ • (w₁ *ᵥ x₀) := eigen_preserve w₁ hx
  -- every eigenvector is scaled by the same `s`
  have hall : ∀ (lam : ℝ) (v : Fin n → ℝ), Aop w₁ *ᵥ v = lam • v → w₂ *ᵥ v = s • (w₁ *ᵥ v) := by
    intro lam v hv
    by_cases hv0 : v = 0
    · simp [hv0]
    by_cases hlm : lam = μ
    · subst hlm; exact hvec v hv
    obtain ⟨t, ht2, htvec⟩ := scale hs₁ hsq hinj hwedge hlm hv0 hv hx₀ hx
    have hlpos := eigen_pos hs₁ hinj hv0 hv
    have hwv : Aop w₁ *ᵥ (w₁ *ᵥ v) = lam • (w₁ *ᵥ v) := eigen_preserve w₁ hv
    have hm := mixed_eq hs₁ hsq hwedge (Ne.symm hlm) hx hwx₀ hv hwv
    have e1 : bf w₂ x₀ (w₁ *ᵥ x₀) = s * bf w₁ x₀ (w₁ *ᵥ x₀) := by
      simp only [bf]; rw [hvec _ hwx₀, dotProduct_smul, smul_eq_mul]
    have e2 : bf w₂ v (w₁ *ᵥ v) = t * bf w₁ v (w₁ *ᵥ v) := by
      simp only [bf]; rw [htvec _ hwv, dotProduct_smul, smul_eq_mul]
    rw [e1, e2] at hm
    have b1 : bf w₁ x₀ (w₁ *ᵥ x₀) ≠ 0 := by
      rw [bf_self hx]; exact neg_ne_zero.mpr (mul_pos hμ (dot_self_pos hx₀)).ne'
    have b2 : bf w₁ v (w₁ *ᵥ v) ≠ 0 := by
      rw [bf_self hv]; exact neg_ne_zero.mpr (mul_pos hlpos (dot_self_pos hv0)).ne'
    have hst : s * t = 1 := by
      have := mul_right_cancel₀ (mul_ne_zero b1 b2) (show 1 * (bf w₁ x₀ (w₁ *ᵥ x₀) * bf w₁ v (w₁ *ᵥ v)) =
        (s * t) * (bf w₁ x₀ (w₁ *ᵥ x₀) * bf w₁ v (w₁ *ᵥ v)) by linear_combination hm)
      linarith
    have hts : t = s := by nlinarith [sq_nonneg (t - s)]
    rw [← hts]; exact htvec v hv
  -- eigenvectors span
  have hsymm : (Aop w₁).IsHermitian := by
    rw [Matrix.IsHermitian, conjTranspose_eq_transpose_of_trivial, Aop_symm hs₁]
  have hD : w₂ - s • w₁ = 0 := eq_zero_of_eigenbasis hsymm.eigenvectorBasis fun j => by
    rw [Matrix.sub_mulVec, Matrix.smul_mulVec, hall _ _ (hsymm.mulVec_eigenvectorBasis j), sub_self]
  have hw : w₂ = s • w₁ := sub_eq_zero.mp hD
  have : s = 1 ∨ s = -1 := by
    have : (s - 1) * (s + 1) = 0 := by nlinarith
    rcases mul_eq_zero.mp this with h | h
    · left; linarith
    · right; linarith
  rcases this with rfl | rfl
  · left; rw [hw, one_smul]
  · right; rw [hw, neg_one_smul]

end Eigen

end HamiltonsCubic.L195Proof
