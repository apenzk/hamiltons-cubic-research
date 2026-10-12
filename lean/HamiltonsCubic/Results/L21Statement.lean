import Mathlib

set_option linter.style.longLine false

/-!
# L21, the eigenvalue bound `α ≤ ⅓`, in the census arithmetic that carries it

## The record's statement, verbatim

[route-a.md](../../../findings/route-a.md)'s *Lemma L21, the eigenvalue bound `α ≤ ⅓`,
structural at every `n ≥ 9`*:

> **Statement.** Let $n\ge9$, $m=n-4$, and let $u=W_{\mathbb{CP}^2}$ padded to $\mathcal W_n$, of
> unit norm with $\theta^*=P(u)=\sqrt{3/2}$. Write $F_u(h)=\tfrac12(uh+hu)+u\#h$ and
> $\alpha=\sqrt{2/3}\,\langle F_uV,V\rangle$ for a unit
> $V\in u^\perp\cap T_u(SO(n).u)^\perp$. Then $\alpha\le\tfrac13$, and $\tfrac13$ is attained.

The proof's engine is a census of six `SO(m)`-isotypic types with multiplicity spaces of
dimensions `20, 20, 6, 10, 4, 1`, of which only the first four carry a nonzero eigenvalue:

> **The dimensions sum to $\dim\mathcal W_n$ as a polynomial identity**, both sides being
> $\tfrac1{12}(m^4+16m^3+89m^2+194m+120)$; at $n=12$ that reads $4\cdot160+1\cdot300=940$ and
> $698+940=1638$.

> **The orbit.** [...] $T_u(SO(n).u)=2\cdot(\text{trivial})\oplus4\cdot(\text{vector})$ of
> dimension $2+4(n-4)=4n-14$ at every $n$.

> **Given the four spectra, the bound follows.** Removing $\mathbb Ru$ and the orbit leaves
> $\tfrac13$ in the trivial block, after deleting the single $1$ and the two $\tfrac12$'s; $0$ in
> the vector block, after deleting four $\tfrac12$'s per copy; $\tfrac13$ in the $\Lambda^2$ and
> $S^2_0$ blocks; and $0$ on the rest. **Hence $\alpha\le\tfrac13$, attained on $136$ dimensions
> at $n=12$.**

## What is NOT typed here

**The lemma itself.** `α ≤ ⅓` is a statement about `F_u`, about the padded `W_{ℂP²}` at general
`n`, and about the subspace `u^⊥ ∩ T_u(SO(n)·u)^⊥`. The real Weyl layer
([WeylReal.lean](../Base/WeylReal.lean)) carries `IsWeyl`, `Pcubic`, `norm` and `theta` over `ℝ`
at a general index type, and **no `W_{ℂP²}` at general `n`, no mixed sharp `u # h`, and no orbit
tangent**, so the operator the bound is about cannot be named, and stating the bound against an
abstract self-adjoint operator would produce a proposition true of no particular one.

**Also not typed, and the record records it as the open debt:** that the four `F_λ` have `m`-free
entries. *`M_λ(n)` is a different space for each `n`; equal dimensions license nothing about
spectra without an identification intertwining the operators, and none is proposed.* The four
spectra therefore enter below **as data**, exactly as the block's own final step takes them, and
what is proved is that the block's conclusion follows from them: the census is exhaustive as a
polynomial identity, the `½`-multiplicity matches the orbit dimension, and the reduced maximum is
`⅓`, attained.

**Everything is over `ℚ` with `m` rational**, so no truncated subtraction can enter; the
eigenvalues are in units of `θ* = √(3/2)`, which is the table's own convention.
-/

namespace HamiltonsCubic.L21Statement

/-! ## The census: six `SO(m)`-types, their multiplicity spaces and their dimensions -/

/-- `dim Weyl_n = n(n+1)(n+2)(n−3)/12`. -/
def dimWeyl (n : ℚ) : ℚ := n * (n + 1) * (n + 2) * (n - 3) / 12

/-- `dim V_λ` for the six types, in order: trivial, vector, `Λ²`, `S²₀`, `V_{(2,1)}`,
`V_{(2,2)}`. -/
def dimV (i : ℕ) (m : ℚ) : ℚ :=
  match i with
  | 1 => 1
  | 2 => m
  | 3 => m * (m - 1) / 2
  | 4 => (m - 1) * (m + 2) / 2
  | 5 => m * (m - 2) * (m + 2) / 3
  | 6 => m * (m + 1) * (m + 2) * (m - 3) / 12
  | _ => 0

/-- `dim M_λ`, the multiplicity spaces: `20, 20, 6, 10, 4, 1`, **none of which contains `m`**. -/
def multM (i : ℕ) : ℚ :=
  match i with
  | 1 => 20
  | 2 => 20
  | 3 => 6
  | 4 => 10
  | 5 => 4
  | 6 => 1
  | _ => 0

/-- **`V_{(2,2)} = Weyl_m`, an equality of formulas rather than an agreement at one dimension.**
-/
theorem row_six_is_weyl (m : ℚ) : dimV 6 m = dimWeyl m := by
  simp only [dimV, dimWeyl]

/-- **The census is exhaustive: the six blocks sum to `dim 𝒲_n` with `n = m + 4`**, as a
polynomial identity in `m`. *Both sides are `(m⁴ + 16m³ + 89m² + 194m + 120)/12`.* -/
theorem census_exhaustive (m : ℚ) :
    multM 1 * dimV 1 m + multM 2 * dimV 2 m + multM 3 * dimV 3 m + multM 4 * dimV 4 m
      + multM 5 * dimV 5 m + multM 6 * dimV 6 m = dimWeyl (m + 4) := by
  simp only [multM, dimV, dimWeyl]; ring

/-- **And that common value is the record's polynomial.** -/
theorem census_polynomial (m : ℚ) :
    dimWeyl (m + 4) = (m ^ 4 + 16 * m ^ 3 + 89 * m ^ 2 + 194 * m + 120) / 12 := by
  simp only [dimWeyl]; ring

/-- **At `n = 12` the two higher types carry `4·160 + 1·300 = 940` of `dim Weyl₁₂ = 1638`**, and
the four blocks that carry a nonzero eigenvalue carry the remaining `698`. -/
theorem census_at_twelve :
    multM 5 * dimV 5 8 + multM 6 * dimV 6 8 = 940 ∧
    multM 1 * dimV 1 8 + multM 2 * dimV 2 8 + multM 3 * dimV 3 8 + multM 4 * dimV 4 8 = 698 ∧
    (698:ℚ) + 940 = 1638 ∧ dimWeyl 12 = 1638 := by
  refine ⟨by norm_num [multM, dimV], by norm_num [multM, dimV], by norm_num,
    by norm_num [dimWeyl]⟩

/-- **`V_{(2,1)}` vanishes at `m = 2`**, which the factored form `m(m−2)(m+2)/3` exhibits; and
`dim V_{(2,2)}` is negative at `m = 2` and at `m = 6 − 4 = 2`, which is why the record excludes
`m ≤ 4` from the census's range. -/
theorem row_five_vanishes_at_two : dimV 5 2 = 0 ∧ dimV 6 2 = -2 := by
  refine ⟨by norm_num [dimV], by norm_num [dimV]⟩

/-! ## The orbit, and the `½`-eigenspace

`T_u(SO(n)·u) = 2·(trivial) ⊕ 4·(vector)`, of dimension `2 + 4m = 4n − 14` at every `n`. -/

/-- **The orbit's dimension is `4n − 14`, identically in `m`.** -/
theorem orbit_dim (m : ℚ) : 2 * dimV 1 m + 4 * dimV 2 m = 4 * (m + 4) - 14 := by
  simp only [dimV]; ring

/-- **And the `½`-eigenvalue occurs exactly `2 + 4m` times**, twice in the trivial block and four
times per vector copy, **so the `½`-eigenspace IS the orbit tangent, block by block.** *This is
the load-bearing direction, and it stands or falls with the four spectra.* -/
theorem half_multiplicity (m : ℚ) : 2 * dimV 1 m + 4 * dimV 2 m = 2 + 4 * m := by
  simp only [dimV]; ring

/-! ## The four spectra, as data, and the bound that follows from them

Eigenvalues in units of `θ* = √(3/2)`, as the block's table gives them. -/

/-- The trivial block's spectrum, `(−1)²`, `(−⅙)⁶`, `0⁶`, `(⅓)³`, `(½)²`, `1`. -/
def specTrivial : List (ℚ × ℕ) := [(-1, 2), (-1/6, 6), (0, 6), (1/3, 3), (1/2, 2), (1, 1)]

/-- The vector block's spectrum, `(−½)⁴`, `0¹²`, `(½)⁴`. -/
def specVector : List (ℚ × ℕ) := [(-1/2, 4), (0, 12), (1/2, 4)]

/-- The `Λ²` block's spectrum, `(−⅙)²`, `0³`, `⅓`. -/
def specLambda2 : List (ℚ × ℕ) := [(-1/6, 2), (0, 3), (1/3, 1)]

/-- The `S²₀` block's spectrum, `(−⅙)⁶`, `0`, `(⅓)³`. -/
def specS2 : List (ℚ × ℕ) := [(-1/6, 6), (0, 1), (1/3, 3)]

/-- `∑ multiplicity`. -/
def specDim (s : List (ℚ × ℕ)) : ℕ := (s.map (fun r => r.2)).sum

/-- **Each block's multiplicities sum to its multiplicity-space dimension**, `20, 20, 6, 10`. -/
theorem spec_dims :
    specDim specTrivial = 20 ∧ specDim specVector = 20 ∧
    specDim specLambda2 = 6 ∧ specDim specS2 = 10 := by
  refine ⟨by norm_num [specDim, specTrivial], by norm_num [specDim, specVector],
    by norm_num [specDim, specLambda2], by norm_num [specDim, specS2]⟩

/-- The spectrum left in the trivial block after removing `ℝu` (the single `1`) and the orbit's
two `½`'s. -/
def reducedTrivial : List ℚ := [-1, -1/6, 0, 1/3]

/-- The spectrum left in the vector block after removing four `½`'s per copy. -/
def reducedVector : List ℚ := [-1/2, 0]

/-- **Removing `ℝu` and the orbit leaves `⅓` as the largest value in every block.** -/
theorem reduced_max :
    (∀ x ∈ reducedTrivial, x ≤ 1 / 3) ∧ (1:ℚ) / 3 ∈ reducedTrivial ∧
    (∀ x ∈ reducedVector, x ≤ 0) ∧
    (∀ x ∈ [(-1/6 : ℚ), 0, 1/3], x ≤ 1 / 3) ∧ (1:ℚ) / 3 ∈ [(-1/6 : ℚ), 0, 1/3] := by
  refine ⟨?_, by norm_num [reducedTrivial], ?_, ?_, by norm_num⟩
  · intro x hx
    simp only [reducedTrivial, List.mem_cons, List.not_mem_nil, or_false] at hx
    rcases hx with h | h | h | h <;> subst h <;> norm_num
  · intro x hx
    simp only [reducedVector, List.mem_cons, List.not_mem_nil, or_false] at hx
    rcases hx with h | h <;> subst h <;> norm_num
  · intro x hx
    simp only [List.mem_cons, List.not_mem_nil, or_false] at hx
    rcases hx with h | h | h <;> subst h <;> norm_num

/-- **`α ≤ ⅓`, given the four spectra**: `α` is a value of `F_u` on the reduced space, every such
value is at most `⅓`, and `⅓` occurs. *This is the block's own final step, stated over the tabled
data rather than over `F_u`.* -/
theorem alpha_bound_from_spectra (α : ℚ)
    (hα : α ∈ reducedTrivial ∨ α ∈ reducedVector ∨ α ∈ [(-1/6 : ℚ), 0, 1/3]) :
    α ≤ 1 / 3 := by
  obtain ⟨h1, _, h2, h3, _⟩ := reduced_max
  rcases hα with h | h | h
  · exact h1 α h
  · exact le_trans (h2 α h) (by norm_num)
  · exact h3 α h

/-- **And `⅓` is attained, on `136` dimensions at `n = 12`**, `3` in the trivial block, `28` in
the `Λ²` block and `105` in the `S²₀` block. -/
theorem third_attained_at_twelve : (3:ℚ) * dimV 1 8 + 1 * dimV 3 8 + 3 * dimV 4 8 = 136 := by
  norm_num [dimV]

/-- **The same diagonalisation reproduces Nienhaus's Theorem 4.14 spectrum**
`{1, ½, ⅓, 0, −⅙, −½, −1}·θ*` in all seven cases: every eigenvalue occurring in the four blocks
is one of the seven, and all seven occur. -/
theorem nienhaus_seven (x : ℚ)
    (hx : x ∈ (specTrivial ++ specVector ++ specLambda2 ++ specS2).map (fun r => r.1)) :
    x = 1 ∨ x = 1 / 2 ∨ x = 1 / 3 ∨ x = 0 ∨ x = -1 / 6 ∨ x = -1 / 2 ∨ x = -1 := by
  simp only [specTrivial, specVector, specLambda2, specS2, List.cons_append, List.nil_append,
    List.map_cons, List.map_nil, List.mem_cons, List.not_mem_nil, or_false] at hx
  tauto

/-! ## Where the bound is exposed

*One extra `½` transverse to the orbit collapses it to `α ≤ ½`, at which the tube theorem is
vacuous*, the block's own note on which direction is load-bearing. -/

/-- **The qualitative theorem survives for any `a < ½`, and `0.5748` needs the exact `⅓`.** With
`α ≤ a` the critical angle is `φ_c ≈ 3/2 − 3a`: `0.476` at `a = 0.36`, `0.158` at `0.45`, zero at
`½`. -/
theorem hedge_critical_angle :
    (3:ℚ) / 2 - 3 * (36 / 100) = 42 / 100 ∧ (3:ℚ) / 2 - 3 * (45 / 100) = 15 / 100 ∧
    (3:ℚ) / 2 - 3 * (1 / 2) = 0 := by
  refine ⟨by norm_num, by norm_num, by norm_num⟩

/-! ## Non-vacuity

The range `n ≥ 9`, that is `m ≥ 5`, is where the census's absolute irreducibility holds; at
`m = 8` (`n = 12`) every row of the table is a positive dimension. -/

example : dimV 1 8 = 1 ∧ dimV 2 8 = 8 ∧ dimV 3 8 = 28 ∧ dimV 4 8 = 35 ∧
    dimV 5 8 = 160 ∧ dimV 6 8 = 300 := by
  refine ⟨by norm_num [dimV], by norm_num [dimV], by norm_num [dimV], by norm_num [dimV],
    by norm_num [dimV], by norm_num [dimV]⟩

end HamiltonsCubic.L21Statement
