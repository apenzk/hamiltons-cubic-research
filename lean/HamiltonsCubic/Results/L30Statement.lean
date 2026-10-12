import Mathlib
import HamiltonsCubic.Base.WeylReal
import HamiltonsCubic.Results.L41Statement
import HamiltonsCubic.Results.FrameExtension

/-!
# L30, a small negative eigenspace forces a small support, STATED

From [stratum-two-negative.md](../../../findings/stratum-two-negative.md), the block headed
*"Lemma L30, a small negative eigenspace forces a small support"*, quoted verbatim:

> **Statement.** Let $W\in\mathrm{Weyl}_n$ and set $U=\sum_{\lambda_\alpha<0}\operatorname{im}
> v_\alpha$, the sum over **all** negative eigenvectors read as skew matrices. If $\dim U<n$ then
> $W$ vanishes on $u\wedge u^\perp$ for every $u\perp U$, and $W$ is a padding of a
> $\mathrm{Weyl}_{\dim U}$ tensor with the same norm and the same $\theta$.

with the hypothesis note, which is what the Lean binder follows:

> **The hypothesis is on $U$, not on a count of negative eigenvalues.** […] read as "at most two
> **distinct**", $\mathrm{pad}_{V_1}(W_{\mathbb{CP}^2})+\mathrm{pad}_{V_2}(W_{\mathbb{CP}^2})$ on
> $\mathbb R^8$ has one distinct negative eigenvalue of multiplicity four, satisfies the hypothesis
> and **breaks the conclusion**, $W(e_5\wedge e_6)\ne0$ at $e_5\perp U$. **And read as "at most",
> the one-negative case leaves $U$ built partly from an undetermined kernel eigenvector, so
> $\dim U$ is not a function of $W$.**

and the mechanism, which is where this file's proved content sits:

> $\mathrm{Ric}(W)(x,x)=\sum_\alpha\lambda_\alpha\lVert v_\alpha x\rVert^2$, so Ricci-flatness is
> exactly $\sum_\alpha\lambda_\alpha v_\alpha^{\mathsf T}v_\alpha=0$, an identity among positive
> semidefinite matrices […]. For $u\perp U$ this gives $v_\alpha u=0$ **for every $\alpha$ with
> $\lambda_\alpha\ne0$**, *it fails at a kernel eigenvector.*

## The two clauses, and the record's own split between them

The support clause is proved on the record. **The norm-and-`θ` clause is
[Lemma L164](../../../findings/stratum-two-negative.md)**, which the canonical block carries with a
proof; [results.md](../../../results.md) still records it as *"the norm-and-`θ` clause that makes the
reduction useful is not"* proved. **The two are typed separately below** so the divergence stays
visible. **Both clauses are proved here**, so the Lean layer sides with the canonical block.

## What is typed here

**`L30_support`**, the first clause, PROVED: `ric_quad` is the Ricci-flatness expansion
`Ric(W)(x,x) = ∑ λ_α ‖v_α x‖²` on the eigenframe, `u ⊥ U` kills every `v_α u` with `λ_α < 0`
(`dot_skew`), the balance then kills the rest, and `⟨u ∧ w, v_α⟩ = w · (v_α u)` (`inner2_wedge`)
makes every frame coefficient of `W(u ∧ w)` vanish. **`hdim` is not used**: it only guarantees
that a nonzero `u` exists. **`L30_padding`**, the second clause, PROVED: padding is stated
through an isometric embedding `E : ℝ^{dim U} → ℝⁿ` with `EᵀE = 1` and range `U`, and the
intertwining `W(E X Eᵀ) = E (W' X) Eᵀ`, which is what *"is a padding of"* means, and which L164's
step (iii) delivers as an operator identity. The construction is `Wp W E = Eᵀ W(E · Eᵀ) E`, in the
`Padding` section.

**Also proved here:** that `u ∧ w` is a bivector; that `⟨x, (vᵀv)x⟩ = ‖vx‖²`, so
`vᵀv ⪰ 0` for every `v`, the positive semidefiniteness the whole identity is a balance of; that
for skew `v` this reads `vᵀv = −v²`; and the scalar step the balance is used through, that a sum of
non-negative terms that vanishes has every term zero.

## What is NOT typed here

**Non-vacuity.** The record's witness for the hypothesis `dim U < n` is padded `W_{ℂP²}` at
`n ≥ 5`, where `dim U = 4`; the construction is not in this Lean layer, so no `example` exhibits a
`W` satisfying the hypotheses.

*`θ` is [WeylReal.lean](../Base/WeylReal.lean)'s, whose own docstring records that its `sharpPair`
term is even in `R` and so is `tr(R#)` rather than `⟨R#,R⟩`.*
-/

set_option linter.style.longLine false
set_option linter.unusedVariables false
set_option linter.unusedSectionVars false

namespace HamiltonsCubic.L30Statement

open HamiltonsCubic.RealLayer Matrix

variable {ι : Type*} [Fintype ι] [DecidableEq ι]
variable {κ : Type*} [Fintype κ] [DecidableEq κ]

/-! ## Bivectors from vectors -/

/-- **`u ∧ w`**, normalised so that `e_i ∧ e_j = φ_{ij}`. -/
noncomputable def wedgeVec (u w : ι → ℝ) : Matrix ι ι ℝ :=
  Matrix.vecMulVec w u - Matrix.vecMulVec u w

/-- **`u ∧ w` is a bivector.** -/
theorem wedgeVec_isSkew (u w : ι → ℝ) : IsSkew (wedgeVec u w) := by
  unfold IsSkew wedgeVec
  ext p q
  simp [Matrix.vecMulVec_apply, Matrix.transpose_apply]
  ring

/-! ## The eigenframe, and the support of its negative part -/

/-- **An orthonormal eigenframe for `W` on `Λ²`.** -/
structure Eigenframe (W : Matrix ι ι ℝ → Matrix ι ι ℝ) (v : κ → Matrix ι ι ℝ) (lam : κ → ℝ) :
    Prop where
  skew : ∀ a, IsSkew (v a)
  orthonormal : ∀ a b, inner2 (v a) (v b) = if a = b then 1 else 0
  eigen : ∀ a, W (v a) = lam a • v a
  complete : ∀ X : Matrix ι ι ℝ, IsSkew X → X ∈ Submodule.span ℝ (Set.range v)

/-- **`U = ∑_{λ_α < 0} im v_α`**, the sum over **all** negative eigenvectors read as skew matrices.
*The hypothesis of the lemma is on this subspace and no count of negative eigenvalues replaces it.*
-/
noncomputable def negSupport (v : κ → Matrix ι ι ℝ) (lam : κ → ℝ) : Submodule ℝ (ι → ℝ) :=
  ⨆ a : κ, ⨆ _ : lam a < 0, LinearMap.range (Matrix.mulVecLin (v a))

/-! ## The frame expansion and the Ricci balance -/

open HamiltonsCubic.L41Statement.Frame in
/-- **`W` in its own frame**: `W Y = Σ_α λ_α ⟨Y, v_α⟩ v_α` on bivectors. -/
theorem apply_frame {W : Matrix ι ι ℝ → Matrix ι ι ℝ} (hW : IsWeyl W) {v : κ → Matrix ι ι ℝ}
    {lam : κ → ℝ} (hf : Eigenframe W v lam) (Y : Matrix ι ι ℝ) (hY : IsSkew Y) :
    W Y = ∑ a, (lam a * inner2 Y (v a)) • v a := by
  obtain ⟨c, hc⟩ := (Submodule.mem_span_range_iff_exists_fun ℝ).mp (hf.complete Y hY)
  have hcoef : ∀ b, inner2 Y (v b) = c b := fun b => by
    rw [← hc, inner2_sum_l]
    simp only [inner2_smul_l, hf.orthonormal, mul_ite, mul_one, mul_zero, Finset.sum_ite_eq',
      Finset.mem_univ, if_true]
  conv_lhs => rw [← hc, weyl_lin hW _ _ _ hf.skew]
  refine Finset.sum_congr rfl fun a _ => ?_
  rw [hf.eigen, smul_smul, hcoef a, mul_comm]

/-- `⟨u ∧ w, V⟩ = w · (V u)` for a bivector `V`. -/
theorem inner2_wedge (u w : ι → ℝ) {V : Matrix ι ι ℝ} (hV : IsSkew V) :
    inner2 (wedgeVec u w) V = dotProduct w (V *ᵥ u) := by
  have hV' : ∀ p q, V q p = -V p q := fun p q => by
    have := congrFun (congrFun hV p) q; simpa [Matrix.transpose_apply] using this
  unfold inner2 wedgeVec
  simp only [Matrix.trace, Matrix.diag, Matrix.mul_apply, Matrix.transpose_apply, Matrix.sub_apply,
    Matrix.vecMulVec_apply, dotProduct, Matrix.mulVec, sub_mul, Finset.sum_sub_distrib, Finset.mul_sum]
  have h2 : ∑ x, ∑ i, u i * w x * V i x = -∑ x, ∑ i, w i * u x * V i x := by
    rw [Finset.sum_comm, ← Finset.sum_neg_distrib]
    exact Finset.sum_congr rfl fun x _ => by
      rw [← Finset.sum_neg_distrib]
      exact Finset.sum_congr rfl fun i _ => by rw [hV' x i]; ring
  rw [h2]
  simp only [sub_neg_eq_add, ← two_mul, ← Finset.mul_sum]
  rw [← mul_assoc]; norm_num
  rw [Finset.sum_comm]
  exact Finset.sum_congr rfl fun x _ => by
    rw [Finset.mul_sum]; exact Finset.sum_congr rfl fun i _ => by ring


open HamiltonsCubic.L41Statement.Frame in
/-- **`Ric(x, x) = Σ_α λ_α ‖v_α x‖²`**, the expansion the record's argument runs on. -/
theorem ric_quad {W : Matrix ι ι ℝ → Matrix ι ι ℝ} (hW : IsWeyl W) {v : κ → Matrix ι ι ℝ}
    {lam : κ → ℝ} (hf : Eigenframe W v lam) (u : ι → ℝ) :
    ∑ b, ∑ c, u b * u c * Ric W b c = ∑ a, lam a * dotProduct (v a *ᵥ u) (v a *ᵥ u) := by
  have hsk : ∀ a p q, v a q p = -v a p q := fun a p q => by
    have := congrFun (congrFun (hf.skew a) p) q; simpa [Matrix.transpose_apply] using this
  have hent : ∀ b c d, inner2 (W (phi b d)) (phi c d) = ∑ a, lam a * (v a b d * v a c d) := by
    intro b c d
    rw [apply_frame hW hf _ (phi_isSkew b d), inner2_sum_l]
    refine Finset.sum_congr rfl fun a _ => ?_
    rw [inner2_smul_l, HamiltonsCubic.RealLayer.inner2_phi _ (hf.skew a) c d, inner2_comm,
      HamiltonsCubic.RealLayer.inner2_phi _ (hf.skew a) b d]
    ring
  unfold Ric
  simp only [hent, dotProduct, Matrix.mulVec, Finset.mul_sum, Finset.sum_mul]
  have e1 : ∀ F : ι → ι → ι → κ → ℝ,
      ∑ b, ∑ c, ∑ d, ∑ a, F b c d a = ∑ p : ι × ι × ι × κ, F p.1 p.2.1 p.2.2.1 p.2.2.2 := by
    intro F; simp only [Fintype.sum_prod_type]
  have e2 : ∀ G : κ → ι → ι → ι → ℝ,
      ∑ a, ∑ d, ∑ b, ∑ c, G a d b c = ∑ q : κ × ι × ι × ι, G q.1 q.2.1 q.2.2.1 q.2.2.2 := by
    intro G; simp only [Fintype.sum_prod_type]
  refine (e1 _).trans ((Fintype.sum_equiv
    (⟨fun p => (p.2.2.2, p.2.2.1, p.1, p.2.1), fun q => (q.2.2.1, q.2.2.2, q.2.1, q.1),
      fun _ => rfl, fun _ => rfl⟩ : ι × ι × ι × κ ≃ κ × ι × ι × ι) _ _ ?_).trans (e2 _).symm)
  rintro ⟨b, c, d, a⟩
  simp only [Equiv.coe_fn_mk]
  rw [hsk a b d, hsk a c d]
  ring

/-- `u · (V z) = -(V u) · z` for a bivector `V`. -/
theorem dot_skew (u z : ι → ℝ) {V : Matrix ι ι ℝ} (hV : IsSkew V) :
    dotProduct u (V *ᵥ z) = -dotProduct (V *ᵥ u) z := by
  have hV' : ∀ p q, V q p = -V p q := fun p q => by
    have := congrFun (congrFun hV p) q; simpa [Matrix.transpose_apply] using this
  simp only [dotProduct, Matrix.mulVec, Finset.mul_sum, Finset.sum_mul, ← Finset.sum_neg_distrib]
  rw [Finset.sum_comm]
  exact Finset.sum_congr rfl fun j _ => Finset.sum_congr rfl fun i _ => by rw [hV' j i]; ring

/-! ## The first clause -/

/-- **L30, the support clause.** If `dim U < n` then `W` vanishes on `u ∧ u^⊥` for every `u ⊥ U`.

**Proved.** `ric_quad` with `Ric(W) = 0` gives `∑_α λ_α ‖v_α u‖² = 0`; `u ⊥ U` kills the negative
terms, so the balance kills the positive ones, and `W(u ∧ w) = ∑_α λ_α ⟨u ∧ w, v_α⟩ v_α` has every
coefficient `λ_α · w·(v_α u) = 0`. *`hdim` is carried from the record and unused.* -/
theorem L30_support (W : Matrix ι ι ℝ → Matrix ι ι ℝ) (hW : IsWeyl W)
    (v : κ → Matrix ι ι ℝ) (lam : κ → ℝ) (hframe : Eigenframe W v lam)
    (hdim : Module.finrank ℝ (negSupport v lam) < Fintype.card ι)
    (u : ι → ℝ) (hu : ∀ x ∈ negSupport v lam, dotProduct u x = 0) (w : ι → ℝ) :
    W (wedgeVec u w) = 0 := by
  have hneg : ∀ a, lam a < 0 → v a *ᵥ u = 0 := by
    intro a ha
    have hmem : v a *ᵥ (v a *ᵥ u) ∈ negSupport v lam := by
      unfold negSupport
      exact Submodule.mem_iSup_of_mem a (Submodule.mem_iSup_of_mem ha
        (LinearMap.mem_range.mpr ⟨v a *ᵥ u, rfl⟩))
    have h0 := hu _ hmem
    rw [dot_skew _ _ (hframe.skew a), neg_eq_zero] at h0
    exact dotProduct_self_eq_zero.mp h0
  have hq := ric_quad hW hframe u
  have hric : ∀ b c, Ric W b c = 0 := hW.2.2.2
  simp only [hric, mul_zero, Finset.sum_const_zero] at hq
  have hnn : ∀ a ∈ (Finset.univ : Finset κ), 0 ≤ lam a * dotProduct (v a *ᵥ u) (v a *ᵥ u) := by
    intro a _
    by_cases ha : lam a < 0
    · rw [hneg a ha]; simp
    · exact mul_nonneg (not_lt.mp ha) (Finset.sum_nonneg fun i _ => mul_self_nonneg _)
  have hz := (Finset.sum_eq_zero_iff_of_nonneg hnn).mp hq.symm
  have hall : ∀ a, lam a ≠ 0 → v a *ᵥ u = 0 := fun a ha =>
    dotProduct_self_eq_zero.mp ((mul_eq_zero.mp (hz a (Finset.mem_univ a))).resolve_left ha)
  rw [apply_frame hW hframe _ (wedgeVec_isSkew u w)]
  refine Finset.sum_eq_zero fun a _ => ?_
  by_cases h : lam a = 0
  · simp [h]
  · rw [inner2_wedge u w (hframe.skew a), hall a h]; simp


/-! ## The padding, built

`exists_isometry` gives an isometric `E` onto `U`, and `W' X = Eᵀ W(E X Eᵀ) E`. **Every eigenvector off
the kernel lives on `U`**: the first clause's balance gives `v_α u = 0` for `u ⊥ U` (`kill`), so
`v_α = P v_α P` with `P = E Eᵀ`, and `W` lands in `Λ²U`. Bianchi and Ricci pass to `W'` through the
frame expansion `⟨W(x∧y), z∧w⟩ = Σ λ_α (y·v_α x)(w·v_α z)`, which is multilinear, and an eigenframe
of `W'` built from `W`'s (`invariants`) carries the norm and `P` across unchanged. -/

section Padding

open Matrix

variable {d : ℕ}

theorem skew_entry {X : Matrix ι ι ℝ} (hX : IsSkew X) (p q : ι) : X q p = -X p q := by
  have := congrFun (congrFun hX p) q; simpa [Matrix.transpose_apply] using this

theorem inner2_conj (E : Matrix ι (Fin d) ℝ) (Z : Matrix ι ι ℝ) (Y : Matrix (Fin d) (Fin d) ℝ) :
    inner2 (Eᵀ * Z * E) Y = inner2 Z (E * Y * Eᵀ) := by
  unfold inner2
  congr 1
  rw [Matrix.transpose_mul, Matrix.transpose_mul, Matrix.transpose_transpose]
  rw [show Eᵀ * (Zᵀ * E) * Y = Eᵀ * (Zᵀ * E * Y) by simp only [Matrix.mul_assoc],
    Matrix.trace_mul_comm, show Zᵀ * E * Y * Eᵀ = Zᵀ * (E * Y * Eᵀ) by simp only [Matrix.mul_assoc]]

theorem skew_conjT (E : Matrix ι (Fin d) ℝ) {Z : Matrix ι ι ℝ} (hZ : IsSkew Z) : IsSkew (Eᵀ * Z * E) := by
  unfold IsSkew at *
  rw [Matrix.transpose_mul, Matrix.transpose_mul, Matrix.transpose_transpose, hZ]
  simp [Matrix.mul_assoc]

theorem skew_conj (E : Matrix ι (Fin d) ℝ) {Y : Matrix (Fin d) (Fin d) ℝ} (hY : IsSkew Y) : IsSkew (E * Y * Eᵀ) := by
  unfold IsSkew at *
  rw [Matrix.transpose_mul, Matrix.transpose_mul, Matrix.transpose_transpose, hY]
  simp [Matrix.mul_assoc]

/-- An isometric embedding onto any subspace. -/
theorem exists_isometry (U : Submodule ℝ (ι → ℝ)) :
    ∃ E : Matrix ι (Fin (Module.finrank ℝ U)) ℝ, Eᵀ * E = 1 ∧ LinearMap.range (Matrix.mulVecLin E) = U := by
  let e : (ι → ℝ) ≃ₗ[ℝ] EuclideanSpace ℝ ι := (WithLp.linearEquiv 2 ℝ (ι → ℝ)).symm
  let U' : Submodule ℝ (EuclideanSpace ℝ ι) := U.map (e : (ι → ℝ) →ₗ[ℝ] EuclideanSpace ℝ ι)
  have hd : Module.finrank ℝ U' = Module.finrank ℝ U := LinearEquiv.finrank_map_eq e U
  let b := (stdOrthonormalBasis ℝ U').reindex (finCongr hd)
  let E : Matrix ι (Fin (Module.finrank ℝ U)) ℝ := fun i j => ((b j : EuclideanSpace ℝ ι) i)
  have hmem : ∀ j, (fun i => E i j) ∈ U := by
    intro j
    have h := (b j).2
    obtain ⟨x, hx, hxe⟩ := Submodule.mem_map.mp h
    have : (fun i => E i j) = x := by
      ext i; simp only [E]; rw [← hxe]; rfl
    rw [this]; exact hx
  refine ⟨E, ?_, ?_⟩
  · ext j k
    have ho := b.orthonormal
    have hin : inner ℝ (b j : EuclideanSpace ℝ ι) (b k) = if j = k then 1 else 0 := by
      have := orthonormal_iff_ite.mp ho j k
      simpa [Submodule.coe_inner] using this
    rw [EuclideanSpace.inner_eq_star_dotProduct] at hin
    rw [Matrix.mul_apply, Matrix.one_apply, ← hin]
    simp only [dotProduct, Matrix.transpose_apply, E, star_trivial]
    exact Finset.sum_congr rfl fun i _ => mul_comm _ _
  · apply le_antisymm
    · rintro _ ⟨c, rfl⟩
      simp only [Matrix.mulVecLin_apply]
      have : E *ᵥ c = ∑ j, c j • (fun i => E i j) := by
        ext i; simp [Matrix.mulVec, dotProduct, Finset.sum_apply, mul_comm]
      rw [this]
      exact Submodule.sum_mem _ fun j _ => Submodule.smul_mem _ _ (hmem j)
    · intro x hx
      have hx' : (⟨e x, Submodule.mem_map_of_mem hx⟩ : U') = ∑ j, b.repr ⟨e x, Submodule.mem_map_of_mem hx⟩ j • b j :=
        (b.sum_repr _).symm
      refine ⟨fun j => b.repr ⟨e x, Submodule.mem_map_of_mem hx⟩ j, ?_⟩
      have h2 := congrArg (fun y : U' => ((y : EuclideanSpace ℝ ι) : ι → ℝ)) hx'
      simp only at h2
      ext i
      have h3 := congrFun h2 i
      simp only [Matrix.mulVecLin_apply, Matrix.mulVec, dotProduct, E]
      rw [show x i = (e x) i from rfl, h3]
      simp [Submodule.coe_sum, Finset.sum_apply, mul_comm]
      change (Matrix.mulVec E _) i = _; simp only [Matrix.mulVec, dotProduct, E]


theorem sum4 (F : ι → ι → ι → ι → ℝ) :
    ∑ p, ∑ q, ∑ r, ∑ s, F p q r s = ∑ t : ι × ι × ι × ι, F t.1 t.2.1 t.2.2.1 t.2.2.2 := by
  simp only [Fintype.sum_prod_type]

theorem e1 (M N : Matrix ι ι ℝ) (x y z w : ι → ℝ) :
    dotProduct y (M *ᵥ x) * dotProduct w (N *ᵥ z)
      = ∑ p, ∑ q, ∑ r, ∑ s, x p * y q * z r * w s * (M q p * N s r) := by
  simp only [dotProduct, mulVec, Finset.sum_mul, Finset.mul_sum]
  rw [sum4, sum4]
  refine Fintype.sum_equiv
    (⟨fun t => (t.2.2.2, t.2.2.1, t.2.1, t.1), fun t => (t.2.2.2, t.2.2.1, t.2.1, t.1),
      fun _ => rfl, fun _ => rfl⟩ : ι × ι × ι × ι ≃ ι × ι × ι × ι) _ _ ?_
  rintro ⟨a, b, c, e⟩; simp only [Equiv.coe_fn_mk]; ring

theorem e2 (M N : Matrix ι ι ℝ) (x y z w : ι → ℝ) :
    dotProduct z (M *ᵥ x) * dotProduct y (N *ᵥ w)
      = ∑ p, ∑ q, ∑ r, ∑ s, x p * y q * z r * w s * (M r p * N q s) := by
  simp only [dotProduct, mulVec, Finset.sum_mul, Finset.mul_sum]
  rw [sum4, sum4]
  refine Fintype.sum_equiv
    (⟨fun t => (t.2.2.2, t.1, t.2.2.1, t.2.1), fun t => (t.2.1, t.2.2.2, t.2.2.1, t.1),
      fun _ => rfl, fun _ => rfl⟩ : ι × ι × ι × ι ≃ ι × ι × ι × ι) _ _ ?_
  rintro ⟨a, b, c, e⟩; simp only [Equiv.coe_fn_mk]; ring

theorem e3 (M N : Matrix ι ι ℝ) (x y z w : ι → ℝ) :
    dotProduct w (M *ᵥ x) * dotProduct z (N *ᵥ y)
      = ∑ p, ∑ q, ∑ r, ∑ s, x p * y q * z r * w s * (M s p * N r q) := by
  simp only [dotProduct, mulVec, Finset.sum_mul, Finset.mul_sum]
  rw [sum4, sum4]
  refine Fintype.sum_equiv
    (⟨fun t => (t.2.2.2, t.2.1, t.1, t.2.2.1), fun t => (t.2.2.1, t.2.1, t.2.2.2, t.1),
      fun _ => rfl, fun _ => rfl⟩ : ι × ι × ι × ι ≃ ι × ι × ι × ι) _ _ ?_
  rintro ⟨a, b, c, e⟩; simp only [Equiv.coe_fn_mk]; ring


/-- **The restriction `W' X = Eᵀ W(E X Eᵀ) E`.** -/
noncomputable def Wp (W : Matrix ι ι ℝ → Matrix ι ι ℝ) (E : Matrix ι (Fin d) ℝ) :
    Matrix (Fin d) (Fin d) ℝ → Matrix (Fin d) (Fin d) ℝ := fun X => Eᵀ * W (E * X * Eᵀ) * E

theorem conj_phi (E : Matrix ι (Fin d) ℝ) (a c : Fin d) :
    E * phi a c * Eᵀ = wedgeVec (fun i => E i a) (fun i => E i c) := by
  ext i j
  simp only [phi, wedgeVec, Matrix.mul_sub, Matrix.sub_mul, Matrix.sub_apply, Matrix.vecMulVec_apply]
  simp [Matrix.mul_apply, Matrix.single_apply, ite_and, mul_ite, ite_mul, Finset.sum_ite_eq,
    Finset.sum_ite_eq']

theorem dot_P (E : Matrix ι (Fin d) ℝ) (y z : ι → ℝ) :
    ∑ c, dotProduct (fun i => E i c) y * dotProduct (fun i => E i c) z = dotProduct z (E *ᵥ (Eᵀ *ᵥ y)) := by
  simp only [dotProduct, Matrix.mulVec, Matrix.transpose_apply, Finset.sum_mul, Finset.mul_sum]
  rw [Finset.sum_comm]
  refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun c _ => Finset.sum_congr rfl fun j _ => by ring

section W
variable {W : Matrix ι ι ℝ → Matrix ι ι ℝ} (hW : IsWeyl W) {v : κ → Matrix ι ι ℝ} {lam : κ → ℝ}
  (hf : Eigenframe W v lam) {E : Matrix ι (Fin d) ℝ} (hE : Eᵀ * E = 1)
  {U : Submodule ℝ (ι → ℝ)} (hR : LinearMap.range (Matrix.mulVecLin E) = U)
  (hkill : ∀ u : ι → ℝ, (∀ x ∈ U, dotProduct u x = 0) → ∀ a, lam a ≠ 0 → v a *ᵥ u = 0)
include hW hf

/-- The first clause's balance, as a statement about each eigenvector off the kernel. -/
theorem kill (u : ι → ℝ) (hu : ∀ x ∈ negSupport v lam, dotProduct u x = 0) (a : κ) (ha : lam a ≠ 0) :
    v a *ᵥ u = 0 := by
  have hneg : ∀ a, lam a < 0 → v a *ᵥ u = 0 := by
    intro a ha
    have hmem : v a *ᵥ (v a *ᵥ u) ∈ negSupport v lam := by
      unfold negSupport
      exact Submodule.mem_iSup_of_mem a (Submodule.mem_iSup_of_mem ha
        (LinearMap.mem_range.mpr ⟨v a *ᵥ u, rfl⟩))
    have h0 := hu _ hmem
    rw [dot_skew _ _ (hf.skew a), neg_eq_zero] at h0
    exact dotProduct_self_eq_zero.mp h0
  have hq := ric_quad hW hf u
  have hric : ∀ b c, Ric W b c = 0 := hW.2.2.2
  simp only [hric, mul_zero, Finset.sum_const_zero] at hq
  have hnn : ∀ a ∈ (Finset.univ : Finset κ), 0 ≤ lam a * dotProduct (v a *ᵥ u) (v a *ᵥ u) := by
    intro a _
    by_cases ha : lam a < 0
    · rw [hneg a ha]; simp
    · exact mul_nonneg (not_lt.mp ha) (Finset.sum_nonneg fun i _ => mul_self_nonneg _)
  have hz := (Finset.sum_eq_zero_iff_of_nonneg hnn).mp hq.symm
  exact dotProduct_self_eq_zero.mp ((mul_eq_zero.mp (hz a (Finset.mem_univ a))).resolve_left ha)

include hE hR in
theorem perp (x : ι → ℝ) : ∀ y ∈ U, dotProduct (x - E *ᵥ (Eᵀ *ᵥ x)) y = 0 := by
  intro y hy
  rw [← hR] at hy
  obtain ⟨c, rfl⟩ := hy
  simp only [Matrix.mulVecLin_apply]
  rw [sub_dotProduct, dotProduct_mulVec, dotProduct_mulVec, Matrix.vecMul_mulVec, ← Matrix.mulVec_transpose,
    ← Matrix.mulVec_transpose, Matrix.mulVec_mulVec]
  simp [Matrix.transpose_mul, Matrix.mul_assoc, hE]

include hE hR hkill in
theorem vP (a : κ) (ha : lam a ≠ 0) : v a * (E * Eᵀ) = v a := by
  have h : ∀ x, v a *ᵥ (x - E *ᵥ (Eᵀ *ᵥ x)) = 0 := fun x => hkill _ (perp hW hf hE hR x) a ha
  apply Matrix.toLin'.injective
  refine LinearMap.ext fun x => ?_
  have := h x
  rw [Matrix.mulVec_sub, sub_eq_zero] at this
  simp only [Matrix.toLin'_apply, ← Matrix.mulVec_mulVec]
  exact this.symm

include hE hR hkill in
theorem Pv (a : κ) (ha : lam a ≠ 0) : (E * Eᵀ) * v a = v a := by
  have h := congrArg Matrix.transpose (vP hW hf hE hR hkill a ha)
  have hs := hf.skew a
  unfold IsSkew at hs
  rw [Matrix.transpose_mul, hs, Matrix.transpose_mul, Matrix.transpose_transpose, Matrix.mul_neg] at h
  exact neg_injective h

include hE hR hkill in
theorem W_P (Y : Matrix ι ι ℝ) (hY : IsSkew Y) : (E * Eᵀ) * W Y * (E * Eᵀ) = W Y := by
  rw [apply_frame hW hf Y hY, Matrix.mul_sum, Matrix.sum_mul]
  refine Finset.sum_congr rfl fun a _ => ?_
  by_cases ha : lam a = 0
  · simp [ha]
  · rw [Matrix.mul_smul, Matrix.smul_mul, Pv hW hf hE hR hkill a ha, vP hW hf hE hR hkill a ha]


/-- `⟨W(x ∧ y), z ∧ w⟩` in the frame. -/
theorem Kform (x y z w : ι → ℝ) :
    inner2 (W (wedgeVec x y)) (wedgeVec z w)
      = ∑ a, lam a * (dotProduct y (v a *ᵥ x) * dotProduct w (v a *ᵥ z)) := by
  rw [apply_frame hW hf _ (wedgeVec_isSkew x y), HamiltonsCubic.L41Statement.Frame.inner2_sum_l]
  refine Finset.sum_congr rfl fun a _ => ?_
  rw [HamiltonsCubic.L41Statement.Frame.inner2_smul_l, inner2_wedge x y (hf.skew a), inner2_comm,
    inner2_wedge z w (hf.skew a)]
  ring

/-- The Bianchi row of `W` in its frame. -/
theorem bianchi_frame (p q r s : ι) :
    ∑ a, lam a * (v a q p * v a s r + v a r p * v a q s + v a s p * v a r q) = 0 := by
  have hent : ∀ b c e f, inner2 (W (phi b c)) (phi e f) = ∑ a, lam a * (v a c b * v a f e) := by
    intro b c e f
    rw [apply_frame hW hf _ (phi_isSkew b c), HamiltonsCubic.L41Statement.Frame.inner2_sum_l]
    refine Finset.sum_congr rfl fun a _ => ?_
    rw [HamiltonsCubic.L41Statement.Frame.inner2_smul_l, inner2_phi _ (hf.skew a), inner2_comm,
      inner2_phi _ (hf.skew a), skew_entry (hf.skew a) c b, skew_entry (hf.skew a) f e]
    ring
  have h := hW.2.2.1 p q r s
  unfold bianchi at h
  rw [hent, hent, hent, ← Finset.sum_add_distrib, ← Finset.sum_add_distrib] at h
  rw [← h]
  exact Finset.sum_congr rfl fun a _ => by ring

/-- The Ricci balance, polarised: `Σ_α λ_α (v_α x)·(v_α y) = 0`. -/
theorem ric_pol (x y : ι → ℝ) : ∑ a, lam a * dotProduct (v a *ᵥ x) (v a *ᵥ y) = 0 := by
  have hz : ∀ u, ∑ a, lam a * dotProduct (v a *ᵥ u) (v a *ᵥ u) = 0 := fun u => by
    rw [← ric_quad hW hf u]; simp [hW.2.2.2]
  have h := hz (x + y)
  simp only [Matrix.mulVec_add, add_dotProduct, dotProduct_add, mul_add, Finset.sum_add_distrib, hz x,
    hz y, zero_add, add_zero] at h
  simp only [dotProduct_comm (v _ *ᵥ y) (v _ *ᵥ x)] at h
  linarith

theorem Wp_entry (a b c e : Fin d) :
    inner2 (Wp W E (phi a b)) (phi c e)
      = ∑ α, lam α * (dotProduct (fun i => E i b) (v α *ᵥ fun i => E i a)
          * dotProduct (fun i => E i e) (v α *ᵥ fun i => E i c)) := by
  unfold Wp
  rw [inner2_conj, conj_phi, conj_phi, Kform hW hf]

include hE hR hkill in
/-- **`W'` is a Weyl operator.** -/
theorem Wp_weyl : IsWeyl (Wp W E) := by
  refine ⟨fun X hX => skew_conjT E (hW.1 _ (skew_conj E hX)), fun X Y hX hY => ?_, fun i j k l => ?_,
    fun a b => ?_⟩
  · unfold Wp
    rw [inner2_conj, hW.2.1 _ _ (skew_conj E hX) (skew_conj E hY), inner2_comm X, inner2_conj, inner2_comm]
  · unfold bianchi
    rw [Wp_entry hW hf, Wp_entry hW hf, Wp_entry hW hf]
    simp only [e1 (x := fun t => E t i) (y := fun t => E t j) (z := fun t => E t k) (w := fun t => E t l),
      e2 (x := fun t => E t i) (y := fun t => E t j) (z := fun t => E t k) (w := fun t => E t l),
      e3 (x := fun t => E t i) (y := fun t => E t j) (z := fun t => E t k) (w := fun t => E t l)]
    rw [← Finset.sum_add_distrib, ← Finset.sum_add_distrib]
    simp only [Finset.mul_sum, ← Finset.sum_add_distrib]
    rw [Finset.sum_comm]; refine Finset.sum_eq_zero fun p _ => ?_
    rw [Finset.sum_comm]; refine Finset.sum_eq_zero fun q _ => ?_
    rw [Finset.sum_comm]; refine Finset.sum_eq_zero fun r _ => ?_
    rw [Finset.sum_comm]; refine Finset.sum_eq_zero fun s _ => ?_
    have hb := bianchi_frame hW hf p q r s
    calc _ = E p i * E q j * E r k * E s l
          * ∑ α, lam α * (v α q p * v α s r + v α r p * v α q s + v α s p * v α r q) := by
            rw [Finset.mul_sum]; exact Finset.sum_congr rfl fun α _ => by ring
      _ = 0 := by rw [hb, mul_zero]
  · unfold Ric
    simp only [Wp_entry hW hf]
    rw [Finset.sum_comm]
    rw [← ric_pol hW hf (fun i => E i a) (fun i => E i b)]
    refine Finset.sum_congr rfl fun α _ => ?_
    by_cases hα : lam α = 0
    · simp [hα]
    · rw [← Finset.mul_sum, dot_P, Matrix.mulVec_mulVec, Matrix.mulVec_mulVec, Pv hW hf hE hR hkill α hα,
        dotProduct_comm]

include hE hR hkill in
/-- **`W(E X Eᵀ) = E W'(X) Eᵀ`.** -/
theorem conj_eq (X : Matrix (Fin d) (Fin d) ℝ) (hX : IsSkew X) : W (E * X * Eᵀ) = E * Wp W E X * Eᵀ := by
  unfold Wp
  rw [show E * (Eᵀ * W (E * X * Eᵀ) * E) * Eᵀ = (E * Eᵀ) * W (E * X * Eᵀ) * (E * Eᵀ) by
    simp only [Matrix.mul_assoc], W_P hW hf hE hR hkill _ (skew_conj E hX)]

omit hW in
theorem toL41 : HamiltonsCubic.L41Statement.EigenFrame W v lam := by
  refine ⟨hf.skew, hf.orthonormal, hf.eigen, fun X hX => ?_⟩
  obtain ⟨c, hc⟩ := (Submodule.mem_span_range_iff_exists_fun ℝ).mp (hf.complete X hX)
  have hcoef : ∀ b, inner2 X (v b) = c b := fun b => by
    rw [← hc, HamiltonsCubic.L41Statement.Frame.inner2_sum_l]
    simp only [HamiltonsCubic.L41Statement.Frame.inner2_smul_l, hf.orthonormal, mul_ite, mul_one, mul_zero,
      Finset.sum_ite_eq', Finset.mem_univ, if_true]
  simp only [hcoef]; exact hc.symm

omit hW hf in
theorem sumS (f : κ → ℝ) (h : ∀ a, lam a = 0 → f a = 0) :
    ∑ s : {a // lam a ≠ 0}, f s = ∑ a, f a := by
  rw [← Fintype.sum_subtype_add_sum_subtype (fun a => lam a ≠ 0) f]
  have : ∑ a : {a // ¬ lam a ≠ 0}, f a = 0 := Finset.sum_eq_zero fun a _ => h a (not_not.mp a.2)
  rw [this, add_zero]

open HamiltonsCubic.L41Statement HamiltonsCubic.L41Statement.Frame in
include hE hR hkill in
/-- **`‖W'‖ = ‖W‖` and `P(W') = P(W)`**, read off an eigenframe of `W'` built from `W`'s. -/
theorem invariants : normSq (Wp W E) = normSq W ∧ Pcubic (Wp W E) = Pcubic W := by
  classical
  have hW' := Wp_weyl hW hf hE hR hkill
  have hf0 := toL41 hf
  let f : {a // lam a ≠ 0} → Matrix (Fin d) (Fin d) ℝ := fun s => Eᵀ * v s.1 * E
  have hPvP : ∀ s : {a // lam a ≠ 0}, E * f s * Eᵀ = v s.1 := fun s => by
    simp only [f]
    rw [show E * (Eᵀ * v s.1 * E) * Eᵀ = (E * Eᵀ) * v s.1 * (E * Eᵀ) by simp only [Matrix.mul_assoc],
      Pv hW hf hE hR hkill _ s.2, vP hW hf hE hR hkill _ s.2]
  have hfs : ∀ s, IsSkew (f s) := fun s => skew_conjT E (hf.skew s.1)
  have hfon : ∀ s t, inner2 (f s) (f t) = if s = t then 1 else 0 := by
    intro s t
    rw [show inner2 (f s) (f t) = inner2 (v s.1) (E * f t * Eᵀ) from inner2_conj E _ _, hPvP t,
      hf.orthonormal]
    by_cases h : s = t
    · simp [h]
    · rw [if_neg (fun h' => h (Subtype.ext h')), if_neg h]
  obtain ⟨r, g, hgs, hgon, hfg, hcomp⟩ := HamiltonsCubic.FrameExtension.extend_frame f hfs hfon
  have hWf : ∀ s, Wp W E (f s) = lam s.1 • f s := by
    intro s; unfold Wp; rw [hPvP, hf.eigen]; simp [f, Matrix.smul_mul, Matrix.mul_smul]
  have hWg : ∀ c, Wp W E (g c) = 0 := by
    intro c; unfold Wp
    rw [apply_frame hW hf _ (skew_conj E (hgs c))]
    have : ∀ a, lam a * inner2 (E * g c * Eᵀ) (v a) = 0 := by
      intro a
      by_cases ha : lam a = 0
      · simp [ha]
      · have h := hfg ⟨a, ha⟩ c
        rw [show inner2 (f ⟨a, ha⟩) (g c) = inner2 (v a) (E * g c * Eᵀ) from inner2_conj E _ _] at h
        rw [inner2_comm, h, mul_zero]
    simp [this]
  let v' : {a // lam a ≠ 0} ⊕ Fin r → Matrix (Fin d) (Fin d) ℝ := Sum.elim f g
  let lv : {a // lam a ≠ 0} ⊕ Fin r → ℝ := Sum.elim (fun s => lam s.1) (fun _ => 0)
  have hgf : ∀ c s, inner2 (g c) (f s) = 0 := fun c s => by rw [inner2_comm]; exact hfg s c
  have hf' : EigenFrame (Wp W E) v' lv := by
    refine ⟨?_, ?_, ?_, ?_⟩
    · rintro (s|c); exacts [hfs s, hgs c]
    · rintro (s|c) (t|e) <;> simp [v', hfon, hgon, hfg, hgf]
    · rintro (s|c)
      · simp [v', lv, hWf]
      · simp [v', lv, hWg]
    · intro X hX; rw [Fintype.sum_sum_type]; exact hcomp X hX
  have hcst : ∀ s t u : {a // lam a ≠ 0}, cst v' (Sum.inl s) (Sum.inl t) (Sum.inl u) = cst v s.1 t.1 u.1 := by
    intro s t u
    simp only [cst, v', Sum.elim_inl]
    have hb : br (f s) (f t) = Eᵀ * br (v s.1) (v t.1) * E := by
      simp only [br, f]
      rw [show Eᵀ * v s.1 * E * (Eᵀ * v t.1 * E) = Eᵀ * (v s.1 * (E * Eᵀ) * v t.1) * E by
          simp only [Matrix.mul_assoc],
        show Eᵀ * v t.1 * E * (Eᵀ * v s.1 * E) = Eᵀ * (v t.1 * (E * Eᵀ) * v s.1) * E by
          simp only [Matrix.mul_assoc],
        vP hW hf hE hR hkill _ s.2, vP hW hf hE hR hkill _ t.2, Matrix.mul_sub, Matrix.sub_mul]
    rw [hb, inner2_conj, hPvP]
  have hn : normSq (Wp W E) = normSq W := by
    rw [normSq_frame hW' hf', normSq_frame hW hf0, Fintype.sum_sum_type]
    simp only [lv, Sum.elim_inl, Sum.elim_inr, ne_eq, OfNat.ofNat_ne_zero, not_false_eq_true, zero_pow,
      Finset.sum_const_zero, add_zero]
    exact sumS (fun a => lam a ^ 2) (fun a ha => by simp [ha])
  have hc : trCube (Wp W E) = trCube W := by
    rw [trCube_frame hW' hf', trCube_frame hW hf0, Fintype.sum_sum_type]
    simp only [lv, Sum.elim_inl, Sum.elim_inr, ne_eq, OfNat.ofNat_ne_zero, not_false_eq_true, zero_pow,
      Finset.sum_const_zero, add_zero]
    exact sumS (fun a => lam a ^ 3) (fun a ha => by simp [ha])
  have hs : sharpPair (Wp W E) = sharpPair W := by
    rw [sharpPair_T hW' hf', sharpPair_T hW hf0]
    congr 1
    simp only [Fintype.sum_sum_type, lv, Sum.elim_inl, Sum.elim_inr, zero_mul, mul_zero,
      Finset.sum_const_zero, add_zero, hcst]
    rw [← sumS (lam := lam) (f := fun a => ∑ b, ∑ c, lam a * lam b * lam c * cst v a b c ^ 2)
      (fun a ha => by simp [ha])]
    refine Finset.sum_congr rfl fun s _ => ?_
    rw [← sumS (lam := lam) (f := fun b => ∑ c, lam s.1 * lam b * lam c * cst v s.1 b c ^ 2)
      (fun b hb => by simp [hb])]
    refine Finset.sum_congr rfl fun t _ => ?_
    rw [← sumS (lam := lam) (f := fun c => lam s.1 * lam t.1 * lam c * cst v s.1 t.1 c ^ 2)
      (fun c hc => by simp [hc])]
  refine ⟨hn, ?_⟩
  unfold Pcubic; rw [hc, hs]

end W

end Padding

/-! ## The second clause -/

/-- **L30, the padding clause**, the record's [Lemma L164](../../../findings/stratum-two-negative.md).
`W` is a padding of a `𝒲_{dim U}` tensor with the same norm and the same `θ`: there is an isometric
embedding `E` of `ℝ^{dim U}` onto `U` and a `W' ∈ 𝒲_{dim U}` with
`W (E X Eᵀ) = E (W' X) Eᵀ` for every bivector `X`, and `‖W'‖ = ‖W‖`, `θ(W') = θ(W)`.

**Proved.** `exists_isometry` supplies `E`, `W' = Wp W E`, `Wp_weyl` is L164's inheritance of the
Weyl conditions, `conj_eq` its invariance of `Λ²U`, and `invariants` the norm and `θ`. *`hW0` and
`hdim` are unused: at `W = 0` or `U = ℝⁿ` the statement holds with the same construction.* -/
theorem L30_padding (W : Matrix ι ι ℝ → Matrix ι ι ℝ) (hW : IsWeyl W) (hW0 : W ≠ fun _ => 0)
    (v : κ → Matrix ι ι ℝ) (lam : κ → ℝ) (hframe : Eigenframe W v lam)
    (hdim : Module.finrank ℝ (negSupport v lam) < Fintype.card ι) :
    ∃ (E : Matrix ι (Fin (Module.finrank ℝ (negSupport v lam))) ℝ)
      (W' : Matrix (Fin (Module.finrank ℝ (negSupport v lam)))
              (Fin (Module.finrank ℝ (negSupport v lam))) ℝ →
            Matrix (Fin (Module.finrank ℝ (negSupport v lam)))
              (Fin (Module.finrank ℝ (negSupport v lam))) ℝ),
      Eᵀ * E = 1 ∧
      LinearMap.range (Matrix.mulVecLin E) = negSupport v lam ∧
      IsWeyl W' ∧
      (∀ X, IsSkew X → W (E * X * Eᵀ) = E * W' X * Eᵀ) ∧
      norm W' = norm W ∧ theta W' = theta W := by
  obtain ⟨E, hE, hR⟩ := exists_isometry (negSupport v lam)
  have hkill := fun u hu a ha => kill hW hframe u hu a ha
  obtain ⟨hn, hP⟩ := invariants hW hframe hE hR hkill
  have hnorm : HamiltonsCubic.RealLayer.norm (Wp W E) = HamiltonsCubic.RealLayer.norm W := by
    unfold HamiltonsCubic.RealLayer.norm; rw [hn]
  refine ⟨E, Wp W E, hE, hR, Wp_weyl hW hframe hE hR hkill, fun X hX => conj_eq hW hframe hE hR hkill X hX, hnorm, ?_⟩
  unfold theta; rw [hP, hnorm]


/-! ## The mechanism: Ricci-flatness is a balance of positive semidefinite matrices -/

/-- **`⟨x, (vᵀv)x⟩ = ‖vx‖²`**, so `vᵀv ⪰ 0` for every matrix `v`. -/
theorem quadratic_form_transpose (v : Matrix ι ι ℝ) (x : ι → ℝ) :
    dotProduct x ((vᵀ * v).mulVec x) = dotProduct (v.mulVec x) (v.mulVec x) := by
  rw [← Matrix.mulVec_mulVec, dotProduct_mulVec, Matrix.vecMul_transpose]

/-- **Hence `vᵀv` is positive semidefinite.** -/
theorem transpose_mul_self_psd (v : Matrix ι ι ℝ) (x : ι → ℝ) :
    0 ≤ dotProduct x ((vᵀ * v).mulVec x) := by
  rw [quadratic_form_transpose]
  exact Finset.sum_nonneg fun i _ => mul_self_nonneg _

/-- **For a bivector this reads `vᵀv = −v²`**, which is the form the record's identity
`∑_α λ_α v_αᵀ v_α = 0` is written in. -/
theorem skew_transpose_mul_self {v : Matrix ι ι ℝ} (hv : IsSkew v) : vᵀ * v = -(v * v) := by
  unfold IsSkew at hv
  rw [hv, Matrix.neg_mul]

/-- **The balance step.** A vanishing sum of non-negative terms has every term zero, which is how
the positive semidefinite identity forces `v_α u = 0` for every `α` with `λ_α ≠ 0`. -/
theorem balance {κ' : Type*} (s : Finset κ') (q : κ' → ℝ) (hnn : ∀ i ∈ s, 0 ≤ q i)
    (hzero : ∑ i ∈ s, q i = 0) : ∀ i ∈ s, q i = 0 :=
  (Finset.sum_eq_zero_iff_of_nonneg hnn).mp hzero

/-- **`v x = 0` is exactly `⟨x, (vᵀv)x⟩ = 0`**, which is how the balance is read back onto the
eigenvectors. -/
theorem mulVec_eq_zero_iff (v : Matrix ι ι ℝ) (x : ι → ℝ) :
    dotProduct x ((vᵀ * v).mulVec x) = 0 ↔ v.mulVec x = 0 := by
  rw [quadratic_form_transpose]
  constructor
  · intro h
    funext i
    have hnn : ∀ j ∈ (Finset.univ : Finset ι), 0 ≤ v.mulVec x j * v.mulVec x j :=
      fun _ _ => mul_self_nonneg _
    have := (Finset.sum_eq_zero_iff_of_nonneg hnn).mp h i (Finset.mem_univ i)
    have h2 : v.mulVec x i = 0 := by nlinarith [this]
    simpa using h2
  · intro h
    rw [h]
    simp [dotProduct]

end HamiltonsCubic.L30Statement
