import Mathlib
import HamiltonsCubic.Results.SpTorusBlocks
import HamiltonsCubic.Results.SpTorusEqualWeight

/-!
# `𝔰𝔭(2)`'s torus family has exactly one positive idempotent, `I/3`

[The I117 working note](../../../reviews/2026-09-28l-I117-g2-torus.md). At `k = 2` the sums over a
third index are empty, so the `p`- and `q`-rows read `p(1 - X⁻) = (u₀ + u₁) q` and
`q(1 - X⁺) = (u₀ + u₁) p`. Their difference is `(p - q)(1 - m + u₀ + u₁ - (p + q)²/2) = 0`, and the
long rows make the bracket positive, so `p = q`; [L285] (`equal_weight_torus`) then gives the
uniform point.

**Typed**: `sp2_unique`, from `TorusRows` at `k = 2` with positive weights. **Not typed**: the rows
from `C # C = C` (Gate 2 [r1888], [r1889]).
-/

namespace HamiltonsCubic.Sp2Torus

open HamiltonsCubic.SpTorusBlocks Matrix

/-- **The only positive solution of `𝔰𝔭(2)`'s torus rows is the uniform one.** -/
theorem sp2_unique (P Q : Matrix (Fin 2) (Fin 2) ℝ) (u a : Fin 2 → ℝ) (h : TorusRows P Q u a)
    (hu : ∀ i, 0 < u i) (hp01 : 0 < P 0 1) (hq01 : 0 < Q 0 1) :
    (∀ i, u i = 1 / 3) ∧ P 0 1 = 1 / 3 ∧ Q 0 1 = 1 / 3 := by
  have hP00 := h.diagP 0; have hP11 := h.diagP 1
  have hQ00 := h.diagQ 0; have hQ11 := h.diagQ 1
  have hP10 : P 1 0 = P 0 1 := h.symP 1 0
  have hQ10 : Q 1 0 = Q 0 1 := h.symQ 1 0
  -- the rows at k = 2
  have hp := h.hp 0 1 (by decide)
  have hq := h.hq 0 1 (by decide)
  have ha0 := h.ha 0
  have ha1 := h.ha 1
  have hl0 := h.hlong 0
  have hl1 := h.hlong 1
  simp only [Fin.sum_univ_two, hP00, hP11, hQ00, hQ11, hP10, hQ10] at hp hq ha0 ha1 hl0 hl1
  set p := P 0 1 with hpdef
  set q := Q 0 1 with hqdef
  have hu0 := hu 0
  have hu1 := hu 1
  -- the long rows: a_i < 1/2 and the bound on (p+q)^2
  have hpq : 0 < p * q := mul_pos hp01 hq01
  have ha0lt : a 0 < 1 / 2 := by nlinarith
  have ha1lt : a 1 < 1 / 2 := by nlinarith
  have hB : 0 < 1 - (a 0 + a 1) / 2 + u 0 + u 1 - (p + q) ^ 2 / 2 := by nlinarith
  have hdiff : (p - q) * (1 - (a 0 + a 1) / 2 + u 0 + u 1 - (p + q) ^ 2 / 2) = 0 := by
    linear_combination hp - hq
  have hpq' : Q = P := by
    have heq : q = p := by
      rcases mul_eq_zero.mp hdiff with h0 | h0
      · linarith
      · linarith
    ext i j
    fin_cases i <;> fin_cases j <;> simp [hP00, hP11, hQ00, hQ11, hP10, hQ10, ← hpdef, ← hqdef, heq]
  have hsym : Pᵀ = P := by
    ext i j; exact h.symP j i
  have hpos : ∀ i j, i ≠ j → 0 < P i j := by
    intro i j hij
    fin_cases i <;> fin_cases j <;> simp_all
  have hres := HamiltonsCubic.SpTorusEqualWeight.equal_weight_torus P Q u a hpq' hsym h.diagP hpos
    hu h.ha h.hlong h.hp
  have h01 := hres.2 0 1 (by decide)
  refine ⟨fun i => ?_, ?_, ?_⟩
  · have := hres.1 i; norm_num at this; exact this
  · have := h01.1; norm_num at this; exact this
  · have := h01.2; norm_num at this; exact this

end HamiltonsCubic.Sp2Torus
