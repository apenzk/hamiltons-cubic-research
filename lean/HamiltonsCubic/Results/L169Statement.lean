import Mathlib

set_option linter.style.longLine false

/-!
# L169, the grading and tracelessness determine the saturating operator

## The record's statement, quoted verbatim from [bounds.md](../../../findings/bounds.md)

> #### Lemma L169, the grading and tracelessness determine the saturating operator

> **Statement.** Let $n$ be even, $W\in\mathcal W_n$ with $\lVert W\rVert=1$, exactly two eigenvalues
> $\lambda_{\max}>0>\lambda_{\min}$ as an operator on $\Lambda^2\mathbb R^n$, and $E_{\max}$
> $SO(n)$-conjugate to $\mathfrak h=\mathfrak{so}(n/2)\oplus\mathfrak{so}(n/2)$. **Then $W$ is
> $SO(n)$-conjugate to the Weyl tensor of $S^{n/2}\times S^{n/2}$ at unit norm**, and
> $\theta=\theta_0(n)$.

> **Proof.** Conjugate so that $E_{\max}=\mathfrak h$ exactly. Two eigenvalues and
> $E_{\min}=E_{\max}^\perp$ give $W=\lambda_{\max}\Pi_{\mathfrak h}+\lambda_{\min}(\mathrm{Id}-\Pi_{\mathfrak h})$,
> so $W$ lies on the two-parameter plane spanned by $\Pi_{\mathfrak h}$ and $\mathrm{Id}$.
> **Ricci-flatness makes $W$ traceless on $\Lambda^2$**, and with $r=\dim\mathfrak h=\tfrac{n(n-2)}4$
> and $N=\binom n2$, so that $N-r=\tfrac{n^2}4$, that reads
> $$\lambda_{\max}\,r+\lambda_{\min}(N-r)=0\iff\frac{\lvert\lambda_{\min}\rvert}{\lambda_{\max}}
> =\frac r{N-r}=\frac{n-2}{n}\iff(n-2)\lambda_{\max}=n\lvert\lambda_{\min}\rvert .$$
> This puts $W$ on the **line** $\mathbb R\big(\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id}\big)$;
> $\lVert W\rVert=1$ fixes the scale up to sign and $\lambda_{\max}>0$ fixes the sign, so $W$ is the
> unique unit positive multiple.

> **And the sphere product is that multiple.** […] With $m=n/2$, $\mathrm{Id}^\#=(n-2)\mathrm{Id}$,
> $\Pi_{\mathfrak h}^\#=(m-2)\Pi_{\mathfrak h}$ and $\Pi_{\mathfrak h}\#\mathrm{Id}=(m-1)\mathrm{Id}-\Pi_{\mathfrak h}$
> give
> $$\theta^2=\frac{(m-1)(2m-1)}{m^2}=\frac{2(n-1)(n-2)}{n^2}=\theta_0(n)^2,$$
> **with no criticality, no saturation and no Bianchi anywhere in it**. *The $\#$-normalisation is
> pinned rather than chosen here: $\#\mapsto c\,\#$ matches $\theta_0$ at every $m$ only at $c=1$.*

> **And $\lambda_{\max}>0>\lambda_{\min}$ is redundant**, forced by tracelessness, unit norm and a
> two-element spectrum.

> **AT ODD $n$ THE HYPOTHESIS IS UNSATISFIABLE, $\tfrac n2\notin\mathbb Z$, SO $\mathfrak h$ DOES
> NOT EXIST.** *Stating it through $\tfrac{n^2}4\notin\mathbb Z$ reaches the same place by a
> downstream route.*

> **AND $n=4$ IS NOT AN EXCEPTION: THE LEMMA HOLDS THERE.** *Every step runs at $m=2$ and returns
> $\theta^2=\tfrac34=\theta_0(4)^2$.* **What fails at $n=4$ is $\theta_0$'s maximality**,
> $W_{\mathbb{CP}^2}$ reaching $\theta^2=\tfrac32$, and that tensor is barred from this lemma's
> hypotheses twice over: $\dim E_{\max}=1\ne2=r$, and its spectrum
> $\{\tfrac{\sqrt6}3,\,0^{(3)},\,-\tfrac{\sqrt6}6{}^{(2)}\}$ has three values rather than two.

## What is typed here

* `dim_identities`, `r = n(n-2)/4`, `N = n(n-1)/2`, `N - r = n²/4`, as an exact identity in `n`.
* `traceless_iff_ratio`, the displayed three-way equivalence: `λ₊r + λ₋(N-r) = 0` iff
  `|λ₋|/λ₊ = r/(N-r) = (n-2)/n` iff `(n-2)λ₊ = n|λ₋|`.
* `sign_hypothesis_redundant`, `λ₊ > 0 > λ₋` is forced by tracelessness together with a
  two-element spectrum and a nonzero operator, so the record's third hypothesis costs nothing.
* `unit_positive_multiple_unique`, the line step: two unit positive multiples of one nonzero
  vector coincide, in any real normed space.
* `D_traceless`, `Qcoeff_eq`, `norm_pins_scale`, `sharp_pins_theta`, **the `θ` computation in full**, carried out in the
  two-dimensional model spanned by `Π_𝔥` and `Id` with the record's own structure constants:
  `Q(W) = u(m-1)·W`, so `W` is `θ`-critical with `θ² = (m-1)(2m-1)/m²`.
* `theta_sq_matches_theta0`, that `(m-1)(2m-1)/m² = 2(n-1)(n-2)/n²` at `n = 2m`.
* `sharp_normalisation_pinned`, **`#` is pinned, not chosen**: under `# ↦ c·#` the operator
  `W² + c·W#` is a multiple of `W` only at `c = 1`. This is stronger than the record's clause,
  which pins `c` by matching `θ₀`; here `c ≠ 1` already breaks proportionality.
* `odd_n_unsatisfiable`, at odd `n`, `4 ∤ n(n-2)`, so `r = n(n-2)/4` is not an integer and
  `𝔥 = 𝔰𝔬(n/2) ⊕ 𝔰𝔬(n/2)` does not exist.
* `n_four_is_not_an_exception`, `CP2_barred_twice`, `θ² = 3/4 = θ₀(4)²` at `m = 2`, and
  `W_{ℂP²}` fails the hypotheses on both counts (`dim E_max = 1 ≠ 2 = r`, three spectral values),
  while reaching `θ² = 3/2`.

Everything below is proved; there is no `sorry`.

## The model, and what it costs

`Q(W) = θW` is derived inside a **two-dimensional real model**: an element `x·Π + y·Id` is carried
by its coordinate pair `(x, y)`, and `Π² = Π`, `Π·Id = Π`, `Id² = Id`, `Π#Π = (m-2)Π`,
`Π#Id = (m-1)Id - Π`, `Id#Id = (n-2)Id`, `⟨Π,Π⟩ = ⟨Π,Id⟩ = r`, `⟨Id,Id⟩ = N` are the model's
*definitions*. Those structure constants are the record's, transcribed; **the model does not prove
them**, and a reader checking this file is checking the algebra that follows from them.

## What is NOT typed here

**The conjugacy is not typed, and it is the lemma's hard hypothesis.** That `E_max` is
`SO(n)`-conjugate to `𝔰𝔬(n/2) ⊕ 𝔰𝔬(n/2)` rather than to some other subalgebra of the same
dimension is [L71](../../../findings/bounds.md)'s work and ends in Cartan's classification; the
record says so in its own aside. Nothing here supplies it.

**Nor is the identification with the Weyl tensor of `S^{n/2} × S^{n/2}`**, which needs the
curvature layer, `𝒲ₙ`, the sphere-product family, `Π_𝔥` as an actual projection on `Λ²ℝⁿ`,
that this record has not built in Lean. `unit_positive_multiple_unique` types the *shape* of that
step (a point on a line, pinned by two scalars), not the identification.
-/

namespace HamiltonsCubic.L169Statement

/-! ## The dimensions -/

/-- `r = dim 𝔥 = n(n-2)/4`. -/
noncomputable def r (n : ℝ) : ℝ := n * (n - 2) / 4

/-- `N = C(n,2) = n(n-1)/2`. -/
noncomputable def Nn (n : ℝ) : ℝ := n * (n - 1) / 2

/-- **`N - r = n²/4`**, and `r/(N-r) = (n-2)/n`. -/
theorem dim_identities (n : ℝ) (hn : n ≠ 0) :
    Nn n - r n = n ^ 2 / 4 ∧ r n / (Nn n - r n) = (n - 2) / n := by
  refine ⟨by simp only [Nn, r]; ring, ?_⟩
  rw [show Nn n - r n = n ^ 2 / 4 by simp only [Nn, r]; ring, r]
  field_simp

/-! ## Tracelessness is the ratio, read in the two directions -/

/-- **The displayed equivalence.** With `r > 0` and `N - r > 0` and `λ₊ > 0 > λ₋`, the trace
condition `λ₊r + λ₋(N-r) = 0` says exactly `|λ₋|/λ₊ = r/(N-r) = (n-2)/n`, equivalently
`(n-2)λ₊ = n|λ₋|`. -/
theorem traceless_iff_ratio {n lmax lmin : ℝ} (hn : 0 < n) (hn2 : 2 < n)
    (hmax : 0 < lmax) (hmin : lmin < 0) :
    (lmax * r n + lmin * (Nn n - r n) = 0) ↔ (n - 2) * lmax = n * |lmin| := by
  have hrn : Nn n - r n = n ^ 2 / 4 := by simp only [Nn, r]; ring
  have habs : |lmin| = -lmin := abs_of_neg hmin
  rw [hrn, habs, r]
  constructor
  · intro h; nlinarith
  · intro h; nlinarith

/-- **The sign hypothesis is redundant.** For a nonzero operator on the plane with a two-element
spectrum, tracelessness alone forces `λ₊` and `λ₋` to have opposite signs; here, with `λ₊` named
as the one on the `r`-dimensional eigenspace and `λ₊ ≠ λ₋`, `λ₊ > 0` gives `λ₋ < 0` and vice
versa. -/
theorem sign_hypothesis_redundant {r' s' lmax lmin : ℝ} (hr : 0 < r') (hs : 0 < s')
    (hne : lmax ≠ lmin) (htr : lmax * r' + lmin * s' = 0) :
    (0 < lmax ∧ lmin < 0) ∨ (lmax < 0 ∧ 0 < lmin) := by
  rcases lt_trichotomy lmax 0 with h | h | h
  · right
    refine ⟨h, ?_⟩
    nlinarith
  · exfalso
    subst h
    have : lmin = 0 := by
      have : lmin * s' = 0 := by linarith
      rcases mul_eq_zero.mp this with h' | h'
      · exact h'
      · exact absurd h' (by positivity)
    exact hne this.symm
  · left
    refine ⟨h, ?_⟩
    nlinarith

/-! ## The line step -/

/-- **Two unit positive multiples of one nonzero vector coincide**, the step that turns "a point
on a line" into "the unique unit positive multiple". -/
theorem unit_positive_multiple_unique {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    {v : E} (hv : v ≠ 0) {c d : ℝ} (hc : 0 < c) (hd : 0 < d)
    (hcn : ‖c • v‖ = 1) (hdn : ‖d • v‖ = 1) : c • v = d • v := by
  rw [norm_smul, Real.norm_eq_abs, abs_of_pos hc] at hcn
  rw [norm_smul, Real.norm_eq_abs, abs_of_pos hd] at hdn
  have hvn : ‖v‖ ≠ 0 := norm_ne_zero_iff.mpr hv
  have : c = d := by
    have h1 : c = 1 / ‖v‖ := by field_simp at hcn ⊢; linarith
    have h2 : d = 1 / ‖v‖ := by field_simp at hdn ⊢; linarith
    rw [h1, h2]
  rw [this]

/-! ## The `θ` computation, in the two-dimensional model

An element `x·Π + y·Id` of the plane is carried by `(x, y)`. The structure constants below are the
record's; see the module docstring for what that costs. The traceless direction is taken in the
denominator-free form `D = (2m-1)Π - (m-1)Id`, a positive multiple of `Π - (r/N)Id`. -/

/-- The `Π`-coordinate of `X²` for `X = xΠ + yId`, using `Π² = Π`, `Π·Id = Π`, `Id² = Id`. -/
def sqPi (x y : ℝ) : ℝ := x ^ 2 + 2 * x * y

/-- The `Id`-coordinate of `X²`. -/
def sqId (_x y : ℝ) : ℝ := y ^ 2

/-- The `Π`-coordinate of `X#` for `X = xΠ + yId`, using `Π#Π = (m-2)Π`,
`Π#Id = (m-1)Id - Π`, `Id#Id = (2m-2)Id`. -/
def shPi (m x y : ℝ) : ℝ := x ^ 2 * (m - 2) - 2 * x * y

/-- The `Id`-coordinate of `X#`. -/
def shId (m x y : ℝ) : ℝ := 2 * x * y * (m - 1) + y ^ 2 * (2 * m - 2)

/-- The squared norm of `X = xΠ + yId`, using `⟨Π,Π⟩ = ⟨Π,Id⟩ = r = m(m-1)` and
`⟨Id,Id⟩ = N = m(2m-1)`. -/
def nrmSq (m x y : ℝ) : ℝ :=
  x ^ 2 * (m * (m - 1)) + 2 * x * y * (m * (m - 1)) + y ^ 2 * (m * (2 * m - 1))

/-- The traceless line's direction, `D = (2m-1)Π - (m-1)Id`; its `Λ²`-trace vanishes, which is what
Ricci-flatness supplies. -/
def Dx (m : ℝ) : ℝ := 2 * m - 1
/-- The `Id`-coordinate of `D`. -/
def Dy (m : ℝ) : ℝ := -(m - 1)

/-- **`D` is traceless**: `r·(2m-1) + N·(-(m-1)) = 0` with `r = m(m-1)`, `N = m(2m-1)`. -/
theorem D_traceless (m : ℝ) : m * (m - 1) * Dx m + m * (2 * m - 1) * Dy m = 0 := by
  simp only [Dx, Dy]; ring

/-- **`Q(W) = θ·W` on the traceless line, with `θ = s(m-1)(2m-1)`.** For `W = s·D` the operator
`Q = X² + X#` returns a multiple of `W`, no criticality was assumed to get there. -/
theorem Qcoeff_eq (m s : ℝ) :
    sqPi (s * Dx m) (s * Dy m) + shPi m (s * Dx m) (s * Dy m)
        = (s * (m - 1) * (2 * m - 1)) * (s * Dx m) ∧
      sqId (s * Dx m) (s * Dy m) + shId m (s * Dx m) (s * Dy m)
        = (s * (m - 1) * (2 * m - 1)) * (s * Dy m) := by
  constructor <;> · simp only [sqPi, sqId, shPi, shId, Dx, Dy]; ring

/-- **`‖W‖ = 1` fixes the scale**: `nrmSq = s²m²(m-1)(2m-1)`, so `s²m²(m-1)(2m-1) = 1`. -/
theorem norm_pins_scale (m s : ℝ) :
    nrmSq m (s * Dx m) (s * Dy m) = s ^ 2 * m ^ 2 * ((m - 1) * (2 * m - 1)) := by
  simp only [nrmSq, Dx, Dy]; ring

/-- **`θ² = (m-1)(2m-1)/m²`**, the record's value, from the sharp identities alone. -/
theorem sharp_pins_theta {m s : ℝ} (hm : 1 < m) (hs : 0 < s)
    (hnorm : nrmSq m (s * Dx m) (s * Dy m) = 1) :
    (s * (m - 1) * (2 * m - 1)) ^ 2 = (m - 1) * (2 * m - 1) / m ^ 2 := by
  rw [norm_pins_scale] at hnorm
  have hm0 : (0 : ℝ) < m := by linarith
  have hm2 : (m : ℝ) ^ 2 ≠ 0 := by positivity
  field_simp
  linear_combination ((m - 1) * (2 * m - 1)) * hnorm

/-- **`(m-1)(2m-1)/m² = 2(n-1)(n-2)/n²` at `n = 2m`**, the model's `θ²` is `θ₀(n)²`. -/
theorem theta_sq_matches_theta0 {m : ℝ} (hm : 0 < m) :
    (m - 1) * (2 * m - 1) / m ^ 2 = 2 * (2 * m - 1) * (2 * m - 2) / (2 * m) ^ 2 := by
  have : (m : ℝ) ≠ 0 := ne_of_gt hm
  field_simp

/-- **The `#`-normalisation is pinned, not chosen.** Under `# ↦ c·#` the operator `W² + c·W#` is a
scalar multiple of `W` only at `c = 1`; away from `c = 1` proportionality already fails, before any
comparison with `θ₀` is made. -/
theorem sharp_normalisation_pinned {m s c θ : ℝ} (hm : 1 < m) (hs : s ≠ 0)
    (h1 : sqPi (s * Dx m) (s * Dy m) + c * shPi m (s * Dx m) (s * Dy m) = θ * (s * Dx m))
    (h2 : sqId (s * Dx m) (s * Dy m) + c * shId m (s * Dx m) (s * Dy m) = θ * (s * Dy m)) :
    c = 1 := by
  have hm0 : (0 : ℝ) < m := by linarith
  have hm1 : (m : ℝ) - 1 ≠ 0 := by intro h; linarith [h]
  have hd : (2 : ℝ) * m - 1 ≠ 0 := by intro h; linarith [h]
  simp only [sqPi, sqId, shPi, shId, Dx, Dy] at h1 h2
  have key : s ^ 2 * (m - 1) * (2 * m - 1) * (m * (1 - c)) = 0 := by
    linear_combination (m - 1) * h1 + (2 * m - 1) * h2
  rcases mul_eq_zero.mp key with h | h
  · rcases mul_eq_zero.mp h with h' | h'
    · rcases mul_eq_zero.mp h' with h'' | h''
      · exact absurd h'' (by positivity)
      · exact absurd h'' hm1
    · exact absurd h' hd
  · rcases mul_eq_zero.mp h with h' | h'
    · exact absurd h' (ne_of_gt hm0)
    · linarith

/-! ## Odd `n`, and `n = 4` -/

/-- **At odd `n` the hypothesis is unsatisfiable**: `r = n(n-2)/4` is not an integer, so no
`𝔥 = 𝔰𝔬(n/2) ⊕ 𝔰𝔬(n/2)` exists to be conjugate to. -/
theorem odd_n_unsatisfiable {n : ℕ} (hn : Odd n) (h2 : 2 ≤ n) : ¬ (4 ∣ n * (n - 2)) := by
  have h1 : Odd (n - 2) := by obtain ⟨k, hk⟩ := hn; exact ⟨k - 1, by omega⟩
  have hodd : Odd (n * (n - 2)) := hn.mul h1
  rw [Nat.odd_iff] at hodd
  intro hdvd
  have h2d : (2 : ℕ) ∣ n * (n - 2) := dvd_trans (by norm_num) hdvd
  rw [Nat.dvd_iff_mod_eq_zero] at h2d
  omega

/-- **And `n/2 ∉ ℤ` directly at odd `n`.** -/
theorem odd_n_no_half {n : ℕ} (hn : Odd n) : ¬ ∃ k : ℕ, n = 2 * k := by
  obtain ⟨k, hk⟩ := hn
  rintro ⟨j, hj⟩
  omega

/-- **`n = 4` is not an exception**: every step runs at `m = 2` and returns `θ² = 3/4 = θ₀(4)²`. -/
theorem n_four_is_not_an_exception :
    ((2 : ℝ) - 1) * (2 * 2 - 1) / 2 ^ 2 = 3 / 4 ∧
      2 * ((4 : ℝ) - 1) * (4 - 2) / 4 ^ 2 = 3 / 4 := by
  constructor <;> norm_num

/-- **`W_{ℂP²}` is barred from the hypotheses twice over** at `n = 4`: `dim E_max = 1 ≠ 2 = r`, and
its spectrum `{√6/3, 0, -√6/6}` has three distinct values rather than two, while its `θ² = 3/2`
exceeds `θ₀(4)² = 3/4`, which is what fails at `n = 4`. -/
theorem CP2_barred_twice :
    r 4 = 2 ∧ (1 : ℝ) ≠ 2 ∧
      ({Real.sqrt 6 / 3, 0, -(Real.sqrt 6 / 6)} : Finset ℝ).card = 3 ∧
      (3 : ℝ) / 4 < 3 / 2 := by
  have h6 : (0 : ℝ) < Real.sqrt 6 := Real.sqrt_pos.mpr (by norm_num)
  refine ⟨by norm_num [r], by norm_num, ?_, by norm_num⟩
  rw [Finset.card_insert_of_notMem, Finset.card_insert_of_notMem, Finset.card_singleton]
  · simp only [Finset.mem_singleton]; intro h; linarith
  · simp only [Finset.mem_insert, Finset.mem_singleton]
    rintro (h | h) <;> linarith

/-- **Spectral tracelessness at `n = 4`** for `W_{ℂP²}`: `1·(√6/3) + 3·0 + 2·(-√6/6) = 0`. -/
theorem CP2_traceless : 1 * (Real.sqrt 6 / 3) + 3 * 0 + 2 * (-(Real.sqrt 6 / 6)) = 0 := by ring

end HamiltonsCubic.L169Statement
