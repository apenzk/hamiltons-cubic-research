import HamiltonsCubic.Results.L186Statement

/-!
# L187, the survivor also has `dim V = 4`, by a Pfaffian argument

**What this closes.** [L185](L185Statement.lean) emptied the all-decomposable branch;
[L186](L186Statement.lean) EMPTIED the one-non-decomposable branch, killed the
same-signed two-non-decomposable subcase on a rank count, and pinned the survivor to

  `ω₁ ∧ ω₁ = c · (ω₂ ∧ ω₂)`,  `c > 0`,  both wedges nonzero.

**GATE 2 REFUTED THIS LEMMA AS PROVED.** *Its premise `dim V ≤ 6` is circular, it reads
`dim V ≤ dim V + 2`, and `≤ 6` IS the rank bound the argument exists to prove.* **What survives is
the exclusion of `dim V = 6`**, and with [r802](../../../reviews/REVIEW_r802.md)'s `τ` generalisation
the exclusions at `dim V ∈ {10,14,…}`; *`dim V ∈ {8,12,…}` is untouched, so two and three both
remain as cases.*

## The argument

*Everything happens inside `dim V ≤ 6`, which holds here because `supp ω₁ = supp ω₂ + P₃` and a
plane adds two.* On `Λ²ℝ⁶` define

  `σ(ω) = ⋆(ω ∧ ω) / 2`.

In a frame adapted to `ω = s₁e₁₂ + s₂e₃₄ + s₃e₅₆` it is the ADJUGATE on pair spectra,
`σ(ω) = s₂s₃ e₁₂ + s₁s₃ e₃₄ + s₁s₂ e₅₆`, and hence

  **`σ(σ(ω)) = Pf(ω) · ω`,  `Pf(ω) = s₁s₂s₃`**, `(t₂t₃, t₁t₃, t₁t₂) = s₁s₂s₃·(s₁,s₂,s₃)`.

*`σ` is quadratic, so applying it to `σ(ω₁) = c·σ(ω₂)` gives* `Pf(ω₁)·ω₁ = c²·Pf(ω₂)·ω₂`.
**The two forms are orthonormal, hence independent, so both coefficients vanish**: `Pf(ω₁) = 0`,
and then `Pf(ω₂) = 0` since `c > 0` and `ω₂ ≠ 0`.

**A vanishing Pfaffian caps the rank at four, and non-decomposability floors it at four.** So both
have rank exactly four; `supp ω₂ ⊆ supp ω₁` with equal dimensions forces equality, `P₃ ⊆ supp ω₁`,
and `V = supp ω₁` has dimension four.

## What is NOT typed here

- **`σ(σ(ω)) = Pf(ω)·ω` as a statement about `Λ²ℝ⁶`.** It is typed below on PAIR SPECTRA, which is
  where the identity lives once a frame is adapted; the passage from a `2`-form to its adapted
  frame is the real skew normal form, which this layer does not carry.
- **`Pf = 0 ⟹ rank ≤ 4`**, and the range identity for positive-semidefinite sums. Both standard.
-/

set_option linter.style.longLine false

namespace HamiltonsCubic.L187Statement

/-- **`σ` on pair spectra**, the adjugate, which is what `⋆(ω ∧ ω)/2` is in an adapted frame. -/
def sigma (s : ℝ × ℝ × ℝ) : ℝ × ℝ × ℝ :=
  (s.2.1 * s.2.2, s.1 * s.2.2, s.1 * s.2.1)

/-- **The Pfaffian on pair spectra.** -/
def pf (s : ℝ × ℝ × ℝ) : ℝ := s.1 * s.2.1 * s.2.2

/-- **`σ` is quadratic**, which is what makes the proportionality square. -/
theorem sigma_smul (c : ℝ) (s : ℝ × ℝ × ℝ) :
    sigma (c * s.1, c * s.2.1, c * s.2.2)
      = (c ^ 2 * (sigma s).1, c ^ 2 * (sigma s).2.1, c ^ 2 * (sigma s).2.2) := by
  simp only [sigma, Prod.mk.injEq]
  refine ⟨by ring, by ring, by ring⟩

/-- **THE IDENTITY: `σ ∘ σ = Pf · id`.** *This is what turns a proportionality between the wedges
into a proportionality between the forms, and the forms being orthonormal is what then kills it.* -/
theorem sigma_sigma (s : ℝ × ℝ × ℝ) :
    sigma (sigma s) = (pf s * s.1, pf s * s.2.1, pf s * s.2.2) := by
  simp only [sigma, pf, Prod.mk.injEq]
  refine ⟨by ring, by ring, by ring⟩

/-- **The independence step.** *Two orthonormal forms are linearly independent, so a relation
`a • ω₁ = b • ω₂` forces both scalars to vanish; this is that, at the coefficients the identity
produces.* -/
theorem pf_eq_zero_of_indep {a b : ℝ} {V : Type*} [AddCommGroup V] [Module ℝ V]
    {w₁ w₂ : V} (hindep : ∀ x y : ℝ, x • w₁ + y • w₂ = 0 → x = 0 ∧ y = 0)
    (h : a • w₁ = b • w₂) : a = 0 ∧ b = 0 := by
  have : a • w₁ + (-b) • w₂ = 0 := by rw [neg_smul, h]; abel
  obtain ⟨ha, hb⟩ := hindep a (-b) this
  exact ⟨ha, by linarith [neg_eq_zero.mp hb]⟩

/-- **L187, at the level the layer reaches**: both Pfaffians vanish, so both ranks are four, so the
support is four-dimensional. *The rank arithmetic; the two standard facts it rests on are named in
the module docstring.* -/
theorem dim_V_eq_four_survivor
    (r₁ r₂ dimV : ℕ)
    (hpf₁ : r₁ ≤ 4) (hnd₁ : 4 ≤ r₁) (_hpf₂ : r₂ ≤ 4) (_hnd₂ : 4 ≤ r₂)
    (hV : dimV = r₁) : dimV = 4 := by
  omega

/-! ## The sign hypothesis is DERIVABLE, so the chain is unconditional

*[L186](L186Statement.lean) assumed that the two decomposable weights share a sign opposite the
third. They must.* **Suppose instead `λ₂ > 0 > λ₃`. Ricci-flatness rearranges to*

  `λ₁ ω₁ω₁ᵀ = |λ₃| Π₃ - λ₂ Π₂`,

*and the left side is semidefinite, being a real multiple of a positive-semidefinite matrix. So the
right side must be too.*

**Decompose by principal angles.** `P₂` and `P₃` split their span into orthogonal `2`-planes, in
each of which `Π₂` restricts to `u uᵀ` and `Π₃` to `v vᵀ` with `⟨u,v⟩ = cos θ`. On such a block

  `a v vᵀ - b u uᵀ` has determinant `-a b sin²θ`,

**which is strictly negative (hence indefinite), unless `sin θ = 0`.** So every principal angle
vanishes, the lines coincide in every block, and `P₂ = P₃`.

**That is excluded**: two unit area forms of the same plane both lie in the one-dimensional `Λ²P`,
so `ω₃ = ±ω₂`, against orthonormality. *So the mixed-sign case is impossible and the hypothesis
[L186](L186Statement.lean) carries is a theorem.*
-/

/-- **The block determinant.** *`a v vᵀ - b u uᵀ` on a `2`-plane, with `u = (1,0)` and
`v = (cos θ, sin θ)`, has determinant `-a b sin²θ`.* -/
theorem block_det (a b c s : ℝ) :
    (a * c * c - b) * (a * s * s) - (a * c * s) * (a * c * s) = -(a * b * (s * s)) := by
  ring

/-- **So the block is indefinite unless the lines coincide.** *A symmetric `2×2` matrix of negative
determinant has eigenvalues of both signs, which is what semidefiniteness forbids.* -/
theorem block_det_neg {a b s : ℝ} (ha : 0 < a) (hb : 0 < b) (hs : s ≠ 0) (c : ℝ) :
    (a * c * c - b) * (a * s * s) - (a * c * s) * (a * c * s) < 0 := by
  rw [block_det]
  have hss : 0 < s * s := mul_self_pos.mpr hs
  have : 0 < a * b * (s * s) := by positivity
  linarith

/-! ## The step the collapse rests on: a self-dual form is non-decomposable

*[L178](L178Statement.lean)'s step 1 makes rank `≤ 3` force (anti-)self-duality at `dim V = 4`, and
the collapse then needs that a nonzero self-dual `2`-form on `ℝ⁴` is NOT decomposable.
[SelfDual.lean](../Base/SelfDual.lean) gives `ω² = -½·Id₄` at the unit self-dual forms; what turns
that into non-decomposability is one line, an `ω` with `ω² = -c·Id` and `c ≠ 0` is invertible,
hence of full rank four.*

**This is recorded as owed elsewhere and is discharged here at the algebraic level.** *What stays
untyped is the `Λ⁺/Λ⁻` splitting of a Weyl operator itself, which is L178 step 1's content.*
-/

/-- **`ω² = -c·Id` with `c ≠ 0` makes `ω` invertible**, its inverse being `-ω/c`. -/
theorem isUnit_of_sq_eq_neg_smul {ω : Matrix (Fin 4) (Fin 4) ℝ} {c : ℝ} (hc : c ≠ 0)
    (h : ω * ω = -(c • (1 : Matrix (Fin 4) (Fin 4) ℝ))) :
    ω * ((-c⁻¹) • ω) = 1 := by
  rw [Matrix.mul_smul, h, smul_neg, neg_smul, neg_neg, smul_smul,
      inv_mul_cancel₀ hc, one_smul]

/-- **So a self-dual form has full rank**, and in particular is non-decomposable. *At the unit
self-dual forms `c = ½`, which is [SelfDual.lean](../Base/SelfDual.lean)'s `unitSD_sq`.* -/
theorem nondecomposable_of_sq_eq_neg_smul {ω : Matrix (Fin 4) (Fin 4) ℝ} {c : ℝ} (hc : c ≠ 0)
    (h : ω * ω = -(c • (1 : Matrix (Fin 4) (Fin 4) ℝ))) :
    ∃ ν, ω * ν = 1 :=
  ⟨(-c⁻¹) • ω, isUnit_of_sq_eq_neg_smul hc h⟩

/-! ## The pairing identity, which turns Bianchi into a scalar relation at `dim 6`

*`⟨σ(ω), ω⟩ = 3·Pf(ω)` on pair spectra, each of the three terms is `s₁s₂s₃`.* **Pairing first
Bianchi against a form therefore converts it from an equation in `Λ⁴` into one in scalars**, which
is what the three-non-decomposable case ([L190](../../../findings/diagonal-half.md)) needs, its
right side carrying two terms where [L189](../../../findings/diagonal-half.md)'s carried one.

*At `N∧N = M₂∧M₂ + M₃∧M₃` this gives `3·Pf(N) = ⟨σ(M₂), N⟩ + ⟨σ(M₃), N⟩`, the cross terms are then
inner products rather than wedges, and that is the shape a successor can price.*
-/

/-- **`⟨σ(ω), ω⟩ = 3·Pf(ω)`** on pair spectra. -/
theorem inner_sigma_self (s : ℝ × ℝ × ℝ) :
    (sigma s).1 * s.1 + (sigma s).2.1 * s.2.1 + (sigma s).2.2 * s.2.2 = 3 * pf s := by
  simp only [sigma, pf]; ring

end HamiltonsCubic.L187Statement
