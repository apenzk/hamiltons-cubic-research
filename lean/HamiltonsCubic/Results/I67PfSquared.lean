import HamiltonsCubic.Results.I67Pf6
import HamiltonsCubic.Results.L193Statement
import HamiltonsCubic.Results.I67PfSign

set_option linter.style.longLine false

/-!
# I67: `Pf(X)² = det X` on `ℝ⁶`, and the input `StarWedgeIdentity` needed

[L193](L193Statement.lean)'s `starWedge_of_pf` derives `StarWedgeIdentity` from ONE input:
`pf6 J = 1 ∨ pf6 J = -1` at every complex structure `J`. **That input is PROVED, in
[I67PfSign.lean](I67PfSign.lean), by orthogonal normal form**, and `pf6_complex_structure` below
now cites it. *The classical identity `pf_sq_eq_det` stays `sorry`'d here as a statement of its
own, off the path `StarWedgeIdentity` takes.*

## The route, and why the previous trick does not obviously transfer

*`pf6 J = ±1` follows from `Pf(X)² = det X` at skew `X` together with `det J = 1`.* **Mathlib
carries no Pfaffian and its `det_fin_*` lemmas stop at `Fin 3`**, so `det` at `Fin 6` is a
`720`-term expansion, which is the same order as the `6⁶` wall that closed three routes to `pf6`.

**The reindexing that got past that wall does not obviously apply here.** *`star_wedge_pairing`
works because both sides are contractions against `levi6`, so relabelling bound variables relates
them; `det` is a sum over permutations of a DIFFERENT shape, and no relabelling of `pf6`'s six
slots produces it.* So this is named as owed rather than attempted-and-failed.

## What the two halves actually need, which is NOT the same thing

**`det_complex_structure` needs no expansion at all and is proved below.** *An earlier version of
this docstring said both propositions were blocked by the `720`-term expansion. That is true of
`pf_sq_eq_det` and false of `det J = 1`, whose content is structural*: `J² = -Id` gives
`(det J)² = 1` in three rewrites, and the SIGN comes from a connectedness argument that never looks
at an entry.

**`pf_sq_eq_det` stays owed**, and the reason is the library rather than the mathematics: Mathlib
carries no Pfaffian and its `det_fin_*` lemmas stop at `Fin 3`.
-/

namespace HamiltonsCubic.I67PfSquared

open HamiltonsCubic.SelfDualLayer HamiltonsCubic.RealLayer

/-- **THE DETERMINANT OF THE PROVED ADJUGATE LAW, WHICH COSTS ONE LINE.** *`adjugate_law` gives
`X · σ₆(X) = -Pf(X)·Id` at every skew `X`, so taking determinants gives this with no expansion.* -/
theorem det_mul_det_sigma6 (X : Matrix (Fin 6) (Fin 6) ℝ) (hX : IsSkew X) :
    X.det * (HamiltonsCubic.L193Statement.sigma6 X).det = pf6 X ^ 6 := by
  have h := congrArg Matrix.det (HamiltonsCubic.L193Statement.adjugate_law X hX)
  rw [Matrix.det_mul, Matrix.det_smul, Matrix.det_one, mul_one, Fintype.card_fin] at h
  rw [h]; ring

set_option maxHeartbeats 0 in
set_option maxRecDepth 100000 in
/-- **The skew `6×6` determinant is the square of the fifteen-term Pfaffian**, by expansion. -/
theorem det_skew6 (a b c d e f g h i j k l m n o : ℝ) :
    (!![0, a, b, c, d, e; -a, 0, f, g, h, i; -b, -f, 0, j, k, l; -c, -g, -j, 0, m, n;
        -d, -h, -k, -m, 0, o; -e, -i, -l, -n, -o, 0] : Matrix (Fin 6) (Fin 6) ℝ).det =
      (a*j*o - a*k*n + a*l*m - b*g*o + b*h*n - b*i*m + c*f*o - c*h*l + c*i*k - d*f*n + d*g*l
        - d*i*j + e*f*m - e*g*k + e*h*j) ^ 2 := by
  simp only [Matrix.det_succ_row_zero, Fin.sum_univ_succ, Matrix.submatrix_apply,
    Matrix.of_apply, Matrix.cons_val', Matrix.cons_val_zero, Matrix.cons_val_succ,
    Matrix.empty_val', Matrix.cons_val_fin_one, Fin.succAbove_zero, Fin.succ_succAbove_zero,
    Fin.succ_succAbove_succ, Fin.zero_succAbove, Matrix.det_unique, Fin.sum_univ_zero,
    Fin.default_eq_zero, pow_zero, pow_succ, Fin.val_zero, Fin.val_succ]
  ring

/-- **`Pf(X)² = det X` at every skew `X` on `ℝ⁶`.** *The classical identity.*

**WHAT IT ACTUALLY OWES IS ONE FACT, NOT A `720`-TERM EXPANSION**, which is what the docstring
here claimed before the adjugate law was proved. *`det_mul_det_sigma6` above gives
`det X · det σ₆(X) = Pf(X)⁶` from the proved law in one line, so the identity follows from*
`det σ₆(X) = Pf(X)⁴` *and from nothing else.*

*Both sides of that remaining fact are degree-12 polynomials in the fifteen free entries, where the
determinant of `X` itself is degree 6.*

**THE REDUCTION IS VALID AND IT IS NOT OBVIOUSLY CHEAPER, WHICH A FIRST VERSION OF THIS NOTE
CLAIMED.** *It said the old price was `of the WRONG object`. The degrees differ as stated, and they
point the other way on cost: `det σ₆(X)` is a six-by-six determinant whose entries are QUADRATIC,
so its expansion carries the same `720` terms at twice the degree, where `det X` has linear
entries.* **So this is a SECOND ROUTE rather than a cheaper one**, and what the round actually
established is that the identity follows from the proved adjugate law at all, which the file did
not record. **THE EXPANSION IS AFFORDABLE AND THE SKEWNESS SUBSTITUTION IS NOT, WHICH REVERSES WHAT THE
PARAGRAPH BELOW FIRST RECORDED.** *With [Sharp.lean](../Base/Sharp.lean)'s unfold set, the
`Fin.sum_univ_six` family down the chain rather than `Fin.sum_univ_succ`, plus `cons_val_two`,
`cons_val_three`, `vecHead` and `vecTail`, and a PER-CALL `maxSteps`, `X.det` expands in about
eight seconds.* **What then fails is applying `X j i = -X i j`.**

**AND IT FAILS BECAUSE THAT REWRITE LOOPS AGAINST ITSELF.** *Applied to `X i j` it gives `-X j i`,
and applied to that it gives `-(-X i j)`, which is why folding it into the expansion made the run
WORSE rather than better.* **So skewness cannot enter as a rewrite RULE in this orientation**, and
the staging question is about it rather than about the determinant. *What that leaves, untried:
substitute the thirty-six entries in terms of the fifteen free ones, so skewness is consumed by the
SUBSTITUTION and never rewritten.*

**AND THE SKEWNESS BLOCKER IS SOLVED, LEAVING ONLY `ring`.** *Fifteen DIRECTED equations,
`X j i = -X i j` for `j > i` only, consume skewness by substitution and cannot rewrite back, so the
loop that defeated the rule form is gone.* **With them the proof reaches its final `ring` and fails
only there**, at `isDefEq`, on a degree-`6` identity in the fifteen free entries.

**THAT LAST STEP MUST BE STAGED AND NOT BOUGHT, AND THE COST OF LEARNING SO WAS REAL.** *Raising
`maxHeartbeats` to `40000000` ran for over five minutes at `1.9 GB` and took the editor's Lean
server down with it. An optimisation whose cost is unknown before it starts is exactly what the
analysis-only rule says to name and stop on, and this one was begun as a two-minute check and grown
one raise at a time, which is how a bounded check becomes an unbounded one with no single step
looking wrong.* **A successor stages the final identity, for instance by proving the expanded
determinant equal to a named polynomial and the squared Pfaffian equal to the same one**, so that
no single `ring` sees the whole term.

## A SECOND ROUTE TO THE SAME INPUT, WHICH NEVER EXPANDS ANYTHING, 2026-09-23

*The downstream consumer needs `pf6 J = 1 ∨ pf6 J = -1` at a complex structure, NOT the general
identity `Pf(X)² = det X`. Those are different obligations and only the first is owed.*

**The route.** A Pfaffian is `O(n)`-equivariant, `Pf(Q X Qᵀ) = det Q · Pf X`, and every complex
structure on `ℝ⁶` **that is also SKEW**, which this record's `IsComplexStructure` carries as a
field, is orthogonally conjugate to the standard block-diagonal `J₀` built from three copies of
the `2×2` rotation by a quarter turn. *Read without the skewness clause the sentence is false*
([r1085](../../../reviews/REVIEW_r1085.md)). So `pf6 J = det Q · pf6 J₀` with `det Q = ±1`, and
`pf6 J₀` is one evaluation on a matrix with four zeros in every row. **Nothing here is a `720`-term
expansion**, and the orthogonality the argument needs is already on file as
`IsComplexStructure.orthogonal` in [SelfDual.lean](../Base/SelfDual.lean).

**The route is COMPLETE**: `pf6_conj` in [Pfaffian6Conj.lean](../Base/Pfaffian6Conj.lean) and
`complexStructure_normalForm` with `pf6_stdJ6` in [I67PfSign.lean](I67PfSign.lean).

**The staged expansion below remains the route to the general identity**, which the equivariance
route does not reach, since a general skew matrix needs a normal form with unequal blocks. *The
input the chain needs is proved, and only the general identity is blocked, on staging.*

**THE PARAGRAPH BELOW IS SUPERSEDED AND IS KEPT FOR ITS CAUSE**, which is that three of its runs
had their declaration options misplaced BETWEEN THE DOCSTRING AND THE THEOREM, where they do not
attach, so each measured a default ceiling rather than the raised one. *[Sharp.lean](../Base/Sharp.lean)
records a route closed the same way, from one attempt, and later reopened.*

**THE SUPERSEDED PRICE.** *Expanding
`X.det` by `Matrix.det_succ_row_zero` and substituting skewness hits THREE ceilings in sequence:
`simp`'s own `maxSteps`, then `maxRecDepth`, which does not yield at `100000`. The binding
constraint is not TIME: the refusals came back in about six seconds each.*

**SO THE OPEN QUESTION IS NOT `which expansion is cheaper` BUT `can either be STAGED`**, since a
monolithic call is what fails. *The layer's own precedent is [Sharp.lean](../Base/Sharp.lean),
retired by emitting a certificate `norm_num` checks rather than asking the kernel to evaluate, and
by unfolding with `Fin.sum_univ_six` rather than `Fin.sum_univ_succ` so an index match meets
literal indices.* **Both of those apply here and neither was tried.**

**THE LIBRARY CARRIES NEITHER HALF, CHECKED 2026-09-22 AND STATED AS NAMES A GREP WOULD FIND.**
*`Pfaffian` and `pfaffian` appear in NO file of the pinned Mathlib, so `pf6` here is the only
Pfaffian in the build and `pf_sq_eq_det` cannot be a wrapper. And Mathlib's determinant files carry
no lemma keyed to `J * J = -1`: `det_eq_one_of_card_eq_zero` is the only `det_eq_one*` name, and it
is about the empty index type.* **So both halves of [StarWedgeIdentity](../Base/SelfDual.lean) were
built in-house**, the Pfaffian sign by the equivariance route in [I67PfSign.lean](I67PfSign.lean).

*What is NOT missing, and was nearly rewritten here*: `IsComplexStructure.orthogonal` already
proves `JᵀJ = 1` in [SelfDual.lean](../Base/SelfDual.lean), from `Jᵀ = -J` and `J * J = -1`.
-/
theorem pf_sq_eq_det (X : Matrix (Fin 6) (Fin 6) ℝ) (hX : IsSkew X) :
    pf6 X ^ 2 = X.det := by
  have hs : ∀ a b : Fin 6, X b a = -X a b := by
    intro a b; have := congrFun (congrFun hX a) b
    simpa [Matrix.transpose_apply] using this
  have hd : ∀ a : Fin 6, X a a = 0 := by
    intro a; have := hs a a; linarith
  have hX' : X = !![0, X 0 1, X 0 2, X 0 3, X 0 4, X 0 5;
      -X 0 1, 0, X 1 2, X 1 3, X 1 4, X 1 5; -X 0 2, -X 1 2, 0, X 2 3, X 2 4, X 2 5;
      -X 0 3, -X 1 3, -X 2 3, 0, X 3 4, X 3 5; -X 0 4, -X 1 4, -X 2 4, -X 3 4, 0, X 4 5;
      -X 0 5, -X 1 5, -X 2 5, -X 3 5, -X 4 5, 0] := by
    ext p q
    fin_cases p <;> fin_cases q <;>
      simp [hd, hs 0 1, hs 0 2, hs 0 3, hs 0 4, hs 0 5, hs 1 2, hs 1 3, hs 1 4, hs 1 5,
        hs 2 3, hs 2 4, hs 2 5, hs 3 4, hs 3 5, hs 4 5]
  rw [HamiltonsCubic.I67Pf6.pf6_eq X hX]
  conv_rhs => rw [hX']
  rw [det_skew6]

/-! ### `det J = 1`, in four steps and no expansion

**A SECOND ROUTE, AND ITS SPLIT IS CHECKED AGAINST THE LIBRARY, 2026-09-23.** *`det J = 1` needs
no Pfaffian at all: `J² = -1` makes the minimal polynomial `X² + 1`, the characteristic polynomial
is then `(X² + 1)³` at size six, and `det J = p(0) = 1`.*

**What Mathlib HAS, by name**: `Matrix.minpoly_dvd_charpoly` in
`LinearAlgebra/Matrix/Charpoly/Minpoly.lean`, and `Matrix.det_eq_sign_charpoly_coeff` in
`Charpoly/Coeff.lean`, which is `det M = (-1)^(card n) * M.charpoly.coeff 0`.

**What it LACKS**: the step from `minpoly = X² + 1` to `charpoly = (X² + 1)³`, which needs that
`charpoly`'s irreducible factors are `minpoly`'s; and any complex-structure normal form, a grep for
`J * J = -1` over `LinearAlgebra/` returning nothing. *So the route is real and its gap is one
named classical fact rather than a computation.*

*Stated as names a grep re-checks in one command, because four blockers in this layer turned out
stale when checked that way.*

*The square is three rewrites. The sign is the content, and it is a connectedness argument*: the
family `cos t · I + sin t · J` is invertible at every `t` because it is inverted by
`cos t · I - sin t · J`, so its determinant never vanishes; it runs continuously from `det I = 1` at
`t = 0` to `det J` at `t = π/2`, and a continuous nowhere-zero path cannot change sign. -/

/-- **`(det J)² = 1`**, from `det(J·J) = det(-1) = (-1)⁶`. -/
theorem det_sq_eq_one {J : Matrix (Fin 6) (Fin 6) ℝ} (hJ : J * J = -1) : J.det ^ 2 = 1 := by
  have h : J.det * J.det = 1 := by
    rw [← Matrix.det_mul, hJ, Matrix.det_neg, Matrix.det_one]
    norm_num
  nlinarith [h]

/-- **The rotation family is inverted by its own conjugate**, since `J² = -Id` turns
`cos²t · I - sin²t · J²` into `(cos²t + sin²t) · I`. -/
theorem rot_mul_rot {J : Matrix (Fin 6) (Fin 6) ℝ} (hJ : J * J = -1) (t : ℝ) :
    (Real.cos t • (1 : Matrix (Fin 6) (Fin 6) ℝ) + Real.sin t • J)
      * (Real.cos t • (1 : Matrix (Fin 6) (Fin 6) ℝ) - Real.sin t • J) = 1 := by
  have hs : Real.sin t ^ 2 + Real.cos t ^ 2 = 1 := Real.sin_sq_add_cos_sq t
  rw [Matrix.mul_sub, Matrix.add_mul, Matrix.add_mul]
  simp only [Matrix.smul_mul, Matrix.mul_smul, Matrix.one_mul, Matrix.mul_one, hJ]
  rw [smul_neg, smul_smul, smul_smul]
  ext i j
  simp only [Matrix.add_apply, Matrix.sub_apply, Matrix.smul_apply, Matrix.one_apply,
    Matrix.neg_apply, smul_eq_mul]
  by_cases h : i = j <;> simp [h] <;> nlinarith [hs]

/-- **So the family's determinant never vanishes.** -/
theorem det_rot_ne_zero {J : Matrix (Fin 6) (Fin 6) ℝ} (hJ : J * J = -1) (t : ℝ) :
    (Real.cos t • (1 : Matrix (Fin 6) (Fin 6) ℝ) + Real.sin t • J).det ≠ 0 := by
  intro h
  have hd := congrArg Matrix.det (rot_mul_rot hJ t)
  rw [Matrix.det_mul, h, zero_mul, Matrix.det_one] at hd
  norm_num at hd

/-- **And it moves continuously**, `det` being a polynomial in the entries. -/
theorem det_rot_continuous (J : Matrix (Fin 6) (Fin 6) ℝ) : Continuous (fun t : ℝ =>
    (Real.cos t • (1 : Matrix (Fin 6) (Fin 6) ℝ) + Real.sin t • J).det) :=
  Continuous.matrix_det
    ((Real.continuous_cos.smul continuous_const).add (Real.continuous_sin.smul continuous_const))

/-- **THE SIGN, which is the whole content.** *A continuous path of determinants running from `1` to
`det J` without ever vanishing cannot end below zero, so the intermediate value theorem settles it.*

**This is where `J` having no real eigenvalue enters**, in the form that makes it checkable: the
rotation family is nonsingular at every `t` precisely because `J² = -Id` supplies its inverse. -/
theorem det_pos_of_sq_eq_neg_one {J : Matrix (Fin 6) (Fin 6) ℝ} (hJ : J * J = -1) : 0 < J.det := by
  set f : ℝ → ℝ :=
    fun t => (Real.cos t • (1 : Matrix (Fin 6) (Fin 6) ℝ) + Real.sin t • J).det with hf
  have hne : ∀ t, f t ≠ 0 := det_rot_ne_zero hJ
  have hf0 : f 0 = 1 := by simp [hf]
  have hfpi : f (Real.pi / 2) = J.det := by simp [hf]
  have hpi : (0:ℝ) ≤ Real.pi / 2 := by linarith [Real.pi_pos]
  rcases lt_trichotomy J.det 0 with h | h | h
  · have hsub : Set.Icc (f (Real.pi / 2)) (f 0) ⊆ f '' Set.Icc 0 (Real.pi / 2) :=
      intermediate_value_Icc' hpi (det_rot_continuous J).continuousOn
    have h0 : (0:ℝ) ∈ Set.Icc (f (Real.pi / 2)) (f 0) := by
      refine ⟨?_, ?_⟩
      · rw [hfpi]; exact h.le
      · rw [hf0]; norm_num
    obtain ⟨t, _, ht⟩ := hsub h0
    exact absurd ht (hne t)
  · exact absurd (by rw [hfpi]; exact h : f (Real.pi / 2) = 0) (hne _)
  · exact h

/-- **A complex structure has determinant one.** *`J² = -Id` gives `(det J)² = 1` and the rotation
family gives the sign.* **Only `J * J = -1` is used; the skewness clause of `IsComplexStructure` is
not needed here.** -/
theorem det_complex_structure (J : Matrix (Fin 6) (Fin 6) ℝ) (hJ : IsComplexStructure J) :
    J.det = 1 := by
  have h1 := det_sq_eq_one hJ.2
  have h2 := det_pos_of_sq_eq_neg_one hJ.2
  nlinarith [h1, h2]

/-- **THE INPUT `StarWedgeIdentity` NEEDED**, cited from [I67PfSign.lean](I67PfSign.lean)'s
`pf6_complexStructure` so it carries no `sorry`. -/
theorem pf6_complex_structure (J : Matrix (Fin 6) (Fin 6) ℝ) (hJ : IsComplexStructure J) :
    pf6 J = 1 ∨ pf6 J = -1 :=
  HamiltonsCubic.SelfDualLayer.pf6_complexStructure hJ

end HamiltonsCubic.I67PfSquared
