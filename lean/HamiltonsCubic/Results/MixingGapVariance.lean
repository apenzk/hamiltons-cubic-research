import Mathlib

/-!
# The mixing gap's variance identity (86), typed as vector algebra

[reviews/2026-09-28-I121-MG-audit.md](../../../reviews/2026-09-28-I121-MG-audit.md), the outside
author's exact variance formula (86) for route R52, checked there by hand.

**What the identity says.** At a unit critical point `W = A + ∑ B_U` split by the sign characters
of an orthonormal frame, with `t = ‖A‖`, `b² = ∑ ‖B_U‖²`, `z = (A/t - tW)/b` and
`C = (𝒰 - η) z`, one has
`ρ² t² b² ‖C‖² = ‖q_⊥‖² + ∑ ‖Y_U‖² + ∑ p_U (λ_U - λ̄)²`.

## How it is typed

The proof has two halves, and they are typed separately.

* **The variance core, `variance_core`.** `C` is a sum `c₀ + ∑ c_U` of a diagonal piece
  `c₀ = α A - κ L A` and one piece `c_U = β B_U - κ L B_U` per character, where `L` is the map
  `L_A = Q(A, ·)`. The pieces are mutually orthogonal, which is the only place the sign
  characters enter, taken here as the hypotheses `hA` and `hUV`. Two scalar conditions,
  `⟪c₀, A⟫ = 0` and `∑ ⟪c_U, B_U⟫ = 0`, force `c₀ = -κ q_⊥` and `β = κ λ̄`, and Pythagoras
  finishes.
* **The front end, `front_end`**, derives the decomposition and the two scalar conditions from
  criticality `Q(W) = ρ W`, the unit norms of `W` and `z`, and the self-adjointness of `L_W`.

*Nothing here is specific to `𝒲ₙ` or Hamilton's `Q`.* **Not typed**: that the sign-character
components of `A` and `B` are mutually orthogonal and that `L_A` maps each character to itself,
which is [L120](../../../findings/second-order.md)'s block diagonality; they enter `identity_86` as
`hAB`, `hQB`, `hQQ`, `hBB`, `hLB` and `hLL`, and `variance_core` as the piece orthogonalities `hA`
and `hUV`. This is [L284](../../../findings/second-order.md).
-/

namespace HamiltonsCubic.MixingGap

open scoped RealInnerProductSpace
open Finset

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] {ι : Type*}

/-- The diagonal piece is forced to be `-κ q_⊥` by `⟪c₀, A⟫ = 0`. -/
theorem c0_eq (L : E →ₗ[ℝ] E) (A : E) (α κ : ℝ) (hA0 : A ≠ 0)
    (h : ⟪α • A - κ • L A, A⟫ = 0) :
    α • A - κ • L A = -κ • (L A - (⟪L A, A⟫ / ‖A‖ ^ 2) • A) := by
  have hn : ‖A‖ ^ 2 ≠ 0 := by positivity
  have hα : α = κ * ⟪L A, A⟫ / ‖A‖ ^ 2 := by
    rw [inner_sub_left, real_inner_smul_left, real_inner_smul_left,
      real_inner_self_eq_norm_sq] at h
    field_simp
    linarith
  rw [hα]
  module

/-- One character's piece: with `L B = λ B + Y`, `Y ⊥ B`, the piece `β B - κ L B` has squared
norm `(β - κ λ)² ‖B‖² + κ² ‖Y‖²`. -/
theorem cU_norm (L : E →ₗ[ℝ] E) (B : E) (β κ lam : ℝ) :
    ‖β • B - κ • L B‖ ^ 2
      = (β - κ * lam) ^ 2 * ‖B‖ ^ 2 + κ ^ 2 * ‖L B - lam • B‖ ^ 2
        + 2 * (β - κ * lam) * (-κ) * ⟪B, L B - lam • B⟫ := by
  have e : β • B - κ • L B = (β - κ * lam) • B + (-κ) • (L B - lam • B) := by
    module
  rw [e, norm_add_sq_real, norm_smul, norm_smul, real_inner_smul_left, real_inner_smul_right,
    mul_pow, mul_pow, Real.norm_eq_abs, Real.norm_eq_abs, sq_abs, sq_abs]
  ring

/-- Pythagoras over a family of pieces orthogonal to `x` and to each other. -/
theorem norm_sq_add_sum (x : E) (s : Finset ι) (c : ι → E)
    (hx : ∀ U ∈ s, ⟪x, c U⟫ = 0)
    (hUV : ∀ U ∈ s, ∀ V ∈ s, U ≠ V → ⟪c U, c V⟫ = 0) :
    ‖x + ∑ U ∈ s, c U‖ ^ 2 = ‖x‖ ^ 2 + ∑ U ∈ s, ‖c U‖ ^ 2 := by
  have h1 : ⟪x, ∑ U ∈ s, c U⟫ = 0 := by
    rw [inner_sum]; exact Finset.sum_eq_zero hx
  have h2 : ‖∑ U ∈ s, c U‖ ^ 2 = ∑ U ∈ s, ‖c U‖ ^ 2 := by
    rw [← real_inner_self_eq_norm_sq, sum_inner]
    refine Finset.sum_congr rfl fun U hU => ?_
    rw [inner_sum, Finset.sum_eq_single_of_mem U hU (fun V hV hVU => hUV U hU V hV (Ne.symm hVU)),
      real_inner_self_eq_norm_sq]
  rw [norm_add_sq_real, h1, h2]
  ring

/-- **THE VARIANCE CORE OF (86).** With `c₀ = α A - κ L A` and `c_U = β B_U - κ L B_U` mutually
orthogonal, `L B_U = λ_U B_U + Y_U` with `Y_U ⊥ B_U`, and the two scalar conditions
`⟪c₀, A⟫ = 0` and `∑ ⟪c_U, B_U⟫ = 0`, the squared norm of `C = c₀ + ∑ c_U` is `κ²` times the three
defects: `‖q_⊥‖²`, `∑ ‖Y_U‖²` and the `p`-weighted variance of the `λ_U`. -/
theorem variance_core (L : E →ₗ[ℝ] E) (A : E) (s : Finset ι) (B : ι → E) (lam : ι → ℝ)
    (α β κ : ℝ) (hA0 : A ≠ 0)
    (hlam : ∀ U ∈ s, ⟪B U, L (B U) - lam U • B U⟫ = 0)
    (hA : ∀ U ∈ s, ⟪α • A - κ • L A, β • B U - κ • L (B U)⟫ = 0)
    (hUV : ∀ U ∈ s, ∀ V ∈ s, U ≠ V →
      ⟪β • B U - κ • L (B U), β • B V - κ • L (B V)⟫ = 0)
    (hc0 : ⟪α • A - κ • L A, A⟫ = 0)
    (hcB : ∑ U ∈ s, ⟪β • B U - κ • L (B U), B U⟫ = 0)
    (hb : ∑ U ∈ s, ‖B U‖ ^ 2 ≠ 0) :
    ‖(α • A - κ • L A) + ∑ U ∈ s, (β • B U - κ • L (B U))‖ ^ 2
      = κ ^ 2 * (‖L A - (⟪L A, A⟫ / ‖A‖ ^ 2) • A‖ ^ 2
          + ∑ U ∈ s, ‖L (B U) - lam U • B U‖ ^ 2
          + ∑ U ∈ s, ‖B U‖ ^ 2 * (lam U
              - (∑ V ∈ s, ‖B V‖ ^ 2 * lam V) / ∑ V ∈ s, ‖B V‖ ^ 2) ^ 2) := by
  set p : ℝ := ∑ V ∈ s, ‖B V‖ ^ 2 with hp
  set lbar : ℝ := (∑ V ∈ s, ‖B V‖ ^ 2 * lam V) / p with hlbar
  -- the pairing of each piece with its own `B_U`
  have hpair : ∀ U ∈ s, ⟪β • B U - κ • L (B U), B U⟫ = (β - κ * lam U) * ‖B U‖ ^ 2 := by
    intro U hU
    have hy := hlam U hU
    rw [inner_sub_right, real_inner_smul_right, real_inner_self_eq_norm_sq] at hy
    have hy' : ⟪B U, L (B U)⟫ = lam U * ‖B U‖ ^ 2 := by linarith
    rw [inner_sub_left, real_inner_smul_left, real_inner_smul_left, real_inner_self_eq_norm_sq,
      real_inner_comm (B U) (L (B U)), hy']
    ring
  -- `β = κ λ̄`
  have hβ : β = κ * lbar := by
    rw [Finset.sum_congr rfl hpair] at hcB
    have key : ∑ U ∈ s, (β - κ * lam U) * ‖B U‖ ^ 2
        = β * p - κ * ∑ V ∈ s, ‖B V‖ ^ 2 * lam V := by
      rw [hp, Finset.mul_sum, Finset.mul_sum, ← Finset.sum_sub_distrib]
      exact Finset.sum_congr rfl fun U _ => by ring
    rw [key] at hcB
    rw [hlbar]
    field_simp
    linarith
  rw [norm_sq_add_sum _ s _ hA hUV, c0_eq L A α κ hA0 hc0, norm_smul, mul_pow, Real.norm_eq_abs,
    sq_abs]
  have hU : ∀ U ∈ s, ‖β • B U - κ • L (B U)‖ ^ 2
      = κ ^ 2 * (‖L (B U) - lam U • B U‖ ^ 2 + ‖B U‖ ^ 2 * (lam U - lbar) ^ 2) := by
    intro U hU
    rw [cU_norm L (B U) β κ (lam U), hlam U hU, hβ]
    ring
  rw [Finset.sum_congr rfl hU, ← Finset.mul_sum, Finset.sum_add_distrib, neg_sq]
  ring

/-- **THE FRONT END.** At a unit critical point `W = A + ∑ B_U` of `m` (`m W W = ρ W`, `‖W‖ = 1`,
`m` symmetric and each `m x` self-adjoint), with `‖A‖ = t`, `t² + b² = 1`, `A ⊥ B_U`, and
`z`, `𝒰 z`, `η`, `C` as the source defines them, `C` is the sum of the diagonal piece and the
character pieces of `variance_core`, and `C ⊥ A`, `C ⊥ ∑ B_U`. -/
theorem front_end (m : E →ₗ[ℝ] E →ₗ[ℝ] E) (A : E) (s : Finset ι) (B : ι → E) (ρ t b η : ℝ)
    (z Uz C : E)
    (hsymm : ∀ x y, m x y = m y x) (hadj : ∀ x y w, ⟪m x y, w⟫ = ⟪y, m x w⟫)
    (hAn : ‖A‖ = t) (ht : 0 < t) (hb : 0 < b) (htb : t ^ 2 + b ^ 2 = 1) (hρ : ρ ≠ 0)
    (hW1 : ‖A + ∑ U ∈ s, B U‖ = 1)
    (hcrit : m (A + ∑ U ∈ s, B U) (A + ∑ U ∈ s, B U) = ρ • (A + ∑ U ∈ s, B U))
    (hAB : ∀ U ∈ s, ⟪A, B U⟫ = 0)
    (hz : z = b⁻¹ • (t⁻¹ • A - t • (A + ∑ U ∈ s, B U)))
    (hUz : Uz = (1 / 2 : ℝ) • z + ((1 / 2 : ℝ) * ⟪A + ∑ U ∈ s, B U, z⟫) • (A + ∑ U ∈ s, B U)
      - ρ⁻¹ • m (A + ∑ U ∈ s, B U) z)
    (hη : η = ⟪z, Uz⟫) (hC : C = Uz - η • z) :
    C = (((1 / 2 - η) * b / t + t / b) • A - (ρ * t * b)⁻¹ • m A A)
        + ∑ U ∈ s, ((t * (1 / 2 + η) / b) • B U - (ρ * t * b)⁻¹ • m A (B U))
      ∧ ⟪C, A⟫ = 0 ∧ ⟪C, ∑ U ∈ s, B U⟫ = 0 := by
  set SB := ∑ U ∈ s, B U with hSB
  set W := A + SB with hWdef
  have ht0 : t ≠ 0 := ht.ne'
  have hb0 : b ≠ 0 := hb.ne'
  have hASB : ⟪A, SB⟫ = 0 := by rw [hSB, inner_sum]; exact Finset.sum_eq_zero hAB
  have hAA : ⟪A, A⟫ = t ^ 2 := by rw [real_inner_self_eq_norm_sq, hAn]
  have hAW : ⟪A, W⟫ = t ^ 2 := by rw [hWdef, inner_add_right, hASB, hAA, add_zero]
  have hWW : ⟪W, W⟫ = 1 := by rw [real_inner_self_eq_norm_sq, hW1, one_pow]
  have hWz : ⟪W, z⟫ = 0 := by
    rw [hz, real_inner_smul_right, inner_sub_right, real_inner_smul_right, real_inner_smul_right,
      real_inner_comm A W, hAW, hWW]
    field_simp
    ring
  have hin : ⟪t⁻¹ • A - t • W, t⁻¹ • A - t • W⟫ = b ^ 2 := by
    simp only [inner_sub_left, inner_sub_right, real_inner_smul_left, real_inner_smul_right, hAA,
      hAW, hWW, real_inner_comm A W]
    have h1 : t⁻¹ * (t⁻¹ * t ^ 2) = 1 := by field_simp
    have h2 : t⁻¹ * (t * t ^ 2) = t ^ 2 := by rw [← mul_assoc, inv_mul_cancel₀ ht0, one_mul]
    have h3 : t * (t⁻¹ * t ^ 2) = t ^ 2 := by rw [← mul_assoc, mul_inv_cancel₀ ht0, one_mul]
    rw [h1, h2, h3]
    linarith [htb]
  have hzz : ⟪z, z⟫ = 1 := by
    rw [hz, real_inner_smul_left, real_inner_smul_right, hin]
    field_simp
  -- `m W A` through linearity and symmetry
  have hmWA : m W A = m A A + ∑ U ∈ s, m A (B U) := by
    rw [hWdef, map_add, LinearMap.add_apply, hSB, map_sum, LinearMap.sum_apply]
    congr 1
    exact Finset.sum_congr rfl fun U _ => hsymm (B U) A
  have hmWz : m W z = b⁻¹ • (t⁻¹ • (m A A + ∑ U ∈ s, m A (B U)) - (t * ρ) • W) := by
    rw [hz, map_smul, map_sub, map_smul, map_smul, hmWA, hcrit, smul_smul]
  -- the two orthogonalities
  have hCW : ⟪C, W⟫ = 0 := by
    have hmz : ⟪m W z, W⟫ = 0 := by rw [hadj, hcrit, real_inner_smul_right, real_inner_comm, hWz,
      mul_zero]
    have hzW : ⟪z, W⟫ = 0 := by rw [real_inner_comm]; exact hWz
    rw [hC, hUz, inner_sub_left, inner_sub_left, inner_add_left, real_inner_smul_left,
      real_inner_smul_left, real_inner_smul_left, real_inner_smul_left]
    simp only [hzW, hWz, hmz, hWW]
    ring
  have hCz : ⟪C, z⟫ = 0 := by
    rw [hC, inner_sub_left, real_inner_smul_left, hzz, real_inner_comm, ← hη]
    ring
  have hAsplit : A = (t ^ 2) • W + (t * b) • z := by
    rw [hz, smul_smul, smul_sub, smul_smul, smul_smul]
    match_scalars <;> field_simp <;> ring
  have hCA : ⟪C, A⟫ = 0 := by
    rw [hAsplit, inner_add_right, real_inner_smul_right, real_inner_smul_right, hCW, hCz]
    ring
  have hCSB : ⟪C, SB⟫ = 0 := by
    have : SB = W - A := by rw [hWdef]; abel
    rw [this, inner_sub_right, hCW, hCA, sub_zero]
  refine ⟨?_, hCA, hCSB⟩
  -- the decomposition, with the sums collected as atoms
  have hsum : ∑ U ∈ s, ((t * (1 / 2 + η) / b) • B U - (ρ * t * b)⁻¹ • m A (B U))
      = (t * (1 / 2 + η) / b) • SB - (ρ * t * b)⁻¹ • ∑ U ∈ s, m A (B U) := by
    rw [Finset.sum_sub_distrib, ← Finset.smul_sum, ← Finset.smul_sum]
  rw [hsum, hC, hUz, hWz, mul_zero, zero_smul, add_zero, hmWz, hz, hWdef]
  match_scalars <;> field_simp <;> first | ring1 | linear_combination (2 * η - 1) * htb

/-- **IDENTITY (86).** At a unit critical point with `ρ ≠ 0`, `0 < t < 1`, split by mutually
orthogonal characters that `L_A` preserves, `ρ² t² b² ‖C‖² = ‖q_⊥‖² + ∑ ‖Y_U‖² + ∑ p_U (λ_U - λ̄)²`.
The character hypotheses are `hAB` to `hLL`; `hlam` defines `λ_U` by `Y_U ⊥ B_U`. -/
theorem identity_86 (m : E →ₗ[ℝ] E →ₗ[ℝ] E) (A : E) (s : Finset ι) (B : ι → E) (lam : ι → ℝ)
    (ρ t b η : ℝ) (z Uz C : E)
    (hsymm : ∀ x y, m x y = m y x) (hadj : ∀ x y w, ⟪m x y, w⟫ = ⟪y, m x w⟫)
    (hAn : ‖A‖ = t) (ht : 0 < t) (hb : 0 < b) (htb : t ^ 2 + b ^ 2 = 1) (hρ : ρ ≠ 0)
    (hW1 : ‖A + ∑ U ∈ s, B U‖ = 1)
    (hcrit : m (A + ∑ U ∈ s, B U) (A + ∑ U ∈ s, B U) = ρ • (A + ∑ U ∈ s, B U))
    (hAB : ∀ U ∈ s, ⟪A, B U⟫ = 0) (hQB : ∀ U ∈ s, ⟪m A A, B U⟫ = 0)
    (hQQ : ∀ U ∈ s, ⟪m A A, m A (B U)⟫ = 0)
    (hBB : ∀ U ∈ s, ∀ V ∈ s, U ≠ V → ⟪B U, B V⟫ = 0)
    (hLB : ∀ U ∈ s, ∀ V ∈ s, U ≠ V → ⟪m A (B U), B V⟫ = 0)
    (hLL : ∀ U ∈ s, ∀ V ∈ s, U ≠ V → ⟪m A (B U), m A (B V)⟫ = 0)
    (hlam : ∀ U ∈ s, ⟪B U, m A (B U) - lam U • B U⟫ = 0)
    (hz : z = b⁻¹ • (t⁻¹ • A - t • (A + ∑ U ∈ s, B U)))
    (hUz : Uz = (1 / 2 : ℝ) • z + ((1 / 2 : ℝ) * ⟪A + ∑ U ∈ s, B U, z⟫) • (A + ∑ U ∈ s, B U)
      - ρ⁻¹ • m (A + ∑ U ∈ s, B U) z)
    (hη : η = ⟪z, Uz⟫) (hC : C = Uz - η • z) :
    ρ ^ 2 * t ^ 2 * b ^ 2 * ‖C‖ ^ 2
      = ‖m A A - (⟪m A A, A⟫ / ‖A‖ ^ 2) • A‖ ^ 2
          + ∑ U ∈ s, ‖m A (B U) - lam U • B U‖ ^ 2
          + ∑ U ∈ s, ‖B U‖ ^ 2 * (lam U
              - (∑ V ∈ s, ‖B V‖ ^ 2 * lam V) / ∑ V ∈ s, ‖B V‖ ^ 2) ^ 2 := by
  obtain ⟨hdec, hCA, hCSB⟩ := front_end m A s B ρ t b η z Uz C hsymm hadj hAn ht hb htb hρ hW1
    hcrit hAB hz hUz hη hC
  set α := (1 / 2 - η) * b / t + t / b
  set β := t * (1 / 2 + η) / b
  set κ := (ρ * t * b)⁻¹ with hκ
  have hA0 : A ≠ 0 := by rintro rfl; rw [norm_zero] at hAn; exact ht.ne hAn
  -- orthogonality of the pieces, from the character hypotheses
  have hpA : ∀ U ∈ s, ⟪β • B U - κ • m A (B U), A⟫ = 0 := by
    intro U hU
    rw [inner_sub_left, real_inner_smul_left, real_inner_smul_left, real_inner_comm, hAB U hU, hadj,
      real_inner_comm, hQB U hU]
    ring
  have hpB : ∀ U ∈ s, ∀ V ∈ s, U ≠ V → ⟪β • B U - κ • m A (B U), B V⟫ = 0 := by
    intro U hU V hV hUV
    rw [inner_sub_left, real_inner_smul_left, real_inner_smul_left, hBB U hU V hV hUV,
      hLB U hU V hV hUV]
    ring
  have hc0B : ∀ V ∈ s, ⟪α • A - κ • m A A, B V⟫ = 0 := by
    intro V hV
    rw [inner_sub_left, real_inner_smul_left, real_inner_smul_left, hAB V hV, hQB V hV]
    ring
  have hc0 : ⟪α • A - κ • m A A, A⟫ = 0 := by
    have h := hCA
    rw [hdec, inner_add_left, sum_inner, Finset.sum_eq_zero hpA, add_zero] at h
    exact h
  have hcB : ∑ U ∈ s, ⟪β • B U - κ • m A (B U), B U⟫ = 0 := by
    have h := hCSB
    rw [hdec, inner_add_left, inner_sum, Finset.sum_eq_zero hc0B, zero_add, sum_inner] at h
    rw [← h]
    refine Finset.sum_congr rfl fun U hU => ?_
    rw [inner_sum, Finset.sum_eq_single_of_mem U hU
      (fun V hV hVU => hpB U hU V hV (Ne.symm hVU))]
  have hAp : ∀ U ∈ s, ⟪α • A - κ • m A A, β • B U - κ • m A (B U)⟫ = 0 := by
    intro U hU
    rw [inner_sub_right, real_inner_smul_right, real_inner_smul_right, hc0B U hU,
      inner_sub_left, real_inner_smul_left, real_inner_smul_left, real_inner_comm, hadj,
      real_inner_comm (m A A), hQB U hU, hQQ U hU]
    ring
  have hpp : ∀ U ∈ s, ∀ V ∈ s, U ≠ V →
      ⟪β • B U - κ • m A (B U), β • B V - κ • m A (B V)⟫ = 0 := by
    intro U hU V hV hUV
    rw [inner_sub_right, real_inner_smul_right, real_inner_smul_right, hpB U hU V hV hUV,
      inner_sub_left, real_inner_smul_left, real_inner_smul_left,
      real_inner_comm (m A (B V)) (B U), hLB V hV U hU (Ne.symm hUV), hLL U hU V hV hUV]
    ring
  have hb2 : ∑ U ∈ s, ‖B U‖ ^ 2 ≠ 0 := by
    have hSBn : ‖∑ U ∈ s, B U‖ ^ 2 = ∑ U ∈ s, ‖B U‖ ^ 2 := by
      have := norm_sq_add_sum (0 : E) s B (fun U _ => inner_zero_left _) hBB
      simpa using this
    have hWn : ‖A + ∑ U ∈ s, B U‖ ^ 2 = t ^ 2 + ‖∑ U ∈ s, B U‖ ^ 2 := by
      rw [norm_add_sq_real, inner_sum, Finset.sum_eq_zero hAB, hAn]; ring
    rw [← hSBn]
    intro h0
    rw [h0, hW1] at hWn
    nlinarith [htb, hb]
  have key := variance_core (m A) A s B lam α β κ hA0 hlam hAp hpp hc0 hcB hb2
  have hk : ρ ^ 2 * t ^ 2 * b ^ 2 * κ ^ 2 = 1 := by
    rw [hκ]; field_simp
  rw [hdec, key, ← mul_assoc, hk, one_mul]

end HamiltonsCubic.MixingGap
