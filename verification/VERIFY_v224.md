# VERIFY_v224, Lemma L39, the two-eigenvalue formula for an arbitrary symmetric pair

*Verifier v224, cold read of [BRIEF_L39.md](BRIEF_L39.md). **No numerical work was done**: every figure below is exact rational arithmetic on an object constructed for the purpose of screening a claim I was about to record, reported as a screen and never as evidence for a positive claim. No script, no Sage, no Python, no floating point. Log: [agent_logs/verify-L39-v224.log](../agent_logs/verify-L39-v224.log).*

## Claim table

| # | claim | verdict |
| --- | --- | --- |
| 1 | The four-invariant formula $\theta^2=\frac{(S_{\mathfrak{kkk}}q^2+3S_{\mathfrak{kmm}}p^2-2p^3+2pq^2)^2}{4p^3q(p+q)^3}$ | **DERIVED, correct** |
| 2 | $S_{\mathfrak{kkm}}=0$ from $[\mathfrak k,\mathfrak k]\subseteq\mathfrak k\perp\mathfrak m$ | **PROVEN**, one line, conditional on claim 15 |
| 3 | $S_{\mathfrak{mmm}}=0$ from $[\mathfrak m,\mathfrak m]\subseteq\mathfrak k\perp\mathfrak m$ | **PROVEN**, one line, conditional on claim 15 |
| 4 | Both vanishings are properties of the decomposition, free of $W$ and of the grading | **CONFIRMED** |
| 5 | $[\mathfrak k,\mathfrak m]\subseteq\mathfrak m$ "closes the Killing split instead" | **MIS-ATTRIBUTED**, it is unused; the split is closed by $\mathfrak g$ being a subalgebra |
| 6 | The $\mathfrak m$-row Killing step $S_{\mathfrak{kmm}}=cq/2$, hence $S_{\mathfrak{kkk}}=c(p-q/2)$ | **PROVEN** |
| 7 | The three-invariant form reduces to the four-invariant one | **PROVEN**, exactly, via $2N=(p+q)M$ |
| 8 | "$\theta$ depends on $p,q,S_{\mathfrak{kkk}},c$ alone" (results.md and target.md) | **BROKEN, overcount**; under its own hypothesis three suffice |
| 9 | $q\le2p$ for every symmetric pair with $\mathfrak g$ simple, equality iff $\mathfrak k$ abelian | **PROVEN** |
| 10 | The equal-$\theta$ pair is "forced", both at $(p,q,c)=(7,8,8)$ | **CORRECT IN FACT, REVERSED IN WORDING** |
| 11 | Balanced pair: numerator $=4k^2(k-1)^2(2k-1)$ and $\theta^2=2(n-1)(n-2)/n^2$ exactly, iff $c=4(k-1)$ | **PROVEN**, uniqueness of $c$ included |
| 12 | This copy dropped the Weyl-ness guard the canon carries | **CONFIRMED** for the block; the file carries it 300 lines away |
| 13 | Overshoot $1.389084$ vs $\Theta_9^2=1.371429$; $12.6\%$ at $n=5$ | **CONFIRMED in closed form**, $64009/46080$ and $61504/61440$ |
| 14 | The $(1,3,3,1)$ weights are multinomial and close only in the ordered reading | **CONFIRMED**; the identification with L114's $6/4/2$ **CONFLATES TWO IDENTITIES** |
| 15 | Scope "any symmetric pair" ($\mathfrak k\perp\mathfrak m$ in the **ambient** form | **HYPOTHESIS-DEBT**), used everywhere, stated nowhere; falsifier exhibited |
| 16 | The normalisations $ap+bq=0$, $a^2p+b^2q=1$ | **HYPOTHESIS-DEBT** in results.md; present in target.md |
| 17 | Table: $h^\vee(\mathfrak{so}(m))=m-2$, $I_\rho=2$ at $m=3,4$ | **BOTH COLUMNS FAIL**; the product $c=m-2$ survives, no value moves |
| 18 | "$S_{XYZ}$ is defined nowhere on the record, conventions.md included" | **STALE, FALSE** since 2026-09-04 |
| 19 | "The denominator is produced by $a^6$" | **OVERSTATED**, $a^6$ supplies $p^3(p+q)^3$ only |
| 20 | "Neither member of the $n=8$ pair is in scope" | **UNVERIFIABLE AS WRITTEN**, referent not fixed; the balanced $n=8$ pair *is* in scope |
| 21 | $p,q$ collide with the sphere-product $(p,q)$ **inside target.md itself** | **CONFIRMED, live collision** |

**One line.** Both closed forms are correct and the second reduces to the first exactly, so the mathematics of L39 stands; what fails is the bookkeeping around it, the invariant count is one too high, the ambient-orthogonality and normalisation hypotheses are used without being stated, and the block's copy has no Weyl-ness scope at all.

**Verdict: PROVEN, hypotheses corrected.**

## 0. Conventions, fixed once

Quoted from [conventions.md](../findings/conventions.md), not restated.

- $\theta$: *"$P(W)/\lVert W\rVert^3$; at a critical point, $Q(W)=\theta W$"*.
- $\theta_0(n)$: *"the closed form $\theta_0(n)^2=2(n-1)(n-2)/n^2$, and nothing more."*
- $\Theta_n$: *"the diagonal maximum; equals $\theta_0(n)$ at even $n$, and $\sqrt{2(n-1)(n-3)/((n+1)(n-2))}$ at odd $n$"*.
- $S_{XYZ}$: *"the block-restricted contraction of $T$ over ORDERED slots"*, with *"conversion is **per pattern**, $S^{\mathrm{ord}}=6S^{\mathrm{unord}}$ on $\mathfrak{mmm}$ and $\mathfrak{hhh}$, $2\times$ on the mixed patterns, not a global constant."*
- The bracket tensor: *"$T_{\alpha\beta\gamma}=\langle[v_\alpha,v_\beta],v_\gamma\rangle^2$"*.
- The row marginal, [Lemma L153](../findings/bounds.md): *"$\sum_\beta\lVert[v,v_\beta]\rVert^2=2(n-2)\lVert v\rVert^2$ for any $v\in\mathfrak{so}(n)$ at any $n\ge2$"*.
- The Killing constant, [target.md:343](../findings/target.md): *"$\sum_{b\in\mathfrak g}\lVert[a,b]\rVert^2=c\lVert a\rVert^2$"*.

The ordered reading matters immediately: it is what makes $(1,3,3,1)$ the right weights in §3 and $(1,2,1)$ the right weights in §4.

## 1. Hypothesis inventory

A pass with no inventory is not a pass. Every hypothesis the derivation consumes, and where it is stated.

| # | hypothesis | where used | where stated |
| --- | --- | --- | --- |
| H1 | $\mathfrak g\subseteq\mathfrak{so}(n)$ is a subalgebra | fixes the ambient inner product; closes $\sum_{\gamma\in\mathfrak g}T_{\alpha\beta\gamma}=\lVert[v_\alpha,v_\beta]\rVert^2$ | results.md, target.md:339 |
| H2 | $\mathfrak g=\mathfrak k\oplus\mathfrak m$ with $[\mathfrak k,\mathfrak k]\subseteq\mathfrak k$, $[\mathfrak m,\mathfrak m]\subseteq\mathfrak k$ | §3 vanishings | stated |
| H3 | **$\mathfrak k\perp\mathfrak m$ in the ambient form** | both vanishings, both projectors, $\mathrm{tr}W$, $\lVert W\rVert$, the Killing split | **NOWHERE**, §9 |
| H4 | $p\ge1$, $q\ge1$ | $a^2=q/(p(p+q))$, division by $q^2$, the denominator | **NOWHERE**, §9 |
| H5 | $ap+bq=0$ (trace-free) | $b=-ap/q$ | target.md:339 only; **absent from results.md** |
| H6 | $a^2p+b^2q=1$ (unit norm) | $a^2=q/(p(p+q))$ | target.md:339 only; **absent from results.md** |
| H7 | $\theta=\mathrm{tr}(W^3)+\tfrac12\big[a^3S_{\mathfrak{kkk}}+3ab^2S_{\mathfrak{kmm}}\big]$, the $\#$-term normalisation | the whole scale of $\theta$ | target.md:389 for $\mathfrak{su}(m)$; imported, not derived in the block |
| H8 | $T$ totally symmetric | $S_{\mathfrak{mkk}}=S_{\mathfrak{kkm}}$, $S_{\mathfrak{mkm}}=S_{\mathfrak{kmm}}$, and the $(1,3,3,1)$ collapse | conventions.md, $T$ third sense |
| H9 | $\mathfrak g$ simple | existence of a single $c>0$; §4, §5, §6 | stated for the three-invariant clause |
| H10 | $c>0$ | $q\le2p$ | **NOWHERE**, automatic under H9 |
| H11 | $\mathfrak k$ is *not* required simple, and may have a centre | §4 needs nothing of $\mathfrak k$ | results.md carries the centre clause, which §5 shows is redundant |
| H12 | $W\in\mathcal W_n$ (Bianchi + Ricci-flat) | **nothing in the formula**, this is precisely the missing admissibility hypothesis | results.md guard; **absent from the block** |
| H13 | $Q(W)=\theta W$ (criticality) | **nothing in the formula** | absent from both copies |

H12 and H13 are the two hypotheses whose absence makes the number meaningless as a $\theta$-value even though the algebra is right; §7 exhibits the consequence.

## 2. The ansatz, and where $a$ comes from

From [target.md:339](../findings/target.md), verbatim: *"the two-eigenvalue graded ansatz $W=a\Pi_{\mathfrak k}+b\Pi_{\mathfrak m}$ ($ap+bq=0$, $a^2p+b^2q=1$, so $a^2=q/(p(p+q))$)"*.

Checking that: $b=-ap/q$ from H5, then $a^2p+a^2p^2/q=1$, so $a^2p(p+q)/q=1$ and

$$a^2=\frac{q}{p(p+q)},\qquad a^6=\frac{q^3}{p^3(p+q)^3}.$$

Correct. Note $W$ vanishes on $\mathfrak g^\perp\subseteq\mathfrak{so}(n)$, so $\ker W\supseteq\mathfrak g^\perp$ has dimension $\binom n2-p-q$, treated in §10.

## 3. Both vanishings

$S_{\mathfrak{kkm}}=\sum_{\alpha,\beta\in\mathfrak k}\sum_{\gamma\in\mathfrak m}\langle[v_\alpha,v_\beta],v_\gamma\rangle^2$. By H2, $[v_\alpha,v_\beta]\in\mathfrak k$; by H3, $\mathfrak k\perp\mathfrak m$; so every summand is zero.

$S_{\mathfrak{mmm}}=\sum_{\alpha,\beta,\gamma\in\mathfrak m}\langle[v_\alpha,v_\beta],v_\gamma\rangle^2$. By H2, $[v_\alpha,v_\beta]\in\mathfrak k$; by H3, orthogonal to $v_\gamma\in\mathfrak m$; so every summand is zero.

**Claim 4 holds.** Neither line mentions $W$, $a$, $b$, the two-eigenvalue point or the grading. The annotation is right that *"identically"* understates them: these are identities of the pair, and the record's *"confirmed on 16 pairs across four Cartan series"* ([target.md:343](../findings/target.md)) is a check on a two-line proof, not the evidence for it.

**Claim 5 fails.** The annotation says $[\mathfrak k,\mathfrak m]\subseteq\mathfrak m$ *"is used in neither; it closes the Killing split instead."* The first half is right; the second is not. The Killing split in §4 needs $[v_\alpha,v_\beta]\in\mathfrak g$ for all $\alpha,\beta\in\mathfrak g$ (that is H1, $\mathfrak g$ a subalgebra) and the completeness of $\mathfrak k\cup\mathfrak m$ as an orthonormal basis of $\mathfrak g$, which is H3. $[\mathfrak k,\mathfrak m]\subseteq\mathfrak m$ enters neither. What it *does* supply is a second, independent proof of $S_{\mathfrak{kkm}}=0$: by H8 the block $S_{\mathfrak{kkm}}$ also equals $\sum_{\alpha\in\mathfrak k}\sum_{\beta\in\mathfrak m}\sum_{\gamma\in\mathfrak k}\langle[v_\alpha,v_\beta],v_\gamma\rangle^2$, and $[\mathfrak k,\mathfrak m]\subseteq\mathfrak m\perp\mathfrak k$ kills that. The relation is a redundancy, not a closure.

## 4. The four-invariant formula, derived

Write $N:=S_{\mathfrak{kkk}}q^2+3S_{\mathfrak{kmm}}p^2-2p^3+2pq^2$.

By H7 with the two vanishings, $\theta=\mathrm{tr}(W^3)+\tfrac12\big[a^3S_{\mathfrak{kkk}}+3ab^2S_{\mathfrak{kmm}}\big]$, and $\mathrm{tr}(W^3)=a^3p+b^3q$. Substituting $b=-ap/q$:

$$a^3p+b^3q=a^3p-\frac{a^3p^3}{q^3}q=\frac{a^3p(q^2-p^2)}{q^2},\qquad 3ab^2=\frac{3a^3p^2}{q^2}.$$

Hence

$$\theta=\frac{a^3}{2q^2}\Big[2p(q^2-p^2)+q^2S_{\mathfrak{kkk}}+3p^2S_{\mathfrak{kmm}}\Big]=\frac{a^3}{2q^2}\,N,$$

since $2p(q^2-p^2)=2pq^2-2p^3$. Squaring and using $a^6=q^3/(p^3(p+q)^3)$:

$$\theta^2=\frac{a^6N^2}{4q^4}=\frac{q^3N^2}{4q^4p^3(p+q)^3}=\frac{N^2}{4p^3q(p+q)^3}.$$

**Claim 1 holds exactly.**

**Claim 19, the annotation's *"the denominator $4p^3q(p+q)^3$ is produced by $a^6$ rather than asserted"*, is overstated.** $a^6$ supplies $p^3(p+q)^3$ in the denominator and $q^3$ in the numerator; the $4$ and the surviving single $q$ come from the $(2q^2)^{-2}$ that the elimination of $b$ leaves behind. The claim is right that the denominator is produced rather than asserted, and wrong about which factor produces it.

**Claim 14, the weights.** The bracket sum over $\mathfrak g$ splits into eight index patterns, grouped by the number of $\mathfrak m$-slots. By H8 the three patterns with one $\mathfrak m$-slot are equal, likewise the three with two, so

$$\sum_{\alpha\beta\gamma\in\mathfrak g}\lambda_\alpha\lambda_\beta\lambda_\gamma T_{\alpha\beta\gamma}=a^3S_{\mathfrak{kkk}}+3a^2bS_{\mathfrak{kkm}}+3ab^2S_{\mathfrak{kmm}}+b^3S_{\mathfrak{mmm}},$$

with $S$ read at a **fixed** slot pattern over ordered tuples, which is exactly conventions.md's reading, as its own $S^{\mathrm{ord}}_{\mathfrak{mhh}}=2S^{\mathrm{unord}}_{\mathfrak{mhh}}$ confirms (a fixed mixed pattern admits $2$ of the $6$ orderings, not $6$). Under the unordered reading every pattern picks up the full $6$, so the four weights become $6,6,6,6$ and the annotation's *"under the unordered reading L39's two coefficients become equal"* is right. **The $(1,3,3,1)$ weights and the ordered reading are confirmed.**

**But the identification with [Lemma L114](../findings/bounds-relaxations.md) conflates two different identities.** L114 is $6S_{\mathfrak{mmm}}+4S_{\mathfrak{mmh}}+2S_{\mathfrak{mhh}}=2d(n-2)$ unordered, which is $S^{\mathrm{ord}}_{\mathfrak{mmm}}+2S^{\mathrm{ord}}_{\mathfrak{mmh}}+S^{\mathrm{ord}}_{\mathfrak{mhh}}=2d(n-2)$, a **$(1,2,1)$** identity, the one-row Killing marginal. Its L39 counterpart is §5's $S_{\mathfrak{kkk}}+2S_{\mathfrak{kkm}}+S_{\mathfrak{kmm}}=cp$, with the same $(1,2,1)$, and L114 is that statement at $\mathfrak g=\mathfrak{so}(n)$, $c=2(n-2)$. The $(1,3,3,1)$ pattern is a *different* object, the cubic expansion above, and equally (as [L114](../findings/bounds-relaxations.md)'s own annotation says) the **sum** of L114 with its $\mathfrak h$-row twin. So *"L114's $6/4/2$ identity is the unordered form of the same statement"* is true of L39's Killing split and false of L39's $(1,3,3,1)$. Both underlying facts are right; the sentence pairs the wrong two.

## 5. The $\mathfrak m$-row Killing step, the load-bearing one

For $v_\alpha\in\mathfrak g$, H1 gives $[v_\alpha,v_\beta]\in\mathfrak g$, so $\lVert[v_\alpha,v_\beta]\rVert^2=\sum_{\gamma\in\mathfrak g}T_{\alpha\beta\gamma}$ with no leakage into $\mathfrak g^\perp$. The Killing constant then reads $\sum_{\beta,\gamma\in\mathfrak g}T_{\alpha\beta\gamma}=c$ for each unit $v_\alpha\in\mathfrak g$.

**Row over $\mathfrak k$** (the record's step). Summing over $\alpha\in\mathfrak k$ and splitting $(\beta,\gamma)$ across $\mathfrak k\oplus\mathfrak m$:

$$S_{\mathfrak{kkk}}+2S_{\mathfrak{kkm}}+S_{\mathfrak{kmm}}=cp\ \Longrightarrow\ S_{\mathfrak{kkk}}+S_{\mathfrak{kmm}}=cp.$$

**Row over $\mathfrak m$** (the annotation's step). Summing over $\alpha\in\mathfrak m$, the four patterns are $(\mathfrak m;\mathfrak{kk})=S_{\mathfrak{mkk}}$, $(\mathfrak m;\mathfrak{km})+(\mathfrak m;\mathfrak{mk})=2S_{\mathfrak{mkm}}$, and $(\mathfrak m;\mathfrak{mm})=S_{\mathfrak{mmm}}$. By H8, $S_{\mathfrak{mkk}}=S_{\mathfrak{kkm}}=0$ and $S_{\mathfrak{mkm}}=S_{\mathfrak{kmm}}$, and $S_{\mathfrak{mmm}}=0$. Hence

$$2S_{\mathfrak{kmm}}=cq\ \Longrightarrow\ \boxed{S_{\mathfrak{kmm}}=\tfrac{cq}2},\qquad S_{\mathfrak{kkk}}=cp-\tfrac{cq}2=c\!\left(p-\tfrac q2\right).$$

**Claim 6 holds.** The step consumes H1, H3, H8, H9 and both vanishings, nothing else, and in particular nothing about $\mathfrak k$. This is what makes $S_{\mathfrak{kkk}}$ determined rather than free.

**Three independent anchors, all from the record's own data.**

1. $(\mathfrak{su}(m),\mathfrak{so}(m))$, where target.md:389 derives $S_{\mathfrak{kmm}}=mq$ independently. The reduction gives $S_{\mathfrak{kmm}}=cq/2=(2m)q/2=mq$. Agrees.
2. The same family's $S_{\mathfrak{kkk}}=(m-2)p$. The reduction gives $c(p-q/2)=2mp-mq$, and with $q=(m+2)(m-1)/2$, $p=m(m-1)/2$ one has $mq=(m+2)p$, so $2mp-mq=(m-2)p$. Agrees.
3. $(\mathfrak{so}(6),\mathfrak u(3))$, the Hermitian witness target.md:355 uses for the $\mathfrak k$-centre correction, at $S_{\mathfrak{kkk}}=48$, $p=9$: here $q=6$, $c=2(6-2)=8$, and $c(p-q/2)=8(9-3)=48$. Agrees, **and it agrees where $\mathfrak k=\mathfrak u(3)$ has a centre and $h^\vee(\mathfrak k)$ is undefined**, which is §6's point.

## 6. The reduction to three invariants

Write $M:=cq(3p-q)-4p(p-q)$. Then

$$M(p+q)=\big[3cpq-cq^2-4p^2+4pq\big](p+q)=3cp^2q+2cpq^2-cq^3-4p^3+4pq^2,$$

the $-4p^2q+4p^2q$ cancelling. And substituting §5 into $N$,

$$2N=2c\!\left(p-\tfrac q2\right)q^2+3cqp^2-4p^3+4pq^2=2cpq^2-cq^3+3cp^2q-4p^3+4pq^2.$$

These are the same polynomial, so

$$\boxed{\,2N=(p+q)\,M\,}\qquad\Longrightarrow\qquad \theta^2=\frac{N^2}{4p^3q(p+q)^3}=\frac{M^2(p+q)^2/4}{4p^3q(p+q)^3}=\frac{M^2}{16\,p^3q(p+q)}.$$

**Claim 7 holds.** [L39.lean](../lean/HamiltonsCubic/Results/L39.lean) states the same factorisation as `numerator_factors` and `theta_sq_reduced`; my derivation is by hand and independent of it, and agrees.

**Hypotheses of the reduction:** H1–H3, H8, H9. It needs nothing about $\mathfrak k$, not simplicity, not centrelessness.

**Claim 8: the invariant count is wrong.** Both copies say the same thing under the same hypothesis. results.md: *"When $\mathfrak g$ is simple with Killing constant $c$, $S_{\mathfrak{kkk}}+S_{\mathfrak{kmm}}=cp$ … so $\theta$ depends on $p$, $q$, $S_{\mathfrak{kkk}}$ and $c$ alone"*. target.md:676: *"so $\theta$ depends on four invariants only"*. Under exactly that hypothesis, §5 determines $S_{\mathfrak{kkk}}=c(p-q/2)$, so the fourth slot is not free. The record used only the $\mathfrak k$-row of a two-row system and stopped one row early.

*Discrepancy protocol.* **(i) Located:** results.md:525-531 and target.md:676, the clause naming four invariants. **(ii) Exhibited:** $S_{\mathfrak{kkk}}=c(p-q/2)$ is an identity, so $(p,q,S_{\mathfrak{kkk}},c)$ has a rational relation among its entries and the map to $\theta^2$ factors through $(p,q,c)$; concretely, the record's own $(7,8,24,32)$ satisfies $24=8(7-4)$ and $32=8\cdot8/2$. **(iii) Opposite argued:** could the $\mathfrak m$-row fail while the $\mathfrak k$-row holds? The $\mathfrak m$-row uses H1, H3, H8, H9 and the two vanishings, a strict subset of what the four-invariant statement already assumes. There is no simple $\mathfrak g$ satisfying the one and not the other. **Confirmed.**

**Which should be canonical.** The **four-invariant form is the right canonical formula** and the three-invariant form is a corollary, because the four-invariant form needs only H1–H3, H5–H8 and survives where H9 fails, and the record itself exercises that region: target.md:369 records $\mathfrak{so}(3)\oplus\mathfrak{so}(5)\subset\mathfrak{so}(8)$ with *"$c\in\{2,6\}$ and the Killing relation fails outright"*, where $\theta^2$ is still computable from $(S_{\mathfrak{kkk}},S_{\mathfrak{kmm}})$. What must change is the **dependency sentence**, not the display: replace *"$\theta$ depends on $p,q,S_{\mathfrak{kkk}},c$ alone"* with *"$S_{\mathfrak{kkk}}=c(p-q/2)$ and $S_{\mathfrak{kmm}}=cq/2$, so $\theta$ depends on $p,q,c$ alone, and $\theta^2=M^2/(16p^3q(p+q))$"*.

**A consequence the record does not carry.** $S_{\mathfrak{kkk}}=\sum_ic_i\dim\mathfrak k_i$ over the simple ideals (direct, since $[\mathfrak k_i,\mathfrak k_j]=0$ and a centre contributes nothing), so §5 gives the identity $\sum_ic_i\dim\mathfrak k_i=c\big(p-\tfrac q2\big)$ relating $\mathfrak k$'s internal Killing constants to $\mathfrak g$'s. It is checked at $(\mathfrak{su}(m),\mathfrak{so}(m))$ and at $(\mathfrak{so}(6),\mathfrak u(3))$ above. It also makes results.md's clause *"when $\mathfrak k$ has a centre, $S_{\mathfrak{kkk}}$ is the sum over its simple ideals"* **redundant under H9**, correct, but never needed, and its presence is what signals that the entry was written a level below its own content.

## 7. $q\le2p$, and its boundary

$T_{\alpha\beta\gamma}=\langle[v_\alpha,v_\beta],v_\gamma\rangle^2\ge0$, so $S_{\mathfrak{kkk}}\ge0$. Under H9, $c>0$: for $a\ne0$ in a compact simple $\mathfrak g$, $\sum_b\lVert[a,b]\rVert^2>0$ since $\mathfrak g$ has no centre. Hence $c(p-q/2)\ge0$ forces $q\le2p$.

**Equality.** $q=2p\iff S_{\mathfrak{kkk}}=0\iff\langle[v_\alpha,v_\beta],v_\gamma\rangle=0$ for all $\alpha,\beta,\gamma\in\mathfrak k$. Since $[v_\alpha,v_\beta]\in\mathfrak k$ (H2) and $\{v_\gamma\}$ spans $\mathfrak k$, this is $[\mathfrak k,\mathfrak k]=0$, i.e. $\mathfrak k$ abelian. **Claim 9 holds**, with the equality clause.

**Boundary witnesses, both on the record.** $(\mathfrak{su}(2),\mathfrak u(1))$ at $(p,q)=(1,2)$, abelian $\mathfrak k$, equality. $(\mathfrak{so}(4),\mathfrak{so}(2)\oplus\mathfrak{so}(2))$ at $(p,q)=(2,4)$, abelian $\mathfrak k$, equality, and it is $k=2$ of the maximiser family (§8). $(\mathfrak{su}(2),\mathfrak{so}(2))$ at $(1,2)$, the $m=2$ member target.md:~400 identifies with $W_{\mathbb{CP}^2}$, equality again.

**Screen of the general claim against the classical list** (rational arithmetic on tuples I constructed for this check, reported as a screen): AI $(\mathfrak{su}(m),\mathfrak{so}(m))$, $q/p=(m+2)/m\le2$ with equality at $m=2$; AII $(\mathfrak{su}(2n),\mathfrak{sp}(n))$, $q=(2n+1)(n-1)$ against $2p=2n(2n+1)$; AIII Grassmannian, $q=2ab$ against $2p=2(a^2+b^2-1)$, i.e. $2(a-b)^2+2ab-2\ge0$; BDI, §8; DIII $(\mathfrak{so}(2m),\mathfrak u(m))$, $q=m(m-1)$ against $2p=2m^2$; EVIII $(\mathfrak e_8,\mathfrak{so}(16))$, $128\le240$. Group type $(\mathfrak g\oplus\mathfrak g,\Delta\mathfrak g)$ gives $q=p$ but has $\mathfrak g$ non-simple, so H9 excludes it, the corollary's hypothesis is doing real work there.

## 8. The maximiser

$(\mathfrak{so}(2k),\mathfrak{so}(k)\oplus\mathfrak{so}(k))$: $p=2\binom k2=k(k-1)$, and $q=\dim\mathfrak{so}(2k)-p=k(2k-1)-k(k-1)=k^2$. Both as stated. With $n=2k$ and the table's first row, $c=2(n-2)=4(k-1)$.

$$3p-q=3k(k-1)-k^2=k(2k-3),\qquad p-q=-k,$$
$$M=4(k-1)k^2\cdot k(2k-3)+4k(k-1)k=4k^2(k-1)\big[k(2k-3)+1\big]=4k^2(k-1)(2k-1)(k-1),$$

since $2k^2-3k+1=(2k-1)(k-1)$. So $M=4k^2(k-1)^2(2k-1)$, **the annotation's collapse, exactly.**

$$p+q=k(2k-1),\qquad 16p^3q(p+q)=16k^3(k-1)^3\cdot k^2\cdot k(2k-1)=16k^6(k-1)^3(2k-1),$$
$$\theta^2=\frac{16k^4(k-1)^4(2k-1)^2}{16k^6(k-1)^3(2k-1)}=\frac{(k-1)(2k-1)}{k^2}.$$

At $n=2k$, $\theta_0(n)^2=\dfrac{2(n-1)(n-2)}{n^2}=\dfrac{2(2k-1)\cdot2(k-1)}{4k^2}=\dfrac{(k-1)(2k-1)}{k^2}$. **Equal, exactly. Claim 11's value holds.**

**Uniqueness of $c$.** With $c$ free, $M=k^2\big[ck(2k-3)+4(k-1)\big]$, and matching $\theta^2$ needs $M=\pm4k^2(k-1)^2(2k-1)$. The $+$ branch gives $ck(2k-3)=4(k-1)\big[(k-1)(2k-1)-1\big]=4(k-1)k(2k-3)$, hence $c=4(k-1)$ for every $k\ge2$; the $-$ branch forces $c<0$, excluded by H10. **So $c=4(k-1)$ is forced, and the annotation's *"exactly when $c=4(k-1)$"* is right, including the "exactly".** With $h^\vee(\mathfrak{so}(2k))=2k-2$ this is $c=2h^\vee$ at $I_\rho=1$, so the maximiser does pin the normalisation.

**The boundary this misses.** At $k=2$ ($n=4$) the family gives $p=2$, $q=4$, $c=4$, $\theta^2=3/4=\theta_0(4)^2$, but $\mathfrak g=\mathfrak{so}(4)=\mathfrak{so}(3)\oplus\mathfrak{so}(3)$ is **not simple**, so H9 fails at the smallest member of the family the annotation calls "in scope". The value survives because the two factors are isomorphic and identically embedded, so a single $c$ still exists, which is precisely the condition target.md:369 shows failing for $\mathfrak{so}(3)\oplus\mathfrak{so}(5)$. **The annotation's *"the non-simple $\mathfrak{so}(k)\oplus\mathfrak{so}(k)$ is $\mathfrak k$, while $\mathfrak g=\mathfrak{so}(2k)$ is simple"* is right for $k\ge3$ and false at $k=2$.** The repair is one clause: $k\ge3$, or "$\mathfrak g$ simple, or semisimple with a single Killing constant".

**Odd $n$.** conventions.md gives $\Theta_n=\theta_0(n)$ at even $n$ only; at odd $n$ the diagonal maximum is the unbalanced $S^{(n-1)/2}\times S^{(n+1)/2}$, whose Weyl tensor has three distinct eigenvalues and is therefore outside the two-eigenvalue ansatz. **The annotation's "structural silence" claim is correct.** Its phrase *"which this formula cannot reach"* is loose, the formula is perfectly *defined* on unbalanced pairs, as §9 shows by evaluating it there; what it cannot do is return a Weyl tensor's $\theta$ there.

## 9. Admissibility, the gap, and what hypothesis is missing

**Claim 12.** results.md carries the guard verbatim: *"The formula gives the value of the point and decides nothing about whether that point is a Weyl tensor: Weyl-ness is a property of the embedding $\rho$…"*. The block at [target.md:672-676](../findings/target.md) states the formula and the invariant count with **no scope sentence at all**. The annotation's claim is confirmed *for the block*; it is worth saying that the same file carries the guard at line 367 (*"The ansatz … is generically not a Weyl tensor at all: of 16 pairs Gate 2 built, only three pass Ricci-flat + Bianchi + criticality"*), some 300 lines above. So the file is not silent; the block is, and the block is what a reader arriving from results.md's *"Proof: target.md"* pointer will read.

**Claim 13, screened in closed form.** At $n=9$ take $(\mathfrak{so}(9),\mathfrak{so}(4)\oplus\mathfrak{so}(5))$: $p=6+10=16$, $q=36-16=20$, $c=2(9-2)=14$.

$$M=14\cdot20\cdot(48-20)-4\cdot16\cdot(16-20)=7840+256=8096=2^5\cdot253,$$
$$16p^3q(p+q)=16\cdot4096\cdot20\cdot36=47185920,\qquad \theta^2=\frac{8096^2}{47185920}=\frac{64009}{46080}.$$

Against $\Theta_9^2=\dfrac{2\cdot8\cdot6}{10\cdot7}=\dfrac{48}{35}$: cross-multiplying, $64009\cdot35=2240315>2211840=48\cdot46080$. **The overshoot is real and exhibited without a single decimal.** ($64009/46080$ agrees with the annotation's $1.389084$ to the digits given; $48/35$ with its $1.371429$.)

At $n=5$ take $(\mathfrak{so}(5),\mathfrak{so}(2)\oplus\mathfrak{so}(3))$: $p=4$, $q=6$, $c=6$, $M=216+32=248$, denominator $16\cdot64\cdot6\cdot10=61440$, so $\theta^2=61504/61440=961/960$. Against $\Theta_5^2=8/9$: the ratio is $\dfrac{961}{960}\cdot\dfrac98=\dfrac{8649}{7680}$, and $8649/7680-1=969/7680$, i.e. **$12.6\%$ over, the annotation's figure, exact.**

**What hypothesis the formula needs to be about Weyl tensors at all.** The formula computes $P(W)$ for $W=a\Pi_{\mathfrak k}+b\Pi_{\mathfrak m}$ as an operator on $\Lambda^2\mathbb R^n$. For that number to be a $\theta$ in the sense of [conventions.md](../findings/conventions.md) (*"$P(W)/\lVert W\rVert^3$"* with $W\in\mathcal W_n$), the missing hypothesis is **$W\in\mathcal W_n$**, which is two conditions the ansatz does not supply:

- **first Bianchi**, the $\Lambda^4\mathbb R^n$ component of $W$ vanishes; and
- **Ricci-flatness**, the trace over one index pair vanishes, which is strictly stronger than the $\mathrm{tr}\,W=ap+bq=0$ that H5 imposes.

And for $\theta$ to be a *critical* value, H13, $Q(W)=\theta W$, is a third. The record already names all three at target.md:367 (*"Ricci-flat + Bianchi + criticality"*) and its sufficient condition at target.md:470 (*"$(\Lambda^4\mathbb R^n)^K=0$ and $\dim\mathcal W_n^K=1$"*, where the first kills the Bianchi obstruction and the second forces the invariant operator to be the Weyl tensor up to scale).

**Why the overshoot family is exactly the family that fails.** target.md:367 records that *"$(\mathfrak{so}(p+q),\mathfrak{so}(p)+\mathfrak{so}(q))$ with $p\ne q$ fails Ricci-flatness"*, the unbalanced sphere pairs, which are precisely the $n=5$ and $n=9$ evaluations above. The geometric reason is clean: the Weyl tensor of $S^r\times S^s$ with $r\ne s$ has **three** distinct eigenvalues, one per sphere block plus the mixed block, so it is not of the form $a\Pi_{\mathfrak k}+b\Pi_{\mathfrak m}$ at all. The two-eigenvalue ansatz forces the two sphere blocks equal, producing an operator that is not the Weyl tensor of anything, and the value it returns exceeds $\Theta_n$, which no Weyl tensor's does. **The overshoot is not a defect in the formula; it is a proof that the missing hypothesis is load-bearing.** That is exactly why *"restoring the Weyl-ness scope sentence is the load-bearing repair"* is right.

## 10. The traps, each by name

**$\ker W\ne0$ and padded objects.** $W$ annihilates $\mathfrak g^\perp$, of dimension $\binom n2-p-q$, at $\mathfrak{su}(4)\subset\mathfrak{so}(8)$ that is $28-15=13$. This is harmless: the kernel directions carry $\lambda=0$, so they drop from $\mathrm{tr}(W^3)$ and from every $T$-contraction, while $\lVert W\rVert^2$ and $\mathrm{tr}\,W$ sum over $\mathfrak g$ alone as H5/H6 state, and $[\mathfrak g,\mathfrak g]\subseteq\mathfrak g$ prevents any leakage into $\mathfrak g^\perp$ in the Killing sum. **But it has a consequence the block never draws: $n$ does not appear in the formula, so the formula cannot see padding.** target.md:369 presents this as a defect, *"$\rho$ is a free infinite parameter: $(\mathfrak{su}(2),\mathfrak u(1))$ on 1, 2, 3 copies of $\mathbb C^2$ keeps $(p,q)=(1,2)$ while $\theta^2$ runs $3/2,\ 2/3,\ 25/54$"*. Under §6 it is not a defect but a determination, because $c$ carries $\rho$. Screening it: at $(p,q)=(1,2)$, $M=2c+4$ and $16p^3q(p+q)=96$, so $\theta^2=(2c+4)^2/96$. Under the diagonal embedding into $k$ copies the ambient norm multiplies by $k$ while the bracket-norm sum also multiplies by $k$, so $c$ divides by $k$: $c=4,2,4/3$. Then $\theta^2=144/96=3/2$, $64/96=2/3$, and $(20/3)^2/96=400/864=25/54$. **All three of the record's values reproduced from $(p,q,c)$ alone**, the padded objects confirm the three-invariant reduction rather than contradicting it, and the record's framing of them as evidence against a functional dependence is aimed at admissibility, not at $\theta$.

**Smallest admissible $p$ and $q$.** H4 is nowhere stated. $p=0$ makes $a^2=q/(p(p+q))$ undefined and the denominator zero; $q=0$ likewise. Under H9 both are automatic ($\mathfrak k=0$ would force $\mathfrak g$ abelian), but the "any symmetric pair" statement has no such protection. The smallest case that *is* admissible, $(p,q)=(1,2)$, is exercised above and works.

**$\mathfrak k$ abelian.** The $q=2p$ boundary: $M=2cp^2+4p^2$, denominator $96p^5$, so $\theta^2=(c+2)^2/(24p)$. At $p=1$, $c=4$ this is $36/24=3/2$, the record's $m=2$ member of the $(\mathfrak{su}(m),\mathfrak{so}(m))$ family, at *"exactly $\mathbf{3/2}$"*, identified there with $W_{\mathbb{CP}^2}$. Consistent, and a fourth independent anchor on H7's $\tfrac12$.

**$\mathfrak g$ not simple.** Two distinct failures, and the record conflates them. (a) Non-isomorphic factors: no single $c$, so §5 and §6 are unavailable and only the four-invariant form survives, target.md:369's $\mathfrak{so}(3)\oplus\mathfrak{so}(5)$. (b) Isomorphic factors, identically embedded: a single $c$ exists and everything survives, the $k=2$ maximiser of §8. The corollary $q\le2p$ is stated for *"$\mathfrak g$ simple"*, which is sufficient but not necessary; it excludes the group-type pair $(\mathfrak g\oplus\mathfrak g,\Delta\mathfrak g)$, where a single $c$ does exist and $q=p$, so no falsifier lives there either.

**The crossover $n=6+2\sqrt7$.** [Post F7](../findings/fence-posts.md) requires every candidate inequality to see it. L39 states no inequality, so the post does not bind, but the maximiser family does cross it: $\theta^2=\theta_0(n)^2$ exceeds $3/2$ from $n=12$ on ($k=6$, per target.md:343 *"exceeds $\sqrt{3/2}$ from $k=6$ on"*), and $6+2\sqrt7\approx11.29$ sits between the last member below and the first above, at even $n$ where $\theta_0=\Theta_n$. **The formula is consistent with the crossover and does not contradict it.**

**Proven on a subfamily, used in general.** target.md:389 derives the vanishings and the closed forms for $(\mathfrak{su}(m),\mathfrak{so}(m))$ only, and target.md:343 generalises with *"confirmed on 16 pairs across four Cartan series"*, a numerical confirmation standing in for a proof. §3 supplies the two-line proof the record never wrote, so the generalisation is sound, but **the record's stated warrant for it is a census, not an argument.** (The census count is itself inconsistent: target.md:343 says *"four Cartan series"* and [07-gradedness-split.tex:1127](../report/sections/07-gradedness-split.tex) says *"five"*. target.md names five distinct types by hand, AI, AII/AIII, BDI, CI, DIII, so "four" is the likelier stale figure, but the census data is not on the record and I cannot settle it analytically.)

**A hypothesis stated but never used.** results.md's *"$\mathfrak g\subseteq\mathfrak{so}(n)$"* names $n$, which appears nowhere in the formula; it is used only to fix the inner product that defines $c$, so the *value* of $n$ is inert. And the centre clause is redundant under H9 (§6).

**A step using a hypothesis never stated.** Three: H3 (§below), H4, and H7's factor $\tfrac12$ on the $\#$-term, which is imported from [conventions.md](../findings/conventions.md)'s *"the $\tfrac12$ goes at the $\Lambda^2$ level, not the operator level"* and never justified in the block. H7 is load-bearing (halving or doubling it moves every $\theta$) and it is validated here by four independent anchors: $(\mathfrak{su}(m),\mathfrak{so}(m))$ returning $m(m+1)/((m-1)(m+2))$, the balanced pair returning $\theta_0(2k)^2$ exactly, the $\mathbb{CP}^2$ member returning $3/2$, and the $(\mathfrak{su}(2),\mathfrak u(1))$ copies returning $3/2,2/3,25/54$. That is calibration, not derivation, but it is four-fold.

**A universal claim with no witness.** None found. Both vanishings have a proof and 16 checks; $q\le2p$ has a proof and three equality witnesses; the maximiser identity has a proof and an exact closed form at every $k$.

**An imported theorem whose hypotheses were never checked.** $c=2h^\vee(\mathfrak g)/I_\rho$ requires $\mathfrak g$ simple; the record states that hypothesis and checks it at every use. The unital-algebra trap that killed the Tkachev route, [fence-posts.md:185](../findings/fence-posts.md), *"assumes a **unital** Euclidean metrised algebra"*, against $\mathcal W_n$ having no unit, is not reachable from L39, which imports nothing of that kind. **Clear.**

**Symbol collisions.** Three, one of them live and dangerous.

- **$p$, $q$, a collision inside target.md itself.** L39 uses $(p,q)=(\dim\mathfrak k,\dim\mathfrak m)$; [conventions.md](../findings/conventions.md) uses $W_{p,q}$ for the sphere product with $p+q=n$; and **target.md:367, twenty-six lines below the boxed L39 formula, writes *"$(\mathfrak{so}(p+q),\mathfrak{so}(p)+\mathfrak{so}(q))$ with $p\ne q$"* in the sphere sense.** At the maximiser the two readings are $(k,k)$ and $(k(k-1),k^2)$, different by an order of magnitude, and nothing on the page disambiguates. This is the most reader-hostile defect in the block.
- **$c$** collides with [fence-posts.md](../findings/fence-posts.md)'s idempotent $c$, where *"$\theta=1/\lVert c\rVert$"* and Tkachev's $|c|^2\le\tfrac12|e|^2$ live. Different objects, same letter, both about $\theta$.
- **$\mathfrak k$/$\mathfrak m$ against $\mathfrak m$/$\mathfrak h$.** L39's two-block split is $(\mathfrak k,\mathfrak m)$; [L114](../findings/bounds-relaxations.md)'s identical construction is $(\mathfrak m,\mathfrak h)$ with $\mathfrak m$ the negative eigenspace, so **L39's $\mathfrak m$ and L114's $\mathfrak m$ are opposite blocks of the same shape of split**, and conventions.md already flags $\mathfrak m$ as carrying three senses. §4 shows the two identities are the same theorem; nothing cross-references them.
- **$S_{XYZ}$ against this block's weights:** checked in §4 and consistent with the settled ordered reading. **No collision.**

## 11. The claims I found stale or reversed

**Claim 18.** The annotation asserts *"$S_{XYZ}$ is defined nowhere on the record, [conventions.md](conventions.md) included."* [conventions.md](../findings/conventions.md) has defined it since 2026-09-04 (*"the block-restricted contraction of $T$ over ORDERED slots"*), on the recommendation of r639 and r640. **The annotation is stale and, as written, false.**

**Claim 10, the "forced" pair.** The fact is right: $(\mathfrak{so}(6),\mathfrak{so}(2)\oplus\mathfrak{so}(4))$ and $(\mathfrak{su}(4),\mathfrak s(\mathfrak u(2)\oplus\mathfrak u(2)))$ both have $p=1+6=7=3+3+1$, $q=15-7=8$, and $c=2(6-2)=8=2\cdot4$, the first from the $\mathfrak{so}(n)$ row of the table, the second from the $\mathfrak{su}(m)$ row, landing on the same $8$ from different formulas. §5 then gives $S_{\mathfrak{kmm}}=32$ and $S_{\mathfrak{kkk}}=24$, reproducing target.md:369's $(7,8,24,32)$, and $M=64\cdot13+28=860$, $16\cdot343\cdot8\cdot15=658560$, $\theta^2=739600/658560=9245/8232$, the record's value, exactly. **But the wording reverses its own implication.** *"The record's known equal-$\theta$ pair is forced"* reads as *equal $\theta$ forces $(7,8,8)$*, which is false: $\theta^2=M^2/(16p^3q(p+q))$ is one equation in three unknowns and cannot pin a triple. The true statement is the converse, and [L39.lean](../lean/HamiltonsCubic/Results/L39.lean)'s own docstring has it right, *"a coincidence in those forces a coincidence in θ"*. The annotation contradicts the file it cites.

**Claim 20, triality.** *"Neither member of the $n=8$ pair is in scope"* has no fixed referent: the balanced pair at $k=4$, $(\mathfrak{so}(8),\mathfrak{so}(4)\oplus\mathfrak{so}(4))$, **is** in scope and returns $\theta^2=(k-1)(2k-1)/k^2=21/16=\theta_0(8)^2$. If the referent is the $(7,8,8)$ pair of claim 10, then $(\mathfrak{su}(4),\ldots)$ does sit inside $\mathfrak{so}(8)$ and is in scope for the formula, though not for Weyl-ness. The substantive half (*"the formula is triality-blind by construction"*), is right for a reason the annotation does not give: the formula reads only $(p,q,c)$, and triality permutes the three $8$-dimensional representations of $\mathfrak{so}(8)$ without changing dimensions, $h^\vee$, or the index, hence without changing $c$.

## 12. The table's two columns

The row under audit, [target.md:~360](../findings/target.md):

| $\mathfrak g$, $\rho$ | $h^\vee$ | $I_\rho$ | $c=2h^\vee/I_\rho$ |
| --- | --- | --- | --- |
| $\mathfrak{so}(m)\subset\mathfrak{su}(m)$, $\mathbb R^m\oplus\mathbb R^m$ | $m-2$ | $2$ | $m-2$ |

**Both middle columns fail at $m=3$.** $\mathfrak{so}(3)\cong\mathfrak{su}(2)=A_1$ has $h^\vee=2$, against the row's $m-2=1$. Since the product must stay $m-2=1$, the index must be $I_\rho=2h^\vee/c=4$, against the row's $2$. **Both columns are wrong, and their error cancels.** At $m=4$, $\mathfrak{so}(4)=\mathfrak{su}(2)\oplus\mathfrak{su}(2)$ is not simple, so $h^\vee$ is undefined and $2h^\vee/I_\rho$ has no meaning; the row's $m-2=2$ coincides with the per-factor $h^\vee$, which is a coincidence, not a reading.

**The doubling argument, checked, and it works.** The claim is that $c=m-2$ survives at both. It does, and the argument uses no representation theory at all. Embed $\mathfrak{so}(m)$ in $\mathfrak{so}(2m)$ diagonally, $X\mapsto\hat X=X\oplus X$. Then $\lVert\hat X\rVert^2=2\lVert X\rVert^2$ and $[\hat X,\hat Y]=\widehat{[X,Y]}$, so an ambient-orthonormal basis of the image is $\{\hat Y_i/\sqrt2\}$ for $\{Y_i\}$ orthonormal in $\mathfrak{so}(m)$, and

$$\sum_i\Big\lVert\big[\hat X,\tfrac{\hat Y_i}{\sqrt2}\big]\Big\rVert^2=\tfrac12\sum_i2\lVert[X,Y_i]\rVert^2=\sum_i\lVert[X,Y_i]\rVert^2=2(m-2)\lVert X\rVert^2=(m-2)\,\lVert\hat X\rVert^2,$$

the middle equality being **[Lemma L153](../findings/bounds.md)** at $\mathfrak{so}(m)$, which holds *"at any $n\ge2$"*. So $c=m-2$, uniformly in $m$, with no $h^\vee$ and no $I_\rho$ anywhere. **Claim 17 holds: the product survives at $m=3$ and $m=4$, and no value moves.**

**Confirmed against §5 at both boundaries.** At $m=3$: $p=3$, $q=(m+2)(m-1)/2=5$, $c_{\mathfrak g}=2m=6$, and $S_{\mathfrak{kkk}}$ is $c_{\mathfrak k}p=1\cdot3=3$ from the table and $c_{\mathfrak g}(p-q/2)=6(3-5/2)=3$ from the reduction, **agree**. At $m=4$: $p=6$, $q=9$, $c_{\mathfrak g}=8$, giving $2\cdot6=12$ and $8(6-9/2)=12$, **agree**. At $m=2$: $c_{\mathfrak k}=0$, $p=1$, $S_{\mathfrak{kkk}}=0$, and $4(1-1)=0$, **agree**, with $\mathfrak{so}(2)$ abelian as §7 requires.

**And the same defect reaches row 1, at $n=3$.** The row *"$\mathfrak{so}(n)$, standard | $n-2$ | $1$ | $2(n-2)$"* has $h^\vee(\mathfrak{so}(3))=2$ rather than $n-2=1$, so the rule $2h^\vee/I_\rho$ returns $4$ while [L153](../findings/bounds.md) gives $c=2(n-2)=2$ outright. The index is the column at fault: the $\mathfrak{so}(3)$ vector representation **is** the adjoint of $\mathfrak{su}(2)$, so $I_\rho=2$ under the normalisation that sets the $\mathfrak{so}(n)$ vector to $1$, and the row's $I_\rho=1$ is generic-$n$ data. **The $c$ column is right at every $n\ge2$ because L153 proves it directly; the factorisation into $2h^\vee/I_\rho$ is what fails, in row 1 at $n=3$ and in row 3 at $m=3$ and $m=4$.**

**What must change in the record.** Nothing in the $c$ column, and no downstream value. The defect is that the middle two columns are presented as a general-$m$ rule when they are generic-$m$ data; the row needs either $m\ge5$ on it, or a note that at $m=3,4$ the product is the object and the factorisation into $2h^\vee/I_\rho$ is not available. **Reported as a presentation defect, not a broken value.**

## 13. The unstated hypothesis, with a falsifier

**H3, $\mathfrak k\perp\mathfrak m$ in the ambient inner product, is used in every step of L39 and stated in none of the three copies.**

It is what makes $\Pi_{\mathfrak k}$ and $\Pi_{\mathfrak m}$ orthogonal projectors, hence what makes $\mathrm{tr}\,W=ap+bq$ and $\lVert W\rVert^2=a^2p+b^2q$; it is what kills both blocks in §3; and it is what makes $\{v_\alpha\}_{\mathfrak k}\cup\{v_\gamma\}_{\mathfrak m}$ an orthonormal basis of $\mathfrak g$ in §5.

Under H9 it is automatic: $\sigma$ is an involutive automorphism of a simple compact $\mathfrak g$, the ambient form restricted to $\mathfrak g$ is $\mathrm{ad}$-invariant hence proportional to the Killing form, the Killing form is $\mathrm{Aut}(\mathfrak g)$-invariant, so $\sigma$ is self-adjoint and its $\pm1$ eigenspaces are orthogonal. **But the lemma is stated for an *arbitrary* symmetric pair, with no simplicity, and there it can fail.**

*Discrepancy protocol.* **(i) Located:** results.md:525-531 and target.md:672, the clause *"For any symmetric pair $(\mathfrak g,\mathfrak k)$ inside $\mathfrak{so}(n)$"*. **(ii) Exhibited in closed form:** take $\mathfrak g=\mathfrak{su}(2)\oplus\mathfrak{su}(2)$ embedded in $\mathfrak{so}(12)$ with the first factor acting on one copy of $\mathbb C^2$ and the second on two copies, so the ambient norm is $\lVert(X,Y)\rVert^2=\lVert X\rVert_1^2+2\lVert Y\rVert_1^2$. The swap $\sigma(X,Y)=(Y,X)$ is an involutive automorphism with $\mathfrak k=\{(X,X)\}$ and $\mathfrak m=\{(Z,-Z)\}$, and

$$\big\langle(X,X),(Z,-Z)\big\rangle=\langle X,Z\rangle_1+2\langle X,-Z\rangle_1=-\langle X,Z\rangle_1,$$

which is nonzero for $X=Z\ne0$. So $\mathfrak k\not\perp\mathfrak m$, $\langle[\mathfrak m,\mathfrak m],\mathfrak m\rangle\ne0$, and $S_{\mathfrak{mmm}}$ does not vanish. **(iii) Opposite argued:** could the record mean orthogonality definitionally? Its own definition of a symmetric pair carries no ambient-invariance condition, its statement says only *"inside $\mathfrak{so}(n)$"*, and target.md:369 explicitly contemplates non-simple $\mathfrak g$ with unequal factor scales ($\mathfrak{so}(3)\oplus\mathfrak{so}(5)$, *"$c\in\{2,6\}$"*), the exact regime where the failure lives. **Confirmed.**

**Grade: HYPOTHESIS-DEBT, not BROKEN.** Every use of L39 on the record has $\mathfrak g$ simple or has isomorphic factors identically embedded, so no consumed value moves. The repair is one clause on each of the three copies: *"with $\mathfrak k\perp\mathfrak m$ in the ambient form, automatic when $\mathfrak g$ is simple"*.

## 14. What would falsify it, and what I did to look

**The object.** A symmetric pair $(\mathfrak g,\mathfrak k)$ with $\mathfrak g$ simple, $\mathfrak g\subseteq\mathfrak{so}(n)$, and $\dim\mathfrak m>2\dim\mathfrak k$. It would break §7's corollary, and with it §5's $S_{\mathfrak{kkk}}=c(p-q/2)$, and with it §6's reduction, leaving the four-invariant form standing but the three-invariant form false.

**What I did.** Such an object would have to break $S_{\mathfrak{kkk}}\ge0$ (impossible, $T$ is a square) or $c>0$ (impossible for compact simple $\mathfrak g$), so the falsifier cannot exist under H9 and the search is over the *hypotheses*, not the list. I therefore checked the hypotheses' boundary instead: **$\mathfrak g$ non-simple** produced the group-type pair $(\mathfrak g\oplus\mathfrak g,\Delta\mathfrak g)$ at $q=p$ (no falsifier) and the scale-asymmetric swap of §13 (a genuine falsifier of the *scope*, not of the corollary); **$\mathfrak k$ abelian** produced three equality witnesses, all consistent; **$p=0$ or $q=0$** produced H4. Separately I screened the classical list (AI, AII, AIII, BDI, CI/CII, DIII and EVIII), in §7, all with margin except the abelian boundary.

**A second falsifier, and it does not exist either.** A two-eigenvalue point that *is* a genuine Weyl tensor, is critical, and has $\theta>\Theta_n$, which would contradict conventions.md's $\Theta_n$ as the diagonal maximum. The $n=5$ and $n=9$ overshoots of §9 are **not** such witnesses: target.md:367 records the unbalanced $(\mathfrak{so}(r+s),\mathfrak{so}(r)\oplus\mathfrak{so}(s))$ family as failing Ricci-flatness, and §9 gives the structural reason (three eigenvalues, not two). I found no candidate that passes both the ansatz and admissibility above $\Theta_n$; the only in-scope family that attains $\Theta_n$ is the balanced one, exactly.

**A third, on the formula itself.** A pair where the four-invariant and three-invariant forms disagree. §6 shows $2N=(p+q)M$ is a polynomial identity in $(p,q,c)$, so disagreement is impossible wherever §5 applies; the only way to separate them is to leave H9, where the three-invariant form has no $c$ to be about.

## Verdict

**PROVEN, hypotheses corrected.**

The mathematics is sound. Both closed forms are correct, the four-invariant form is derived from the ansatz in full above, the three-invariant form follows exactly by $2N=(p+q)M$, and the balanced pair returns $\theta_0(n)^2$ with $c=4(k-1)$ uniquely. Six of the corrections are to what the block *says* rather than to what it computes:

1. **The invariant count is one too high** in both copies, three, not four, under the stated hypothesis (§6). *The single substantive correction.*
2. **H3 ($\mathfrak k\perp\mathfrak m$ in the ambient form) is used everywhere and stated nowhere**, with a falsifier for the "any symmetric pair" scope (§13).
3. **H4, H5, H6 are absent from results.md**, the canonical statement literally under-determines $W$ (§1).
4. **The block carries no admissibility scope**, and the overshoot at $n=5$ and $n=9$ shows the guard is load-bearing (§9).
5. **The $h^\vee$ and $I_\rho$ columns fail at $m=3$ and $m=4$**; the product survives by a doubling argument that needs only [L153](../findings/bounds.md), and no value moves (§12).
6. **Four annotation statements are stale, mis-attributed, reversed, or unreferenced**: the $S_{XYZ}$ definition (stale), the role of $[\mathfrak k,\mathfrak m]\subseteq\mathfrak m$ (mis-attributed), the direction of "forced" (reversed, against its own Lean file), and the $n=8$ triality referent (unfixed), plus the $k=2$ member of the maximiser family, where $\mathfrak g=\mathfrak{so}(4)$ is not simple.

The live symbol collision on $p$ and $q$, L39's $(\dim\mathfrak k,\dim\mathfrak m)$ against the sphere-product reading used **twenty-six lines below the boxed formula in the same file**, is the defect most likely to mislead a reader, and it is not annotated at all.
