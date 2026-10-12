import Mathlib.Tactic

/-!
# I73 sub-step (c), section 6: eliminating the quintic correction entries

[reviews/2026-09-23-I73c-summed-pairs.md](../../../reviews/2026-09-23-I73c-summed-pairs.md), section 6.

**The claim, quoted from the note**: at three values the quintic moment $M_{22}$ enters the summed
correction of pair $(a,b)$ only through $\ell_a\ell_b$, and $p\,S_{12}+(p+q)\,S_{13}\le0$ and
$q\,S_{23}+(p+q)\,S_{13}\le0$ are free of it; every nonnegative quintic-free combination is a
nonnegative combination of these two.

## What is typed here

* `lead3` is the leading Lagrange coefficient $\ell_a$.
* `lead_signs`: $\ell_1\ell_2<0<\ell_1\ell_3$ and $\ell_2\ell_3<0$ at $\varepsilon_1<\varepsilon_2<\varepsilon_3$.
* `elim_first` and `elim_second`: the $M_{22}$ coefficient vanishes on the weights $(w_{12},w_{13},w_{23})=(p,p+q,0)$ and $(0,p+q,q)$.
* `elim_iff`: the coefficient vanishes on $(w_{12},w_{13},w_{23})$ exactly when
  $w_{13}=(p+q)(w_{12}/p+w_{23}/q)$. The split of such a nonnegative vector as $\tfrac{w_{12}}p$ times the
  first plus $\tfrac{w_{23}}q$ times the second is one line and is not typed.
* **Not typed**: the Lemma's bilinear decomposition $F(e;P_a,P_b)=\sum_{ij}[L_a]_i[L_b]_jM^F_{ij}$ and
  the summed inequalities themselves. The layer has frame projections (`proj` in L39Statement) and
  `Eigenframe` (L30Statement), and the orthogonal projection onto the Weyl module is `weylProj`
  (WeylProjection, WeylOrthogonal); what it lacks is the corrections $\Phi$ and $\Omega$.
-/

namespace HamiltonsCubic.Results

/-- The leading Lagrange coefficient `ℓ_a = ∏_{c ≠ a} (ε_a - ε_c)⁻¹` at three values. -/
noncomputable def lead3 (e1 e2 e3 : ℝ) : ℝ := 1 / ((e1 - e2) * (e1 - e3))

/-- **The quintic moment's coefficient vanishes on the first weight vector** `(w₁₂, w₁₃, w₂₃) = (p, p + q, 0)`. -/
theorem elim_first (e1 e2 e3 : ℝ) (h12 : e1 < e2) (h23 : e2 < e3) :
    (e2 - e1) * (lead3 e1 e2 e3 * lead3 e2 e1 e3)
      + (e3 - e1) * (lead3 e1 e2 e3 * lead3 e3 e1 e2) = 0 := by
  unfold lead3
  have a : e1 - e2 ≠ 0 := by linarith
  have b : e1 - e3 ≠ 0 := by linarith
  have c : e2 - e3 ≠ 0 := by linarith
  have a' : e2 - e1 ≠ 0 := by linarith
  have b' : e3 - e1 ≠ 0 := by linarith
  have c' : e3 - e2 ≠ 0 := by linarith
  field_simp
  ring

/-- **And on the second** `(0, p + q, q)`. -/
theorem elim_second (e1 e2 e3 : ℝ) (h12 : e1 < e2) (h23 : e2 < e3) :
    (e3 - e2) * (lead3 e2 e1 e3 * lead3 e3 e1 e2)
      + (e3 - e1) * (lead3 e1 e2 e3 * lead3 e3 e1 e2) = 0 := by
  unfold lead3
  have a : e1 - e2 ≠ 0 := by linarith
  have b : e1 - e3 ≠ 0 := by linarith
  have c : e2 - e3 ≠ 0 := by linarith
  have a' : e2 - e1 ≠ 0 := by linarith
  have b' : e3 - e1 ≠ 0 := by linarith
  have c' : e3 - e2 ≠ 0 := by linarith
  field_simp
  ring

/-- **The signs**: `ℓ₁ℓ₂ < 0 < ℓ₁ℓ₃` and `ℓ₂ℓ₃ < 0`, so the quintic moment enters pair `(1,3)` against
the other two. -/
theorem lead_signs (e1 e2 e3 : ℝ) (h12 : e1 < e2) (h23 : e2 < e3) :
    lead3 e1 e2 e3 * lead3 e2 e1 e3 < 0 ∧ 0 < lead3 e1 e2 e3 * lead3 e3 e1 e2 ∧
      lead3 e2 e1 e3 * lead3 e3 e1 e2 < 0 := by
  unfold lead3
  have h1 : 0 < (e1 - e2) * (e1 - e3) := by nlinarith
  have h2 : (e2 - e1) * (e2 - e3) < 0 := by nlinarith
  have h3 : 0 < (e3 - e1) * (e3 - e2) := by nlinarith
  refine ⟨?_, ?_, ?_⟩
  · exact mul_neg_of_pos_of_neg (by positivity) (by rw [one_div]; exact inv_lt_zero.mpr h2)
  · exact mul_pos (by positivity) (by positivity)
  · exact mul_neg_of_neg_of_pos (by rw [one_div]; exact inv_lt_zero.mpr h2) (by positivity)

/-- **The elimination**: at three values, with `F_ab = F̂_ab + ℓ_a ℓ_b μ` for any quintic moment `μ`,
a nonnegative combination `w₁₂ F₁₂ + w₁₃ F₁₃ + w₂₃ F₂₃` is independent of `μ` exactly when
`w₁₃ = (p+q)(w₁₂/p + w₂₃/q)`, the cone spanned by the two weight vectors above. -/
theorem elim_iff (e1 e2 e3 w12 w13 w23 : ℝ) (h12 : e1 < e2) (h23 : e2 < e3) :
    w12 * (lead3 e1 e2 e3 * lead3 e2 e1 e3) + w13 * (lead3 e1 e2 e3 * lead3 e3 e1 e2)
        + w23 * (lead3 e2 e1 e3 * lead3 e3 e1 e2) = 0
      ↔ w13 = (e3 - e1) * (w12 / (e2 - e1) + w23 / (e3 - e2)) := by
  have a : e1 - e2 ≠ 0 := by linarith
  have b : e1 - e3 ≠ 0 := by linarith
  have c : e2 - e3 ≠ 0 := by linarith
  have a' : e2 - e1 ≠ 0 := by linarith
  have b' : e3 - e1 ≠ 0 := by linarith
  have c' : e3 - e2 ≠ 0 := by linarith
  have key : w12 * (lead3 e1 e2 e3 * lead3 e2 e1 e3) + w13 * (lead3 e1 e2 e3 * lead3 e3 e1 e2)
        + w23 * (lead3 e2 e1 e3 * lead3 e3 e1 e2)
      = (lead3 e1 e2 e3 * lead3 e3 e1 e2)
          * (w13 - (e3 - e1) * (w12 / (e2 - e1) + w23 / (e3 - e2))) := by
    unfold lead3; field_simp; ring
  have hK : lead3 e1 e2 e3 * lead3 e3 e1 e2 ≠ 0 := (lead_signs e1 e2 e3 h12 h23).2.1.ne'
  rw [key, mul_eq_zero, sub_eq_zero]
  exact ⟨fun h => h.resolve_left hK, Or.inr⟩

end HamiltonsCubic.Results

#print axioms HamiltonsCubic.Results.lead_signs   -- [propext, Classical.choice, Quot.sound]
#print axioms HamiltonsCubic.Results.elim_first   -- [propext, Classical.choice, Quot.sound]
#print axioms HamiltonsCubic.Results.elim_second  -- [propext, Classical.choice, Quot.sound]
#print axioms HamiltonsCubic.Results.elim_iff     -- [propext, Classical.choice, Quot.sound]
