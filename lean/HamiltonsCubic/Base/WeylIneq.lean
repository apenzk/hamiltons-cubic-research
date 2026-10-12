import Mathlib

set_option linter.style.longLine false

/-!
# Weyl's eigenvalue inequality for symmetric operators

Milestone 1 of [the build plan for L17's derivative](../../../reviews/2026-09-26-lean-DK-plan.md). For a symmetric
operator on a finite-dimensional real inner product space, with Mathlib's decreasing eigenvalues `λ₀ ≥ λ₁ ≥ …`:

- `inner_apply_eq_sum`: `⟪T x, x⟫ = ∑ λᵢ ⟪eᵢ, x⟫²` in the eigenbasis;
- `inner_le_of_orth`: `⟪T x, x⟫ ≤ λ_k ‖x‖²` when `x` is orthogonal to `e₀, …, e_{k−1}`;
- `le_inner_of_span`: `λ_k ‖x‖² ≤ ⟪T x, x⟫` when `x` lies in the span of `e₀, …, e_k`;
- `eigenvalue_le_of_inner_le`: `λ_k(S) ≤ λ_k(A) + c` whenever `⟪S x, x⟫ ≤ ⟪A x, x⟫ + c ‖x‖²` for all `x`;
- `eigenvalue_le_add`: `λ_k(A + B) ≤ λ_k(A) + c` whenever `⟪B x, x⟫ ≤ c ‖x‖²` for all `x`;
- **`abs_eigenvalue_add_sub_le`**, Weyl's inequality: `|λ_k(A + B) − λ_k(A)| ≤ c` whenever `|⟪B x, x⟫| ≤ c ‖x‖²`,
  and `abs_inner_self_le` supplies that hypothesis with `c = ‖B‖`;
- `abs_eigenvalue_add_smul_sub_le`: `|λ_k(A + tH) − λ_k(A)| ≤ |t| ‖H‖`.
-/

namespace HamiltonsCubic.WeylIneq

open Module

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] [FiniteDimensional ℝ E]
  {n : ℕ} (hn : finrank ℝ E = n)

section
variable {T : E →ₗ[ℝ] E} (hT : T.IsSymmetric)
include hT

/-- **The quadratic form in the eigenbasis.** -/
theorem inner_apply_eq_sum (x : E) :
    inner ℝ (T x) x = ∑ i, hT.eigenvalues hn i * inner ℝ (hT.eigenvectorBasis hn i) x ^ 2 := by
  set e := hT.eigenvectorBasis hn
  rw [← e.sum_inner_mul_inner (T x) x]
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [hT (x) (e i), hT.apply_eigenvectorBasis, real_inner_smul_right, real_inner_comm (e i) x]
  simp only [RCLike.ofReal_real_eq_id, id]
  ring

/-- **Above the first `k`**: `x ⊥ e₀, …, e_{k−1}` gives `⟪T x, x⟫ ≤ λ_k ‖x‖²`. -/
theorem inner_le_of_orth (k : Fin n) (x : E) (hx : ∀ i : Fin n, i < k → inner ℝ (hT.eigenvectorBasis hn i) x = 0) :
    inner ℝ (T x) x ≤ hT.eigenvalues hn k * ‖x‖ ^ 2 := by
  rw [inner_apply_eq_sum hn hT, ← real_inner_self_eq_norm_sq, ← (hT.eigenvectorBasis hn).sum_inner_mul_inner x x,
    Finset.mul_sum]
  refine Finset.sum_le_sum fun i _ => ?_
  rw [real_inner_comm (hT.eigenvectorBasis hn i) x]
  by_cases hi : i < k
  · rw [hx i hi]; simp
  · push Not at hi
    have := hT.eigenvalues_antitone hn hi
    nlinarith [sq_nonneg (inner ℝ (hT.eigenvectorBasis hn i) x)]

/-- **Within the first `k + 1`**: `x ∈ span(e₀, …, e_k)` gives `λ_k ‖x‖² ≤ ⟪T x, x⟫`. -/
theorem le_inner_of_span (k : Fin n) (x : E) (hx : ∀ i : Fin n, k < i → inner ℝ (hT.eigenvectorBasis hn i) x = 0) :
    hT.eigenvalues hn k * ‖x‖ ^ 2 ≤ inner ℝ (T x) x := by
  rw [inner_apply_eq_sum hn hT, ← real_inner_self_eq_norm_sq, ← (hT.eigenvectorBasis hn).sum_inner_mul_inner x x,
    Finset.mul_sum]
  refine Finset.sum_le_sum fun i _ => ?_
  rw [real_inner_comm (hT.eigenvectorBasis hn i) x]
  by_cases hi : k < i
  · rw [hx i hi]; simp
  · push Not at hi
    have := hT.eigenvalues_antitone hn hi
    nlinarith [sq_nonneg (inner ℝ (hT.eigenvectorBasis hn i) x)]

end

/-- **Eigenvalue comparison.** If `⟪S x, x⟫ ≤ ⟪A x, x⟫ + c ‖x‖²` for every `x`, then `λ_k(S) ≤ λ_k(A) + c` for
every `k`. The proof takes `x ≠ 0` in the span of the first `k + 1` eigenvectors of `S` and orthogonal to the first
`k` of `A`, which exists by counting dimensions. -/
theorem eigenvalue_le_of_inner_le {A S : E →ₗ[ℝ] E} (hA : A.IsSymmetric) (hAB : S.IsSymmetric) (c : ℝ)
    (hB : ∀ x, inner ℝ (S x) x ≤ inner ℝ (A x) x + c * ‖x‖ ^ 2) (k : Fin n) :
    hAB.eigenvalues hn k ≤ hA.eigenvalues hn k + c := by
  set e := hA.eigenvectorBasis hn
  set f := hAB.eigenvectorBasis hn
  let L : (Fin n → ℝ) →ₗ[ℝ] E := Fintype.linearCombination ℝ (fun i => f i)
  let Φ : (Fin n → ℝ) →ₗ[ℝ] ({i : Fin n // i ≠ k} → ℝ) :=
    LinearMap.pi fun i => if (i : Fin n) < k then (innerₛₗ ℝ (e i)) ∘ₗ L else LinearMap.proj (i : Fin n)
  have hdim : finrank ℝ ({i : Fin n // i ≠ k} → ℝ) < finrank ℝ (Fin n → ℝ) := by
    rw [Module.finrank_fintype_fun_eq_card, Module.finrank_fintype_fun_eq_card, Fintype.card_subtype_compl,
      Fintype.card_fin, Fintype.card_unique]
    have := k.isLt
    omega
  obtain ⟨v, hv, hv0⟩ := Submodule.exists_mem_ne_zero_of_ne_bot (LinearMap.ker_ne_bot_of_finrank_lt (f := Φ) hdim)
  rw [LinearMap.mem_ker] at hv
  set x := L v with hxdef
  have hfx : ∀ i, inner ℝ (f i) x = v i := fun i => by
    rw [hxdef, Fintype.linearCombination_apply]
    exact f.orthonormal.inner_right_fintype v i
  have hcomp : ∀ i : {i : Fin n // i ≠ k}, Φ v i = 0 := fun i => by rw [hv]; rfl
  have hhigh : ∀ i : Fin n, k < i → inner ℝ (f i) x = 0 := fun i hi => by
    have := hcomp ⟨i, ne_of_gt hi⟩
    simp only [Φ, LinearMap.pi_apply, not_lt.mpr hi.le, if_false, LinearMap.proj_apply] at this
    rw [hfx]; exact this
  have hlow : ∀ i : Fin n, i < k → inner ℝ (e i) x = 0 := fun i hi => by
    have := hcomp ⟨i, ne_of_lt hi⟩
    simpa [Φ, hi] using this
  have hx0 : x ≠ 0 := by
    intro h
    apply hv0
    funext i
    rw [← hfx, h, inner_zero_right]; rfl
  have hpos : 0 < ‖x‖ ^ 2 := by positivity
  have h1 := le_inner_of_span hn hAB k x hhigh
  have h2 := inner_le_of_orth hn hA k x hlow
  have h3 := hB x
  have : hAB.eigenvalues hn k * ‖x‖ ^ 2 ≤ (hA.eigenvalues hn k + c) * ‖x‖ ^ 2 := by linarith
  exact le_of_mul_le_mul_right this hpos

/-- **Weyl's inequality, one side.** If `⟪B x, x⟫ ≤ c ‖x‖²` for every `x`, then `λ_k(A + B) ≤ λ_k(A) + c`. -/
theorem eigenvalue_le_add {A B : E →ₗ[ℝ] E} (hA : A.IsSymmetric) (hAB : (A + B).IsSymmetric) (c : ℝ)
    (hB : ∀ x, inner ℝ (B x) x ≤ c * ‖x‖ ^ 2) (k : Fin n) :
    hAB.eigenvalues hn k ≤ hA.eigenvalues hn k + c :=
  eigenvalue_le_of_inner_le hn hA hAB c (fun x => by
    rw [LinearMap.add_apply, inner_add_left]; linarith [hB x]) k

/-- **Weyl's inequality.** If `|⟪B x, x⟫| ≤ c ‖x‖²` for every `x`, then `|λ_k(A + B) − λ_k(A)| ≤ c` for every `k`.
With `c = ‖B‖` this is the eigenvalue control of milestone 1: the spectrum of `A + tH` stays within `|t| ‖H‖` of the
spectrum of `A`, eigenvalue by eigenvalue in decreasing order. -/
theorem abs_eigenvalue_add_sub_le {A B : E →ₗ[ℝ] E} (hA : A.IsSymmetric) (hAB : (A + B).IsSymmetric) (c : ℝ)
    (hB : ∀ x, |inner ℝ (B x) x| ≤ c * ‖x‖ ^ 2) (k : Fin n) :
    |hAB.eigenvalues hn k - hA.eigenvalues hn k| ≤ c := by
  have up := eigenvalue_le_of_inner_le hn hA hAB c (fun x => by
    rw [LinearMap.add_apply, inner_add_left]; linarith [(abs_le.mp (hB x)).2]) k
  have down := eigenvalue_le_of_inner_le hn hAB hA c (fun x => by
    rw [LinearMap.add_apply, inner_add_left]; linarith [(abs_le.mp (hB x)).1]) k
  rw [abs_le]; constructor <;> linarith

omit [FiniteDimensional ℝ E] in
/-- The hypothesis of `abs_eigenvalue_add_sub_le` from an operator-norm bound. -/
theorem abs_inner_self_le (B : E →L[ℝ] E) (x : E) : |inner ℝ (B x) x| ≤ ‖B‖ * ‖x‖ ^ 2 := by
  calc |inner ℝ (B x) x| ≤ ‖B x‖ * ‖x‖ := abs_real_inner_le_norm _ _
    _ ≤ ‖B‖ * ‖x‖ * ‖x‖ := by gcongr; exact B.le_opNorm x
    _ = ‖B‖ * ‖x‖ ^ 2 := by ring

/-- **Weyl's inequality in the perturbation form milestone 1 asks for**: `|λ_k(A + tH) − λ_k(A)| ≤ |t| ‖H‖`. -/
theorem abs_eigenvalue_add_smul_sub_le {A : E →ₗ[ℝ] E} (H : E →L[ℝ] E) (t : ℝ) (hA : A.IsSymmetric)
    (hAB : (A + t • (H : E →ₗ[ℝ] E)).IsSymmetric) (k : Fin n) :
    |hAB.eigenvalues hn k - hA.eigenvalues hn k| ≤ |t| * ‖H‖ := by
  refine abs_eigenvalue_add_sub_le hn hA hAB _ (fun x => ?_) k
  have := abs_inner_self_le (t • H) x
  rwa [norm_smul, Real.norm_eq_abs] at this

end HamiltonsCubic.WeylIneq
