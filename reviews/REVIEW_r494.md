# REVIEW r494, Lemma L73

**Target.** [Lemma L73](../findings/bounds.md), "a purely spectral necessary condition on all of $\mathcal W_n$", [findings/bounds.md](../findings/bounds.md) lines 313–326, from the `#### Lemma L73` heading to the `#### Lemma L107` heading. Cited 17 times; cites nothing.

**VERDICT: CONFIRMED**, *the headline inequality is true, and I prove it below in three lines; the constant $n-2$ is sharp and I verify all three sharpness families by hand.* **But the block carries two false surviving sentences, one broken derivation line, one false numerical sub-claim, and a stale index row.** The lemma stands; four sentences must go.

## Summary of findings

| # | Where | Finding |
| --- | --- | --- |
| **D1** | [bounds.md](../findings/bounds.md) line 321 | **FALSE SENTENCE.** "Lemma L73 is therefore the whole of what the row calculus says on $\mathcal W_n$", refuted twice over, once *four lines above it inside the same block* and once at line 351 by name |
| **D2** | [bounds.md](../findings/bounds.md) line 323 | **FALSE ATTRIBUTION.** "The derivation uses only (B) and $T\ge0$", (A) is load-bearing and is exactly where the constant $n-2$ comes from |
| **D3** | [bounds.md](../findings/bounds.md) line 326 | **BOUNDARY MISDRAWN.** The block's closing display $\theta\le\lambda_{\min}+(n-2)\lambda_{\max}$ consumes (C), hence criticality, yet sits at the end of the blockquote titled "IT NEEDS NO CRITICALITY", under a heading reading "on all of $\mathcal W_n$", one sentence after "this is a constraint on the spectrum of every Weyl tensor" |
| **D4** | [bounds.md](../findings/bounds.md) line 306 | **BROKEN STEP, the only derivation L73 has.** "$\lambda_a/(n-2)$ must lie in $[\lambda_{\min},\lambda_{\max}]$" is **vacuous**; the true statement carries a minus sign |
| **D5** | [bounds.md](../findings/bounds.md) line 319 | **FALSE NUMERICAL SUB-CLAIM.** The row-range sharpening is claimed to halve the slack at padded $W_{\mathbb{CP}^2}$ ($0.272166\to0.136083$). It cannot bite there at all: $\lambda_{\min}$ has multiplicity $2$, so $\lambda_{(1)}=\lambda_{(2)}=\lambda_{\min}$ and the two bounds are *identical* |
| **D6** | [bounds.md](../findings/bounds.md) lines 319, 323 | **WITHDRAWN CLAIM SURVIVING.** Line 317 restricts torus saturation to **even $n$**; lines 319 and 323 both re-assert it unqualified. Line 319 also calls the balanced products a "saturating family" while reporting their slack as $0.1318$ |
| **D7** | [INDEX-results.md](../findings/INDEX-results.md) line 87 | **STALE INDEX ROW, asserting something L73 itself forbids.** L73's row still reads "sharp on $\mathbb{CP}^m$ and on **every** maximal torus", the pre-r335 sharpness families, with the flagship witness $S^2\times S^{n-2}$ absent |
| **C1** | headline box | **CONFIRMED.** $-(n-2)\lambda_{\max}\le\lambda_a\le(n-2)\lvert\lambda_{\min}\rvert$ on all of $\mathcal W_n$; proof below |
| **C2** | headline box | **CONFIRMED.** $n-2$ is attained at $S^2\times S^{n-2}$ for every $n\ge4$, odd and even, closed form and the row mechanism both verified by hand at $n=5$ |
| **C3** | headline box | **CONFIRMED.** "Not implied by tracelessness, which gives only $N-1$", $N-1$ is the sharp traceless constant, and $n-2<N-1$ for every $n\ge3$ |
| **C4** | line 317 | **CONFIRMED.** The strengthening $\lambda_{\max}\le-\tfrac{n-2}2(\lambda_{(1)}+\lambda_{(2)})$ derives correctly and is strictly stronger when $\lambda_{\min}$ is simple |
| **C5** | line 335 (r337) | **CONSISTENT, but L73 is a *lossy* projection and the block says otherwise.** See D1 |

---

## P1, the three ingredients, derived cold

The block's relations, at [bounds.md](../findings/bounds.md) line 223, with $T_{abc}=c_{abc}^2$, $c_{abc}=\langle[v_a,v_b],v_c\rangle$ in an orthonormal eigenbasis of $W$ on $\Lambda^2\mathbb R^n\cong\mathfrak{so}(n)$:

$$\text{(A)}\ \sum_{\beta\gamma}T_{k\beta\gamma}=2(n-2),\qquad \text{(B)}\ \sum_{\beta\gamma}\lambda_\beta T_{k\beta\gamma}=-2\lambda_k,\qquad \text{(C)}\ \sum_{\beta\gamma}\lambda_\beta\lambda_\gamma T_{k\beta\gamma}=2\lambda_k(\theta-\lambda_k).$$

**(A), hypotheses: none beyond an orthonormal basis of $\mathfrak{so}(n)$.** $\sum_\gamma T_{k\beta\gamma}=\lVert[v_k,v_\beta]\rVert^2$, so (A) is the Killing marginal $\sum_\beta\lVert[v_k,v_\beta]\rVert^2$, a fact about $\mathfrak{so}(n)$ alone. It is $I\#I=(n-2)I$ read on the diagonal, [Böhm–Wilking notes](../references/boehm-wilking-2008-space-forms/notes.md), Lemma 2.1 at $R=I$. **Holds on all of $\mathcal W_n$, and indeed independently of $W$.**

**(B), hypotheses: first Bianchi *and* Ricci-flatness; nothing else.** [Böhm–Wilking](../references/boehm-wilking-2008-space-forms/notes.md) Lemma 2.1 reads $R+R\#I=(n-1)R_I+\tfrac{n-2}2R_{\mathrm{Ric}_0}$ for $R\in S^2_B(\mathfrak{so}(n))$, and puts $\langle W\rangle$ in the kernel: $W\#I=-W$. On the diagonal that is $\sum_{\beta\gamma}\lambda_\beta T_{k\beta\gamma}=-2\lambda_k$. $S^2_B$ is where first Bianchi lives; the $\langle W\rangle$ summand is where Ricci-flatness lives. **Criticality appears nowhere. (B) is a Weyl identity holding on all of $\mathcal W_n$, CONFIRMED.**

*The factor-$2$ check.* The notes give $(W\#I)_{kk}=\tfrac12\sum_{\beta\gamma}\lambda_\beta T_{k\beta\gamma}$ and $(I\#I)_{kk}=\tfrac12\sum_{\beta\gamma}T_{k\beta\gamma}$, so (A) and (B) carry the *same* convention factor. Everything L73 uses is their ratio, $-\lambda_k/(n-2)$, which is therefore convention-free. I checked this against my own $n=5$ hand computation in P5 below, in the opposite normalisation, and the ratio came out identical.

**(C), hypotheses: criticality.** $\lambda_\beta\lambda_\gamma$ against $T$ is $(W\#W)_{kk}=(W^\#)_{kk}$, and $W^\#=\theta W-W^2$ is the critical equation $Q(W)=\theta W$ rearranged. Off the critical set $\theta$ is not even defined as anything but $P(W)/\lVert W\rVert^3$, and $W^\#-\theta W+W^2\ne0$. **(C) is a critical-point statement, CONFIRMED, and the block is right about this at line 321.**

**$T\ge0$ is unconditional**: $T_{abc}=c_{abc}^2$ is a square. No hypothesis at all.

## P2, the core inequality, derived; and D2 and D4

**The proof, complete.** By (A) and $T\ge0$, $\mu_a(b,c):=T_{abc}/2(n-2)$ is a *probability measure* on ordered pairs. Dividing (B) at $k=a$ by $2(n-2)$ and writing $X_{bc}=\tfrac{\lambda_b+\lambda_c}2$, legitimate because $T$ is totally symmetric, so $\mathbb E_{\mu_a}[\lambda_b]=\mathbb E_{\mu_a}[\lambda_c]=\mathbb E_{\mu_a}[X]$,

$$\mathbb E_{\mu_a}[X]=\frac{-\lambda_a}{n-2}.$$

An expectation lies in the closed convex hull of what it averages, so $-\lambda_a/(n-2)\in[\lambda_{\min},\lambda_{\max}]$ for every $a$. The right half at $a=\arg\min$ gives $\lvert\lambda_{\min}\rvert\le(n-2)\lambda_{\max}$; the left half at $a=\arg\max$ gives $\lambda_{\max}\le(n-2)\lvert\lambda_{\min}\rvert$; and rearranged for general $a$ this is exactly the headline $-(n-2)\lambda_{\max}\le\lambda_a\le(n-2)\lvert\lambda_{\min}\rvert$. $\square$

**C1, CONFIRMED, on all of $\mathcal W_n$, critical or not.** The proof consumes (A), (B) and $T\ge0$, and none of the three needs criticality.

> **D2, the block's own account of its ingredients is wrong.** Line 323: "*The derivation uses only (B) and $T\ge0$*". **It does not.** (B) with $T\ge0$ alone gives $\sum_{\beta\gamma}\lambda_\beta T_{a\beta\gamma}=-2\lambda_a$ with no normalisation of the weights, so $\mu_a$ is not a probability measure and no bound follows, the expectation could be anything. **The constant $n-2$ *is* (A)**: it is the total mass $2(n-2)$ dividing the $-2\lambda_a$ of (B). Naming (B) as the sole ingredient names the numerator and drops the denominator, which is the whole content of the lemma. *The sentence is repairable in three words ("(A), (B) and $T\ge0$") and the rest of that blockquote survives intact, since (A) is as criticality-free as (B).*

> **D4, the only derivation the record carries for L73 has a sign slip that makes its stated premise vacuous.** The derivation is not inside the L73 block at all; it sits at [bounds.md](../findings/bounds.md) lines 303–311, under the preceding heading. Line 306 reads: "*From the first, $\lambda_a/(n-2)$ must lie in $[\lambda_{\min},\lambda_{\max}]$ for every $a$*". **That says nothing.** $\lambda_a\in[\lambda_{\min},\lambda_{\max}]$ by definition, $\lambda_{\min}\le0\le\lambda_{\max}$ by tracelessness, and $n-2\ge1$, so $\lambda_a/(n-2)$ lies between $0$ and $\lambda_a$ and is in the interval automatically, for *every* real vector. The non-vacuous statement, and the one the very next display uses, is $-\lambda_a/(n-2)\in[\lambda_{\min},\lambda_{\max}]$. The displayed conclusion at line 308 is correct; the line that is supposed to justify it is not.

## P3, "not implied by tracelessness", C3 CONFIRMED

With $N=\binom n2$ eigenvalues summing to zero, $\lambda_{\max}=-\sum_{a\ne\arg\max}\lambda_a\le(N-1)\lvert\lambda_{\min}\rvert$, and $\lambda=(N-1,-1,\dots,-1)$ attains it. **So $N-1$ is the sharp constant from tracelessness alone, and the comparison is fair.** And $N-1=\tfrac{n(n-1)}2-1>n-2$ for every $n\ge3$, at $n=3$, $2>1$; at $n=4$, $5>2$; the gap grows quadratically. **The claim, including its "for every $n\ge3$", is correct.**

*One remark the block does not make and could.* At $n=4$ the constant $n-2=2$ is *also* what tracelessness gives, applied separately to the two $3$-dimensional halves $W_\pm$, each traceless on $3$ eigenvalues, so max $\le2\lvert\min\rvert$ per half. The strengthening over the $N$-vector statement is real at $n=4$; the *mechanism* is not new there.

## P4, the row-range sharpening, C4 CONFIRMED, D5 REFUTED

**The sharpening derives.** $T_{abc}=0$ whenever two indices coincide ([conventions.md](../findings/conventions.md): $c_{abc}$ totally antisymmetric), so $\mu_a$ is supported on pairs with $b\ne c$, $b\ne a$, $c\ne a$. Hence $\mathbb E_{\mu_a}[X]\ge\tfrac12(\lambda_{(1)}+\lambda_{(2)})$ with $\lambda_{(1)}\le\lambda_{(2)}$ the two smallest eigenvalues on indices $\ne a$, and at $a=\arg\max$, $-\lambda_{\max}/(n-2)\ge\tfrac12(\lambda_{(1)}+\lambda_{(2)})$, i.e. $\lambda_{\max}\le-\tfrac{n-2}2(\lambda_{(1)}+\lambda_{(2)})$. **Correct.** Strictly stronger when $\lambda_{\min}$ is simple, since then $\lambda_{(2)}>\lambda_{\min}$ and $-\tfrac{n-2}2(\lambda_{\min}+\lambda_{(2)})<-(n-2)\lambda_{\min}$. **Correct.**

**Both halves of the block's claim about *where* it coincides:**

- *"Coincides at the saturating families."* **True for the right reason, stated for the wrong one.** The sharpening is inert exactly when $\lambda_{\min}$ has multiplicity $\ge2$ among the indices $\ne\arg\max$, then $\lambda_{(1)}=\lambda_{(2)}=\lambda_{\min}$. At $S^2\times S^{n-2}$, $\dim E_{\min}=2(n-2)\ge2$; at the maximal tori, $\dim E_{\min}=N-n/2$; at $\mathbb{CP}^m$, $\dim E_{\min}=m^2-m\ge2$. So it is inert at every saturating point, which is what the block observes. This matches [r338](REVIEW_r338.md) exactly.
- *"Bites only elsewhere."* **True in general, but the block's own witness for it is false.**

> **D5, REFUTED sub-claim.** Line 319: "*padded $W_{\mathbb{CP}^2}$ going $0.272166\to0.136083$*". Padded $W_{\mathbb{CP}^2}$ has spectrum $(0.816497,\,-0.408248^{\times2},\,0^{\times(N-3)})$ ([target.md](../findings/target.md) line 614), so $\lambda_{\min}$ has multiplicity **$2$**, both indices distinct from $\arg\max$, hence $\lambda_{(1)}=\lambda_{(2)}=\lambda_{\min}$ and the sharpened bound *equals* the crude one. **The sharpening cannot improve anything at that point, so a halving of its slack there is impossible.** [r338](REVIEW_r338.md) line 62 states the same thing independently and by name: "*the sharpening is identically zero wherever $\lambda_{\min}$ has multiplicity $\ge2$ … padded $W_{\mathbb{CP}^2}$ ($\dim E_{\min}=2$)*". I cannot reconstruct what the two figures measure, the ratio is exactly $\lambda_{\max}:\lvert\lambda_{\min}\rvert$, suggesting they are a different pair of quantities than the sentence claims, but whatever they are, they do not measure this sharpening at this point. *The companion figure for a random Weyl tensor ($0.308618\to0.280304$) is consistent with a simple $\lambda_{\min}$ and I have no objection to it.*

> **D6, first half.** The same sentence calls the balanced products a "**saturating famil**y" while reporting their slack as $0.1318$, $0.1273$, $0.1125$, $0.0989$. They are not saturating, the ratio at the balanced product is $n/(n-2)<n-2$, as line 367 itself derives. This is residue of the withdrawn "slack at every sphere product" claim being half-edited: the intended assertion is "the two forms agree there", which is a statement about the *sharpening*, not about saturation.

## P5, the replacement witness, by hand at $n=5$, C2 CONFIRMED

**Closed form.** For $S^p\times S^q$ Einstein with $(p-1)/r_1^2=(q-1)/r_2^2=\mu$: $\mathrm{Ric}=\mu g$, $\mathrm{scal}=n\mu$, and $W=R-\tfrac{\mu}{n-1}I$. $R$ is diagonal on the three blocks with the sectional curvatures $\tfrac{\mu}{p-1}$, $\tfrac{\mu}{q-1}$, $0$, giving

$$\Lambda^2V_p:\ \tfrac{\mu(n-p)}{(p-1)(n-1)},\qquad \Lambda^2V_q:\ \tfrac{\mu(n-q)}{(q-1)(n-1)},\qquad V_p\otimes V_q:\ -\tfrac{\mu}{n-1},$$

so the mixed block is always $\lambda_{\min}$. At $p=2$ the first is $\tfrac{\mu(n-2)}{n-1}$ and the second $\tfrac{2\mu}{(n-3)(n-1)}$, with $n-2>\tfrac2{n-3}$ for $n\ge5$, so

$$\frac{\lambda_{\max}}{\lvert\lambda_{\min}\rvert}=\frac{\mu(n-2)/(n-1)}{\mu/(n-1)}=n-2\quad\textbf{exactly}.$$

**Fully explicit at $n=5$** ($S^2\times S^3$), in units $\mu/(n-1)=1$: $\Lambda^2V_2=\langle\varphi_{12}\rangle$ at $+3$ (multiplicity $1$); $\Lambda^2V_3=\langle\varphi_{34},\varphi_{35},\varphi_{45}\rangle$ at $+1$ (multiplicity $3$); mixed $\langle\varphi_{ik}\rangle_{i\le2<k}$ at $-1$ (multiplicity $6$). Trace $3+3-6=0$ ✓, $\lambda_{\max}/\lvert\lambda_{\min}\rvert=3=n-2$ ✓.

**The row mechanism, checked directly rather than quoted.** With $v_{ij}=\varphi_{ij}/\sqrt2$ orthonormal and $a=(12)=\arg\max$: $[\varphi_{12},\varphi_{34}]=0$, so $\Lambda^2V_3$ contributes nothing; $[\varphi_{12},\varphi_{1k}]=-\varphi_{2k}$ and $[\varphi_{12},\varphi_{2k}]=+\varphi_{1k}$ for $k=3,4,5$, both landing in the **mixed** block. So $\mu_a$ is supported entirely on pairs $(b,c)$ with $\lambda_b=\lambda_c=\lambda_{\min}$, and $\mathbb E_{\mu_a}[X]=\lambda_{\min}=-1$. Against $-\lambda_{\max}/(n-2)=-3/3=-1$: **equality, the expectation sitting at the endpoint. Saturation, by hand.**

*Normalisation cross-check.* In my convention $\lVert[v_{12},v_{1k}]\rVert^2=\tfrac12$ on six basis elements, so (A) returns $\sum_\beta\lVert[v_a,v_\beta]\rVert^2=3=n-2$ and (B) returns $6\cdot\tfrac12\cdot(-1)=-3=-\lambda_a$, the record's $2(n-2)$ and $-2\lambda_k$ with the factor $2$ stripped from both. **The ratio is $-\lambda_a/(n-2)$ either way**, which is why the block's constant survives the convention split flagged in [conventions.md](../findings/conventions.md).

**Scope.** The derivation needs $n\ge5$ for $\lambda_{\max}$ to sit on $\Lambda^2V_2$; at $n=4$, $S^2\times S^2$ has both blocks equal and the ratio is $2=n-2$ anyway, so saturation holds from $n=4$ up. **The headline's "for every $n$, odd and even" is correct.** The block *does* say which $n$, it gives both the screened list $n=5,6,8,10,12$ (line 317) and the closed form covering every $n$ (line 367). No defect here.

**The other two families, verified while I was at it.**

- *Maximal torus, $n=2m$.* $W=\alpha\Pi_{\mathfrak t}+\beta(I-\Pi_{\mathfrak t})$ traceless with $\dim\mathfrak t=m$, $N=m(2m-1)$: ratio $=(N-m)/m=2m-2=n-2$ ✓, saturating, with $\mathfrak t$ abelian and $[\mathfrak t,\mathfrak m]\subseteq\mathfrak m=E_{\min}$, the same mechanism. **At odd $n=2m+1$ the same construction gives ratio $(N-m)/m=2m=n-1>n-2$, which L73 forbids**, so L73 itself certifies that the torus Casimir is not a Weyl tensor at odd $n$, exactly as line 317 asserts. *A pleasing internal consistency, and independent support for r335's restriction.*
- *$\mathbb{CP}^m$, $n=2m$.* $R$ has spectrum $0^{(m^2-m)},2^{(m^2-1)},2(m+1)^{(1)}$ at holomorphic sectional curvature $4$ (trace check: $2(m^2-1)+2(m+1)=2m(m+1)=\mathrm{scal}/2$ ✓), and $\mu=2(m+1)$, so $W=R-\tfrac{2(m+1)}{2m-1}I$ gives $\lambda_{\max}=2(m+1)\tfrac{2m-2}{2m-1}$, $\lambda_{\min}=-\tfrac{2(m+1)}{2m-1}$, ratio $2m-2=n-2$ ✓. At $m=2$ this is $(-2^{\times2},0^{\times3},4)$, matching [target.md](../findings/target.md)'s $(-0.408248^{\times2},0^{\times3},0.816497)$ up to scale. **Saturating at $n=2m$ only**, padded into $n>2m$ the ratio stays $2m-2<n-2$.

> **D6, second half, a withdrawn restriction not propagated.** Line 317 restricts the torus family to **even $n$**. Line 319 then says "*and at every maximal torus, where both read $0.000000$*", and line 323 says "*$\mathbb{CP}^m$ and the maximal tori are critical points and saturate it*", **both unqualified**. [results.md](../results.md) line 572 gets this right ("*at $\mathbb{CP}^m$ and the maximal tori $\mathfrak{so}(2)^{n/2}$ at even $n$*"); [bounds.md](../findings/bounds.md) does not. Since both families are even-$n$-only and the block's own line 317 says so, two sentences in the same block contradict a third.

## P6, the two-dimensional condition, and whether L73 overclaims

**r337's reading is right and is consistent with L73 being one-dimensional.** Row $a$ pins two moments of the *same* measure $\mu_a$ ($\mathbb E[X]$ by (B), $\mathbb E[Y]$ by (C) with $Y=\lambda_b\lambda_c$) so the exact per-row condition is $(\mathbb E[X],\mathbb E[Y])\in\mathrm{conv}\{(X_{bc},Y_{bc})\}$. **L73 is the projection onto the first coordinate. There is no inconsistency in stating a projection as an inequality**, a projection of a true convex condition is a true condition.

**But two things follow that the block gets wrong.**

1. **L73 is a *lossy* projection, and not only because it drops (C).** Even the $(A)+(B)$ content of a single row is stronger than L73: the sharp first-moment condition is $-\lambda_a/(n-2)\in[\min X_{bc},\max X_{bc}]$ over $b\ne c$, $b,c\ne a$, which is precisely the C4 strengthening. L73 replaces that interval by the crude $[\lambda_{\min},\lambda_{\max}]$. **So L73 is not even the sharp single-row shadow of the criticality-free half.**
2. **The hull condition is unavailable off the critical set**, because $\mathbb E[Y]$ is pinned by (C). So on $\mathcal W_n$ what survives is the *first-moment* condition only, which is what makes D1 an error rather than a quibble.

> **D1, the block's central structural sentence is false.** Line 321: "***Lemma L73 is therefore the whole of what the row calculus says on $\mathcal W_n$***". Refuted twice:
>
> - **From inside the block, four lines earlier.** Line 317's own strengthening $\lambda_{\max}\le-\tfrac{n-2}2(\lambda_{(1)}+\lambda_{(2)})$ is derived from (A), (B) and the vanishing of $T$ on repeated indices (all criticality-free, all row calculus, all on $\mathcal W_n$) and is *strictly stronger* than L73 whenever $\lambda_{\min}$ is simple. **The block asserts a strictly stronger criticality-free consequence of the row calculus three lines above the sentence claiming L73 exhausts it.**
> - **By name, 30 lines below, in the same file.** [Lemma L112](../findings/bounds.md)'s block at line 351 opens: "*[r338](REVIEW_r338.md) U2, **refuting** 'Lemma L73 is the whole of what the calculus gives on $\mathcal W_n$' by construction*". I verified r338's construction independently: $S_{ab}:=\sum_cT_{abc}$ is symmetric (total symmetry of $T$), nonnegative, and hollow ($S_{aa}=\sum_cT_{aac}=0$); (A) gives $\sum_bS_{ab}=2(n-2)$ and (B) gives $S\lambda=-2\lambda$. So $P=S/2(n-2)$ is symmetric doubly stochastic with $P\lambda=-\lambda/(n-2)$, whence $-\lambda/(n-2)\prec\lambda$ by Hardy–Littlewood–Pólya, and **L73 is exactly the $\lvert A\rvert=1$ case of the resulting subset-sum family**, as [plan.md](../plan.md)'s I17 already states. The majorisation statement is strictly stronger and is pure $(A)+(B)$, i.e. lives on all of $\mathcal W_n$.
>
> **The rest of the line-321 blockquote is sound and worth keeping**, (A) and (B) criticality-free, (C) critical-only, the per-row $\theta$-bounds therefore not extending off the critical set. Only the one sentence must go, and the honest replacement is *"the row calculus's criticality-free content on $\mathcal W_n$ is the doubly-stochastic majorisation of [Lemma L112](../findings/bounds.md), of which Lemma L73 is the one-index shadow"*. **This is the same failure mode the record has hit before: a headline sentence left standing above a later passage that refutes it, in one file, with nobody reconciling the two.**

> **D3, the criticality boundary is drawn correctly in prose and then crossed by the block's closing display.** The final display, [bounds.md](../findings/bounds.md) line 326,
> $$\theta\le\lambda_{\min}+(n-2)\lambda_{\max},$$
> is derived correctly, from **(C)** at $a=\arg\min$, using $\lambda_b\lambda_c\ge\lambda_{\min}\lambda_{\max}$ (valid: the minimum of $xy$ over $[\lambda_{\min},\lambda_{\max}]^2$ with $\lambda_{\min}\le0\le\lambda_{\max}$ is $\lambda_{\min}\lambda_{\max}$) and dividing by $\lambda_{\min}<0$, which flips the inequality. **I confirm the step. But it consumes (C), so it holds only at critical points**, it is in fact the $\lambda_{\min}$ row of the family at line 341, i.e. [Lemma L70](../findings/bounds.md) with $D=0$, not a statement of L73 at all. Its placement is the defect: it closes the blockquote headed "**AND IT NEEDS NO CRITICALITY**", one sentence after "**So this is a constraint on the spectrum of every Weyl tensor**", under a `####` heading reading "**on all of $\mathcal W_n$**". *A reader who takes the block at its headings reads a $\theta$-bound as valid off the critical set, where $\theta$ is not even the eigenvalue of anything.* Line 321 states the correct boundary in prose; line 326 hands a reader the material to cross it. **Move the display into [Lemma L70](../findings/bounds.md)'s block, or label it "at critical points" in the line that introduces it.**

**Where the boundary actually falls, stated plainly:**

| displayed statement | holds on | needs |
| --- | --- | --- |
| $-(n-2)\lambda_{\max}\le\lambda_a\le(n-2)\lvert\lambda_{\min}\rvert$ | **all of $\mathcal W_n$** | (A), (B), $T\ge0$ |
| $\lambda_{\max}\le(n-2)\lvert\lambda_{\min}\rvert$ and mirror | **all of $\mathcal W_n$** | (A), (B), $T\ge0$ |
| $\lambda_{\max}\le-\tfrac{n-2}2(\lambda_{(1)}+\lambda_{(2)})$ | **all of $\mathcal W_n$** | (A), (B), $T\ge0$, $T$ hollow |
| $-\lambda/(n-2)\prec\lambda$ ([L112](../findings/bounds.md)) | **all of $\mathcal W_n$** | (A), (B), $T\ge0$, $T$ symmetric |
| $\theta\le\lambda_{\min}+(n-2)\lambda_{\max}$ (line 326) | **critical points only** | (C) |
| the per-row $\theta$-family, the $\Pi$-bound, the hull reading | **critical points only** | (C) |

## P7, what else in the record bears on this

- **[INDEX-results.md](../findings/INDEX-results.md) line 87 is stale, and asserts something L73 forbids, D7.** L73's row reads: "*a purely spectral necessary condition $\lambda_{\max}\le(n-2)\lvert\lambda_{\min}\rvert$ and its mirror, **sharp on $\mathbb{CP}^m$ and on every maximal torus***". Those are the two **pre-r335** sharpness families. The row omits $S^2\times S^{n-2}$, the replacement witness and the only one covering odd $n$; and "every maximal torus" is false at odd $n$, where, as computed in P5, it would assert a ratio of $n-1$, violating the very inequality in the same cell. **Anyone reading L73 through the index gets the withdrawn claim, in the file the record designates as canonical for what each number says.** Replace with: "*sharp at $S^2\times S^{n-2}$ for every $n$, and at $\mathbb{CP}^m$ and the maximal tori at even $n$*".
- **[results.md](../results.md) lines 198 and 572 are correct** and properly qualified on both the $S^2\times S^{n-2}$ witness and the even-$n$ restriction. The defect is confined to [bounds.md](../findings/bounds.md) and [INDEX-results.md](../findings/INDEX-results.md).
- **[bounds-relaxations.md](../findings/bounds-relaxations.md) lines 329 and 360 read L73 correctly**, "*carries no $\theta$*", and lists it among the per-row bounds whose exhaustion is the motivation for the vertex route. **No contradiction.**
- **[bounds.md](../findings/bounds.md) line 367 does not contradict the block**, it is the closed-form settlement of the r335/r336 dispute and independently confirms $S^2\times S^{n-2}$. *Two incidental defects there, outside my target: the blockquote is never closed, and its final third ("the record does not currently carry this computation … settling it is the next task") is superseded framing left standing beneath the settlement that supersedes it.*
- **[bounds.md](../findings/bounds.md) line 347 is consistent with this block** and needs no change.
- **[INDEX-traps.md](../findings/INDEX-traps.md) holds nothing on L73.** Given D2 and D4 (a constant attributed to the wrong relation, and a sign slip turning a premise vacuous), **the (A)-is-the-denominator point is worth a trap row**: it is the third normalisation/attribution collision in this file's row calculus.

## Screen

None run. Every figure above is closed-form arithmetic on spectra I wrote down myself, the $S^2\times S^3$ block eigenvalues, the $\mathbb{CP}^m$ trace check, the torus ratio $(N-m)/m$, the $n=5$ bracket computation, and each is reproduced in full so a reader can check it without a machine. **No claim here rests on computation.**

## Required repairs, in priority order

1. **Delete the sentence "Lemma L73 is therefore the whole of what the row calculus says on $\mathcal W_n$"** ([bounds.md](../findings/bounds.md) line 321) and point it at [Lemma L112](../findings/bounds.md). It is refuted inside its own block and by name 30 lines below. **D1.**
2. **Fix [INDEX-results.md](../findings/INDEX-results.md) line 87**, it still carries the withdrawn sharpness families and is false at odd $n$. **D7.**
3. **"(A), (B) and $T\ge0$"** at line 323, not "(B) and $T\ge0$". **D2.**
4. **Delete "padded $W_{\mathbb{CP}^2}$ going $0.272166\to0.136083$"** at line 319, the sharpening is provably inert at a point with $\lambda_{\min}$ of multiplicity $2$. **D5.**
5. **Label the closing display at line 326 "at critical points"**, or move it into [Lemma L70](../findings/bounds.md)'s block where it belongs. **D3.**
6. **Restore the even-$n$ qualifier** to the torus claims at lines 319 and 323, and stop calling the balanced products a saturating family at line 319. **D6.**
7. **Repair line 306's sign** ($-\lambda_a/(n-2)$, not $\lambda_a/(n-2)$) so that L73's only recorded derivation is not vacuous at its pivot step. **D4.**
