# Review r922, does Lemma L212 establish $\theta=1/(2\lVert W\rVert)$ on the multi-block family with no Einstein hypothesis?

Reviewer r922, Gate 2 on [Lemma L212](../findings/graded-half.md#lemma-l212-the-multi-block-vertex-solution-is-critical-at-every-partition-and-its-second-moment-is-the-norm-identity), read link by link against the hypotheses actually stated. Read in full: the L212 block and the multi-block norm identity above it at [graded-half.md:69-88](../findings/graded-half.md#L69), [conventions.md](../findings/conventions.md) entire, [ungraded-slack.md:20-60](../findings/ungraded-slack.md#L20), [L212VertexTheta.lean](../lean/HamiltonsCubic/Results/L212VertexTheta.lean) entire, [r653](REVIEW_r653.md) sections 2 and 4, [ROUND_L05](../verification/ROUND_L05.md), [VERIFY_v158](../verification/VERIFY_v158.md), [VERIFY_v159](../verification/VERIFY_v159.md), [VERIFY_v148](../verification/VERIFY_v148.md), and the L212 rows of [INDEX-results.md](../findings/INDEX-results.md), [LEDGER.md](../findings/LEDGER.md), [results.md](../results.md), [lean/INDEX.md](../lean/INDEX.md) and [ATTEMPTS.md](../ATTEMPTS.md). **Steps 1 and 2 and the criticality of the vertex solution were each derived by hand in general before anything was run**, and the only compute is one exact-rational screen of those derivations at ten partitions, seconds, reported as a screen. Analysis-only footing honoured, no long or open-ended run was made. The concurrent reviewer's report, log and [INDEX.md](INDEX.md) were not opened. Log: [agent_logs/gate2-l212-r922.log](../agent_logs/gate2-l212-r922.log).

| # | Item | Verdict | Reason |
|---|---|---|---|
| 1 | $t_F=2$ in the vertex frame | **GAP** | the premise is per-frame coordinate-diagonality, which is true and sits at [ungraded-slack.md:45](../findings/ungraded-slack.md#L45), while step 3 cites the *in some frame* clause the record warns is the extremal reading |
| 2 | $t$ a function of $K$ alone, the factor 4 | **CONFIRMED** | no contradiction, the brief's $\lVert\operatorname{diag}W\rVert^2=4\lVert W\rVert^2$ is two representatives compared, $\lVert W\rVert^2=4R$ at $\theta_g=1$ and $R$ at $\theta_g=\tfrac12$ |
| 3 | Step 2's arithmetic, $t=8R$ | **CONFIRMED** | proved as an identity at every $k$ and every partition by hand, screened in exact rationals at ten partitions including $k=5$ and $k=7$ |
| 4 | Step 1's Ricci-flatness | **CONFIRMED** | $\operatorname{Ric}(W)_{ik}=\sum_jW_{ijkj}$, and on the coordinate-diagonal locus the off-diagonal entries vanish identically, so the rows of $K$ exhaust it and the cancellation is exact |
| 5 | What is $\theta_g$, and the scaling claim | **CONFIRMED** | $\theta_g$ must be the $Q$-eigenvalue, it is in fact the Einstein constant $\lambda$ of the product, and the scaling is $Q$'s quadratic homogeneity |
| 6 | Is the vertex solution critical | **GAP** | criticality is needed and is never asserted, and I proved $Q(W)=\theta_gW$ holds for every partition, so the hole is in the writing |
| 7 | Same $W$ in identity and step 2 | **GAP** | three representatives are in play, and $\lVert W\rVert^2=R$ holds at none of the two the proof uses, so the display reads as $\theta=\tfrac12$ at unit norm |
| 8 | The bound's strictness | **CONFIRMED** | strict at every $k\ge2$ including $n_a=2$ blocks, and at $k=1$ the vertex solution is identically zero, so the family is empty rather than the bound false |
| 9 | The hypotheses actually dropped | **REFUTED in part** | local symmetry, Einstein and $\lambda\ne0$ genuinely go, and $\lambda=\tfrac12$ does not, being exactly what the conclusion $\theta=1/(2\lVert W\rVert)$ says |
| 10 | Padding | **CONFIRMED** | the hypotheses $n=\sum_an_a$ and $n_a\ge2$ exclude every padded copy, and step 2 is the one step that would break if $n$ were read as ambient |
| 11 | Already on the record | **GAP** | [ungraded-slack.md:29](../findings/ungraded-slack.md#L29) already carries $\theta^2$ in closed form for every partition, algebraically identical to $1/(4R)$, and already states the bound strictly |
| 12 | What would break it | **CONFIRMED** | the unordered reading of $t$ is the live falsifier and is excluded by two recorded values, one of them not cited by the block |

**One line.** L212's value is right and provable, $\theta=1/(2\sqrt R)$ at every partition, but three of its four links rest on premises it never states, its claim to have dropped $\lambda=\tfrac12$ is false, and the record already carried the same $\theta$ in closed form by a route with no Einstein hypothesis in it.

## 1. The normalisation, and what $t_F=2$ needs

**Step 3 needs $t_F=2$ for the vertex configuration's own frame, and what supplies it is per-frame coordinate-diagonality, which the block never states.** [conventions.md:142](../findings/conventions.md#L142) gives the operator form $t=2\lVert\operatorname{diag}W\rVert^2$ with the diagonal taken in the pair basis, so $t\le2\lVert W\rVert^2$ by Cauchy-Schwarz with equality exactly when $W$ has all its mass on the pair diagonal. The clause step 3 quotes is the other one, *$t=2$ iff $W$ is coordinate-diagonal in some frame*, which [conventions.md:144](../findings/conventions.md#L144) says in terms is about $\max_Ft_F$ and warns must not be substituted where a formula means $t_F$.

**What would have to be true of $W$ for $t_F=2$ in the frame the vertex solution is written in**: every component of $W$ other than the $W_{abab}$ must vanish in the block frame, and $\lVert W\rVert=1$. The first half is exactly coordinate-diagonality, the second is what step 3 is trying to arrange.

**It is true, and it is on the record in the file L212 cites for the vertex solution.** [ungraded-slack.md:45](../findings/ungraded-slack.md#L45) reads *"on this family the operator is diagonal in coordinate 2-planes with entries depending only on the blocks the indices fall in"*. It is also forced by [conventions.md:47](../findings/conventions.md#L47), where $\mathcal D_n$ is defined as *the vertex matrices of coordinate-diagonal Weyl operators*, so naming a sectional matrix names a coordinate-diagonal operator. And it is checkable from the geometry in three lines: for $\prod_aS^{n_a}(\kappa_a)$ the curvature operator is diagonal in coordinate $2$-planes, the scalar and trace-free Ricci parts are Kulkarni-Nomizu products of diagonal matrices and are diagonal too, so the Weyl part is diagonal.

**So this is a citation defect, not a hole**, and the repair is one sentence: *the configuration is the coordinate-diagonal Weyl operator with sectional matrix $K$, so $t_F=2\lVert W\rVert^2$ in this frame.* Without it step 3 is the substitution the record's own trap note forbids, and a reader who takes the extremal clause at face value has $t_F\le2$ and no equation.

## 2. Whether $t$ is a function of $K$ alone, and the factor of four

**There is no contradiction, and the discrepancy is a difference of representative rather than of basis.** $\lVert\operatorname{diag}W\rVert^2$ is the pair-basis diagonal, one entry per *unordered* pair, so $\lVert\operatorname{diag}W\rVert^2=\sum_{a<b}K_{ab}^2=t/2$, and $t=2\lVert\operatorname{diag}W\rVert^2$ is an identity rather than a convention. Step 2's configuration sits at $\theta_g=1$, where $t=8R$ and therefore $\lVert\operatorname{diag}W\rVert^2=4R$, and being coordinate-diagonal it also has $\lVert W\rVert^2=\lVert\operatorname{diag}W\rVert^2=4R$. The brief's $\lVert\operatorname{diag}W\rVert^2=4\lVert W\rVert^2$ comes from reading $\lVert W\rVert^2=R$ at that same configuration, and $R$ is the norm of a *different* representative, the one at $\theta_g=\tfrac12$.

**The record already noticed the four and explained it in the wrong currency.** [ATTEMPTS.md:6906](../ATTEMPTS.md#L6906) records *"gave exactly four times the record's multi-block norm identity $R$, which looked at first like the factor-of-two hazard"* and resolves it through $t\le2$, which is the correct resolution of the scale but leaves step 4's *"with $\lVert W\rVert^2=R$"* unreconciled. See item 7.

**Where the record fixes the normalisation**: [conventions.md:140-142](../findings/conventions.md#L140) for the ordered sum and the operator form, and [conventions.md:85](../findings/conventions.md#L85) for the $\tfrac12$ sitting at the $\Lambda^2$ level with plain Frobenius on the pair matrix, which is what makes $\sum_{a<b}K_{ab}^2$ the pair-diagonal mass.

## 3. Step 2's arithmetic, derived independently

**The term-by-term count is right.** Block $a$ contributes $n_a(n_a-1)$ ordered pairs at $\frac{(n-n_a)^2}{(n-1)^2(n_a-1)^2}$, giving $\frac{n_a(n-n_a)^2}{(n-1)^2(n_a-1)}$. The across-block ordered pairs number $n(n-1)-\sum_a n_a(n_a-1)=n^2-\sum_an_a^2$, each at $\frac1{(n-1)^2}$. Both match the display.

**And the total is $8R$ identically, at every $k$ and every partition.** Writing $m=n_a$ and using $\frac{m(n-m)^2}{m-1}=(n-m)^2+\frac{(n-1)^2}{m-1}-2(n-1)+(m-1)$, summing over the $k$ blocks and adding $n^2-\sum n_a^2$ gives

$$(n-1)^2t=(k-1)n^2-2kn+k+n+(n-1)^2\sum_a\tfrac1{n_a-1},$$

while $(n-1)^2\cdot8R=(k-1)(n-1)^2+(n-1)^2\sum_a\tfrac1{n_a-1}-(n-1)$, and the two non-sum parts agree as $(k-1)n^2-2kn+n+k$. **So step 2 is a proved identity rather than a screened one**, which is more than the record claims for it, [lean/INDEX.md:102](../lean/INDEX.md#L102) calling it the screened half.

**Screened as well, in exact rationals, at ten partitions**: $(3,3)$, $(2,3)$, $(2,2,3)$, $(5,7)$, $(6,6)$, $(2,10)$, $(2,3,4,5)$, $(2,2,2,2,2)$, $(4,7,9,2,3)$ and $(2,2,2,2,2,2,2)$, every one returning $t=8R$, zero row sums and $\lVert W\rVert^2=4R$. **Four of those are outside the $k\le4$ the record's symbolic verification covers**, including $(S^2)^5$ at $n=10$, which [graded-half.md:67](../findings/graded-half.md#L67) names as the smallest uncovered case of the norm identity. No factor of two anywhere.

## 4. Step 1's Ricci-flatness

**$\operatorname{Ric}$ of an algebraic Weyl tensor contracts one index pair, $\operatorname{Ric}(W)_{ik}=\sum_jW_{ijkj}$**, an $n\times n$ symmetric matrix, and its vanishing is what makes an algebraic curvature tensor a Weyl tensor. The rows of $K$ deliver the diagonal entries, $\operatorname{Ric}(W)_{ii}=\sum_jW_{ijij}=\sum_jK_{ij}$. **The off-diagonal entries $i\ne k$ read $\sum_jW_{ijkj}$, which are not sectional entries at all**, so in general the rows of $K$ are one contraction among several.

**On the coordinate-diagonal locus they exhaust it**, because every $W_{ijkj}$ with $i\ne k$ has three distinct indices and vanishes. So step 1 proves what it claims for this object, and it does so because the object is diagonal, which is the same unstated premise as item 1. The arithmetic is exact: $(n_a-1)\cdot\frac{\theta_g(n-n_a)}{(n-1)(n_a-1)}=\frac{\theta_g(n-n_a)}{n-1}$ against $(n-n_a)\cdot\frac{\theta_g}{n-1}$, cancelling for every partition with every $n_a\ge2$, verified at ten partitions including unequal blocks such as $(4,7,9,2,3)$.

**The sentence about where the Einstein hypothesis went is therefore true of the Ricci condition** and is not the whole story, see item 9. It is also not new, [r653:84](REVIEW_r653.md#L84) already reads *"is Ricci-flat for every $n_a\ge2$"* of the same formula.

## 5. What $\theta_g$ is, and the scaling claim

**Only one reading of "multiplier" makes step 3's scaling sentence true, and it is the $Q$-eigenvalue.** $Q$ is quadratic, so $Q(cW)=c^2Q(W)=c^2\theta_gW=(c\theta_g)(cW)$, and the eigenvalue scales by $c$ while $t$ scales by $c^2$. Under the other definition the record carries, $\theta=P(W)/\lVert W\rVert^3$, the quantity is scale-invariant and *does not scale by $c$ at all*, so a reader importing that reading gets a false sentence. The block writes "multiplier" in step 3 and "$\theta$" only at unit norm, which is the correct discipline, and it never says which object the multiplier is.

**At unit norm the two agree by definition**, [conventions.md:17](../findings/conventions.md#L17) and [conventions.md:151](../findings/conventions.md#L151) giving $Q(W)=\theta W$ as the first-order condition on $\{\lVert W\rVert=1\}$, so step 4's identification is licensed the moment criticality is available. The block is entitled to the scaling, and it is not entitled to leave the reading unnamed, this being the exact trap [conventions.md:62](../findings/conventions.md#L62) records for $Q(W_{p,q})=\frac{n-1}{pq}W_{p,q}$.

**And $\theta_g$ has a name the block does not give it: it is the Einstein constant.** For $\prod_aS^{n_a}(\kappa_a)$, Einstein forces $\kappa_a=\lambda/(n_a-1)$, and the Weyl part of an Einstein operator has $W_{ijij}=R_{ijij}-\frac{\lambda}{n-1}$, so within block $a$ it is $\lambda\frac{n-n_a}{(n_a-1)(n-1)}$ and across blocks $-\frac{\lambda}{n-1}$. **That is the vertex solution verbatim, with $\theta_g=\lambda$.** This is the fact item 9 turns on.

## 6. Whether the vertex solution is critical, and whether the argument needs it to be

**Criticality is needed.** Step 4 reads the multiplier at unit norm as $\theta$, and the record licenses that only at a critical point, [conventions.md:151](../findings/conventions.md#L151) adding that the bracket form $[W,Q(W)]=0$ is strictly weaker and holds at *every* diagonal Weyl tensor, so the weak form is worthless here. **The block never asserts it**, and calls the object "the vertex solution" without saying of what.

**It is available, and I proved it rather than assumed it.** For a coordinate-diagonal $W$ the pair-diagonal of $W^2$ is $K_{ab}^2$, and the pair-diagonal of $W^\#$ is $\sum_{e\ne a,b}K_{ae}K_{eb}=(M^2)_{ab}$ from the index formula with its $\tfrac12$ and $c_{acd}^2=1$ on a bracket triangle, which is [conventions.md:77](../findings/conventions.md#L77) and [conventions.md:51](../findings/conventions.md#L51)'s $\Phi(M)=M^{\circ2}+M^2$. Off-diagonal components of $W^\#$ vanish, because $c_{(ab)\gamma\delta}\ne0$ forces $\{\gamma,\delta\}=\{(ae),(eb)\}$ and no such pair serves two distinct pairs $(ab)\ne(cd)$, so $Q$ preserves coordinate-diagonality and criticality in $\mathcal W_n$ reduces to $\operatorname{hollow}(M^{\circ2}+M^2)=\theta_gM$. At $\theta_g=1$ that reduces, within block $a$, to $(n_a-1)u_a^2+(n-n_a)v^2=u_a$, which is

$$\frac{n-n_a}{(n-1)^2}\Big[\frac{n-n_a}{n_a-1}+1\Big]=\frac{n-n_a}{(n-1)^2}\cdot\frac{n-1}{n_a-1}=u_a,$$

and across blocks $a\ne b$ to $v^2+(n_a-1)u_av+(n_b-1)u_bv+(n-n_a-n_b)v^2=\frac{1-n}{(n-1)^2}=v$. **Both hold for every partition**, and the screen confirms the full $n\times n$ equation at all ten partitions.

**So the verdict is GAP rather than REFUTED**: the premise the argument needs is true at every member of the family, and no line of the block supplies it.

## 7. Whether the conclusion's $\lVert W\rVert^2=R$ is step 2's $W$

**It is not, and three distinct representatives are in play.** At $\theta_g=1$, which is step 2's, $\lVert W\rVert^2=4R$. At unit norm, which is step 4's, $\lVert W\rVert^2=1$ and the multiplier is $1/(2\sqrt R)$. The identity's $\lVert W\rVert^2=R$ holds at neither, it holds at $\theta_g=\tfrac12$, since norm and multiplier both scale by $c$ and $c=\tfrac12$ takes $4R$ to $R$.

**So step 4's display mixes scales.** *"$\theta=c=1/(2\sqrt R)=1/(2\lVert W\rVert)$, with $\lVert W\rVert^2=R$ the identity above"* is a $\theta$ read at unit norm equated to a norm read at the $\theta_g=\tfrac12$ representative. A reader who takes $\lVert W\rVert$ at the point where $\theta$ was computed gets $\theta=\tfrac12$ at every partition, which is false at all of them.

**What the proof actually establishes is $\theta=1/(2\sqrt R)$, and that is sound and is what consumers use.** [VERIFY_v148:74](../verification/VERIFY_v148.md#L74) and [graded-half.md:388](../findings/graded-half.md#L388) both consume the relation in the form $\theta^2=1/(4\lVert W\rVert^2)$ with $\lVert W\rVert^2$ the identity's value, so no consumer is damaged. The repair is to say which representative carries the norm, and the honest scale-explicit statement is $\lVert W\rVert^2=4R\theta_g^2$, from which $\theta=\theta_g/\lVert W\rVert=1/(2\sqrt R)$ at every $\theta_g$.

**An unclaimed upside sits here.** $t=8R$ at $\theta_g=1$ together with coordinate-diagonality *proves* $\lVert W\rVert^2=4R\theta_g^2$ at every $k$, which is the multi-block norm identity that [graded-half.md:67](../findings/graded-half.md#L67) records as owed above $k=4$ and that [LEDGER.md](../findings/LEDGER.md) carries as a debt. L212 discharges it and says so nowhere.

## 8. The bound's strictness

**Strict at every $k\ge2$.** Each block has $n_a<n$, so $n_a-1<n-1$ and $\frac1{n_a-1}>\frac1{n-1}$ strictly, and with $k\ge2$ terms against one subtraction the sum exceeds $\frac{k-1}{n-1}>0$. The block's display writes the per-block comparison as $\ge$ and then concludes strictly, which understates what it uses without breaking it. **A block at $n_a=2$ changes nothing**, giving $\frac1{n_a-1}=1$, the largest term available.

**At $k=1$ the conclusion is vacuous rather than false**, and for a stronger reason than the failure of strictness. There $n=n_1$, the sum telescopes to zero and $R=0$, but also both vertex entries vanish identically, the within-block numerator being $n-n_a=0$ and there being no across-block pairs, so the family at $k=1$ is $\{0\}$ and has no unit-norm member to carry a $\theta$. Both $1/(2\sqrt R)$ and $\sqrt{2/(k-1)}$ are undefined there, consistently. [theta_lt_bound](../lean/HamiltonsCubic/Results/L212VertexTheta.lean) guards this correctly with the hypothesis $1<k$.

**Informative from $k=3$.** At $k=2$ the bound reads $\theta<\sqrt2=1.41421$, which is weaker than the recorded $\sqrt{3/2}$ competitor and settles nothing, at $k=3$ it reads $\theta<1$, which is the statement the census wants.

## 9. The hypotheses actually dropped, inventoried

**What the new argument uses**, item by item: the vertex solution's form, imported from [ungraded-slack.md:47](../findings/ungraded-slack.md#L47) and [r653:84](REVIEW_r653.md#L84); its coordinate-diagonality in the block frame, unstated, item 1; its criticality in the strong sense $Q(W)=\theta_gW$, unstated, item 6; $t=\lVert K\rVert_F^2$ over ordered pairs with $t=2\lVert\operatorname{diag}W\rVert^2$ and the equality case of $t\le2$, from [conventions.md:140-142](../findings/conventions.md#L140); the quadratic homogeneity of $Q$; $\theta$'s definition at a critical point, from [conventions.md:17](../findings/conventions.md#L17); and, in step 4's display alone, the multi-block norm identity.

**Three of the four hypotheses genuinely go.** Local symmetry, Einstein and $\lambda\ne0$ are nowhere used as premises, the scale being fixed by $t$ instead, and the important consequence is that the chain no longer routes through a lemma whose scope is *irreducible* symmetric spaces while its objects are products. That was [ROUND_L05](../verification/ROUND_L05.md)'s F3 and [VERIFY_v159:54](../verification/VERIFY_v159.md#L54)'s finding, and on it L212 delivers.

**The fourth does not go, and the claim that it does is false.** By item 5, $\theta_g$ *is* the Einstein constant $\lambda$ of the product. By item 7, $\theta=1/(2\lVert W\rVert)$ holds exactly at the representative with $\lVert W\rVert^2=R$, which is the one at $\theta_g=\lambda=\tfrac12$. So *"not used: $\lambda=\tfrac12$"* misdescribes the situation: the relation $\theta=1/(2\lVert W\rVert)$ is equivalent to evaluating at $\lambda=\tfrac12$, and what L212 does is *derive* that normalisation for reducible products instead of importing it from the irreducible case, which is where [VERIFY_v159:102](../verification/VERIFY_v159.md#L102) located the defect. **That is a real repair and it is the opposite of dropping the hypothesis.** Stated positively, L212 shows the normalisation under which the identity is written is the one the vertex system produces.

**And the objects satisfy all four anyway**, being Weyl parts of Einstein products of round spheres, so nothing in the census's failures on the strongly-regular and $\mathfrak{su}(m)$ items is reached by this lemma either way. The gain is in the scope of the argument, not in the scope of the conclusion.

**The vertex solution's own derivation assumes none of the four.** [ungraded-slack.md:45](../findings/ungraded-slack.md#L45) reaches it by *"solving the vertex system by hand rather than through the sampling solver"*, which is the criticality equation on the diagonal locus, and [r653:60](REVIEW_r653.md#L60) checks its trace directly. **One presentational discrepancy**: both of those write the across-block entry as $+1$ with the within-block entries negative, which is the negative of L212's configuration, and only L212's sign is the geometric one and the one with $\theta>0$. No value moves, since both files consume moduli, and [ungraded-slack.md:312](../findings/ungraded-slack.md#L312) already records the sign flip.

## 10. Padding

**L212 asserts nothing at a padded configuration, and that is why its conclusion is safe.** Its hypothesis is a partition $n=\sum_an_a$ with every $n_a\ge2$, and a padded copy has blocks of size one, which the formula cannot even evaluate, the within-block denominator being $n_a-1=0$. So the padded configuration is not a member of the family at the ambient $n$, and $R$ is computed from the block sum, exactly as [graded-half.md:67](../findings/graded-half.md#L67) requires.

**The two forms of the conclusion behave differently under padding, and both survive.** $\theta=1/(2\sqrt R)$ survives because $R$ is read off the partition, which padding does not change. $\theta=1/(2\lVert W\rVert)$ survives because [L164](../findings/stratum-two-negative.md) preserves both $\theta$ and the norm. **No conflict with the identity's failure at a padded copy**, because that failure is the identity read at the *ambient* $n$, $27/64$ against $75/176$ for $(S^3)^3$ in $\mathbb R^{12}$, and neither form of L212's conclusion reads $R$ at the ambient $n$.

**Step 2 is the one step where the distinction bites**, since $t$ is padding-invariant while $8R$ is not if $n$ is read as ambient. The block states $n=\sum_an_a$ once, in the line introducing the vertex solution, and step 2's display repeats $n$ four times without repeating the qualification. Worth a clause, given that [ROUND_L05](../verification/ROUND_L05.md) already booked this same omission once in this same file.

## 11. Whether any of it is already on the record

**Most of it is, and the block credits none of it.**

- **Step 1 is verbatim prior.** [r653:84](REVIEW_r653.md#L84): *"The vertex solution $w_{ab}=-\theta/(n-1)$, $w_{aa}=\theta(n-n_a)/((n-1)(n_a-1))$ is Ricci-flat for every $n_a\ge2$"*. [r653:60](REVIEW_r653.md#L60) calls the trace computation *"the Ricci-flatness check"*.
- **The diagonality item 1 needs is prior**, [ungraded-slack.md:45](../findings/ungraded-slack.md#L45).
- **The value is prior, in closed form, for every partition.** [ungraded-slack.md:29](../findings/ungraded-slack.md#L29) carries $\theta^2=\frac{2(n-1)^2}{(k-1)n^2+\sum_a\frac{(n-n_a)^2}{n_a-1}}$, and its denominator is $(n-1)^2t$ at $\theta_g=1$ in a different grouping of the same sum, so that formula **is** $\theta^2=1/(4R)$. I checked the identification at $(3,3)$, where both give $10/9$, and at $(2,3,4,5)$, where both give $0.3994876$. **That block also already states the bound strictly**, *"$\theta^2<2/(k-1)$ strictly, so $k\ge3$ forces $\theta<1$ for every partition and every $n$"*, by a route that mentions neither $\lVert W\rVert$ nor Einstein nor [L46](../findings/problem.md).
- **The repair route is prior as a named plan.** [ROUND_L05](../verification/ROUND_L05.md)'s F3 reads *"The conclusion is repairable from the vertex solution plus $t=2$ with no Einstein hypothesis at all"*, which is L212's abstract in one clause.
- **The norm-to-$\theta$ relation itself is prior as [L46](../findings/problem.md)**, consumed at [graded-half.md:388](../findings/graded-half.md#L388), [VERIFY_v148:74](../verification/VERIFY_v148.md#L74) and [VERIFY_v146:55](../verification/VERIFY_v146.md#L55), each time with the hypotheses attached.

**What is genuinely new**: step 2's closed form for $t$ as $8R$, which is the bridge between the vertex system and the norm identity, and with it the retirement of [L46](../findings/problem.md) from [L05](../findings/graded-half.md)'s chain and the discharge of the norm identity's $k\ge5$ debt noted in item 7. **That is worth a numbered result.** What it is not is a new value, a new bound, or the first observation that the vertex solution is Ricci-flat, and the block presents all three as its own.

## 12. What would break it, and what I did to look

**Named falsifiers, in the order I would bet on them.**

1. **The unordered reading of $t$**, cap $1$ rather than $2$. It is the live hazard, since $8Rc^2=1$ gives $c=1/(2\sqrt{2R})$ and moves every $\theta$ by $\sqrt2$, and [conventions.md:142](../findings/conventions.md#L142) records that the ambiguity was real in this very cell. **Excluded by anchors L212 was not fitted to**: the ordered reading returns $\theta=\sqrt{55}/6=1.2360331$ at $(6,6)$, which is $\theta_0(12)$, and $\theta^2=264/175$ at $(5,7)$, which is the value [graded-half.md:61](../findings/graded-half.md#L61) carries from two independent exact-rational routes. The unordered reading returns both divided by $\sqrt2$ and contradicts them. **The $(5,7)$ anchor is not among the four the block's Gate 1 cites**, so it is an independent check.
2. **A member of the family not coordinate-diagonal in the block frame.** It would leave only $\lVert W\rVert^2\ge4R\theta_g^2$, hence $\theta\le1/(2\sqrt R)$, so the *bound* would survive and the *equality* would not. Excluded by the geometric computation in item 1 and by the exact match of the sectional matrix to the Einstein product's Weyl part in item 5.
3. **A partition where $t\ne8R$.** Excluded by the general proof in item 3, so no partition can be it.
4. **A partition where the vertex solution fails criticality.** Excluded by the general proof in item 6.
5. **A padded configuration, or a block at $n_a=1$.** Excluded by hypothesis, item 10.

**What I did to look.** Derived steps 1 and 2 and the criticality equation in general by hand before running anything; screened all three plus $\lVert W\rVert^2=4R$ in exact rationals at ten partitions chosen to include unequal blocks, $n_a=2$ blocks, and $k=5$ and $k=7$, which are outside the record's symbolic coverage; and cross-checked $\theta$ against four recorded values, $\theta_0(6)=\sqrt{10}/3$, $\theta_0(12)=\sqrt{55}/6$, $S^2\times S^{10}$ at $0.994987437$ and $S^5\times S^7$ at $\sqrt{264/175}$, all four reproduced exactly. Nothing falsifying was found.

## The Lean declarations, and what type-checks

**What type-checks is strictly weaker than the claim, and one of the three declarations is a duplicate.**

- **[theta_eq_inv_two_norm](../lean/HamiltonsCubic/Results/L212VertexTheta.lean) is [scale_of_t_eq_two](../lean/HamiltonsCubic/Results/L212VertexTheta.lean) under another name.** Same binders, same hypotheses $0<R$, $0<c$, $8Rc^2=2$, same conclusion $c=1/(2\sqrt R)$, and its proof is the single term `scale_of_t_eq_two hR hc ht`. It is a definitional alias, and calling it *"THE LEMMA'S ARITHMETIC CORE"* and *"the lemma's own conclusion $\theta=1/(2\lVert W\rVert)$"* in [lean/INDEX.md:102](../lean/INDEX.md#L102) overstates it by a whole statement.
- **$\lVert W\rVert=\sqrt R$ enters as no hypothesis anywhere.** It appears only in the docstring, *"With $\lVert W\rVert=\sqrt R$"*. No declaration in the file mentions $W$, $\theta$, $t$, a sectional matrix or a partition. The three statements are inequalities and equations among two real variables.
- **[theta_lt_bound](../lean/HamiltonsCubic/Results/L212VertexTheta.lean) is real content of the right kind**, $1/(2\sqrt R)<\sqrt{2/(k-1)}$ from $1<k$ and $(k-1)/8<R$, and its $1<k$ guard is exactly the $k=1$ exclusion item 8 asks for.
- **So the layer types the algebra of step 3 and the bound, and types no part of the lemma.** The file's own scope note says as much for steps 1 and 2 and then claims *"that is what `theta_eq_inv_two_norm` states and proves"* of the conclusion $\theta=1/(2\lVert W\rVert)$, which it does not state. Given item 3, the better use of the layer would be to type step 2's identity, which is provable in general rather than screened, over a `Finset` of block sizes and no sectional matrix at all.

## Verdict for L212 as a whole

**GAP.** The conclusion $\theta=1/(2\sqrt R)$ is true at every partition with every $n_a\ge2$, I proved both of its unproved halves in general rather than screening them, and it reproduces four recorded values exactly. **The derivation as written establishes it at three links short**: per-frame coordinate-diagonality, without which step 3's $t=2$ is the extremal substitution the record forbids; criticality, without which step 4 may not read a multiplier as $\theta$; and the representative behind $\lVert W\rVert^2=R$, which is neither of the two the proof uses. Each is one cited sentence. **One claim is refuted**, that $\lambda=\tfrac12$ is not used, since $\theta_g$ is the Einstein constant and the conclusion is that normalisation rather than a statement independent of it. **And the novelty claim needs trimming**, the value and the strict bound being already on the record in closed form at [ungraded-slack.md:29](../findings/ungraded-slack.md#L29) and the Ricci-flatness at [r653:84](REVIEW_r653.md#L84), with step 2's $t=8R$ and the retirement of [L46](../findings/problem.md) the parts that are this lemma's own.
