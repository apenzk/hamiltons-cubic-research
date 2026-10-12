import HamiltonsCubic.Base.RelationC

/-!
# The `#`-term split at the competitor, exactly

The record refutes a proposed `#`-term reduction by evaluating it at the padded
`W_{ℂP²}`: `⟨W, W#⟩ = 2/√6 ≈ 0.8165` against a demanded `0.2476`. *A sufficient
condition false at the equality case of its own conclusion cannot be proved.*
And [post F11](../../../findings/second-order.md) records the same split with
the same numbers: any route must treat `tr(W³)` and `⟨W,W#⟩` together.

**Stated rationally.** The tensor here has `‖W‖² = 6`, and `#` is quadratic, so
unit normalisation carries a factor `6√6`. The claim `⟨W,W#⟩ = 2/√6` is then the
rational statement `⟨W_{ℂP²}, W_{ℂP²}#⟩ = 12`, all the irrationality sitting in
the normalisation.

The three figures are pinned together: `tr(W³) = 6`, `⟨W,W#⟩ = 12`, and their
sum `P(W) = 18`, which is `√(3/2) · 6√6`.
-/

set_option linter.style.longLine false

namespace HamiltonsCubic.Base

open Matrix

set_option maxHeartbeats 1000000 in
/-- The cubic trace at the competitor, `2³ + (-1)³ + (-1)³`, and the only one of the three that
computes: a `6 × 6` product and a trace, with no `sharpQF` anywhere in it. -/
theorem WCP2_trace_cube : (WCP2 * WCP2 * WCP2).trace = 6 := by
  simp [WCP2, Matrix.trace, Matrix.diag, Matrix.mul_apply, Fin.sum_univ_six,
    Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.cons_val_two, Matrix.cons_val_three,
    Matrix.cons_val_four, cons_val_five, Matrix.vecHead, Matrix.vecTail]
  norm_num

/-- **The `#` pairing, exactly**, `2/√6` once normalised, and it **follows from criticality**: `sharpMat W = 3W - W²` read off `Q(W) = 3W`, so the
pairing is `3‖W‖² - tr W³ = 18 - 6`. *`W` is symmetric, which is what lets `Wᵀ` become `W` and
turns `tr(Wᵀ W²)` into `tr W³`.* -/
theorem WCP2_sharp_pairing : (WCP2ᵀ * sharpMat WCP2).trace = 12 := by
  have hsym : WCP2ᵀ = WCP2 := WCP2_isSymm
  have hsq : (WCP2 * WCP2).trace = 6 := by
    have h := WCP2_normSq
    rwa [hsym] at h
  have hsharp : sharpMat WCP2 = (3 : ℚ) • WCP2 - WCP2 * WCP2 := by
    have h := WCP2_critical
    unfold Qop at h
    exact eq_sub_of_add_eq' h
  rw [hsym, hsharp, Matrix.mul_sub, Matrix.trace_sub, Matrix.mul_smul, Matrix.trace_smul,
    hsq, ← Matrix.mul_assoc, WCP2_trace_cube]
  norm_num

/-- **And the value is two rewrites**, criticality giving `P = 3‖W‖²` and `‖W‖² = 6`. -/
theorem WCP2_P : Pcubic WCP2 = 18 := by
  rw [WCP2_P_from_criticality, WCP2_normSq]
  norm_num

/-- **And the split adds up**, which is what post F11 says any route must respect:
the cubic trace and the `#` pairing are not separable. -/
theorem WCP2_split :
    (WCP2 * WCP2 * WCP2).trace + (WCP2ᵀ * sharpMat WCP2).trace = Pcubic WCP2 := by
  rw [WCP2_trace_cube, WCP2_sharp_pairing, WCP2_P]
  norm_num

end HamiltonsCubic.Base
