import Mathlib

set_option linter.style.longLine false

/-!
# L75, maximal isotropy, characterised three ways, STATED

[isotropy-cap.md](../../../findings/isotropy-cap.md)'s Lemma L75, *"maximal isotropy,
characterised three ways (the third needs isotropy as a hypothesis"*), in the form the audit
repaired it to:

> **THE CHAIN IS NOT A CHAIN OF EQUIVALENCES, IT BREAKS AT THE SECOND LINK.**
> `[𝔪,𝔪]^⊥ = 𝔪` **entails isotropy unaided**, since `𝔪 ⊆ [𝔪,𝔪]^⊥` *is* isotropy restated; so the
> block's choice of the equality form over an inclusion is right, and unexplained. **But
> `rank[𝔪,𝔪] = N - dim 𝔪` says only `dim[𝔪,𝔪]^⊥ = dim 𝔪`**, it fixes a dimension and leaves the
> subspace free. *The repair is asymmetric: only the rank form needs "for isotropic `𝔪`".*
>
> **WITNESS, BY HAND, IN FOUR DIMENSIONS.** `𝔰𝔬(3) ⊂ 𝔰𝔬(4)`: `[φ₁₂,φ₁₃] = -φ₂₃`, so
> `[𝔪,𝔪] = 𝔪` and the rank count holds **exactly**, `3 = 6 - 3`, while
> `⟨[φ₁₂,φ₁₃],φ₂₃⟩ = -1`, so `𝔪` is not isotropic. **The dimension-versus-subspace failure in its
> purest form.**

So the repaired statement is: for `𝔪 ⊆ 𝔰𝔬(n)`, the following are equivalent, **(i)** `𝔪` is a
maximal isotropic subspace, **(ii)** `[𝔪,𝔪]^⊥ = 𝔪`, and **(iii)** `𝔪` is isotropic **and**
`rank[𝔪,𝔪] = N - dim 𝔪`, with `N = C(n,2)`.

## What IS typed here

**The full three-way equivalence**, as `L75`, PROVED: stage A (`maxIso_iff_perp`) needs no
dimensions, stage B reads the rank form off `finrank_perp` and `finrank_soN`.

**The asymmetry of the repair, proved.** `bracketPerp_implies_isotropic` is the record's
*"entails isotropy unaided"*: form (ii) needs no isotropy hypothesis, which is why only form
(iii) carries one.

**The four-dimensional witness, proved.** `witness_bracket` computes `[φ₀₁, φ₀₂] = -φ₁₂` and
`witness_not_isotropic` reads `⟨[φ₀₁,φ₀₂], φ₁₂⟩ = -1 ≠ 0`, so `𝔰𝔬(3) ⊂ 𝔰𝔬(4)` fails isotropy
while, `[𝔪,𝔪]` being `𝔪` itself, the rank count `3 = 6 - 3` holds. *Indices are `0`-based here
against the record's `1`-based `φ₁₂, φ₁₃, φ₂₃`; the matrices are the same three.*

## How it is proved

Maximality forces `[𝔪,𝔪]^⊥ ⊆ 𝔪` because the trilinear form `⟨[x,y],z⟩` is cyclically invariant
on `𝔰𝔬(n)`: adjoining any `A ⊥ [𝔪,𝔪]` to `𝔪` leaves every pairing zero. The rank identity is the
same fact read off dimensions, `dim [𝔪,𝔪]^⊥ = C(n,2) - dim [𝔪,𝔪]` inside `𝔰𝔬(n)`.

## What is NOT typed here

**The rank count of the witness.** That `[𝔪,𝔪] = 𝔪` for `𝔪 = 𝔰𝔬(3) ⊂ 𝔰𝔬(4)`, hence
`rank[𝔪,𝔪] = 3 = 6 - 3`, is a span computation and is absent; only the isotropy failure, which
is the half the witness exists to exhibit, is proved.

**`N - dim 𝔪` is written as an addition.** Form (iii) is stated as
`rank[𝔪,𝔪] + dim 𝔪 = C(n,2)` so that no `ℕ`-truncation can enter; the two read the same because
`dim 𝔪 ≤ N` always, but the subtraction form would be the record's meaning only under that side
condition.

**The dimension bracket `[n-1, ⌊n²/4⌋`].** The free corollary [L76](../../../findings/isotropy-cap.md)
supplies (`d ≥ n-1` for every maximal isotropic, equivalently `d(d+1) ≥ n(n-1)`), is carried by
[IsotropyCap.lean](IsotropyCap.lean) and is not repeated.
-/

namespace HamiltonsCubic.L75Statement

open Matrix Module

variable {n : ℕ}

/-- The `Λ²` inner product `⟨X, Y⟩ = ½ tr(Xᵀ Y)`. -/
noncomputable def inner2 (X Y : Matrix (Fin n) (Fin n) ℝ) : ℝ := (1 / 2) * (Xᵀ * Y).trace

/-- The bracket on `𝔰𝔬(n)`. -/
def br (X Y : Matrix (Fin n) (Fin n) ℝ) : Matrix (Fin n) (Fin n) ℝ := X * Y - Y * X

/-- Membership in `𝔰𝔬(n)`. -/
def Skew (X : Matrix (Fin n) (Fin n) ℝ) : Prop := Xᵀ = -X

theorem inner2_comm (X Y : Matrix (Fin n) (Fin n) ℝ) : inner2 X Y = inner2 Y X := by
  unfold inner2
  rw [← Matrix.trace_transpose (Xᵀ * Y), Matrix.transpose_mul, Matrix.transpose_transpose]

/-- `[𝔪,𝔪]`. -/
def brackets (m : Submodule ℝ (Matrix (Fin n) (Fin n) ℝ)) :
    Submodule ℝ (Matrix (Fin n) (Fin n) ℝ) :=
  Submodule.span ℝ {A | ∃ u ∈ m, ∃ v ∈ m, A = br u v}

/-- **Isotropic**: the Cartan three-form vanishes on `𝔪`. -/
def Isotropic (m : Submodule ℝ (Matrix (Fin n) (Fin n) ℝ)) : Prop :=
  ∀ u ∈ m, ∀ v ∈ m, ∀ w ∈ m, inner2 (br u v) w = 0

/-- `𝔪 ⊆ 𝔰𝔬(n)`. -/
def SkewSub (m : Submodule ℝ (Matrix (Fin n) (Fin n) ℝ)) : Prop := ∀ A ∈ m, Skew A

/-- **Form (i)**: `𝔪` is isotropic and no isotropic subspace of `𝔰𝔬(n)` properly contains it. -/
def MaximalIsotropic (m : Submodule ℝ (Matrix (Fin n) (Fin n) ℝ)) : Prop :=
  Isotropic m ∧
    ∀ m' : Submodule ℝ (Matrix (Fin n) (Fin n) ℝ), SkewSub m' → Isotropic m' → m ≤ m' → m' = m

/-- **Form (ii)**: `[𝔪,𝔪]^⊥ = 𝔪`, written pointwise inside `𝔰𝔬(n)`. -/
def BracketPerpEqSelf (m : Submodule ℝ (Matrix (Fin n) (Fin n) ℝ)) : Prop :=
  ∀ A : Matrix (Fin n) (Fin n) ℝ, Skew A →
    ((∀ u ∈ m, ∀ v ∈ m, inner2 A (br u v) = 0) ↔ A ∈ m)

/-- **Form (iii)**: `𝔪` isotropic with `rank[𝔪,𝔪] = N - dim 𝔪`, `N = C(n,2)`, stated as an
addition so no `ℕ`-truncation enters. -/
def RankForm (m : Submodule ℝ (Matrix (Fin n) (Fin n) ℝ)) : Prop :=
  Isotropic m ∧ finrank ℝ (brackets m) + finrank ℝ m = Nat.choose n 2

/-! ## The asymmetry of the repair, proved

Form (ii) carries isotropy inside it; form (iii) does not, which is why only (iii) needs it
written in. -/

/-- **`[𝔪,𝔪]^⊥ = 𝔪` entails isotropy unaided**, since `𝔪 ⊆ [𝔪,𝔪]^⊥` *is* isotropy restated. -/
theorem bracketPerp_implies_isotropic (m : Submodule ℝ (Matrix (Fin n) (Fin n) ℝ))
    (hskew : SkewSub m) (h : BracketPerpEqSelf m) : Isotropic m := by
  intro u hu v hv w hw
  have := (h w (hskew w hw)).mpr hw u hu v hv
  rw [inner2_comm] at this
  exact this

/-! ## The four-dimensional witness

`𝔪 = 𝔰𝔬(3) ⊂ 𝔰𝔬(4)` satisfies the rank count and is not isotropic. -/

/-- `φ₀₁ = E₀₁ - E₁₀`. -/
def phi01 : Matrix (Fin 4) (Fin 4) ℝ := !![0,1,0,0; -1,0,0,0; 0,0,0,0; 0,0,0,0]

/-- `φ₀₂ = E₀₂ - E₂₀`. -/
def phi02 : Matrix (Fin 4) (Fin 4) ℝ := !![0,0,1,0; 0,0,0,0; -1,0,0,0; 0,0,0,0]

/-- `φ₁₂ = E₁₂ - E₂₁`. -/
def phi12 : Matrix (Fin 4) (Fin 4) ℝ := !![0,0,0,0; 0,0,1,0; 0,-1,0,0; 0,0,0,0]

/-- **`[φ₀₁, φ₀₂] = -φ₁₂`**, so `[𝔪,𝔪] = 𝔪` and the rank count `3 = 6 - 3` holds. -/
theorem witness_bracket : br phi01 phi02 = -phi12 := by
  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [br, phi01, phi02, phi12, Matrix.mul_apply, Fin.sum_univ_four]

/-- **And `⟨[φ₀₁,φ₀₂], φ₁₂⟩ = -1`**, so `𝔪` is not isotropic, the dimension-versus-subspace
failure the audit calls *"in its purest form"*. -/
theorem witness_not_isotropic : inner2 (br phi01 phi02) phi12 = -1 := by
  rw [witness_bracket]
  simp [inner2, phi12, Matrix.trace, Matrix.mul_apply, Fin.sum_univ_four]
  norm_num

/-- Stated as the record states it: the rank form without isotropy has a counterexample. -/
theorem rank_form_needs_isotropy :
    ¬ (∀ u ∈ Submodule.span ℝ ({phi01, phi02, phi12} : Set (Matrix (Fin 4) (Fin 4) ℝ)),
        ∀ v ∈ Submodule.span ℝ ({phi01, phi02, phi12} : Set (Matrix (Fin 4) (Fin 4) ℝ)),
        ∀ w ∈ Submodule.span ℝ ({phi01, phi02, phi12} : Set (Matrix (Fin 4) (Fin 4) ℝ)),
        inner2 (br u v) w = 0) := by
  intro H
  have h1 : phi01 ∈ Submodule.span ℝ ({phi01, phi02, phi12} : Set (Matrix (Fin 4) (Fin 4) ℝ)) :=
    Submodule.subset_span (by simp)
  have h2 : phi02 ∈ Submodule.span ℝ ({phi01, phi02, phi12} : Set (Matrix (Fin 4) (Fin 4) ℝ)) :=
    Submodule.subset_span (by simp)
  have h3 : phi12 ∈ Submodule.span ℝ ({phi01, phi02, phi12} : Set (Matrix (Fin 4) (Fin 4) ℝ)) :=
    Submodule.subset_span (by simp)
  have := H phi01 h1 phi02 h2 phi12 h3
  rw [witness_not_isotropic] at this
  norm_num at this

/-! ## The proof's machinery

**Stage A**, maximal isotropy is `[𝔪,𝔪]^⊥ = 𝔪`: `⟨[x,y],z⟩` is cyclically invariant on skew
matrices (`cyc`), so adjoining any `A ⊥ [𝔪,𝔪]` keeps `𝔪` isotropic and maximality puts `A` in `𝔪`.
**Stage B**, the rank form: `dim 𝔰𝔬(n) = C(n,2)` (`finrank_soN`, through the strictly upper
triangular entries) and `dim (V ∩ S^⊥) + dim S = dim V` for `S ≤ V` (`finrank_perp`, rank-nullity
for `A ↦ ⟨A,·⟩`, onto because `inner2` is positive definite). -/

namespace Proof

theorem br_add_l (x y z : Matrix (Fin n) (Fin n) ℝ) : br (x + y) z = br x z + br y z := by
  unfold br; rw [Matrix.add_mul, Matrix.mul_add]; abel
theorem br_add_r (x y z : Matrix (Fin n) (Fin n) ℝ) : br x (y + z) = br x y + br x z := by
  unfold br; rw [Matrix.add_mul, Matrix.mul_add]; abel
theorem br_smul_l (c : ℝ) (x y : Matrix (Fin n) (Fin n) ℝ) : br (c • x) y = c • br x y := by
  unfold br; rw [Matrix.smul_mul, Matrix.mul_smul, smul_sub]
theorem br_smul_r (c : ℝ) (x y : Matrix (Fin n) (Fin n) ℝ) : br x (c • y) = c • br x y := by
  unfold br; rw [Matrix.smul_mul, Matrix.mul_smul, smul_sub]
theorem br_self (x : Matrix (Fin n) (Fin n) ℝ) : br x x = 0 := by unfold br; exact sub_self _
theorem inner2_add_l (x y z : Matrix (Fin n) (Fin n) ℝ) : inner2 (x + y) z = inner2 x z + inner2 y z := by
  unfold inner2; rw [Matrix.transpose_add, Matrix.add_mul, Matrix.trace_add]; ring
theorem inner2_add_r (x y z : Matrix (Fin n) (Fin n) ℝ) : inner2 x (y + z) = inner2 x y + inner2 x z := by
  unfold inner2; rw [Matrix.mul_add, Matrix.trace_add]; ring
theorem inner2_smul_l (c : ℝ) (x y : Matrix (Fin n) (Fin n) ℝ) : inner2 (c • x) y = c * inner2 x y := by
  unfold inner2; rw [Matrix.transpose_smul, Matrix.smul_mul, Matrix.trace_smul, smul_eq_mul]; ring
theorem inner2_smul_r (c : ℝ) (x y : Matrix (Fin n) (Fin n) ℝ) : inner2 x (c • y) = c * inner2 x y := by
  unfold inner2; rw [Matrix.mul_smul, Matrix.trace_smul, smul_eq_mul]; ring
theorem inner2_zero_l (y : Matrix (Fin n) (Fin n) ℝ) : inner2 0 y = 0 := by simp [inner2]

/-- **Cyclic invariance** of `⟨[x,y],z⟩` on skew matrices. -/
theorem cyc {x y z : Matrix (Fin n) (Fin n) ℝ} (hx : Skew x) (hy : Skew y) (hz : Skew z) :
    inner2 (br x y) z = inner2 (br y z) x := by
  unfold inner2 br Skew at *
  rw [Matrix.transpose_sub, Matrix.transpose_mul, Matrix.transpose_mul, hx, hy,
    Matrix.transpose_sub, Matrix.transpose_mul, Matrix.transpose_mul, hy, hz]
  simp only [Matrix.neg_mul, Matrix.mul_neg, neg_neg, Matrix.sub_mul, Matrix.trace_sub]
  rw [Matrix.trace_mul_cycle y x z, Matrix.trace_mul_cycle y z x]

theorem skew_add {x y : Matrix (Fin n) (Fin n) ℝ} (hx : Skew x) (hy : Skew y) : Skew (x + y) := by
  unfold Skew at *; rw [Matrix.transpose_add, hx, hy, neg_add]
theorem skew_smul (c : ℝ) {x : Matrix (Fin n) (Fin n) ℝ} (hx : Skew x) : Skew (c • x) := by
  unfold Skew at *; rw [Matrix.transpose_smul, hx, smul_neg]

theorem maxIso_iff_perp (m : Submodule ℝ (Matrix (Fin n) (Fin n) ℝ)) (hskew : SkewSub m) :
    MaximalIsotropic m ↔ BracketPerpEqSelf m := by
  constructor
  · rintro ⟨hiso, hmax⟩ A hA
    constructor
    · intro hperp
      let m' := m ⊔ Submodule.span ℝ {A}
      have hdecomp : ∀ x ∈ m', ∃ y ∈ m, ∃ c : ℝ, x = y + c • A := by
        intro x hx
        obtain ⟨y, hy, z, hz, rfl⟩ := Submodule.mem_sup.mp hx
        obtain ⟨c, rfl⟩ := Submodule.mem_span_singleton.mp hz
        exact ⟨y, hy, c, rfl⟩
      have hsk' : SkewSub m' := by
        intro x hx
        obtain ⟨y, hy, c, rfl⟩ := hdecomp x hx
        exact skew_add (hskew y hy) (skew_smul c hA)
      have hperp' : ∀ u ∈ m, ∀ v ∈ m, inner2 (br u v) A = 0 := fun u hu v hv => by
        rw [inner2_comm]; exact hperp u hu v hv
      have hiso' : Isotropic m' := by
        intro x hx y hy z hz
        obtain ⟨y1, h1, a, rfl⟩ := hdecomp x hx
        obtain ⟨y2, h2, b, rfl⟩ := hdecomp y hy
        obtain ⟨y3, h3, c, rfl⟩ := hdecomp z hz
        have s1 := hskew y1 h1; have s2 := hskew y2 h2; have s3 := hskew y3 h3
        have e1 : inner2 (br y1 A) y3 = 0 := by
          rw [cyc s1 hA s3, cyc hA s3 s1]; exact hperp' y3 h3 y1 h1
        have e2 : inner2 (br A y2) y3 = 0 := by rw [cyc hA s2 s3]; exact hperp' y2 h2 y3 h3
        have e4 : inner2 (br A y2) A = 0 := by rw [cyc hA s2 hA, cyc s2 hA hA, br_self, inner2_zero_l]
        have e5 : inner2 (br y1 A) A = 0 := by rw [cyc s1 hA hA, br_self, inner2_zero_l]
        simp only [br_add_l, br_add_r, br_smul_l, br_smul_r, br_self, smul_zero, add_zero,
          inner2_add_l, inner2_add_r, inner2_smul_l, inner2_smul_r, hiso y1 h1 y2 h2 y3 h3,
          hperp' y1 h1 y2 h2, e1, e2, e4, e5]
        ring
      have := hmax m' hsk' hiso' le_sup_left
      rw [← this]
      exact Submodule.mem_sup_right (Submodule.mem_span_singleton_self A)
    · intro hAm u hu v hv
      rw [inner2_comm]; exact hiso u hu v hv A hAm
  · intro h
    refine ⟨bracketPerp_implies_isotropic m hskew h, fun m' hsk' hiso' hle => ?_⟩
    refine le_antisymm (fun x hx => ?_) hle
    refine (h x (hsk' x hx)).mp fun u hu v hv => ?_
    rw [inner2_comm]; exact hiso' u (hle hu) v (hle hv) x hx


/-! ## Stage B: the dimension count -/

theorem skew_br {u v : Matrix (Fin n) (Fin n) ℝ} (hu : Skew u) (hv : Skew v) : Skew (br u v) := by
  unfold Skew br at *
  rw [Matrix.transpose_sub, Matrix.transpose_mul, Matrix.transpose_mul, hu, hv]
  simp only [Matrix.neg_mul, Matrix.mul_neg, neg_neg, neg_sub]

/-- `𝔰𝔬(n)` as a submodule. -/
def soN (n : ℕ) : Submodule ℝ (Matrix (Fin n) (Fin n) ℝ) where
  carrier := {A | Skew A}
  add_mem' := fun ha hb => skew_add ha hb
  zero_mem' := by show Skew (0 : Matrix (Fin n) (Fin n) ℝ); unfold Skew; simp
  smul_mem' := fun c _ ha => skew_smul c ha

/-- The orthogonal of `S` under `inner2`. -/
def orthS (S : Submodule ℝ (Matrix (Fin n) (Fin n) ℝ)) : Submodule ℝ (Matrix (Fin n) (Fin n) ℝ) where
  carrier := {A | ∀ s ∈ S, inner2 A s = 0}
  add_mem' := fun ha hb s hs => by rw [inner2_add_l, ha s hs, hb s hs, add_zero]
  zero_mem' := fun s _ => inner2_zero_l s
  smul_mem' := fun c _ ha s hs => by rw [inner2_smul_l, ha s hs, mul_zero]

theorem inner2_self_eq_zero {X : Matrix (Fin n) (Fin n) ℝ} (h : inner2 X X = 0) : X = 0 := by
  unfold inner2 at h
  simp only [Matrix.trace, Matrix.diag, Matrix.mul_apply, Matrix.transpose_apply] at h
  have h' : ∑ i, ∑ j, X j i * X j i = 0 := by linarith
  ext a b
  have h1 := (Finset.sum_eq_zero_iff_of_nonneg (fun i _ => Finset.sum_nonneg fun j _ =>
    mul_self_nonneg (X j i))).mp h' b (Finset.mem_univ b)
  have h2 := (Finset.sum_eq_zero_iff_of_nonneg (fun j _ => mul_self_nonneg (X j b))).mp h1 a
    (Finset.mem_univ a)
  simpa using mul_self_eq_zero.mp h2

/-- **The orthogonal complement has complementary dimension** inside any `V ⊇ S`. -/
theorem finrank_perp (V S : Submodule ℝ (Matrix (Fin n) (Fin n) ℝ)) (hSV : S ≤ V) :
    finrank ℝ (V ⊓ orthS S : Submodule ℝ _) + finrank ℝ S = finrank ℝ V := by
  let g : V →ₗ[ℝ] Module.Dual ℝ S :=
    { toFun := fun A =>
        { toFun := fun s => inner2 A.1 s.1
          map_add' := fun s t => by simp only [Submodule.coe_add, inner2_add_r]
          map_smul' := fun c s => by simp only [Submodule.coe_smul, inner2_smul_r, smul_eq_mul,
            RingHom.id_apply] }
      map_add' := fun A B => by ext s; simp only [Submodule.coe_add, inner2_add_l, LinearMap.coe_mk,
        AddHom.coe_mk, LinearMap.add_apply]
      map_smul' := fun c A => by ext s; simp only [Submodule.coe_smul, inner2_smul_l,
        LinearMap.coe_mk, AddHom.coe_mk, LinearMap.smul_apply, smul_eq_mul, RingHom.id_apply] }
  let h : S →ₗ[ℝ] Module.Dual ℝ S := g ∘ₗ Submodule.inclusion hSV
  have hinj : Function.Injective h := by
    rw [← LinearMap.ker_eq_bot, LinearMap.ker_eq_bot']
    intro s hs
    have := LinearMap.congr_fun hs s
    have h0 : inner2 s.1 s.1 = 0 := this
    exact Subtype.ext (inner2_self_eq_zero h0)
  have hsurj : Function.Surjective h :=
    (LinearMap.injective_iff_surjective_of_finrank_eq_finrank Subspace.dual_finrank_eq.symm).mp hinj
  have hrange : LinearMap.range g = ⊤ := by
    rw [LinearMap.range_eq_top]
    intro φ
    obtain ⟨s, hs⟩ := hsurj φ
    exact ⟨Submodule.inclusion hSV s, hs⟩
  have hker : LinearMap.ker g = (V ⊓ orthS S).comap V.subtype := by
    ext A
    simp only [LinearMap.mem_ker, Submodule.mem_comap, Submodule.subtype_apply, Submodule.mem_inf,
      A.2, true_and]
    constructor
    · intro hA s hs
      exact LinearMap.congr_fun hA ⟨s, hs⟩
    · intro hA; ext s; exact hA s.1 s.2
  have := LinearMap.finrank_range_add_finrank_ker g
  rw [hrange, finrank_top, Subspace.dual_finrank_eq, hker,
    (Submodule.comapSubtypeEquivOfLe (inf_le_left : V ⊓ orthS S ≤ V)).finrank_eq] at this
  omega

/-- The strictly upper triangular index pairs. -/
abbrev Tri (n : ℕ) := {p : Fin n × Fin n // p.1 < p.2}

theorem card_tri : Fintype.card (Tri n) = n.choose 2 := by
  rw [Fintype.card_subtype, Nat.choose_two_right, ← Finset.sum_range_id]
  rw [Finset.card_filter, ← Finset.univ_product_univ, Finset.sum_product, Finset.sum_comm]
  rw [← Fin.sum_univ_eq_sum_range (fun j => j) n]
  refine Finset.sum_congr rfl fun j _ => ?_
  rw [← Finset.card_filter, Finset.filter_gt_eq_Iio, Fin.card_Iio]

theorem finrank_soN : finrank ℝ (soN n) = n.choose 2 := by
  let f : soN n →ₗ[ℝ] (Tri n → ℝ) :=
    { toFun := fun A p => A.1 p.1.1 p.1.2
      map_add' := fun A B => rfl
      map_smul' := fun c A => rfl }
  have hinj : Function.Injective f := by
    rw [← LinearMap.ker_eq_bot, LinearMap.ker_eq_bot']
    intro A hA
    have hz : ∀ p : Tri n, A.1 p.1.1 p.1.2 = 0 := fun p => congrFun hA p
    have hsk : ∀ i j, A.1 j i = -A.1 i j := fun i j => by
      have := congrFun (congrFun A.2 i) j; simpa [Matrix.transpose_apply] using this
    apply Subtype.ext
    ext i j
    rcases lt_trichotomy i j with h | h | h
    · exact hz ⟨(i, j), h⟩
    · subst h; have := hsk i i; show A.1 i i = 0; linarith
    · rw [hsk j i, hz ⟨(j, i), h⟩]; simp
  have hsurj : Function.Surjective f := by
    intro c
    refine ⟨⟨∑ p : Tri n, c p • (Matrix.single p.1.1 p.1.2 1 - Matrix.single p.1.2 p.1.1 1), ?_⟩, ?_⟩
    · show Skew _
      unfold Skew
      rw [Matrix.transpose_sum, ← Finset.sum_neg_distrib]
      refine Finset.sum_congr rfl fun p _ => ?_
      rw [Matrix.transpose_smul, Matrix.transpose_sub, Matrix.transpose_single, Matrix.transpose_single,
        ← smul_neg, neg_sub]
    · funext q
      show (∑ p : Tri n, c p • (Matrix.single p.1.1 p.1.2 (1 : ℝ) - Matrix.single p.1.2 p.1.1 1) :
        Matrix (Fin n) (Fin n) ℝ) q.1.1 q.1.2 = c q
      rw [Matrix.sum_apply, Finset.sum_eq_single q]
      · have hq := q.2
        simp [Matrix.single_apply, ne_of_lt hq, (ne_of_lt hq).symm]
      · intro p _ hpq
        have hp := p.2; have hq := q.2
        simp only [Matrix.smul_apply, Matrix.sub_apply, Matrix.single_apply, smul_eq_mul]
        have e1 : ¬ (p.1.1 = q.1.1 ∧ p.1.2 = q.1.2) := fun ⟨h1, h2⟩ =>
          hpq (Subtype.ext (Prod.ext h1 h2))
        have e2 : ¬ (p.1.2 = q.1.1 ∧ p.1.1 = q.1.2) := fun ⟨h1, h2⟩ => by
          rw [← h1, ← h2] at hq; exact lt_asymm hp hq
        simp [e1, e2]
      · intro h; exact absurd (Finset.mem_univ q) h
  rw [LinearEquiv.finrank_eq (LinearEquiv.ofBijective f ⟨hinj, hsurj⟩), Module.finrank_fintype_fun_eq_card,
    card_tri]

end Proof

/-! ## The statement -/

open Proof in
/-- **L75.** For a subspace `𝔪 ⊆ 𝔰𝔬(n)`, maximal isotropy, `[𝔪,𝔪]^⊥ = 𝔪`, and *(isotropy together
with `rank[𝔪,𝔪] + dim 𝔪 = C(n,2)`)* are equivalent.

*The isotropy conjunct of the third form is the repair: without it the equivalence is false, and
`rank_form_needs_isotropy` above is the witness.* -/
theorem L75 (m : Submodule ℝ (Matrix (Fin n) (Fin n) ℝ)) (hskew : SkewSub m) :
    (MaximalIsotropic m ↔ BracketPerpEqSelf m) ∧ (MaximalIsotropic m ↔ RankForm m) := by
  refine ⟨maxIso_iff_perp m hskew, ?_⟩
  rw [maxIso_iff_perp m hskew]
  have hSV : brackets m ≤ soN n := by
    unfold brackets
    rw [Submodule.span_le]
    rintro _ ⟨u, hu, v, hv, rfl⟩
    exact skew_br (hskew u hu) (hskew v hv)
  have hmem : ∀ A, A ∈ soN n ⊓ orthS (brackets m) ↔
      Skew A ∧ ∀ u ∈ m, ∀ v ∈ m, inner2 A (br u v) = 0 := by
    intro A
    rw [Submodule.mem_inf]
    refine and_congr Iff.rfl ⟨fun h u hu v hv => h _ (Submodule.subset_span ⟨u, hu, v, hv, rfl⟩),
      fun h s hs => ?_⟩
    induction hs using Submodule.span_induction with
    | mem x hx => obtain ⟨u, hu, v, hv, rfl⟩ := hx; exact h u hu v hv
    | zero => simp [inner2]
    | add x y _ _ hx hy => rw [inner2_add_r, hx, hy, add_zero]
    | smul c x _ hx => rw [inner2_smul_r, hx, mul_zero]
  have hd := finrank_perp (soN n) (brackets m) hSV
  rw [finrank_soN] at hd
  constructor
  · intro h
    refine ⟨bracketPerp_implies_isotropic m hskew h, ?_⟩
    have heq : soN n ⊓ orthS (brackets m) = m := by
      ext A
      rw [hmem]
      constructor
      · rintro ⟨hA, hp⟩; exact (h A hA).mp hp
      · intro hA; exact ⟨hskew A hA, (h A (hskew A hA)).mpr hA⟩
    rw [heq] at hd
    omega
  · rintro ⟨hiso, hrank⟩
    have hle : m ≤ soN n ⊓ orthS (brackets m) := fun A hA => (hmem A).mpr
      ⟨hskew A hA, fun u hu v hv => by rw [inner2_comm]; exact hiso u hu v hv A hA⟩
    have heq : m = soN n ⊓ orthS (brackets m) :=
      Submodule.eq_of_le_of_finrank_eq hle (by omega)
    intro A hA
    constructor
    · intro h
      have hP : A ∈ soN n ⊓ orthS (brackets m) := (hmem A).mpr ⟨hA, h⟩
      rw [← heq] at hP; exact hP
    · intro hAm
      have hP : A ∈ soN n ⊓ orthS (brackets m) := heq ▸ hAm
      exact ((hmem A).mp hP).2


end HamiltonsCubic.L75Statement
