import Mathlib
import HamiltonsCubic.Base.WeylReal

set_option linter.style.longLine false

/-!
# L46, at a locally symmetric Einstein space the Weyl part is critical, and `θ` is quadratic

## The record's statement, quoted verbatim from [problem.md](../../../findings/problem.md)

> Let $R$ be the curvature operator of a locally symmetric Einstein space, $\Ric=\lambda g$ with
> $\lambda$ of either sign, and set $W=R-cI$ with $c=\lambda/(n-1)$. Then $Q(W)=\lambda W$, and when
> $W\ne0$, $\theta(W/\|W\|)=\lambda/\|W\|$, so $W/\lVert W\rVert$ is a critical point of $P$ on the
> unit sphere. *The hypothesis is $W\ne0$ and not $\lambda\ne0$: the round sphere has
> $\lambda=n-1$ and $W=0$.* […] In Petersen--Stanfield's normalisation, where $\lambda=\tfrac12$
> for every compact irreducible symmetric space, this reads
> $\theta^2=\frac1{4(\|R\|^2-(\tr R)^2/N)}$.

and the proof's three steps: **(A)** $Q(R)=\lambda R$, from Hamilton's equation along the explicit
homothety $(1-2\lambda t)g$; **(B)** the shift $c=\lambda/(n-1)$ cancels once $W\circ I=0$; **(C)**
$W\circ I=W\#I+W=0$, Böhm–Wilking Lemma 2.1.

## What is typed here

The lemma is a formal consequence of three inputs, and all three are classical and published, so
each enters as a named hypothesis rather than as a `sorry`:

* `hcrit`, **(A)**, `Q(R) = λ R` at a locally symmetric Einstein space, from Hamilton's equation along
  the explicit homothety `(1-2λt)g`.
* `hQI`, `Q(I) = (n-1) I`, Böhm–Wilking.
* `hWI`, `W ∘ I = 0`, which is **(B′)** and **(C)** together: `W # I = -W` is Böhm–Wilking
  Lemma 2.1, and `W ∘ I = W # I + W`.

Given those, `shift_kills_remainder` is the whole of steps (A)–(C): pure bilinear algebra in the
metrised algebra, over an arbitrary `ℝ`-module, with the symmetric bilinear `Qb` in place of `Q`
and `Qb x x` in place of `Q(x)`. `theta_of_eigenvalue` and `petersen_stanfield` are the two
displays, the first stated against the record's own `RealLayer.theta`, `RealLayer.Pcubic` and
`RealLayer.normSq`.

Everything below is proved; there is no `sorry`.

## What is NOT typed here

**The identification of the abstract `Qb` with the record's curvature product is not made here.**
The real Weyl layer carries it, `Qop` with `Pcubic_eq_inner_Qop`, and this file predates that. The
bridge from `Qb W W = lam • W` to `theta_of_eigenvalue`'s hypothesis `Pcubic W = lam * normSq W` is
therefore that pairing, taken as the hypothesis of the second theorem rather than derived from the
first.

**`θ` is read at `W` rather than at `W/‖W‖`.** `θ` is homogeneous of degree `0`, so the two agree;
the homogeneity itself is not proved here, the real Weyl layer carrying no scaling lemma for
`Pcubic`.
-/

namespace HamiltonsCubic.L46Statement

open HamiltonsCubic.RealLayer

/-! ## Steps (A)–(C): the shift that cancels -/

variable {E : Type*} [AddCommGroup E] [Module ℝ E]

/-- **Step (B), with (A), (B′) and (C) as its inputs: `Q(W) = λ W`.**

`Qb` is the symmetric bilinear form of the metrised algebra, so `Qb x x` is `Q(x)` and
`Qb W I` is `W ∘ I`. The hypotheses are, in the record's labelling: `hcrit` is (A),
Hamilton's equation along the homothety; `hQI` is `Q(I) = (n-1) I`; `hWI` is `W ∘ I = 0`, which is
(C) `W # I = -W` together with (B′) `W ∘ I = W # I + W`. The conclusion is the lemma's
`Q(W) = λ W`, and `c = λ/(n-1)` is what makes the two `I`-terms cancel. -/
theorem shift_kills_remainder (Qb : E →ₗ[ℝ] E →ₗ[ℝ] E) (hsymm : ∀ x y, Qb x y = Qb y x)
    (I W : E) (n : ℕ) (lam c : ℝ) (hn : ((n : ℝ) - 1) ≠ 0)
    (hQI : Qb I I = ((n : ℝ) - 1) • I) (hWI : Qb W I = 0)
    (hc : c = lam / ((n : ℝ) - 1))
    (hcrit : Qb (W + c • I) (W + c • I) = lam • (W + c • I)) :
    Qb W W = lam • W := by
  have hIW : Qb I W = 0 := by rw [hsymm]; exact hWI
  have hexp : Qb (W + c • I) (W + c • I)
      = Qb W W + (c * c * ((n : ℝ) - 1)) • I := by
    simp only [map_add, LinearMap.add_apply, map_smul, LinearMap.smul_apply, hWI, hIW, hQI,
      smul_zero, smul_smul]
    module
  have hrhs : lam • (W + c • I) = lam • W + (lam * c) • I := by
    rw [smul_add, smul_smul]
  rw [hexp, hrhs] at hcrit
  have hcoef : c * c * ((n : ℝ) - 1) = lam * c := by
    rw [hc]; field_simp
  rw [hcoef] at hcrit
  exact add_right_cancel hcrit

/-! ## The first display: `θ = λ/‖W‖` -/

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **`θ(W) = λ/‖W‖`.** The hypothesis is `Q(W) = λ W` paired against `W`, i.e.
`P(W) = λ‖W‖²`; `hnn` is nonnegativity of `‖W‖²`, and `hpos` is the statement's `W ≠ 0`. -/
theorem theta_of_eigenvalue (R : Matrix ι ι ℝ → Matrix ι ι ℝ) (lam : ℝ)
    (hnn : 0 ≤ normSq R) (hpos : 0 < norm R) (hP : Pcubic R = lam * normSq R) :
    theta R = lam / norm R := by
  have hsq : norm R ^ 2 = normSq R := Real.sq_sqrt hnn
  have hne : norm R ≠ 0 := ne_of_gt hpos
  rw [theta, hP, ← hsq]
  field_simp

/-! ## The second display: Petersen–Stanfield's normalisation -/

/-- **`θ² = 1/(4(‖R‖² - (tr R)²/N))`**, at `λ = 1/2`.

`nR` is `‖R‖`, `trR` is `tr R`, `NN` is `N = binom n 2`, and `w` is `‖W‖`; the hypothesis `hw` is
`‖W‖² = ‖R‖² - (tr R)²/N`, which is what `W = R - cI` says for the trace part, and `hth` is the
first display at `λ = 1/2`. -/
theorem petersen_stanfield (nR trR NN w th : ℝ) (hNN : 0 < NN) (hwpos : 0 < w)
    (hw : w ^ 2 = nR ^ 2 - trR ^ 2 / NN) (hth : th = (1 / 2) / w) :
    th ^ 2 = 1 / (4 * (nR ^ 2 - trR ^ 2 / NN)) := by
  have hwne : w ≠ 0 := ne_of_gt hwpos
  have hNNne : NN ≠ 0 := ne_of_gt hNN
  rw [hth, ← hw]
  field_simp
  norm_num

/-! ## Non-vacuity -/

/-- **A witness for `shift_kills_remainder`'s hypotheses**, exhibiting `hQI` and `hWI` together: take
`E = ℝ`, `Qb x y = x * y`, `I = n - 1`, `W = 0`. *It exhibits two of the theorem's hypotheses, not all
of them at once, and it is not a curvature operator.* -/
example (n : ℕ) :
    letI Qb : ℝ →ₗ[ℝ] ℝ →ₗ[ℝ] ℝ := LinearMap.mul ℝ ℝ
    Qb ((n : ℝ) - 1) ((n : ℝ) - 1) = ((n : ℝ) - 1) • ((n : ℝ) - 1) ∧ Qb 0 ((n : ℝ) - 1) = 0 := by
  refine ⟨?_, ?_⟩
  · simp [smul_eq_mul]; ring
  · simp

end HamiltonsCubic.L46Statement
