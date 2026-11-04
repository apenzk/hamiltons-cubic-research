# VERIFY_v183, L28, cold verification

Verifier v183. The brief was read cold. **No numerical work was done**: no script, no Sage, no Python, no numeric evaluation. All arithmetic below is exact and by hand, in closed form. Log: [agent_logs/verify-L28-v183.log](../agent_logs/verify-L28-v183.log).

## Claim table

*Each row was written the moment its section was settled. Verdict at the foot.*

| # | claim | verdict |
|---|---|---|
| 1 | Ten complex summands, seven real classes, three conjugate pairs | **CONFIRMED** |
| 2 | Multiplicity-freeness (import from Howe–Tan–Willenbring) | **CONFIRMED at $m=3$ by a dimension count; IMPORT for $m\ge4$** |
| 3 | The seven real dimensions sum to $\dim\mathcal W_{2m}$ identically in $m$ | **CONFIRMED, exact polynomial identity** |
| 4 | The seven individual dimensions | **CONFIRMED, Weyl dimension formula, each checked** |
| 5 | $\lambda_S=1-\frac{c_S+q_S^2}{4(m+1)}$ reproduces all seven $L_e$ values | **CONFIRMED** |
| 6 | Every row's charge $c_S+q_S^2$ | **CONFIRMED, all seven recomputed from the weights** |
| 7 | $\lambda_S=\tfrac12\iff c_S+q_S^2=2(m+1)$, met only by $4(m-1)$ at $m=3$ | **CONFIRMED** |
| 8 | The $m=3$ absence, on its own terms | **CONFIRMED, and the continuation disclaimer is correct** |
| 9 | $\mathop{\mathrm{tr}}L_e=0$ | **CONFIRMED, exact** |
| 10 | $\mathop{\mathrm{tr}}(L_e^2)=\frac{3m(m-1)(4m-1)}{4(m+1)}=\kappa_F(2m)\lVert e\rVert^2$ | **CONFIRMED, exact, both sides** |
| 11 | Fox's Theorem 1.3 as an import: hypotheses checked at source | **HYPOTHESES SATISFIED, and the unital trap is inverted; but $\kappa_F$'s closed form is not Fox's: HYPOTHESIS-DEBT** |
| 12 | Second route: $\mathop{\mathrm{tr}}L_e=0$ recovers each class uniquely | **CONFIRMED for four of five; FAILS AT $m=3$ FOR ONE ROW, harmlessly** |
| 13 | Closed form for $e$; $\mathop{\mathrm{tr}}e=0$; $\lVert e\rVert^2=1/\theta^2$ | **CONFIRMED, exact, and it re-derives $\theta^2$** |
| 14 | Slack against L70, exactly $2(m-2)\theta$, vanishing only at $m=2$ | **CONFIRMED, exact, by three independent routes** |
| 15 | Landscape line "Only $\tfrac2{m+1}$ reaches $\tfrac12$" vs the table's orbit row | **INCONSISTENT AS WRITTEN, confirmed discrepancy, §12** |
| 16 | The duplicate table at second-order.md | **THE TABLES AGREE ROW FOR ROW; one gloss beside it is a confirmed defect, §13a** |
| 17 | The traps, each by name | **answered in §14, three unstated hypotheses and four live symbol collisions found** |

## 0. Conventions, fixed once

Quoted from [findings/conventions.md](../findings/conventions.md):

> | $\mathcal W_n$ | the space of algebraic Weyl curvature operators on $\mathbb R^n$ |
> | $\dim\mathcal W_n$ | $\frac{n(n-3)(n+1)(n+2)}{12}$, $10$ at $n=4$, $84$ at $n=6$, $1638$ at $n=12$ |
> | $Q(W)$ | Hamilton's quadratic map $W^2+W^\#$, sending $\mathcal W_n$ to itself |
> | $P(W)$ | the cubic form $\langle W,Q(W)\rangle$ |
> | $\theta$ | $P(W)/\lVert W\rVert^3$; at a critical point, $Q(W)=\theta W$ |

Quoted from [findings/second-order.md](../findings/second-order.md), the charge convention this round turns on:

> $$\lambda_S=1-\frac{c_S+q_S^2}{4(m+1)},\qquad c_S=\sum_i\nu_i(\nu_i+m+1-2i),\quad q_S=\sum_i\nu_i,$$
> with $\nu$ the summand's highest weight as a $GL(m)$ weight.

The block's own $\dim\mathcal W_{2m}=\frac{m(m+1)(2m+1)(2m-3)}3$ is the conventions entry at $n=2m$:
$$\frac{2m(2m-3)(2m+1)(2m+2)}{12}=\frac{4m(m+1)(2m+1)(2m-3)}{12}=\frac{m(m+1)(2m+1)(2m-3)}3 .$$
So the block restates rather than contradicts the convention. **CONFIRMED.**

## Hypothesis inventory

Every hypothesis the block uses, whether or not it states it.

| # | hypothesis | stated in the block? | used? | status |
|---|---|---|---|---|
| H1 | $m\ge3$ | yes | yes, $m=2$ is a genuine exception ($\lambda_{\max}=\tfrac12$, not $\tfrac23$) | discharged; boundary $m=3$ checked in §7 |
| H2 | $n=2m$ is the **native** dimension; no padding | no | yes, padding manufactures excess elsewhere | **stated nowhere in the block**; recorded at [second-order.md](../findings/second-order.md) line 205. See §14, trap 1 |
| H3 | $W$ is critical: $Q(W)=\theta W$, so $L_ee=e$ | implicitly, via "critical $W_{\mathbb{CP}^m}$" | yes, gives the $\lambda=1$ row | discharged by the closed form (§10) |
| H4 | $\lVert W\rVert=1$, so $\lVert e\rVert^2=\theta^{-2}$ | no | yes, in the Fox check (§9) | discharged: the closed form for $e$ yields $\lVert e\rVert^2=\theta^{-2}$ independently (§10) |
| H5 | $e$ is $U(m)$-invariant, so $L_e$ is $U(m)$-equivariant | yes | yes, Schur | discharged by the closed form: $e$ is a combination of $U(m)$-isotypic projectors |
| H6 | $\mathrm{Weyl}_{2m}\otimes\mathbb C$ is $U(m)$-multiplicity-free | yes | yes, Schur gives a **scalar**, not a block | import (§2); proved outright at $m=3$ |
| H7 | Fox's Theorem 1.3 applies to $(\mathcal W_n,\#)$ | yes, by citation | yes, the whole "two identities check the list" paragraph | §9 |
| H8 | $\ell(\lambda)+\ell(\mu)\le m$ for the mixed tensor $V_{\lambda;\mu}$ to be nonzero | as "four rows against the $m=3$ available" | yes, the entire $m=3$ absence | §8: correct, but the block never names the criterion |
| H9 | The orbit is the $\Lambda^2E\oplus\Lambda^2\bar E$ summand and nothing more | asserted | yes, $\dim E(\tfrac12)=\dim(\text{orbit})$ | §6: dimension agreement $m(m-1)$ is checked; the *identification* is asserted, see §14 trap 5 |

## 1. The decomposition: ten, seven, three

Seven real classes with three of them conjugate pairs give $3\cdot2+4\cdot1=10$ complex summands. The table marks exactly three rows "$\oplus$ dual" ($(1,1,0^{m-2})$, $(2,1,0^{m-3},-1)$, $(2,2,0^{m-2})$) and the remaining four are self-dual as $GL(m)$ weights, the dual of $\nu$ being $(-\nu_m,\dots,-\nu_1)$:

- $(0^m)\mapsto(0^m)$; $(1,0^{m-2},-1)\mapsto(1,0^{m-2},-1)$; $(1,1,0^{m-4},-1,-1)\mapsto(1,1,0^{m-4},-1,-1)$; $(2,0^{m-2},-2)\mapsto(2,0^{m-2},-2)$. Self-dual, four of them.
- $(1,1,0^{m-2})\mapsto(0^{m-2},-1,-1)$; $(2,1,0^{m-3},-1)\mapsto(1,0^{m-3},-1,-2)$; $(2,2,0^{m-2})\mapsto(0^{m-2},-2,-2)$. Not self-dual, three of them.

$4+2\cdot3=10$. **The count is internally consistent and CONFIRMED.** At $m=3$ the fourth row is absent, leaving $9$ complex summands, which is exactly what [second-order.md](../findings/second-order.md) records ("ten summands, nine at $m=3$").

## 2. Multiplicity-freeness

This is an **import**, cited at [second-order.md](../findings/second-order.md) as [Howe–Tan–Willenbring §2.3.1](https://arxiv.org/abs/math/0311159), $GL_n\subset O_{2n}$ branching at $\lambda=(2,2)$, "all multiplicity one for $m\ge4$".

**The citation as recorded covers $m\ge4$ and not $m=3$**, and $m=3$ is the smallest admissible dimension and the one the whole $E(\tfrac12)$ argument turns on. That gap closes on the record's own numbers, without appeal to the source:

At $m=3$ the six surviving classes have real dimensions $1$, $8$, $6$, $\frac{2\cdot9\cdot5}3=30$, $\frac{9\cdot2\cdot6}4=27$, $\frac{9\cdot8}6=12$, summing to
$$1+8+6+30+27+12=84=\dim\mathcal W_6 .$$
Six pairwise-inequivalent $U(3)$-classes, each occurring at least once, whose dimensions already exhaust $\mathcal W_6$, leave no room for a second copy of anything. **So multiplicity-freeness at $m=3$ is a consequence of the dimension count and needs no citation. CONFIRMED at $m=3$; for $m\ge4$ it remains an import (hypotheses in §9's sense are not at issue here, this is a branching computation, not a structure theorem).**

## 3. The dimension sum, as a polynomial identity

Over the common denominator $12$:

| row | $12\times$ dimension |
|---|---|
| $(0^m)$ | $12$ |
| $\mathfrak{su}(m)$ | $12m^2-12$ |
| orbit | $12m^2-12m$ |
| $(1,1,0^{m-4},-1,-1)$ | $3m^2(m+1)(m-3)=3m^4-6m^3-9m^2$ |
| $(2,1,\dots,-1)$ | $8m^2(m^2-4)=8m^4-32m^2$ |
| $(2,0^{m-2},-2)$ | $3m^2(m-1)(m+3)=3m^4+6m^3-9m^2$ |
| $(2,2,0^{m-2})$ | $2m^2(m^2-1)=2m^4-2m^2$ |

Collecting: $m^4$: $3+8+3+2=16$. $m^3$: $-6+6=0$. $m^2$: $12+12-9-32-9-2=-28$. $m^1$: $-12$. $m^0$: $12-12=0$.
$$\textstyle\sum=\frac{16m^4-28m^2-12m}{12}=\frac{4m(4m^3-7m-3)}{12}=\frac{m(4m^3-7m-3)}3 .$$
And $(m+1)(2m+1)(2m-3)=(2m^2+3m+1)(2m-3)=4m^3-7m-3$. So the sum is $\frac{m(m+1)(2m+1)(2m-3)}3=\dim\mathcal W_{2m}$, **identically in $m$. CONFIRMED, an exact polynomial identity, not a spot check.**

*Note the identity holds at $m=3$ only because the fourth row's polynomial vanishes there, which is the same fact §8 discusses, seen from the other side. The identity is therefore consistent with the absence rather than blind to it.*

## 4. The seven dimensions, each independently

By Weyl's formula $\dim=\prod_{i<j}\frac{\ell_i-\ell_j}{j-i}$ with $\ell_i=\nu_i+m-i$, and by the hook-content formula where the weight is a partition.

- $(0^m)$: $1$. $(1,0^{m-2},-1)$: the $\mathfrak{gl}(m)$ adjoint minus the centre, $m^2-1$.
- $(1,1,0^{m-2})=\Lambda^2E$: $\binom m2$; with its dual, real dimension $m(m-1)$. **matches.**
- $(2,2,0^{m-2})=S_{(2,2)}E$: hook contents $(0,1;-1,0)$, hooks $(3,2;2,1)$, so $\frac{m(m+1)(m-1)m}{12}=\frac{m^2(m^2-1)}{12}$; with its dual, $\frac{m^2(m^2-1)}6$. **matches.**
- $(1,1,0^{m-4},-1,-1)$, listed $\frac{m^2(m+1)(m-3)}4$. $m=4$: $\ell=(4,3,0,-1)$, numerator $1\cdot4\cdot5\cdot3\cdot4\cdot1=240$, denominator $1!2!3!=12$, $\dim=20=\frac{16\cdot5\cdot1}4$. $m=5$: $\ell=(5,4,2,0,-1)$, numerator $21600$, denominator $288$, $\dim=75=\frac{25\cdot6\cdot2}4$. $m=6$: $\ell=(6,5,3,2,0,-1)$, numerator $6531840$, denominator $34560$, $\dim=189=\frac{36\cdot7\cdot3}4$. **matches at three points.**
- $(2,1,0^{m-3},-1)$, listed complex $\frac{m^2(m^2-4)}3$ per copy. $m=3$: $\ell=(4,2,-1)$, $\frac{2\cdot5\cdot3}{2}=15=\frac{9\cdot5}3$. $m=4$: $\ell=(5,3,1,-1)$, $\frac{2\cdot4\cdot6\cdot2\cdot4\cdot2}{12}=64=\frac{16\cdot12}3$. **matches.**
- $(2,0^{m-2},-2)$, listed $\frac{m^2(m-1)(m+3)}4$. $m=3$: $\ell=(4,1,-2)$, $\frac{3\cdot6\cdot3}2=27=\frac{9\cdot2\cdot6}4$. $m=4$: $\ell=(5,2,1,-2)$, $\frac{3\cdot4\cdot7\cdot1\cdot4\cdot3}{12}=84=\frac{16\cdot3\cdot7}4$. **matches.**

**CONFIRMED.** Each individual dimension is checked, and §3's exact polynomial identity then constrains the whole set.

## 5–6. The eigenvalue formula and every row's charge

**The brief flags this column as the one that once carried an arithmetic error, so each of the seven is recomputed from the weight, not read off the record.** With $c_S=\sum_i\nu_i(\nu_i+m+1-2i)$ and $q_S=\sum_i\nu_i$:

| $\nu$ | $q_S$ | $c_S$, term by term | $c_S$ | $c_S+q_S^2$ | table |
|---|---|---|---|---|---|
| $(0^m)$ | $0$ |, | $0$ | $0$ | $0$ ✓ |
| $(1,0^{m-2},-1)$ | $0$ | $1\cdot m$; $(-1)(-1+1-m)=m$ | $2m$ | $2m$ | $2m$ ✓ |
| $(1,1,0^{m-2})$ | $2$ | $1\cdot m$; $1\cdot(m-2)$ | $2m-2$ | $2m+2$ | $2(m+1)$ ✓ |
| $(1,1,0^{m-4},-1,-1)$ | $0$ | $m$; $m-2$; $(-1)(-1+3-m)=m-2$; $(-1)(-1+1-m)=m$ | $4m-4$ | $4m-4$ | $4(m-1)$ ✓ |
| $(2,1,0^{m-3},-1)$ | $2$ | $2(2+m-1)=2m+2$; $1\cdot(m-2)$; $(-1)(-m)=m$ | $4m$ | $4m+4$ | $4(m+1)$ ✓ |
| $(2,0^{m-2},-2)$ | $0$ | $2(m+1)$; $(-2)(-2+1-m)=2(m+1)$ | $4m+4$ | $4m+4$ | $4(m+1)$ ✓ |
| $(2,2,0^{m-2})$ | $4$ | $2(m+1)$; $2(2+m-3)=2(m-1)$ | $4m$ | $4m+16$ | $4(m+4)$ ✓ |

The two index positions that are easy to get wrong are $i=m-1$ and $i=m$ in row four, where $m+1-2i$ is $3-m$ and $1-m$; both are carried above explicitly. **All seven charges are correct. The repaired column survives its own re-derivation.**

Feeding these into $\lambda_S=1-\frac{c_S+q_S^2}{4(m+1)}$:
$$1,\quad 1-\tfrac{m}{2(m+1)}=\tfrac{m+2}{2(m+1)},\quad \tfrac12,\quad 1-\tfrac{m-1}{m+1}=\tfrac2{m+1},\quad 0,\quad 0,\quad 1-\tfrac{m+4}{m+1}=-\tfrac3{m+1}.$$
**Every one reproduces the $L_e$ column. CONFIRMED.**

## 7. $\lambda_S=\tfrac12$ and which charges can meet $2(m+1)$

$\lambda_S=\tfrac12\iff\frac{c_S+q_S^2}{4(m+1)}=\tfrac12\iff c_S+q_S^2=2(m+1)$, immediate from the formula, valid because $m+1\ne0$. Testing the seven charges against $2m+2$:

$0=2m+2$ needs $m=-1$; $2m=2m+2$ never; $2(m+1)$ identically; $4m-4=2m+2$ iff $m=3$; $4m+4=2m+2$ needs $m=-1$; $4m+16=2m+2$ needs $m=-7$.

**So exactly two rows can reach $\tfrac12$: the orbit, identically, and $(1,1,0^{m-4},-1,-1)$, at $m=3$ alone. CONFIRMED.** The claim is a statement over integers $m\ge3$ and each solved value ($-1$, $-7$) is outside that range, so the argument has no boundary case it misses.

## 8. The $m=3$ absence, on its own terms

The block gives two things and is careful to say which is the reason.

**The reason.** "It needs four rows of a Young diagram against the $m=3$ available." The summand is the mixed tensor $V_{(1,1);(1,1)}$, and a mixed tensor $V_{\lambda;\mu}$ of $GL(m)$ is nonzero exactly when $\ell(\lambda)+\ell(\mu)\le m$. Here $\ell(1,1)+\ell(1,1)=2+2=4$, so the summand exists iff $m\ge4$. **This is correct.** The same thing is visible in the weight itself: $(1,1,0^{m-4},-1,-1)$ requires positions $1,2$ and $m-1,m$ to be disjoint, i.e. $2<m-1$, i.e. $m\ge4$; at $m=3$ the pattern has no well-defined instantiation. **CONFIRMED.**

*What the block does not do is name the criterion.* It says "four rows of a Young diagram", which is $\ell(\lambda)+\ell(\mu)$ under a name it does not use; a reader who reads "four rows" as "$\ell$ of a single partition" will look at $\nu+(1^m)=(2,2,1^{m-4},0,0)$, count $m-2$ rows, and find no obstruction at all. **Recorded as an under-citation, not a defect**, the mathematics is right and the statement is true as written.

**The disclaimer.** "$\frac{m^2(m+1)(m-3)}4$ vanishing there is the analytic continuation agreeing with the absence rather than the reason for it." **This is exactly right and is the block at its best.** The dimension polynomial is derived under $m\ge4$ (§4 checks it at $m=4,5,6$); its value at $m=3$ is an extrapolation, and an extrapolation agreeing with a fact is corroboration, not proof. Had the polynomial been, say, $\frac{m^2(m+1)(m-3)}4+1$ (a function agreeing at $m\ge4$ with a different value at $m=3$), nothing about the absence would change. The block declines to lean on the coincidence, and separately §3 shows the coincidence is *needed* for the dimension sum to hold at $m=3$, so it is doing real work as a consistency check while correctly not doing any as an argument. **CONFIRMED on its own terms.**

## 9. Both Fox identities, and the import's hypotheses

### 9a. $\mathop{\mathrm{tr}}L_e=0$

$\sum_S(\dim S)\lambda_S$, row by row: $1\cdot1=1$; $(m^2-1)\frac{m+2}{2(m+1)}=\frac{(m-1)(m+2)}2=\frac{m^2+m-2}2$; $m(m-1)\cdot\frac12=\frac{m^2-m}2$; $\frac{m^2(m+1)(m-3)}4\cdot\frac2{m+1}=\frac{m^2(m-3)}2$; $0$; $0$; $\frac{m^2(m^2-1)}6\cdot\left(-\frac3{m+1}\right)=-\frac{m^2(m-1)}2$.

Sum $=1+\frac{(m^2+m-2)+(m^2-m)+m^2(m-3)-m^2(m-1)}2=1+\frac{2m^2-2+m^3-3m^2-m^3+m^2}2=1+\frac{-2}2=0.$

**Exactly zero, identically in $m$. CONFIRMED.**

### 9b. $\mathop{\mathrm{tr}}(L_e^2)$

$\sum_S(\dim S)\lambda_S^2$, over the common denominator $4(m+1)$:

| row | contribution | $\times4(m+1)$ |
|---|---|---|
| $(0^m)$ | $1$ | $4m+4$ |
| $\mathfrak{su}(m)$ | $\frac{(m-1)(m+2)^2}{4(m+1)}$ | $(m-1)(m^2+4m+4)=m^3+3m^2-4$ |
| orbit | $\frac{m(m-1)}4$ | $m(m-1)(m+1)=m^3-m$ |
| $(1,1,\dots,-1,-1)$ | $\frac{m^2(m-3)}{m+1}$ | $4m^3-12m^2$ |
| $(2,2,0^{m-2})$ | $\frac{3m^2(m-1)}{2(m+1)}$ | $6m^3-6m^2$ |

Numerator $=12m^3-15m^2+3m=3m(4m^2-5m+1)=3m(4m-1)(m-1)$, so
$$\mathop{\mathrm{tr}}(L_e^2)=\frac{3m(m-1)(4m-1)}{4(m+1)} .$$
**Matches the block exactly. CONFIRMED.**

And the right-hand side: $\kappa_F(2m)=\frac{(4m-1)(2m-1)}4$, $\lVert e\rVert^2=\theta^{-2}=\frac{3m(m-1)}{(m+1)(2m-1)}$, so
$$\kappa_F(2m)\lVert e\rVert^2=\frac{(4m-1)(2m-1)}4\cdot\frac{3m(m-1)}{(m+1)(2m-1)}=\frac{3m(m-1)(4m-1)}{4(m+1)},$$
the $(2m-1)$ cancelling. **The two sides agree identically in $m$. CONFIRMED.**

*How much of a check is this?* Genuine but not independent of everything. Both identities are linear/quadratic functionals of the seven $(\dim,\lambda)$ pairs, so they test the pairs jointly; a single $\lambda$ wrong by a rational function of $m$ fails both, as the block claims. But §9a is used *twice over* (as a check here and as the derivation in §10) and a quantity cannot be both the derivation of a value and an independent check on it. The block is aware of this and says so ("the trace identity derives the row the conclusion rests on"), so the honest count is: **one independent identity ($\mathop{\mathrm{tr}}L_e^2$) plus one derivation ($\mathop{\mathrm{tr}}L_e$)**, not two independent checks. The block's opening sentence "Two identities check the whole list" overstates by one; its own later paragraph corrects it.

### 9c. Fox's Theorem 1.3: the import's hypotheses, checked at source

**This is the trap the brief names, and it is the one place this round does not close.** See §14, trap 6.

*Answered here rather than deferred.* **The brief warns that "one route here died because a cited theorem assumes a *unital* algebra and $\mathcal W_n$ has no unit, and Fox's theorem is exactly such an import". It is not, and the source settles it in the opposite direction.**

From [fox-1901.04012.txt](https://arxiv.org/abs/1901.04012), lines 151–162, verbatim:

> A commutative algebra $(A,\circ)$ is *exact* (called *harmonic* in [29]) if its multiplication endomorphisms $L_\circ$ satisfy $\mathop{\mathrm{tr}}L_\circ(x)=0$ for all $x\in A$. **Note that an exact algebra is nonunital.** […]
> **Theorem 1.3.** Let $(V,h)$ be a Euclidean vector space of dimension at least $4$. The algebra $(\mathrm{MC}_W(V^*),*)$ is exact and Killing metrized. Moreover: (1) The Killing form $\tau_*(X,Y)=\mathop{\mathrm{tr}}L_*(X)L_*(Y)$ is a nonzero multiple of $\langle\cdot,\cdot\rangle$. (2) If $\dim V>4$, then $(\mathrm{MC}_W(V^*),*)$ is simple.

Three things follow, and each disarms a different form of the trap.

1. **Theorem 1.3 is not a general theorem being imported onto an object; it is a theorem *about this object*.** Its subject is $(\mathrm{MC}_W(V^*),*)$ by name. There is nothing to check beyond the identification of the record's algebra with Fox's, and one hypothesis: $\dim V\ge4$. Here $\dim V=2m\ge6$. **Discharged.**
2. **Unitality is a *conclusion*, not a hypothesis, and it goes the record's way.** Fox proves the algebra exact, and his own sentence says an exact algebra is nonunital. So Theorem 1.3 does not merely survive $\mathcal W_n$'s lack of a unit, it proves it. This is the exact opposite of [Tkachev's Theorem 1.2](../references/tkachev-2019-clifford-extremal/README.md), whose "**unital** Euclidean metrised algebra" hypothesis the record correctly records as barring that route ([fence-posts.md](../findings/fence-posts.md)). **The two imports are not the same kind of import, and the record does not confuse them.**
3. **The identification $X*Y=-F_X(Y)$ carries a sign, and both identities are blind to it.** [algebra.md](../findings/algebra.md) records the identification as verified numerically at residual $2\times10^{-16}$, "the sign being his curvature convention". $\mathop{\mathrm{tr}}L_e=0$ is unchanged under $L\mapsto-L$, and $\mathop{\mathrm{tr}}(L_e^2)$ is unchanged under $L\mapsto-L$. **So the one soft joint in the identification is inert for exactly the two facts L28 uses.** The normalisation is likewise reconciled: Fox's metric is $4\times$ Frobenius, and at $n=4$ his $\kappa=21/16$ is the record's $\kappa_F(4)=\frac{7\cdot3}4=\frac{21}4$ divided by $4$. **The anchor checks.**

### 9d. What the second identity does **not** establish, the one real debt

**Fox does not give $\kappa$ for $\dim V>4$, and says so.** Remark 1.4, verbatim:

> When $\dim V>4$, Theorem 1.3 does not give the value of the positive constant $\kappa$ such that $\tau_*=\kappa h\langle\cdot,\cdot\rangle$.

So $\kappa_F(n)=\frac{(2n-1)(n-1)}4$ is **the record's own closed form, not Fox's**, obtained as a fit anchored at $n=4$ and corroborated numerically ([algebra.md](../findings/algebra.md): "roughly 90 points", "This is a number Fox does not have"). The L28 block writes "Fox's Theorem 1.3 […] gives $\mathop{\mathrm{tr}}L(x)=0$ and $\mathop{\mathrm{tr}}(L(x)L(y))=\kappa_F\langle x,y\rangle$ with $\kappa_F(n)=\frac{(2n-1)(n-1)}4$", which **attributes the closed form to Fox**. [algebra.md](../findings/algebra.md) is scrupulous about this; the L28 block, read alone, is not.

**And this changes the direction of the inference.** What Theorem 1.3 supplies is that $\mathop{\mathrm{tr}}(L_x^2)/\lVert x\rVert^2$ is a constant $\kappa(n)$ *depending on $n$ alone*. L28's own table then **computes** that constant at $n=2m$:
$$\kappa(2m)=\frac{\mathop{\mathrm{tr}}(L_e^2)}{\lVert e\rVert^2}=\frac{3m(m-1)(4m-1)}{4(m+1)}\cdot\frac{(m+1)(2m-1)}{3m(m-1)}=\frac{(4m-1)(2m-1)}4=\frac{(2n-1)(n-1)}4 .$$
That the answer is a function of $m$ alone is automatic and carries **no information about the table**. The identity acquires content only against a *second* point at the same $n$, and the record has one, at [algebra.md](../findings/algebra.md): the balanced sphere product at $n=8$ returning $\kappa_F(8)=26.25=\frac{15\cdot7}4$. **That comparison is a real check, and it is numerical and at one dimension.**

**So the honest accounting of "two identities check the whole list":**

| | what it is |
|---|---|
| $\mathop{\mathrm{tr}}L_e=0$ | **a genuine constraint on the list, and the block itself uses it as the *derivation* of the $\mathfrak{su}(m)$ row.** A quantity cannot be both the derivation of a value and an independent check on it. |
| $\mathop{\mathrm{tr}}(L_e^2)=\kappa_F(2m)\lVert e\rVert^2$ | **a derivation of $\kappa_F$ at even $n$ from the table, not a check of the table by $\kappa_F$**, unless $\kappa_F(2m)$ is known from a different point at the same $n$, which the record has numerically at $n=8$ alone. |

**Verdict on the import: the hypotheses of Fox's Theorem 1.3 are checked at source and are satisfied. The closed form $\kappa_F(n)$ attached to it in the L28 block is not Fox's and is not proved on the record for $n>4$, `HYPOTHESIS-DEBT`, borne by the *check*, not by the lemma.** The lemma's conclusion does not depend on it: §5–§7 establish the seven eigenvalues from the charge formula, and §12 gives an independent recovery of five of them.

*Nothing in §9's arithmetic is disturbed. What is disturbed is the block's sentence "Two identities check the whole list, and each fails if any single value is wrong by a rational function of $m$." The **first** clause overstates the independence, and the block's own later paragraph concedes half of it. The **second** clause is true of $\mathop{\mathrm{tr}}L_e$ taken alone: perturbing exactly one $\lambda_S$ by $\varepsilon(m)\ne0$ changes $\mathop{\mathrm{tr}}L_e$ by $(\dim S)\varepsilon(m)\ne0$, since every $\dim S$ is a nonzero polynomial on $m\ge3$ (the fourth being nonzero on $m\ge4$, its range).*

## 10. The closed form for $e$, its tracelessness, and $\lVert e\rVert^2$

From [nondegeneracy.md](../findings/nondegeneracy.md) line 548, *just outside the brief's quoted range, and load-bearing, so checked here*:
$$e=-\frac1{2m-1}P_{\mathfrak m}+\frac{m-2}{(m+1)(2m-1)}P_{\mathfrak{su}(m)}+\frac{2(m-1)}{2m-1}P_\omega .$$
The three $U(m)$-isotypic pieces of $\Lambda^2\mathbb R^{2m}\cong\mathfrak{so}(2m)$ have ranks $\dim\mathfrak m=m(m-1)$, $\dim\mathfrak{su}(m)=m^2-1$, $\dim\mathbb R\omega=1$, summing to $m(2m-1)=\dim\mathfrak{so}(2m)$ ✓.

**Tracelessness.**
$$\mathop{\mathrm{tr}}e=\frac1{2m-1}\Big[-m(m-1)+\frac{(m-2)(m^2-1)}{m+1}+2(m-1)\Big]=\frac{-m^2+m+(m^2-3m+2)+2m-2}{2m-1}=\frac{0}{2m-1}=0 .$$
**Exact, identically in $m$. CONFIRMED.**

**Norm.**
$$\lVert e\rVert^2=\frac{m(m-1)}{(2m-1)^2}+\frac{(m-2)^2(m^2-1)}{(m+1)^2(2m-1)^2}+\frac{4(m-1)^2}{(2m-1)^2}=\frac{m-1}{(m+1)(2m-1)^2}\Big[m(m+1)+(m-2)^2+4(m-1)(m+1)\Big].$$
The bracket is $(m^2+m)+(m^2-4m+4)+(4m^2-4)=6m^2-3m=3m(2m-1)$, so
$$\lVert e\rVert^2=\frac{3m(m-1)}{(m+1)(2m-1)}=\frac1{\theta^2},\qquad \theta^2=\frac{(m+1)(2m-1)}{3m(m-1)} .$$
**Exact. CONFIRMED, and this is the strongest check in the whole entry**: three projector coefficients and the closed form for $\theta$ are four independent quantities, and one identity ties all four together. It also discharges hypothesis **H4** ($\lVert W\rVert=\theta\lVert e\rVert=1$) without assuming it.

**$\ker W$, the brief's first trap, and it is disarmed at exactly the right place.** $W=\theta e$ has the three eigenvalues $-\frac\theta{2m-1}$, $\frac{(m-2)\theta}{(m+1)(2m-1)}$, $\frac{2(m-1)\theta}{2m-1}$. **The middle one vanishes precisely at $m=2$**, which is why $W_{\mathbb{CP}^2}=\mathrm{diag}(0,0,0,-1,-1,2)/\sqrt6$ has $\dim\ker W=3$, and why $m\ge3$ is not a cosmetic restriction: it is exactly the condition $\ker W=0$. **At every $m\ge3$ the point is kernel-free**, so no padded-object reading of this lemma is available in its own range. See §14, trap 1, for the reading that *is* available and is the real exposure.

## 11. The slack against Lemma L70

[L70](../findings/bounds.md) states, at every critical point with $\lVert W\rVert=1$ and every unit $v\in E_{\min}$:
$$\theta=\lambda_{\min}+(n-2)\lambda_{\max}-\frac{D(v)}{\lvert\lambda_{\min}\rvert},\qquad D(v)\ge0 .$$
From §10, $\lambda_{\min}=-\frac\theta{2m-1}$ (the $\mathfrak m$ coefficient is the only negative one) and $\lambda_{\max}=\frac{2(m-1)\theta}{2m-1}$ (larger than the $\mathfrak{su}(m)$ coefficient, since $2(m-1)>\frac{m-2}{m+1}$ for $m\ge2$). At $n=2m$:
$$\lambda_{\min}+(n-2)\lambda_{\max}=\frac{\theta}{2m-1}\big[-1+(2m-2)\cdot2(m-1)\big]=\theta\,\frac{4(m-1)^2-1}{2m-1}=\theta\,\frac{(2m-3)(2m-1)}{2m-1}=\theta(2m-3).$$
So the deficiency is
$$\frac{D(v)}{\lvert\lambda_{\min}\rvert}=\theta(2m-3)-\theta=2(m-2)\theta .$$
**Exactly $2(m-2)\theta$, CONFIRMED**, and the block's own factorisation $\frac{4(m-1)^2-1}{2m-1}-1=\frac{2(2m-1)(m-2)}{2m-1}=2(m-2)$ is correct. It vanishes iff $m=2$, outside the range, and grows linearly. **The unit-norm hypothesis L70 needs is supplied by §10.**

The block's parenthetical also checks: saturation requires $\lambda_{\max}/\lvert\lambda_{\min}\rvert=\frac n{n-2}=\frac m{m-1}$, and here the ratio is $2(m-1)$; $2(m-1)=\frac m{m-1}\iff2(m-1)^2=m\iff(2m-1)(m-2)=0\iff m=2$. ✓ **A second, independent route to the same conclusion, and [L70](../findings/bounds.md) supplies a third**, saturation forces $\dim E_{\max}\ge\frac{n-2}2=m-1$, against $\dim E_{\max}=1$ here. Three routes, agreeing.

*Note for the record's benefit: [nondegeneracy.md](../findings/nondegeneracy.md) line 548 says "**It does NOT saturate Lemma L70**, and the claim that it did stood here for one revision." That correction is itself correct, by all three routes above.*

## 12. The second route to $\lambda_{\max}$, tested at one more row than the displayed one

Write $t_S=(\dim S)\lambda_S$. From §9a the seven $t_S$ are
$$1,\quad\tfrac{m^2+m-2}2,\quad\tfrac{m^2-m}2,\quad\tfrac{m^2(m-3)}2,\quad0,\quad0,\quad-\tfrac{m^2(m-1)}2,$$
and they sum to $0$.

**The displayed row ($\mathfrak{su}(m)$), reproduced.** With $y$ unknown there, $1+(m^2-1)y+\frac{m^2-m}2+\frac{m^2(m-3)}2-\frac{m^2(m-1)}2=0$, i.e. $1+(m^2-1)y-\frac{m^2+m}2=0$ (the block's display, term for term) so $(m^2-1)y=\frac{m^2+m-2}2=\frac{(m+2)(m-1)}2$ and $y=\frac{m+2}{2(m+1)}$. ✓

**Row four, $(1,1,0^{m-4},-1,-1)$, the extra row the brief asks for.** Holding the other six fixed, with unknown $u$:
$$1+\tfrac{m^2+m-2}2+\tfrac{m^2-m}2+\tfrac{m^2(m+1)(m-3)}4u+0+0-\tfrac{m^2(m-1)}2=0 .$$
The first three terms are $1+\frac{2m^2-2}2=m^2$, so $\frac{m^2(m+1)(m-3)}4u=\frac{m^2(m-1)}2-m^2=\frac{m^2(m-3)}2$, giving
$$u=\frac{m^2(m-3)}2\cdot\frac4{m^2(m+1)(m-3)}=\frac2{m+1}\qquad\textbf{(for }m\ge4\textbf{)}. \checkmark$$

**Row seven, $(2,2,0^{m-2})$.** The other six sum to $m^2+\frac{m^2(m-3)}2=\frac{m^2(m-1)}2$, so $\frac{m^2(m^2-1)}6w=-\frac{m^2(m-1)}2$ and $w=-\frac{3(m-1)}{m^2-1}=-\frac3{m+1}$. ✓

**Rows five and six, one at a time.** The other six already sum to $0$, so $\frac{2m^2(m^2-4)}3v=0$ gives $v=0$ (the coefficient is nonzero for $m\ge3$), and $\frac{m^2(m-1)(m+3)}4v'=0$ gives $v'=0$. ✓

**So each of the five computed classes is recovered uniquely from the other four, as claimed, with one qualification the block does not state.**

> **AT $m=3$ THE ROW-FOUR SOLVE IS VACUOUS.** $\dim=\frac{m^2(m+1)(m-3)}4$ and the right-hand side $\frac{m^2(m-3)}2$ **both vanish at $m=3$**, so the equation reads $0=0$ and $u$ is undetermined. **The word "uniquely" is therefore true on $m\ge4$ and empty at $m=3$.** This is harmless (at $m=3$ the summand is absent and there is no $u$ to determine) but it means the second route, taken alone, says nothing at the smallest admissible dimension about that row. *Checked against the discrepancy protocol: located at [nondegeneracy.md](../findings/nondegeneracy.md)'s "each uniquely from the other four"; exhibited in closed form above; and the opposite argued, the claim's scope is the five computed rows, and at $m=3$ row four is not one of them, so the sentence is not false, only unqualified. **Reported as an under-qualification, not a defect.***

**And the $\mathfrak{su}(m)$ solve survives the boundary, which is what matters.** The general solve's row-four contribution is $\frac{m^2(m-3)}2$, which vanishes at $m=3$ of its own accord, so the same equation runs unchanged: $1+8y+3-9=0$, $y=\frac58=\frac{m+2}{2(m+1)}\big|_{m=3}$. ✓ **The row carrying "not a maximiser" is recovered at every $m\ge3$ including the boundary. CONFIRMED.**

**A note on the count.** "Each uniquely from the other four" is loose read literally (solving for one of seven leaves six) but the preceding sentence ("the other five are computed") fixes the reading as *the other four computed values*, and under that reading it is exactly what §12 verifies.

## 13. The duplicate: does the same table stand at second-order.md?

**Both files opened. Row for row, the two tables AGREE.**

| row | [nondegeneracy.md](../findings/nondegeneracy.md) | [second-order.md](../findings/second-order.md) | agree? |
|---|---|---|---|
| trivial | $1$, $1$ | $1$, $1$ | ✓ |
| $\mathfrak{su}(m)$ | $m^2-1$, $\frac{m+2}{2(m+1)}$ | $m^2-1$, $\frac{m+2}{2(m+1)}$ | ✓ |
| orbit | $m(m-1)$, $\tfrac12$ | $m(m-1)$, $\tfrac12$ | ✓ |
| $V_{(1,1);(1,1)}$ | $\frac{m^2(m+1)(m-3)}4$, $\frac2{m+1}$ | $\frac{m^2(m+1)(m-3)}4$, $\frac2{m+1}$ | ✓ |
| $V_{(2,1);(1)}\oplus$conj | $\frac{2m^2(m^2-4)}3$, $0$ | $\frac{2m^2(m^2-4)}3$, $0$ | ✓ |
| $V_{(2);(2)}$ | $\frac{m^2(m-1)(m+3)}4$, $0$ | $\frac{m^2(m+3)(m-1)}4$, $0$ | ✓ (factors reordered only) |
| $V_{(2,2);\varnothing}\oplus$conj | $\frac{m^2(m^2-1)}6$, $-\frac3{m+1}$ | $\frac{m^2(m^2-1)}6$, $-\frac3{m+1}$ | ✓ |

The charge row $0,2m,2(m+1),4(m-1),4(m+1),4(m+1),4(m+4)$ likewise appears in both and matches §5–6. **The duplicate is faithful.** [nondegeneracy.md](../findings/nondegeneracy.md) adds the $GL(m)$ highest-weight column, which [second-order.md](../findings/second-order.md) supplies as prose instead; [second-order.md](../findings/second-order.md) adds the closed form for $e$ and the citation. **AGREE.**

### 13a. But one sentence of the duplicate is wrong, and it is not in the L28 block

**[second-order.md](../findings/second-order.md) line 279:**

> Both $V_{(2,1);(1)}\oplus\text{conj}$ and $V_{(2);(2)}$ carry $c_S+q_S^2=4(m+1)$, hence $L_e=0$; **the trace identity forces it, since the other five values already sum to zero against their dimensions.**

**The premise is right and the second reason is not.** §12 confirms that rows $1,2,3,4,7$ sum to zero against their dimensions, so $\mathop{\mathrm{tr}}L_e=0$ reduces to
$$\tfrac{2m^2(m^2-4)}3\lambda_5+\tfrac{m^2(m-1)(m+3)}4\lambda_6=0 .$$
**That is one equation in two unknowns and forces neither to vanish.** A closed-form family satisfying it, for any $s\in\mathbb R$:
$$\lambda_5=\frac{3s}{2m^2(m^2-4)},\qquad \lambda_6=-\frac{4s}{m^2(m-1)(m+3)} ,$$
which reproduces $\mathop{\mathrm{tr}}L_e=0$ identically in $m$ for every $s$, and is the true table only at $s=0$. **So the trace identity does not force $L_e=0$ on the two rows; it forces one linear relation between them.**

*Discrepancy protocol, all three cleared.* **Located**: [second-order.md](../findings/second-order.md) line 279, the clause after the semicolon. **Exhibited**: the one-parameter family above, in closed form, no computation. **Opposite argued**: the sentence's *first* clause already gives a valid reason, equal charges give $\lambda_5=\lambda_6$ by the charge formula, and then $(\dim_5+\dim_6)\lambda=0$ does force $\lambda=0$. So the intended argument is sound and the repair is one clause: **"equal by their shared charge, hence zero by the trace"** rather than "the trace identity forces it". **Confirmed as a stated-reason defect in [second-order.md](../findings/second-order.md).**

**This does not touch L28.** The [nondegeneracy.md](../findings/nondegeneracy.md) block makes the correct version of the claim ("each uniquely from the other four", which holds one row at a time (§12)) and its conclusion rests on the charge formula, verified independently in §5–6.

## 14. The traps, each answered by name

**1. $\ker W\ne0$ and padded objects.** *Answered in §10 for the kernel: $\ker W=0$ at every $m\ge3$, and $m=2$ is exactly where it fails.* **Padding is the live exposure and the block does not mention it.** The whole decomposition is the branching of $\mathcal W_{2m}$ under $U(m)\subset O(2m)$ in **native** dimension. Embed the same $W$ in $\mathcal W_N$ for $N>2m$ and every dimension in the table is wrong, the invariance group changes, and, per [second-order.md](../findings/second-order.md) line 205, "padding manufactures excess elsewhere". The record knows this and says so *in another file*. **Recorded as hypothesis H2, used and unstated.** The correct scope sentence is one line: *stated at $n=2m$ in native dimension; nothing here applies to a padded copy.*

**2. The boundary of every stated range and the smallest admissible dimension.** *Answered throughout, and $m=3$ is checked at every step it touches:* the six surviving dimensions sum to $84=\dim\mathcal W_6$ (§2); $4(m-1)=2(m+1)$ has its unique solution there (§7); the absence is proved by $\ell(\lambda)+\ell(\mu)=4>3$ (§8); the trace solve for $\mathfrak{su}(m)$ runs unchanged and returns $\tfrac58$ (§12); and the row-four solve degenerates there, harmlessly (§12). **The upper end of the range is $\infty$ and every identity is a polynomial identity in $m$, so there is no upper boundary to fail at.** *One further boundary is worth naming: $\theta^2=\frac{(m+1)(2m-1)}{3m(m-1)}$ has $m(m-1)$ in the denominator, so the closed form is singular at $m=0,1$, both outside the range, and $m=2$ gives $\theta^2=\tfrac32$, the literature's $W_{\mathbb{CP}^2}$, which the record checks as the family's anchor.*

**3. A claim proven on a subfamily and used in general.** *Found, and it is the $\kappa_F$ closed form.* $\kappa_F(n)=\frac{(2n-1)(n-1)}4$ is proved at $n=4$ (Fox's Theorem 1.5) and fitted elsewhere; L28 uses it at every even $n\ge6$. **Recorded in §9d.** *No other instance: every other claim in the block is a polynomial identity in $m$ verified as such.*

**4. A hypothesis stated but never used.** *None found.* Every stated hypothesis in the inventory is consumed: $m\ge3$ by the kernel and the absence; multiplicity-freeness by Schur; $U(m)$-invariance of $e$ by equivariance; "three conjugate pairs" by the reconciliation of $10$ with $7$.

**5. A step using a hypothesis never stated.** *Three found.* **H2** (native dimension, §14.1). **H4** ($\lVert W\rVert=1$, needed for $\lVert e\rVert^2=\theta^{-2}$ in the Fox check and for L70 in §11), discharged by §10 but never stated. **And the block's final sentence, "since $\lambda_{\max}>\tfrac12$, is not a maximiser", is [Lemma L24](../findings/second-order.md) and cites nothing.** L24 is what converts an eigenvalue above $\tfrac12$ into a failure of maximality; without it the sentence is a non sequitur. **Recorded as H10, an uncited dependency.** *[conventions.md](../findings/conventions.md) states the needed form and warns against exactly the conflation the sentence risks:* "an eigenvalue **above** $\tfrac12$ off the orbit costs maximality and contributes nothing to the kernel, and the two failures must never be collapsed." **The block keeps them separate correctly** ($E(\tfrac12)$ for nondegeneracy, $\lambda_{\max}>\tfrac12$ for non-maximality) so the trap is avoided in substance and the citation is what is missing.

**6. An imported theorem whose hypotheses were never checked against the object.** *Answered in full at §9c, at source.* **Fox's Theorem 1.3 is a theorem about $(\mathrm{MC}_W(V^*),*)$ itself, its only hypothesis is $\dim V\ge4$, and it *concludes* nonunitality rather than assuming it.** The trap the brief names is real on this record but belongs to Tkachev's Theorem 1.2, which the record already bars for exactly that reason. **The debt that does exist is $\kappa_F$'s closed form (§9d), which is an over-attribution rather than a failed hypothesis.**

**7. A universal claim with no witness.** *One candidate, and it survives inspection.* "The seven real dimensions sum to $\dim\mathcal W_{2m}$ identically in $m$" is universal over $m\ge3$, **§3 supplies the polynomial identity, so it is proved rather than sampled.** Likewise "$\mathop{\mathrm{tr}}L_e=0$" and the $\mathop{\mathrm{tr}}L_e^2$ value (§9). *The one genuinely unwitnessed universal is multiplicity-freeness at $m\ge4$, which rests on the citation (§2); at $m=3$ it is proved here.*

**8. Symbol collisions.** *Checked against [conventions.md](../findings/conventions.md), and three are live in this block.*
- **$c$**, $c_S$ is the Casimir charge here, while [bounds.md](../findings/bounds.md)'s $c_{vab}$ are the bracket structure constants **in the very identity §11 compares against**, and [conventions.md](../findings/conventions.md) flags a third sense at [L47](../findings/problem.md). *Both senses appear within one paragraph of each other at [nondegeneracy.md](../findings/nondegeneracy.md) line 548.* **Read $c_S$ only with its subscript.**
- **$q$**, $q_S=\sum_i\nu_i$ here, against [conventions.md](../findings/conventions.md)'s two tabled senses in [stratum-two-negative.md](../findings/stratum-two-negative.md) (a Weitzenböck operator and a scalar parameter of $W_4(q,r)$), and against $q$ as a sphere-product block dimension in [L27](../findings/nondegeneracy.md), **the lemma immediately adjacent to this one**. **The adjacency is the risk.**
- **$P$**, [conventions.md](../findings/conventions.md) tables three senses (the cubic form, Petersen–Stanfield's operator, the certificate polynomial). **The closed form for $e$ adds a fourth, $P_{\mathfrak m},P_{\mathfrak{su}(m)},P_\omega$ as isotypic projectors, and it is untabled.** *In the same file, $P(W)$ the cubic form is the object whose critical points the whole entry is about.*
- **$e$** and **$\lambda$** are used in their tabled senses ($e=W/\theta$; $\lambda$ an eigenvalue), with one caveat: **$\lambda$ also names the $O(2m)$ highest weight $(2,2)$ in the phrase "the $GL_m\subset O_{2m}$ branching rule at $\lambda=(2,2)$", one sentence before the $L_e$ eigenvalue column.** *Two senses of $\lambda$ inside one paragraph.*
- **$\nu$** carries the $GL(m)$ weight and is defined only at [second-order.md](../findings/second-order.md), never in [conventions.md](../findings/conventions.md); so are $c_S$ and $q_S$. **The block therefore restates a convention rather than quoting one, against [conventions.md](../findings/conventions.md)'s own standing rule** ("definitions and conventions are quoted, never restated"). *Convention hygiene, not mathematics.*

## 15. The landscape statement, are they consistent?

**No. Read literally, [results.md](../results.md) line 142 contradicts the table on the same lemma.**

> The $U(m)$-decomposition is multiplicity-free, so Schur fixes one eigenvalue per summand, and each is $1-\frac{c_S+q_S^2}{4(m+1)}$. **Only $\tfrac2{m+1}$ reaches $\tfrac12$, at $m=3$, where that summand is empty.**

The sentence quantifies over the summands with no exclusion, immediately after naming the formula that produces all seven values. **But the orbit summand $\Lambda^2E\oplus\Lambda^2\bar E$ carries $c_S+q_S^2=2(m+1)$ identically (§5–6), hence $\lambda_S=\tfrac12$ at every $m\ge3$.** So a second summand reaches $\tfrac12$, and it reaches it everywhere rather than at one $m$.

*Discrepancy protocol, all three cleared.*
1. **Located.** [results.md](../results.md) line 142, final sentence.
2. **Exhibited in closed form.** $\nu=(1,1,0^{m-2})$ gives $q_S=2$, $c_S=m+(m-2)=2m-2$, so $c_S+q_S^2=2m+2$ and $\lambda_S=1-\frac{2m+2}{4(m+1)}=\tfrac12$ for **every** $m$. No numerics.
3. **The opposite argued.** The charitable reading supplies "besides the orbit", which is how the [nondegeneracy.md](../findings/nondegeneracy.md) block states it correctly: *"That holds identically on the orbit, and among the rest only $4(m-1)$ can meet it."* **That reading does not rescue the sentence, and here is why it cannot.** Line 142's own lemma statement, four lines above in the same file, asserts $\dim E(\tfrac12)=m(m-1)$. If only $\tfrac2{m+1}$ reached $\tfrac12$ and it were empty at $m=3$ and unequal to $\tfrac12$ at $m\ne3$, then $E(\tfrac12)=0$ at every $m$, **flatly contradicting the lemma the sentence is summarising.** The landscape line is not a harmless compression: it removes the one summand that makes the conclusion true.

**CONFIRMED DISCREPANCY.** The mathematics behind it is right; the sentence as written is not. **The repair is three words**: *"Besides the orbit, only $\tfrac2{m+1}$ reaches $\tfrac12$, at $m=3$, where that summand is empty."* **Not repaired here, a verifier reports.**

*Severity: statement-level, not result-level. Nothing downstream of L28 is derived from line 142; it is a summary line, and the canonical statement and proof are at [nondegeneracy.md](../findings/nondegeneracy.md), which is correct.*

## Verdict

# `PROVEN, hypotheses corrected`

**The lemma is correct and its proof is correct.** Every arithmetic claim the brief named was re-derived from the weights rather than read from the record, and **all of it stands**, including the repaired charge column, which survives its own independent re-derivation at all seven rows.

**What the block owes, in descending order of seriousness:**

| # | owed | where |
|---|---|---|
| 1 | **`HYPOTHESIS-DEBT`: $\kappa_F(n)=\frac{(2n-1)(n-1)}4$ is attributed to Fox and is not his**, his Remark 1.4 leaves $\kappa$ uncomputed for $\dim V>4$. The second identity therefore *derives* $\kappa_F$ at even $n$ rather than checking the table. **What would have to be proved: $\kappa_F(n)=\frac{(2n-1)(n-1)}4$ for $n>4$, analytically.** | §9d |
| 2 | **The scope hypothesis H2 (native dimension $n=2m$, no padding), is used and stated nowhere in the block.** | §14.1 |
| 3 | **A confirmed statement defect at [results.md](../results.md) line 142**: "Only $\tfrac2{m+1}$ reaches $\tfrac12$" contradicts the orbit row and, taken literally, contradicts its own lemma. Repair is three words. | §15 |
| 4 | **A confirmed stated-reason defect at [second-order.md](../findings/second-order.md) line 279**: the trace identity forces one linear relation between the two zero rows, not their vanishing. The valid reason is the shared charge. | §13a |
| 5 | "Two identities check the whole list" **overstates by one**, $\mathop{\mathrm{tr}}L_e$ is the block's own derivation of the $\mathfrak{su}(m)$ row and cannot also be an independent check on it. The block's later paragraph concedes this. | §9 |
| 6 | **The final clause is [L24](../findings/second-order.md) and cites nothing** ($\lambda_{\max}>\tfrac12\Rightarrow$ not a maximiser). | §14.5 |
| 7 | Under-citations, no mathematics at risk: the $m=3$ absence uses $\ell(\lambda)+\ell(\mu)\le m$ without naming it (§8); "uniquely from the other four" is empty at $m=3$ for row four (§12); $P$ as an isotypic projector is a fourth untabled sense (§14.8). | §8, §12, §14.8 |

**None of items 1–7 reaches the conclusion.** $E(\tfrac12)$ is the orbit tangent at every $m\ge3$, $\lambda_{\max}(L_e|_{W^\perp})=\frac{m+2}{2(m+1)}>\tfrac12$, and $\mathbb{CP}^m$ is Morse–Bott nondegenerate and not a maximiser, each resting on the charge formula, which §5–6 verifies at all seven rows, and on the closed form for $e$, which §10 verifies by an identity tying four independent quantities together.

*No numerical work was done in reaching this verdict. Every derivation above is exact arithmetic in closed form.*
