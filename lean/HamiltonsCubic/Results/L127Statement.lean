import Mathlib

set_option linter.style.longLine false
set_option linter.unusedSectionVars false

/-!
# L127, the block-level refinement of L27: which block each `½` comes from

## The record's statement, verbatim

> #### Lemma L127, the block-level refinement of Lemma L27: which block each $\tfrac12$ comes from
>
> **At $S^p\times S^q$ with sectional matrix $\alpha$ within the first factor, $\beta$ within the
> second and $\gamma$ across, the $L_e$-spectrum splits by Lemma L120's block families as:**
>
> | block family | count | top $L_e$-eigenvalue | reaches $\tfrac12$ **exactly**? |
> |---|---|---|---|
> | four-set | $\binom n4$ | $\mu_{p,q}=\dfrac{n-2}{2(p-1)(q-1)}$ on the $(2,2)$-splits, $0$ otherwise | only at $(3,3)$ (Lemma L126) |
> | pair, **cross-factor** | $pq$ | spectrum is exactly $\big\{\tfrac12\ \text{simple},\ 0^{\,n-4}\big\}$ | yes, along the orbit |
> | pair, **within-factor** | $\binom p2$ and $\binom q2$, **two families** | $\dfrac{p-2}{2(p-1)}$ and $\dfrac{q-2}{2(q-1)}$ respectively, both $<\tfrac12$, **at $p,q\ge3$** | no |
> | $\mathcal D_n$ | $1$ | $\sigma(L_e|_{\mathcal D_n})=\{1,\ \lambda_p^{\,p-1},\ \lambda_q^{\,q-1},\ (-\mu)^{(p-1)(q-1)},\ 0^{\text{rest}}\}$, from Lemma L27's summands | no |
>
> > **THE COLUMN ASKS $=\tfrac12$, AND EVERY ROW IS CORRECT UNDER THAT READING ONLY.** Lemma L24
> > needs $\ge\tfrac12$, and under *that* reading the four-set row's "only at $(3,3)$" is false at
> > $\min(p,q)=2$, where $\mu_{2,q}>\tfrac12$.
> >
> > **AND THE WITHIN-FACTOR ROW IS FALSE AT $p=2$**: the $\lambda_p$-eigenvector needs
> > $F_1\setminus\{j,k\}$ nonempty, so at $p=2$ the block is entirely $-\mu$ and the stated top
> > $\tfrac{p-2}{2(p-1)}=0$ is **not in the spectrum at all**, at $S^2\times S^4$ it is
> > $(-\tfrac23)^3$ against a printed $0$.
> >
> > **The whole within-factor spectrum, which the table does not print, is
> > $\{\lambda_p,\ (-\mu)^{q-1},\ 0^{p-3}\}$.**
>
> **The table is forced, not merely consistent.** Lemma L27 decomposes $L_e$ by $O(p)\times O(q)$
> representation and this table by sign-character block family, two unrelated decompositions of
> one operator, and they agree on the **full spectrum with multiplicity, identically in $p,q$**,
> through
> $$(p-1)+\binom p2=\dim S^2_0(\mathbb R^p),\qquad \binom p2\binom q2+(p-1)(q-1)+\binom p2(q-1)+\binom q2(p-1)=\dim\bigl(S^2_0\otimes S^2_0\bigr).$$
> **So the $\mathcal D_n$ row is forced by L27 together with the other three rows**, rather than
> merely compatible with them, and $\operatorname{tr}L_e=0$ sums to zero off the table as well.
>
> **Proof of the cross-factor row.** The index set $(F_1\setminus j)\cup(F_2\setminus k)$ is an
> equitable two-block partition, so Lemma L122's Laplacian has three eigenvector types on
> $\mathbf1^\perp$. *Sum-zero within $F_1\setminus j$*: eigenvalue $(p-1)\alpha+(q-1)\gamma$,
> which Ricci-flatness $(p-1)\alpha+q\gamma=0$ makes $-\gamma$, so the block value is $0$, with
> multiplicity $p-2$; *within $F_2\setminus k$*: identically $0$, by $(q-1)\beta+p\gamma=0$, with
> multiplicity $q-2$. *Constant on each part*: block value $-\tfrac12(n-1)\gamma$. Multiplicities
> total $n-3$. $\square$
>
> **The third type is the orbit direction**, $x_i=M_{ki}-M_{ji}$ is $\gamma-\alpha$ on
> $F_1\setminus j$ and $\beta-\gamma$ on $F_2\setminus k$, so its value is $\theta/2$ and
> $\theta=(n-1)\lvert\gamma\rvert$.
>
> > **WHAT THIS ADDS TO Lemma L27, AND WHAT IT DOES NOT.** *Adds*: the **attribution**, each
> > $\tfrac12$ is one cross-factor pair block, $pq$ of them, matching
> > $\dim\mathcal O=\dim SO(n)-\binom p2-\binom q2=pq$; the exact cross-factor spectrum; and the
> > two within-factor tops. *Does not*: establish nondegeneracy independently.
> >
> > **AND THE CLAUSE "NO NON-DIAGONAL CRITICAL POINT BRANCHES OFF IT" IS WITHDRAWN.**
>
> **Agreement**: the arithmetic reproduces the record's $\dim E(\tfrac12)=18$ at $S^3\times S^3$,
> nine cross-factor pair blocks against the nine-dimensional orbit, plus nine four-set blocks,
> and its six orbit-free within-factor blocks among fifteen.

[second-order.md](../../../findings/second-order.md), Lemma L127.

## What this file states

Everything in the table that is arithmetic, PROVED, with no `sorry`:

- the **block counts**, and the identity `C(p,2) + C(q,2) + pq = C(p+q,2)`, that is,
  `pq = dim SO(n) − C(p,2) − C(q,2)`, which matches the cross-factor count to `dim 𝒪`. *It is
  stated additively so that no `ℕ`-subtraction enters the claim.*
- the **four-set row's value** `μ_{p,q}` and its `= ½` clause at `(3,3)` alone, imported in shape
  from L126 and reproved here so the file stands alone, together with the box's correction
  `μ_{2,q} > ½`, which is why the column has to read `= ½` and not `≥ ½`;
- the **cross-factor row**: the multiplicity bookkeeping `1 + (n−4) = n−3` and the proof's own
  count `(p−2) + (q−2) + 1 = n−3`, and the Ricci-flatness cancellations
  `(p−1)α + (q−1)γ = −γ` and `(q−1)β + (p−1)γ = −γ` that make the two within-part types give
  block value `0`;
- the **within-factor row**: the top `(p−2)/(2(p−1))` is `< ½` at every `p ≥ 2`, it is `0` at
  `p = 2` where the box says it is not in the spectrum at all, and the unprinted whole spectrum
  `{λ_p, (−μ)^{q−1}, 0^{p−3}}` has the right size `1 + (q−1) + (p−3) = n−3`;
- the **two dimension identities** that force the `𝒟ₙ` row, `(p−1) + C(p,2) = dim S²₀(ℝᵖ)` and the
  four-term one; `dim S²₀(ℝᵖ) = p(p+1)/2 − 1` is written `C(p+1,2) − 1`, the same number with no
  division, and the four-term identity is the same factorisation applied twice;
- the **`S³ × S³` agreement**: `pq = 9`, nine `(2,2)`-split four-set blocks, `9 + 9 = 18`, and six
  within-factor blocks among the fifteen pair blocks.

## What is NOT typed here

**No eigenvalue of anything is named.** `L_e`, the Fox product, `L120`'s sign-character blocks,
`L122`'s pair Laplacian and the `𝒟ₙ` summand list are outside the `RealLayer`, so the claims that
these numbers *are* the `L_e`-spectra of those blocks are absent, and with them:

- that the cross-factor block spectrum *is* `{½ simple, 0^{n−4}}` and that the `½` lies **along
  the orbit**, only the counts and the two Ricci cancellations are typed;
- the `𝒟ₙ` row's spectrum `{1, λ_p^{p−1}, λ_q^{q−1}, (−μ)^{(p−1)(q−1)}, 0^rest}`, whose entries
  `λ_p, λ_q, μ` are L27's summand eigenvalues;
- **that the two decompositions agree on the full spectrum with multiplicity**, of which only the
  two dimension counts are typed, agreement of *values* needs `L_e`;
- the orbit-direction identification `θ = (n−1)|γ|` and `tr L_e = 0`.

*The record's withdrawn branching clause is deliberately absent.*
-/

namespace HamiltonsCubic.L127Statement

/-! ## The four-set row -/

/-- `μ_{p,q} = (n−2)/(2(p−1)(q−1))` with `n = p + q`, the common four-set value on the
`(2,2)`-splits. *Over `ℝ` with `p, q : ℕ` cast in: the record's `p−1` and `n−2` are ordinary
differences, and `ℕ`-truncation would silently change them.* -/
noncomputable def mu (p q : ℕ) : ℝ := ((p : ℝ) + q - 2) / (2 * ((p : ℝ) - 1) * ((q : ℝ) - 1))

/-- **The four-set row's `= ½` clause**: at `p, q ≥ 2` the value reaches `½` exactly at `(3,3)`. -/
theorem mu_eq_half_iff (p q : ℕ) (hp : 2 ≤ p) (hq : 2 ≤ q) :
    mu p q = 1 / 2 ↔ p = 3 ∧ q = 3 := by
  have hp1 : (0 : ℝ) < (p : ℝ) - 1 := by
    have : (2 : ℝ) ≤ (p : ℝ) := by exact_mod_cast hp
    linarith
  have hq1 : (0 : ℝ) < (q : ℝ) - 1 := by
    have : (2 : ℝ) ≤ (q : ℝ) := by exact_mod_cast hq
    linarith
  constructor
  · intro h
    have hcl : ((p : ℝ) + q - 2) * 2 = 2 * ((p : ℝ) - 1) * ((q : ℝ) - 1) := by
      unfold mu at h
      rw [div_eq_div_iff (by positivity) (by norm_num)] at h
      linarith
    have hz : ((p : ℝ) - 2) * ((q : ℝ) - 2) = 1 := by nlinarith [hcl]
    have hzi : ((p : ℤ) - 2) * ((q : ℤ) - 2) = 1 := by exact_mod_cast hz
    have hpz : (2 : ℤ) ≤ (p : ℤ) := by exact_mod_cast hp
    have hqz : (2 : ℤ) ≤ (q : ℤ) := by exact_mod_cast hq
    rcases Int.eq_one_or_neg_one_of_mul_eq_one' hzi with ⟨h1, h2⟩ | ⟨h1, h2⟩
    · omega
    · omega
  · rintro ⟨rfl, rfl⟩
    unfold mu; norm_num

/-- **The box's correction.** At `min(p,q) = 2` the value strictly exceeds `½`, so the table's
column has to ask `= ½`; under Lemma L24's `≥ ½` the row's "only at `(3,3)`" is false. -/
theorem mu_two_gt_half (q : ℕ) (hq : 2 ≤ q) : 1 / 2 < mu 2 q := by
  have hq1 : (0 : ℝ) < (q : ℝ) - 1 := by
    have : (2 : ℝ) ≤ (q : ℝ) := by exact_mod_cast hq
    linarith
  have hval : mu 2 q = (q : ℝ) / (2 * ((q : ℝ) - 1)) := by unfold mu; norm_num
  rw [hval, lt_div_iff₀ (by positivity)]
  linarith

/-! ## The within-factor row, and its failure at `p = 2` -/

/-- The printed within-factor top, `(p−2)/(2(p−1))`. -/
noncomputable def withinTop (p : ℕ) : ℝ := ((p : ℝ) - 2) / (2 * ((p : ℝ) - 1))

/-- **Both within-factor tops are `< ½`**, which is the row's conclusion. *The record qualifies it
with `p, q ≥ 3`; the inequality in fact holds from `p ≥ 2`, and at `p = 2` it is the separate
defect below that bites, not this one.* -/
theorem withinTop_lt_half (p : ℕ) (hp : 2 ≤ p) : withinTop p < 1 / 2 := by
  have hp1 : (0 : ℝ) < (p : ℝ) - 1 := by
    have : (2 : ℝ) ≤ (p : ℝ) := by exact_mod_cast hp
    linarith
  unfold withinTop
  rw [div_lt_div_iff₀ (by positivity) (by norm_num)]
  linarith

/-- **The printed value is `0` at `p = 2`**, where the box records that the block is entirely
`−μ`, so `0` is not in the spectrum at all. -/
theorem withinTop_two : withinTop 2 = 0 := by unfold withinTop; norm_num

/-- And it is nonzero from `p = 3` on, so the row's *value* is wrong only at `p = 2`. -/
theorem withinTop_ne_zero (p : ℕ) (hp : 3 ≤ p) : withinTop p ≠ 0 := by
  have hp2 : (3 : ℝ) ≤ (p : ℝ) := by exact_mod_cast hp
  have hd : (0 : ℝ) < 2 * ((p : ℝ) - 1) := by linarith
  unfold withinTop
  exact div_ne_zero (by linarith) (ne_of_gt hd)

/-- **The unprinted whole within-factor spectrum `{λ_p, (−μ)^{q−1}, 0^{p−3}}` has `n − 3`
entries**, matching the pair block's dimension after the Ricci cut. -/
theorem within_spectrum_size (p q : ℕ) (hp : 3 ≤ p) (hq : 1 ≤ q) :
    1 + (q - 1) + (p - 3) = p + q - 3 := by omega

/-! ## The cross-factor row -/

/-- The cross-factor block carries `n − 3` eigenvalues: one `½` and `n − 4` zeros. -/
theorem cross_spectrum_size (n : ℕ) (hn : 4 ≤ n) : 1 + (n - 4) = n - 3 := by omega

/-- **The proof's own multiplicity count**: `(p−2)` sum-zero directions within `F₁∖j`, `(q−2)`
within `F₂∖k`, and one constant-on-parts direction, totalling `n − 3`. -/
theorem cross_multiplicities (p q : ℕ) (hp : 2 ≤ p) (hq : 2 ≤ q) :
    (p - 2) + (q - 2) + 1 = p + q - 3 := by omega

/-- **The first Ricci cancellation.** `(p−1)α + (q−1)γ = −γ` whenever `(p−1)α + qγ = 0`, so the
sum-zero directions within `F₁∖j` give block value `0`. -/
theorem ricci_cancel_first (p q : ℕ) (α γ : ℝ) (h : ((p : ℝ) - 1) * α + (q : ℝ) * γ = 0) :
    ((p : ℝ) - 1) * α + ((q : ℝ) - 1) * γ = -γ := by linarith [h]

/-- **The second Ricci cancellation.** `(q−1)β + (p−1)γ = −γ` whenever `(q−1)β + pγ = 0`. -/
theorem ricci_cancel_second (p q : ℕ) (β γ : ℝ) (h : ((q : ℝ) - 1) * β + (p : ℝ) * γ = 0) :
    ((q : ℝ) - 1) * β + ((p : ℝ) - 1) * γ = -γ := by linarith [h]

/-! ## The block counts, and the `½`-count matches the orbit dimension -/

/-- `2·C(n,2) = n(n−1)`, the division-free form of the binomial. -/
theorem two_choose_two (n : ℕ) : 2 * Nat.choose n 2 = n * (n - 1) := by
  rcases n with _ | m
  · simp
  · rw [Nat.choose_two_right]
    have hdvd : 2 ∣ (m + 1) * (m + 1 - 1) := by
      simp only [Nat.add_sub_cancel, Nat.mul_comm]
      exact (Nat.even_mul_succ_self m).two_dvd
    exact Nat.mul_div_cancel' hdvd

/-- **`C(p,2) + C(q,2) + pq = C(p+q,2)`**, i.e. `pq = dim SO(n) − C(p,2) − C(q,2)` at `n = p + q`:
the number of cross-factor pair blocks is exactly `dim 𝒪`, so the `½`-count matches the orbit
dimension **because the blocks are `pq`** rather than by a separate coincidence. *Stated
additively, so no `ℕ`-subtraction enters the claim.* -/
theorem cross_count_eq_orbit_dim (p q : ℕ) :
    Nat.choose p 2 + Nat.choose q 2 + p * q = Nat.choose (p + q) 2 := by
  have key : ∀ a b : ℕ, a * (a - 1) + b * (b - 1) + 2 * (a * b) = (a + b) * (a + b - 1) := by
    intro a b
    cases a with
    | zero => simp
    | succ a' =>
      cases b with
      | zero => simp
      | succ b' =>
        have e1 : a' + 1 - 1 = a' := by omega
        have e2 : b' + 1 - 1 = b' := by omega
        have e3 : (a' + 1) + (b' + 1) - 1 = a' + b' + 1 := by omega
        rw [e1, e2, e3]
        ring
  have hdouble : 2 * (Nat.choose p 2 + Nat.choose q 2 + p * q) = 2 * Nat.choose (p + q) 2 := by
    rw [Nat.mul_add, Nat.mul_add, two_choose_two p, two_choose_two q, two_choose_two (p + q)]
    exact key p q
  exact Nat.eq_of_mul_eq_mul_left (by norm_num) hdouble

/-! ## The two dimension identities that force the `𝒟ₙ` row -/

/-- `C(p+1,2) = p + C(p,2)`, Pascal at the second column. -/
theorem choose_two_succ (p : ℕ) : Nat.choose (p + 1) 2 = p + Nat.choose p 2 := by
  simp [Nat.choose_succ_succ]

/-- **`(p−1) + C(p,2) = dim S²₀(ℝᵖ)`**, the first of the two counts through which L27's
`O(p)×O(q)` decomposition and this table's block decomposition agree. *`dim S²₀(ℝᵖ) = p(p+1)/2 − 1`
is written `C(p+1,2) − 1`, which is the same number with no division.* -/
theorem dim_symTraceless (p : ℕ) (hp : 1 ≤ p) :
    (p - 1) + Nat.choose p 2 = Nat.choose (p + 1) 2 - 1 := by
  rw [choose_two_succ p]
  omega

/-- **The four-term identity**, which is the same factorisation twice:
`C(p,2)C(q,2) + (p−1)(q−1) + C(p,2)(q−1) + C(q,2)(p−1) = [(p−1)+C(p,2)]·[(q−1)+C(q,2)]`,
and the right side is `dim(S²₀ ⊗ S²₀)`. -/
theorem dim_tensor_split (p q : ℕ) :
    Nat.choose p 2 * Nat.choose q 2 + (p - 1) * (q - 1) + Nat.choose p 2 * (q - 1)
        + Nat.choose q 2 * (p - 1)
      = ((p - 1) + Nat.choose p 2) * ((q - 1) + Nat.choose q 2) := by
  ring

/-! ## The `S³ × S³` agreement -/

/-- Nine cross-factor pair blocks at `S³ × S³`, matching the nine-dimensional orbit. -/
theorem s3s3_cross : 3 * 3 = 9 := by norm_num

/-- Nine `(2,2)`-split four-set blocks at `S³ × S³`: `C(3,2)·C(3,2)`. -/
theorem s3s3_foursets : Nat.choose 3 2 * Nat.choose 3 2 = 9 := by decide

/-- **`dim E(½) = 18` at `S³ × S³`**, nine from cross-factor pair blocks and nine from four-set
blocks, the latter because `μ_{3,3} = ½` exactly. -/
theorem s3s3_half_eigenspace : 3 * 3 + Nat.choose 3 2 * Nat.choose 3 2 = 18 := by decide

/-- `μ₃,₃ = ½`, which is what puts the nine four-set blocks into `E(½)`. -/
theorem mu_three_three : mu 3 3 = 1 / 2 := by unfold mu; norm_num

/-- **Six orbit-free within-factor blocks among fifteen pair blocks** at `S³ × S³`. -/
theorem s3s3_within : Nat.choose 3 2 + Nat.choose 3 2 = 6 ∧ Nat.choose 6 2 = 15 := by decide

/-! ## Witnesses, so the hypotheses are not empty

*`(3,3)` meets the four-set threshold and `(2,4)` breaches it, so neither side of the `= ½` clause
is vacuous; and a Ricci-flat sectional triple exists, so the two cancellations are not vacuous.* -/

example : mu 3 3 = 1 / 2 := mu_three_three

example : 1 / 2 < mu 2 4 := mu_two_gt_half 4 (by norm_num)

/-- `p = q = 3`, `γ = -1`, `α = β = 3/2`: `(p−1)α + qγ = 2·(3/2) − 3 = 0`. -/
example : ((3 : ℕ) : ℝ) - 1 = 2 ∧ (((3 : ℕ) : ℝ) - 1) * (3 / 2) + ((3 : ℕ) : ℝ) * (-1) = 0 := by
  norm_num

end HamiltonsCubic.L127Statement
