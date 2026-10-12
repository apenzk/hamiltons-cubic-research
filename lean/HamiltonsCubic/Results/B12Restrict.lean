import HamiltonsCubic.Results.B12Support
import HamiltonsCubic.Results.CompChar

set_option linter.style.longLine false

/-!
# B12, the restriction step: a sector's trace is the trace on the sector

[B12Sectors.lean](B12Sectors.lean) writes `tr(L_e²)` as `∑_t tr(L_e² ∘ P_t)` with `P_t` commuting
with `L_e²`. Each sector is then computed on `range P_t`, which needs `tr(A ∘ P) = tr(A|_{range P})` for an idempotent
`P` commuting with `A`. That is linear algebra on the splitting `V = range P ⊕ ker P`
(Mathlib's `IsIdempotentElem.isCompl` and `LinearMap.trace_eq_sum_trace_restrict`):

* **`trace_comp_idem`**: for `P ∘ P = P` and `A ∘ P = P ∘ A` on a finite-dimensional real space,
  `tr(A ∘ P) = tr(A|_{range P})`;
* **`projS_idem`**: the sector projectors of `weylModuleS` are idempotent, through [L120Decomp.lean](L120Decomp.lean)'s
  `proj_signMat` and [CompChar.lean](CompChar.lean)'s `proj_of_char`;
* **`trace_sector_restrict`**: so at a sign-fixed `e`, each sector term of `trace_sq_sectors` is the trace of `L_e²`
  restricted to `range P_t`.
-/

namespace HamiltonsCubic.B12Restrict

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.Results HamiltonsCubic.L120Decomp HamiltonsCubic.L120HessPair
  HamiltonsCubic.B12Sectors

section Generic

variable {V : Type*} [AddCommGroup V] [Module ℝ V] [Module.Finite ℝ V]

theorem mapsTo_range {A P : V →ₗ[ℝ] V} (hAP : A ∘ₗ P = P ∘ₗ A) :
    Set.MapsTo A (LinearMap.range P) (LinearMap.range P) := by
  rintro _ ⟨y, rfl⟩
  exact ⟨A y, by rw [← LinearMap.comp_apply, ← hAP, LinearMap.comp_apply]⟩

/-- **`tr(A ∘ P) = tr(A|_{range P})`** for an idempotent `P` commuting with `A`. -/
theorem trace_comp_idem (A P : V →ₗ[ℝ] V) (hP : P ∘ₗ P = P) (hAP : A ∘ₗ P = P ∘ₗ A) :
    LinearMap.trace ℝ V (A ∘ₗ P) = LinearMap.trace ℝ (LinearMap.range P) (A.restrict (mapsTo_range hAP)) := by
  have hid : IsIdempotentElem P := by unfold IsIdempotentElem; exact hP
  let N : Bool → Submodule ℝ V := fun b => cond b (LinearMap.range P) (LinearMap.ker P)
  have hN : DirectSum.IsInternal N :=
    (DirectSum.isInternal_submodule_iff_isCompl N (i := true) (j := false) (by decide)
      (by ext b; cases b <;> simp)).mpr (LinearMap.IsIdempotentElem.isCompl hid)
  have hmaps : ∀ b, Set.MapsTo (A ∘ₗ P) (N b) (N b) := by
    intro b
    cases b
    · intro x hx
      show A (P x) ∈ LinearMap.ker P
      have hx' : P x = 0 := hx
      rw [hx', map_zero]; exact (LinearMap.ker P).zero_mem
    · rintro _ ⟨y, rfl⟩
      exact ⟨A (P y), by simp only [LinearMap.comp_apply]; rw [← LinearMap.comp_apply P A, ← hAP]; rfl⟩
  rw [LinearMap.trace_eq_sum_trace_restrict hN hmaps, Fintype.sum_bool]
  have hker : (A ∘ₗ P).restrict (hmaps false) = 0 := by
    apply LinearMap.ext; intro x
    apply Subtype.ext
    show A (P x) = 0
    have hx' : P x = 0 := x.2
    rw [hx', map_zero]
  have hran : (A ∘ₗ P).restrict (hmaps true) = A.restrict (mapsTo_range hAP) := by
    apply LinearMap.ext; rintro ⟨_, ⟨y, rfl⟩⟩
    apply Subtype.ext
    show A (P (P y)) = A (P y)
    rw [← LinearMap.comp_apply P P, hP]
  rw [hker, map_zero, add_zero]
  exact congrArg (LinearMap.trace ℝ (LinearMap.range P)) hran

end Generic

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **The sector projectors are idempotent.** -/
theorem projS_idem (t : Finset ι) : projS t ∘ₗ projS t = projS t := by
  apply LinearMap.ext; intro Y; apply Subtype.ext
  rw [LinearMap.comp_apply, projS_coe, projS_coe]
  have h := HamiltonsCubic.CompChar.proj_of_char (u := t) (B := proj t (Y : CurvLin ι)) (fun ε hε => proj_signMat t _ ε hε) t
  rw [if_pos rfl] at h
  exact h

theorem sq_comm (e : weylModuleS ι) (he : ∀ u : Finset ι, act (diagSet u) (e : CurvLin ι) = e) (t : Finset ι) :
    (Lop e ∘ₗ Lop e) ∘ₗ projS t = projS t ∘ₗ (Lop e ∘ₗ Lop e) := by
  rw [LinearMap.comp_assoc, Lop_projS e he t, ← LinearMap.comp_assoc, Lop_projS e he t, LinearMap.comp_assoc]

/-- **Each sector term is a trace on the sector**, at a sign-fixed `e`. -/
theorem trace_sector_restrict (e : weylModuleS ι) (he : ∀ u : Finset ι, act (diagSet u) (e : CurvLin ι) = e)
    (t : Finset ι) :
    LinearMap.trace ℝ (weylModuleS ι) ((Lop e ∘ₗ Lop e) ∘ₗ projS t)
      = LinearMap.trace ℝ (LinearMap.range (projS t))
          ((Lop e ∘ₗ Lop e).restrict (fun x hx => mapsTo_range (V := weylModuleS ι) (A := Lop e ∘ₗ Lop e) (P := projS t)
            (sq_comm e he t) hx)) :=
  trace_comp_idem (V := weylModuleS ι) (Lop e ∘ₗ Lop e) (projS t) (projS_idem t) (sq_comm e he t)

end HamiltonsCubic.B12Restrict
