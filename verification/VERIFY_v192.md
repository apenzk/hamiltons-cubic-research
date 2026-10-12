# VERIFY_v192, L48, the reducible case and the symmetric-space Theorem

**The brief was read cold. No numerical work of any kind was done**, every figure below is exact rational arithmetic carried out by hand on objects the record itself names, in the screening allowance of [analysis-only.md](../.claude/rules/analysis-only.md). No script, no Sage, no evaluation. Log: [agent_logs/verify-L48-v192.log](../agent_logs/verify-L48-v192.log).

**Two objects are checked here and kept apart**: the *lemma* about products (the decomposition, the closed form, Jensen, the threshold), and the *Theorem* stated inside the blockquote at [problem.md](../findings/problem.md) line 261.

## Claim table

| # | claim | verdict |
| --- | --- | --- |
| 1 | $R$ block-diagonal on $\Lambda^2$, zero on the mixed terms | **CONFIRMED**, standard, and the block states it of $R$ and not of $W$, which is the right object |
| 2 | $\lVert W\rVert^2=\sum_a\lVert W_a\rVert^2+B$, $B=\sum_af(n_a)-\tfrac n{8(n-1)}$, $f(m)=\tfrac m{8(m-1)}$ | **CONFIRMED**, re-derived independently from the block decomposition, mixed block included |
| 3 | $B$ depends on the partition alone | **CONFIRMED** for $B$; **the landscape gloss that $\lVert W\rVert^2$ does is FALSE as written** |
| 4 | $f$ decreasing and convex | **CONFIRMED**, $f'=-\tfrac1{8(m-1)^2}$, $f''=\tfrac1{4(m-1)^3}$ |
| 5 | Jensen minimises $\sum f$ at the balanced split for fixed $k$ | **CONFIRMED**, direction correct; the constraint is *fixed $k$ and fixed $\sum n_a=n$*, and the block names only the first |
| 6 | $k\,f(n/k)=\tfrac{kn}{8(n-k)}$ increasing in $k$ | **CONFIRMED**, derivative $\tfrac{n^2}{8(n-k)^2}>0$ |
| 7 | $\lVert W_a\rVert^2\ge0$, vanishing exactly when the factor is a sphere | **CONFIRMED under Einstein**, both directions; **the Einstein hypothesis is what makes $\Rightarrow$ true and the canonical block does not say so**, and "sphere" should read "constant curvature" ($\mathbb{RP}^{n_a}$ qualifies) |
| 8 | reducible minimum $=\tfrac{n^2}{8(n-1)(n-2)}=\tfrac1{4\theta_0(n)^2}$ | **CONFIRMED**, both the value and its identification with $\tfrac1{4\theta_0^2}$ |
| 9 | $\tfrac16\ge\tfrac{n^2}{8(n-1)(n-2)}\iff n^2-12n+8\ge0$ | **CONFIRMED**, equivalence exact; polynomial recovered, not assumed |
| 10 | Theorem: for every $n\ge12$ every compact Einstein symmetric space has $\theta\le\theta_0(n)$ | **HYPOTHESIS-DEBT**, the quantifier still admits $S^n$, $\mathbb{RP}^n$ and flat tori, where $\theta$ is $0/0$; $W\ne0$ (equivalently L46's $\lambda\ne0$) is a **third** missing hypothesis |
| 11 | equality exactly at $S^{n/2}\times S^{n/2}$, round factors, equal Einstein constant, $n$ even | **HYPOTHESIS-DEBT**, the *value* is right and the uniqueness clause is false over isometry classes: $\mathbb{RP}^{n/2}\times\mathbb{RP}^{n/2}$ attains it too |
| 12 | Einstein is load-bearing | **CONFIRMED**, used at three separate steps, not merely stated |
| 13 | a reducible symmetric space with unequal factor Einstein constants is not Einstein | **CONFIRMED**, $\mathrm{Ric}$ of a product is the direct sum, both directions |
| 14 | odd $n$: $\theta^2=\tfrac{120}{77}$ against $\theta_0^2=\tfrac{264}{169}$ at $n=13$ | **CONFIRMED**, both figures reproduced by hand, and cross-checked against Nienhaus's $\theta_{k,l}$ |
| 15 | the repair's summary, "two hypotheses were missing, and neither changes a value" | **NOT A FAIR DESCRIPTION**, the count is wrong (a third is missing) and "neither changes a value" describes numbers while concealing that the claim narrowed twice |
| 16 | symbol hygiene: $B$, $f$, $k$, $c$ | **DEFECT**, L48's scalar $B$ is a **fourth** object under that letter and is tabled nowhere; $k$ collides with $\theta_{k,l}$ eighteen lines below in the same file |

**Verdict: HYPOTHESIS-DEBT.** Every derivation in the block is correct and every number in it is correct; what the block owes is three unstated hypotheses and one over-strong uniqueness clause, none of which moves a figure.

## 0. Conventions, fixed once

Quoted from [conventions.md](../findings/conventions.md), not restated:

> $\theta$ | $P(W)/\lVert W\rVert^3$; at a critical point, $Q(W)=\theta W$

> $\theta_0(n)$ | **the closed form $\theta_0(n)^2=2(n-1)(n-2)/n^2$, and nothing more.** *It is the value at the balanced sphere product **at even $n$ only**, at odd $n$ the balanced split gives $\Theta_n<\theta_0(n)$*

> $\Theta_n$ | the diagonal maximum; equals $\theta_0(n)$ at even $n$, and $\sqrt{2(n-1)(n-3)/((n+1)(n-2))}$ at odd $n$

> **$\operatorname{scal}=2\operatorname{tr}$ on $\Lambda^2$.**

> $R_I$, $R_{\mathrm{ric}_0}$, $R_W$ | the three $O(n)$-irreducible pieces of an algebraic curvature operator, scalar, **trace-free** Ricci, and Weyl.

> **THE LETTER $B$ MEANS TWO THINGS, live.** … | $B$ | $B=\tfrac\theta2\mathrm{Id}-L_W$ at a critical point … *This is a third object under the letter $B$ in this record*

The last is quoted because L48 introduces a fourth. See §9.

## 1. The hypothesis inventory

**Of the block's own argument (the lemma).** Stated: *product*, *symmetric*, *compact*, *Einstein*. Unstated but used:

| hypothesis | where it is used | stated in the canonical block? |
| --- | --- | --- |
| $M$ carries the **product metric** (de Rham splitting is metric) | the vanishing of $R$ on the mixed block | implicit in "for a product" |
| Einstein constant normalised to $\lambda=\tfrac12$ | the whole identity $\lVert W\rVert^2=\lVert R\rVert^2-f(n)$, and $f$ itself | **no**, it lives two blocks up in [L47](../findings/problem.md), never quoted here |
| every factor Einstein with the **same** $\lambda=\tfrac12$ | $\lVert W_a\rVert^2=\lVert R_a\rVert^2-f(n_a)$ *with the same $f$* | **no**, [graded-half.md](../findings/graded-half.md) line 128 states it; the canonical block does not |
| $n_a\ge2$ for every factor | $f(m)=\tfrac m{8(m-1)}$ has a pole at $m=1$ | **no**, it follows from the previous row (a flat circle factor has $\lambda=0\ne\tfrac12$), and [graded-half.md](../findings/graded-half.md) says "so no flat factors occur"; the canonical block says nothing |
| $k\ge2$ | "the reducible minimum sits at $k=2$" needs $k=2$ to be admissible and $k=1$ excluded | implicit in "reducible"; $k=1$ returns $B=0$ consistently |
| $\sum n_a=n$ held fixed alongside $k$ | Jensen | **no**, the block names only "for fixed $k$" |

**Of the imported [Lemma L46](../findings/problem.md), which carries four.** The block's own inventory there reads:

> **HYPOTHESES THE STATEMENT OWES, ALL FOUND AT THE SAME AUDIT.** *$\lambda\ne0$* … **the conclusion needs $W\ne0$ and neither the block nor the canon says so** … **Step (A) is stated flow-free and needs no completeness.** … the identity needs neither compactness nor irreducibility nor rank.

Checked against L48's object, a compact Einstein symmetric space of dimension $n$:

| L46 hypothesis | checked at L48? |
| --- | --- |
| locally symmetric | **yes**, symmetric $\Rightarrow$ locally symmetric |
| $\mathrm{Ric}=\lambda g$ | **yes**, hypothesised outright, and this is the repair's own point |
| $\lambda\ne0$ | **NO**, a flat torus $T^n$ is compact, symmetric and Einstein at $\lambda=0$ |
| $W\ne0$ | **NO**, $S^n$ and $\mathbb{RP}^n$ are inside the Theorem's quantifier and have $W=0$ |

The last two rows are the finding of §7. They are one condition in practice: under $\lambda\ne0$ the normalisation $\lambda=\tfrac12$ is available, no flat factor survives, and the only remaining $W=0$ spaces are the constant-curvature ones.

## 2. The decomposition, derived

**Claim.** For a Riemannian product $M=M_1\times\cdots\times M_k$ with $T_pM=\bigoplus_aV_a$, the curvature operator on
$$\Lambda^2\mathbb R^n=\bigoplus_a\Lambda^2V_a\ \oplus\ \bigoplus_{a<b}V_a\wedge V_b$$
preserves each $\Lambda^2V_a$, acting there as $R_a$, and annihilates every mixed summand $V_a\wedge V_b$.

**Derivation.** The Levi-Civita connection of a product metric splits: $\nabla_XY$ is tangent to $V_a$ whenever $X$ and $Y$ are, and vanishes when they are tangent to different factors. Hence $R(X,Y)Z=0$ unless $X,Y,Z$ all lie in one factor, so in an adapted frame $R_{ijkl}=0$ unless $i,j,k,l$ all index the same factor. Then for $e_i\in V_a$, $e_j\in V_b$ with $a\ne b$, every component $\langle R(e_i\wedge e_j),e_k\wedge e_l\rangle=R_{ijkl}$ vanishes, so $R$ kills the mixed block; and for $e_i,e_j\in V_a$ the only surviving components have $k,l\in V_a$, so $\Lambda^2V_a$ is preserved and $R$ restricts there to $R_a$.

**What it needs.** Only that the metric is a Riemannian product. It needs neither Einstein nor symmetric.

**The trap the block avoids and a reader may not.** The statement is about $R$, **not** about $W$. Since $W=R-cI$ and $I$ is the identity on all of $\Lambda^2$, the mixed block of $W$ is $-c\,\mathrm{Id}$, which is nonzero. That mixed block is not a nuisance term, it is exactly where half of $B$ comes from, as §3 shows. The block writes "$R$ is block-diagonal … and zero on the mixed terms" and is correct; [graded-half.md](../findings/graded-half.md) draws the consequence explicitly as $\lVert R\rVert^2=\sum_a\lVert R_a\rVert^2$, which the canonical block leaves to the reader.

## 3. The closed form, re-derived from the blocks

I did not take the identity on trust; I rebuilt it from the decomposition of §2, which is the only way to see the mixed block pay.

Write $c=\lambda/(n-1)=\tfrac1{2(n-1)}$ and $c_a=\lambda/(n_a-1)=\tfrac1{2(n_a-1)}$, so $W=R-cI$ and $W_a=R_a-c_aI_a$. First, the arithmetic identity that makes $f$ what it is:
$$c_m^2\binom m2=\frac1{4(m-1)^2}\cdot\frac{m(m-1)}2=\frac m{8(m-1)}=f(m).$$
So **$f(m)$ is not an ansatz: it is $\lVert cI\rVert^2$ in dimension $m$.**

Now split $\lVert W\rVert^2$ over §2's three kinds of block. On $\Lambda^2V_a$, $W=R_a-cI_a=W_a+(c_a-c)I_a$, and $\langle W_a,I_a\rangle=\operatorname{tr}W_a=\tfrac12\operatorname{scal}(W_a)=0$ because the Weyl piece is trace-free. On the mixed block, $W=-c\,\mathrm{Id}$ on a space of dimension $\sum_{a<b}n_an_b=\tfrac12(n^2-\sum_an_a^2)$. Hence
$$\lVert W\rVert^2=\sum_a\Bigl[\lVert W_a\rVert^2+(c_a-c)^2\binom{n_a}2\Bigr]+\frac{c^2}2\Bigl(n^2-\sum_an_a^2\Bigr).$$
Expand $(c_a-c)^2=c_a^2-2c_ac+c^2$ and use $c_a\binom{n_a}2=\tfrac{n_a}4$, so $\sum_ac_a\binom{n_a}2=\tfrac n4$:

- the $c_a^2$ terms give $\sum_af(n_a)$;
- the cross terms give $-2c\cdot\tfrac n4=-\tfrac n{4(n-1)}=-2f(n)$;
- the $c^2$ terms over the diagonal blocks give $\tfrac{c^2}2(\sum_an_a^2-n)$, and the mixed block gives $\tfrac{c^2}2(n^2-\sum_an_a^2)$; these sum to $\tfrac{c^2}2(n^2-n)=c^2\binom n2=f(n)$.

Total: $\lVert W\rVert^2=\sum_a\lVert W_a\rVert^2+\sum_af(n_a)-2f(n)+f(n)$, i.e.
$$B=\sum_af(n_a)-\frac n{8(n-1)}.\qquad\checkmark$$

**The formula is correct.** Note what the derivation shows: the $\sum_an_a^2$ terms cancel between the diagonal and mixed blocks exactly, which is *why* $B$ comes out depending on the partition through $\sum f(n_a)$ alone and not through $\sum n_a^2$ as well.

**Cross-check against an independent formula on the record.** [problem.md](../findings/problem.md) line 521 carries Nienhaus's $\theta_{k,l}^2=2\tfrac{n-1}{n-2}\bigl(1-\tfrac{n-1}{kl}\bigr)$ for the split $k+l=n$. Through $\theta^2=\tfrac1{4B}$ at two spheres, at $(6,6)$, $n=12$: $B=\tfrac18(1+\tfrac15+\tfrac15-\tfrac1{11})=\tfrac9{55}$, so $\theta^2=\tfrac{55}{36}$; Nienhaus gives $2\cdot\tfrac{11}{10}\cdot\tfrac{25}{36}=\tfrac{55}{36}$. Agreement.

### 3a. "Depending on the partition alone", a real defect, in the landscape line

The block's dash-clause attaches to $B$ and is true of $B$. The **landscape statement at [results.md](../results.md) line 172 detaches it and is false as written**:

> For a product the mixed terms vanish, so $\lVert W\rVert^2$ depends on the partition alone

Discrepancy protocol, all three cleared.

1. **Located.** [results.md](../results.md) line 172, the L48 landscape entry.
2. **Exhibited, in closed form.** Take $n=12$ and the partition $6+6$. $S^6\times S^6$ gives $\lVert W\rVert^2=B=\tfrac9{55}$. $\mathbb{CP}^3\times S^6$ has the same partition, is compact, symmetric and Einstein at $\lambda=\tfrac12$, and by [L47](../findings/problem.md)'s closed form $\lVert W_{\mathbb{CP}^m}\rVert^2=\tfrac{3m(m-1)}{4(m+1)(2m-1)}$ at $m=3$ equals $\tfrac{18}{80}=\tfrac9{40}$, so $\lVert W\rVert^2=\tfrac9{55}+\tfrac9{40}$. **Same partition, two values.**
3. **Argued the opposite.** Could the sentence be read as "the *partition-dependent part* depends on the partition alone"? That reading is vacuous. Could it be read under a standing "all factors spheres" hypothesis? Nothing in the sentence or its neighbours supplies one, and the sentence is the *premise* from which sphere factors are later concluded, so it cannot presuppose them. The consumer at [results.md](../results.md) line 567 states the correct version ("depends on the partition alone **with every non-sphere factor adding to it**") which confirms the intent and confirms that line 172 dropped the clause that makes it true.

**Severity.** Expository, not mathematical: the argument never uses more than $\lVert W_a\rVert^2\ge0$, so the minimum over a fixed partition is $B$ and everything downstream stands. But line 172 is the entry a reader meets first, and as written it is false.

## 4. Jensen, and the direction it is used in

$f(m)=\tfrac m{8(m-1)}=\tfrac18\bigl(1+\tfrac1{m-1}\bigr)$, so on $(1,\infty)$
$$f'(m)=-\frac1{8(m-1)^2}<0,\qquad f''(m)=\frac1{4(m-1)^3}>0.$$
**Decreasing and convex, both confirmed.**

**The direction.** For $f$ convex, Jensen reads $\tfrac1k\sum_af(n_a)\ge f\bigl(\tfrac1k\sum_an_a\bigr)$, so
$$\sum_af(n_a)\ \ge\ k\,f(n/k),$$
with equality iff all $n_a$ are equal. Convexity therefore puts the **minimum** of $\sum f$ at the balanced point. This is the direction the block needs, because the target is a *lower* bound on $\lVert W\rVert^2$ (and hence an *upper* bound on $\theta=\tfrac{1/2}{\lVert W\rVert}$).

**The constraint the block does not name.** Convexity gives a minimum at the balanced point only under *both* constraints: **the number of terms $k$ is fixed and their sum $\sum n_a=n$ is fixed**. The block says "for fixed $k$" and leaves the fixed sum to be inferred. Under a fixed sum with $k$ free the balanced point is not a minimum of anything; under fixed $k$ with free sum the infimum is $k/8$, unattained. Both constraints are genuinely in force here and the step is correct, but only one of the two is written down. Recorded as an omission, not an error.

**Domain.** Jensen needs $f$ convex on an interval containing every $n_a$ and $n/k$. With $n_a\ge2$ and $k\le n/2$ we have $n/k\ge2$, so all points lie in $[2,\infty)\subset(1,\infty)$ where $f''>0$. The hypothesis $n_a\ge2$ is the one the canonical block never states (§1).

**Integrality.** Jensen is applied over the reals while $n_a$ are integers. That is the safe direction: the real minimum is a valid lower bound for the integer problem, so $\theta\le\theta_0(n)$ survives at every $n$. It is *attained* only when $n/k$ is an integer, which at $k=2$ means $n$ even, and this is exactly why the equality clause is restricted to even $n$ and why odd $n$ falls strictly below. **The block gets this right.**

**$k\,f(n/k)$ in $k$.** $k\,f(n/k)=k\cdot\tfrac{n/k}{8(n/k-1)}=\tfrac{n}{8\cdot\frac{n-k}k}=\tfrac{kn}{8(n-k)}$, and
$$\frac{\partial}{\partial k}\frac{kn}{8(n-k)}=\frac n8\cdot\frac{(n-k)+k}{(n-k)^2}=\frac{n^2}{8(n-k)^2}>0.$$
**Increasing in $k$, confirmed**, on $0<k<n$, which covers $2\le k\le n/2$.

**Hence the minimum over $k\ge2$ is at $k=2$**, giving
$$B_{\min}=\frac{2n}{8(n-2)}-\frac n{8(n-1)}=\frac n8\cdot\frac{2(n-1)-(n-2)}{(n-1)(n-2)}=\frac{n^2}{8(n-1)(n-2)}.$$
The block asserts "the reducible minimum sits at $S^{n/2}\times S^{n/2}$" without writing the $k=2$ selection or this line; [graded-half.md](../findings/graded-half.md) writes "so $k=2$ balanced is the global minimum". The step is one line and correct either way.

## 5. $\lVert W_a\rVert^2\ge0$, and when it vanishes, both directions

**Nonnegativity** is a norm, and needs nothing.

**($\Leftarrow$) A round factor has $W_a=0$.** Constant sectional curvature gives $R_a=\kappa\,I_a$ on $\Lambda^2V_a$, whose Weyl part is zero. Immediate.

**($\Rightarrow$) $W_a=0$ forces constant curvature, and this is where Einstein pays.** $W_a=0$ means $M_a$ is conformally flat. Conformal flatness alone does **not** give a sphere: $S^1\times S^{m-1}$ is conformally flat with $W=0$ and is not of constant curvature. What closes the direction is the standing hypothesis that $M_a$ is Einstein: an Einstein manifold with vanishing Weyl tensor has constant sectional curvature, since $R=R_I+R_{\mathrm{ric}_0}+R_W$ (quoted in §0) collapses to $R_I$ when the trace-free Ricci and Weyl pieces both vanish. At $n_a=2$ and $n_a=3$, $W_a\equiv0$ identically and the conclusion still holds, because Einstein in those dimensions is itself constant curvature.

**Verdict.** The claim is **true as used** and **false as stated in the abstract**. The canonical block writes "each $\lVert W_a\rVert^2\ge0$ vanishes exactly when that factor is a sphere" with no hypothesis attached; that sentence is a general claim about a factor of a product and is refuted by $S^1\times S^{m-1}$. Under the block's own Einstein hypothesis it is correct. [graded-half.md](../findings/graded-half.md) states it better, "vanishes exactly when that factor has constant curvature, i.e. **is a sphere**", naming the property rather than the space.

**And "sphere" is the wrong noun even under Einstein.** $\mathbb{RP}^{n_a}$ has constant curvature, is a compact symmetric space, and has $W=0$. The record knows this: [graded-half.md](../findings/graded-half.md) line 120 says "$S^n$ and $\mathbb{RP}^n$ have $W=0$". The consequence for the equality clause is §8.

## 6. The meeting with no gap, and the threshold polynomial recovered

**The equivalence.** For $n\ge3$ both $n-1$ and $n-2$ are positive, so multiplying through by $24(n-1)(n-2)>0$ is order-preserving:
$$\frac16\ \ge\ \frac{n^2}{8(n-1)(n-2)}\iff 8(n-1)(n-2)\ge6n^2\iff 8n^2-24n+16\ge6n^2\iff 2n^2-24n+16\ge0\iff n^2-12n+8\ge0.$$
**Confirmed, and the polynomial is recovered rather than assumed**: it is produced by comparing [L47](../findings/problem.md)'s irreducible floor $\tfrac16$ against §4's reducible floor, neither of which mentions it. Roots $6\pm2\sqrt7$, upper root $6+2\sqrt7\approx11.2915$, so over the integers the condition is $n\ge12$; at $n=12$ the polynomial is $144-144+8=8>0$ and at $n=11$ it is $121-132+8=-3<0$. Both boundary values checked.

**That the reducible minimum is $\tfrac1{4\theta_0(n)^2}$.** From §0, $\theta_0(n)^2=\tfrac{2(n-1)(n-2)}{n^2}$, so
$$\frac1{4\theta_0(n)^2}=\frac{n^2}{8(n-1)(n-2)},$$
which is §4's $B_{\min}$ exactly. **Confirmed.** And it is the right quantity to compare, because at a locally symmetric Einstein space [L46](../findings/problem.md) gives $\theta=\lambda/\lVert W\rVert=\tfrac{1/2}{\lVert W\rVert}$, so $\theta^2=\tfrac1{4\lVert W\rVert^2}$ and minimising $\lVert W\rVert^2$ maximises $\theta$. Sanity: at $n=12$, $B_{\min}=\tfrac{144}{880}=\tfrac9{55}$ and $\theta^2=\tfrac{55}{36}=\theta_0(12)^2$.

**One observation on "recovered rather than assumed".** Through the monotone bijection $\lVert W\rVert^2\leftrightarrow\theta^2=\tfrac1{4\lVert W\rVert^2}$, the inequality $\tfrac16\ge\tfrac{n^2}{8(n-1)(n-2)}$ is literally $\theta_0(n)\ge\sqrt{3/2}$, which is also [L44](../findings/problem.md)'s comparison. So this is the same inequality read at the other end of the correspondence, not an independent derivation of the threshold. That is not a defect (the block claims only that the polynomial is not assumed, and it is not) but "its third independent appearance" ([graded-half.md](../findings/graded-half.md)) overstates the independence.

**"No gap" is loose but harmless.** For $n\ge12$ the reducible floor is *strictly* below $\tfrac16$, so the two halves do not meet; they meet at $n^2-12n+8=0$, which no integer attains. The content (that the same polynomial governs which of the two floors binds and where $n\ge12$ comes from), is correct.

## 7. The Theorem, checked separately

> **Theorem.** For every $n\ge12$, every compact **Einstein** symmetric space of dimension $n$ satisfies $\theta\le\theta_0(n)$, with equality exactly at $S^{n/2}\times S^{n/2}$ **with both factors of constant curvature and equal Einstein constant**, when $n$ is even.

**The inequality half is sound where $\theta$ is defined.** By de Rham a compact symmetric space splits into irreducible factors (and a flat factor); Einstein with $\lambda=\tfrac12$ kills the flat factor. Irreducible: [L47](../findings/problem.md) gives $\theta\le\sqrt{3/2}$, and $\theta_0(n)^2\ge\tfrac{55}{36}>\tfrac32$ for $n\ge12$ by §6, so the bound holds with room. Reducible: §4 gives $\lVert W\rVert^2\ge B_{\min}=\tfrac1{4\theta_0^2}$, hence $\theta\le\theta_0(n)$. The two cases are exhaustive. **Confirmed.**

### 7a. Einstein is load-bearing, confirmed, and used at three places

The block argues it at one: [L46](../findings/problem.md)'s $Q(W)=\lambda W$ needs $\mathrm{Ric}=\lambda g$. There are two more, neither named:

1. **The normalisation.** $\theta$ is scale-invariant, so a *single* Einstein space may be normalised to $\lambda=\tfrac12$ without loss. But the identity $\lVert W\rVert^2=\sum_a\lVert W_a\rVert^2+\sum_af(n_a)-f(n)$ needs the **same** $\lambda=\tfrac12$ on *every factor at once*, since $f(n_a)=c_{n_a}^2\binom{n_a}2$ is computed at that constant. Only the global Einstein condition supplies it (§7b). Rescale one factor and the identity fails.
2. **The vanishing criterion of §5.** $W_a=0\Rightarrow$ constant curvature is false without Einstein.
3. **No $n_a=1$.** $f$ has a pole at $m=1$; a circle factor is excluded only because its $\lambda$ is $0$, not $\tfrac12$.

So Einstein is not a hypothesis stated and unused, it is used three times, and two of those uses are unmarked.

### 7b. Unequal factor Einstein constants, confirmed, both directions

For a Riemannian product the Ricci tensor is the direct sum, $\mathrm{Ric}_M=\mathrm{Ric}_{M_1}\oplus\cdots\oplus\mathrm{Ric}_{M_k}$, with no mixed components (the same splitting of $\nabla$ that gave §2). Hence $\mathrm{Ric}_M=\lambda g$ **iff** $\mathrm{Ric}_{M_a}=\lambda g_a$ for every $a$ **with one and the same $\lambda$**. So a reducible symmetric space whose factors carry different Einstein constants is not Einstein. **Confirmed.**

**The witness this excludes, and what it does not do.** The natural candidate is $\mathbb{CP}^2\times T^{n-4}$: a compact symmetric space of dimension $n$ whose Weyl operator is precisely the record's padded $W_{\mathbb{CP}^2}$, with $\theta=\sqrt{3/2}$ at every $n$ and $\ker W\ne0$. It is excluded by exactly this clause, $\mathbb{CP}^2$ has $\lambda>0$ and $T^{n-4}$ has $\lambda=0$, so the product is not Einstein. **But it would not have violated the Theorem anyway**: at $n\ge12$, $\sqrt{3/2}<\theta_0(n)$. So the padded-object trap is checked and is empty here. The Einstein clause earns its keep at the *equality* case and at the identity of §7a, not at the inequality.

### 7c. The quantifier is STILL too wide, the finding

Discrepancy protocol, all three cleared.

1. **Located.** [problem.md](../findings/problem.md) line 261: "every compact **Einstein** symmetric space of dimension $n$ satisfies $\theta\le\theta_0(n)$".
2. **Exhibited, in closed form.** The round $S^{12}$. It is compact, symmetric, Einstein, of dimension $12$, and therefore inside the quantifier. In the $\lambda=\tfrac12$ normalisation $R=cI$ with $c=\tfrac1{2\cdot11}$, so $W=R-cI=0$, $\lVert W\rVert=0$, and $\theta=P(W)/\lVert W\rVert^3$ is $0/0$. The conclusion "$\theta\le\theta_0(12)$" is not false, it is **not a statement**. The flat torus $T^{12}$ does the same at $\lambda=0$, and $\mathbb{RP}^{12}$ at $\lambda=\tfrac12$. The record concedes the point twice, at [L47](../findings/problem.md), "at $S^4$, $R=\tfrac16I$ on all of $\Lambda^2$, so $\lVert W\rVert^2=0<\tfrac16$ and $\theta$ is $0/0$", and "**which is why $W\ne0$ is a hypothesis and not a remark**", and at [L46](../findings/problem.md)'s inventory, "**the conclusion needs $W\ne0$ and neither the block nor the canon says so**".
3. **Argued the opposite.** *Could $\theta:=0$ be the convention at $W=0$?* No: [conventions.md](../findings/conventions.md) defines $\theta=P(W)/\lVert W\rVert^3$ with no extension, and the record twice states the value is $0/0$ rather than $0$. *Could "Einstein symmetric space" be read as tacitly carrying L47's $W\ne0$?* The Theorem is stated inside a blockquote as a self-contained statement, quoted by consumers as such, and names its two repaired hypotheses explicitly, a statement that goes to the trouble of writing "with both factors of constant curvature and equal Einstein constant" is being read literally. *Could the flat torus be excluded by "Einstein"?* No: $\mathrm{Ric}=0=0\cdot g$ is Einstein on the record's own reading, which is why [L46](../findings/problem.md) had to book $\lambda\ne0$ separately.

**Finding.** A **third** hypothesis is missing: $W\ne0$, equivalently (given compact + symmetric + Einstein) $\lambda\ne0$ together with "not of constant curvature". The residue the argument does not cover is exactly $\{$flat$\}\cup\{S^n,\mathbb{RP}^n\}$ and is characterised by $W=0$. **No value changes** (the repair is one clause) but the claim as it stands quantifies over objects for which its conclusion is undefined, which is the precise defect [r462](../reviews/REVIEW_r462.md) and [r463](../reviews/REVIEW_r463.md) were reported to have closed.

## 8. The equality case, the uniqueness clause is over-strong

Discrepancy protocol, all three cleared.

1. **Located.** [problem.md](../findings/problem.md) line 261, "with equality exactly at $S^{n/2}\times S^{n/2}$ with both factors of constant curvature and equal Einstein constant".
2. **Exhibited, in closed form.** At $n=12$, take $\mathbb{RP}^6\times\mathbb{RP}^6$, both factors of constant curvature normalised to $\lambda=\tfrac12$. It is compact, symmetric (each $\mathbb{RP}^6=O(7)/(O(6)\times O(1))$ is a rank-one compact symmetric space), Einstein with equal factor constants, of dimension $12$, with both factors of constant curvature. Its curvature operator at every point is that of $S^6\times S^6$, so $W_a=0$ for both factors and $\lVert W\rVert^2=B=\tfrac9{55}$, giving $\theta^2=\tfrac{55}{36}=\theta_0(12)^2$, **equality**. It is not $S^6\times S^6$: its fundamental group is $\mathbb Z_2\times\mathbb Z_2$. The same holds for $S^6\times\mathbb{RP}^6$ and for every quotient of $S^6\times S^6$ by a finite group acting freely by isometries.
3. **Argued the opposite.** *Is the clause meant about the algebraic curvature operator rather than the space?* That is the reading under which it is true, and it is the reading the chief consumer takes, [results.md](../results.md) line 567 concludes "$W$ is the Weyl tensor of a two-factor sphere product $S^p\times S^q$", a statement about $W$. Since $\theta$ is a pointwise algebraic invariant, locally isometric spaces are one point of $\mathcal W_n$ and the consumer is unaffected. *Is the quotient excluded by "symmetric"?* No, $\mathbb{RP}^m$ is symmetric, and the record says so at [graded-half.md](../findings/graded-half.md) line 120 and at [L47](../findings/problem.md). *By "constant curvature"?* No, $\mathbb{RP}^m$ has it. Nothing in the stated hypotheses excludes it.

**Finding.** The clause is a **uniqueness assertion about spaces** and is false at that level; it is true up to local isometry, or equivalently of the universal cover. The repair correctly identified that "sphere" does not fix the *metric* and added "constant curvature"; it did not notice that "sphere" also does not fix the *global form*. **No value changes.**

**What the equality case does get right.** The three conditions it needs are each necessary and jointly sufficient: (i) $\lVert W_a\rVert^2=0$ for every $a$, by §5; (ii) the split balanced, by the Jensen equality case in §4; (iii) $k=2$, by strict monotonicity in $k$ in §4. And $n$ even is necessary for (ii) to be attainable, at odd $n$ the balanced split does not exist over the integers and the bound is strict, which is why "when $n$ is even" is correctly placed and why there is no equality case at odd $n$.

### 8a. The odd-$n$ figures, checked by hand

At $n=13$ the best two-factor split is $6+7$ (convexity on integers with a fixed sum puts the minimum at the most balanced pair):
$$\sum f=f(6)+f(7)=\frac6{40}+\frac7{48}=\frac{36}{240}+\frac{35}{240}=\frac{71}{240},\qquad f(13)=\frac{13}{96},$$
$$B=\frac{71}{240}-\frac{13}{96}=\frac{142}{480}-\frac{65}{480}=\frac{77}{480},\qquad \theta^2=\frac1{4B}=\frac{480}{308}=\frac{120}{77}.\ \checkmark$$
$$\theta_0(13)^2=\frac{2\cdot12\cdot11}{169}=\frac{264}{169}.\ \checkmark$$
Strictness: $120\cdot169=20280<20328=77\cdot264$, so $\theta^2<\theta_0^2$. **Both figures confirmed, and the inequality is strict.**

**Two independent corroborations on the record.** [conventions.md](../findings/conventions.md) gives $\Theta_n^2=\tfrac{2(n-1)(n-3)}{(n+1)(n-2)}$ at odd $n$, which at $n=13$ is $\tfrac{2\cdot12\cdot10}{14\cdot11}=\tfrac{120}{77}$; and [problem.md](../findings/problem.md) line 527 gives $\theta_{7,6}^2=2\cdot\tfrac67\cdot\tfrac56\cdot\tfrac{12}{11}=\tfrac{120}{77}$ from Nienhaus Proposition 2.25. All three agree, and the value is $\Theta_{13}$, which is what [conventions.md](../findings/conventions.md) warns must not be conflated with $\theta_0$.

**Also checked: $k\ge3$ is genuinely excluded.** At $k=3$ balanced, $B_{\min}=\tfrac{3n}{8(n-3)}-\tfrac n{8(n-1)}=\tfrac{n^2}{4(n-1)(n-3)}$, and $\tfrac{n^2}{4(n-1)(n-3)}>\tfrac16\iff 6n^2>4n^2-16n+12\iff 2n^2+16n-12>0$, true at every $n\ge1$. So the consumer's "$k=2$" at [results.md](../results.md) line 567 is sound at every $n$, not only at $n=12$.

**And the consumer's arithmetic checks against $f$.** With both factors spheres, $\lVert W\rVert^2\le\tfrac16$ reads $\tfrac18\bigl(1+\tfrac1{p-1}+\tfrac1{q-1}-\tfrac1{n-1}\bigr)\le\tfrac16$, i.e. $\tfrac1{p-1}+\tfrac1{q-1}-\tfrac1{n-1}\le\tfrac13$, the consumer's condition exactly. At $p=5$, $q=n-5$: $\tfrac1{n-6}-\tfrac1{n-1}=\tfrac5{(n-6)(n-1)}\le\tfrac1{12}$ is $n^2-7n-54\ge0$, upper root $\tfrac{7+\sqrt{265}}2\approx11.64$, so $n\ge12$. Both of the consumer's figures reproduced.

## 9. The traps, answered by name

| trap | answer |
| --- | --- |
| $\ker W\ne0$ and padded objects | **Checked, and one half bites.** The padded $W_{\mathbb{CP}^2}$ is realised by $\mathbb{CP}^2\times T^{n-4}$, excluded by the Einstein clause (§7b), and would not have violated the bound at $n\ge12$ regardless. The *total* kernel $W=0$ is the live gap of §7c. |
| boundary of every stated range | $n=12$: $n^2-12n+8=8>0$, bound holds strictly. $n=11$: $-3<0$, condition reverses, correctly outside the quantifier. $n_a=2$: $f(2)=\tfrac14$, fine, $W_a\equiv0$. $n_a=1$: **$f$ has a pole**, excluded only by the unstated Einstein normalisation. $k=n/2$: $n-k>0$ holds, monotonicity valid. |
| smallest admissible dimension | $n=12$ checked above; and at $n=12$ the irreducible ceiling $\sqrt{3/2}$ is *strictly* below $\theta_0(12)=\sqrt{55/36}$, so equality can only come from the reducible side, as the Theorem says. |
| odd $n$ | §8a: figures reproduced, strictness confirmed, no equality case, and the value identified as $\Theta_{13}$ rather than $\theta_0(13)$, the conflation [conventions.md](../findings/conventions.md) records as having "regrew [L0](../findings/problem.md)'s refuted constant". |
| $k=1$ against $k\ge2$ | $k=1$ gives $B=0$ and is the irreducible case, handled by [L47](../findings/problem.md). The block never writes $k\ge2$; it is forced by "reducible" and the monotonicity in $k$ then selects $k=2$. Correct, one step implicit. |
| a claim proven on a subfamily and used in general | **Found, §5.** "$\lVert W_a\rVert^2$ vanishes exactly when that factor is a sphere" is proved for Einstein factors and stated with no hypothesis; $S^1\times S^{m-1}$ refutes the unrestricted form. Used only in the Einstein setting, so the argument is unaffected. Also: Jensen is proved over the reals and applied to integers, the safe direction, and the block correctly declines to claim attainment at odd $n$. |
| a hypothesis stated but never used | **None found.** *Einstein* is used three times (§7a); *compact* is used to exclude noncompact-type factors and to import [L47](../findings/problem.md)'s census; *symmetric* is used for the de Rham splitting into symmetric factors and again for L47; *$n\ge12$* is used exactly once, at §6. |
| a step using a hypothesis never stated | **Four found**, all in §1's table: the $\lambda=\tfrac12$ normalisation, the equality of the factor Einstein constants, $n_a\ge2$, and the fixed sum in Jensen. Three of the four are stated in [graded-half.md](../findings/graded-half.md)'s parallel copy and were lost in the compression into the canonical block. |
| a universal claim with no witness | **The equality case has one**: $S^6\times S^6$ at $n=12$, $\theta^2=\tfrac{55}{36}=\theta_0(12)^2$, exhibited in §6. The inequality is a genuine universal and is proved by exhausting the de Rham split into two cases. |
| an imported theorem whose hypotheses were never checked | **[L46](../findings/problem.md), the import here, carries four; two are unchecked.** §1's second table: *locally symmetric* ✓, *Einstein* ✓, *$\lambda\ne0$* ✗, *$W\ne0$* ✗. This is the same failure mode as the unital-algebra citation the brief recalls, the imported identity simply has no content at the objects the quantifier admits. |
| symbol collisions | **$B$**: [conventions.md](../findings/conventions.md) already tables three objects under the letter and flags the third as such; L48's scalar $B(n_1,\dots,n_k)$ is a **fourth**, and is tabled nowhere. **$k$**: the number of factors here, and a *factor dimension* in Nienhaus's $\theta_{k,l}$ eighteen lines below in the same file, [problem.md](../findings/problem.md) line 274, where the very same objects are under discussion, so the two readings are live together. **$f$**: checked across [findings/](../findings/) and [results.md](../results.md); every occurrence is this one function, no collision. **$c$**: L48 inherits [L46](../findings/problem.md)'s shift constant $c=\lambda/(n-1)$ silently, and [conventions.md](../findings/conventions.md) already records that it "collides with [L44](../findings/problem.md)'s pinned $\partial\Omega_0$ constant twenty lines up" in this same file. |

## 10. The repair's own summary

> **TWO HYPOTHESES WERE MISSING, AND NEITHER CHANGES A VALUE.**

**This is not a fair description of what changed, on two counts.**

- **The count is wrong.** A third hypothesis is missing ($W\ne0$) and it is the one the record has already booked twice elsewhere, at [L46](../findings/problem.md)'s inventory and at [L47](../findings/problem.md)'s "$W\ne0$ is a hypothesis and not a remark". A headline that states a count is making a completeness claim, and this one is refuted from inside the same file. A fourth, the over-strong "exactly at $S^{n/2}\times S^{n/2}$", is still open (§8).
- **"Neither changes a value" is true of the numbers and misleading about the claim.** Adding a hypothesis narrows a claim: the Theorem after the repair quantifies over a strictly smaller class (every non-Einstein reducible symmetric space left it, and with them $\mathbb{CP}^2\times T^{n-4}$ and its $\theta=\sqrt{3/2}$), and its equality set is strictly smaller (every non-round metric on a sphere product left it). The figures $\theta_0(n)$, $\tfrac{120}{77}$, $\tfrac{264}{169}$ are indeed untouched. But "neither changes a value" is the sentence a reader takes as "nothing of substance changed", and what changed is the strength of the Theorem in both of its clauses.

A fair summary would say what the Theorem now *is*: a bound over compact Einstein symmetric spaces with nonzero Weyl tensor, sharp at even $n$ and attained exactly on the local isometry class of the balanced round sphere product.

## 11. What would falsify each, and what I did to look

**They are different objects and take different falsifiers.**

**The lemma** (the decomposition, $B$, Jensen, and the reducible floor), would be falsified by:

- a product Einstein symmetric space with $\lVert W\rVert^2<\sum_a\lVert W_a\rVert^2+\sum_af(n_a)-f(n)$, i.e. an error in the block algebra;
- a partition with $k\ge2$, all $n_a\ge2$, $\sum n_a=n$, and $\sum_af(n_a)-f(n)<\tfrac{n^2}{8(n-1)(n-2)}$;
- $f$ failing to be convex somewhere in $[2,\infty)$, which would break the Jensen step.

*What I did.* I re-derived $B$ from scratch off §2's three blocks rather than checking the block's arithmetic, and the mixed-block term is what makes the $\sum_an_a^2$ dependence cancel, an error there would have shown up as a surviving $\sum n_a^2$. I cross-checked the resulting $\theta^2$ against Nienhaus's independent $\theta_{k,l}^2$ at $(6,6)$ and against $\Theta_{13}$ at $(7,6)$; all three agree exactly. I differentiated $f$ twice in closed form and checked the sign on the whole domain in use, and I differentiated $kf(n/k)$ in $k$. I checked $k=3$ separately in closed form rather than trusting monotonicity alone. **I found no falsifier, and the lemma's mathematics is correct.**

**The Theorem** would be falsified by a compact Einstein symmetric space of dimension $n\ge12$ with $\theta>\theta_0(n)$, or by a second isometry class attaining equality at even $n$, or by any equality at odd $n$.

*What I did.* I worked the de Rham split into its two exhaustive cases and checked that the irreducible ceiling $\sqrt{3/2}$ clears $\theta_0(n)$ with strict room at $n\ge12$, and that the reducible floor is exactly $\tfrac1{4\theta_0^2}$. I went after the record's own standing counterexample generator (the padded $W_{\mathbb{CP}^2}$), realised it as $\mathbb{CP}^2\times T^{n-4}$, and found it excluded twice over (not Einstein, and $\sqrt{3/2}<\theta_0(n)$ anyway). **I found no violation of the inequality.** I did find a second equality class, $\mathbb{RP}^{n/2}\times\mathbb{RP}^{n/2}$ (§8), and a residue of the quantifier on which the conclusion is undefined rather than true, $\{$flat$\}\cup\{S^n,\mathbb{RP}^n\}$ (§7c).

## Verdict

**HYPOTHESIS-DEBT.**

Every derivation in the block is correct, every figure in it is correct, and the closed form $B=\sum_af(n_a)-\tfrac n{8(n-1)}$ survives an independent rebuild. What is owed:

1. **The Theorem needs $W\ne0$** (equivalently $\lambda\ne0$ and not of constant curvature). Without it the quantifier admits $S^n$, $\mathbb{RP}^n$ and flat tori, where $\theta$ is $0/0$.
2. **The equality clause needs "up to local isometry"**, or must be stated of the curvature operator rather than the space. $\mathbb{RP}^{n/2}\times\mathbb{RP}^{n/2}$ attains $\theta_0(n)$ at even $n$.
3. **The canonical block owes four steps that [graded-half.md](../findings/graded-half.md)'s parallel copy states and the compression dropped**: the $\lambda=\tfrac12$ normalisation, the equality of the factor Einstein constants, $n_a\ge2$ (so $f$ is defined), and the fixed sum in Jensen. Each is one clause.
4. **[results.md](../results.md) line 172's "$\lVert W\rVert^2$ depends on the partition alone" is false as written** and should carry line 567's qualifier.
5. **$B$ is a fourth object under that letter and belongs in [conventions.md](../findings/conventions.md)**, which already tables three and flags the collision as live.

None of the five moves a number. All five narrow or correct a statement.
