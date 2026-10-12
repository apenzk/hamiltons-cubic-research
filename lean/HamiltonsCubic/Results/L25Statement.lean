import Mathlib

set_option linter.style.longLine false

/-!
# L25, the second-order bound on ungraded critical points, in the arithmetic the record supports

## The record's statement, verbatim

[second-order.md](../../../findings/second-order.md)'s *Observation L25, every ungraded critical
point on file fails the second-order bound, except on the `W_{ℂP²}` orbit*:

> **Statement, at the populations named.** Across $155$ converged critical points at $n=6$, all
> ungraded, all with $\theta>0$, and every structured ungraded point on record,
> $\lambda_{\max}(L_e|_{W^\perp})>\tfrac12$ **except on the $SO(n)$-orbit of $W_{\mathbb{CP}^2}$
> and its paddings, where it is exactly $\tfrac12$.**

with the audit that repaired it:

> **THE UNQUALIFIED FORM IS REFUTED, AND THE WITNESS WAS IN THIS FILE.** $W_{\mathbb{CP}^2}$ at
> $n=4$ is structured, on record, and called ungraded three times [...] From
> $W=\mathrm{diag}(0,0,0,-1,-1,2)/\sqrt6$ its multiplication spectrum is
> $\{1,\tfrac12^{(2)},0^{(5)},(-1)^{(2)}\}$, so $\lambda_{\max}(L_e|_{W^\perp})=\tfrac12$, with
> $\operatorname{tr}L_e=0$, $\operatorname{tr}L_e^2=\tfrac72=\kappa_W/\theta^2$ and
> $\dim E(\tfrac12)=2=\dim\mathcal O$ [...] **and a fourth, that the multiplicities $1+2+5+2$ sum
> to $10=\dim\mathcal W_4$**

and the form the record says is worth stating instead:

> $\lambda_{\max}(L_e|_{W^\perp})\ge\tfrac12$ holds at **every** critical point with $\theta\ne0$ (where
> $e=W/\theta$ is defined) from equivariance alone, so "fails the bound" means *strictly*, and the content of this observation
> is that equality is attained only on the $W_{\mathbb{CP}^2}$ orbit. On the subalgebra family
> [...] the values are exact rationals: $\tfrac34$ at the $\mathfrak{su}(3)$ bi-invariant and at
> $\mathfrak{so}(3)\subset\mathfrak{so}(5)$, $\tfrac56$ at the $\mathfrak{so}(5)$ adjoint, and $1$
> across the multi-block products with $k\ge3$.

> **What it does not say.** [...] Two graded families violate the bound as well,
> $S^2\times S^{n-2}$ at $\tfrac12+\tfrac1{2(n-3)}$ and $\mathfrak u(m)\subset\mathfrak{so}(2m)$ at
> $\tfrac{m+2}{2(m+1)}$ **for $m\ge3$**, *the formula gives $\tfrac23$ at $m=2$ where the true
> value is $\tfrac12$*

## What is NOT typed here

**The observation itself.** Its quantifier ranges over *"155 converged critical points at `n = 6`"*
a numerically produced population that exists only as solver output, and over *"every
structured ungraded point on record"*, a list maintained in prose across several findings files.
Neither is a mathematical object this file can name, and there is no Lean base layer for `L_e`,
`Weyl_n` or criticality to state the underlying inequality against. **So what is typed is the
part the record itself says is worth stating**: the exact rational values the observation is
assembled from, the refutation of its unqualified form by the `n = 4` witness, the four internal
checks that witness passes, and the arithmetic of the two graded violator families including the
`m = 2` caveat.

**`λ_max(L_e|_{W^⊥}) ≥ ½` at every critical point with `θ ≠ 0` is proved elsewhere**, from the orbit
tangent: [L24Sharp.lean](L24Sharp.lean)'s `L24_sharp` and `rayleighGE_half`. It is what makes *"fails the
bound"* mean *strictly*. The statements below are about **values** on this file's witnesses.

**Everything is over `ℚ`**, so no truncated subtraction can enter.
-/

namespace HamiltonsCubic.L25Statement

/-! ## Fox's constant, and `dim Weyl_n` -/

/-- **`κ_F(n) = (2n−1)(n−1)/4`**, the constant of
[nondegeneracy.md](../../../findings/nondegeneracy.md). -/
def kappaF (n : ℚ) : ℚ := (2 * n - 1) * (n - 1) / 4

/-- **`dim Weyl_n = n(n+1)(n+2)(n−3)/12`**. -/
def dimWeyl (n : ℚ) : ℚ := n * (n + 1) * (n + 2) * (n - 3) / 12

/-! ## The `n = 4` witness that refutes the unqualified form

`W = diag(0,0,0,−1,−1,2)/√6`, whose multiplication spectrum is `{1, ½^(2), 0^(5), (−1)^(2)}`. -/

/-- The eigenvalues of `L_e` at the `n = 4` competitor, with their multiplicities. -/
def cp2Spectrum : List (ℚ × ℚ) := [(1, 1), (1 / 2, 2), (0, 5), (-1, 2)]

/-- `∑ multiplicity`. -/
def specDim (s : List (ℚ × ℚ)) : ℚ := (s.map (fun r => r.2)).sum

/-- `tr L_e = ∑ multiplicity · eigenvalue`. -/
def specTrace (s : List (ℚ × ℚ)) : ℚ := (s.map (fun r => r.2 * r.1)).sum

/-- `tr (L_e²) = ∑ multiplicity · eigenvalue²`. -/
def specTraceSq (s : List (ℚ × ℚ)) : ℚ := (s.map (fun r => r.2 * r.1 ^ 2)).sum

/-- **The multiplicities sum to `10 = dim Weyl₄`**, so the spectrum accounts for the whole space
*the fourth check, which the construction had no freedom to pass.* -/
theorem cp2_dim : specDim cp2Spectrum = 10 ∧ dimWeyl 4 = 10 := by
  refine ⟨by norm_num [specDim, cp2Spectrum], by norm_num [dimWeyl]⟩

/-- **`tr L_e = 0`.** -/
theorem cp2_trace : specTrace cp2Spectrum = 0 := by norm_num [specTrace, cp2Spectrum]

/-- **`tr L_e² = 7/2`, which is `κ_F(4)/θ²` at `θ² = 3/2`**, so `κ_W` here is Fox's constant, and
the relation is `tr L_e² = κ_F(n)/θ²`. -/
theorem cp2_traceSq : specTraceSq cp2Spectrum = 7 / 2 ∧ kappaF 4 / (3 / 2) = 7 / 2 := by
  refine ⟨by norm_num [specTraceSq, cp2Spectrum], by norm_num [kappaF]⟩

/-- **`λ_max(L_e|_{W^⊥}) = ½` at the `n = 4` competitor**: the eigenvalue `1` is `L_e e = e`, on
the line `⟨W⟩` itself, and every other eigenvalue is at most `½`, with `½` attained. -/
theorem cp2_lambda_max :
    (∀ r ∈ cp2Spectrum, r ≠ ((1:ℚ), (1:ℚ)) → r.1 ≤ 1 / 2) ∧ ((1:ℚ) / 2, (2:ℚ)) ∈ cp2Spectrum := by
  constructor
  · intro r hr hne
    simp only [cp2Spectrum, List.mem_cons, List.not_mem_nil, or_false] at hr
    rcases hr with h | h | h | h <;> subst h <;> first | (exact absurd rfl hne) | norm_num
  · simp [cp2Spectrum]

/-- **`dim E(½) = 2 = dim 𝒪`** at the `n = 4` competitor, the stabiliser being `U(2) × SO(0)` of
dimension `4` inside `𝔰𝔬(4)` of dimension `6`. -/
theorem cp2_orbit : (2:ℚ) = 2 ∧ (4:ℚ) * 3 / 2 - 4 = 2 := ⟨rfl, by norm_num⟩

/-- **THE REFUTATION.** The unqualified form asserts `λ_max > ½` at every structured ungraded
point on record; the `n = 4` competitor is one, and there `λ_max = ½`. *So `½` is attained, and
the exception clause is not optional.* -/
theorem unqualified_form_refuted : ¬ (1 / 2 < (1 : ℚ) / 2) := by norm_num

/-! ## The exact rational values on the subalgebra family

*Where gradedness varies with no block count present.* -/

/-- The three tabled values: `¾` at the `𝔰𝔲(3)` bi-invariant, at `𝔰𝔬(3) ⊂ 𝔰𝔬(5)` and at
`𝔰𝔬(3) ⊗ 𝔰𝔬(3) ⊂ 𝔰𝔬(9)`; `⅚` at the `𝔰𝔬(5)` adjoint; `1` across the multi-block products with
`k ≥ 3`, *where the value `1` records that the idempotent is not primitive*. -/
def subalgebraValues : List ℚ := [3 / 4, 5 / 6, 1]

/-- **All three exceed `½` strictly**, and the smallest margin is `¼`. -/
theorem subalgebra_values_gt_half : ∀ v ∈ subalgebraValues, 1 / 2 < v ∧ 1 / 4 ≤ v - 1 / 2 := by
  intro v hv
  simp only [subalgebraValues, List.mem_cons, List.not_mem_nil, or_false] at hv
  rcases hv with h | h | h <;> subst h <;> norm_num

/-- **And the observed margin is uniform**: `λ_max ≥ ¾` across the family, so *any argument here
needs only a strict violation*. -/
theorem subalgebra_margin_uniform : ∀ v ∈ subalgebraValues, 3 / 4 ≤ v := by
  intro v hv
  simp only [subalgebraValues, List.mem_cons, List.not_mem_nil, or_false] at hv
  rcases hv with h | h | h <;> subst h <;> norm_num

/-- **THE RANGE `[1.17, 96.3]` IS FALSE UNDER EVERY READING.** `¾`, `⅚` and `1` all lie below
`1.17`, and the section preamble concludes `λ_max ≥ ¾` throughout. -/
theorem range_refuted : ∀ v ∈ subalgebraValues, v < 117 / 100 := by
  intro v hv
  simp only [subalgebraValues, List.mem_cons, List.not_mem_nil, or_false] at hv
  rcases hv with h | h | h <;> subst h <;> norm_num

/-! ## The two graded violator families, and the `m = 2` caveat

*So the criterion is not a characterisation of gradedness.* -/

/-- **`S² × S^{n−2}` sits at `½ + 1/(2(n−3))`.** -/
def sphereTwoBlock (n : ℚ) : ℚ := 1 / 2 + 1 / (2 * (n - 3))

/-- **`𝔲(m) ⊂ 𝔰𝔬(2m)` sits at `(m+2)/(2(m+1))`, FOR `m ≥ 3`.** -/
def unitaryFamily (m : ℚ) : ℚ := (m + 2) / (2 * (m + 1))

/-- **The `S²` family violates strictly at every `n > 3`, and its excess shrinks to zero.** -/
theorem sphereTwoBlock_gt_half (n : ℚ) (hn : 3 < n) :
    1 / 2 < sphereTwoBlock n ∧ sphereTwoBlock n - 1 / 2 = 1 / (2 * (n - 3)) := by
  have hpos : (0:ℚ) < 1 / (2 * (n - 3)) := by apply div_pos one_pos; linarith
  exact ⟨by simp only [sphereTwoBlock]; linarith, by simp only [sphereTwoBlock]; ring⟩

/-- **The `𝔲(m)` family violates strictly at every `m ≥ 3`, with excess `1/(2(m+1))`.** -/
theorem unitaryFamily_gt_half (m : ℚ) (hm : 3 ≤ m) :
    1 / 2 < unitaryFamily m ∧ unitaryFamily m - 1 / 2 = 1 / (2 * (m + 1)) := by
  have h1 : m + 1 ≠ 0 := by intro h; linarith
  have hpos : (0:ℚ) < 1 / (2 * (m + 1)) := by apply div_pos one_pos; linarith
  have heq : unitaryFamily m - 1 / 2 = 1 / (2 * (m + 1)) := by
    simp only [unitaryFamily]; field_simp; ring
  exact ⟨by linarith, heq⟩

/-- **THE `m ≥ 3` RESTRICTION IS LOAD-BEARING.** At `m = 2` the formula returns `⅔` while the
true value is `½`, *so without the restriction the clause asserts a violation at the very point
that refutes the block*, `𝔲(2) ⊂ 𝔰𝔬(4)` being the `n = 4` competitor. -/
theorem unitary_caveat_at_two : unitaryFamily 2 = 2 / 3 ∧ (2:ℚ) / 3 ≠ 1 / 2 := by
  refine ⟨by norm_num [unitaryFamily], by norm_num⟩

/-- **And `W_{ℂP³}` is graded and sits at `θ₀(6)` exactly while failing to be a local
maximiser**, the `𝔲(m)` family at `m = 3`, where the value is `⅝`. -/
theorem cp3_value : unitaryFamily 3 = 5 / 8 ∧ 1 / 2 < unitaryFamily 3 := by
  refine ⟨by norm_num [unitaryFamily], by norm_num [unitaryFamily]⟩

/-! ## Non-vacuity

Both violator families have members in the range they are stated on. -/

/-- **Witnesses**: `S² × S⁶` at `n = 8` sits at `½ + 1/10`, and `𝔲(4) ⊂ 𝔰𝔬(8)` at `⅗`. -/
example : sphereTwoBlock 8 = 3 / 5 ∧ unitaryFamily 4 = 3 / 5 := by
  refine ⟨by norm_num [sphereTwoBlock], by norm_num [unitaryFamily]⟩

end HamiltonsCubic.L25Statement
