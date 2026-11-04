# Review r961, Gate 2 on I106 batches 32 and 33, and post F69

**Brief**: [BRIEF_I106_batches32_33.md](BRIEF_I106_batches32_33.md). **Log**: [agent_logs/r961-batches32-33.log](../agent_logs/r961-batches32-33.log).

Adversarial audit. Every claim below is derived here from the definitions in the brief. No code under review was imported, and the criticality system was rebuilt from the Lagrange forms rather than taken from the record.

## Verdicts

| # | claim | verdict |
|---|---|---|
| 1 | $[\hat U,V^2]=\{V,K\}$, and $[\hat U,A]=-\beta\{V,K\}$ for the $A$ Lagrange form | CONFIRMED |
| 2 | $[\hat U,\beta V^2+A]=0$ at every critical point, so batch 7's condition is an identity | CONFIRMED |
| 3 | Post F69's test is correct as stated, and its scope is not overreach | CONFIRMED, with a propagated sentence elsewhere REFUTED |
| 4 | The orbit preserves both norms and the internal part, so the curve lies in the constraint set | CONFIRMED |
| 5 | $X=[\Omega,\hat U]$, $Y=[\Omega,V]$ is traceless symmetric and satisfies the tangency form identically | CONFIRMED |
| 6 | First order along the orbit is $[\hat U,A]+[V,C]=0$, an identity under the Lagrange forms | CONFIRMED |
| 7 | $Q(\Omega)$ has the displayed form, is not identically zero, and the multiples of $I$ drop out | CONFIRMED |
| 8 | $Q(\Omega)\ge0$ equals batch 21's inequality at the orbit direction, exactly | CONFIRMED |
| 9 | $Q\ge0$ is equivalent to a lower bound on $\mu$, a generalised eigenvalue | CONFIRMED, with a degeneracy caveat |
| 10 | The table's four rows, and the conclusion that the orbit bound excludes nothing new | **REFUTED in one cell**, every number reproduced |

Nothing in the mathematics of either block is broken. One verdict cell of batch 33's table states the opposite of what its own numbers say, and two sentences that propagate out of these blocks into [findings/second-order.md](../findings/second-order.md) claim more than the blocks establish.

## Which numbers I reproduced, and which I did not

The brief warns that two numbers in the table were once recorded at twice their size. I therefore rebuilt the whole chain rather than spot-checking it: the system, the quadratic, the roots, the recovered $V$, and the bound.

**The system.** Requiring $A$ and $C$ to be diagonal in one frame is $[A,C]=0$ for the symmetric pair, three equations in $(a_1,a_2,\mu)$. In $\hat U$'s eigenframe at $w_3=0$, $w_1=w_2=w$ I get $[A,C]_{12}=-\tfrac{81}{16}w^2\big(a_1(2u_1+u_2)-a_2(u_1+2u_2)\big)$, and $2u_1+u_2=D_2$, $u_1+2u_2=D_1$, so the $(1,2)$ equation is exactly batch 28's $a_1D_2=a_2D_1$. **Reproduced.**

**Batch 29's quadratic.** Substituting $a_1=sD_1$, $a_2=sD_2$ and eliminating $s$ from the other two equations by resultant gives $\tfrac{531441}{65536}(u_1-u_2)^2\,P(\mu)^2$ with $P$ equal, coefficient for coefficient, to $c_2\mu^2+c_1\mu+c_0$ as the brief displays it. **Reproduced, all three coefficients, symbolically in $u_1,u_2$.**

**Every number in the audited table.** All ten values below are mine, computed from my own system.

| spectrum | $\mu$ | $(a_1,a_2)$ | $\lVert K\rVert$ | batch 18 | batch 21 | orbit $\lambda_{\max}$ |
|---|---|---|---|---|---|---|
| $(3,1,-4)$ | $-6.06130$ | $\pm(1.58669,2.22137)$ | $12.1655$ | $9.36750$ | $15$ | $11.27393$ |
| $(3,1,-4)$ | $-24.43870$ | $\pm(11.77482,16.48475)$ | $12.1655$ | $9.36750$ | $15$ | $-12.52940$ |
| $(19,-20,1)$ | $5.61547$ | $\pm(46.91679,-40.21439)$ | $39.1152$ | $50.71242$ | $75$ | $97.95009$ |
| $(19,-20,1)$ | $762.38453$ | $\pm(630.66564,-540.57055)$ | $39.1152$ | $50.71242$ | $75$ | $105.69267$ |

Every entry agrees with the record to the digits the record prints, including the two that were once doubled, $11.274$ and $-12.529$. The Gate 1 control also reproduces: at $\mu=5.61547$ the record reports $a=(-46.9168,40.2144)$ and $\lVert K\rVert=39.1152$, which is my row up to the sign pair batch 28 records. Residuals $\lVert[A,C]\rVert$ ran from $6\cdot10^{-15}$ to $8\cdot10^{-9}$, the last at $\mu=762.38453$ where the entries are of order $10^3$.

**What I did not reproduce**: batch 29's value comparison (the factor $1.39$ to $1.54$, the floor $1.0915$) and batch 22's leading coefficient, none of which these two blocks rest on.

## The one refutation, claim 10's second row

The table's second row reads **"orbit CLEARS it, and is weaker than both"** at $\mu=-24.43870$ against an orbit requirement of $-12.529$.

**The orbit bound excludes that point.** The condition is $\mu\ge\lambda_{\max}$, and $-24.43870<-12.52940$. My pencil at that point has spectrum $(-24.0097,-14.2045,-12.5294)$, so $Q(\Omega)<0$ in the top direction and the point fails the orbit condition outright.

**The record contradicts itself here, and the table is the wrong half.** Batch 33's own Gate 1 note says *"An earlier reading of these same numbers said the orbit bound excluded two of the points tested, which is true and misleading"*. That earlier reading is the correct one on the arithmetic. The repair kept the right complaint, that the exclusion is uninformative because both points were already excluded, and attached it to the wrong verdict word.

**The correct row**: `excluded by all three, and the orbit bound is weaker than both`. The second clause survives, since $-12.529<9.3675<15$ compares thresholds and is true.

**The headline survives.** "The orbit bound excludes no point that batches 18 and 21 do not already exclude" is unaffected, because the point this row concerns is excluded by all three rather than by the orbit alone.

## What the four points understate, from six more

I screened the orbit bound at the other three spectra batch 29 itself names as carrying positive $\mu$. This was seconds of arithmetic on objects the record already holds, and I report it as a screen. An argument could not replace it: the question is whether a specific finite list of known critical points is separated by these bounds, and the bounds are generalised eigenvalues of an explicit pencil.

| spectrum | $\mu$ | batch 18 | batch 21 | orbit | what excludes it |
|---|---|---|---|---|---|
| $(1,-3,2)$ | $7.39940$ | $6.8739$ | $11.2500$ | $7.67177$ | batch 21 and the orbit, **batch 18 clears it** |
| $(1,-3,2)$ | $11.60060$ | $6.8739$ | $11.2500$ | $11.46022$ | **nothing, it survives all three** |
| $(2,-5,3)$ | $12.27757$ | $11.3248$ | $18.7500$ | $12.35703$ | batch 21 and the orbit, **batch 18 clears it** |
| $(2,-5,3)$ | $18.38909$ | $11.3248$ | $18.7500$ | $17.95160$ | batch 21 alone, **the orbit clears it** |
| $(-1,-3,4)$ | $6.06130$ | $9.3675$ | $11.2500$ | $11.58852$ | all three |
| $(-1,-3,4)$ | $24.43870$ | $9.3675$ | $11.2500$ | $24.00970$ | **nothing, it survives all three** |

Three things follow, and two of them cut against the record's wording.

- **The negative conclusion holds on a wider sample than the block tested.** Across all ten points, no point is excluded by the orbit bound alone. That is stronger evidence than four points, and it is still a finite sample on the stratum $w_3=0$, $w_1=w_2=1$.
- **The orbit bound is not redundant against batch 18.** At $(1,-3,2)$ and $(2,-5,3)$ it excludes points batch 18 clears. It is redundant only against the **pair**, which is a weaker and different statement than "it is the same shape as batches 18 and 21".
- **More than one non-commuting critical point survives all three conditions.** The record calls the $(19,-20,1)$ root *"the surviving non-commuting critical point of batch 29"*, in the singular. $(1,-3,2)$ at $\mu=11.60060$ and $(-1,-3,4)$ at $\mu=24.43870$ survive all three as well, and by margins of a few per cent rather than the factor of seven at $(19,-20,1)$. **These are the points that press hardest on batch 29's value comparison**, and they were not tested against it here.

The $(-1,-3,4)$ pair is also an internal control on my own numbers: $(-1,-3,4)$ is a transposition of $-(3,1,-4)$ preserving $w_3=0$ and $w_1=w_2$, the map $(\hat U,V,\mu)\mapsto(-\hat U,V,-\mu)$ carries critical points to critical points and sends $\lambda_{\max}$ to $-\lambda_{\min}$, and my two tables satisfy that relation to every digit printed.

## Claims 1, 2, 6, and what batch 7 still has

Claims 1, 2 and 6 are exact matrix identities needing neither tracelessness nor symmetry of the fields, and each closed in one line by hand and again symbolically with the multiples of $I$ carried.

$\{V,K\}=V(\hat UV-V\hat U)+(\hat UV-V\hat U)V=\hat UV^2-V^2\hat U=[\hat U,V^2]$, whence $[\hat U,A]=-\beta[\hat U,V^2]=-\beta\{V,K\}$ and $[V,C]=-\beta[V,\{\hat U,V\}]=\beta\{V,K\}$. Claim 2 and claim 6 are the two ways of adding these.

**On whether claim 2 is vacuous in the damaging sense.** It is vacuous exactly as the block says, and the block is right that a cycle spent on the commutator alone would have derived nothing. **What the block's framing loses is that batch 7 is not exhausted by its commutator.** Batch 7 says the supremum is $\psi(\beta V^2+A)+\mathop{\mathrm{tr}}(VC)$ with $\psi$ the **global** supremum of $\alpha\mathop{\mathrm{tr}}U^3+\mathop{\mathrm{tr}}(UM)$ on the sphere. Diagonalise $\hat U$ and $M=\beta V^2+A$ together, as the commuting condition permits: criticality admits **every** pairing of the eigenvalues of $\hat U$ against those of $M$, while the supremum selects among them, and by rearrangement the maximiser sorts the two spectra the same way. That selection is genuine maximality information, it is invisible to the first-order equations, and post F69's substitution does not touch it.

So batch 32's title, "the obvious maximality input is vacuous", is right about the obvious input. The record should not carry it as having closed batch 7 as a lever, only as having closed the commutator reading of batch 7.

## Claim 3, post F69, and one sentence that has to change

**[Post F69](../findings/fence-posts.md) is correct as written.** Its title says a condition on the fields *can be* criticality restated and that the test is to substitute, its body proves the substitution for this one case, and its closing says *"nothing here says a maximality input cannot exist"*. As a test it is sound and the hedging is in the right places. Batch 32's own sentence, *"a condition on them can be criticality wearing a different coat"*, is hedged the same way.

**The sentence that propagates out of it is not.** [findings/second-order.md](../findings/second-order.md) line 1052 reads: *"A condition on the fields is not an input, since the fields are defined by the criticality equations and substituting their Lagrange forms collapses such a condition to an identity"*. That is the unhedged version, and it is false.

**The counterexample is this derivation's own standing hypothesis.** $[A,C]=0$, that $A$ and $C$ are diagonal in one frame, is a condition on the fields alone. Substituting the Lagrange forms does not collapse it: it produces the three equations of batch 28 and, after elimination, batch 29's quadratic in $\mu$. A condition on the fields that yields the derivation's entire non-trivial solution set is the furthest thing from an identity. The distinction that makes F69 work is narrower than that sentence: a condition collapses when it commutes $\hat U$ (or $V$) against a field whose Lagrange form **already contains the term being commuted against**, which is a property of that particular pairing rather than of conditions on fields generally.

**Required change**: that clause must be rewritten to the hedged form the post itself carries, for instance that a condition on the fields is not automatically an input and must be tested by substitution.

## Claims 4, 5, 7, 8, 9

**Claim 4.** Exact, and by argument rather than by series. For $g\in O(3)$ the map is a similarity, so $\mathop{\mathrm{tr}}\hat U^3$ and $\mathop{\mathrm{tr}}(\hat UV^2)$ are invariant, and it is orthogonal, so $\lvert\hat U\rvert$ and $\lvert V\rvert$ are invariant. Hence $T$ is constant along the orbit and the curve lies in the constraint set exactly. **The brief's worry about the acceleration term is answered better than by batch 21's argument.** Because the orbit is an honest curve inside the constraint set and the internal part is constant along it, $\Phi(\gamma(t))=\text{const}+f(t)$ with $f(t)=\langle\hat U(t),A\rangle+\langle V(t),C\rangle$, and a local maximum gives $f''(0)\le0$ directly. No multiplier, no criticality and no dropped acceleration term enter at all. Differentiating twice, $\ddot{\hat U}=[\Omega,[\Omega,\hat U]]$ and $\mathop{\mathrm{tr}}([\Omega,X]Y)=-\mathop{\mathrm{tr}}(X[\Omega,Y])$ give $f''(0)=-Q(\Omega)$, so $Q\ge0$. The criticality assumption re-enters only when the Lagrange forms are substituted to produce the $\mu$ form, which is the right place for it.

**Claim 5.** $[\Omega,\hat U]^{\mathsf T}=\hat U^{\mathsf T}\Omega^{\mathsf T}-\Omega^{\mathsf T}\hat U^{\mathsf T}=[\Omega,\hat U]$ for skew $\Omega$ and symmetric $\hat U$, and the trace of a commutator vanishes. The tangency form holds in the strong sense that **each term vanishes separately**: $\mathop{\mathrm{tr}}(\hat U[\Omega,\hat U])=\mathop{\mathrm{tr}}(\hat U^2\Omega)-\mathop{\mathrm{tr}}(\hat U^2\Omega)=0$, and likewise for $V$. Confirmed symbolically too.

**Claim 7.** The displayed form is an identity, the derivatives of $Q$ in both multiples of $I$ are zero, so they drop out, and $[\Omega,X]$ is symmetric so $\mathop{\mathrm{tr}}([\Omega,\hat U]^2)=\lvert[\Omega,\hat U]\rvert^2\ge0$. On "not identically zero" I checked the stronger thing the block needs: $Q$ is not identically zero **on the criticality variety**, which is what would have made it vacuous the way the first-order condition is. At all ten critical points above, $R\ne\mu N$ as forms, and at eight of them $Q$ is actually negative in some direction. The second-order condition has real content.

**Claim 8.** Exact, and this is the claim the brief asks to be hardest on. Derived independently from the two sides. With $X=[\Omega,\hat U]$ and $Y=[\Omega,V]$, the three pieces of the block's $\mu$ form evaluate as $[\Omega,\hat U^2]=\{\hat U,X\}$, $[\Omega,V^2]=\{V,Y\}$ and $[\Omega,\{\hat U,V\}]=\{X,V\}+\{\hat U,Y\}$, giving
$$3\alpha\mathop{\mathrm{tr}}(X\{\hat U,X\})=6\alpha\mathop{\mathrm{tr}}(\hat UX^2),\quad \beta\mathop{\mathrm{tr}}(X\{V,Y\})=2\beta\mathop{\mathrm{tr}}(XVY),\quad \beta\mathop{\mathrm{tr}}(Y(\{X,V\}+\{\hat U,Y\}))=2\beta\mathop{\mathrm{tr}}(XVY)+2\beta\mathop{\mathrm{tr}}(\hat UY^2),$$
using $\mathop{\mathrm{tr}}(XYV)=\mathop{\mathrm{tr}}(XVY)$ for symmetric factors. Summing gives batch 21's left-hand side exactly, so $Q(\Omega)=\mu(3\lvert X\rvert^2+\lvert Y\rvert^2)-\big(6\alpha\mathop{\mathrm{tr}}(\hat UX^2)+4\beta\mathop{\mathrm{tr}}(XVY)+2\beta\mathop{\mathrm{tr}}(\hat UY^2)\big)$ and $Q\ge0$ is batch 21's inequality at that direction, with no slack. Confirmed again symbolically over generic symmetric pairs. **Batch 33 is a specialisation of batch 21 and not new mathematics, and the block says so in those words.**

**Claim 9.** Correct, with one caveat the block does not state. $N(\Omega)=3\lvert[\Omega,\hat U]\rvert^2+\lvert[\Omega,V]\rvert^2$ is positive **semi**definite, and $N(\Omega)=0$ exactly when $\Omega$ commutes with both $\hat U$ and $V$. The block's "the $\mu$ term is a positive multiple of $\mu$" therefore needs $\hat U$ or $V$ to be regular enough to kill the joint stabiliser. On the kernel the constraint is empty rather than violated, since $X=Y=0$ forces $Q=0$, so the honest statement is $\mu\ge\lambda_{\max}$ of the pencil restricted to the complement of $\ker N$. At all ten points $N\succ0$, with smallest eigenvalue from $27.6$ to $4.1\cdot10^{5}$. The caveat bites only on degenerate configurations, for instance $\hat U$ with a repeated eigenvalue whose eigenplane $V$ also respects, and those are exactly the configurations the $\lvert J\rvert=3$ node cares about, so it is worth a clause.

## The Lean layer

I compared statements against the block's words rather than trusting the build.

- **[orbit_first_order_vacuous](../lean/HamiltonsCubic/Results/I106Criticality.lean)** says what claim 6 says, and slightly more: it is stated for arbitrary matrices, so neither symmetry nor tracelessness is used. Faithful.
- **[orbit_second_order_form](../lean/HamiltonsCubic/Results/I106Criticality.lean)** is stronger than the block's display, an identity of **matrices** rather than of traces, again for arbitrary `W`. Faithful, and the file's own docstring correctly warns that it does not say the form is nonnegative.
- **One gap.** [Afield](../lean/HamiltonsCubic/Results/I106Criticality.lean) and [Cfield](../lean/HamiltonsCubic/Results/I106Criticality.lean) carry **no multiple of the identity**. So the clause "the multiples of $I$ drop out", which the sympy screen does check and which post F69 leans on, is typed nowhere. It is a one-line addition: the statements are unchanged under `A + c • 1` because `⁅W, c • 1⁆ = 0`.

Of the claims typed nowhere, **claim 8 is the one that should be typed**, and it is easy. It is a polynomial identity in the same shape as [orbit_second_order_form](../lean/HamiltonsCubic/Results/I106Criticality.lean) and closes by `module` the same way, and it carries the block's central assertion that the orbit condition is batch 21's condition. Claim 2 is likewise a one-line matrix identity and is the entire content of post F69, which currently has no typed form at all. Claims 1 and 5 are trivial to type. Claim 4 is typeable using orthogonality of `g` and `Matrix.trace_mul_comm`. Claim 9 is statable but needs the positive-definiteness hypothesis and a genuine eigenvalue argument. **Claim 10 should not be typed**: it is a numerical comparison at named points, and typing the algebraic roots would carry none of its meaning.

## What I would change in the record

1. **[reviews/2026-09-15-I106-m3-derivation.md](2026-09-15-I106-m3-derivation.md), batch 33's table, row 2.** Replace `orbit CLEARS it, and is weaker than both` with `excluded by all three, and the orbit bound is weaker than both`. This is the refutation, and the block's own Gate 1 note already contains the correct reading.
2. **[findings/second-order.md](../findings/second-order.md) line 1052.** Rewrite *"A condition on the fields is not an input ... collapses such a condition to an identity"* to the hedged form post F69 itself carries. As written it is refuted by $[A,C]=0$, this derivation's own standing hypothesis, whose substitution is batch 29's quadratic.
3. **Scope the negative conclusion.** Both the block's bolded conclusion and its index line should say that the orbit bound excludes nothing new **at the points tested, on the stratum $w_3=0$, $w_1=w_2$**. The evidence is now ten points rather than four, which is worth recording, and it is still a sample.
4. **Drop "it is the same shape as batches 18 and 21, which is the first sign that it will not close anything"**, or qualify it. The orbit bound is the strongest of the three at four of the ten points, and at $(1,-3,2)$ and $(2,-5,3)$ it excludes points batch 18 clears. It is redundant against the pair, not weak.
5. **Correct the singular in "the surviving non-commuting critical point of batch 29"**. At least three survive all three conditions, and the two new ones survive by a few per cent rather than by a factor of seven. **This is the useful part of my screen**: the tightest known configurations against batch 29's value comparison are at $(1,-3,2)$, $\mu=11.60060$, and $(-1,-3,4)$, $\mu=24.43870$, not at $(19,-20,1)$.
6. **Record what batch 7 still has.** Batch 32 closes the commutator reading of batch 7. The selection statement, that the maximiser sorts the spectrum of $\hat U$ with that of $\beta V^2+A$, is maximality information that survives post F69's test and is not recorded anywhere.
7. **Add the $\ker N$ clause to claim 9**, and type the identity-multiple invariance beside the two orbit declarations.

## What I could not break

Claims 1, 2, 4, 5, 6, 7, 8 and 9 are correct, and claim 8, the load-bearing one, is exact with no slack by two independent derivations. Every number in the audited table reproduced, including both of the pair that had been doubled. **The blocks' mathematics stands. What needs repair is one verdict word, one propagated sentence, and the scope of a negative conclusion.**
