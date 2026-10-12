# Brief, round L42

**Cold brief. Every passage below is quoted verbatim from the record, with its source lines. No prior verdict is included.**


## Passage A, the statement as the findings file carries it ([findings/stratum-two-negative.md](../findings/stratum-two-negative.md) lines 536-545)

#### Lemma L42, the sharp dual weight

*Numbered here on 2026-08-31: the result was numbered in [report/](../report/) and the mathematics has always been in this file, but it carried no block. The statement is below; **the argument is in this file under "The $\dim\mathfrak m\le2$ stratum, assembled, closed modulo three nam"**.*

Let $\lambda_P$ be at least three positive eigenvalues and let
\[
M(\lambda_P)\;=\;\max\Big\{\textstyle\sum_{\alpha<\beta<\gamma}t_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta\lambda_\gamma\;:\;t\ge0,\ \sum_{\gamma\notin\{\alpha,\beta\}}t_{\alpha\beta\gamma}\le2\ \text{for every pair}\Big\}.
\]
Then $3M(\lambda_P)\le h\,(s^2-u)$, with $h$ the harmonic mean of the three largest positives, $s=\sum\lambda$ and $u=\sum\lambda^2$. **The constant cannot be improved.**


## Passage B, the canonical statement, landscape form ([results.md](../results.md) line 182)

- **Lemma L42 (landscape). The sharp dual weight.** For a positive spectrum $\lambda_P$ with at least three entries, the pair-capped triangle packing $M(\lambda_P)$ satisfies $3M(\lambda_P)\le h(s^2-u)$ with $h$ the harmonic mean of the three largest positives, $s=\sum\lambda$, $u=\sum\lambda^2$, and the constant cannot be improved.

## Passage C, the canonical statement, detail form ([results.md](../results.md) lines 633-637)

##### Lemma L42, the sharp dual weight

Let $\lambda_P$ be a list of at least three positive eigenvalues and let $M(\lambda_P)$ be the maximum of $\sum_{\alpha<\beta<\gamma}t_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta\lambda_\gamma$ over $t\ge0$ with $\sum_{\gamma\notin\{\alpha,\beta\}}t_{\alpha\beta\gamma}\le2$ for every pair, the relaxation of the bracket tensor's pair cap that Lemma L35 uses. Then $3M(\lambda_P)\le h\,(s^2-u)$ with $h$ the harmonic mean of the three largest entries, $s=\sum\lambda$ and $u=\sum\lambda^2$, and the constant is attained, so no better weight exists for this relaxation. It bounds the relaxation, and it is the relaxation rather than $P$ that it is sharp for.

**Proof:** [stratum-two-negative.md](findings/stratum-two-negative.md)

## Passage D, the proof as written ([findings/stratum-two-negative.md](../findings/stratum-two-negative.md) lines 581-610)

#### The lemma that closes it is the sharp dual weight, and it is now PROVED, by LP weak duality, not verified

*The "$2800$ draws" recorded below were checking a theorem.*

#### The primal

$M(\lambda_P):=\max\sum_{\alpha<\beta<\gamma}t_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta\lambda_\gamma$ over $t\ge0$ subject to the pair cap $\sum_{\gamma\notin\{\alpha,\beta\}}t_{\alpha\beta\gamma}\le2$ for every pair.

**Its dual** is $\min\ 2\sum_{\alpha<\beta}z_{\alpha\beta}$ subject to $z_{\alpha\beta}+z_{\beta\gamma}+z_{\alpha\gamma}\ge\lambda_\alpha\lambda_\beta\lambda_\gamma$ on every triple, $z\ge0$.

#### Feasibility of the product weight

Put $z_{\alpha\beta}=c\,\lambda_\alpha\lambda_\beta$. Dividing the triple constraint by $\lambda_\alpha\lambda_\beta\lambda_\gamma>0$ turns it into
$$c\Big(\tfrac1{\lambda_\alpha}+\tfrac1{\lambda_\beta}+\tfrac1{\lambda_\gamma}\Big)\ \ge\ 1,\qquad\text{i.e.}\qquad c\ \ge\ \tfrac13H(\alpha,\beta,\gamma),$$
with $H$ the **harmonic mean** of the triple, since $\sum1/\lambda=3/H$. The harmonic mean is increasing in each argument, so the binding triple is the **three largest positives** and $c=h/3$ is feasible.

#### Weak duality

With that $c$,
$$M(\lambda_P)\ \le\ 2\sum_{\alpha<\beta}z_{\alpha\beta}\ =\ 2\cdot\tfrac h3\cdot\tfrac{s^2-u}2\ =\ \tfrac h3(s^2-u),$$

$$\boxed{\ 3M(\lambda_P)\ \le\ h\,(s^2-u)\ },\qquad h=\text{harmonic mean of the three largest positives.}$$

#### It is sharp, and the equal case shows it

With $k$ equal positives $\lambda$: $h=\lambda$, $s^2-u=k(k-1)\lambda^2$, so the bound reads $3M\le k(k-1)\lambda^3$. *The pair-count $\sum t\le k(k-1)/3$ is the same upper bound again, not attainment*, **both Gate 2 reviewers flagged that, and both supplied the missing maximiser**: $t_{\alpha\beta\gamma}=2/(k-2)$ on every triple has pair marginal $(k-2)\cdot\frac2{k-2}=2$, feasible, with $\sum t=\binom k3\frac2{k-2}=k(k-1)/3$. So equality genuinely holds for $k\ge3$ and no constant in the lemma can be improved.

#### Hypothesis: at least three positives

At $k\le2$ there are no triples, $M=0$, and $h$ is undefined; those cases are closed elsewhere.

## Passage E, a second statement of the same argument in the same file ([findings/stratum-two-negative.md](../findings/stratum-two-negative.md) lines 518-525)

**The closing lemma is the sharp dual weight.** For a triple of positives the dual
$z_{\alpha\beta}=\mu\cdot\tfrac32\lambda_\alpha\lambda_\beta$ is feasible exactly when $\mu$ is at
least the triple's harmonic mean, so the binding value is $h$, the harmonic mean of the three
largest positives, and $3M(\lambda_P)\le h\,(s^2-u)$. With $h\le\min(\lambda_1,\tfrac3{2\sqrt2}\sqrt d)$
and two further elementary bounds, $G$ is dominated by a three-parameter relaxation strictly
increasing in $s$ and $u$; forcing both to the constraint $s^2\le2-2u$ **forces $b=c$** and leaves
two variables, in three regions capped at $1.017217$, $1.067666$, and an envelope whose maximum is
exactly $\sqrt{3/2}$ at $A=\sqrt{2/3}$. **The cases of one and two positive eigenvalues close in exact closed form, and the closure is in [REVIEW_r63](../reviews/REVIEW_r63.md) rather than here**, reconciling with $G$ and reaching its maximum at $\sqrt{3/2}$. *[Lemma L29](#lemma-l29-one-positive-and-two-negative-eigenvalues-cap-theta-at-sqrt32-canonical-statement-and-proof)'s block declares the $k=2$ maximisation owed and names L35 as unable to discharge it, while this block declared it closed by L29, a loop with nothing in it, broken by the argument's real location rather than by either pointer.* **What the canonical record owes here is the transcription, not the mathematics.** $\square$

## Passage F, the Lean statement ([lean/HamiltonsCubic/Results/L42Statement.lean](../lean/HamiltonsCubic/Results/L42Statement.lean) lines 72-128)

```lean
/-! ## The primal -/

/-- **The feasible set of the primal**: `t ≥ 0`, totally symmetric, and the pair cap. -/
structure Feasible (t : Fin k → Fin k → Fin k → ℝ) : Prop where
  nonneg : ∀ α β γ, 0 ≤ t α β γ
  symm12 : ∀ α β γ, t α β γ = t β α γ
  symm23 : ∀ α β γ, t α β γ = t α γ β
  pairCap : ∀ α β, α ≠ β → (∑ γ ∈ univ.filter fun γ => γ ≠ α ∧ γ ≠ β, t α β γ) ≤ 2

/-- **`∑_{α<β<γ} t_{αβγ} λ_α λ_β λ_γ`**, the primal objective. -/
def objective (t : Fin k → Fin k → Fin k → ℝ) (lam : Fin k → ℝ) : ℝ :=
  ∑ α : Fin k, ∑ β ∈ Finset.Ioi α, ∑ γ ∈ Finset.Ioi β, t α β γ * (lam α * lam β * lam γ)

/-! ## The three largest positives, and their harmonic mean -/

/-- **The three largest positives**: three distinct indices that no other index exceeds. -/
structure ThreeLargest (lam : Fin k → ℝ) (a b c : Fin k) : Prop where
  ab : a ≠ b
  bc : b ≠ c
  ac : a ≠ c
  largest : ∀ γ, γ ≠ a → γ ≠ b → γ ≠ c → lam γ ≤ min (lam a) (min (lam b) (lam c))

/-- **`h`, the harmonic mean of three values.** -/
noncomputable def harmonicMean (x y z : ℝ) : ℝ := 3 / (1 / x + 1 / y + 1 / z)

/-! ## The dual feasibility step -/

/-- **The dual constraint on one triple**, which is the whole of the record's "feasibility of the
product weight": with `z_{αβ} = c λ_α λ_β` and `c ≥ H(α,β,γ)/3`, the triple constraint
`z_{αβ} + z_{βγ} + z_{αγ} ≥ λ_αλ_βλ_γ` holds. -/
theorem triple_constraint (x y z c : ℝ) (hx : 0 < x) (hy : 0 < y) (hz : 0 < z)
    (hc : harmonicMean x y z / 3 ≤ c) :
    x * y * z ≤ c * (x * y + y * z + x * z) := by
  have hsum : 0 < 1 / x + 1 / y + 1 / z := by positivity
  have hH : harmonicMean x y z / 3 = 1 / (1 / x + 1 / y + 1 / z) := by
    rw [harmonicMean]; field_simp
  rw [hH] at hc
  have hkey : (1 / (1 / x + 1 / y + 1 / z)) * (x * y + y * z + x * z) = x * y * z := by
    field_simp
    ring
  have hpos : 0 < x * y + y * z + x * z := by positivity
  nlinarith [mul_le_mul_of_nonneg_right hc hpos.le]

/-! ## The lemma -/

/-- **The sharp dual weight.** For every feasible `t`,
`3 ∑_{α<β<γ} t_{αβγ} λ_α λ_β λ_γ ≤ h (s² - u)`, with `h` the harmonic mean of the three largest
positives, `s = ∑ λ` and `u = ∑ λ²`.

*`sorry`: what is missing is the summation of `triple_constraint` against `t` and the pair-cap
rearrangement, together with the exchange argument that the three largest minimise the sum of
reciprocals over triples.* -/
theorem sharp_dual_weight (t : Fin k → Fin k → Fin k → ℝ) (lam : Fin k → ℝ)
    (a b c : Fin k) (hk : 3 ≤ k) (hpos : ∀ i, 0 < lam i)
    (hft : Feasible t) (h3 : ThreeLargest lam a b c) :
    3 * objective t lam
      ≤ harmonicMean (lam a) (lam b) (lam c)
```

## Definitions the proof needs

- $\lambda_P$ is a finite list of $k\ge3$ strictly positive reals, indexed by $\alpha$. Triples $\alpha<\beta<\gamma$ are unordered triples of distinct indices; pairs $\alpha<\beta$ are unordered pairs of distinct indices.
- $t_{\alpha\beta\gamma}\ge0$ is indexed by unordered triples, so $t_{\alpha\beta\gamma}$ is the same number under any reordering of its indices.
- $s=\sum_\alpha\lambda_\alpha$, $u=\sum_\alpha\lambda_\alpha^2$, so $s^2-u=2\sum_{\alpha<\beta}\lambda_\alpha\lambda_\beta$.
- The harmonic mean of $x,y,z>0$ is $H=3/(1/x+1/y+1/z)$.

## What to attack, beyond the standing list

1. Whether Passage D's weak duality establishes $3M\le h(s^2-u)$: the dual as written, its feasibility at every triple (not only the three largest), and the summation step from per-triple feasibility to $M\le2\sum z$.
2. Whether the three largest entries are the binding triple, including when entries tie.
3. Whether "the constant cannot be improved" (Passage A) and "the constant is attained, so no better weight exists for this relaxation" (Passage C) are established, and what "the constant" refers to.
4. Whether Passage E's sentence about $z_{\alpha\beta}=\mu\cdot\tfrac32\lambda_\alpha\lambda_\beta$ and "$\mu$ at least the triple's harmonic mean" is correct, and whether the file's own text at the end of Passage D is consistent with it.
5. Whether Passage A's pointer to the argument (*"under 'The $\dim\mathfrak m\le2$ stratum, assembled, closed modulo three nam'"*) lands on the argument. *Location facts, so the item is answerable: that heading is [findings/stratum-two-negative.md](../findings/stratum-two-negative.md) line 468, and Passage E (lines 518-525) sits under it; Passage D (lines 581-610) sits under the heading at line 566, "The $\theta\le\mathrm{LP}\le G\le\sqrt{3/2}$ chain for two negative eigenvalues, its sharp dual weight, and the residual one-variable inequality".*
6. Whether Passage F's Lean statement is the record's claim: its binders, `Feasible` (note the pair cap filter and what `t` may do on repeated indices), `objective`, `ThreeLargest`, and the direction of the inequality.
7. The boundary: $k=3$ exactly, all entries equal, and $k\le2$.

