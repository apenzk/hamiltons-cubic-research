# Review r959, Gate 2 on batch 30 of the I106 derivation, the commutator relations

Reviewer: r959, adversarial. Brief: [BRIEF_I106_batch30.md](BRIEF_I106_batch30.md). Block audited: [batch 30 of the derivation](2026-09-15-I106-m3-derivation.md). Log: [agent_logs/r959-batch30.log](../agent_logs/r959-batch30.log).

**Every verdict below was reached by hand from the definitions in the brief.** No script was run and none was needed: each claim is an identity of the matrix ring or a two-line inequality, and the one point where a number could have been demanded (batch 28's four points clearing or failing the denominators) is three subtractions on data the record already prints. The analysis-only rule was never approached.

## Verdicts

| # | claim | verdict |
|---|---|---|
| 1 | $\mu K-\beta\{\hat U,K\}=[\hat U,C]$ follows from the $C$ condition alone | **CONFIRMED** |
| 2 | $[V,A]=3\alpha\{\hat U,K\}-3\mu K$ follows from the $A$ condition alone | **CONFIRMED** |
| 3 | Neither needs symmetry, tracelessness, or any condition beyond its one equation | **CONFIRMED** |
| 4 | $3(\alpha-\beta)\mu K=3\alpha[\hat U,C]+\beta[V,A]$, hypotheses exactly $\alpha\ne\beta$ and $\mu\ne0$ | **PLAUSIBLE**, the identity is unconditional and the hypothesis attribution is wrong, see [D2](#d2) |
| 5 | Eigenframe: $(\mu+\beta u_k)K_{ij}=[\hat U,C]_{ij}$, tracelessness load-bearing | **CONFIRMED** |
| 6 | At every global maximum $\mu+\beta u_k\ge0$ for every $k$ | **CONFIRMED**, and it survives the $V=0$ hole in batch 18's derivation, see [the note on batch 18](#the-one-place-batch-18s-bound-could-have-failed-and-does-not) |
| 7 | At every global maximum, no spectral hypothesis, $[\hat U,V]=0\iff[\hat U,C]=0$ | **CONFIRMED**, with three sub-cases the block leaves silent |
| 8 | Field frame: $3(\alpha-\beta)\mu K_{ij}=3\alpha\hat U_{ij}(C_j-C_i)+\beta V_{ij}(A_j-A_i)$ | **CONFIRMED**, signs correct |
| 9 | A critical point with both fields scalar has $[\hat U,V]=0$ | **CONFIRMED**, and the block's derivation of it is incomplete, see [D5](#d5) |
| 10 | The disclaimer is accurate: nothing establishes $[\hat U,C]=0$, batch 28 untouched | **CONFIRMED** in both assertions, one supporting clause inside it is false, see [D4](#d4) |

**Nothing in the block is refuted.** Five defects are recorded, four of them wording that states something false and one of them a missing step. The mathematics of batch 30 stands.

## Defects, in the order I would fix them

### D4

**"resting on batch 18's bound, which those points clear" is false, and it reverses what batch 28 established.** Batch 28's four points have $\mu=-6.06130$ and $\mu=-24.43870$ against batch 18's necessary $\mu\ge2\beta\lvert\hat U\rvert/\sqrt6=9.3675$, and batch 28 says so in the same words. They fail the bound by a wide margin, which is exactly why they are critical points and not maxima, and that failure is what makes the paragraph's own point. **Replace "which those points clear" with "which those points fail".** As written the sentence contradicts the record two batches earlier and removes the reason the equivalence is not in danger.

### D3

**"The open case ... is now the single condition $[\hat U,C]\ne0$" equates two sets that differ in both directions.** The recorded open case is the complement of the stratum [L229](../findings/second-order.md) closed, which is "$\hat U$ and $V$ share an eigenvector **that is a frame vector of $F$**" ([plan.md](../plan.md) item I106, and batch 16's own closing paragraph). Against that:

- A configuration with exactly one $w_k\ne0$ and distinct spectrum shares an eigenvector by batch 16, so it sits outside "share no eigenvector", while $K_{ij}=(u_i-u_j)w_k\ne0$ puts it inside $[\hat U,C]\ne0$. The new condition is strictly larger than the paraphrase the block uses.
- A commuting pair whose common eigenframe misses $F$ has $[\hat U,C]=0$ and is still open under the precise reading. The new condition is not larger than the precise open case.

**The honest statement is stronger than the one the block makes, so the fix costs nothing**: proving $[\hat U,C]=0$ at every global maximum gives $K=0$ there, and "the supremum is attained at commuting blocks" is the $\lvert J\rvert=3$ node itself, not one stratum of it. Recommended wording: *what is owed is $[\hat U,C]=0$ at every global maximum, which closes the node outright rather than one stratum of it.*

### D1

**"turns $[\hat U,V^2]$ into $[\hat U^2,V]$" names the wrong bracket.** The $C$ condition carries no $V^2$ term. The term commuted is $[\hat U,\{\hat U,V\}]$, and the identity used is $[\hat U,\{\hat U,V\}]=[\hat U^2,V]=\{\hat U,K\}$, each step being $\hat U^2V-\hat UV\hat U+\hat UV\hat U-V\hat U^2$. The $V^2$ term belongs to the $A$ condition, where the sentence's next clause correctly kills $[V,V^2]$. **The same error is in the docstring of [commutator_from_C](../lean/HamiltonsCubic/Results/I106Criticality.lean)**, so it needs fixing twice.

### D2

**The elimination needs no hypotheses at all, and the two it is given belong to a different step.** Take $3\alpha$ times relation 1 and $\beta$ times relation 2 and add: the $\{\hat U,K\}$ terms cancel with no division, leaving
$$3(\alpha-\beta)\mu K=3\alpha[\hat U,C]+\beta[V,A]$$
over any ring and for every $\alpha,\beta,\mu$. What $\alpha\ne\beta$ and $\mu\ne0$ buy is the inversion, $K=\big(3\alpha[\hat U,C]+\beta[V,A]\big)/\big(3(\alpha-\beta)\mu\big)$, which is what "leaves $K$ alone on one side" actually means and what the field-frame support statement and claim 9 both use. **Attach the two hypotheses to the inversion rather than to the display.**

There is a second gap in the same sentence: **$\mu\ne0$ is asserted with no source.** At a global maximum it follows from batch 18 whenever $\hat U\ne0$, and at a general critical point it is an extra hypothesis. Every use of the field-frame form in the block is at a critical point rather than a maximum, so the source matters.

### D5

**Claim 9's one-line derivation does not cover $\mu=0$, and the claim is nonetheless true.** With $A$ and $C$ scalar, every right-hand side in the field-frame identity vanishes and the identity reads $3(\alpha-\beta)\mu K=0$, which says nothing at $\mu=0$. The gap closes, and here is the argument to put in the record.

Scalar fields contribute nothing to $\Phi$, since $\hat U$ and $V$ are traceless, so the conditions are $3\alpha\hat U^2+\beta V^2=\rho I$ and $\beta\{\hat U,V\}=\lambda I$ at $\mu=0$. In $\hat U$'s eigenframe the second gives $(u_i+u_j)V_{ij}=0$ off the diagonal and $2u_iV_{ii}=\lambda$ on it.

- If every $u_k\ne0$ then $u_i+u_j=-u_k\ne0$ forces every off-diagonal entry to zero, so $K=0$ directly.
- Otherwise some $u_k=0$, say $u_3=0$, so $u_1=-u_2=u$. Then $V_{13}=V_{23}=0$, the diagonal equations give $\lambda=0$ and $V_{11}=V_{22}=0$, and tracelessness gives $V_{33}=0$, leaving $V=w(E_{12}+E_{21})$. The first condition is then $\operatorname{diag}(3\alpha u^2+\beta w^2,\ 3\alpha u^2+\beta w^2,\ 0)=\rho I$, and with $\alpha,\beta>0$ that forces $u=w=0$, hence $\hat U=0$ and $K=0$.

**So with both fields scalar there is no critical point at $\mu=0$ on the constraint surface at all**, and claim 9 holds at every critical point rather than only at those with $\mu\ne0$.

## The attacks that did not land, and why

### Claim 7's edge case, checked step by step

The block's chain survives every case I could put to it, and three of them it does not mention.

- **The sign of $u_k$ comes out right.** If $\mu+\beta u_k=0$ then $\beta u_k=-\mu\le-2\beta\lvert\hat U\rvert/\sqrt6$, and $\beta>0$ gives $u_k\le-2\lvert\hat U\rvert/\sqrt6$. Against [jordan_gap_le](../lean/HamiltonsCubic/Results/I106Criticality.lean)'s $\lvert u_k\rvert\le2\lvert\hat U\rvert/\sqrt6$ this forces $u_k=-2\lvert\hat U\rvert/\sqrt6$ exactly, so $3u_k^2=2\lvert\hat U\rvert^2$, so $(u_i-u_j)^2=0$ by [jordan_gap](../lean/HamiltonsCubic/Results/I106Criticality.lean), so $K_{ij}=(u_i-u_j)V_{ij}=0$ on its own. **$\beta>0$ is used and $\beta=\tfrac94$ supplies it.** The argument would fail at $\beta<0$, where $\mu+\beta u_k=0$ would put $u_k$ at the top of the range instead.
- **At most one denominator can vanish unless $\hat U=0$.** Two vanishing denominators give $u_k=u_l=-2\lvert\hat U\rvert/\sqrt6$, tracelessness gives $u_m=4\lvert\hat U\rvert/\sqrt6$, and summing squares gives $\lvert\hat U\rvert^2=4\lvert\hat U\rvert^2$, hence $\hat U=0$. So the equality clause disposes of one entry at a time and the other two entries are cleared by their own nonzero denominators.
- **$\hat U=0$ and $\mu=0$ are both harmless.** Batch 18's bound makes $\mu=0$ imply $\hat U=0$, and $\hat U=0$ gives $K=[0,V]=0$ and $[\hat U,C]=0$ together, so the equivalence holds as $0\iff0$.

**The forward direction is free of all of this.** $K=0$ put into relation 1 gives $[\hat U,C]=\mu\cdot0-\beta\{\hat U,0\}=0$ with no hypothesis whatever, not even criticality beyond the $C$ equation. Only the reverse direction meets the denominators. **And no entry is handled twice**: when $u_i=u_j$ both sides of $(\mu+\beta u_k)K_{ij}=[\hat U,C]_{ij}$ vanish identically, so the two routes to $K_{ij}=0$ agree rather than compete.

### The one place batch 18's bound could have failed, and does not

**Batch 18 derives its bound from a trust-region problem "at fixed $\lvert V\rvert$", which is vacuous at $V=0$**, and $V=0$ is consistent with criticality whenever $C$ is scalar. That would have left claim 6 unsupported on a nonempty set. The bound survives, by the second-order condition in the direction $(X,Y)=(0,Y)$, which is tangent for every traceless symmetric $Y$ when $V=0$: the second variation of $\Phi-\mu g$ there is $\beta\operatorname{tr}(\hat UY^2)-\tfrac{\mu}2\lvert Y\rvert^2\le0$, and maximising the left term over $Y$ gives $\mu\ge2\beta\lambda_{\max}(\mathcal L)=2\beta\lvert\hat U\rvert/\sqrt6$. **That is the form [mu_ge_of_rayleigh](../lean/HamiltonsCubic/Results/I106Criticality.lean) already carries**, so the Lean statement is the robust one and the derivation's prose is the fragile one. Worth a clause in batch 18 saying the bound comes from the second-order condition rather than from a trust region with positive radius.

### Batch 30 is new information, not a rearrangement of batch 15

**The two are independent in both directions, and the reason is which input each consumes.**

| | batch 15 | batch 30, relations 1, 2 and 4 |
|---|---|---|
| input used | $[A,C]=0$, which holds because $A$ and $C$ are both diagonal in $F$ | one Lagrange equation each, with $A$ and $C$ arbitrary |
| fields in the output | eliminated | retained, as $[\hat U,C]$ and $[V,A]$ |
| what it constrains | $\hat U$, $V$, $\mu$ alone | $K$ against the field separations |

Batch 15's system is not a consequence of relations 1 and 2, because $[A,C]$ involves $[\hat U^2,C]$ and $[V^2,C]$, which those relations do not reach. Relations 1 and 2 are not consequences of batch 15's system, because they hold with no diagonality hypothesis at all, which batch 15's system needs. **Both are contractions of batch 10's Lagrange conditions along different directions**, so the correct attribution is that batch 30 descends from batch 10 rather than from batch 15. The field information batch 15 throws away in forming $[A,C]$ is precisely what batch 30 keeps, and that is where the field-frame support statement comes from.

### The reduction is a change of description, and the block should say so

**At a global maximum $[\hat U,C]\ne0$ and $K\ne0$ are the same condition**, which is claim 7 read as a statement about sets. Relation 1 makes $[\hat U,C]$ a linear image of $K$, so the forward containment is unconditional, and the denominators supply the reverse. **So the reduction excludes nothing it did not already exclude.** Its whole content is the change of variables, stating the condition in the field $C$ that the other blocks generate rather than in the partner $V$, which is a claim about where an induction hypothesis can be applied and not a claim about the solution set. The block's closing paragraph half concedes this and the "what this does to the node" paragraph does not. **I would keep the change of variables, which is real, and delete the suggestion that the stratum has shrunk** (see [D3](#d3)).

### Claim 9 is not vacuous, and its witness saturates batch 18

Vacuity was a live worry, since a scalar-field critical point could have been forced into a degenerate corner where commutativity is automatic for an unrelated reason. It is not. **With $A$ and $C$ scalar the global maximum is $\hat U\propto V\propto\operatorname{diag}(2,-1,-1)$ with both nonzero**, found by maximising $\alpha\operatorname{tr}\hat U^3+\beta\langle V,\mathcal LV\rangle$ at $\lvert\hat U\rvert^2=x$ and $\lvert V\rvert^2=2T-3x$, which gives $\Phi_{\max}(x)=\tfrac{\sqrt x}{\sqrt6}\big(2\beta T-3x\big)$ and an interior optimum at $x=T/2$, hence $\Phi^\ast=\tfrac{\sqrt3}2T^{3/2}$.

**Three things follow, and the third is new to the record.**

- The claim has a witness with $V\ne0$, so it is a statement about a populated case.
- The witness commutes, as claim 9 says it must.
- **Batch 18's bound is attained with equality there.** Euler on the homogeneous cubic gives $3\Phi=2\mu T$, so $\mu=\tfrac{3\sqrt3}4\sqrt T$, while $2\beta\lvert\hat U\rvert/\sqrt6=\tfrac{9}2\sqrt{T/2}/\sqrt6=\tfrac{3\sqrt3}4\sqrt T$. The two agree exactly. *So the constant $2\beta/\sqrt6$ is sharp as a bound on $\mu$ at a global maximum, and the correction [r957](REVIEW_r957.md) and [r958](REVIEW_r958.md) forced is the sharp value rather than merely a larger one.* This is worth a line in batch 18, which currently records only that ten screened maximisers clear the bound with margin between $2.13$ and $9.37$. The equality case is at $u\propto(2,-1,-1)$, where batch 18's tightness discussion looks instead at $u\sim(t,t,-2t)$, so the two tightness statements are about different things: one is tightness of $\lambda_{\max}(\mathcal L)$ against the off-diagonal block, the other is tightness of $\mu$ against $2\beta\lambda_{\max}(\mathcal L)$.

At that witness the denominators are comfortable, $\mu+\beta u_{\min}=\tfrac{\sqrt3}{2}\cdot\tfrac{\sqrt3}{2}\sqrt T>0$, so claim 6 has slack where claim 7 needs it most.

### Batch 28's points do carry $[\hat U,C]\ne0$

Checked by hand on the record's own data rather than by rerunning anything. At $u=(3,1,-4)$ with $w_3=0$ and $w_1=w_2=1$ the commutator entries are $K_{12}=0$, $K_{13}=(u_1-u_3)w_2=7$ and $K_{23}=(u_2-u_3)w_1=5$, giving $\lVert K\rVert_F=\sqrt{148}=12.1655$, which matches batch 28. The denominators are $\mu+\beta u_k$ with $\beta=\tfrac94$:

| $\mu$ | $\mu+\beta u_1$ | $\mu+\beta u_2$ | $\mu+\beta u_3$ | $[\hat U,C]_{13}$ | $[\hat U,C]_{23}$ |
|---|---|---|---|---|---|
| $-6.06130$ | $0.68870$ | $-3.81130$ | $-15.06130$ | $-26.679$ | $3.443$ |
| $-24.43870$ | $-17.68870$ | $-22.18870$ | $-33.43870$ | $-155.321$ | $-88.444$ |

**No denominator vanishes and both off-diagonal entries of $[\hat U,C]$ are nonzero at all four points**, so the block's assertion that they satisfy the identities with $[\hat U,C]\ne0$ holds. An argument could not have replaced these six subtractions, since the numbers are the definition of the points.

## The Lean file, statement by statement

I compared each declaration in [I106Criticality.lean](../lean/HamiltonsCubic/Results/I106Criticality.lean) against the block's words rather than against a build.

**What matches.** [commutator_from_C](../lean/HamiltonsCubic/Results/I106Criticality.lean) and [commutator_from_A](../lean/HamiltonsCubic/Results/I106Criticality.lean) hypothesise exactly the brief's Lagrange forms with the multiple of the identity present as $c$, quantify over arbitrary square matrices with no symmetry or trace hypothesis, and conclude the two displayed relations. **Claims 1, 2 and 3 are typed faithfully.** The three [entry_relation](../lean/HamiltonsCubic/Results/I106Criticality.lean) declarations put tracelessness into $\hat U$ by writing $u_3=-u_1-u_2$ and leave $V$'s diagonal free, which is right, since the entrywise form needs tracelessness of $\hat U$ and nothing about $V$.

**Three mismatches worth recording.**

- **No declaration states $(\mu+\beta u_k)K_{ij}=[\hat U,C]_{ij}$.** The three entry relations evaluate the left-hand matrix of [commutator_from_C](../lean/HamiltonsCubic/Results/I106Criticality.lean) at one entry and factor the result. The bridge to $[\hat U,C]$ exists only inside the proof of [K_zero_of_field_commutes](../lean/HamiltonsCubic/Results/I106Criticality.lean). The claim the block displays is therefore typed as a composite and not as a statement.
- **[K_zero_of_field_commutes](../lean/HamiltonsCubic/Results/I106Criticality.lean) concludes three scalar products vanish, not $K=0$.** For $\hat U$ diagonal and $V$ symmetric those three products are all of $K$, since the diagonal entries of $K$ vanish identically, but that last step is not in the file. The statement is weaker than the words "drawing the conclusion".
- **The falsity of the entrywise form without tracelessness is typed nowhere**, so the control that makes "tracelessness is load-bearing" a checkable claim lives only in the screen. That is acceptable, and the file header should say it rather than leaving the claim to read as typed.

**What a Lean statement would need for the untyped claims.** The file header says maximisers are not typed and is right, and the brief asks what each would take.

| claim | typeable as it stands? | what it needs |
|---|---|---|
| 4 | **yes, today** | a linear-combination lemma over an arbitrary ring, hypotheses being the two Lagrange equations, conclusion the display. The `module` tactic closes it the same way the other two are closed. The inversion is a second statement taking $(\alpha-\beta)\mu\ne0$ |
| 6 | **yes, today** | $\mu\ge2\beta t/\sqrt6$ and $3u_k^2\le2t^2$ and $\beta>0$ imply $\mu+\beta u_k\ge0$, where $t$ stands for $\lvert\hat U\rvert$. It is [jordan_gap_le](../lean/HamiltonsCubic/Results/I106Criticality.lean) plus `nlinarith`, and the bound enters as a hypothesis exactly as [mu_ge_of_rayleigh](../lean/HamiltonsCubic/Results/I106Criticality.lean) already lets it |
| 7 | **the hard half, yes** | the equivalence with the bound as a hypothesis rather than as a theorem about maximisers, so the statement reads "if $\mu\ge2\beta\lvert\hat U\rvert/\sqrt6$ then $K=0\iff[\hat U,C]=0$". That is [K_zero_of_field_commutes](../lean/HamiltonsCubic/Results/I106Criticality.lean) with the three denominator hypotheses replaced by the bound and the equality case discharged inside, which is the version worth having, since it is where the argument actually lives |
| 8 | **yes, today** | the diagonality of $A$ and $C$ as `Matrix.diagonal` hypotheses, then the entry computation. Nothing about maximisers enters |
| 9 | **yes, with D5's argument** | scalar $A$ and $C$, the two Lagrange equations, conclusion $\hat U V=V\hat U$. The $\mu=0$ branch is the case split in [D5](#d5) and needs $\alpha>0$, $\beta>0$ |
| 10 | **no** | it is a statement about what is absent from a proof, and about four numerically located points |

**The only genuinely untypeable item is the "at a global maximum" quantifier**, because the record has no Lean definition of the constraint surface or of a maximiser. Everything else on that list is within reach of the same tactics the file already uses, and claim 7 in the hypothesised form is the one I would type next.

## What I would change in the record

1. **Fix "which those points clear" to "which those points fail"** in batch 30's closing paragraph. It is a false statement about batch 28's points and it inverts the reason the equivalence is safe. ([D4](#d4))
2. **Replace "the open case ... is now the single condition $[\hat U,C]\ne0$"** with the stronger and correct "what is owed is $[\hat U,C]=0$ at every global maximum, which closes the node outright". ([D3](#d3))
3. **Fix $[\hat U,V^2]$ to $[\hat U,\{\hat U,V\}]$** in batch 30 and in the docstring of [commutator_from_C](../lean/HamiltonsCubic/Results/I106Criticality.lean). ([D1](#d1))
4. **Move $\alpha\ne\beta$ and $\mu\ne0$ off the displayed identity and onto the inversion**, and say where $\mu\ne0$ comes from at a critical point as against a maximum. ([D2](#d2))
5. **Add the $\mu=0$ branch to claim 9**, in the three lines of [D5](#d5), so "a critical point with both fields scalar commutes" is derived rather than asserted.
6. **Add to batch 18** that the bound comes from the second-order condition in the direction $(0,Y)$ and therefore holds at $V=0$, where the trust-region phrasing is vacuous, and that the constant is sharp, attained at $\hat U\propto V\propto\operatorname{diag}(2,-1,-1)$ with $\lvert\hat U\rvert^2=T/2$ and $\mu=\tfrac{3\sqrt3}4\sqrt T$ when both fields are scalar.
7. **Record that batch 30 descends from batch 10 and is independent of batch 15 in both directions**, which is the answer to whether it is new information. It is.
8. **Say in the Lean header that the entrywise control is screened rather than typed**, and that [K_zero_of_field_commutes](../lean/HamiltonsCubic/Results/I106Criticality.lean) concludes three entries rather than $K=0$.
