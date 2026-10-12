# r983: Gate 2 on I104's two Gram claims, and whether they stand at the same configuration

Reviewer r983, working from [BRIEF_I104_gram_claims.md](BRIEF_I104_gram_claims.md) alone. The working note the blocks were drawn from and the scripts under review were left unread, as the brief directs.

**Sole reviewer of this round.** The brief gives the reason: both blocks compare a computed number against a bound the record already calls exact, so a second reader would repeat the same comparison. Two places below are outside that reason and would need a second pair of eyes, and they are marked where they arise: the identification of the $u_i$ in $F_i$ with the $u_i$ of the Gram bound, and the $\tau$ ceiling the sweep of claim 3 must have used.

## Verdicts

| # | claim | verdict |
|---|---|---|
| 1 | $u_{\mathrm{lo}}$ minimises $\sum_iu_i^2$ over the admissible interval | **CONFIRMED**, and for a one-line reason the block does not give |
| 2 | the recorded worst configuration is excluded by the Gram bound | **CONFIRMED on the arithmetic**, with a point-identity defect below and one hypothesis a second reader must check |
| 3 | Gram-admitted worst shortfall $-0.014793$ at $N_i=0.218$, $\tau=0.0509$ | **PLAUSIBLE**. The stated point reproduces to $2\cdot10^{-5}$. **The extremum does not**, and it fails without a $\tau$ ceiling the brief never states |
| 4 | the joint system's two forms are equivalent under $\alpha_i=\sqrt3x_i$ | **CONFIRMED**, both coefficients right, and the Lean gap is real |
| 5 | the $x$-free part is violated by $0.140048$ and Cauchy--Schwarz forces $S_2\ge0.116707$ | **CONFIRMED**, direction included, and **not vacuous** |
| 6 | the scalar corollary discards exactly that, slack by $0.2586$ | **CONFIRMED**, and "exactly" is literally true for a reason worth recording |
| 7 | the deficit the estimates must now cover is $0.0148$ | **CONFIRMED as arithmetic on block 1 alone**, and it inherits claim 3's exposure |
| 8 | the two blocks are stated at the SAME configuration | **REFUTED** |

## The headline

**Claim 8 is false and the brief was right to suspect it.** The Gram-exclusion block works at $t=0.196$ and $t=0.166$, the joint-forcing block at $t=0.598$. These are not neighbouring points on one grid. They are configurations with $N_i=0.268$ and $N_i=0.278$ against $N_i=0.134$, a factor of two apart in every block mass. **The $0.1167$ forcing therefore has no bearing on the $0.0148$ deficit**, and claim 7's arithmetic is well posed only because it never uses the second block: the $0.02$ and the $0.0148$ both come out of the first block's sweep.

**The repair is cheap and I have done it below**: run the same forcing at the Gram-admitted worst instead of at $t=0.598$, where it says something much sharper than it says at $t=0.598$.

**The second finding is that claim 3's extremum is unsupported by anything in the brief.** Restricting to Gram-admitted configurations does not on its own produce $-0.0148$. It produces $-0.0515$.

## Claim 8, settled first

$t=1-N$ and $N=\sum_iN_i=3N_i$ on the equal-$N$ grid both blocks use.

| block | $N_i$ | $N$ | $t$ | $\sum_iu_i^2$ |
|---|---|---|---|---|
| Gram exclusion, as the record's prose locates it | $0.268$ | $0.804$ | $0.196$ | $0.503844$ at $u_{\mathrm{lo}}$ |
| Gram exclusion, as the block's own table locates it | $0.278$ | $0.834$ | $0.166$ | $0.486376$ at $u_{\mathrm{lo}}$ |
| joint forcing | $0.134$ | $0.402$ | $0.598$ | $0.738048$ at $u_a=0.496$ |

The internal control is that the exclusion block's own numbers come out of the first row: $u_{\mathrm{lo}}=(\theta-2\tau/N_i)/\sqrt3=0.409814$ at $\tau=0.069$, so $3u_{\mathrm{lo}}^2=0.503844$, printed as $0.504$, and $\tfrac53t=\tfrac53(0.196)=0.326667$, printed as $0.327$. Both of the block's figures are reproduced exactly, which fixes $t=0.196$ beyond argument. The joint-forcing block states $t=0.598$ in its own first sentence.

**What claim 7 is actually comparing.** Both the $-0.020422$ and the $-0.014793$ are rows of one table produced by one sweep, so subtracting the second from the first, or replacing the first by the second, is arithmetic within a single object. That part is sound. **What it is not is a combination of the two blocks**, and the item should not present it as one. The $S_2\ge0.116707$ number belongs to a configuration that appears nowhere in the deficit accounting.

**A third configuration, not two.** Worth saying plainly, because "the same configuration" is false in a stronger way than a two-way mismatch: the Gram-admitted worst is at $N_i=0.218$, $t=0.346$, which is neither of the other two. The item's three quantitative statements sit at $t=0.196$ (or $0.166$), $t=0.346$ and $t=0.598$.

### The forcing redone where it belongs

At the Gram-admitted worst, $t=0.346$ and $u_i=u_{\mathrm{lo}}=0.437500$, so $\sum u^2=0.574219$. The $x$-free part $\sum u^2\le t$ is violated by $0.228219$, and the same Cauchy--Schwarz step gives

$$S_2\ \ge\ \frac{0.228219}{1.2}\ =\ 0.190183 .$$

Against this there is an upper bound the item does not use. Since $u_a^2=\alpha_a^2+\beta_a^2$ and $\beta_a^2\ge0$, $\alpha_a^2\le u_a^2$, and with $\alpha_i=\sqrt3x_i$ that is $S_2=\tfrac13\sum_a\alpha_a^2\le\tfrac13\sum_au_a^2=0.191406$. So

$$0.190183\ \le\ S_2\ \le\ 0.191406,$$

**a window of width $0.00122$, about $0.6\%$.** The Gram-extremal configuration has $\beta=0$ and all $x_i$ equal with $S_2=5t/9=0.192222$, so the forcing pins the admitted worst to within one per cent of the extremal ray, with $\sum_a\beta_a^2\le0.574219-3(0.190183)=0.003670$. That is a real structural statement about the only configuration the deficit still has to survive, and it is the statement the item should be making instead of the $t=0.598$ one.

## Claim 1

**CONFIRMED**, and the block's stated reason is right but understates why it is airtight.

The admissible set is $\prod_i[u_{\mathrm{lo},i},\sqrt t\,]$, a product box, because $u_i\ge(\theta-2\tau/N_i)/\sqrt3$ constrains $u_i$ through $N_i$ alone and $u_i\le\sqrt t$ shares $t$ across coordinates without coupling them. The objective $\sum_iu_i^2$ is separable and, on $u_i\ge0$, increasing in each coordinate. A separable increasing function on a box attains its minimum at the componentwise lower corner, so no admissible triple can beat $\sum_iu_{\mathrm{lo},i}^2$.

**This answers the brief's mixing question in the negative and it is the whole content of the claim.** A configuration cannot mix endpoints to its advantage, because lowering any one coordinate below its own $u_{\mathrm{lo},i}$ is the only way to reduce $\sum u_i^2$ further and that is inadmissible. With $N_1=N_2=N_3$ the three lower endpoints coincide and the corner is $3u_{\mathrm{lo}}^2$, which is what the block computes.

**One hypothesis to write down.** The argument needs $u_{\mathrm{lo},i}\ge0$, which holds exactly when $2\tau/N_i\le\theta$. At all three points under review it holds with room ($2\tau/N_i$ is $0.4670$, $0.5149$ and $0.5273$ against $\theta=1.224745$). Where it fails the true lower endpoint is $0$ rather than the formula's value, the box corner is $\sum u^2=0$, and **the Gram test passes vacuously**. That case is not reached here, and the item should say so rather than leave the formula looking unconditional.

## Claim 2

**CONFIRMED on the arithmetic**, with one defect of point identity and one hypothesis I cannot settle from the brief.

The exclusion itself: $0.503844>0.326667$ at the first configuration and $0.486376>0.276667$ at the second, both by more than a factor of $1.5$, so the margin is nowhere near rounding. The admissible interval is non-empty at both ($u_{\mathrm{lo}}=0.409814\le\sqrt t=0.442719$, and $0.402648\le0.407431$), so the exclusion is not an artefact of testing an empty set. Combined with claim 1, no admissible triple at either configuration satisfies the Gram bound, so the configuration carries no $u$ at all and the negativity of $F_i$ there is moot. **The logic is valid.**

### The defect: the block excludes a configuration that is not the table's worst

The record's prose puts the worst at $N_1=N_2=N_3=0.268$, $\tau=0.069$, value $-0.020$. The block's table puts it at $N_i=0.278$, $\tau=0.0733$, value $-0.020422$. These are different points, and recomputing $F$ from the quoted formula separates them:

| point | $\min_u F$ over the admissible interval |
|---|---|
| $N_i=0.268$, $\tau=0.069$ | $-0.019077$ |
| $N_i=0.278$, $\tau=0.0733$ | $-0.020438$ |

The table's row reproduces to $1.6\cdot10^{-5}$, consistent with grid rounding of $\tau$. **The prose's row does not: at the point the prose names, the shortfall is $-0.0191$, which rounds to $-0.019$ and not to $-0.020.** So the figure $-0.020$ belongs to $(0.278,0.0733)$ and the location $(0.268,0.069)$ belongs to a different, less negative point. The exclusion block then computes $u_{\mathrm{lo}}=0.4098$ "at that configuration", which is the prose's point, so **the block excludes the point the prose names while the table's worst is elsewhere.**

**This does not break the conclusion**, because both points are excluded and by wide margins. It does mean the item currently carries two different "worst configurations" under one label, and a reader checking $-0.020$ at $(0.268,0.069)$ will not find it. One of the two rows needs correcting.

### The hypothesis a second reader must check

The Gram bound is proved for the three pattern projections of a single $D$, and its $u_i$ are the norms of those projections. The $u_i$ in $F_i$ are the block variables of the per-block slack. **Whether these are the same objects is not derivable from anything the brief quotes**, and the whole exclusion rests on it. From the brief alone I can say only that the two families are both indexed by $i\in\{1,2,3\}$ and both constrained by $u_i\le\sqrt t$ with the same $t$, which is suggestive and is not a proof. **This is the one place in the round where a second pair of eyes with the record open is genuinely needed**, and it is outside the brief's stated reason for running one reviewer, since it is not a comparison of two numbers.

What I can confirm about the bound's own reach: $\lambda_{\max}=\tfrac53$ is right for the sign pattern the record's rank-one statement forces. $G_e=\tfrac23I+\tfrac13J$ has eigenvalue $\tfrac53$ on $(1,1,1)$ and $\tfrac23$ on its complement. The "$\pm\tfrac13$" in the quoted statement is safe precisely because the cross-Gram is rank one, which forces the off-diagonals into the form $\varepsilon_i\varepsilon_j/3$, and a diagonal sign change carries that to the all-plus matrix without moving the spectrum. **Had the pattern been the frustrated one** (the three off-diagonal signs multiplying to $-1$, which no rank-one cross-Gram produces) **the matrix would be $\tfrac43I-\tfrac13J$ with $\lambda_{\max}=\tfrac43$**, and the exclusion would be stronger still, $0.504>\tfrac43(0.196)=0.261$. So the exclusion is robust to the sign question either way, and the joint system's exact coefficients are not.

## Claim 4

**CONFIRMED.** Both coefficients are right. Derived here rather than checked:

Start from $t\ \ge\ \sum_a\beta_a^2+\tfrac32\sum_a\alpha_a^2-\tfrac3{10}\big(\sum_a\alpha_a\big)^2$ and substitute $\beta_a^2=u_a^2-\alpha_a^2$:

$$t\ \ge\ \sum_au_a^2-\sum_a\alpha_a^2+\tfrac32\sum_a\alpha_a^2-\tfrac3{10}\Big(\sum_a\alpha_a\Big)^2\ =\ \sum_au_a^2+\tfrac12\sum_a\alpha_a^2-\tfrac3{10}\Big(\sum_a\alpha_a\Big)^2 .$$

With $\alpha_i=\sqrt3x_i$, $\sum_a\alpha_a^2=3\sum_ix_i^2$ and $(\sum_a\alpha_a)^2=3(\sum_ix_i)^2$, so $\tfrac12\sum\alpha^2=\tfrac32\sum x^2$ and $\tfrac3{10}(\sum\alpha)^2=\tfrac9{10}(\sum x)^2$, giving

$$\sum_iu_i^2\ \le\ t-\tfrac32\sum_ix_i^2+\tfrac9{10}\Big(\sum_ix_i\Big)^2 .$$

**The second form is the first, exactly**, and the two coefficients arise from $\tfrac32-1=\tfrac12$ and from $\sqrt3$ squaring through the cross term. The rewriting is reversible, so the two forms are equivalent rather than one being a weakening.

The quoted inverse is also right: $(\tfrac23I+\tfrac13J)(\tfrac32I-\tfrac3{10}J)=I+\big[\tfrac53c+\tfrac12\big]J$ at $c=-\tfrac3{10}$, which is $I$. So $\tfrac32\sum\alpha^2-\tfrac3{10}(\sum\alpha)^2$ is exactly the quadratic form $\alpha^{\mathsf T}G_e^{-1}\alpha$, and the first displayed form is the correct Schur-style statement rather than a bound with fitted constants.

**The Lean row is right and it is now an obligation.** After the substitution this is an identity in six real variables with no matrices in it, closed by `ring` (or by `nlinarith` if it is stated as the equivalence of two inequalities), and it is untyped. I confirm the gap.

## Claim 5

**CONFIRMED**, including the direction, and it is not vacuous.

Arithmetic: $\sum u^2=3(0.496)^2=0.738048$, and $0.738048-0.598=0.140048$ exactly as stated. Writing $S_1=\sum_ix_i$ and $S_2=\sum_ix_i^2$, the second form of the joint system says $\tfrac9{10}S_1^2-\tfrac32S_2\ \ge\ \sum u^2-t=0.140048$.

**The direction is correct and the brief's worry is unfounded.** The step upper-bounds the quantity that is known to be large, which is exactly how a lower bound on $S_2$ is produced. Cauchy--Schwarz at three terms gives $S_1^2\le3S_2$, hence

$$\tfrac9{10}S_1^2-\tfrac32S_2\ \le\ \tfrac{27}{10}S_2-\tfrac32S_2\ =\ \tfrac65S_2,$$

and chaining, $0.140048\le\tfrac65S_2$, so $S_2\ge0.140048/1.2=0.1167067$. The printed $0.116707$ is right. Mixing an upper bound into a lower-bound argument would be the error of bounding $\sum u^2-t$ from above, which the step does not do.

**The equality condition is stated slightly too strongly.** Equality in Cauchy--Schwarz needs all $x_i$ equal, and that is necessary for $S_2=0.116707$. It is not sufficient: the joint inequality must also be tight at that configuration. "With equality only when all $x_i$ are equal" is a correct necessary condition and reads as a characterisation, so the word "only" is carrying the sentence and should be kept.

**Vacuity.** A forced lower bound on a quantity nothing else constrains would buy nothing, and the brief is right to ask. $S_2$ is constrained from above, by $\beta_a^2\ge0$: $S_2=\tfrac13\sum_a\alpha_a^2\le\tfrac13\sum_au_a^2=0.246016$. So at $t=0.598$ the forcing gives $S_2\in[0.116707,\,0.246016]$, which is a genuine restriction and a loose one, occupying under half the available range. **The claim is not vacuous and at this configuration it is also not sharp.** Redone at the Gram-admitted worst it is sharp, as the claim-8 section shows, where the same two bounds leave a window of $0.6\%$. That is the argument for moving the block rather than deleting it.

## Claim 6

**CONFIRMED**, and the word "exactly" is literally true for a reason the block does not state.

Arithmetic: $\tfrac53(0.598)=0.996667$ against $\sum u^2=0.738048$, slack $0.258619$, printed as $0.2586$.

**Why "discards exactly that" is the right word.** The scalar corollary is the joint system with $x$ optimised out. Put all $x_i$ equal to $x$, so $\alpha_a=\alpha$ for all $a$. The first form reads $t\ge\sum\beta^2+\tfrac32(3\alpha^2)-\tfrac3{10}(9\alpha^2)=\sum\beta^2+\tfrac95\alpha^2$, while $\sum u^2=\sum\beta^2+3\alpha^2$. Eliminating $\sum\beta^2$ at its largest admissible value gives $\sum u^2\le t+\tfrac65\alpha^2$, and $\sum\beta^2\ge0$ caps $\alpha^2\le t/\tfrac95=\tfrac59t$, so

$$\sum u^2\ \le\ t+\tfrac65\cdot\tfrac59 t\ =\ t+\tfrac23t\ =\ \tfrac53t .$$

**So $\lambda_{\max}(G_e)=\tfrac53$ and the joint system are one statement read at two levels of detail**, the corollary being the system maximised over $x$ subject to $\beta=0$. The $0.2586$ of slack is precisely the part of the $x$-budget the configuration does not spend, and the joint system is what converts that unspent budget back into the $S_2$ forcing. The block's claim is correct and its justification is missing.

## Claim 3

**PLAUSIBLE.** The stated point reproduces. The extremum does not, and I think this is the item's second real exposure.

**What reproduces.** Recomputing $F_i$ from the quoted formula and the quoted interval, with $t=1-3N_i$ and the minimum taken over $[u_{\mathrm{lo}},\sqrt t\,]$:

| row | reported | recomputed | minimiser |
|---|---|---|---|
| all configurations | $-0.020422$ at $N_i=0.278$, $\tau=0.0733$ | $-0.020438$ | at $u_{\mathrm{lo}}$ |
| Gram-admitted only | $-0.014793$ at $N_i=0.218$, $\tau=0.0509$ | $-0.014808$ | at $u_{\mathrm{lo}}$ |

Both to $2\cdot10^{-5}$, which is grid rounding on $\tau$. **The two table rows are right at the points they name**, and the Gram verdicts attached to them are right: $3u_{\mathrm{lo}}^2=0.486376>0.276667$ for the first, and $0.574219\le0.576667$ for the second, admitted with headroom $0.00245$.

**What does not reproduce.** $F$ is increasing in $\tau$ at fixed $u$ ($\partial F/\partial\tau=+1$), but raising $\tau$ lowers $u_{\mathrm{lo}}$ at rate $-2/(N_i\sqrt3)$, and the endpoint effect dominates: at $N_i=0.218$ the total derivative of $\min_uF$ along $\tau$ is $1+F'(u_{\mathrm{lo}})\cdot(-5.297)=-2.07$. **So the sweep's worst configurations want $\tau$ as large as it is allowed to be**, and Gram admission wants $\tau$ large too, since $3u_{\mathrm{lo}}^2\le\tfrac53t$ is the condition $\tau\ge\tau_{\mathrm{Gram}}(N)$. The two pull the same way. Nothing in the brief says what stops $\tau$.

Sweeping the Gram-admission boundary itself, $\tau=\tau_{\mathrm{Gram}}(N)$, which is the *least* negative admitted $\tau$ at each $N$, over $N\in[0.05,1)$ at step $10^{-4}$:

- the minimum of $F$ sits at $u_{\mathrm{lo}}$ at $8876$ of $8999$ grid points, moving into the interior only for $N\ge0.9877$
- **$3426$ of those grid points, covering $N\in[0.6557,0.9982]$, have a shortfall worse than $-0.014793$**
- the worst is $\mathbf{-0.051512}$ at $N=0.9088$, $N_i=0.3029$, $\tau_{\mathrm{Gram}}=0.12646$, $t=0.0912$, and it is Gram-admitted by construction.

**So "Gram-admitted only" does not by itself yield $-0.0148$. It yields $-0.0515$, three and a half times larger.** The reported figure can only be right if a ceiling $\tau\le\tau_{\max}(N)$ excludes those configurations, and the brief's own phrase "with $\tau$ at its bound $0.069$" says such a ceiling exists in the record.

**The reported figures are consistent with that reading, and this is the strongest thing I can say for claim 3.** Backing the ceiling out of the three reported points against the admission boundary at the same $N$:

| $N$ | $\tau$ reported | $\tau_{\mathrm{Gram}}(N)$ | admitted |
|---|---|---|---|
| $0.654$ | $0.05090$ | $0.050724$ | yes, by $0.00018$ |
| $0.804$ | $0.06900$ | $0.087528$ | no |
| $0.834$ | $0.07330$ | $0.097127$ | no |

**The reported Gram-admitted worst sits exactly where the ceiling crosses the admission boundary.** At $N=0.654$ the reported $\tau$ and $\tau_{\mathrm{Gram}}$ agree to the fourth decimal, above $N=0.654$ the reported $\tau$ falls below $\tau_{\mathrm{Gram}}$ so the admitted $\tau$-interval is empty, and the boundary value first drops past $-0.014793$ at $N=0.6557$, three grid steps from the reported $N=0.654$. That is what a real, monotone ceiling crossing a real admission boundary looks like, and it is strong circumstantial support. **It is not verification**, because I was given neither $\tau_{\max}(N)$ nor the grid, and the whole of claim 3 and hence of claim 7 rests on it. **A second reader with the record open should state $\tau_{\max}(N)$ and confirm it caps $\tau$ below $\tau_{\mathrm{Gram}}(N)$ for every $N>0.6557$.** Until then the $0.0148$ should be recorded as conditional on the $\tau$ bound, not as a swept extremum.

**On the brief's other question**, whether $N_1=N_2=N_3$ is an assumption the record's own grid makes: the record's quoted sentence reports its worst at $N_1=N_2=N_3$ and the table reports a single $N_i$ per row, so the sweep is over the equal-mass diagonal. I have no way from the brief to tell whether that is the grid or a reported slice of a fuller one. **If it is the grid, the sweep bounds nothing off the diagonal**, and claim 1's box argument does not help, because claim 1 is about $u$ at fixed $N$ and says nothing about unequal $N_i$. That is a second thing a reader with the record should check.

## Claim 7

**CONFIRMED as arithmetic, with its framing corrected by claim 8.** Neither Gram statement closes the $0.020422$: the first removes the configuration where it occurs, which moves the operative shortfall to the next surviving one rather than reducing it to zero, and the second is stated at a configuration that plays no part in the accounting. The surviving figure is $-0.014793$, so $0.0148$ is what the estimates must cover. **The claim is well posed on block 1 alone and does not need block 2, which is the only reason claim 8's falsity does not damage it.** It inherits claim 3's exposure in full: if $\tau_{\max}$ does not cap the configurations found above, the deficit is $0.0515$ and not $0.0148$.

## Corrections, in the order I would make them

1. **Claim 8.** Delete the assertion that the two blocks share a configuration. They are at $t=0.196$ (or $0.166$) and $t=0.598$.
2. **Claim 3 and claim 7.** Record the $0.0148$ as conditional on the $\tau$ ceiling, and state the ceiling. On the admission constraint alone the worst is $-0.0515$ at $N=0.9088$.
3. **Claim 2.** Reconcile the prose's $(0.268,\,0.069,\,-0.020)$ with the table's $(0.278,\,0.0733,\,-0.020422)$. The prose's point has shortfall $-0.0191$.
4. **Claim 5.** Move the forcing to $t=0.346$, where it gives $S_2\in[0.190183,\,0.191406]$ and pins the surviving configuration to within one per cent of the Gram-extremal ray, instead of $t=0.598$, where it gives a range occupying under half the room available.
5. **Claim 1.** Add the hypothesis $2\tau/N_i\le\theta$, without which $u_{\mathrm{lo}}<0$ and the Gram test passes vacuously.
6. **Claim 6.** Add the two-line derivation of $\tfrac53t$ as the joint system at $\beta=0$ with all $x_i$ equal, which is what makes "exactly" true.

## Lean

I confirm the brief's row 4: the equivalence of the two forms of the joint system is an identity in $\alpha,\beta,x$ with no matrices in it, closed by `ring` after the substitution, and untyped. **It is an obligation.** Row 5's Cauchy--Schwarz step, $(\sum_ix_i)^2\le3\sum_ix_i^2$ at three terms, is likewise typeable and untyped, and a direct `nlinarith` is the shorter route, since the statement is $2(x_1^2+x_2^2+x_3^2)\ge2(x_1x_2+x_1x_3+x_2x_3)$, a sum of three squares.

**One correction to row 5 itself.** The lemma it names, `inner_mul_le_norm_mul_norm`, does not exist in current Mathlib under that spelling: it appears nowhere in the declaration data behind [the Mathlib4 documentation](https://leanprover-community.github.io/mathlib4_docs/). The declaration to reach for, if the inner-product route is taken rather than `nlinarith`, is [norm_inner_le_norm](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Analysis/InnerProductSpace/Basic.html#norm_inner_le_norm), with [InnerProductSpace.Core.norm_inner_le_norm](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Analysis/InnerProductSpace/Defs.html#InnerProductSpace.Core.norm_inner_le_norm) the pre-bundling form. **This is worth fixing in whatever generates these Lean rows**, since a brief that names a non-existent declaration sends the typing round down a dead path before it starts. I agree with the remaining rows that the other claims are comparisons of computed numbers or statements about the text, and carry no proposition to type.

## Screens

Assertions, no printed expectations, seconds of arithmetic on objects built from the brief's formulas for this review, under the standing analysis-only rule's screening allowance. The controls that had to hold and did: $t=1-3N_i$ at all three points; $u_{\mathrm{lo}}=0.4098$ and $3u_{\mathrm{lo}}^2=0.504$ and $\tfrac53t=0.327$ at the exclusion block's configuration; $-0.020422$ and $-0.014793$ recovered at the table's two points; the exclusion holding at both excluded points and failing at the admitted one; $\sum u^2=0.738048$ and the violation $0.140048$ and the slack $0.258619$ at $t=0.598$; $G_eG_e^{-1}=I$ with the quoted inverse; $\lambda_{\max}=\tfrac53$ on the rank-one pattern and $\tfrac43$ on the frustrated one; and $t+\tfrac65\cdot\tfrac59t=\tfrac53t$ at each of the three $t$ values. One assertion fired and became a finding: the minimum of $F$ is not at $u_{\mathrm{lo}}$ everywhere on the admission boundary, failing for $N\ge0.9877$, though it holds at every point under review.
