import Mathlib
import HamiltonsCubic.Base.FoxProduct
import HamiltonsCubic.Base.Families
import HamiltonsCubic.Base.SharpDiag
import HamiltonsCubic.Results.L97Statement

set_option linter.style.longLine false
set_option linter.unusedSectionVars false

/-!
# L99, the direct-sum scaling law, and the component-indicator family

## The record's statement, quoted verbatim from [diagonal-half.md](../../../findings/diagonal-half.md)

> #### Lemma L99, a diagonal critical point with two components carrying an edge fails second-order maximality

> **Lemma L99, proved.** *Let $M\in\mathcal D_n$ be a diagonal critical point with $\theta>0$ whose
> support graph has at least two components carrying an edge. Then
> $\lambda_{\max}(L_e\vert_{W^\perp})\ge1$, so $W$ is not a maximiser.* **The hypothesis is sharp
> for this family**, the $k^+=1$ case being exhausted by the radial direction, *and the wider
> statement that stood here, for every disconnected point, is refuted by this file's own padded
> $S^4\times S^4$ row at $n=9$, where the extra components are singletons,
> $\lambda_{\max}(L_e)=0.5714<1$ and $\cos(N,M)=+1$.*

and the construction it rests on, from the same block:

> **The construction, and it is a derivation rather than a check.** A direct sum of diagonal
> critical points is critical **once scaled as criticality forces**: $M=\bigoplus\lambda_iM_i$ with
> $\lambda_i\theta_i=\theta$. […] Unit norm is $\sum_i\lambda_i^2=1$, so $\theta^2\sum_i\theta_i^{-2}=1$
> and $$\theta=\Big(\textstyle\sum_i\theta_i^{-2}\Big)^{-1/2}.$$
> **This is the harmonic-square law** […] additivity closes the loop,
> $\theta(M)=\sum_i\lambda_i^3\theta_i=\theta^3\sum_i\theta_i^{-2}=\theta$.

> On such a point the **component-indicator** deformation $N_{ab}=a_{c(a)}M_{ab}$, with $a$ constant
> on each component, gives an admissible direction, **and the condition is
> $\sum_ca_c\theta_c^{-2}=0$ over the EDGE-CARRYING components**, since
> $\langle N,M\rangle=\theta^2\sum_ca_c\theta_c^{-2}$ and a singleton component contributes nothing
> whatever its $a_c$. *The condition $\sum a=0$ that stood here is the one this file withdraws ten
> lines above […]*

> **So the $A=\operatorname{diag}(a)$ family is live exactly where at least TWO components carry an
> edge**, and there it delivers a non-radial admissible $N$ with $\mathcal LN=\theta N$ exactly.
> Writing $k^+$ for the number of edge-carrying components: at $k^+\ge2$, taking
> $a_{c_1}=\theta_{c_1}^2$ and $a_{c_2}=-\theta_{c_2}^2$ gives $N\ne0$ with $N\perp M$, so
> $\lambda_{\max}(L_e\vert_{W^\perp})\ge1>\tfrac12$ and [Lemma L24](../results.md) fails; at
> $k^+=1$ the condition forces $N\propto M$, which is radial and certifies nothing; at $k^+=0$ the
> family is empty. **The admissible eigenspace has dimension $k^+-1$**, so three or more
> edge-carrying components give a violation of multiplicity at least two.

## What is typed here

* `scaling_forced`, criticality forces `λᵢ²θᵢ = θλᵢ`, hence `λᵢθᵢ = θ` at every `λᵢ ≠ 0`.
* `harmonic_square_law`, with `λᵢθᵢ = θ` and `∑ λᵢ² = 1`, the law `θ²∑θᵢ⁻² = 1`, and its
  root form `θ = (∑θᵢ⁻²)^(-1/2)` at `θ > 0`.
* `additivity_closes_the_loop`, `∑ λᵢ³θᵢ = θ`, the record's check that the law is consistent.
* `admissible_witness`, at `k⁺ ≥ 2`, the record's own `a_{c₁} = θ_{c₁}²`, `a_{c₂} = -θ_{c₂}²` is
  admissible and **nonzero**, so the direction it produces is not the zero one.
* `singleton_drops_out`, the admissibility functional runs over the edge-carrying components only,
  so a singleton's `a_c` is unconstrained and contributes nothing. *This is the correction that
  replaced `∑ a = 0`, and `withdrawn_condition_differs` exhibits a coefficient vector satisfying
  one condition and not the other.*
* `k_plus_one_is_radial`, at `k⁺ = 1` admissibility forces `a_{c₁} = 0`; without it the
  deformation is `a_{c₁}·M`, a multiple of `M`, which is the radial direction.
* `admissible_dim`, the admissible space is the kernel of a surjective linear functional on
  `ℝ^{k⁺}`, so `finrank ker + 1 = k⁺`. *Stated in that form rather than as `k⁺ - 1`, because the
  subtraction would be over `ℕ`.*

* `SplitsAlong`, `blockNormSq`, `CarriesEdge`, `indDir`, `indCoeff`, the support partition and
  the component-indicator direction `N_{ab} = a_{c(a)}M_{ab}`, on
  [Families.lean](../Base/Families.lean)'s diagonal locus. `indDir_isWeight` puts `N` back on the
  locus, `indDir_isWeylOp` puts it in `𝒲ₙ`, `indDir_perp` is `⟨N,M⟩ = 0` and `indDir_ne_zero` is
  `N ≠ 0`, the last using both `CarriesEdge` hypotheses and nothing else.
* `L99`, **the lemma**, `RayleighGE (diagOp w) θ 1`, which is
  [FoxProduct.lean](../Base/FoxProduct.lean)'s reading of `λ_max(L_e|_{W^⊥}) ≥ 1`; and
  `not_maximiser`, its conclusion, `¬ RayleighLE (diagOp w) θ ½` against
  [Lemma L24](../../../results.md)'s bound.
* `k_plus_one_certifies_nothing`, at one edge-carrying block every admissible direction of this
  family has zero norm, so it is no `RayleighGE` witness. This is the sharpness the record claims.

**`indicator_eigen` is proved (2026-09-24)**, `L_e N = N`, the record's `𝓛N = θN` in the `e = W/θ`
normalisation, and at every coefficient vector (`indicator`), not only the orthogonal one: `∘` at two
diagonal operators is `foxProd_diag`, the polarisation of `Qop` on the locus, which needed no general
bilinearity of `∘`, and L97's `diagCriticalRow` supplies the criticality row. The file carries no `sorry`.

## What is NOT typed here

**`dim ker M` = the number of connected components.** The record proves it by recognising
`M² - θM` as the Laplacian of the weighted graph `w_{ab} = M_{ab}²` and using that its kernel is
spanned by the component indicators; the converse half needs graph connectivity machinery this
file does not develop. What is used instead is a partition the weight respects, the component
partition is one, and two edge-carrying blocks of any adapted partition contain two edge-carrying
components, so the hypothesis is the record's without the machinery.

**The harmonic-square normalisation of the coefficients.** `indCoeff` is written in the block
masses `‖M^{(γ)}‖²` rather than in the record's `θ_c²`; the two agree by `λ_c = θ/θ_c`, which is
`harmonic_square_law` above, but the identification of a block's multiplier `θ_c` with a critical
point of its own needs `Qop` restricted to a block, which no layer builds.
-/

namespace HamiltonsCubic.L99Statement

open Finset

variable {ι : Type*} [Fintype ι]

/-! ## The direct-sum scaling law -/

omit [Fintype ι] in
/-- **Criticality forces the scaling.** `Q` is quadratic and the blocks are `∘`-orthogonal, so
`Q(M) = ⊕ λᵢ² θᵢ Mᵢ` while `θM = ⊕ θλᵢ Mᵢ`; matching blocks gives `λᵢ²θᵢ = θλᵢ`, hence
`λᵢθᵢ = θ` wherever `λᵢ ≠ 0`. -/
theorem scaling_forced {lam th : ι → ℝ} {θ : ℝ}
    (hblock : ∀ i, lam i ^ 2 * th i = θ * lam i) :
    ∀ i, lam i ≠ 0 → lam i * th i = θ := by
  intro i hne
  have := hblock i
  field_simp at this ⊢
  nlinarith [this, sq_nonneg (lam i)]

/-- **THE HARMONIC-SQUARE LAW.** With `λᵢθᵢ = θ` at every block and unit norm `∑ λᵢ² = 1`, the
multiplier satisfies `θ² ∑ θᵢ⁻² = 1`. -/
theorem harmonic_square_law {lam th : ι → ℝ} {θ : ℝ}
    (hth : ∀ i, th i ≠ 0)
    (hscale : ∀ i, lam i * th i = θ)
    (hnorm : ∑ i, lam i ^ 2 = 1) :
    θ ^ 2 * ∑ i, (th i) ⁻¹ ^ 2 = 1 := by
  have hlam : ∀ i, lam i = θ / th i := fun i => by
    rw [eq_div_iff (hth i)]; exact hscale i
  rw [Finset.mul_sum, ← hnorm]
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [hlam i]
  field_simp

/-- **The law in the record's root form**, `θ = (∑ θᵢ⁻²)^(-1/2)`, at `θ > 0`. -/
theorem harmonic_square_root_form {lam th : ι → ℝ} {θ : ℝ}
    (hth : ∀ i, th i ≠ 0)
    (hscale : ∀ i, lam i * th i = θ)
    (hnorm : ∑ i, lam i ^ 2 = 1)
    (hpos : 0 < θ) :
    θ = (Real.sqrt (∑ i, (th i) ⁻¹ ^ 2))⁻¹ := by
  have hlaw := harmonic_square_law hth hscale hnorm
  have hS : ∑ i, (th i) ⁻¹ ^ 2 = (θ ^ 2)⁻¹ := by
    field_simp at hlaw ⊢
    linarith
  rw [hS]
  rw [show ((θ ^ 2)⁻¹ : ℝ) = (θ⁻¹) ^ 2 by field_simp]
  rw [Real.sqrt_sq (by positivity), inv_inv]

/-- **ADDITIVITY CLOSES THE LOOP**: `∑ λᵢ³θᵢ = θ³ ∑ θᵢ⁻² = θ`. -/
theorem additivity_closes_the_loop {lam th : ι → ℝ} {θ : ℝ}
    (hscale : ∀ i, lam i * th i = θ)
    (hnorm : ∑ i, lam i ^ 2 = 1) :
    ∑ i, lam i ^ 3 * th i = θ := by
  have hlam : ∀ i, lam i * th i = θ := hscale
  have : ∀ i ∈ (Finset.univ : Finset ι), lam i ^ 3 * th i = θ * lam i ^ 2 := by
    intro i _
    have := hlam i
    nlinarith [this]
  rw [Finset.sum_congr rfl this, ← Finset.mul_sum, hnorm, mul_one]

/-! ## The component-indicator family

*`C` indexes the components, `E ⊆ C` the edge-carrying ones, `th c` the component multipliers. The
admissibility condition is `∑_{c ∈ E} a_c θ_c⁻² = 0`, over the edge-carrying components alone,
which is the correction this block records.* -/

variable {C : Type*} [Fintype C] [DecidableEq C]

/-- Admissibility of a coefficient vector: `⟨N, M⟩ = 0`, which is `∑_{c ∈ E} a_c θ_c⁻² = 0`. -/
def Admissible (E : Finset C) (th : C → ℝ) (a : C → ℝ) : Prop :=
  ∑ c ∈ E, a c * (th c) ⁻¹ ^ 2 = 0

omit [Fintype C] in
/-- **THE RECORD'S WITNESS AT `k⁺ ≥ 2`.** Two edge-carrying components `c₁ ≠ c₂` with
`a_{c₁} = θ_{c₁}²`, `a_{c₂} = -θ_{c₂}²` and `a = 0` elsewhere is admissible and **nonzero**. -/
theorem admissible_witness {E : Finset C} {th : C → ℝ} {c₁ c₂ : C}
    (hth : ∀ c, th c ≠ 0)
    (h1 : c₁ ∈ E) (h2 : c₂ ∈ E) (hne : c₁ ≠ c₂) :
    Admissible E th
        (fun c => (if c = c₁ then th c₁ ^ 2 else 0) - (if c = c₂ then th c₂ ^ 2 else 0)) ∧
      (fun c => (if c = c₁ then th c₁ ^ 2 else 0) - (if c = c₂ then th c₂ ^ 2 else 0)) ≠ 0 := by
  have hpt : ∀ c ∈ E,
      ((if c = c₁ then th c₁ ^ 2 else 0) - (if c = c₂ then th c₂ ^ 2 else 0)) * (th c) ⁻¹ ^ 2
        = (if c = c₁ then (1 : ℝ) else 0) - (if c = c₂ then (1 : ℝ) else 0) := by
    intro c _
    by_cases hb1 : c = c₁
    · subst hb1
      have hb2 : c ≠ c₂ := hne
      simp only [ite_true, if_neg hb2, sub_zero]
      field_simp [hth c]
    · by_cases hb2 : c = c₂
      · subst hb2
        simp only [if_neg hb1, ite_true, zero_sub]
        field_simp [hth c]
      · simp only [if_neg hb1, if_neg hb2, sub_zero, zero_mul]
  constructor
  · unfold Admissible
    rw [Finset.sum_congr rfl hpt, Finset.sum_sub_distrib,
      Finset.sum_ite_eq' E c₁ (fun _ => (1 : ℝ)), Finset.sum_ite_eq' E c₂ (fun _ => (1 : ℝ)),
      if_pos h1, if_pos h2, sub_self]
  · intro hzero
    have hc := congrFun hzero c₁
    simp only [ite_true, if_neg hne, sub_zero, Pi.zero_apply] at hc
    exact hth c₁ (pow_eq_zero_iff (n := 2) (by norm_num) |>.mp hc)

omit [Fintype C] in
/-- **A SINGLETON COMPONENT DROPS OUT.** The functional sums over `E` only, so a component outside
`E` may carry any coefficient at all without affecting admissibility. -/
theorem singleton_drops_out {E : Finset C} {th : C → ℝ} {a : C → ℝ} {c₀ : C} (hc₀ : c₀ ∉ E)
    (t : ℝ) :
    Admissible E th a ↔ Admissible E th (Function.update a c₀ t) := by
  unfold Admissible
  constructor <;> intro h <;>
  · rw [← h]
    refine Finset.sum_congr rfl fun c hc => ?_
    have : c ≠ c₀ := fun he => hc₀ (he ▸ hc)
    simp [this]

/-- **THE WITHDRAWN CONDITION IS A DIFFERENT CONDITION.** With `θ_{c₁} = 1` and `θ_{c₂} = 2`, the
vector `(1, -4)` satisfies `∑_{c ∈ E} a_c θ_c⁻² = 0` while `∑_{c ∈ E} a_c ≠ 0`; the vector
`(1, -1)` satisfies the second and not the first. -/
theorem withdrawn_condition_differs :
    (Admissible (Finset.univ : Finset (Fin 2)) ![1, 2] ![1, -4] ∧
        ∑ c, (![1, -4] : Fin 2 → ℝ) c ≠ 0) ∧
      (∑ c, (![1, -1] : Fin 2 → ℝ) c = 0 ∧
        ¬ Admissible (Finset.univ : Finset (Fin 2)) ![1, 2] ![1, -1]) := by
  unfold Admissible
  refine ⟨⟨?_, ?_⟩, ?_, ?_⟩ <;> norm_num [Fin.sum_univ_two]

omit [Fintype C] [DecidableEq C] in
/-- **AT `k⁺ = 1` THE FAMILY IS RADIAL.** With a single edge-carrying component, admissibility
forces its coefficient to vanish; and without the admissibility constraint the deformation is
`a_{c₁} · M`, a multiple of `M`. -/
theorem k_plus_one_is_radial {th : C → ℝ} {a : C → ℝ} {c₁ : C}
    (hth : th c₁ ≠ 0)
    (h : Admissible {c₁} th a) : a c₁ = 0 := by
  unfold Admissible at h
  rw [Finset.sum_singleton] at h
  have hinv : ((th c₁) ⁻¹ ^ 2 : ℝ) ≠ 0 := by positivity
  exact (mul_eq_zero.mp h).resolve_right hinv

/-! ## The dimension of the admissible space -/

/-- The admissibility functional on the edge-carrying components, as a linear map. -/
noncomputable def admFunctional (th : C → ℝ) : (C → ℝ) →ₗ[ℝ] ℝ where
  toFun a := ∑ c, a c * (th c) ⁻¹ ^ 2
  map_add' a b := by simp [Finset.sum_add_distrib, add_mul]
  map_smul' r a := by simp [Finset.mul_sum, mul_assoc]

/-- **THE ADMISSIBLE EIGENSPACE HAS DIMENSION `k⁺ - 1`**, stated as `finrank ker + 1 = k⁺` so that
no truncated subtraction over `ℕ` enters. *The functional is surjective because a single component
already realises every value.* -/
theorem admissible_dim {th : C → ℝ} (hth : ∀ c, th c ≠ 0) (c₀ : C) :
    Module.finrank ℝ (LinearMap.ker (admFunctional th)) + 1 = Fintype.card C := by
  classical
  have hsurj : Function.Surjective (admFunctional th) := by
    intro y
    refine ⟨fun c => if c = c₀ then y * th c₀ ^ 2 else 0, ?_⟩
    show ∑ c, (if c = c₀ then y * th c₀ ^ 2 else 0) * (th c) ⁻¹ ^ 2 = y
    rw [Finset.sum_eq_single c₀]
    · rw [if_pos rfl]; field_simp [hth c₀]
    · intro b _ hb; simp [hb]
    · intro hb; exact absurd (Finset.mem_univ c₀) hb
  have hrange : LinearMap.range (admFunctional th) = ⊤ := LinearMap.range_eq_top.mpr hsurj
  have hkey := LinearMap.finrank_range_add_finrank_ker (admFunctional th)
  rw [hrange] at hkey
  have h1 : Module.finrank ℝ (⊤ : Submodule ℝ ℝ) = 1 := by
    rw [finrank_top, Module.finrank_self]
  rw [h1] at hkey
  rw [Module.finrank_pi ℝ] at hkey
  omega

/-! ## Lemma L99 itself, on the diagonal locus and against `L_e`

*[Families.lean](../Base/Families.lean) carries the diagonal locus `𝒟ₙ` and
[FoxProduct.lean](../Base/FoxProduct.lean) carries `L_e` with its Rayleigh readings, so the lemma
is nameable. The support graph is carried as a **partition the weight respects**: `SplitsAlong w
part` says `w` vanishes between blocks, and a block carrying a nonzero entry is an edge-carrying
piece. Taking `part` to be the component map makes the two readings agree, and any coarser
adapted partition with two edge-carrying blocks has two edge-carrying components inside them, so
the hypothesis below is the record's.*
-/

section Locus

open HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer

variable [DecidableEq ι]

/-- **`diagOp` is a linear operator on `Λ²`**, the clause `IsWeyl` omits and `IsWeylOp` needs. -/
theorem isLinOp_diagOp (w : Matrix ι ι ℝ) : IsLinOp (diagOp w) := by
  constructor
  · intro X Y; ext a b; simp [diagOp, mul_add]
  · intro c X; ext a b; simp [diagOp]; ring

/-- **The pairing of two diagonal operators is the entrywise one**, `⟨diagOp v, diagOp w⟩ =
½ ∑_{a,b} v_{ab} w_{ab}`. *The `½` is `innerOp`'s ordered-pair doubling, exactly as in
`diagOp_normSq`.* -/
theorem innerOp_diagOp (v w : Matrix ι ι ℝ) (hv : ∀ a b, v a b = v b a)
    (hw : ∀ a b, w a b = w b a) (hh : ∀ a, w a a = 0) :
    innerOp (diagOp v) (diagOp w) = (1/2) * ∑ i : ι, ∑ j : ι, v i j * w i j := by
  unfold innerOp
  congr 1
  refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => ?_
  rw [diagOp_phi v hv, diagOp_phi w hw, FamilyLayer.inner2_smul_left,
    FamilyLayer.inner2_smul_right, inner2_phi_phi]
  by_cases hij : i = j
  · subst hij; rw [hh i]; ring
  · simp [hij, Ne.symm hij]

/-! ### The support partition -/

/-- **The support graph splits along `part`**: `w` vanishes between distinct blocks. *The component
map of the support graph is the finest such partition, and is the record's reading.* -/
def SplitsAlong (w : Matrix ι ι ℝ) (part : ι → C) : Prop := ∀ a b, part a ≠ part b → w a b = 0

/-- **`‖M^{(γ)}‖²` up to the pairing's `½`**: the Frobenius mass of the block `γ` carries. -/
def blockNormSq (w : Matrix ι ι ℝ) (part : ι → C) (γ : C) : ℝ :=
  ∑ a : ι, ∑ b : ι, if part a = γ then (w a b) ^ 2 else 0

/-- **The block `γ` carries an edge.** *`k⁺` of the record is the number of `γ` for which this
holds.* -/
def CarriesEdge (w : Matrix ι ι ℝ) (part : ι → C) (γ : C) : Prop :=
  ∃ a b : ι, part a = γ ∧ w a b ≠ 0

theorem blockNormSq_nonneg (w : Matrix ι ι ℝ) (part : ι → C) (γ : C) :
    0 ≤ blockNormSq w part γ :=
  Finset.sum_nonneg fun a _ => Finset.sum_nonneg fun b _ => by
    by_cases h : part a = γ <;> simp [h, sq_nonneg]

/-- **AN EDGE-CARRYING BLOCK HAS POSITIVE MASS**, which is what makes the direction below
nonzero. -/
theorem blockNormSq_pos {w : Matrix ι ι ℝ} {part : ι → C} {γ : C} (h : CarriesEdge w part γ) :
    0 < blockNormSq w part γ := by
  obtain ⟨a, b, hpa, hab⟩ := h
  refine lt_of_lt_of_le ?_ (Finset.single_le_sum
    (f := fun x : ι => ∑ y : ι, if part x = γ then (w x y) ^ 2 else 0)
    (fun x _ => Finset.sum_nonneg fun y _ => by by_cases h : part x = γ <;> simp [h, sq_nonneg])
    (Finset.mem_univ a))
  refine lt_of_lt_of_le ?_ (Finset.single_le_sum
    (f := fun y : ι => if part a = γ then (w a y) ^ 2 else 0)
    (fun y _ => by by_cases h : part a = γ <;> simp [h, sq_nonneg]) (Finset.mem_univ b))
  simp only [hpa, if_true]
  positivity

/-- **Regrouping a block-constant weighting**, `∑_{x,y} a_{γ(x)} w_{xy}² = ∑_γ a_γ ‖M^{(γ)}‖²`.
*This is the identity the record's `⟨N,M⟩ = ∑_c a_c(θ/θ_c)²‖M^{(c)}‖²` is.* -/
theorem sum_block (w : Matrix ι ι ℝ) (part : ι → C) (a : C → ℝ) :
    ∑ γ : C, a γ * blockNormSq w part γ = ∑ x : ι, ∑ y : ι, a (part x) * w x y ^ 2 := by
  have h1 : ∀ γ : C, a γ * blockNormSq w part γ
      = ∑ x : ι, ∑ y : ι, (if part x = γ then a γ * w x y ^ 2 else 0) := by
    intro γ
    unfold blockNormSq
    rw [Finset.mul_sum]
    refine Finset.sum_congr rfl fun x _ => ?_
    rw [Finset.mul_sum]
    refine Finset.sum_congr rfl fun y _ => ?_
    split_ifs <;> ring
  rw [Finset.sum_congr rfl fun γ _ => h1 γ, Finset.sum_comm]
  refine Finset.sum_congr rfl fun x _ => ?_
  rw [Finset.sum_comm]
  refine Finset.sum_congr rfl fun y _ => ?_
  simp

/-! ### The component-indicator direction -/

/-- **`N_{ab} = a_{c(a)} M_{ab}`**, the record's component-indicator deformation. -/
def indDir (w : Matrix ι ι ℝ) (part : ι → C) (a : C → ℝ) : Matrix ι ι ℝ :=
  Matrix.of fun x y => a (part x) * w x y

/-- **THE DIRECTION STAYS ON THE DIAGONAL LOCUS.** *Symmetry is where `SplitsAlong` is used: off
the blocks `w` already vanishes, and on a block the coefficient is the same at both ends.* -/
theorem indDir_isWeight {w : Matrix ι ι ℝ} {part : ι → C} (hw : IsWeight w)
    (hs : SplitsAlong w part) (a : C → ℝ) : IsWeight (indDir w part a) where
  symm x y := by
    by_cases h : part x = part y
    · simp only [indDir, Matrix.of_apply, h, hw.symm x y]
    · rw [show indDir w part a x y = a (part x) * w x y from rfl,
        show indDir w part a y x = a (part y) * w y x from rfl,
        hs x y h, hs y x (Ne.symm h), mul_zero, mul_zero]
  hollow x := by simp [indDir, hw.hollow x]
  rowSum x := by
    show ∑ y : ι, a (part x) * w x y = 0
    rw [← Finset.mul_sum, hw.rowSum x, mul_zero]

/-- **`⟨N, M⟩` IS THE ADMISSIBILITY FUNCTIONAL**: `⟨N,M⟩ = ½ ∑_γ a_γ ‖M^{(γ)}‖²`. *So the
condition is a sum over the blocks, and a block of zero mass (a singleton component), drops out
whatever its `a_γ`, which is the correction this block records.* -/
theorem innerOp_indDir {w : Matrix ι ι ℝ} {part : ι → C} (hw : IsWeight w)
    (hs : SplitsAlong w part) (a : C → ℝ) :
    innerOp (diagOp (indDir w part a)) (diagOp w)
      = (1/2) * ∑ γ : C, a γ * blockNormSq w part γ := by
  rw [innerOp_diagOp _ _ (indDir_isWeight hw hs a).symm hw.symm hw.hollow, sum_block]
  congr 1
  exact Finset.sum_congr rfl fun x _ => Finset.sum_congr rfl fun y _ => by
    show a (part x) * w x y * w x y = _
    ring

/-- **`‖N‖² = ½ ∑_γ a_γ² ‖M^{(γ)}‖²`.** -/
theorem normSq_indDir {w : Matrix ι ι ℝ} {part : ι → C} (hw : IsWeight w)
    (hs : SplitsAlong w part) (a : C → ℝ) :
    innerOp (diagOp (indDir w part a)) (diagOp (indDir w part a))
      = (1/2) * ∑ γ : C, (a γ) ^ 2 * blockNormSq w part γ := by
  have hN := indDir_isWeight hw hs a
  rw [innerOp_diagOp _ _ hN.symm hN.symm hN.hollow, sum_block]
  congr 1
  exact Finset.sum_congr rfl fun x _ => Finset.sum_congr rfl fun y _ => by
    show a (part x) * w x y * (a (part x) * w x y) = _
    ring

/-- **THE RECORD'S COEFFICIENT VECTOR AT `k⁺ ≥ 2`**, in the mass normalisation:
`a_{γ₁} = ‖M^{(γ₂)}‖²` and `a_{γ₂} = -‖M^{(γ₁)}‖²`, zero elsewhere. *Under the harmonic-square law
`‖M^{(c)}‖² = (θ/θ_c)²`, this is the block's `a_{c₁} = θ_{c₁}²`, `a_{c₂} = -θ_{c₂}²` up to the
common factor `θ²`; it is also ATTEMPTS.md's `H = ‖W₂‖²W₁ - ‖W₁‖²W₂`, which the block names as the
same eigenvector.* -/
def indCoeff (w : Matrix ι ι ℝ) (part : ι → C) (γ₁ γ₂ : C) : C → ℝ :=
  fun γ => if γ = γ₁ then blockNormSq w part γ₂ else
    if γ = γ₂ then -blockNormSq w part γ₁ else 0

/-- **A COEFFICIENT VECTOR SUPPORTED ON TWO BLOCKS** collapses the sum to those two terms. -/
theorem sum_two_blocks {γ₁ γ₂ : C} (hne : γ₁ ≠ γ₂) (B g : C → ℝ) {u v : ℝ}
    (hg1 : g γ₁ = u) (hg2 : g γ₂ = v) (hg0 : ∀ γ, γ ≠ γ₁ → γ ≠ γ₂ → g γ = 0) :
    ∑ γ : C, g γ * B γ = u * B γ₁ + v * B γ₂ := by
  have hpt : ∀ γ : C, g γ * B γ
      = (if γ = γ₁ then u * B γ₁ else 0) + (if γ = γ₂ then v * B γ₂ else 0) := by
    intro γ
    by_cases h1 : γ = γ₁
    · subst h1; simp [hne, hg1]
    · by_cases h2 : γ = γ₂
      · subst h2; simp [h1, hg2]
      · simp [h1, h2, hg0 γ h1 h2]
  rw [Finset.sum_congr rfl fun γ _ => hpt γ, Finset.sum_add_distrib,
    Finset.sum_ite_eq' Finset.univ γ₁, Finset.sum_ite_eq' Finset.univ γ₂]
  simp

theorem indCoeff_at_one (w : Matrix ι ι ℝ) (part : ι → C) (γ₁ γ₂ : C) :
    indCoeff w part γ₁ γ₂ γ₁ = blockNormSq w part γ₂ := by simp [indCoeff]

theorem indCoeff_at_two (w : Matrix ι ι ℝ) (part : ι → C) {γ₁ γ₂ : C} (hne : γ₁ ≠ γ₂) :
    indCoeff w part γ₁ γ₂ γ₂ = -blockNormSq w part γ₁ := by simp [indCoeff, Ne.symm hne]

theorem indCoeff_off (w : Matrix ι ι ℝ) (part : ι → C) {γ₁ γ₂ γ : C} (h1 : γ ≠ γ₁) (h2 : γ ≠ γ₂) :
    indCoeff w part γ₁ γ₂ γ = 0 := by simp [indCoeff, h1, h2]

/-- **THE DIRECTION IS ADMISSIBLE**: `⟨N, M⟩ = 0`. -/
theorem indDir_perp {w : Matrix ι ι ℝ} {part : ι → C} (hw : IsWeight w) (hs : SplitsAlong w part)
    {γ₁ γ₂ : C} (hne : γ₁ ≠ γ₂) :
    innerOp (diagOp (indDir w part (indCoeff w part γ₁ γ₂))) (diagOp w) = 0 := by
  rw [innerOp_indDir hw hs,
    sum_two_blocks hne (blockNormSq w part) (indCoeff w part γ₁ γ₂)
      (indCoeff_at_one w part γ₁ γ₂) (indCoeff_at_two w part hne)
      (fun γ h1 h2 => indCoeff_off w part h1 h2)]
  ring

/-- **AND IT IS NONZERO**, provided both blocks carry an edge, which is the hypothesis `k⁺ ≥ 2`
and the only place it is used. -/
theorem indDir_ne_zero {w : Matrix ι ι ℝ} {part : ι → C} (hw : IsWeight w) (hs : SplitsAlong w part)
    {γ₁ γ₂ : C} (hne : γ₁ ≠ γ₂) (h1 : CarriesEdge w part γ₁) (h2 : CarriesEdge w part γ₂) :
    innerOp (diagOp (indDir w part (indCoeff w part γ₁ γ₂)))
      (diagOp (indDir w part (indCoeff w part γ₁ γ₂))) ≠ 0 := by
  have hb1 := blockNormSq_pos h1
  have hb2 := blockNormSq_pos h2
  rw [normSq_indDir hw hs,
    sum_two_blocks hne (blockNormSq w part) (fun γ => (indCoeff w part γ₁ γ₂ γ) ^ 2)
      (by rw [indCoeff_at_one w part γ₁ γ₂]) (by rw [indCoeff_at_two w part hne])
      (fun γ h1 h2 => by rw [indCoeff_off w part h1 h2]; ring)]
  have hgt : blockNormSq w part γ₂ ^ 2 * blockNormSq w part γ₁
      + (-blockNormSq w part γ₁) ^ 2 * blockNormSq w part γ₂ > 0 := by positivity
  intro h
  nlinarith [hgt]

/-- **THE DIRECTION IS AN ELEMENT OF `𝒲ₙ`**, linear and Weyl, so it is admissible in the record's
sense and not merely in norm. -/
theorem indDir_isWeylOp {w : Matrix ι ι ℝ} {part : ι → C} (hw : IsWeight w)
    (hs : SplitsAlong w part) (a : C → ℝ) : IsWeylOp (diagOp (indDir w part a)) :=
  ⟨isLinOp_diagOp _, diagOp_isWeyl (indDir_isWeight hw hs a)⟩

/-! ### The lemma

*The Rayleigh value at the direction is the one thing owed, and it is the record's `𝓛N = θN`.*
-/

/-! ### `Q` and `∘` on the diagonal locus -/

theorem Qop_diag (u : Matrix ι ι ℝ) (hu : ∀ p q, u p q = u q p) (hh : ∀ a, u a a = 0) (a b : ι) :
    Qop (diagOp u) (phi a b) = (u a b * u a b + (u * u) a b) • phi a b := by
  have hR := diagOp_phi u hu a b
  show compOp (diagOp u) (phi a b) + sharpOp (diagOp u) (phi a b) = _
  unfold compOp
  rw [hR, diagOp_smul_arg, hR, sharpOp_diagOp u hu hh, smul_smul, ← add_smul]

theorem foxProd_diag (u v : Matrix ι ι ℝ) (hu : ∀ p q, u p q = u q p) (hv : ∀ p q, v p q = v q p)
    (hhu : ∀ a, u a a = 0) (hhv : ∀ a, v a a = 0) (a b : ι) :
    foxProd (diagOp u) (diagOp v) (phi a b)
      = (u a b * v a b + (1 / 2) * ((u * v) a b + (v * u) a b)) • phi a b := by
  unfold foxProd
  have hadd : diagOp u + diagOp v = diagOp (u + v) := by
    funext X; ext i j; simp [diagOp, add_mul]
  rw [hadd, Qop_diag (u + v) (fun p q => by simp [hu p q, hv p q]) (fun a => by simp [hhu a, hhv a]),
    Qop_diag u hu hhu, Qop_diag v hv hhv, ← sub_smul, ← sub_smul, smul_smul]
  congr 1
  simp only [Matrix.add_apply, Matrix.add_mul, Matrix.mul_add]
  ring

theorem i2_smul_l (c : ℝ) (X Y : Matrix ι ι ℝ) : inner2 (c • X) Y = c * inner2 X Y := by
  simp [inner2, Matrix.trace_smul]; ring
theorem i2_smul_r (c : ℝ) (X Y : Matrix ι ι ℝ) : inner2 X (c • Y) = c * inner2 X Y := by
  simp [inner2, Matrix.trace_smul]; ring

/-- **`L_e N = N` at EVERY component-indicator direction**, the coefficient vector free. -/
theorem indicator {w : Matrix ι ι ℝ} {part : ι → C} {θ : ℝ} (hw : IsWeight w)
    (hs : SplitsAlong w part) (hcrit : IsCritical (diagOp w) θ) (hθ : θ ≠ 0) (c : C → ℝ) :
    foxTri (idemOf (diagOp w) θ) (diagOp (indDir w part c)) (diagOp (indDir w part c))
      = innerOp (diagOp (indDir w part c)) (diagOp (indDir w part c)) := by
  obtain ⟨-, -, hrow⟩ := HamiltonsCubic.L97Statement.diagCriticalRow hw hcrit
  have hvW := indDir_isWeight hw hs c
  set v := indDir w part c with hvdef
  have hid : idemOf (diagOp w) θ = diagOp (θ⁻¹ • w) := by
    funext X; ext i j; simp [idemOf, diagOp, mul_assoc]
  rw [hid]
  unfold foxTri innerOp
  congr 1
  refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => ?_
  have hu : ∀ p q, (θ⁻¹ • w) p q = (θ⁻¹ • w) q p := fun p q => by simp [hw.symm p q]
  have hhu : ∀ a, (θ⁻¹ • w) a a = 0 := fun a => by simp [hw.hollow a]
  rw [foxProd_diag _ _ hu hvW.symm hhu hvW.hollow, diagOp_phi v hvW.symm i j]
  simp only [i2_smul_l, i2_smul_r]
  by_cases hij : i = j
  · subst hij; simp [phi_self, inner2]
  -- the block structure: `w i x ≠ 0` forces `part x = part i`
  have hblk : ∀ x, w i x * c (part x) = w i x * c (part i) := fun x => by
    by_cases hp : part i = part x
    · rw [hp]
    · rw [hs i x hp, zero_mul, zero_mul]
  have hv : ∀ x y, v x y = c (part x) * w x y := fun x y => rfl
  have huv : ((θ⁻¹ • w) * v) i j = θ⁻¹ * c (part i) * (w * w) i j := by
    simp only [Matrix.mul_apply, Matrix.smul_apply, smul_eq_mul, hv, Finset.mul_sum]
    exact Finset.sum_congr rfl fun x _ => by
      have := hblk x; linear_combination θ⁻¹ * w x j * this
  have hvu : (v * (θ⁻¹ • w)) i j = θ⁻¹ * c (part i) * (w * w) i j := by
    simp only [Matrix.mul_apply, Matrix.smul_apply, smul_eq_mul, hv, Finset.mul_sum]
    exact Finset.sum_congr rfl fun x _ => by ring
  have hcoef : (θ⁻¹ • w) i j * v i j + 1 / 2 * (((θ⁻¹ • w) * v) i j + (v * (θ⁻¹ • w)) i j) = v i j := by
    rw [huv, hvu, hv]
    have hr := hrow i j hij
    simp only [Matrix.smul_apply, smul_eq_mul]
    field_simp
    simp only [Matrix.mul_apply] at hr ⊢
    linear_combination (2 * c (part i)) * hr
  rw [hcoef]

/-- **`L_e N = N` AT THE COMPONENT-INDICATOR DIRECTION**, the record's *"a non-radial admissible
`N` with `𝓛N = θN` exactly"*, in the `e = W/θ` normalisation where the eigenvalue is `1`.

**PROVED (2026-09-24), at EVERY coefficient vector** (`indicator`): `∘` at two diagonal operators
acts on `φ_ab` by `u_ab v_ab + ½(uv + vu)_ab` (`foxProd_diag`), the block structure makes both products
`θ⁻¹c_a(w²)_ab`, and L97's criticality row `w_ab² + (w²)_ab = θw_ab` makes the coefficient `v_ab`.
What it needed was `X ∘ Y` evaluated at two diagonal
operators, i.e. the polarisation of `Qop` on the diagonal locus, which is
[Families.lean](../Base/Families.lean)'s `DiagCubicFormula`, PROVED in [SharpDiag.lean](../Base/SharpDiag.lean), one derivative down, together
with the bilinearity of `∘` that [FoxProduct.lean](../Base/FoxProduct.lean) records as owed in
`foxProd_split`. Everything else the lemma needs, that `N` is in `𝒲ₙ`, that `N ⊥ M`, that
`N ≠ 0`, is proved above. -/
theorem indicator_eigen {w : Matrix ι ι ℝ} {part : ι → C} {θ : ℝ} (hw : IsWeight w)
    (hs : SplitsAlong w part) (hcrit : IsCritical (diagOp w) θ) (hθ : 0 < θ) {γ₁ γ₂ : C}
    (hne : γ₁ ≠ γ₂) (h1 : CarriesEdge w part γ₁) (h2 : CarriesEdge w part γ₂) :
    foxTri (idemOf (diagOp w) θ) (diagOp (indDir w part (indCoeff w part γ₁ γ₂)))
        (diagOp (indDir w part (indCoeff w part γ₁ γ₂)))
      = innerOp (diagOp (indDir w part (indCoeff w part γ₁ γ₂)))
          (diagOp (indDir w part (indCoeff w part γ₁ γ₂))) :=
  indicator hw hs hcrit hθ.ne' _

/-- **LEMMA L99.** *Let `M` be a diagonal critical point with `θ > 0` whose support graph has at
least two blocks carrying an edge. Then `λ_max(L_e|_{W^⊥}) ≥ 1`.* -/
theorem L99 {w : Matrix ι ι ℝ} {part : ι → C} {θ : ℝ} (hw : IsWeight w) (hs : SplitsAlong w part)
    (hcrit : IsCritical (diagOp w) θ) (hθ : 0 < θ) {γ₁ γ₂ : C} (hne : γ₁ ≠ γ₂)
    (h1 : CarriesEdge w part γ₁) (h2 : CarriesEdge w part γ₂) :
    RayleighGE (diagOp w) θ 1 :=
  ⟨diagOp (indDir w part (indCoeff w part γ₁ γ₂)), indDir_isWeylOp hw hs _,
    indDir_ne_zero hw hs hne h1 h2, indDir_perp hw hs hne, by
      rw [one_mul, indicator_eigen hw hs hcrit hθ hne h1 h2]⟩

/-- **…SO `W` IS NOT A MAXIMISER**, which is the lemma's conclusion: [Lemma L24](../../../results.md)
bounds `λ_max(L_e|_{W^⊥})` by `½` at a maximiser, and `1 > ½`. -/
theorem not_maximiser {w : Matrix ι ι ℝ} {part : ι → C} {θ : ℝ} (hw : IsWeight w)
    (hs : SplitsAlong w part) (hcrit : IsCritical (diagOp w) θ) (hθ : 0 < θ) {γ₁ γ₂ : C}
    (hne : γ₁ ≠ γ₂) (h1 : CarriesEdge w part γ₁) (h2 : CarriesEdge w part γ₂) :
    ¬ RayleighLE (diagOp w) θ (1 / 2) := by
  intro hle
  have := (L99 hw hs hcrit hθ hne h1 h2).le_of_RayleighLE hle
  linarith

/-- **A SINGLE EDGE-CARRYING BLOCK COLLAPSES THE SUM** to its one term. -/
theorem sum_single_block {w : Matrix ι ι ℝ} {part : ι → C} {γ₁ : C}
    (hone : ∀ γ, γ ≠ γ₁ → blockNormSq w part γ = 0) (g : C → ℝ) :
    ∑ γ : C, g γ * blockNormSq w part γ = g γ₁ * blockNormSq w part γ₁ :=
  Finset.sum_eq_single γ₁ (fun b _ hb => by rw [hone b hb, mul_zero])
    (fun h => absurd (Finset.mem_univ γ₁) h)

/-- **AT `k⁺ = 1` THE FAMILY CERTIFIES NOTHING.** With one edge-carrying block, every admissible
coefficient vector produces a direction of zero norm, so there is no `RayleighGE` witness to be
had from it. *This is the sharpness the record claims for the hypothesis, in the shape the
construction takes here: at `k⁺ = 1` admissibility forces `a_{γ₁}‖M^{(γ₁)}‖² = 0` and the mass of
every other block is already zero.* -/
theorem k_plus_one_certifies_nothing {w : Matrix ι ι ℝ} {part : ι → C} (hw : IsWeight w)
    (hs : SplitsAlong w part) (a : C → ℝ) {γ₁ : C}
    (hone : ∀ γ, γ ≠ γ₁ → blockNormSq w part γ = 0)
    (hadm : innerOp (diagOp (indDir w part a)) (diagOp w) = 0) :
    innerOp (diagOp (indDir w part a)) (diagOp (indDir w part a)) = 0 := by
  rw [innerOp_indDir hw hs, sum_single_block hone] at hadm
  rw [normSq_indDir hw hs, sum_single_block hone (fun γ => (a γ) ^ 2)]
  have h : a γ₁ * blockNormSq w part γ₁ = 0 := by linarith
  rcases mul_eq_zero.mp h with h1 | h1 <;> rw [h1] <;> ring

end Locus

end HamiltonsCubic.L99Statement
