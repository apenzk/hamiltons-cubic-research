# VERIFY_v184, Lemma L28, cold verification

Brief read cold, from [verification/BRIEF_L28.md](BRIEF_L28.md) plus [findings/nondegeneracy.md](../findings/nondegeneracy.md), [findings/second-order.md](../findings/second-order.md), [findings/algebra.md](../findings/algebra.md), [findings/bounds.md](../findings/bounds.md) and [findings/conventions.md](../findings/conventions.md). **No numerical work was done**, no script, no Sage, no Python, no numeric evaluation of any kind. Every arithmetic step below is a closed-form derivation carried out by hand and displayed in full. Log: [agent_logs/verify-L28-v184.log](../agent_logs/verify-L28-v184.log).

## Claim table

| # | claim | verdict |
|---|---|---|
| 1 | Ten complex summands, seven real classes, three conjugate pairs | **CONFIRMED (count)**, multiplicity-freeness is **IMPORTED, UNCHECKED** |
| 2 | The seven real dimensions sum to $\dim\mathcal W_{2m}=\frac{m(m+1)(2m+1)(2m-3)}3$ identically in $m$ | **PROVEN** |
| 3 | Each of the seven real dimensions is the right dimension | **PROVEN** (four of seven re-derived from scratch; see §3) |
| 4 | $\lambda_S=1-\frac{c_S+q_S^2}{4(m+1)}$, and $\lambda_S=\tfrac12\iff c_S+q_S^2=2(m+1)$ | **PROVEN** (given the formula; the formula itself is imported) |
| 5 | Every row's charge $c_S+q_S^2$ | **ALL SEVEN CONFIRMED**, the repaired column is correct |
| 6 | Only $4(m-1)$ meets $2(m+1)$, at $m=3$ alone | **PROVEN** |
| 7 | The $m=3$ absence, on the stated Young-diagram grounds | **PROVEN**, and the stated reason is the right one |
| 8 | $\operatorname{tr}L_e=0$ identically in $m$ | **PROVEN** |
| 9 | $\operatorname{tr}(L_e^2)=\frac{3m(m-1)(4m-1)}{4(m+1)}=\kappa_F(2m)\lVert e\rVert^2$ | **PROVEN** |
| 10 | Fox's Theorem 1.3 applies to this algebra | **HYPOTHESIS-DEBT**, hypotheses not checked against the object on the record |
| 11 | The trace solve returns $\frac{m+2}{2(m+1)}$ on the $\mathfrak{su}(m)$ row | **PROVEN** |
| 12 | "Each remaining class is recovered uniquely the same way" | **PROVEN for four of five; FAILS for $V_{(1,1);(1,1)}$ at $m=3$** (degenerate coefficient) |
| 13 | "So $\lambda_{\max}$ rests on more than the charge formula" | **OVERSTATED**, the solve consumes five charge-formula values as inputs |
| 14 | Closed form for $e$: exact tracelessness | **PROVEN** |
| 15 | Closed form for $e$: $\lVert e\rVert^2=1/\theta^2$ | **PROVEN** |
| 16 | Closed form for $e$: membership in $\mathcal W_{2m}$ (Bianchi, Ricci-flat) | **HYPOTHESIS-DEBT**, asserted, proof off-file |
| 17 | Slack against [L70](../findings/bounds.md) exactly $2(m-2)\theta$, vanishing only at $m=2$ | **PROVEN** |
| 20 | "Two identities check the whole list" | **OVERSTATED**, they are polynomial identities in $m$ and pass at $m=2$, where the list is refuted |
| 21 | [second-order.md](../findings/second-order.md)'s third route, "exact ... at $m=3\ldots9$" | **RANGE ERROR**, the weight degenerates to the adjoint's at $m=3$ |
| 22 | $\kappa_F(n)=\frac{(2n-1)(n-1)}4$ attributed to Fox's Theorem 1.3 | **MISATTRIBUTED**, Fox's Remark 1.4 leaves $\kappa$ uncomputed for $\dim V>4$ |
| 23 | The unital-algebra trap | **DOES NOT FIRE**, Theorem 1.3 assumes only $\dim V\ge4$; Fox writes that an exact algebra *is* nonunital |
| 24 | **Overall** | **`HYPOTHESIS-DEBT`**, all arithmetic PROVEN; H3, H4, H7/H8 undischarged |
| 18 | The landscape line at [results.md](../results.md) line 142 | **INCONSISTENT AS WRITTEN** with the table's orbit row |
| 19 | "The same table stands at [second-order.md](../findings/second-order.md)" | **TABLE AGREES; the surrounding reason for the $m=3$ absence DISAGREES** |

**One-line summary.** Every arithmetic claim in the block checks out exactly (all seven charges, the dimension identity, both Fox identities and the trace solve) so the repaired column is sound and the conclusion $E(\tfrac12)=$ orbit at every $m\ge3$ stands on its own arithmetic; what does not stand is the block's account of its own independence, the landscape one-liner, and the unchecked import of Fox's hypotheses.

## 0. Conventions, fixed once

Quoted from [findings/conventions.md](../findings/conventions.md):

> | $\mathcal W_n$ | the space of algebraic Weyl curvature operators on $\mathbb R^n$ |
> | $\dim\mathcal W_n$ | $\frac{n(n-3)(n+1)(n+2)}{12}$, $10$ at $n=4$, $84$ at $n=6$, $1638$ at $n=12$ |
> | $Q(W)$ | Hamilton's quadratic map $W^2+W^\#$, sending $\mathcal W_n$ to itself |
> | $P(W)$ | the cubic form $\langle W,Q(W)\rangle$ |
> | $\theta$ | $P(W)/\lVert W\rVert^3$; at a critical point, $Q(W)=\theta W$ |

Quoted from [findings/second-order.md](../findings/second-order.md), the charge convention this block runs on:

> $$\lambda_S=1-\frac{c_S+q_S^2}{4(m+1)},\qquad c_S=\sum_i\nu_i(\nu_i+m+1-2i),\quad q_S=\sum_i\nu_i,$$
> with $\nu$ the summand's highest weight as a $GL(m)$ weight.

Quoted from [findings/algebra.md](../findings/algebra.md):

> **Fox's Theorem 1.3** gives, for this algebra, $\operatorname{tr}L(x)=0$ and $\operatorname{tr}\big(L(x)L(y)\big)=\kappa_F\langle x,y\rangle$

**First consistency note, resolved.** The conventions file gives $\dim\mathcal W_n=\frac{n(n-3)(n+1)(n+2)}{12}$; the block gives $\dim\mathcal W_{2m}=\frac{m(m+1)(2m+1)(2m-3)}{3}$. Substituting $n=2m$,
$$\frac{2m(2m-3)(2m+1)(2m+2)}{12}=\frac{2m(2m-3)(2m+1)\cdot2(m+1)}{12}=\frac{m(m+1)(2m+1)(2m-3)}{3},$$
so the two are the same polynomial. **No symbol collision here.**

**Second, the normalisation of $e$, a real collision, and it is handled correctly.** [conventions.md](../findings/conventions.md) reserves $\theta$ for $P(W)/\lVert W\rVert^3$ with $\lVert W\rVert=1$ at a critical point, whence $Q(W)=\theta W$ and $L_W W=\theta W$. The block's table needs $L_e=1$ on $\langle W\rangle$, which requires the **idempotent** normalisation $e=W/\theta$, $Q(e)=e$. The block says exactly that ("$Q(e)=e$ gives the first"), and [second-order.md](../findings/second-order.md) writes $e=W/\theta$ explicitly. Consequently $\lVert e\rVert^2=1/\theta^2\ne1$, and every appearance of $\lVert e\rVert^2$ below is that. This is the one place where a reader could take $e$ for a unit vector and get $\kappa_F(2m)$ instead of $\kappa_F(2m)/\theta^2$; **the record is internally consistent on it.**

## Hypothesis inventory

| # | hypothesis | stated? | used? | discharged? |
|---|---|---|---|---|
| H1 | $m\ge3$ | stated in the lemma | used (the $m=3$ absence; the $\lambda_{\max}>\tfrac12$ conclusion) | boundary $m=3$ checked in §5; $m=2$ excluded and genuinely different, [second-order.md](../findings/second-order.md) records $\lambda_{\max}=\tfrac12$ at $m=2$ against the formula's $\tfrac23$ |
| H2 | $e$ is $U(m)$-invariant | stated | used (Schur $\Rightarrow$ scalar per summand) | true by construction: $e$ is a combination of $U(m)$-isotypic projectors |
| H3 | The $U(m)$-decomposition of $\mathrm{Weyl}_{2m}\otimes\mathbb C$ is multiplicity-free | stated | used essentially, it is what upgrades "$E(\tfrac12)\supseteq$ orbit" to "$=$" | **NOT discharged on the record.** Cited to [Howe–Tan–Willenbring §2.3.1](https://arxiv.org/abs/math/0311159); no branching computation on file. See §1 |
| H4 | $\lambda_S=1-\frac{c_S+q_S^2}{4(m+1)}$ | stated at [second-order.md](../findings/second-order.md) | used for five of seven rows | **NOT discharged on the record**: derived there from $\sharp$ closed forms "exact in GF(p) at $m=3\ldots20$", i.e. checked, not proved. See §4 |
| H5 | Fox's Theorem 1.3 applies to $(\mathrm{MC}(V),*)$ | stated | used for both check identities | **NOT discharged**: hypotheses never listed against the object. See §7 |
| H6 | $\lVert e\rVert^2=1/\theta^2$ with $\theta^2=\frac{(m+1)(2m-1)}{3m(m-1)}$ | stated | used in the $\kappa_F$ identity | **discharged here**, §8, from the closed form for $e$ |
| H7 | $e\in\mathcal W_{2m}$ (Bianchi, Ricci-flat) | asserted at [second-order.md](../findings/second-order.md) | used everywhere implicitly, a non-Weyl $e$ makes the whole table a statement about the wrong space | **NOT discharged on the record**: "proved symbolically for all $m$", proof off-file |
| H8 | $L_e$ preserves $\mathrm{Weyl}_{2m}$ | asserted at [second-order.md](../findings/second-order.md), "to $10^{-15}$" | used | **NOT discharged**: numerical, and explicitly contrasted there with the individual $\sharp$ pieces, which do **not** preserve it |

**A hypothesis stated but never used:** none found. **A step using a hypothesis never stated:** one, see §12, where the trace solve silently requires the *dimension* column to be correct, a fact nowhere listed as an input to that solve.

## 1. The decomposition: ten complex summands, seven real classes, three conjugate pairs

**The count is internally consistent.** Reading the block's own seven rows and counting the ones marked "$\oplus$ dual" / "$\oplus\text{conj}$" as two complex summands each:

| row | complex summands |
|---|---|
| $(0^m)$ | 1 |
| $(1,0^{m-2},-1)$, $\mathfrak{su}(m)$ adjoint | 1 |
| $(1,1,0^{m-2})\oplus$ dual | 2 |
| $(1,1,0^{m-4},-1,-1)$ | 1 |
| $(2,1,0^{m-3},-1)\oplus$ dual | 2 |
| $(2,0^{m-2},-2)$ | 1 |
| $(2,2,0^{m-2})\oplus$ dual | 2 |

Total $1+1+2+1+2+1+2=10$, with exactly three pairs. **CONFIRMED.**

**Self-conjugacy of the four singletons is checkable and checks.** A $GL(m)$ summand $V_\nu$ is self-conjugate iff $\nu$ is fixed by $\nu\mapsto(-\nu_m,\dots,-\nu_1)$. Applying that map: $(0^m)\mapsto(0^m)$; $(1,0^{m-2},-1)\mapsto(1,0^{m-2},-1)$; $(1,1,0^{m-4},-1,-1)\mapsto(1,1,0^{m-4},-1,-1)$; $(2,0^{m-2},-2)\mapsto(2,0^{m-2},-2)$. All four fixed. And the three paired rows are **not** fixed, $(1,1,0^{m-2})\mapsto(0^{m-2},-1,-1)$, $(2,1,0^{m-3},-1)\mapsto(1,0^{m-3},-1,-2)$, $(2,2,0^{m-2})\mapsto(0^{m-2},-2,-2)$, so they genuinely pair. **The "three of them conjugate pairs" is CONFIRMED and is not an assertion the reader has to take.**

**Multiplicity-freeness is IMPORTED and UNCHECKED.** The block says only "the $GL_m\subset O_{2m}$ branching rule at $\lambda=(2,2)$" and gives no rule, no reference, and no computation. [second-order.md](../findings/second-order.md) supplies the reference, [Howe–Tan–Willenbring §2.3.1](https://arxiv.org/abs/math/0311159), "all multiplicity one for $m\ge4$", plus a cross-check against [Tricerri–Vanhecke (1981)](https://www.ams.org/journals/tran/1981-267-02/S0002-9947-1981-0626479-0/) "once the three Ricci-and-scalar modules are removed". **No branching computation is on file in either place.** This matters more than a missing citation usually would, because multiplicity-freeness is exactly what carries the block's *equals* rather than *contains*: "since multiplicity-freeness makes $E(\tfrac12)$ a sum of whole summands". Without it, a repeated summand could contribute a $\tfrac12$-eigenvector outside the orbit.

**What the record does have instead is a strong consequence.** The dimension identity of §2 is a nontrivial polynomial constraint the seven claimed dimensions satisfy exactly; a decomposition missing a summand, or carrying one twice, would generically fail it. That is real evidence and I record it as such. **It is not a proof of multiplicity-freeness**, since it constrains only the total.

**Finding.** `HYPOTHESIS-DEBT` on H3: *the multiplicity-freeness of $\mathrm{Weyl}_{2m}\otimes\mathbb C$ as a $U(m)$-module, and the identification of the ten summands, have no derivation on the record; they rest on an uncited (in the block) and unverified (in either file) reading of a branching rule.*

## 2. The dimension sum, as a polynomial identity in $m$

I derive it in full rather than evaluating it.

Two rows pair off first. The $V_{(1,1);(1,1)}$ and $V_{(2);(2)}$ dimensions combine as
$$\frac{m^2(m+1)(m-3)}4+\frac{m^2(m-1)(m+3)}4=\frac{m^2}4\big[(m^2-2m-3)+(m^2+2m-3)\big]=\frac{m^2(2m^2-6)}4=\frac{m^2(m^2-3)}2 .$$

The two remaining large rows combine as
$$\frac{2m^2(m^2-4)}3+\frac{m^2(m^2-1)}6=\frac{4m^2(m^2-4)+m^2(m^2-1)}6=\frac{m^2(4m^2-16+m^2-1)}6=\frac{m^2(5m^2-17)}6 .$$

The three small rows give $1+(m^2-1)+m(m-1)=2m^2-m$. Summing over the common denominator $6$:
$$6(2m^2-m)+3m^2(m^2-3)+m^2(5m^2-17)=12m^2-6m+3m^4-9m^2+5m^4-17m^2=8m^4-14m^2-6m,$$
so the total is
$$\frac{8m^4-14m^2-6m}6=\frac{2m(4m^3-7m-3)}6=\frac{m(4m^3-7m-3)}3 .$$

And the target factors the same way:
$$(m+1)(2m+1)=2m^2+3m+1,\qquad (2m^2+3m+1)(2m-3)=4m^3+6m^2+2m-6m^2-9m-3=4m^3-7m-3 .$$

$$\boxed{\ \sum_{S}\dim_{\mathbb R}S=\frac{m(m+1)(2m+1)(2m-3)}3=\dim\mathcal W_{2m}\ }$$

**identically in $m$, as a polynomial identity. PROVEN.** Note it is an identity in $m$ with no restriction, so it holds at $m=3$ too, where the $V_{(1,1);(1,1)}$ term is $0$, consistent with the absence, and I return to that in §5.

## 3. The seven dimensions individually, re-derived

The block asserts the dimension column. Four of the seven are re-derivable from first principles without any branching rule, and I do so, because the trace solve of §12 consumes this column as an input and the block never says so.

- **$V_{(1,1);(1,1)}$.** $\Lambda^2E\otimes\Lambda^2E^*$ has dimension $\binom m2^2$ and decomposes as $V_{(1,1);(1,1)}\oplus V_{(1);(1)}\oplus\mathbb C$ (the two contractions). Hence
$$\dim V_{(1,1);(1,1)}=\frac{m^2(m-1)^2}4-(m^2-1)-1=\frac{m^2(m-1)^2}4-m^2=\frac{m^2\big[(m-1)^2-4\big]}4=\frac{m^2(m-3)(m+1)}4 .$$
**Matches the table exactly.**
- **$V_{(2);(2)}$.** The same argument on $\mathrm{Sym}^2E\otimes\mathrm{Sym}^2E^*$:
$$\frac{m^2(m+1)^2}4-m^2=\frac{m^2\big[(m+1)^2-4\big]}4=\frac{m^2(m-1)(m+3)}4 .$$
**Matches.**
- **$V_{(2,2)}\oplus$ dual.** The hook-content formula on $\lambda=(2,2)$ (cells with contents $0,1,-1,0$ and hooks $3,2,2,1$), gives $\dim V_{(2,2)}=\frac{m(m+1)(m-1)m}{12}=\frac{m^2(m^2-1)}{12}$, doubled to $\frac{m^2(m^2-1)}6$. **Matches.**
- **$V_{(2,1);(1)}\oplus$ dual.** $\dim V_{(2,1)}=\frac{m(m+1)(m-1)}3$ by hook-content, and $V_{(2,1)}\otimes E^*=V_{(2,1);(1)}\oplus V_{(2)}\oplus V_{(1,1)}$, so
$$\dim V_{(2,1);(1)}=\frac{m^2(m^2-1)}3-\frac{m(m+1)}2-\frac{m(m-1)}2=\frac{m^2(m^2-1)}3-m^2=\frac{m^2(m^2-4)}3,$$
doubled to $\frac{2m^2(m^2-4)}3$. **Matches.**

The remaining three ($1$, $m^2-1$, $m(m-1)=2\binom m2$) are immediate. **All seven dimensions PROVEN.** This is a genuinely independent check on the table's second column, and it passes.

## 4. The eigenvalue formula and every row's charge, the repaired column, checked directly

The brief warns that this block already carries one repaired arithmetic error in this column. I compute all seven charges from the convention quoted in §0, **from the weights, not from the block's values**.

Write $c(\nu)=\sum_i\nu_i(\nu_i+m+1-2i)$ and $q(\nu)=\sum_i\nu_i$. The two positions that recur are $i=1$, contributing $\nu_1(\nu_1+m-1)$; $i=2$, contributing $\nu_2(\nu_2+m-3)$; $i=m-1$, contributing $\nu_{m-1}(\nu_{m-1}-m+2)$; and $i=m$, contributing $\nu_m(\nu_m-m+1)$.

| row | $\nu$ | $c_S$ | $q_S$ | $c_S+q_S^2$ | block says |
|---|---|---|---|---|---|
| 1 | $(0^m)$ | $0$ | $0$ | $0$ | $0$ ✓ |
| 2 | $(1,0^{m-2},-1)$ | $1\cdot m+(-1)(-1-m+1)=m+m=2m$ | $0$ | $2m$ | $2m$ ✓ |
| 3 | $(1,1,0^{m-2})$ | $1\cdot m+1\cdot(m-2)=2m-2$ | $2$ | $2m-2+4=2(m+1)$ | $2(m+1)$ ✓ |
| 4 | $(1,1,0^{m-4},-1,-1)$ | $m+(m-2)+(-1)(-1-m+2)+(-1)(-1-m+1)=m+(m-2)+(m-2)+m=4m-4$ | $0$ | $4(m-1)$ | $4(m-1)$ ✓ |
| 5 | $(2,1,0^{m-3},-1)$ | $2(2+m-1)+1(1+m-3)+(-1)(-1-m+1)=2(m+1)+(m-2)+m=4m$ | $2$ | $4m+4=4(m+1)$ | $4(m+1)$ ✓ |
| 6 | $(2,0^{m-2},-2)$ | $2(m+1)+(-2)(-2-m+1)=2(m+1)+2(m+1)=4(m+1)$ | $0$ | $4(m+1)$ | $4(m+1)$ ✓ |
| 7 | $(2,2,0^{m-2})$ | $2(m+1)+2(2+m-3)=2(m+1)+2(m-1)=4m$ | $4$ | $4m+16=4(m+4)$ | $4(m+4)$ ✓ |

**ALL SEVEN CHARGES CONFIRMED.** The repaired column is correct. And each feeds through to the stated $L_e$ value:

$$\lambda_2=1-\frac{2m}{4(m+1)}=\frac{2(m+1)-m}{2(m+1)}=\frac{m+2}{2(m+1)},\qquad \lambda_3=1-\frac{2(m+1)}{4(m+1)}=\tfrac12,$$
$$\lambda_4=1-\frac{m-1}{m+1}=\frac2{m+1},\qquad \lambda_5=\lambda_6=1-1=0,\qquad \lambda_7=1-\frac{m+4}{m+1}=-\frac3{m+1}.$$

**The third column of the table is therefore an exact consequence of the fourth, in all seven rows.**

**The $\tfrac12$ criterion.** $\lambda_S=\tfrac12\iff\frac{c_S+q_S^2}{4(m+1)}=\tfrac12\iff c_S+q_S^2=2(m+1)$. **PROVEN**, trivially, and the equivalence is unconditional (no division by anything that vanishes, since $m+1>0$).

**Which rows can meet $2(m+1)$.** Solving each row's charge against it:

| row | equation | solution |
|---|---|---|
| 1 | $0=2(m+1)$ | $m=-1$, out of range |
| 2 | $2m=2(m+1)$ | no solution |
| 3 | $2(m+1)=2(m+1)$ | **identically, every $m$** |
| 4 | $4(m-1)=2(m+1)\Rightarrow 2m=6$ | $m=3$ |
| 5, 6 | $4(m+1)=2(m+1)$ | $m=-1$, out of range |
| 7 | $4(m+4)=2(m+1)\Rightarrow 2m=-14$ | $m=-7$, out of range |

**PROVEN: only the orbit row meets it identically, and among the rest only $4(m-1)$ meets it at all, at $m=3$ alone.** No other row comes near it at any $m\ge3$.

**And $\lambda_{\max}$ is on row 2.** Comparing $\frac{m+2}{2(m+1)}$ with the only other positive off-line value $\frac2{m+1}=\frac4{2(m+1)}$: the first exceeds the second iff $m+2>4$, i.e. $m>2$, **true at every $m\ge3$ and false at $m=2$.** So $\lambda_{\max}(L_e|_{W^\perp})=\frac{m+2}{2(m+1)}=\tfrac12+\frac1{2(m+1)}>\tfrac12$ throughout the stated range. **CONFIRMED.**

**H4 is not discharged.** The formula $\lambda_S=1-\frac{c_S+q_S^2}{4(m+1)}$ itself is imported from [second-order.md](../findings/second-order.md), where it is derived from the $\sharp$ closed forms whose status is "exact in GF(p) at $m=3\ldots20$", checked at twenty values, not proved for all $m$. Everything in this section is *conditional on that formula*. The block's own hedge ("the charge formula is where this block's one arithmetic error stood") acknowledges the risk; it does not remove the debt.

**A symbol note.** $c_S$ and $q_S$ are **not in [conventions.md](../findings/conventions.md)**, while the bare letters $c$ and $q$ are both tabled there as live collisions, $c$ against [L44](../findings/problem.md)'s pinned $\partial\Omega_0$ constant and against the scalar part in $R_I,R_{\mathrm{ric}_0},R_W$, and $q$ against the Weitzenböck operator and the $W_4(q,r)$ parameter in [stratum-two-negative.md](../findings/stratum-two-negative.md). The subscript disambiguates in practice and I found no place where the wrong sense is read, but by that file's own rule (*"Where a block needs a convention that is not here, it is added here and quoted there"*), these two belong in it.

## 5. The $m=3$ absence, on its own terms

**The claim.** $(1,1,0^{m-4},-1,-1)$ carries $4(m-1)$, meeting $2(m+1)$ at $m=3$ alone, and the summand is *absent* there because "it needs four rows of a Young diagram against the $m=3$ available", with the vanishing of $\frac{m^2(m+1)(m-3)}4$ recorded as *agreement* rather than as the reason.

**The absence is right, and so is the stated reason.** The summand is the rational $GL(m)$-irreducible $V_{\mu;\nu}$ with $\mu=\nu=(1,1)$. Two equivalent readings of the requirement, both giving $m\ge4$:

1. **By the weight.** A $GL(m)$ weight has exactly $m$ coordinates. The weight $\varepsilon_1+\varepsilon_2-\varepsilon_{m-1}-\varepsilon_m$ requires the four indices $1,2,m-1,m$ to be **distinct**, i.e. $m\ge4$. At $m=3$ the indices collide ($2=m-1$) and the expression collapses to $\varepsilon_1+\varepsilon_2-\varepsilon_2-\varepsilon_3=\varepsilon_1-\varepsilon_3$, which is the *adjoint* highest weight, row 2, and not a fourth-row weight at all.
2. **By the standard nonvanishing condition for rational irreducibles.** $V_{\mu;\nu}\ne0$ iff $\ell(\mu)+\ell(\nu)\le m$. Here $\ell(\mu)=\ell(\nu)=2$, so $m\ge4$. This is exactly "four rows against the available $m$", the four rows being the two of $\mu$ plus the two of $\nu$.

**PROVEN, and the block's epistemic ordering is correct.** The vanishing of the dimension polynomial at $m=3$ is a consequence, not a cause: the same polynomial is *negative* at $m=2$, giving $-3$, which no dimension can be. So the dimension formula's analytic continuation has no independent authority below $m=4$, and the block is right to refuse to lean on it. **This is the strongest single point in the block.**

**And the consequence.** At $m=3$ the decomposition has **nine** complex summands and **six** real classes, whose $L_e$ values are $1,\tfrac58,\tfrac12,0,0,-\tfrac34$. Exactly one equals $\tfrac12$, the orbit row, of real dimension $m(m-1)=6$. **So $E(\tfrac12)$ is the orbit tangent at $m=3$, the one place the argument could have failed.** The smallest admissible dimension is settled.

**A gap in the block's own bookkeeping, minor.** The block's headline says "**ten** summands" with no qualification, and only the table row carries "**absent at $m=3$**". [second-order.md](../findings/second-order.md) states it properly, "ten summands, nine at $m=3$". The nondegeneracy.md headline should carry the same rider.

**And the "equals rather than contains" step reuses H3 a second time.** The identification of the row-3 summand *with* the orbit tangent is itself a multiplicity argument: the orbit tangent is $\mathrm{ad}(\mathfrak{so}(2m))\cdot W\cong\mathfrak{so}(2m)/\mathfrak u(m)\cong\Lambda^2E\oplus\Lambda^2\bar E$ as a $U(m)$-module, of real dimension $m(2m-1)-m^2=m(m-1)$, and it *is* row 3 only because $\mathcal W_{2m}$ contains just one copy of that module. **Multiplicity-freeness is load-bearing in two distinct places, and is discharged in neither.**

## 6. Fox's Theorem 1.3, the import, checked at source

The brief names this as the trap that killed a previous route: *a cited theorem assumes a **unital** algebra and $\mathcal W_n$ has no unit.* I read the theorem in the source PDF text, [references/fox-2019-nonassociative-curvature-algebra/](https://arxiv.org/abs/1901.04012), lines 152–195, and quote it verbatim:

> A commutative algebra $(A,\circ)$ is **exact** (called harmonic in [29]) if its multiplication endomorphisms $L_\circ:A\to\mathrm{End}(A)$ defined by $L_\circ(x)=x\circ y$ satisfy $\operatorname{tr}L_\circ(x)=0$ for all $x\in A$. **Note that an exact algebra is nonunital.** A commutative algebra $(A,\circ)$ is **Killing metrized**, if the Killing type trace form $\tau_\circ(x,y)=\operatorname{tr}L_\circ(x)L_\circ(y)$ is nondegenerate and invariant.

> **Theorem 1.3.** Let $(V,h)$ be a Euclidean vector space of **dimension at least 4**. The algebra $(\mathrm{MC}_W(V^*),*)$ is exact and Killing metrized. Moreover: (1) The Killing form $\tau_*(X,Y)=\operatorname{tr}L_*(X)L_*(Y)$ is a nonzero multiple of $\langle\cdot,\cdot\rangle$. (2) If $\dim V>4$, then $(\mathrm{MC}_W(V^*),*)$ is simple.

**The unitality trap does not fire here, and the reason is the opposite of the worry.** Theorem 1.3's *only* hypothesis is $\dim V\ge4$. Unitality is not assumed anywhere; on the contrary, Fox states that an exact algebra **is** nonunital, so the theorem's own conclusion *entails* that $\mathrm{MC}_W(V^*)$ has no unit. **The absence of a unit is a consequence of the cited theorem, not an obstruction to citing it.** `NO DEFECT` on the named trap.

**The hypothesis is met.** $\dim V=n=2m\ge6$ at every $m\ge3$, so $\dim V\ge4$ holds with room, and clause (2) (simplicity), holds as well since $\dim V>4$.

**Two further hypotheses the block does not list, both of which hold.**

- *The theorem is about $\mathrm{MC}_W(V^*)$, the Weyl tensors, not $\mathrm{MC}(V^*)$.* The object here is $\mathcal W_{2m}$, which is exactly $\mathrm{MC}_W$. ✓, but only if $e\in\mathcal W_{2m}$, which is **H7, undischarged**; see §8.
- *The theorem is about $L_*$, and this record uses $F_u$.* [algebra.md](../findings/algebra.md) records the identification with a sign, $X*Y=-F_X(Y)$, "the sign being his curvature convention". **The sign is harmless for both identities used**: $\operatorname{tr}L_*(x)=-\operatorname{tr}F_x$ vanishes iff $\operatorname{tr}F_x$ does, and $\operatorname{tr}(L_*L_*)=\operatorname{tr}(F F)$ with the sign squared away. ✓

**What Fox's theorem does NOT give, and the block writes as though it does.** The block says: *"Fox's Theorem 1.3, at [algebra.md](../findings/algebra.md), gives $\operatorname{tr}L(x)=0$ and $\operatorname{tr}(L(x)L(y))=\kappa_F\langle x,y\rangle$ with $\kappa_F(n)=\frac{(2n-1)(n-1)}4$."* Fox's Remark 1.4, verbatim:

> **Remark 1.4.** When $\dim V>4$, Theorem 1.3 does not give the value of the positive constant $\kappa$ such that $\tau_*=\kappa\langle\cdot,\cdot\rangle$.

So the *form* $\tau_*=\kappa\langle\cdot,\cdot\rangle$ is Fox's; the *closed form* $\kappa_F(n)=\frac{(2n-1)(n-1)}4$ is **this project's**, and [algebra.md](../findings/algebra.md) says so plainly, *"This is a number Fox does not have: his Remark 1.4 explicitly leaves $\kappa$ uncomputed for $\dim V>4$."* The block's sentence attributes the whole package to Theorem 1.3 and should not. **This is a citation-scope defect, not a mathematical one:** the block's $\kappa_F$ is right (I confirm the anchor at $n=4$ below), but its provenance is misstated in the one sentence a reader would use to check it.

**A circularity I looked for and did not find, WITHDRAWN.** Since $\kappa_F$'s closed form was established by the project rather than by Fox, I checked whether it was fitted from the $\mathbb{CP}^m$ points themselves, which would make the $\operatorname{tr}(L_e^2)$ check circular. It was not, on three counts: (i) it is anchored at $n=4$ by Fox's *own* Theorem 1.5, $\kappa=21/16$ in his metric, and $\kappa_F(4)=\frac{7\cdot3}4=\frac{21}4=4\cdot\frac{21}{16}$ matches under the recorded $4\times$ metric conversion; (ii) Theorem 1.3(1) makes $\kappa$ a function of $n$ **alone**, so *any* point at $n=2m$ determines it and the $\mathbb{CP}^m$ point is then genuinely tested against it; (iii) [algebra.md](../findings/algebra.md) records the verification set as including *"random unit Weyl operators with criticality residual $\approx1$"*, i.e. non-idempotents, which pins $\kappa$ as a property of the algebra independently of any critical point. **Candidate withdrawn: it fails the third test of the discrepancy protocol, the opposite is not merely arguable, it is what the record shows.** What survives is the weaker and correct statement: *the $\operatorname{tr}(L_e^2)$ check is a check against a numerically-established constant, not against a theorem.*

## 7. Both Fox identities, derived

**Identity one, $\operatorname{tr}L_e=0$.** Summing $\dim_{\mathbb R}S\cdot\lambda_S$ over the seven rows:

$$1\cdot1+(m^2-1)\frac{m+2}{2(m+1)}+m(m-1)\cdot\tfrac12+\frac{m^2(m+1)(m-3)}4\cdot\frac2{m+1}+0+0+\frac{m^2(m^2-1)}6\cdot\Big(-\frac3{m+1}\Big).$$

Term by term: $(m^2-1)\frac{m+2}{2(m+1)}=\frac{(m-1)(m+2)}2$; the $V_{(1,1);(1,1)}$ term is $\frac{m^2(m-3)}2$; the last is $-\frac{3m^2(m-1)(m+1)}{6(m+1)}=-\frac{m^2(m-1)}2$. So the sum is

$$1+\frac{(m^2+m-2)+(m^2-m)+(m^3-3m^2)-(m^3-m^2)}2=1+\frac{-2}2=1-1=0 .$$

$$\boxed{\ \operatorname{tr}L_e=0\ \text{identically in }m\ }\qquad\textbf{PROVEN.}$$

**Identity two, $\operatorname{tr}(L_e^2)$.** Summing $\dim_{\mathbb R}S\cdot\lambda_S^2$:

$$1+\frac{(m^2-1)(m+2)^2}{4(m+1)^2}+\frac{m(m-1)}4+\frac{m^2(m+1)(m-3)}4\cdot\frac4{(m+1)^2}+0+0+\frac{m^2(m^2-1)}6\cdot\frac9{(m+1)^2}.$$

The second term is $\frac{(m-1)(m+2)^2}{4(m+1)}$; the fourth is $\frac{m^2(m-3)}{m+1}$; the seventh is $\frac{9m^2(m-1)}{6(m+1)}=\frac{3m^2(m-1)}{2(m+1)}$. Collecting the three over $4(m+1)$:

$$(m-1)(m+2)^2+4m^2(m-3)+6m^2(m-1)=(m^3+3m^2-4)+(4m^3-12m^2)+(6m^3-6m^2)=11m^3-15m^2-4 .$$

Hence

$$\operatorname{tr}(L_e^2)=1+\frac{m(m-1)}4+\frac{11m^3-15m^2-4}{4(m+1)}=\frac{4(m+1)+(m^3-m)+11m^3-15m^2-4}{4(m+1)}=\frac{12m^3-15m^2+3m}{4(m+1)},$$

and $12m^3-15m^2+3m=3m(4m^2-5m+1)=3m(4m-1)(m-1)$, so

$$\boxed{\ \operatorname{tr}(L_e^2)=\frac{3m(m-1)(4m-1)}{4(m+1)}\ }\qquad\textbf{PROVEN, exactly as stated.}$$

**And it equals $\kappa_F(2m)\lVert e\rVert^2$.** With $\kappa_F(n)=\frac{(2n-1)(n-1)}4$ at $n=2m$, and $\lVert e\rVert^2=1/\theta^2=\frac{3m(m-1)}{(m+1)(2m-1)}$ (proved in §8):

$$\kappa_F(2m)\lVert e\rVert^2=\frac{(4m-1)(2m-1)}4\cdot\frac{3m(m-1)}{(m+1)(2m-1)}=\frac{3m(m-1)(4m-1)}{4(m+1)} .$$

**The $(2m-1)$ cancels exactly. PROVEN.**

**What the two identities do and do not certify, and this is where the block overreaches.** The block says *"Two identities check the whole list, and each fails if any single value is wrong by a rational function of $m$."* The first half of that is true: perturbing one $\lambda_S$ by any nonzero rational $\epsilon(m)$ shifts $\operatorname{tr}L_e$ by $\dim_{\mathbb R}S\cdot\epsilon(m)\ne0$. **But both identities are polynomial identities in $m$, and they therefore pass at values of $m$ where the table is known false.** At $m=2$ the table's rows read $(1,1)$, $(3,\tfrac23)$, $(2,\tfrac12)$, $(-3,\tfrac23)$, $(0,0)$, $(5,0)$, $(2,-1)$ (a **negative dimension** on row 4) and yet

$$1+3\cdot\tfrac23+2\cdot\tfrac12+(-3)\cdot\tfrac23+0+0+2\cdot(-1)=1+2+1-2-2=0 .$$

The trace identity passes on a row list that [second-order.md](../findings/second-order.md) itself records as refuted at $m=2$, where the true spectrum is $\{1,\tfrac12^{(2)},0^{(5)},(-1)^{(2)}\}$ and $\lambda_{\max}(L_e|_{W^\perp})=\tfrac12$, not $\tfrac23$. **So the identities certify the internal arithmetic of the seven-row list; they do not certify that the list is the right decomposition at any given $m$.** That distinction is exactly what H3 would supply and does not. The block's phrase "check the whole list" should read "check the arithmetic of the list".

## 8. The closed form for $e$: tracelessness, norm, and Weyl membership

From [findings/nondegeneracy.md](../findings/nondegeneracy.md) line 548 and [second-order.md](../findings/second-order.md):

$$e=-\frac1{2m-1}P_{\mathfrak m}+\frac{m-2}{(m+1)(2m-1)}P_{\mathfrak{su}(m)}+\frac{2(m-1)}{2m-1}P_\omega .$$

The three $U(m)$-isotypic pieces of $\Lambda^2\mathbb R^{2m}=\mathfrak{so}(2m)$ have dimensions $\dim\mathfrak m=\binom{2m}2-m^2=m(2m-1)-m^2=m(m-1)$, $\dim\mathfrak{su}(m)=m^2-1$, $\dim\omega=1$, summing to $m(m-1)+m^2-1+1=m(2m-1)=\binom{2m}2$. ✓

**Tracelessness, exactly.**
$$\operatorname{tr}e=-\frac{m(m-1)}{2m-1}+\frac{(m-2)(m^2-1)}{(m+1)(2m-1)}+\frac{2(m-1)}{2m-1}=\frac{-m(m-1)+(m-2)(m-1)+2(m-1)}{2m-1}=\frac{(m-1)\big[-m+m-2+2\big]}{2m-1}=0 .$$
**PROVEN, identically in $m$.**

**The norm.**
$$\lVert e\rVert^2=\frac{m(m-1)}{(2m-1)^2}+\frac{(m^2-1)(m-2)^2}{(m+1)^2(2m-1)^2}+\frac{4(m-1)^2}{(2m-1)^2}=\frac{m-1}{(2m-1)^2(m+1)}\Big[m(m+1)+(m-2)^2+4(m-1)(m+1)\Big].$$
The bracket is $(m^2+m)+(m^2-4m+4)+(4m^2-4)=6m^2-3m=3m(2m-1)$, so
$$\lVert e\rVert^2=\frac{(m-1)\cdot3m(2m-1)}{(2m-1)^2(m+1)}=\frac{3m(m-1)}{(m+1)(2m-1)}=\frac1{\theta^2},\qquad\theta^2=\frac{(m+1)(2m-1)}{3m(m-1)} .$$
**PROVEN.** This is a genuine joint check on the three projector coefficients and on the closed form for $\theta$, as the block claims, the $(2m-1)$ cancellation is not automatic.

**Cross-check against the source, which the block does not make and which passes.** [algebra.md](../findings/algebra.md) records Fox's (10.4), $|S^r|^2=\frac{6r(r-2)}{(r+2)(r-1)}$ in his metric, for the idempotent $S^r$ built from an orthogonal complex structure. At $r=2m$ and converting by the recorded factor $4$:
$$\lVert e\rVert^2_{\mathrm{Frob}}=\tfrac14\cdot\frac{6\cdot2m(2m-2)}{(2m+2)(2m-1)}=\tfrac14\cdot\frac{24m(m-1)}{2(m+1)(2m-1)}=\frac{3m(m-1)}{(m+1)(2m-1)} .$$
**Identical.** So $\theta^2=\frac{(m+1)(2m-1)}{3m(m-1)}$ is Fox's own value for this family, reached by a route sharing nothing with the projector assembly. Independent confirmation of H6.

**Weyl membership is NOT discharged, H7.** Everything above treats $e$ as an operator on $\Lambda^2\mathbb R^{2m}$. That it lies in $\mathcal W_{2m}$ (first Bianchi and Ricci-flatness), is asserted at [second-order.md](../findings/second-order.md) as *"proved symbolically for all $m$"*, with no derivation on file and the supporting $\sharp$ forms *"exact in GF(p) at $m=3\ldots20$"*. **A traceless, correctly-normed operator on $\Lambda^2$ that is not a Weyl tensor would satisfy §8 and make the entire table a statement about the wrong space.** The tracelessness computed above is the $\Lambda^2$ trace, which is *not* the Ricci contraction and does not imply it. `HYPOTHESIS-DEBT`: *the closed form for $e$ has no on-file proof of first-Bianchi or Ricci-flatness.* The same debt attaches to H8, $L_e$ preserving $\mathcal W_{2m}$, which [second-order.md](../findings/second-order.md) supports only numerically and explicitly contrasts with the individual $\sharp$ pieces, of which it says *"$28$–$46\%$ of the image leaves"*.

## 9. The slack against Lemma L70

**The claim**, from [nondegeneracy.md](../findings/nondegeneracy.md) line 548: $W_{\mathbb{CP}^m}$ does **not** saturate [Lemma L70](../findings/bounds.md), the slack being exactly $2(m-2)\theta$, vanishing only at $m=2$.

**The spectrum of $W$ on $\Lambda^2$.** From $W=\theta e$ and the closed form, the three eigenvalues are
$$-\frac\theta{2m-1}\ \text{on }\mathfrak m\ (\dim m(m-1)),\qquad \frac{\theta(m-2)}{(m+1)(2m-1)}\ \text{on }\mathfrak{su}(m)\ (\dim m^2-1),\qquad \frac{2\theta(m-1)}{2m-1}\ \text{on }\omega\ (\dim 1).$$
At $m\ge3$ the middle one is strictly positive, so **$\ker W=0$**; $\lambda_{\min}=-\frac\theta{2m-1}$ and $\lambda_{\max}=\frac{2\theta(m-1)}{2m-1}$, since $2(m-1)>\frac{m-2}{m+1}$ for every $m\ge3$. **$\dim E_{\max}=1$.**

**L70's hypotheses, checked.** The boxed identity at [bounds.md](../findings/bounds.md) needs $\lVert W\rVert=1$ (*"the left side is scale-invariant while the right is homogeneous of degree one"*) and here $\lVert W\rVert=\theta\lVert e\rVert=\theta\cdot\tfrac1\theta=1$ ✓ by §8. It needs $\lambda_{\min}\le0\le\lambda_{\max}$ ✓. It needs criticality ✓. **All discharged.**

**The value.** With $n=2m$,
$$\lambda_{\min}+(n-2)\lambda_{\max}=\theta\cdot\frac{-1+(2m-2)\cdot2(m-1)}{2m-1}=\theta\cdot\frac{4(m-1)^2-1}{2m-1}=\theta\cdot\frac{(2m-3)(2m-1)}{2m-1}=(2m-3)\theta,$$
using $4(m-1)^2-1=(2m-3)(2m-1)$ as a difference of squares. Since L70 reads $\theta=\lambda_{\min}+(n-2)\lambda_{\max}-D/\lvert\lambda_{\min}\rvert$ with $D\ge0$, the slack is

$$\boxed{\ D/\lvert\lambda_{\min}\rvert=(2m-3)\theta-\theta=(2m-4)\theta=2(m-2)\theta\ }$$

**PROVEN, exactly as claimed, vanishing only at $m=2$ and growing linearly in $m$.** The block's own route via $\theta(1+2(m-2))$ agrees, $1+2(m-2)=2m-3$.

**Consistent with the record's independent route.** [bounds.md](../findings/bounds.md) proves saturation forces $\dim E_{\max}\ge(n-2)/2=m-1$; here $\dim E_{\max}=1$, so saturation needs $m\le2$. **Two routes, same boundary, and the block's earlier claim that $W_{\mathbb{CP}^m}$ saturates is correctly withdrawn**, [INDEX-results.md](../findings/INDEX-results.md) and [LEDGER.md](../findings/LEDGER.md) both record the withdrawal with this same $2(m-2)\theta$.

**One loose phrase.** *"Equivalently the ratio $\lambda_{\max}/\lvert\lambda_{\min}\rvert=2(m-1)$ meets saturation's requirement only there."* The ratio is right, $\frac{2(m-1)/(2m-1)}{1/(2m-1)}=2(m-1)$ ✓, but "saturation's requirement" on a *ratio* is nowhere stated in [L70](../findings/bounds.md); the requirement there is on $\dim E_{\max}$, or equivalently on the slack. The sentence is an unsupported restatement, harmless because the two preceding sentences carry the result.

## 10. The second route to $\lambda_{\max}$, tested beyond the displayed row

**The displayed solve is correct.** Holding the other six rows fixed and writing $y$ for the $\mathfrak{su}(m)$ value, $\operatorname{tr}L_e=0$ reads
$$1+(m^2-1)y+\frac{m(m-1)}2+\frac{m^2(m-3)}2-\frac{m^2(m-1)}2=0 .$$
The two $m^2$ terms combine as $\frac{m^2[(m-3)-(m-1)]}2=-m^2$, so the constant is $1+\frac{m(m-1)}2-m^2=1-\frac{m(m+1)}2$, and
$$(m^2-1)y=\frac{m^2+m-2}2=\frac{(m+2)(m-1)}2,\qquad y=\frac{(m+2)(m-1)}{2(m-1)(m+1)}=\frac{m+2}{2(m+1)} .$$
**PROVEN**, and the cancellation of $(m-1)$ is legitimate at every $m\ge3$.

**The brief asks for one more row. I do three, which exhausts the distinct cases.**

**Row 7, $(2,2,0^{m-2})\oplus$ dual, unknown $w$.** The five known contributions are $1$, $\frac{(m-1)(m+2)}2$, $\frac{m(m-1)}2$, $\frac{m^2(m-3)}2$, $0$, $0$, and
$$(m^2+m-2)+(m^2-m)+(m^3-3m^2)=m^3-m^2-2,\qquad 1+\frac{m^3-m^2-2}2=\frac{m^2(m-1)}2 .$$
So $\frac{m^2(m^2-1)}6\,w=-\frac{m^2(m-1)}2$, giving $w=-\frac{6(m-1)}{2(m^2-1)}=-\frac3{m+1}$. **Recovered uniquely, at every $m\ge3$**, since the coefficient $\frac{m^2(m^2-1)}6\ne0$ there. ✓

**Rows 5 and 6, unknown $0$.** The full seven-row sum is $0$ identically (§7), so with the two zero rows carrying coefficients $\frac{2m^2(m^2-4)}3$ and $\frac{m^2(m-1)(m+3)}4$ (both strictly positive at every $m\ge3$), solving either for its own value returns $0$ uniquely. ✓ *This is the case [second-order.md](../findings/second-order.md) already states: "the trace identity forces it, since the other five values already sum to zero against their dimensions."* Note the solve recovers each **separately**, not the pair jointly: with **both** unknown the single equation leaves a one-parameter family $\frac{2m^2(m^2-4)}3u+\frac{m^2(m-1)(m+3)}4v=0$. The block's "holding the rest fixed" is doing real work.

**Row 4, $V_{(1,1);(1,1)}$, unknown $z$, and here the claim FAILS at $m=3$.** The known contributions sum to
$$1+\frac{(m-1)(m+2)}2+\frac{m(m-1)}2-\frac{m^2(m-1)}2=1+\frac{(m-1)\big[(m+2)+m-m^2\big]}2=1+\frac{-m^3+3m^2-2}2=\frac{-m^2(m-3)}2,$$
so $\frac{m^2(m+1)(m-3)}4\,z=\frac{m^2(m-3)}2$ and $z=\frac2{m+1}$, **provided $m\ne3$.** At $m=3$ the coefficient is $0$ and the equation degenerates to $0\cdot z=0$: **every** value of $z$ satisfies it.

**Verdict on claim 12.** *"The same solve returns $\frac2{m+1}$, $-\frac3{m+1}$ and $0$ on each remaining class, **each uniquely from the other four**"* is **true at every $m\ge4$ and false at $m=3$ for the $V_{(1,1);(1,1)}$ row**. It is not a defect in the lemma (at $m=3$ that summand is *absent*, so there is nothing to recover) but the sentence as written quantifies over the lemma's whole range $m\ge3$ and is false at its boundary. **The repair is one clause**: "for $m\ge4$; at $m=3$ the class is empty and the coefficient degenerate."

**Verdict on claim 13, the independence sentence, OVERSTATED.** The block concludes: *"So $\lambda_{\max}$ rests on more than the charge formula, which matters, since the charge formula is where this block's one arithmetic error stood."*

- **Located exactly:** the final sentence of the [nondegeneracy.md](../findings/nondegeneracy.md) L28 block.
- **The failure, in closed form.** The solve for $y$ takes as *inputs* the values $\tfrac12$, $\frac2{m+1}$, $0$, $0$, $-\frac3{m+1}$ on rows 3–7, of which four come from the charge formula and one from equivariance. Perturb the charge formula on row 7 alone by $\epsilon(m)$, so $\lambda_7=-\frac3{m+1}+\epsilon$. Then $(m^2-1)y=\frac{(m+2)(m-1)}2-\frac{m^2(m^2-1)}6\epsilon$, i.e.
$$y=\frac{m+2}{2(m+1)}-\frac{m^2}6\,\epsilon(m).$$
**A single wrong charge propagates straight into $\lambda_{\max}$ with a nonzero coefficient.** The same holds for perturbations on rows 4, 5, 6, and it holds for a wrong *dimension* too. So the route does not decouple $\lambda_{\max}$ from the charge formula; it re-expresses one charge-formula output in terms of four others.
- **Argue the opposite, honestly.** The route *is* worth something: an arithmetic slip confined to row 2 would be caught, since $y$ is then over-determined; and $\operatorname{tr}L_e=0$ is a theorem of Fox's, external to the charge formula, so the seven values are constrained by something the formula did not supply. **That is the defensible version of the sentence.** What it cannot support is independence from the charge formula, because five of the six inputs are charge-formula outputs.
- **All three tests cleared. Recorded.** Severity: a **claim of independence that the derivation does not establish**, in the one paragraph the block wrote to reassure a reader about the very column that was previously wrong. The arithmetic is sound; the epistemics are not. **The repair is to say "rests on more than the charge formula *at row 2*", or better, "the charge formula's seven outputs are mutually consistent under an external trace identity."**

## 11. The landscape statement, INCONSISTENT AS WRITTEN

**The sentence**, [results.md](../results.md) line 142: *"each is $1-\frac{c_S+q_S^2}{4(m+1)}$. Only $\tfrac2{m+1}$ reaches $\tfrac12$, at $m=3$, where that summand is empty."*

**The table**, same lemma: the orbit tangent $(1,1,0^{m-2})\oplus$ dual carries $L_e=\tfrac12$ **at every $m$**, with $c_S+q_S^2=2(m+1)$ identically (§4).

- **Located exactly.** One sentence, [results.md](../results.md) line 142.
- **The failure, in closed form.** At $m=4$ the seven values are $1$, $\tfrac35$, $\tfrac12$, $\tfrac25$, $0$, $0$, $-\tfrac35$. The value $\tfrac12$ **is** attained, by the orbit row; $\frac2{m+1}=\tfrac25\ne\tfrac12$. So "only $\frac2{m+1}$ reaches $\frac12$" is false at $m=4$, and at every other $m\ge3$ by the same instance. It is false in a second way at $m=3$: there $\frac2{m+1}=\frac12$ *and* the orbit row is $\frac12$, so two values reach it, one of them from a summand that exists.
- **Argue the opposite.** The intended reading is plainly "among the summands **other than the orbit**", which is exactly how the [nondegeneracy.md](../findings/nondegeneracy.md) block words it: *"That holds identically on the orbit, and among the rest only $4(m-1)$ can meet it."* Read that way the sentence is true, and no consumer could be misled about the mathematics, since the whole point of the lemma is that $E(\tfrac12)$ **equals** the orbit. **That is a fair account of intent.** It is not a defence of the text: the sentence appears in the landscape list, which is the first and often only line a reader meets, and it drops the qualifier that makes it true. A reader taking it at face value concludes $E(\tfrac12)=0$ at $m\ge4$, the opposite of the lemma.
- **All three tests cleared. Recorded** as a wording defect in [results.md](../results.md), not a mathematical one. **The repair is three words**: "Among the rest, only $\frac2{m+1}$ reaches $\frac12$…".

## 12. The duplicate, do [nondegeneracy.md](../findings/nondegeneracy.md) and [second-order.md](../findings/second-order.md) agree?

I opened both. **The table agrees, row for row. The surrounding argument does not.**

| row | [nondegeneracy.md](../findings/nondegeneracy.md) | [second-order.md](../findings/second-order.md) | agree? |
|---|---|---|---|
| trivial | $1$, $1$ | $1$, $1$ | ✓ |
| $\mathfrak{su}(m)$ adjoint | $m^2-1$, $\frac{m+2}{2(m+1)}$ | $m^2-1$, $\frac{m+2}{2(m+1)}$ | ✓ |
| orbit | $m(m-1)$, $\tfrac12$ | $m(m-1)$, $\tfrac12$ | ✓ |
| $V_{(1,1);(1,1)}$ | $\frac{m^2(m+1)(m-3)}4$, $\frac2{m+1}$ | $\frac{m^2(m+1)(m-3)}4$, $\frac2{m+1}$ | ✓ |
| $V_{(2,1);(1)}\oplus$ conj | $\frac{2m^2(m^2-4)}3$, $0$ | $\frac{2m^2(m^2-4)}3$, $0$ | ✓ |
| $V_{(2);(2)}$ | $\frac{m^2(m-1)(m+3)}4$, $0$ | $\frac{m^2(m+3)(m-1)}4$, $0$ | ✓ (factors reordered) |
| $V_{(2,2)}\oplus$ conj | $\frac{m^2(m^2-1)}6$, $-\frac3{m+1}$ | $\frac{m^2(m^2-1)}6$, $-\frac3{m+1}$ | ✓ |

**Three divergences outside the table, and one of them matters.**

1. **The reason for the $m=3$ absence, a direct contradiction of emphasis.** [nondegeneracy.md](../findings/nondegeneracy.md) says the summand is absent because it needs four Young-diagram rows, and explicitly demotes the vanishing dimension: *"$\frac{m^2(m+1)(m-3)}4$ vanishing there is the analytic continuation agreeing with the absence rather than the reason for it."* [second-order.md](../findings/second-order.md) gives **only** the demoted reason: *"at $m=3$ alone, precisely where $\dim V_{(1,1);(1,1)}=\frac{m^2(m+1)(m-3)}4$ vanishes."* **The two files do not agree on why the lemma is true at its boundary case**, and the file that carries the weaker reason is the one the block sends the reader to for the derivation. §5 shows the stronger reason is the correct one, so the repair is to carry it into [second-order.md](../findings/second-order.md).
2. **The summand count.** [second-order.md](../findings/second-order.md) says "ten summands, **nine at $m=3$**" and "all multiplicity one **for $m\ge4$**"; [nondegeneracy.md](../findings/nondegeneracy.md) says "ten" and "multiplicity-free" unqualified. Same content, one file more careful.
3. **A third route in [second-order.md](../findings/second-order.md) that cannot hold over its stated range, a NEW discrepancy, scoped to that file.**
   - **Located exactly.** [second-order.md](../findings/second-order.md): *"The critical row was reached three independent ways: … and explicit highest-weight vectors of weight $\varepsilon_1+\varepsilon_2-\varepsilon_{m-1}-\varepsilon_m$, exact in two primes at $m=3\ldots9$."*
   - **The failure, in closed form.** At $m=3$ that weight is $\varepsilon_1+\varepsilon_2-\varepsilon_{2}-\varepsilon_{3}=\varepsilon_1-\varepsilon_3$, the highest root of $\mathfrak{su}(3)$. A highest-weight vector of that weight lies in the **adjoint** summand, whose $L_e$ value is $\frac{m+2}{2(m+1)}=\tfrac58$, not $\frac2{m+1}=\tfrac12$. So either the run at $m=3$ produced $\tfrac58$ and was recorded as confirming $\tfrac12$, or it produced nothing and a vacuous pass was recorded. **Either way the stated range cannot be right**, and it contradicts the same file's own claim, two sentences earlier, that the summand's dimension vanishes at $m=3$.
   - **Argue the opposite.** The likeliest innocent explanation is that "$m=3\ldots9$" was copied from the ranges attached to the other two routes and the intended range is $m=4\ldots9$. That is a plausible slip and would leave the mathematics untouched. **It is not a defence of the text**, which as written asserts a verification at a value where the object being verified does not exist.
   - **All three tests cleared. Recorded** as a range error in [second-order.md](../findings/second-order.md). **The repair is one character.** It does not touch L28's conclusion.

**One check in [second-order.md](../findings/second-order.md) that I verified and that passes.** The "hand assembly" $\frac{-(m+4)+3(m+1)+5(2m-1)}{3(m+1)(2m-1)}$: the numerator is $-m-4+3m+3+10m-5=12m-6=6(2m-1)$, so the quotient is $\frac{6(2m-1)}{3(m+1)(2m-1)}=\frac2{m+1}$ ✓, independent of the charge collapse.

## 13. The named traps, each answered

| trap | finding |
|---|---|
| **$\ker W\ne0$ and padded objects** | **NO DEFECT, and the block should say so.** §9 shows $\ker W=0$ at every $m\ge3$, the $\mathfrak{su}(m)$ eigenvalue $\frac{\theta(m-2)}{(m+1)(2m-1)}$ being strictly positive there. It **is** zero at $m=2$, giving the $3$-dimensional kernel [bounds.md](../findings/bounds.md) records at $n=4$, so a kernel appears exactly at the excluded member. No padded object enters: $W_{\mathbb{CP}^m}\in\mathcal W_{2m}$ is full-support at $m\ge3$, and every dimension in the table is a $U(m)$-module dimension in $\mathcal W_{2m}$ itself. |
| **The boundary of every stated range, and the smallest admissible dimension** | **CHECKED, and it is where the two real findings live.** $m=3$ ($n=6$) is fully worked in §5 (nine summands, six classes, $E(\tfrac12)$ six-dimensional) and the lemma holds there. But $m=3$ is exactly where claim 12's uniqueness fails (§10) and where the landscape line double-counts (§11). $m=2$ is correctly excluded and is *genuinely* different, not merely untreated: the formula gives $\tfrac23$ where the truth is $\tfrac12$, the row-4 dimension goes **negative** at $-3$, and $W_{\mathbb{CP}^2}$ **is** the maximiser. **H1 is load-bearing and correctly stated.** |
| **A claim proven on a subfamily and used in general** | **ONE, and it is H4.** The charge formula is established "exact in GF(p) at $m=3\ldots20$" and used for all $m\ge3$. The block's conclusion is a universal statement over an infinite family resting on a formula checked at eighteen values. The dimension identity of §2 and the trace identities of §7 are genuine all-$m$ constraints on the result, which is why I grade this `HYPOTHESIS-DEBT` rather than `GAP`. |
| **A hypothesis stated but never used** | **NONE FOUND.** Every hypothesis in the inventory is consumed: $m\ge3$ twice, $U(m)$-invariance for Schur, multiplicity-freeness twice, the charge formula for five rows, Fox for both checks, $\lVert e\rVert^2$ for the second check. |
| **A step using a hypothesis never stated** | **TWO.** (i) The trace solve of §10 requires the **dimension column** to be correct, and never says so, it presents itself as a check on the eigenvalue column while silently consuming the other column whole. (ii) The identification of row 3 *with* the orbit tangent (§5) requires multiplicity-freeness a second time, in a place the block does not flag. |
| **A universal claim with no witness** | **NO DEFECT.** The lemma is universal over $m\ge3$ and the record carries explicit witnesses at both ends: $W_{\mathbb{CP}^3}$ at $m=3$, [second-order.md](../findings/second-order.md) records it graded, at $\theta_0(6)$ exactly, and not a local maximiser, and $W_{\mathbb{CP}^2}=\mathrm{diag}(0,0,0,-1,-1,2)/\sqrt6$ as the $m=2$ anchor identified with Nienhaus's point. |
| **An imported theorem whose hypotheses were never checked** | **THE NAMED UNITAL TRAP DOES NOT FIRE**, Fox's Theorem 1.3 assumes only $\dim V\ge4$, and Fox writes that an exact algebra *is* nonunital, so nonunitality is the theorem's conclusion (§6). **But the import is misdescribed in a second way**: the block attributes the constant $\kappa_F(n)=\frac{(2n-1)(n-1)}4$ to Theorem 1.3, while Fox's Remark 1.4 says in terms that the theorem does not give $\kappa$ for $\dim V>4$. The value is the project's, anchored at $n=4$ and established numerically above it. `HYPOTHESIS-DEBT` on the provenance, not on the mathematics. |
| **Symbol collisions, $c$, $q$, $P$, $e$, $\lambda$** | **ONE REAL, HANDLED; ONE STRUCTURAL.** The real one is $e$: it is the **idempotent** $W/\theta$, not the unit critical point, so $\lVert e\rVert^2=1/\theta^2\ne1$, and both files say so, and every use is consistent (§0, §8). $P$: [conventions.md](../findings/conventions.md) tables three senses; L28 uses only the cubic form, and only in the phrase "$\mathrm{Crit}(P)$". $\lambda$: used for $L_e$-eigenvalues throughout, with $\lambda_{\min},\lambda_{\max}$ in §9 meaning the $\Lambda^2$-spectrum of $W$, a genuine change of referent between the table and the L70 paragraph, disambiguated by $L_e$ vs. bare, and the block does not flag it. The structural one is $c_S,q_S$, absent from [conventions.md](../findings/conventions.md) while the bare $c$ and $q$ are both tabled there as colliding (§4). |

## 14. Verdict

# `HYPOTHESIS-DEBT`

**Every arithmetic claim in the block is exactly right.** All seven charges reproduce from the weights (§4); the dimension sum is a polynomial identity and I derived it in full (§2); four of the seven dimensions re-derive from first principles with no branching rule at all (§3); both Fox identities come out to the stated closed forms with the $(2m-1)$ cancelling (§7); the closed form for $e$ is exactly traceless with $\lVert e\rVert^2=1/\theta^2$, confirmed a second time against Fox's own (10.4) (§8); the L70 slack is exactly $2(m-2)\theta$ (§9); and the trace solve returns $\frac{m+2}{2(m+1)}$ (§10). **The repaired column is sound. I found no arithmetic error anywhere in this block.**

**What the block does not have is a proof of the three things it imports.** The conclusion, $E(\tfrac12)=$ the orbit tangent at every $m\ge3$, hence Morse–Bott nondegeneracy, hence not a maximiser, is **conditional** on:

| debt | what would have to be proved |
|---|---|
| **H3** | that $\mathrm{Weyl}_{2m}\otimes\mathbb C$ is $U(m)$-multiplicity-free with exactly these ten summands. **Load-bearing twice**: it is what upgrades $E(\tfrac12)\supseteq$ orbit to $=$, and it is what identifies row 3 *with* the orbit tangent. Cited in a sibling file to [Howe–Tan–Willenbring §2.3.1](https://arxiv.org/abs/math/0311159); **no branching computation is on the record in either file**, and the block itself gives no citation at all. |
| **H4** | that $\lambda_S=1-\frac{c_S+q_S^2}{4(m+1)}$ holds for all $m$, rather than at the eighteen values $m=3\ldots20$ where it is recorded exact in GF(p). Five of the seven rows come from it. |
| **H7 / H8** | that the closed-form $e$ satisfies first Bianchi and is Ricci-flat, i.e. lies in $\mathcal W_{2m}$ at all, and that $L_e$ preserves $\mathcal W_{2m}$. Asserted as "proved symbolically for all $m$" and "to $10^{-15}$" respectively, with **no derivation on file**. The $\Lambda^2$-tracelessness proved in §8 is not the Ricci contraction and does not imply it. |

**And four statements in the record are wrong as written, none of them touching the conclusion:**

1. **[nondegeneracy.md](../findings/nondegeneracy.md), final sentence, the independence claim.** *"So $\lambda_{\max}$ rests on more than the charge formula"* is **overstated**: five of the six inputs to that solve are charge-formula outputs, and a perturbation $\epsilon(m)$ on row 7 alone moves $\lambda_{\max}$ by $-\frac{m^2}6\epsilon(m)$ (§10). The defensible version is that the seven values are *mutually consistent* under an external trace identity, which is real, and worth saying, and is not independence.
2. **[nondegeneracy.md](../findings/nondegeneracy.md), the uniqueness clause.** *"each uniquely from the other four"* is **false at $m=3$** for the $V_{(1,1);(1,1)}$ row, where the coefficient degenerates and $0\cdot z=0$ admits every $z$ (§10). Harmless (the class is empty there) but the sentence quantifies over the lemma's own boundary.
3. **[results.md](../results.md) line 142, the landscape line.** *"Only $\tfrac2{m+1}$ reaches $\tfrac12$"* is **inconsistent with the table**, which gives the orbit tangent $\tfrac12$ at every $m$; the missing qualifier is "among the rest", which the [nondegeneracy.md](../findings/nondegeneracy.md) block supplies and this line drops (§11). A reader taking it literally concludes $E(\tfrac12)=0$ at $m\ge4$, the opposite of the lemma.
4. **[second-order.md](../findings/second-order.md), the third route's range.** *"explicit highest-weight vectors of weight $\varepsilon_1+\varepsilon_2-\varepsilon_{m-1}-\varepsilon_m$, exact in two primes at $m=3\ldots9$"* **cannot include $m=3$**: there the weight collapses to $\varepsilon_1-\varepsilon_3$, the adjoint's highest root, whose value is $\tfrac58$ and not $\tfrac12$, and the same file says the summand's dimension vanishes at $m=3$ (§12).

**Two smaller repairs owed.** The block's "ten summands" wants [second-order.md](../findings/second-order.md)'s rider "nine at $m=3$"; and the block attributes $\kappa_F(n)=\frac{(2n-1)(n-1)}4$ to Fox's Theorem 1.3, which Remark 1.4 says in terms it does not supply for $\dim V>4$ (§6).

**On the named unital trap: NO DEFECT.** Fox's Theorem 1.3 assumes only that $(V,h)$ is Euclidean of dimension at least $4$, met at $n=2m\ge6$; and Fox writes that *"an exact algebra is nonunital"*, so the absence of a unit in $\mathcal W_n$ is a **consequence** of the theorem rather than a bar to citing it. The import is legitimate. Only its scope is misstated.

**What I would change the verdict to, and on what.** A proof of H3, the $O(2m)\downarrow U(m)$ branching at $\lambda=(2,2)$, or a citation checked at source the way Fox's Theorem 1.3 is checked in §6, together with an on-file derivation of Bianchi and Ricci-flatness for the closed-form $e$, would move this to `PROVEN`. **Neither requires computation.** H4 could be left as it is, since the dimension identity, both trace identities and the $m=2$ counter-instance together constrain the seven values tightly; but it should be *labelled* as checked rather than proved.
