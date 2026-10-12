import HamiltonsCubic.Results.L70Identity
import HamiltonsCubic.Results.L244RowA
import HamiltonsCubic.Results.L244RowBMass

set_option linter.style.longLine false

/-!
# L70 at a critical Weyl operator: the rows discharged

[findings/bounds.md](../../../findings/bounds.md), Lemma L70: at every critical point and every unit
`v ∈ E_min`, `θ = λ_min + (n − 2) λ_max − D(v)/|λ_min|` with
`D(v) = ½ ∑_{a,b} (λ_a λ_b − λ_min λ_max) c²_{vab} ≥ 0`.

[L70Identity.lean](L70Identity.lean) proves the identity, the sign and the equality case with the
per-vector rows (A) and (C) as hypotheses. **This file supplies both rows from the operator**, so
the statement is about a critical linear Weyl operator rather than about numbers that satisfy two
equations:

- row (A), `∑_{a,b} b_ab(x) = n − 2`, is [L244RowA.lean](L244RowA.lean)'s `rowMass_total_any`
  through `rowMass_eq_sum_bAB`, for any skew family `ψ` expanding every bivector;
- row (C), `∑_{a,b} λ_a λ_b b_ab(x) = λ_min (θ − λ_min)`, is
  [L244RowBMass.lean](L244RowBMass.lean)'s `rowC_mass` (the class masses sum to `⟨W# x, x⟩`) and
  `rowC_critical` (at a critical point that is `λ_c (θ − λ_c)` on a unit eigenvector).

**Any number `K` of eigenvalue classes**, `cls : Fin r → Fin K`: the row files are generic in `K`,
so a spectrum with any count of distinct eigenvalues is covered, in particular by taking every basis
vector as its own class (`K = r`, `cls = id`), which lifts the three-class limit
[r1195](../../../reviews/REVIEW_r1195.md) found. `θ` is the multiplier in `Q(W) = θ W`. `b_ab` is the record's `½ ∑_{γ ∈ E_a, δ ∈ E_b} ⟨[ψ_γ, ψ_δ], x⟩²`.

The existence of an orthonormal eigenbasis, which enters here as `hψ` and `hWP`, is
[EigenFrameExist.lean](EigenFrameExist.lean)'s, and `L70_bound_exists` there states the bound with it supplied. **Not typed here**: and the Lie-theoretic reading of saturation on L23's family.
-/

namespace HamiltonsCubic.L70Weyl

open HamiltonsCubic.RealLayer

variable {n r K : ℕ}

/-- **Row (A) summed**: `∑_{a,b} b_ab(x) = n − 2` at a unit skew `x`. -/
theorem rowA_sum (ψ : Fin r → Matrix (Fin n) (Fin n) ℝ) (hψS : ∀ k, IsSkew (ψ k))
    (hψ : ∀ Y, IsSkew Y → Y = ∑ k, inner2 (ψ k) Y • ψ k) (cls : Fin r → Fin K)
    (x : Matrix (Fin n) (Fin n) ℝ) (hx : IsSkew x) (hunit : inner2 x x = 1) :
    ∑ a, ∑ b, L244RowA.bAB ψ cls a b x = (n : ℝ) - 2 := by
  have h := L244RowA.rowMass_total_any ψ hψS hψ ψ hψ x hx
  rw [L244RowA.rowMass_eq_sum_bAB ψ cls x, hunit, mul_one] at h
  exact h

/-- **Row (C) at a unit eigenvector**: `∑_{a,b} λ_a λ_b b_ab(x) = λ_c (θ − λ_c)`. -/
theorem rowC_sum (W : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ) (hW : IsWeylOp W)
    (θ : ℝ) (hc : IsCritical W θ) (ψ : Fin r → Matrix (Fin n) (Fin n) ℝ)
    (hψS : ∀ k, IsSkew (ψ k)) (cls : Fin r → Fin K) (lam : Fin K → ℝ)
    (hWP : ∀ X, IsSkew X → W X = ∑ b, lam b • L244RowBMass.Pc ψ cls b X)
    (x : Matrix (Fin n) (Fin n) ℝ) (hx : IsSkew x) (lc : ℝ) (hxe : W x = lc • x)
    (hunit : inner2 x x = 1) :
    ∑ a, ∑ b, lam a * lam b * L244RowA.bAB ψ cls a b x = lc * (θ - lc) := by
  rw [L244RowBMass.rowC_mass W hW ψ hψS cls lam hWP x hx,
    L244RowBMass.rowC_critical W hW θ hc x hx lc hxe hunit]

/-- **L70's boxed identity at a critical Weyl operator.** For a unit skew eigenvector `x` of the
eigenvalue `λ_min < 0`, `θ = λ_min + (n − 2) λ_max − D(x)/|λ_min|`, with `D` the deficiency over
the class masses of `x`. -/
theorem L70_identity (W : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ) (hW : IsWeylOp W)
    (θ : ℝ) (hc : IsCritical W θ) (ψ : Fin r → Matrix (Fin n) (Fin n) ℝ)
    (hψS : ∀ k, IsSkew (ψ k)) (hψ : ∀ Y, IsSkew Y → Y = ∑ k, inner2 (ψ k) Y • ψ k)
    (cls : Fin r → Fin K) (lam : Fin K → ℝ)
    (hWP : ∀ X, IsSkew X → W X = ∑ b, lam b • L244RowBMass.Pc ψ cls b X)
    (x : Matrix (Fin n) (Fin n) ℝ) (hx : IsSkew x) (hunit : inner2 x x = 1)
    (lmin lmax : ℝ) (hxe : W x = lmin • x) (hneg : lmin < 0) :
    θ = lmin + ((n : ℝ) - 2) * lmax
      - L70Identity.D (fun a b => L244RowA.bAB ψ cls a b x) lam lmin lmax / |lmin| :=
  L70Identity.deficiency_identity _ lam lmin lmax θ n hneg
    (rowA_sum ψ hψS hψ cls x hx hunit)
    (rowC_sum W hW θ hc ψ hψS cls lam hWP x hx lmin hxe hunit)

/-- The class masses are nonnegative, a half sum of squares. -/
theorem bAB_nonneg (ψ : Fin r → Matrix (Fin n) (Fin n) ℝ) (cls : Fin r → Fin K) (a b : Fin K)
    (x : Matrix (Fin n) (Fin n) ℝ) : 0 ≤ L244RowA.bAB ψ cls a b x := by
  unfold L244RowA.bAB
  exact mul_nonneg (by norm_num)
    (Finset.sum_nonneg fun _ _ => Finset.sum_nonneg fun _ _ => sq_nonneg _)

/-- **The deficiency is nonnegative**, so `θ ≤ λ_min + (n − 2) λ_max`, when every class value lies
in `[λ_min, λ_max]` with `λ_min ≤ 0 ≤ λ_max`. -/
theorem L70_bound (W : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ) (hW : IsWeylOp W)
    (θ : ℝ) (hc : IsCritical W θ) (ψ : Fin r → Matrix (Fin n) (Fin n) ℝ)
    (hψS : ∀ k, IsSkew (ψ k)) (hψ : ∀ Y, IsSkew Y → Y = ∑ k, inner2 (ψ k) Y • ψ k)
    (cls : Fin r → Fin K) (lam : Fin K → ℝ)
    (hWP : ∀ X, IsSkew X → W X = ∑ b, lam b • L244RowBMass.Pc ψ cls b X)
    (x : Matrix (Fin n) (Fin n) ℝ) (hx : IsSkew x) (hunit : inner2 x x = 1)
    (lmin lmax : ℝ) (hxe : W x = lmin • x) (hneg : lmin < 0) (hmax : 0 ≤ lmax)
    (hlo : ∀ i, lmin ≤ lam i) (hhi : ∀ i, lam i ≤ lmax) :
    θ ≤ lmin + ((n : ℝ) - 2) * lmax := by
  have hid := L70_identity W hW θ hc ψ hψS hψ cls lam hWP x hx hunit lmin lmax hxe hneg
  have hD := L70Identity.deficiency_nonneg (fun a b => L244RowA.bAB ψ cls a b x) lam lmin lmax
    (fun a b => bAB_nonneg ψ cls a b x) hneg.le hmax hlo hhi
  have : 0 ≤ L70Identity.D (fun a b => L244RowA.bAB ψ cls a b x) lam lmin lmax / |lmin| :=
    div_nonneg hD (abs_nonneg _)
  linarith

/-- **The equality case**: `θ = λ_min + (n − 2) λ_max` exactly when every class pair carrying mass
at `x` has `λ_a λ_b = λ_min λ_max`. -/
theorem L70_equality (W : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ) (hW : IsWeylOp W)
    (θ : ℝ) (hc : IsCritical W θ) (ψ : Fin r → Matrix (Fin n) (Fin n) ℝ)
    (hψS : ∀ k, IsSkew (ψ k)) (hψ : ∀ Y, IsSkew Y → Y = ∑ k, inner2 (ψ k) Y • ψ k)
    (cls : Fin r → Fin K) (lam : Fin K → ℝ)
    (hWP : ∀ X, IsSkew X → W X = ∑ b, lam b • L244RowBMass.Pc ψ cls b X)
    (x : Matrix (Fin n) (Fin n) ℝ) (hx : IsSkew x) (hunit : inner2 x x = 1)
    (lmin lmax : ℝ) (hxe : W x = lmin • x) (hneg : lmin < 0) (hmax : 0 ≤ lmax)
    (hlo : ∀ i, lmin ≤ lam i) (hhi : ∀ i, lam i ≤ lmax) :
    θ = lmin + ((n : ℝ) - 2) * lmax ↔
      ∀ a b, (lam a * lam b - lmin * lmax) * L244RowA.bAB ψ cls a b x = 0 := by
  have hid := L70_identity W hW θ hc ψ hψS hψ cls lam hWP x hx hunit lmin lmax hxe hneg
  rw [← L70Identity.deficiency_zero_iff (fun a b => L244RowA.bAB ψ cls a b x) lam lmin lmax
    (fun a b => bAB_nonneg ψ cls a b x) hneg.le hmax hlo hhi]
  have habs : 0 < |lmin| := abs_pos.mpr hneg.ne
  constructor
  · intro h
    rw [h] at hid
    have := div_eq_zero_iff.mp (by linarith : L70Identity.D (fun a b => L244RowA.bAB ψ cls a b x) lam lmin lmax / |lmin| = 0)
    rcases this with h0 | h0
    · exact h0
    · exact absurd h0 habs.ne'
  · intro h
    rw [hid, h, zero_div, sub_zero]

/-! ## Every spectrum, through an eigenbasis with one class per vector -/

/-- With `cls = id`, `Pc` is the rank-one projection onto `ψ_b`. -/
theorem Pc_id (ψ : Fin r → Matrix (Fin n) (Fin n) ℝ) (b : Fin r) (X : Matrix (Fin n) (Fin n) ℝ) :
    L244RowBMass.Pc ψ id b X = inner2 (ψ b) X • ψ b := by
  unfold L244RowBMass.Pc
  simp [Finset.filter_eq']

/-- **An eigenbasis frame with `cls = id` meets `hWP`**, whatever the number of distinct
eigenvalues. -/
theorem hWP_of_eigenbasis (W : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ) (hW : IsWeylOp W)
    (ψ : Fin r → Matrix (Fin n) (Fin n) ℝ) (μ : Fin r → ℝ)
    (hψ : ∀ Y, IsSkew Y → Y = ∑ k, inner2 (ψ k) Y • ψ k) (heig : ∀ k, W (ψ k) = μ k • ψ k) :
    ∀ X, IsSkew X → W X = ∑ b, μ b • L244RowBMass.Pc ψ id b X := by
  intro X hX
  have hL := hW.1
  conv_lhs => rw [hψ X hX]
  have hsum : ∀ (s : Finset (Fin r)),
      W (∑ k ∈ s, inner2 (ψ k) X • ψ k) = ∑ k ∈ s, W (inner2 (ψ k) X • ψ k) := by
    intro s
    classical
    induction s using Finset.induction_on with
    | empty => simpa using (hL.2 0 0)
    | insert a s ha ih => rw [Finset.sum_insert ha, Finset.sum_insert ha, hL.1, ih]
  rw [hsum]
  refine Finset.sum_congr rfl fun k _ => ?_
  unfold L244RowBMass.Pc
  simp [Finset.filter_eq', hL.2, heig, smul_smul, mul_comm]

/-- With `cls = id`, `b_ab(x) = ½ ⟨[ψ_a, ψ_b], x⟩²`, the record's `½ c²_{xab}`. -/
theorem bAB_id (ψ : Fin r → Matrix (Fin n) (Fin n) ℝ) (a b : Fin r) (x : Matrix (Fin n) (Fin n) ℝ) :
    L244RowA.bAB ψ id a b x = (1/2) * inner2 (br (ψ a) (ψ b)) x ^ 2 := by
  unfold L244RowA.bAB
  simp [Finset.filter_eq']

/-- **L70's bound over an eigenbasis, at every spectrum**: `θ ≤ λ_min + (n − 2) λ_max` for a
critical linear Weyl `W` with a skew eigenbasis `ψ` expanding every bivector, eigenvalues `μ` in
`[λ_min, λ_max]`, `λ_min < 0 ≤ λ_max`, and `x` a unit skew eigenvector of `λ_min`. -/
theorem L70_bound_eigenbasis (W : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ)
    (hW : IsWeylOp W) (θ : ℝ) (hc : IsCritical W θ) (ψ : Fin r → Matrix (Fin n) (Fin n) ℝ)
    (hψS : ∀ k, IsSkew (ψ k)) (hψ : ∀ Y, IsSkew Y → Y = ∑ k, inner2 (ψ k) Y • ψ k)
    (μ : Fin r → ℝ) (heig : ∀ k, W (ψ k) = μ k • ψ k)
    (x : Matrix (Fin n) (Fin n) ℝ) (hx : IsSkew x) (hunit : inner2 x x = 1)
    (lmin lmax : ℝ) (hxe : W x = lmin • x) (hneg : lmin < 0) (hmax : 0 ≤ lmax)
    (hlo : ∀ i, lmin ≤ μ i) (hhi : ∀ i, μ i ≤ lmax) :
    θ ≤ lmin + ((n : ℝ) - 2) * lmax :=
  L70_bound W hW θ hc ψ hψS hψ id μ (hWP_of_eigenbasis W hW ψ μ hψ heig) x hx hunit lmin lmax
    hxe hneg hmax hlo hhi

end HamiltonsCubic.L70Weyl
