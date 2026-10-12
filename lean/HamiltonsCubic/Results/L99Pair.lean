import HamiltonsCubic.Results.L99Statement

set_option linter.style.longLine false

/-!
# L99's pairing in the harmonic-square scaling

[diagonal-half.md](../../../findings/diagonal-half.md), Lemma L99: *"`⟨N, M⟩ = θ² Σ_c a_c θ_c⁻²` over the EDGE-CARRYING
components."* [L99Statement.lean](L99Statement.lean)'s `innerOp_indDir` gives `⟨N, M⟩ = ½ Σ_γ a_γ ‖M^{(γ)}‖²` with
`‖M^{(γ)}‖²` the block's Frobenius mass. The block `γ` of `M = ⊕ λ_γ M_γ` over unit `M_γ` has mass `2λ_γ²` (the
pairing's `½` being the ordered-pair doubling), and the per-block relation `λ_γ² θ_γ = θ λ_γ` forces `λ_γ θ_γ = θ` at
every edge-carrying block (`scaling_forced`, applied inside the proof). This file composes the two:

* **`inner_harmonic`**: `⟨N, M⟩ = θ² Σ_{γ carrying an edge} a_γ θ_γ⁻²`, the blocks carrying no edge contributing
  nothing whatever their `a_γ`.

*Reading not typed*: that `θ_γ` is the block's own critical value, so that `Q(M_γ) = θ_γ M_γ` gives the per-block
relation, which [L99Statement.lean](L99Statement.lean) records as built nowhere in the layer.
-/

namespace HamiltonsCubic.L99Statement

open Finset HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer

variable {ι : Type*} [Fintype ι] [DecidableEq ι] {C : Type*} [Fintype C] [DecidableEq C]

open Classical in
/-- **`⟨N, M⟩ = θ² Σ_γ a_γ θ_γ⁻²` over the edge-carrying blocks**, when each block has mass `2λ_γ²` and satisfies
the per-block criticality relation `λ_γ² θ_γ = θ λ_γ`, which `scaling_forced` turns into `λ_γ θ_γ = θ` wherever the
block carries an edge. -/
theorem inner_harmonic {w : Matrix ι ι ℝ} {part : ι → C} (hw : IsWeight w) (hs : SplitsAlong w part)
    (a : C → ℝ) {lam th : C → ℝ} {θ : ℝ} (hmass : ∀ γ, blockNormSq w part γ = 2 * lam γ ^ 2)
    (hblock : ∀ γ, lam γ ^ 2 * th γ = θ * lam γ) (hth : ∀ γ, th γ ≠ 0) :
    innerOp (diagOp (indDir w part a)) (diagOp w)
      = θ ^ 2 * ∑ γ ∈ univ.filter (fun γ => CarriesEdge w part γ), a γ / th γ ^ 2 := by
  rw [innerOp_indDir hw hs a]
  have hterm : ∀ γ, a γ * blockNormSq w part γ = if CarriesEdge w part γ then 2 * θ ^ 2 * (a γ / th γ ^ 2) else 0 :=
    fun γ => by
      by_cases hc : CarriesEdge w part γ
      · rw [if_pos hc, hmass γ]
        -- an edge-carrying block has positive mass, so `λ_γ ≠ 0`, and `scaling_forced` gives `λ_γ θ_γ = θ`
        have hl0 : lam γ ≠ 0 := by
          intro h0
          have := blockNormSq_pos hc
          rw [hmass γ, h0] at this; norm_num at this
        have hscale := scaling_forced hblock γ hl0
        have hl : lam γ = θ / th γ := by rw [← hscale]; field_simp [hth γ]
        rw [hl]; field_simp [hth γ]
      · rw [if_neg hc]
        have h0 : blockNormSq w part γ = 0 := by
          unfold blockNormSq
          refine Finset.sum_eq_zero fun x _ => Finset.sum_eq_zero fun y _ => ?_
          split_ifs with hx
          · have : w x y = 0 := by by_contra hne; exact hc ⟨x, y, hx, hne⟩
            rw [this]; ring
          · rfl
        rw [h0, mul_zero]
  simp only [hterm, Finset.sum_ite, Finset.sum_const_zero, add_zero, ← Finset.mul_sum]
  ring

end HamiltonsCubic.L99Statement
