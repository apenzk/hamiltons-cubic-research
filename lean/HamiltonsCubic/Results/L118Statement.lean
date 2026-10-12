import Mathlib
import HamiltonsCubic.Base.WeylReal

set_option linter.style.longLine false
set_option linter.unusedSectionVars false

/-!
# L118, the sectional-curvature closed forms behind post F20

## The record's statement, verbatim

> #### Lemma L118, the sectional-curvature closed forms behind post F20
>
> > **THE IDENTITY IS FORCED, NOT FITTED, AND $c_n$ WAS ALREADY IN THE RECORD.** In $n$-free form,
> > at every $n\ge4$ and every $W$,
> > $$144\,\theta=\mathbb E[N_{xy}^3]+10\,\mathbb E[N_{xy}N_{yz}N_{zx}],\qquad N_{xy}=R(x,y,x,y),$$
> > with $$c_n=\tfrac1{144}(n-1)n(n+1)(n+2)(n+3)(n+4)=[n+4]_6/144,$$ giving $1050,2310,4620$
> > exactly.
> >
> > **"ALSO FALSE AT $n=4,5$" IS REFUTED, AND BACKWARDS.** The identity **holds** there. **What
> > fails at $n=4,5$ is uniqueness, not truth.**
> >
> > **$\Phi$ IS NOT WHAT THE BLOCK SAYS IT IS.** With unit bivectors the definition forces
> > $\lvert\Phi\rvert\le1$, while **the block's own three numbers require $\Phi=14.3357$ at
> > $S^3\times S^3$.** It is the *unnormalised* Gaussian correlation,
> > $\Phi=16\langle W,W^\#\rangle-8\operatorname{tr}W^3$. **So "$\theta$ is an explicit closed form
> > in sectional-curvature moments" is overstated: $\Phi$ is not a moment of $\sec$.**
>
> $$\theta=c_n\Psi_3+\tfrac5{72}\Phi,\qquad c_n=1050,\,2310,\,4620\ \text{at}\ n=6,7,8,$$
> **Also false at $n=4,5$**, where the cubic invariants are $1$-dimensional
> ($\langle W,W^\#\rangle=2\,\mathrm{tr}\,W^3$) so $\theta=3\,\mathrm{tr}\,W^3$ and
> $\theta\propto\Psi_3$ outright. Likewise $\Psi_3=a\,\mathrm{tr}\,W^3+b\langle W,W^\#\rangle$
> with $a/b=\mathbf{-14}$ **exactly** for $n\ge6$.

[curvature-invariants.md](../../../findings/curvature-invariants.md), Lemma L118.

## What this file states

**The `n`-free form is the one stated**, because it is the one whose objects are unambiguous:
`N_{xy} = R(x,y,x,y)` against the record's own `Λ²` pairing, and both expectations taken over the
standard Gaussian on `ℝⁿ`, `Measure.pi (gaussianReal 0 1)`. `L118_identity` carries this file's
one `sorry`.

**Everything the record derives from it is proved.** `cn` is stated in the record's closed form and
evaluated at `n = 6, 7, 8` to `1050, 2310, 4620`; the passage between the `n`-free form and
`θ = c_n Ψ₃ + (5/72)Φ` is proved as the arithmetic it is; and (the substantive corollary), with
`Φ = 16⟨W,W#⟩ - 8 tr W³` the identity **forces** `E[N³] = 224 tr W³ - 16⟨W,W#⟩`, whose coefficient
ratio is `-14` exactly, which is the number the record records for `Ψ₃`. The `n = 4, 5` collapse
`θ = 3 tr W³` is proved from `⟨W,W#⟩ = 2 tr W³` at unit norm.

**Conventions.** `θ`, `tr W³ = ⟨R², R⟩` and `⟨W, W#⟩` are `HamiltonsCubic.RealLayer`'s `theta`,
`trCube` and `sharpPair`, so the `½` of the `Λ²` pairing is the record's. `wedge x y` is the
bivector `x ∧ y` in the same coordinates as `phi`, and `wedge_eq_phi` proves it agrees with `phi`
on basis vectors, so `secN` really is `R(x,y,x,y)` and not a rescaling of it.

## What is NOT typed here

**`Ψ₃` itself is not defined, and deliberately.** The record's `Ψ_k` are *normalised* moments,
related to the Gaussian moments by `E[N^k] = Ψ_k·E[g^k]` with `g` the Gram determinant, and the
record does not settle that normalisation in a form this layer can carry. Following the rule that a
convention-dependent constant is not to be guessed, only the `n`-free Gaussian form is stated, and
`theta_eq_cn_form` reads `Ψ₃` as `E[N³]/(144 c_n)` under an explicit hypothesis rather than
defining it.

**`Φ = 16⟨W,W#⟩ - 8 tr W³` is a Wick computation the record reports and this file does not prove.**
It enters `M3_closed_form` and `Phi_ratio` as the named hypothesis `hPhi`, and those two theorems
are conditional on it. *This is why the file does not claim `a/b = -14` outright.*

**Also absent**: `Ψ₁ = scal/(n(n-1))` and `Ψ₂ = 12/((n-1)n(n+1)(n+2))·‖W‖²`; the numerical
separation of `S³ × S³` from `ℂP³`; and the `Λ⁴`-dimension count behind "the cubic invariants are
`1`-dimensional at `n = 4, 5`", which is what makes the collapse's hypothesis hold there.
-/

namespace HamiltonsCubic.L118Statement

open HamiltonsCubic.RealLayer MeasureTheory ProbabilityTheory Finset

variable {n : ℕ}

/-! ## `c_n` -/

/-- **`c_n = [n+4]_6/144 = (n-1)n(n+1)(n+2)(n+3)(n+4)/144`**, Weingart's normalising falling
factorial. -/
noncomputable def cn (n : ℝ) : ℝ := (n - 1) * n * (n + 1) * (n + 2) * (n + 3) * (n + 4) / 144

theorem cn_six : cn 6 = 1050 := by unfold cn; norm_num

theorem cn_seven : cn 7 = 2310 := by unfold cn; norm_num

theorem cn_eight : cn 8 = 4620 := by unfold cn; norm_num

/-! ## `N_{xy} = R(x,y,x,y)` -/

/-- **`x ∧ y` as a bivector**, in the coordinates `phi` uses. -/
def wedge (x y : Fin n → ℝ) : Matrix (Fin n) (Fin n) ℝ := fun i j => x j * y i - x i * y j

/-- The coordinate vector. -/
def evec (a : Fin n) : Fin n → ℝ := fun i => if i = a then 1 else 0

/-- **`wedge` agrees with `phi` on basis vectors**, which is what pins the normalisation of
`secN` to the record's. -/
theorem wedge_eq_phi (a b : Fin n) : wedge (evec a) (evec b) = phi a b := by
  funext i j
  simp only [wedge, evec, phi, Matrix.sub_apply, Matrix.single_apply, mul_ite, mul_zero]
  by_cases h1 : j = a <;> by_cases h2 : i = b <;> by_cases h3 : i = a <;> by_cases h4 : j = b <;>
    subst_vars <;> simp_all [eq_comm]

/-- **`N_{xy} = R(x,y,x,y)`**, the sectional numerator, against the record's `Λ²` pairing. -/
noncomputable def secN (R : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ) (x y : Fin n → ℝ) : ℝ :=
  inner2 (R (wedge x y)) (wedge x y)

/-- The standard Gaussian on `ℝⁿ`. -/
noncomputable def gaussPi (n : ℕ) : Measure (Fin n → ℝ) :=
  Measure.pi (fun _ => gaussianReal 0 1)

/-- **`E[N_{xy}³]`**, the single-plane third moment, unnormalised. -/
noncomputable def M3 (R : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ) : ℝ :=
  ∫ x, (∫ y, (secN R x y) ^ 3 ∂(gaussPi n)) ∂(gaussPi n)

/-- **`Φ = E[N_{xy} N_{yz} N_{zx}]`**, the three-plane correlation. *The record is explicit that
this is the **unnormalised** Gaussian correlation and so is not a moment of `sec`.* -/
noncomputable def Phi3 (R : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ) : ℝ :=
  ∫ x, (∫ y, (∫ z, secN R x y * secN R y z * secN R z x ∂(gaussPi n)) ∂(gaussPi n)) ∂(gaussPi n)

/-! ## The identity -/

/-- **L118, in the `n`-free form**: at every `n ≥ 4` and every unit `W ∈ 𝒲ₙ`,
`144θ = E[N³] + 10 E[N_{xy}N_{yz}N_{zx}]`.

**This is the file's one `sorry`.** What is missing is the Wick computation behind it: that
`E[N^k]` factors as `Ψ_k · E[g^k]` by frame–Gram independence, that `E[g^k]` is Wishart, and that
Ricci-flatness kills every within-tensor Wick pairing so no `δ`-loop can produce an `n`. None of
that is on this record in a form that can be replayed here, and it is left as a `sorry` rather
than a hypothesis because it is the lemma's own content. -/
theorem L118_identity (R : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ)
    (hn : 4 ≤ n) (hW : IsWeyl R) (hunit : normSq R = 1) :
    144 * theta R = M3 R + 10 * Phi3 R := by
  sorry

/-! ## What the identity forces -/

/-- At unit norm, `θ = tr W³ + ⟨W, W#⟩`. -/
theorem theta_at_unit (R : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ)
    (hunit : normSq R = 1) : theta R = trCube R + sharpPair R := by
  have hnorm : RealLayer.norm R = 1 := by
    unfold RealLayer.norm; rw [hunit, Real.sqrt_one]
  unfold RealLayer.theta
  rw [hnorm]
  simp [Pcubic]

/-- **The record's `θ = c_n Ψ₃ + (5/72)Φ` is the `n`-free identity, divided by `144`**, once `Ψ₃`
is read as `E[N³]/(144 c_n)`. *The reading is a hypothesis, not a definition: see the file's note
on the normalisation the record does not settle.* -/
theorem theta_eq_cn_form (R : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ)
    (c Psi3 : ℝ) (hc : c ≠ 0) (hPsi : Psi3 = M3 R / (144 * c))
    (hid : 144 * theta R = M3 R + 10 * Phi3 R) :
    theta R = c * Psi3 + (5 / 72) * Phi3 R := by
  rw [hPsi]
  field_simp at hid ⊢
  linarith [hid]

/-- **The identity forces the third moment's closed form**: `E[N³] = 224 tr W³ - 16⟨W,W#⟩`.

*Conditional on `hPhi`, the record's Wick value for `Φ`, which this file does not prove.* -/
theorem M3_closed_form (R : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ)
    (hunit : normSq R = 1)
    (hid : 144 * theta R = M3 R + 10 * Phi3 R)
    (hPhi : Phi3 R = 16 * sharpPair R - 8 * trCube R) :
    M3 R = 224 * trCube R - 16 * sharpPair R := by
  rw [theta_at_unit R hunit] at hid
  rw [hPhi] at hid
  linarith [hid]

/-- **The recorded ratio `a/b = -14`**, read off the closed form. -/
theorem M3_ratio (R : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ)
    (hunit : normSq R = 1)
    (hid : 144 * theta R = M3 R + 10 * Phi3 R)
    (hPhi : Phi3 R = 16 * sharpPair R - 8 * trCube R) :
    ∃ a b : ℝ, M3 R = a * trCube R + b * sharpPair R ∧ b ≠ 0 ∧ a / b = -14 := by
  refine ⟨224, -16, ?_, by norm_num, by norm_num⟩
  rw [M3_closed_form R hunit hid hPhi]; ring

/-- **`Φ`'s own ratio is `-1/2`**, the record's second independent point of the cubic plane. -/
theorem Phi_ratio (R : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ)
    (hPhi : Phi3 R = 16 * sharpPair R - 8 * trCube R) :
    ∃ a b : ℝ, Phi3 R = a * trCube R + b * sharpPair R ∧ b ≠ 0 ∧ a / b = -(1 / 2) := by
  refine ⟨-8, 16, ?_, by norm_num, by norm_num⟩
  rw [hPhi]; ring

/-! ## The `n = 4, 5` collapse -/

/-- **At `n = 4, 5` the cubic invariants are one-dimensional**, `⟨W,W#⟩ = 2 tr W³`, and then
`θ = 3 tr W³` at unit norm.

*The record is explicit that what fails at `n = 4, 5` is uniqueness and not the identity, so this
is a collapse of the invariant space and not a failure of L118.* -/
theorem collapse_n45 (R : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ)
    (hunit : normSq R = 1) (hcol : sharpPair R = 2 * trCube R) :
    theta R = 3 * trCube R := by
  rw [theta_at_unit R hunit, hcol]; ring

/-! ## A witness, so the hypotheses are not empty

*The zero operator has `normSq = 0`, so it does not witness the unit-norm hypothesis; what is
witnessed here is the collapse hypothesis, which the zero operator satisfies, and the `c_n`
arithmetic, which is unconditional.* -/

example : sharpPair (ι := Fin n) (fun _ => 0) = 2 * trCube (ι := Fin n) (fun _ => 0) := by
  have h : Pcubic (ι := Fin n) (fun _ => 0) = 0 := Pcubic_zero
  rw [Pcubic_eq] at h
  have h2 : trCube (ι := Fin n) (fun _ => 0) = 0 := by
    simp [trCube, innerOp, compOp, inner2]
  rw [h2] at h ⊢
  linarith

example : cn 6 = 1050 ∧ cn 7 = 2310 ∧ cn 8 = 4620 := ⟨cn_six, cn_seven, cn_eight⟩

end HamiltonsCubic.L118Statement
