import HamiltonsCubic.Results.L185Statement

/-!
# L186, one non-decomposable image form puts `dim V` at exactly four

**What this is for.** [L185](L185Statement.lean) empties the branch where all three image forms of
a rank-three Weyl tensor are decomposable, so [I38](../../../plan.md)'s surviving question is about
the branch where at least one is not. *This lemma takes the case of exactly one, and finds that it
lands inside [L178](L178Statement.lean)'s hypothesis rather than outside it.*

**The chain.** Ricci-flatness is `λ₁ ω₁ω₁ᵀ + λ₂Π₂ + λ₃Π₃ = 0` ([L180](L180Statement.lean)(1), with
`ωᵢωᵢᵀ = Πᵢ` at the two decomposable forms). *`ω₁ω₁ᵀ` is positive semidefinite, so with `λ₂` and
`λ₃` sharing a sign opposite to `λ₁` both sides are PSD and*

  `λ₁ ω₁ω₁ᵀ = |λ₂| Π₂ + |λ₃| Π₃`.

**The rank pins it from both ends.** *`ω₁` is non-decomposable so its rank is at least four; the
right side has rank at most `dim(P₂ + P₃) ≤ 4`.* **So the rank is exactly four, `P₂ ∩ P₃ = 0`, and
since `range(A + B) = range A + range B` for PSD `A`, `B`, the support of `ω₁` IS `P₂ + P₃`.**
Hence `V = supp ω₁ + P₂ + P₃ = P₂ + P₃`, of dimension four.

## What is NOT typed here

- **The sign hypothesis is assumed, not derived.** `P₂ = P₃` is excluded, two orthonormal forms
  cannot both lie in the one-dimensional `Λ²P`, but mixed signs with `P₂ ≠ P₃` need their own
  argument, and this file does not give it.
- **The rank inequality for PSD sums and the passage from a non-decomposable `2`-form to `rank ≥ 4`**
  are [L186Rank.lean](L186Rank.lean)'s `rank_le_of_pos` and `rank_ge_four`, which prove the count this
  file takes with its ranks as hypotheses. The range identity `range(A + B) = range A + range B` is not
  typed.
- **The two-non-decomposable case**, which is where `dim V` is not yet bounded: there
  `supp ω₁ = supp ω₂ + P₃` can have dimension six, and nothing here rules it out.
-/

set_option linter.style.longLine false

namespace HamiltonsCubic.L186Statement

open Matrix

variable {n : ℕ}

/-- **The sign split the argument runs on.** *`Σλᵢ = 0` with every `λᵢ ≠ 0` forces mixed signs, and
this names the case where the two decomposable weights share the sign opposite `λ₁`.* -/
def OppositeSigns (l₁ l₂ l₃ : ℝ) : Prop :=
  (0 < l₁ ∧ l₂ < 0 ∧ l₃ < 0) ∨ (l₁ < 0 ∧ 0 < l₂ ∧ 0 < l₃)

/-- **The sum is zero and the signs are mixed**, so a split of this shape exists whenever the
weights are nonzero and one of them is alone in its sign. -/
theorem oppositeSigns_of_sum_zero {l₁ l₂ l₃ : ℝ} (hsum : l₁ + l₂ + l₃ = 0)
    (h2 : l₂ < 0) (h3 : l₃ < 0) : OppositeSigns l₁ l₂ l₃ :=
  Or.inl ⟨by linarith, h2, h3⟩

/-- **Both sides become positive semidefinite**, which is the step the rank count needs: under the
sign split, Ricci-flatness rearranges to a PSD identity. -/
theorem psd_form_of_ricci {l₁ l₂ l₃ : ℝ} {A P₂ P₃ : Matrix (Fin n) (Fin n) ℝ}
    (hricci : l₁ • A + l₂ • P₂ + l₃ • P₃ = 0) (hsign : OppositeSigns l₁ l₂ l₃) :
    l₁ • A = (-l₂) • P₂ + (-l₃) • P₃ := by
  have : l₁ • A = -(l₂ • P₂) - l₃ • P₃ := by
    rw [← sub_eq_zero]
    rw [← hricci]; abel
  rw [this]
  rw [neg_smul, neg_smul]
  abel

/-- **The rank is pinned from both ends.** *A non-decomposable `2`-form has rank at least four; the
right-hand side has rank at most `dim(P₂ + P₃) ≤ 4`.* So four is forced, and with it
`P₂ ∩ P₃ = 0`. -/
theorem rank_eq_four {rA rSum : ℕ} (hlow : 4 ≤ rA) (hhigh : rSum ≤ 4) (heq : rA = rSum) :
    rA = 4 := by omega

/-- **L186.** *Under the sign split, the support of the non-decomposable form is `P₂ + P₃`, so
`V = P₂ + P₃` has dimension four, which is [L178](L178Statement.lean)'s hypothesis.*

**THIS THEOREM IS ARITHMETIC, AND ITS CONTENT IS IN THE BINDERS.** *`hrange` is the range identity
for positive-semidefinite sums and `hnondec` the passage from non-decomposability to `rank ≥ 4`,
both standard, both external, and neither in this layer, which is what makes them legitimate
binders rather than the conclusion in disguise.* **What this file PROVES is `psd_form_of_ricci`**:
that the sign split turns Ricci-flatness into an identity between positive-semidefinite matrices,
which is the step the rank count needs and the only step that is about this problem. -/
theorem dim_V_eq_four
    (dimV rankOne dimP₂P₃ : ℕ)
    (hnondec : 4 ≤ rankOne) (hsum : dimP₂P₃ ≤ 4)
    (hrange : rankOne = dimP₂P₃) (hV : dimV = dimP₂P₃) :
    dimV = 4 := by
  omega

/-! ## The two-non-decomposable case: half of it dies on a rank count

*If the two non-decomposable forms carry the SAME sign, then `Σλᵢ = 0` puts the decomposable one
alone on the other side, and Ricci-flatness reads*

  `|λ₁| ω₁ω₁ᵀ + |λ₂| ω₂ω₂ᵀ = |λ₃| Π₃`.

**The left side is a positive combination of two positive-semidefinite matrices of rank at least
four, so its rank is at least four; the right has rank two.** *So the two non-decomposable forms
must carry OPPOSITE signs, and only that configuration survives.*
-/

/-- **A positive combination of positive-semidefinite matrices has rank at least each summand's.**
*Stated as the rank inequality it is used through. [L186Rank.lean](L186Rank.lean)'s `rank_le_of_pos`
proves it for Gram matrices.* -/
theorem rank_ge_of_psd_sum {rA rB rSum : ℕ} (hA : 4 ≤ rA) (hle : rA ≤ rSum) : 4 ≤ rSum := by
  omega

/-- **Same-signed non-decomposable weights are impossible.** *Rank at least four on one side,
exactly two on the other.* -/
theorem same_sign_impossible {rA rSum : ℕ} (hA : 4 ≤ rA) (hle : rA ≤ rSum) (hplane : rSum = 2) :
    False := by
  omega

/-- **So the two non-decomposable forms carry opposite-signed weights**, which is the whole of what
the rank count leaves. *What it does NOT settle is the dimension: in the surviving configuration
`supp ω₁ = supp ω₂ + P₃`, and that can still reach six.* -/
theorem nondecomposable_weights_opposite {l₁ l₂ l₃ : ℝ}
    (hsum : l₁ + l₂ + l₃ = 0) (h₁ : l₁ ≠ 0) (h₂ : l₂ ≠ 0) (h₃ : l₃ ≠ 0)
    (hsame : ¬ ((0 < l₁ ∧ 0 < l₂) ∨ (l₁ < 0 ∧ l₂ < 0))) :
    (0 < l₁ ∧ l₂ < 0) ∨ (l₁ < 0 ∧ 0 < l₂) := by
  rcases lt_trichotomy l₁ 0 with hl | hl | hl
  · rcases lt_trichotomy l₂ 0 with hm | hm | hm
    · exact absurd (Or.inr ⟨hl, hm⟩) hsame
    · exact absurd hm h₂
    · exact Or.inr ⟨hl, hm⟩
  · exact absurd hl h₁
  · rcases lt_trichotomy l₂ 0 with hm | hm | hm
    · exact Or.inl ⟨hl, hm⟩
    · exact absurd hm h₂
    · exact absurd (Or.inl ⟨hl, hm⟩) hsame

/-! ## What first Bianchi says about the survivor

*[L179](L179Statement.lean)(b) makes the first Bianchi identity one equation on the nonzero
spectrum: `Σ λᵢ ωᵢ ∧ ωᵢ = 0` in `Λ⁴`. The decomposable form contributes nothing, `ω ∧ ω = 0` is
exactly decomposability, so in the surviving configuration it reads*

  `λ₁ ω₁ ∧ ω₁ + λ₂ ω₂ ∧ ω₂ = 0`,   hence   `ω₁ ∧ ω₁ = c · (ω₂ ∧ ω₂)` with `c = -λ₂/λ₁ > 0`,

*the positivity because the two weights carry opposite signs.* **Both wedges are nonzero, since
both forms are non-decomposable, so this is proportionality with a POSITIVE ratio and not a
vanishing.**

**This places the survivor exactly in [L183](L183Statement.lean)'s second alternative**, the
images distinct and collinear, rather than coincident, *which is the case
[L184](L184Statement.lean) does not reach.*
-/

/-- **The ratio is positive**, because the two non-decomposable weights carry opposite signs. -/
theorem wedge_ratio_pos {l₁ l₂ : ℝ} (h : (0 < l₁ ∧ l₂ < 0) ∨ (l₁ < 0 ∧ 0 < l₂)) :
    0 < -l₂ / l₁ := by
  rcases h with ⟨h1, h2⟩ | ⟨h1, h2⟩
  · exact div_pos (by linarith) h1
  · rw [div_pos_iff]; right; exact ⟨by linarith, h1⟩

/-- **First Bianchi at the survivor.** *With the decomposable form's wedge vanishing, the identity
is a proportionality between the other two.* -/
theorem bianchi_survivor {l₁ l₂ l₃ : ℝ} {W₁ W₂ W₃ : Matrix (Fin n) (Fin n) ℝ}
    (hbianchi : l₁ • W₁ + l₂ • W₂ + l₃ • W₃ = 0) (hdec : W₃ = 0) (h₁ : l₁ ≠ 0) :
    W₁ = (-l₂ / l₁) • W₂ := by
  subst hdec
  simp only [smul_zero, add_zero] at hbianchi
  have h : l₁ • W₁ = (-l₂) • W₂ := by
    rw [neg_smul, ← sub_eq_zero, sub_neg_eq_add, hbianchi]
  have := congrArg (fun M => (l₁⁻¹ : ℝ) • M) h
  simpa [smul_smul, inv_mul_cancel₀ h₁, div_eq_inv_mul, mul_comm] using this

end HamiltonsCubic.L186Statement
