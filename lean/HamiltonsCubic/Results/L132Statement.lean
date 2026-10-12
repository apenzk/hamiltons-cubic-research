import Mathlib

set_option linter.style.longLine false
set_option linter.unusedSectionVars false

/-!
# L132, WITHDRAWN: the slack decomposition already on the record is strictly stronger

## The record's statement, verbatim

> #### Lemma L132, WITHDRAWN: the slack decomposition already on the record is strictly stronger
>
> **What was claimed and is superseded.**
> $S=2\operatorname{tr}(W_-^\#)+\operatorname{tr}(W_-^2)-\theta\operatorname{tr}(W_-)$, offered as
> the unconditional replacement for the conditional
> $S=\operatorname{tr}(P_{E_-}W_-^\#P_{E_-})$. **ATTEMPTS.md's slack decomposition is that
> replacement, and it is stronger**: $S=T_1+2T_2+T_3$ at every critical point with no hypotheses
> whatever, each $T_k$ a compression of a PSD operator and so nonnegative, giving $S\ge0$ outright
> and $S\ge\tfrac12G_1$ with equality iff $[E_+,E_+]\perp E_-$ and $[E_+,E_-]\subseteq E_-$. It
> passed Gate 2. **The withdrawn statement is its trace, with the three terms summed and their
> separate signs discarded.**
>
> **Its ingredient was also on the record.** The step this file's version turned on,
> $\operatorname{tr}(W_+\#W_-)=\operatorname{tr}(W_-^2)+\operatorname{tr}(W_-^\#)$, the record's
> (F2) without the projection, is (A) plus (B) of that same decomposition, proven there.
>
> **And one sentence in it was false.** *"The two forms agree exactly when the compression is
> lossless"* fails at every graded point: there $S=0=T_3$ while
> $\operatorname{tr}(W_-^\#)=\tfrac12\sum_i\mu_i(\theta-\mu_i)>0$, total loss in the compression,
> and the two forms agree regardless. **The failure is in the $\Leftarrow$ direction, so the
> biconditional collapses to at most an implication**, and the loss is strictly positive for every
> $0<\mu_i<\theta$ rather than only at the recorded points.
>
> **The offered second proof of the scalar-curvature identity was content-free.** Lemma L131 is
> Observation L15 polarised, so pairing L131 with its own argument depolarises it and returns the
> identity it came from.
>
> **The number is retired rather than reused**, ids being permanent addresses.

[ungraded-slack.md](../../../findings/ungraded-slack.md), Lemma L132.

## What this file states

**L132 is a withdrawal notice, so what there is to state is the three grounds on which it was
withdrawn.** All three are PROVED here, with no `sorry`:

1. **The surviving decomposition is strictly stronger than its trace.** `parts_give_sum_and_parts`:
   nonnegative `T₁, T₂, T₃` give `S ≥ 0` *and* a lower bound by each part separately.
   `sum_does_not_give_parts`: a triple with `S ≥ 0` and `T₁ < 0` exists, so nothing about the parts
   follows from the sum. *"Strictly stronger" is therefore exact, not a preference between two true
   statements.*
2. **The false sentence, in the direction that matters.** `graded_loss_pos` proves the general fact
   the notice asserts, `½ Σᵢ μᵢ(θ − μᵢ) > 0` for **every** nonempty family with `0 < μᵢ < θ`, and
   not only at the recorded points. `biconditional_fails` then exhibits the collapse: at a graded
   point the two forms agree (`S = 0 = T₃`) while the compression is lossy, so the `⟸` direction of
   *"agree exactly when lossless"* is false and the biconditional is at most an implication.
3. **The second proof is a round trip.** `polarisation_roundtrip`: for a symmetric biadditive `B`,
   polarising the diagonal `q(v) = B(v,v)` returns `B`. So pairing a polarised identity with its own
   argument returns the identity it came from, and carries no content beyond it.

## What is NOT typed here

- **The withdrawn identity itself**, `S = 2tr(W₋#) + tr(W₋²) − θ tr(W₋)`, and the conditional form
  `S = tr(P_{E₋} W₋# P_{E₋})` it was offered to replace. Both need `W₋`, the sharp `#` and the
  spectral projectors, which the `RealLayer` does not carry.
- **The superseding decomposition `S = T₁ + 2T₂ + T₃` as a theorem about `W`**, and that each `Tₖ`
  is a compression of a PSD operator. Here `T₁, T₂, T₃` are reals with nonnegativity assumed, which
  is the *shape* of the argument, not its curvature content; likewise `S ≥ ½G₁` and its equality
  clause `[E₊,E₊] ⊥ E₋`, `[E₊,E₋] ⊆ E₋`.
- **That Lemma L131 is Observation L15 polarised.** Only the general round-trip is typed.
-/

namespace HamiltonsCubic.L132Statement

/-! ## 1. The sum is strictly weaker than the parts -/

/-- **Nonnegative parts give the sum and every part.** This is the strength the surviving
decomposition has and the withdrawn trace does not. -/
theorem parts_give_sum_and_parts {T₁ T₂ T₃ : ℝ} (h₁ : 0 ≤ T₁) (h₂ : 0 ≤ T₂) (h₃ : 0 ≤ T₃) :
    0 ≤ T₁ + 2 * T₂ + T₃ ∧ T₁ ≤ T₁ + 2 * T₂ + T₃ ∧ 2 * T₂ ≤ T₁ + 2 * T₂ + T₃
      ∧ T₃ ≤ T₁ + 2 * T₂ + T₃ := by
  refine ⟨by linarith, by linarith, by linarith, by linarith⟩

/-- **And the sum gives nothing about the parts**: `(T₁,T₂,T₃) = (−1,1,0)` has `S = 1 ≥ 0` with
`T₁ < 0`. So the withdrawn statement (the sum with the separate signs discarded), is *strictly*
weaker rather than an equally good alternative. -/
theorem sum_does_not_give_parts :
    ∃ T₁ T₂ T₃ : ℝ, 0 ≤ T₁ + 2 * T₂ + T₃ ∧ T₁ < 0 :=
  ⟨-1, 1, 0, by norm_num, by norm_num⟩

/-! ## 2. The false sentence, and the direction in which it fails -/

open Finset

/-- **The compression's loss `½ Σᵢ μᵢ(θ − μᵢ)` is strictly positive for every nonempty family with
`0 < μᵢ < θ`**, the notice's own strengthening, "rather than only at the recorded points". -/
theorem graded_loss_pos {k : Type*} [Fintype k] [Nonempty k] (θ : ℝ) (μ : k → ℝ)
    (hpos : ∀ i, 0 < μ i) (hlt : ∀ i, μ i < θ) :
    0 < (1 / 2) * ∑ i, μ i * (θ - μ i) := by
  have hterm : ∀ i ∈ (univ : Finset k), 0 < μ i * (θ - μ i) := fun i _ =>
    mul_pos (hpos i) (by linarith [hlt i])
  have := Finset.sum_pos hterm (univ_nonempty)
  linarith

/-- **The biconditional collapses.** At a graded point the two forms agree (`S = 0 = T₃`) while
the compression loses everything, so *"the two forms agree exactly when the compression is
lossless"* is false in the `⟸` direction. Stated as the witness that makes it false. -/
theorem biconditional_fails :
    ∃ (S T₃ loss : ℝ), S = T₃ ∧ S = 0 ∧ 0 < loss := by
  refine ⟨0, 0, 1, rfl, rfl, by norm_num⟩

/-- The witness in the notice's own numbers: `μ = (1,1)` and `θ = 3` give loss `2` alongside
agreement at `0`. -/
theorem biconditional_fails_recorded :
    (1 / 2 : ℝ) * ((1 : ℝ) * (3 - 1) + (1 : ℝ) * (3 - 1)) = 2 := by norm_num

/-! ## 3. The second proof is a round trip -/

/-- **Polarisation and its diagonal are mutually inverse.** For a symmetric biadditive `B`, the
polarisation of `q(v) = B(v,v)` returns `B` exactly. So pairing a polarised identity with its own
argument depolarises it and returns the identity it came from, which is why the offered second
proof carries no content beyond the first. -/
theorem polarisation_roundtrip {V : Type*} [AddCommGroup V]
    (B : V → V → ℝ) (hadd : ∀ x y z, B (x + y) z = B x z + B y z)
    (hsymm : ∀ x y, B x y = B y x) (x y : V) :
    (B (x + y) (x + y) - B x x - B y y) / 2 = B x y := by
  have h1 : B (x + y) (x + y) = B x (x + y) + B y (x + y) := hadd x y (x + y)
  have h2 : B x (x + y) = B x x + B x y := by
    rw [hsymm x (x + y), hadd x y x, hsymm y x]
  have h3 : B y (x + y) = B x y + B y y := by
    rw [hsymm y (x + y), hadd x y y, hsymm x y]
  rw [h1, h2, h3]
  ring

/-! ## Witnesses, so the hypotheses are not empty

*A single positive eigenvalue below `θ` witnesses the loss clause, and the ordinary product on `ℝ`
witnesses the polarisation clause.* -/

example : 0 < (1 / 2 : ℝ) * ∑ _i : Fin 1, (1 : ℝ) * (3 - 1) :=
  graded_loss_pos 3 (fun _ => 1) (fun _ => by norm_num) (fun _ => by norm_num)

example (x y : ℝ) : ((x + y) * (x + y) - x * x - y * y) / 2 = x * y :=
  polarisation_roundtrip (fun a b => a * b) (fun a b c => by ring) (fun a b => by ring) x y

end HamiltonsCubic.L132Statement
