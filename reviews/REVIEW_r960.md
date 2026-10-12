# Review r960: Gate 2 on batch 30 of the I106 derivation, the commutator relations

Reviewer r960, adversarial Gate 2. Brief: [BRIEF_I106_batch30.md](BRIEF_I106_batch30.md). Log: [agent_logs/r960-batch30.log](../agent_logs/r960-batch30.log).

**Headline.** The mathematics of batch 30 survives every line of attack: all ten claims hold, claim 7 holds as stated and is in fact stronger than stated. One sentence of the block is false and contradicts two earlier batches of the same document, and it is the sentence about batch 28. Three smaller defects follow.

## Verdicts

| # | claim | verdict |
|---|---|---|
| 1 | $\mu K-\beta\{\hat U,K\}=[\hat U,C]$ follows from the $C$ condition alone | CONFIRMED |
| 2 | $[V,A]=3\alpha\{\hat U,K\}-3\mu K$ follows from the $A$ condition alone | CONFIRMED |
| 3 | Neither needs symmetry, tracelessness, or any condition beyond its one equation | CONFIRMED |
| 4 | $3(\alpha-\beta)\mu K=3\alpha[\hat U,C]+\beta[V,A]$, hypotheses exactly $\alpha\ne\beta$, $\mu\ne0$ | CONFIRMED for the identity, the hypothesis clause corrected below |
| 5 | $(\mu+\beta u_k)K_{ij}=[\hat U,C]_{ij}$ in $\hat U$'s eigenframe, tracelessness load-bearing | CONFIRMED |
| 6 | At every global maximum $\mu+\beta u_k\ge0$ for every $k$ | CONFIRMED |
| 7 | At every global maximum, no spectral hypothesis, $[\hat U,V]=0\iff[\hat U,C]=0$ | CONFIRMED, and it holds under a weaker hypothesis than maximality |
| 8 | Field frame: $3(\alpha-\beta)\mu K_{ij}=3\alpha\hat U_{ij}(C_j-C_i)+\beta V_{ij}(A_j-A_i)$ | CONFIRMED |
| 9 | A critical point with both fields scalar has $[\hat U,V]=0$ | CONFIRMED, but the block's route to it is incomplete and is repaired below |
| 10 | The disclaimer is accurate: nothing establishes $[\hat U,C]=0$, batch 28 untouched | REFUTED in one clause, the two substantive halves standing |

## The refutation: batch 28's four points do not clear batch 18's bound

The block's closing paragraph says the equivalence "is a statement about global maxima resting on batch 18's bound, **which those points clear**". That is false, and the record contradicts it twice in the preceding pages.

- [Batch 28](2026-09-15-I106-m3-derivation.md) itself: the four points have $\mu=-6.06130$ and $\mu=-24.43870$, "far below the $\mu\ge2\beta\lvert\hat U\rvert/\sqrt6=9.3675$ that batch 18 makes necessary at a maximum, so these are critical points and not maxima".
- [Batch 29](2026-09-15-I106-m3-derivation.md): "At $(3,1,-4)$ they have $\mu=-6.06130$ and $-24.43870$ against batch 18's necessary $9.3675$".
- The threshold checks: at $(3,1,-4)$, $\lvert\hat U\rvert^2=26$, so $2\beta\lvert\hat U\rvert/\sqrt6=4.5\sqrt{26}/\sqrt6=9.3675$. Both multipliers are negative, so they fail it by a wide margin.

No run was needed for this. The numbers are the record's own, in the same file, and the arithmetic confirming the threshold is one line.

**The conclusion of the paragraph survives, and its stated reason is backwards.** Batch 28's points are indeed untouched by batch 30, but *because* they fail batch 18's bound, so claim 7 never applies to them at all. Reading them as clearing the bound makes the disclaimer sound like a near miss when it is not even in range. The points that genuinely clear the bound are batch 29's, at $(19,-20,1)$ with $\mu=762.3845$ against a threshold of $50.712$, and those are the ones for which the block's sentence would have been the right caution.

## Claim by claim

### Claims 1, 2, 3, the two ring identities

Both are correct and both are genuinely identities of the matrix ring. For claim 1, $[\hat U,\{\hat U,V\}]=\hat U^2V-V\hat U^2=[\hat U^2,V]=\hat UK+K\hat U=\{\hat U,K\}$, each step valid for arbitrary square matrices, and the added multiple of $I$ dies under either commutator. For claim 2, $[V,V^2]=0$ for any $V$ whatever, and $[V,\hat U^2]=-\{\hat U,K\}$. No symmetry, no tracelessness, no second equation.

The Lean statements are faithful. [commutator_from_C](../lean/HamiltonsCubic/Results/I106Criticality.lean) and [commutator_from_A](../lean/HamiltonsCubic/Results/I106Criticality.lean) both quantify over arbitrary `Matrix (Fin 3) (Fin 3) ℝ` with the identity multiple `c` free, and their conclusions are the block's two displays verbatim. Neither is weakened and neither is vacuous.

**One sentence of the block is false as written.** It says commuting the $C$ equation with $\hat U$ "turns $[\hat U,V^2]$ into $[\hat U^2,V]=\{\hat U,K\}$". The $C$ equation contains $\{\hat U,V\}$, not $V^2$, and the true fact is $[\hat U,V^2]=\{V,K\}$, a different matrix. The correct sentence names $[\hat U,\{\hat U,V\}]$. My screen confirms both halves: $[\hat U,V^2]\ne\{\hat U,K\}$ in general, and $[\hat U,V^2]=\{V,K\}$ identically. **The same wrong phrase is copied into the Lean docstring of [commutator_from_C](../lean/HamiltonsCubic/Results/I106Criticality.lean)**, so it needs fixing in two places. The theorem itself is unaffected.

### Claim 4, the elimination

The identity is right: $3\alpha$ times the first relation plus $\beta$ times the second cancels $\{\hat U,K\}$ and leaves $3(\alpha-\beta)\mu K=3\alpha[\hat U,C]+\beta[V,A]$.

**The hypothesis clause is wrong, in the harmless direction.** The displayed identity is a linear combination of two identities, so it needs nothing at all, and it is true when $\alpha=\beta$ and true when $\mu=0$ (both sides vanish). What needs $\alpha\ne\beta$ and $\mu\ne0$ is the division that recovers $K$ from the right-hand side. The block writes "With $\alpha-\beta=\tfrac32\ne0$ and $\mu\ne0$" as a preamble to the display, which attaches the hypotheses to the wrong object. This matters for claim 9, where $\mu\ne0$ is not available.

### Claim 5, the eigenframe reading

Correct in every entry. $K_{ij}=(u_i-u_j)V_{ij}$ and $\{\hat U,K\}_{ij}=(u_i+u_j)K_{ij}$, and tracelessness gives $u_i+u_j=-u_k$, so $(\mu+\beta u_k)K_{ij}=[\hat U,C]_{ij}$. Verified at all three off-diagonal entries. The diagonal entries say $0=0$, since $K_{ii}=0$ and $[\hat U,C]_{ii}=(u_i-u_i)C_{ii}=0$ in that frame, so nothing is handled twice and no entry with $u_i=u_j$ is double-counted: such an entry gives $0=0$ on both sides and is carried by neither branch of the argument.

**Tracelessness is load-bearing exactly as claimed.** With $u_1,u_2,u_3$ free the entrywise form fails and the frame-free form still holds. Both halves verified.

**The converse direction the brief asked about is free.** $K=0\Rightarrow[\hat U,C]=0$ needs no denominator condition at all, since it reads straight off the frame-free identity $[\hat U,C]=\mu K-\beta\{\hat U,K\}$. Only the direction $[\hat U,C]=0\Rightarrow K=0$ consumes the denominators. The asymmetry is real and the block does not mislead about it.

[entry_relation](../lean/HamiltonsCubic/Results/I106Criticality.lean) and its two siblings type the left side of relation 1 at entries $(0,1)$, $(0,2)$, $(1,2)$ with the correct complementary index in each, and [K_zero_of_field_commutes](../lean/HamiltonsCubic/Results/I106Criticality.lean) concludes the three products $(u_i-u_j)w_k$ vanish, which is exactly $K=0$. Faithful, and not vacuous. Note that $V$ is not required traceless in any of them, correctly: only $\hat U$'s tracelessness is used, which the block's wording does not distinguish.

### Claims 6 and 7, the global maximum

Claim 6 is correct. $\lvert u_k\rvert\le\sqrt{2/3}\lvert\hat U\rvert=2\lvert\hat U\rvert/\sqrt6$ from [jordan_gap_le](../lean/HamiltonsCubic/Results/I106Criticality.lean), and $\beta>0$, so $\beta u_k\ge-2\beta\lvert\hat U\rvert/\sqrt6\ge-\mu$. Positivity of $\beta$ is used and is available at $\beta=\tfrac94$.

Claim 7 survives every case the brief asked me to check.

- **The equality case.** $\mu+\beta u_k=0$ gives $-u_k=\mu/\beta\ge0$, so $u_k\le0$ and $\lvert u_k\rvert=-u_k\ge2\lvert\hat U\rvert/\sqrt6$. Against claim 6's upper bound this forces $\lvert u_k\rvert=2\lvert\hat U\rvert/\sqrt6$, hence $3u_k^2=2\lvert\hat U\rvert^2$, hence $(u_i-u_j)^2=0$ by [jordan_gap](../lean/HamiltonsCubic/Results/I106Criticality.lean), hence $K_{ij}=(u_i-u_j)V_{ij}=0$. The sign of $u_k$ falls out rather than being assumed, and the final step uses only $u_i=u_j$, which is sign-free.
- **The case $\hat U=0$.** Then $u_k=0$ for every $k$, and $3u_k^2=2\lvert\hat U\rvert^2$ holds as $0=0$, so the degenerate branch covers it. Independently, $\hat U=0$ makes both sides of the equivalence trivially true.
- **The case $\mu=0$.** Batch 18's bound forces $\lvert\hat U\rvert=0$, so this collapses to the previous case. There is no critical point at a global maximum with $\mu=0$ and $\hat U\ne0$.
- **Each pair separately.** For each of the three pairs, either the denominator is nonzero and the entry is killed by $[\hat U,C]=0$, or it is zero and the entry is killed by $u_i=u_j$. The two branches are exhaustive per pair, not per configuration, which is what the argument needs.

**Claim 7 is stated more weakly than it is true, and the record should take the stronger form.** Nothing in the argument uses global maximality except through the inequality $\mu\ge2\beta\lvert\hat U\rvert/\sqrt6$. So the true statement is: *at every critical point satisfying batch 18's bound*, $[\hat U,V]=0\iff[\hat U,C]=0$. That is a larger set than the global maxima, it is the form a later argument is likely to want, and it makes the relationship to batch 28 exact rather than approximate.

### Claim 8, the field frame

Signs correct, and I checked them against the flip the brief warned about. For $C$ diagonal, $(\hat UC)_{ij}=\hat U_{ij}C_j$ and $(C\hat U)_{ij}=C_i\hat U_{ij}$, so $[\hat U,C]_{ij}=\hat U_{ij}(C_j-C_i)$, and likewise for $[V,A]$. Verified entrywise over a symbolic symmetric $\hat U$ and $V$ against diagonal $A$ and $C$. A flipped sign would have negated the right-hand side of the display, and the check distinguishes the two.

The support statement that follows is correct: a pair $(i,j)$ with $C_i=C_j$ and $A_i=A_j$ contributes nothing, **given $\mu\ne0$**, which the block again does not carry.

### Claim 9, scalar fields

True, and **the block's derivation of it does not reach it**. The route through the elimination needs $\mu\ne0$, and at a general critical point that is not available. With both fields scalar, $\Phi$ is homogeneous of degree three and Euler gives $3\Phi=2\mu T$, so $\mu=0$ is exactly $\Phi=0$, which nothing excludes a priori.

**The repair, which closes it without $\mu\ne0$.** Suppose $\mu=0$, both fields scalar, and $K\ne0$. Some $K_{ij}=(u_i-u_j)V_{ij}\ne0$, so $u_i\ne u_j$ and $V_{ij}\ne0$. The $C$ condition reads $\{\hat U,V\}=\nu I$, whose off-diagonal entries in $\hat U$'s eigenframe are $-u_kV_{ij}=0$, forcing $u_k=0$ and therefore $u_j=-u_i\ne0$. Relabel to $u=(s,-s,0)$ with $s\ne0$. The diagonal entry at index 3 gives $0\cdot V_{33}=\nu$, so $\nu=0$, and then $V_{11}=V_{22}=0$, with $V_{33}=0$ by tracelessness. The remaining off-diagonal conditions kill $V_{13}$ and $V_{23}$. So $V=w(E_{12}+E_{21})$ with $w\ne0$. Now the $A$ condition requires $3\alpha\hat U^2+\beta V^2$ scalar, and that matrix is $\operatorname{diag}(3\alpha s^2+\beta w^2,\;3\alpha s^2+\beta w^2,\;0)$, so scalarity demands $3\alpha s^2+\beta w^2=0$, impossible for $\alpha,\beta>0$ with $s\ne0$. Hence $K=0$.

So claim 9 holds unconditionally, at the cost of a positivity argument the block does not make. The final matrix was screened symbolically to guard against an arithmetic slip.

**The claim is not vacuous.** Critical points with both fields scalar exist: $\hat U=t\operatorname{diag}(1,1,-2)$, $V=0$, $\mu=-\alpha t$ satisfies both Lagrange conditions with $A$ and $C$ scalar. The class is populated and the conclusion is a conclusion about it, not an empty statement.

## The two structural questions

### Is batch 30 a rearrangement of batch 15?

**No, and the honest description is narrower than the block's.** Batch 15's system $(u_i-u_j)V_{ij}q(u_k)=\beta^2(VKV)_{ij}$ comes from $[A,C]=0$, which is genuine extra input from the field frame, and it eliminates $A$ and $C$ entirely. Batch 30's relations come from each single Lagrange equation and retain $[\hat U,C]$ and $[V,A]$ explicitly. Neither derives the other: batch 15 cannot produce a relation mentioning fields it has eliminated, and batch 30's relations never invoke $[A,C]=0$. They are independent.

**But independent is not the same as new.** Substituting the Lagrange forms into relations 1, 2 and 4 turns each into a tautology of the matrix ring, so on their own they say nothing whatever about the solution set that the Lagrange conditions did not already say. Every bit of content in the batch sits in two places: claim 7, which imports batch 18, and claim 8, which imports the field frame. That is worth recording plainly, because "two identities of the matrix ring" reads as an achievement and the identities are the cheap part.

### Is the reduction circular?

**It is an equivalence, not a reduction, and the block should not be read as claiming otherwise.** Since $[\hat U,C]=\mu K-\beta\{\hat U,K\}$ identically, $[\hat U,C]$ is a function of $(\hat U,V,\mu)$ alone, and at a point satisfying batch 18's bound $[\hat U,C]\ne0$ is *logically equivalent* to $K\ne0$. So "the open case is now the single condition $[\hat U,C]\ne0$" restates the open case at equal strength rather than weakening it.

That said, the restatement is not empty, and I do not recommend striking it. $[\hat U,C]=0$ constrains $\hat U$ against a matrix diagonal in the fixed frame $F$, where $[\hat U,V]=0$ couples two unknowns, and [batch 31](2026-09-15-I106-m3-derivation.md) cashes exactly that out by reducing the criterion to $(\beta_{ac}-\beta_{bc})[X_a+X_b,X_c]=0$. The value is in the change of variables, and the record would be more accurate saying so than saying the stratum has been reduced.

## What is typed and what is not

Claims 1, 2 and 5 are typed faithfully. **Claims 4, 6, 7, 8, 9 and 10 are typed nowhere**, and the block's Gate 1 line claiming "every statement typed and proved in Lean on the standard three axioms" is therefore an overclaim. The Lean file's own header is more honest than the derivation, saying that batch 18's bound making the denominators nonzero "is argued in the derivation and typed nowhere here".

What each would need:

- **Claim 4** is immediate in Lean as a `linear_combination` of the two existing theorems, with no hypotheses. Roughly an hour, and it would make the hypothesis error impossible to restate.
- **Claim 8** is entrywise over diagonal `A` and `C`, the same shape as [entry_relation](../lean/HamiltonsCubic/Results/I106Criticality.lean), and is equally cheap.
- **Claim 9** is typeable as stated once the repair above is in hand, since the argument is a finite case split with a positivity contradiction at the end. The `μ = 0` branch is the only work.
- **Claims 6 and 7** need $\lvert\hat U\rvert$ and the hypothesis $\mu\ge2\beta\lvert\hat U\rvert/\sqrt6$ as an assumption, which is straightforward, plus the case split already present in the prose. The obstruction is not claim 7, it is that batch 18's bound itself is not derived in Lean: the header records that [mu_ge_of_rayleigh](../lean/HamiltonsCubic/Results/I106Criticality.lean) assumes the factor of two and that no declaration computes $\lambda_{\max}=\lvert\hat U\rvert/\sqrt6$. **Claim 7 can be typed conditionally on the bound today, and that is what I would do**, since it separates the part the record holds from the part it owes.
- **Claim 10** is a statement about the record, not about mathematics, and is not typeable.

One housekeeping item: the Lean file's module docstring opens "batches 15 to 26" while the file now carries batches 30 and 31.

## What I would change in the record

1. **Replace the false clause in batch 30's closing paragraph.** Strike "which those points clear" and say instead that batch 28's four points fail batch 18's bound, both multipliers being negative against a threshold of $9.3675$, so claim 7 does not reach them at all. If a caution about points that do clear the bound is wanted, name batch 29's at $(19,-20,1)$ with $\mu=762.3845$ against $50.712$, which is the real case.
2. **Fix $[\hat U,V^2]$ to $[\hat U,\{\hat U,V\}]$** in batch 30's first paragraph and in the [commutator_from_C](../lean/HamiltonsCubic/Results/I106Criticality.lean) docstring. As written the sentence is false, since $[\hat U,V^2]=\{V,K\}$.
3. **Move $\alpha\ne\beta$ and $\mu\ne0$ off the display and onto the division.** The identity is unconditional and the hypotheses belong to recovering $K$ from it.
4. **State claim 7 at the batch-18 inequality rather than at global maximality**, which is where its proof actually lives and which makes its relation to batches 28 and 29 exact.
5. **Add the $\mu\ne0$ gap and its repair to the scalar-fields sentence**, or cite the positivity argument above. As it stands claim 9 is asserted through a route that does not reach it.
6. **Narrow the Gate 1 (b) line** to name the statements that are typed, since claims 4, 6, 7, 8 and 9 are not.
7. **Say that the open case has been restated rather than reduced**, with the gain being the change to the field variables that batch 31 exploits.

Nothing here touches claims 1 through 9 as mathematics. The batch's content stands, the target it names is the right one, and the correction is to one sentence of self-assessment that the rest of the same document already contradicts.

## Method note

Everything above is by hand from the brief's definitions. One symbolic screen, seconds of compute on symbolic matrices I constructed for the purpose, guarded my own signs on claims 1, 2, 4, 5, 8 and the final matrix of the claim 9 repair. It is recorded as a screen of claims I derived, never as evidence for them. No sweep, census or search was opened.
