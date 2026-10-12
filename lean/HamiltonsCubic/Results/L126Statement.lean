import Mathlib

set_option linter.style.longLine false

/-!
# L126, the four-set `½`-threshold, met in the two-factor family only at `S³ × S³`

## The record's statement, verbatim

> #### Lemma L126, the four-set $\tfrac12$-threshold, met in the two-factor family only at $S^3\times S^3$
>
> **Let $M$ be a diagonal critical point **of unit norm** with $\theta>0$, which $P(M)=\theta$
> requires. On the tangent space the criticality map $F(W)=Q(W)-P(W)W$ has $DF(M)=\theta(2L_e-
> \mathrm{Id})$, so $\ker DF(M)$ is the $\tfrac12$-eigenspace of $L_e$, which by Lemma L121 a
> four-set block meets exactly when $\Sigma_{ijkl}=\theta^2$. The four-set blocks are orbit-free:
> the orbit tangent for the $(j,k)$ generator lies in the $\{j,k\}$ pair block, so the orbit's
> tangent space lies in the span of the pair blocks.**
>
> **At $S^p\times S^q$, $n=p+q$, the nonzero four-set blocks are the $(2,2)$-splits, with the
> common value $\mu_{p,q}=\dfrac{n-2}{2(p-1)(q-1)}$, and**
> $$\mu_{p,q}=\tfrac12\iff\frac1{p-1}+\frac1{q-1}=1\iff(p,q)=(3,3),$$
> **the second step being $(u-1)(v-1)=1$** for $u=p-1$, $v=q-1$, which over the integers leaves
> $u=v=2$ alone. *The derivation is valid at $p,q\ge2$; $p=1$ is excluded structurally,
> Ricci-flatness forcing $M\equiv0$ there.*
>
> **And the threshold is met off the $(2,2)$-splits once padding enters.** A four-set carrying two
> indices from the first factor, one from the second and one **padded** index has $L_e$ value
> $\frac1{2(p-1)}$, which is exactly $\tfrac12$ at $p=2$ for every $q$.
>
> > **WHAT THE LEMMA IS FOR.** $\mu_{2,q}=\dfrac q{2(q-1)}>\tfrac12$ at every $q$, so **no
> > $S^2\times S^q$ is a local maximum**, its four-set block breaches Lemma L24 outright.
>
> **Agreement on the values.** $\mu_{2,4}=\tfrac23$ and $\mu_{2,6}=\tfrac35$ are the record's
> padding-invariant four-set eigenvalues, and $\mu_{2,2}=1$ matches its $(2,2)$ spectrum.

[second-order.md](../../../findings/second-order.md), Lemma L126.

## What this file states

**The threshold and its Diophantine step, which are the two clauses both Gate 2 reviewers
confirmed, are stated and PROVED in full**, the equivalence `μ_{p,q} = ½ ↔ (p,q) = (3,3)` over
the integers `p, q ≥ 2`, together with the intermediate reciprocal form, the strict breach
`μ_{2,q} > ½` at every `q ≥ 2`, the padded four-set value `1/(2(p-1))` and its `p = 2` case, and
the three recorded values `μ₂,₄ = ⅔`, `μ₂,₆ = ⅗`, `μ₂,₂ = 1`.

`mu` is defined over `ℝ` with `p, q : ℕ` cast in. **The subtraction is the reason**: the record's
`p-1` and `n-2` are ordinary differences, and over `ℕ` truncation would make `μ_{1,q}` a division
by zero rather than the structurally excluded case the record names.

## What is NOT typed here

**The identification of `μ_{p,q}` as an `L_e` eigenvalue lives in other files**, which postdate this
one: `DF(M) = θ(2L_e - Id)` and its kernel in [L126Kernel.lean](L126Kernel.lean), orbit-freeness in
[L126Orbit.lean](L126Orbit.lean), the eigenvalue `+μ_{p,q}` of the Bianchi vector of each
`(2,2)`-split four-set block in [L126Assembly.lean](L126Assembly.lean), carried to `LeLin` on
`CurvOp2` in [L126Bridge.lean](L126Bridge.lean) (`split_LeLin`), and the vanishing of every
other split's Bianchi part with the second eigenvector `b − c` in [L126Splits.lean](L126Splits.lean),
`v ≠ 0` and the algebraic kernel clause in [L126Final.lean](L126Final.lean), its reading as the
derivative of the criticality map in [L126DF.lean](L126DF.lean), and the clause at a general diagonal
`M` in [L126General.lean](L126General.lean), the Weyl property of the direction in
[L126Weyl.lean](L126Weyl.lean), and the general-`M` clause on `LeLin` and `DF(M)` in
[L126GenBridge.lean](L126GenBridge.lean), all composed in [L126Main.lean](L126Main.lean). Here `mu` is the record's
closed form, and the consequence "no `S² × S^q` is a local maximum" is stated as the arithmetic
breach `μ_{2,q} > ½`.

*The record's own box is also kept out of the Lean: a `½` is a necessary condition for a branch and
not a sufficient one, and at `S³ × S³` no branch emanates along the arcs tested.*
-/

namespace HamiltonsCubic.L126Statement

/-- **`μ_{p,q} = (n-2)/(2(p-1)(q-1))` with `n = p + q`**, the common four-set value the record
records at `Sᵖ × S^q`. -/
noncomputable def mu (p q : ℕ) : ℝ := ((p : ℝ) + q - 2) / (2 * ((p : ℝ) - 1) * ((q : ℝ) - 1))

/-- **The padded four-set value `1/(2(p-1))`**: two indices from the first factor, one from the
second, one padded. -/
noncomputable def muPadded (p : ℕ) : ℝ := 1 / (2 * ((p : ℝ) - 1))

/-! ## The threshold, and the Diophantine step -/

/-- **The first equivalence**: `μ_{p,q} = ½` iff `1/(p-1) + 1/(q-1) = 1`, at `p, q ≥ 2`. -/
theorem mu_eq_half_iff_recip (p q : ℕ) (hp : 2 ≤ p) (hq : 2 ≤ q) :
    mu p q = 1 / 2 ↔ 1 / ((p : ℝ) - 1) + 1 / ((q : ℝ) - 1) = 1 := by
  have hp1 : (0 : ℝ) < (p : ℝ) - 1 := by
    have : (2 : ℝ) ≤ (p : ℝ) := by exact_mod_cast hp
    linarith
  have hq1 : (0 : ℝ) < (q : ℝ) - 1 := by
    have : (2 : ℝ) ≤ (q : ℝ) := by exact_mod_cast hq
    linarith
  unfold mu
  rw [div_eq_div_iff (by positivity) (by norm_num)]
  constructor
  · intro h
    field_simp
    linarith
  · intro h
    field_simp at h
    linarith

/-- **The Diophantine step, over the integers**: `1/(p-1) + 1/(q-1) = 1` forces `p = q = 3`.
*Its content is `(u-1)(v-1) = 1` for `u = p-1`, `v = q-1`.* -/
theorem recip_iff_three_three (p q : ℕ) (hp : 2 ≤ p) (hq : 2 ≤ q) :
    1 / ((p : ℝ) - 1) + 1 / ((q : ℝ) - 1) = 1 ↔ p = 3 ∧ q = 3 := by
  have hp1 : (0 : ℝ) < (p : ℝ) - 1 := by
    have : (2 : ℝ) ≤ (p : ℝ) := by exact_mod_cast hp
    linarith
  have hq1 : (0 : ℝ) < (q : ℝ) - 1 := by
    have : (2 : ℝ) ≤ (q : ℝ) := by exact_mod_cast hq
    linarith
  constructor
  · intro h
    have hcl : ((p : ℝ) - 1) + ((q : ℝ) - 1) = ((p : ℝ) - 1) * ((q : ℝ) - 1) := by
      field_simp at h
      linarith
    have hz : ((p : ℝ) - 2) * ((q : ℝ) - 2) = 1 := by nlinarith [hcl]
    have hzi : ((p : ℤ) - 2) * ((q : ℤ) - 2) = 1 := by exact_mod_cast hz
    have hpz : (2 : ℤ) ≤ (p : ℤ) := by exact_mod_cast hp
    have hqz : (2 : ℤ) ≤ (q : ℤ) := by exact_mod_cast hq
    rcases Int.eq_one_or_neg_one_of_mul_eq_one' hzi with ⟨h1, h2⟩ | ⟨h1, h2⟩
    · omega
    · omega
  · rintro ⟨rfl, rfl⟩
    norm_num

/-- **L126's threshold clause, in full**: at `p, q ≥ 2` the four-set value reaches `½` exactly at
the balanced pair `(3,3)`. -/
theorem mu_eq_half_iff (p q : ℕ) (hp : 2 ≤ p) (hq : 2 ≤ q) :
    mu p q = 1 / 2 ↔ p = 3 ∧ q = 3 :=
  (mu_eq_half_iff_recip p q hp hq).trans (recip_iff_three_three p q hp hq)

/-! ## `S² × S^q` breaches the cap outright -/

/-- **`μ_{2,q} = q/(2(q-1))`**, the record's closed form at `p = 2`. -/
theorem mu_two (q : ℕ) (hq : 2 ≤ q) : mu 2 q = (q : ℝ) / (2 * ((q : ℝ) - 1)) := by
  have hq1 : (0 : ℝ) < (q : ℝ) - 1 := by
    have : (2 : ℝ) ≤ (q : ℝ) := by exact_mod_cast hq
    linarith
  unfold mu
  norm_num

/-- **`μ_{2,q} > ½` at every `q ≥ 2`**, the strict breach of Lemma L24's cap, which is what the
record spends to conclude that no `S² × S^q` is a local maximum. -/
theorem mu_two_gt_half (q : ℕ) (hq : 2 ≤ q) : 1 / 2 < mu 2 q := by
  have hq1 : (0 : ℝ) < (q : ℝ) - 1 := by
    have : (2 : ℝ) ≤ (q : ℝ) := by exact_mod_cast hq
    linarith
  rw [mu_two q hq]
  rw [lt_div_iff₀ (by positivity)]
  linarith

/-! ## Padding moves the threshold off the `(2,2)`-splits -/

/-- **The padded four-set value is `½` exactly at `p = 2`**, for every `q`, the record's reason
that the closing caveat has to stay. -/
theorem muPadded_eq_half_iff (p : ℕ) (hp : 2 ≤ p) : muPadded p = 1 / 2 ↔ p = 2 := by
  have hp1 : (0 : ℝ) < (p : ℝ) - 1 := by
    have : (2 : ℝ) ≤ (p : ℝ) := by exact_mod_cast hp
    linarith
  unfold muPadded
  rw [div_eq_div_iff (by positivity) (by norm_num)]
  constructor
  · intro h
    have : (p : ℝ) = 2 := by linarith
    exact_mod_cast this
  · rintro rfl
    norm_num

/-! ## The three recorded values -/

/-- `μ₂,₄ = ⅔`, a recorded padding-invariant four-set eigenvalue. -/
theorem mu_two_four : mu 2 4 = 2 / 3 := by unfold mu; norm_num

/-- `μ₂,₆ = ⅗`, the other recorded padding-invariant four-set eigenvalue. -/
theorem mu_two_six : mu 2 6 = 3 / 5 := by unfold mu; norm_num

/-- `μ₂,₂ = 1`, matching the record's `(2,2)` spectrum. -/
theorem mu_two_two : mu 2 2 = 1 := by unfold mu; norm_num

/-- `μ₃,₃ = ½`, the threshold point itself. -/
theorem mu_three_three : mu 3 3 = 1 / 2 := by unfold mu; norm_num

/-! ## A witness, so the hypotheses are not empty

*`(p,q) = (3,3)` satisfies `p, q ≥ 2` and meets the threshold; `(2,4)` satisfies them and breaches
it. So neither side of the equivalence is vacuous.* -/

example : 2 ≤ 3 ∧ mu 3 3 = 1 / 2 := ⟨by norm_num, mu_three_three⟩

example : 1 / 2 < mu 2 4 := mu_two_gt_half 4 (by norm_num)

end HamiltonsCubic.L126Statement
