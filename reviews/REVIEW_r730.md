# Review r730, Gate 2 adversarial review of seven refutations (2026-09-07)

## Claim table

| # | Result | Verdict |
|---|--------|---------|
| 1 | [L13](../findings/curvature-invariants.md), "reaching $58.9$ needs $k_0\ge74$" | **CONFIRMED on the number swap; the *determination* diagnosis and the $S^6\times S^6$ witness REFUTED AS THE DEFECT** |
| 2 | [L01](../findings/problem.md), the edge that excludes the corner | **CONFIRMED on the defect; the repair introduced one FALSE sentence** |
| 3 | [L38](../findings/ungraded-slack.md) ("two families **capped**" | **CONFIRMED as arithmetic; REFUTED AS A REFUTATION), the block already said every word of it, under Gate 2** |
| 4 | [L39](../findings/target.md), "overshoots the true $\theta$ every time" | **the circularity strike CONFIRMED and understated; the witness VALID BUT DEGENERATE, and two better ones exist at the same $n$** |
| 5 | [L41](../findings/target.md), scale, sign and the equality clause | **all three CONFIRMED, every figure exact; but the repair contradicts [conventions.md](../findings/conventions.md) on criticality** |
| 6 | [L71](../findings/bounds.md), the determinant route to $SO(8)$-conjugacy | **CONFIRMED, witness genuine; the owed $O(8)\to SO(8)$ line is one line and is supplied below** |
| 7 | [L26](../findings/nondegeneracy.md), why five splits missed $(3,4)$ | **CONFIRMED as arithmetic; "false in both halves" OVERSTATED, and the replacement reason is weaker than the true one** |

## Overall

**Six of the seven defects are real. Two of the repairs are not.**

- **[L01](../findings/problem.md) is the failure mode the brief names.** The strike is right that $(\mathop{\mathrm{tr}}S^3)^2\le\mathop{\mathrm{tr}}S^4$ admits the $n=12$ corner, and the same edit **turned a true sentence false** by moving the $(\tfrac12,\tfrac15)$ witness onto the edge that admits it.
- **[L38](../findings/ungraded-slack.md) is not a refutation at all.** The block already carried the strike, word for word, in a box, under a Gate 2 `CONFIRMED`. The edit relabelled a heading and dropped three proofs.
- **[L13](../findings/curvature-invariants.md) and [L39](../findings/target.md) are right in the strike and wrong in the diagnosis**: one names "determination" where the inherited defect is scope, the other names circularity where the premise is false outright, and its witness sits at the degenerate end of the family.
- **[L41](../findings/target.md), [L71](../findings/bounds.md) and [L26](../findings/nondegeneracy.md) hold**, with one live contradiction against [conventions.md](../findings/conventions.md), one owed line supplied, and one overstatement.

*The brief asked whether it was briefed wrong. On item 3 it was: that item is an editorial repair filed as a refutation, and there was no false statement on the record for it to strike.*

*Computation used: exact rational arithmetic only, all of it screening figures the record already prints or enumerating a closed-form locus over a finite range. No search, sweep or optimisation was opened.*

---

## Item 1, [L13](../findings/curvature-invariants.md), the $58.9$ / $49.7$ substitution

**The chain, re-derived cold.** $Q$ is quadratic, so $DQ_W(H)=2W\circ H=2L_WH$. Criticality $Q(W)=\theta W$ gives $L_WW=W\circ W=\tfrac12(Q(2W)-2Q(W))=Q(W)=\theta W$. Equivariance $Q(gWg^{-1})=gQ(W)g^{-1}$ differentiated at $g=e$ in direction $A\in\mathfrak{so}(n)$ gives $DQ_W([A,W])=[A,Q(W)]=\theta[A,W]$, hence $L_Wo_A=\tfrac\theta2o_A$; and $\langle[A,W],W\rangle=0$ by ad-invariance, so the orbit tangent space is $\theta$-eigenvector-free and contributes $k_0$ independent eigenvalues $\theta/2$. Self-adjointness of $L_W$ then gives $\mathop{\mathrm{tr}}(L_W^2)\ge\theta^2+k_0(\theta/2)^2$. **The proof as now written is correct**, and $\theta>0$ is exactly what keeps the two eigenvalues apart.

**The screen, exact.** $\kappa_{12}=\tfrac{11\cdot23}4=\tfrac{253}4$; the bound is $\theta\le\sqrt{253/(4+k_0)}$; $\theta_0(12)=\tfrac{\sqrt{55}}6$, $\sqrt{3/2}=\tfrac{\sqrt6}2$, gap $=0.0112882098$.

| $k_0$ | bound | ratio $(\text{bound}-\theta_0)/(\theta_0-\sqrt{3/2})$ |
| --- | --- | --- |
| $66=\binom{12}2$ | $1.9011275$ | $\mathbf{58.9194}$ |
| $74$ | $1.8009969$ | $\mathbf{50.0490}$ |
| $34$ (padded $W_{\mathbb{CP}^2}$) | $2.5802897$ | $119.085$ |
| level-3 $1.7974$ |, | $\mathbf{49.7304}$, and $4\big(\tfrac{253}4/1.7974^2-1\big)=74.3125$ |

**Every figure in the refutation reproduces.** $58.9$ is what the *admissible maximum* $k_0=66$ delivers, so the struck sentence's "$58.9$ … is unreachable, needing $k_0\ge74>66$" asserts the unreachability of the block's own printed figure, and does so three sentences after the same block bracketed it in $(58,59)$. **The $74$ belongs to $49.7$**, and the provenance is on the record: [REVIEW_r595.md:86](REVIEW_r595.md#L86) is the source computation, verbatim, applied to $1.7974$; [REVIEW_r596.md:78](REVIEW_r596.md#L78) identifies $1.7974$ as `bound_level3(n, N)`, a level-3 bound consuming $\mathop{\mathrm{tr}}(L_W^3)$. **So the substitution is real and the strike lands.**

**But the second strike names the wrong defect, and its witness does not bite.** The refutation calls the overwritten argument *"reading an upper bound as a determination"*, and offers $\theta_0(12)$, which needs $k_0\ge161.6$, so $\ge162>66$, as refuting $S^6\times S^6$.

- Under the reading the sentence's own clause forces (*"larger $k_0$ only lowers $\lambda$"*, where what larger $k_0$ lowers is the **bound**), the inversion $k_0=4(\kappa_n/b^2-1)$ is a statement about which $k_0$ makes the level-2 **bound** equal $b$. Applied to $b=\theta_0(12)$ it says *the level-2 bound never descends to $\theta_0(12)$*, **true, and it refutes nothing**, since $S^6\times S^6$ has $\theta=\theta_0(12)=1.2360$, comfortably under the bound $1.9011$.
- The reductio therefore needs the sentence read as *"$\theta$ reaching $b$"*. That reading is available only because the block writes $\lambda$ for both $\theta$ and its bound (a **notational** collision the block's own closing paragraph already flags), not because the inference is of the wrong shape.
- **The actual defect in [r595](REVIEW_r595.md)'s argument, which the record inherited, is scope, not logic**: r595 concluded $1.7974$ was *unreachable* because it assumed the figure had to come out of the displayed level-2 chain. [r596](REVIEW_r596.md) supplies the missing premise, it came from a level-3 bound. **A refutation naming "determination" leaves that scope error unrecorded**, and it is the one that recurs.

**One caveat the repair does not carry.** *"$49.7$ was never wrong"* rests on a figure [r596](REVIEW_r596.md) itself reports as a grid search (`ngrid=40001, nsamp=61`) and declined to reconstruct. The block now prints *"A level-3 bound of $1.7974$"* with no such flag, where the same block flags $\kappa_n$ at odd $n$ as fitted. **The number is restored with less provenance than the record has for it.**

*Screens only: four exact rational evaluations of a closed form, each replacing nothing an argument could supply, since the question is which of two printed decimals a given $k_0$ produces.*

---

## Item 2, [L01](../findings/problem.md), the edge that excludes the corner

**Setup, from the block.** $S=\mathrm{Ric}(\lvert W\rvert)/\lVert\mathrm{Ric}(\lvert W\rvert)\rVert\succeq0$ with $\mathop{\mathrm{tr}}S^2=1$; $\mu=\sum\lambda_i^2\delta_{\lambda_i}$ is a probability measure on $(0,1]$ with $\mathbb E[\lambda]=\mathop{\mathrm{tr}}S^3$ and $\mathbb E[\lambda^2]=\mathop{\mathrm{tr}}S^4$. The corner is $\mathop{\mathrm{tr}}S^3$ at its floor with $\mathop{\mathrm{tr}}S^4$ at its ceiling $E(12)=\tfrac{8\cdot144-41\cdot12+49}{4\cdot13\cdot10\cdot9}=\tfrac{709}{4680}$.

**The defect is real, and it is structural rather than numerical.** $(\mathop{\mathrm{tr}}S^3)^2\le\mathop{\mathrm{tr}}S^4$ is Jensen on $\mu$, so it bounds $\mathop{\mathrm{tr}}S^4$ **from below** given $\mathop{\mathrm{tr}}S^3$. A corner with $\mathop{\mathrm{tr}}S^3$ **low** and $\mathop{\mathrm{tr}}S^4$ **high** is precisely the configuration it cannot touch. The arithmetic confirms: $\tfrac1{12}=0.08333\le\tfrac{709}{4680}=0.15150$, so the corner satisfies it. **CONFIRMED**, and no number was needed to see it.

**The replacement's headline survives an attack I expected it to fail.** *"The edge that excludes it is $1\le(\mathop{\mathrm{tr}}S)(\mathop{\mathrm{tr}}S^3)$ with $\mathop{\mathrm{tr}}S\le\sqrt n$"* looks self-defeating, because that chain is what **defines** the corner's floor $\mathop{\mathrm{tr}}S^3\ge1/\sqrt{12}$, an inequality cannot exclude its own boundary point. It survives on the equality case: $\mathop{\mathrm{tr}}S^3=1/\sqrt n$ forces $\mathop{\mathrm{tr}}S\ge\sqrt n$ through $1=(\mathop{\mathrm{tr}}S^2)^2\le(\mathop{\mathrm{tr}}S)(\mathop{\mathrm{tr}}S^3)$, and $\mathop{\mathrm{tr}}S\le\sqrt n\lVert S\rVert_F=\sqrt n$ then binds, whose equality case at $\mathop{\mathrm{tr}}S^2=1$ is the flat spectrum $\lambda_i=1/\sqrt{12}$ for all twelve, where $\mathop{\mathrm{tr}}S^4=12\cdot\tfrac1{144}=\tfrac1{12}=0.0833$, its **floor**, against the ceiling $0.1515$ the corner asks for. **So the corner is excluded, by the working edge's equality case.** CONFIRMED.

> **BUT THE EDIT DOWNGRADED "TWO CAUCHY–SCHWARZ EQUALITIES" TO "THE CAUCHY–SCHWARZ EQUALITY", AND TWO IS THE HONEST COUNT.** Both steps of the chain must be tight; that the first is *forced* by the second, rather than assumed, is the content, and the singular hides it.

### The repair entered a false sentence, and it was true before the edit

The block's last illustration is unchanged in its numbers and changed in its attribution:

| version | sentence |
| --- | --- |
| before | *"a box bounding the two traces separately admits $(\tfrac12,\tfrac15)$, which **the edge** excludes"*, the edge there being $(\mathop{\mathrm{tr}}S^3)^2\le\mathop{\mathrm{tr}}S^4$ |
| after | *"A box bounding the two traces separately admits $(\tfrac12,\tfrac15)$, which **the working edge** excludes"* |

The block's own ordering is $\mathop{\mathrm{tr}}S^3$ first (*"He bounds $\mathop{\mathrm{tr}}S^3$ and $\mathop{\mathrm{tr}}S^4$ separately"*; *"the corner has $(\mathop{\mathrm{tr}}S^3)^2=\tfrac1{12}$ against $E(12)$"*), so the pair is $(\mathop{\mathrm{tr}}S^3,\mathop{\mathrm{tr}}S^4)=(\tfrac12,\tfrac15)$. Then:

- **Cauchy–Schwarz edge**: $(\tfrac12)^2=\tfrac14>\tfrac15$. **Excludes it.** *(And it is genuinely infeasible: Jensen forces $\mathbb E[\lambda^2]\ge(\mathbb E[\lambda])^2$.)*
- **Working edge**: $\tfrac12\ge1/\sqrt{12}=0.2887$. **Admits it.**

**So the one witness the block offers for the working edge is a witness for the edge the refutation struck.** The old sentence was correct; the new one is false. This is the failure mode the brief names (right about the defect, wrong about the repair) and it is now on the record with an audit's authority behind it.

*The repair: keep the strike, and restore the attribution.* Both edges are true and neither is redundant, $(\mathop{\mathrm{tr}}S^3)^2\le\mathop{\mathrm{tr}}S^4$ excludes high-$\mathop{\mathrm{tr}}S^3$/low-$\mathop{\mathrm{tr}}S^4$ pairs such as $(\tfrac12,\tfrac15)$, and $1\le(\mathop{\mathrm{tr}}S)(\mathop{\mathrm{tr}}S^3)$ excludes the $n=12$ corner through its equality case. *A further nit: $\tfrac15>E(12)=0.1515$, so $(\tfrac12,\tfrac15)$ lies outside the $n=12$ box in either attribution and illustrates a generic box, which the sentence does not say.*

### The second strike, the corner elimination does not close $n=12$, CONFIRMED

$\varphi(v)=\tfrac7{10}v+\tfrac{8647}{38000}$ at $v=E(12)=\tfrac{709}{4680}$ gives exactly

$$\varphi(E(12))=\frac{4963}{46800}+\frac{8647}{38000}=\frac{92699}{277875}=0.3335996 ,$$

against the corner-elimination floor $1/\sqrt{12}=0.288675$ and the stated requirement $0.3152$. **Both recorded decimals reproduce to four places**, and $0.2887<0.3152<0.3336$ is the whole of the claim. *The requirement $0.3152$ is the one figure in the chain the block sources nowhere*, it appears in no other line of [problem.md](../findings/problem.md), so a reader cannot check the middle term.

---

## Item 3, [L38](../findings/ungraded-slack.md), "two families capped"

**Every number reproduces, exactly.** $\theta_0(2m)^2=\tfrac{2(2m-1)(2m-2)}{4m^2}=\tfrac{(2m-1)(m-1)}{m^2}$, so

$$\frac{(m+1)(2m-1)}{3m(m-1)}-\frac{(2m-1)(m-1)}{m^2}=(2m-1)\cdot\frac{m(m+1)-3(m-1)^2}{3m^2(m-1)}=\frac{-(2m-1)^2(m-3)}{3m^2(m-1)},$$

using $-2m^2+7m-3=-(2m-1)(m-3)$. **Above at $m=2$ by $\tfrac34$, zero at $m=3$, negative from $m=4$**, as printed. The Kähler differences are $\tfrac32-\tfrac34=\tfrac34$ at $m=2$, $\tfrac65-\tfrac{10}9=\tfrac4{45}$ at $m=3$, and $\tfrac{10}9-\tfrac{21}{16}=-\tfrac{29}{144}$ at $m=4$, as printed. The two families' difference is $\frac{-(m+1)(m-2)}{3m(m+2)}$ after the shared $(m-1)$ cancels, so $m=2$ is the only meeting point in the domain, and $\tfrac{10}9$ against $\tfrac65$ at $m=3$ is exactly the split [conventions.md](../findings/conventions.md) tables under *"the Ricci-flat Kähler family names TWO different families"*.

### But this is not a refutation, and the record was not carrying a false statement

**`git show d25f6c6d` shows the pre-edit block already carried the strike, in its own box, in the same words:**

> *"**"CAPPED" DOES NOT MEAN "BELOW THE TARGET" AT THE FAMILY'S OWN $n$.** Both families **exceed** $\theta_0(2m)$ at $m=2$; $\mathbb{CP}^m$ **ties exactly at $m=3$** … and the Kähler $m=3$ member sits at $\sqrt{6/5}=1.0954$ against $\Theta_6=1.0541$, **above it.** … but the cap is *attained* at $\mathbb{CP}^2$, **so it fences and never separates.**"*

**What changed is the heading and the arrangement.** The mathematics of the strike (every comparison, the phrase *"fences and never separates"*), was on the record before the commit that entered it as a refutation, having been put there by [r645](REVIEW_r645.md) and [r646](REVIEW_r646.md), whose verdict was `CONFIRMED`. **A refutation is owed a statement that was false; this one had none.** *Bringing a heading into line with a box the block already carried is an editorial repair, and filing it as `Deliverable: refutation` overstates what it is.*

### And the edit lost three things the block had proved

| lost | what it was |
| --- | --- |
| monotonicity | $f'$ has numerator $-3(3m^2-2m+1)$, discriminant $-8$, so negative-definite, I re-derived it and it is right. The new block **asserts** *"Both are strictly decreasing on $m\ge2$"* with no argument |
| the $m=2$ identification | *"now proved rather than asserted"*: one chiral $\mathfrak{su}(2)\subset\mathfrak{so}(4)$, $\mathbb R\omega=\mathfrak{so}(2)$ as $\mathfrak k$, $(p,q)=(1,2)$, $ap+bq=0$, spectrum $(2,-1,-1,0,0,0)/\sqrt6$. The new block asserts *"their shared $m=2$ member, which is $W_{\mathbb{CP}^2}$"* |
| Gate 2 provenance | *"[r645](REVIEW_r645.md) and [r646](REVIEW_r646.md) on identical briefs, both CONFIRMED, each deriving both closed forms cold and by disjoint routes."* The block now carries no provenance line, so a reader cannot tell it has been through Gate 2 |

*A nit on the surviving prose:* *"the difference vanishing exactly on $m^2-3m+2=0$ whose other root $m=1$ is the shared singularity"*, $m=1$ is a **removable** zero of the pre-cancellation numerator and a genuine pole of both families, so the two families do not meet there in any sense; the quadratic is an artefact of not cancelling.

**What does survive as new** is the `WHAT IS OWED` box: nothing puts the Kähler family's members in $\mathcal W_{2m}$ at general $m$, [L4](../findings/algebra.md)'s criterion failing because $\Lambda^2\mathbb R^m$ enters $\Lambda^2\mathbb R^{2m}$ with multiplicity three. **That is a real and previously unrecorded debt**, and it is what the commit should have been titled.

---

## Item 4, [L39](../findings/target.md), "overshoots the true $\theta$ every time"

**The struck sentence, in full, from `git show e5581b6f`:** *"The formula values an operator that is **generically not a Weyl tensor**, and at unbalanced sphere pairs it overshoots the true $\theta$ every time, $1.389084$ against $\Theta_9^2=1.371429$ at $n=9$, and by $12.6\%$ at $n=5$."* **The gloss fixes the reading: "the true $\theta$" is $\Theta_n$**, not the matching sphere product's own value. Everything below turns on that.

### The circularity strike is CONFIRMED, and it is weaker than the truth

An operator with $\theta>\Theta_n$ is inadmissible only if $\Theta_n$ caps $\theta$ over $\mathcal W_n$, which is Problem P. **So the inference does presuppose what the programme proves.** But the record's own [conventions.md](../findings/conventions.md) gives a cheaper kill:

> *"$M(n)>0$ at every $n\ge4$, padded $W_{\mathbb{CP}^2}$ giving $M(n)\ge\sqrt{3/2}$"*, and $M(n)$ is the **global** maximum, where $\Theta_n$ is the diagonal one.

At $n=9$, $\Theta_9^2=\tfrac{48}{35}=1.3714<\tfrac32\le M(9)^2$. **The anchor value $\tfrac{64009}{46080}=1.3891$ is itself below $\tfrac32$**, so an operator carrying it is consistent with being a Weyl tensor by a value the record already has attained. The same at $n=5$: $\tfrac{961}{960}=1.0010<\tfrac32$. *So the argument fails on its own two anchors without any appeal to the conjecture at all, it is not merely circular, its premise is false as stated.* **The refutation names the weaker defect.**

### The witness is valid under that reading, degenerate as an instance, and bettered twice over

$(\mathfrak{so}(9),\mathfrak{so}(8))$: $p=\dim\mathfrak{so}(8)=28$, $q=36-28=8$, $c=2h^\vee(\mathfrak{so}(9))=14$, **and $c=14$ is confirmed independently**, since $p=16,q=20,c=14$ reproduces the record's own $\tfrac{64009}{46080}$ to the digit. Then

$$\theta^2=\frac{(14\cdot8\cdot76-4\cdot28\cdot20)^2}{16\cdot28^3\cdot8\cdot36}=\frac{6272^2}{101154816}=\frac7{18},$$

below $\tfrac{48}{35}$ by a factor $3.53$. **The arithmetic is exact and the claim "every time" is false.** *But the witness is the degenerate end of the family.* $\mathfrak{so}(8)=\mathfrak{so}(1)\oplus\mathfrak{so}(8)$, so the pair is the $(a,b)=(1,8)$ Grassmannian, whose "sphere product" $S^1\times S^8$ has $\theta_{1,8}^2=\tfrac{2(n-1)}{n-2}\big(1-\tfrac{n-1}{ab}\big)=\tfrac{16}7(1-1)=0$. **Calling it a *sphere pair* is a stretch, and a reader who reads "unbalanced sphere pair" as requiring two nontrivial factors will judge the witness out of scope.**

**Two in-scope witnesses sit one and two steps in, at the same $n$**, both with $a,b\ge2$:

| $(a,b)$ at $n=9$ | $p$ | $q$ | L39 $\theta^2$ | $\theta_{a,b}^2$ | vs $\Theta_9^2=\tfrac{48}{35}$ |
| --- | --- | --- | --- | --- | --- |
| $(1,8)$ | $28$ | $8$ | $\tfrac7{18}=0.3889$ | $0$ | **below** |
| $(2,7)$ | $22$ | $14$ | $\tfrac{351649}{335412}=1.0484$ | $\tfrac{48}{49}=0.9796$ | **below** |
| $(3,6)$ | $18$ | $18$ | $\tfrac{49}{36}=1.3611$ | $\tfrac{80}{63}=1.2698$ | **below** |
| $(4,5)$ | $16$ | $20$ | $\tfrac{64009}{46080}=1.3891$ | $\tfrac{48}{35}=1.3714$ | above |

**$(\mathfrak{so}(9),\mathfrak{so}(3)\oplus\mathfrak{so}(6))$ at $\theta^2=\tfrac{49}{36}$ is the witness the record should carry**: both factors nontrivial, no degeneracy to argue about, and it falls below $\Theta_9^2$ by a margin no reading can talk away. *Screened exactly; four evaluations of a closed form the record prints, each reproducing a recorded value at the fourth row.*

> **AND THE TABLE SHOWS WHY THE READING WAS LOAD-BEARING.** In the **last two columns**, L39 exceeds the matching sphere product's own $\theta$ at **all four** splits, $(1,8)$ included. **Under the reading "overshoots the sphere pair's own value" the struck sentence is true at every row, and the refutation's witness confirms rather than refutes it.** *The sentence's own gloss picks the $\Theta_n$ reading, so the strike lands, but the repair should say which of the two it struck, because only one of them is false, and the block's replacement text repeats the bare phrase "overshoots the true $\theta$" without disambiguating it.*

*The recorded confirmations check exactly:* the gap $\frac{24k^4-6k^3-5k^2+4k-1}{4k^4(2k+1)(k+1)(2k-1)}$ for $(\mathfrak{so}(2k{+}1),\mathfrak{so}(k)\oplus\mathfrak{so}(k{+}1))$ against $\Theta_{2k+1}$ gives $\tfrac{1139}{64512}$ at $k=4$ and $\tfrac{323}{2880}$ at $k=2$, **identical to $\tfrac{64009}{46080}-\tfrac{48}{35}$ and $\tfrac{961}{960}-\tfrac89$ respectively**, and its numerator is positive at every $k\ge1$.

---

## Item 5, [L41](../findings/target.md), scale, sign and the equality clause

**The scale correction is right, and it is [conventions.md](../findings/conventions.md)'s own text.** That file tables $\sum_kg_k=4(n-1)\lVert W\rVert^2$ and $\sum_k\lambda_kg_k=-4P(W)$; the struck forms $4(n-1)$ and $-4\theta$ equate degree $2$ and degree $3$ with degree $0$. **CONFIRMED.**

**The sign change is real and the figure is exact.** $g$ is degree $2$ in $W$, so at $2\times$ padded $W_{\mathbb{CP}^2}$ in $\mathcal W_{12}$ the masses quadruple: $\Delta=0$, $G_0=4\cdot4(n-4)=128$, bracket $=44-128=-84$, and $\lvert\lambda_{\min}\rvert=2/\sqrt6$ gives

$$\frac{2}{\sqrt6}\cdot\frac{-84}4=-17.14643 ,$$

against a positive $P$. **CONFIRMED**, and the diagnosis is right: the bracket mixes degree $0$ with degree $2$, so the bound admits no homogeneous form and cannot be applied by rescaling.

**The equality clause. CONFIRMED, and I rebuilt the whole bound to check it.** From $-4P(W)=\sum_\gamma\lambda_\gamma g_\gamma$ split over $\{\lambda>0\}$, $\{\lambda<0\}$, $\ker W$, and $\lambda_\gamma\ge\lambda_{\min}$ on the negative part,

$$-4\theta=\sum_{\lambda>0}\lambda_\gamma g_\gamma+\sum_{\lambda<0}\lambda_\gamma g_\gamma\ \ge\ \lambda_{\min}\,G_-,\qquad G_-=4(n-1)-\Delta-G_0 ,$$

so the exact slack is $\sum_{\lambda>0}\lambda_\gamma g_\gamma+\sum_{\lambda<0}(\lambda_\gamma-\lambda_{\min})g_\gamma$, **the kernel term was subtracted before the estimate and never re-enters**, so equality constrains $g$ on $E_{\lambda_{\min}}$ and on the kernel not at all. **The record's $E_{\lambda_{\min}}\oplus\ker W$ is right.**

**The witness does exactly what it is said to do.** Padded $W_{\mathbb{CP}^2}$ has spectrum $(2,-1,-1,0,\dots)/\sqrt6$; $\mathrm{ad}$ of its top eigenvector is the $U(2)$-centre action, which fixes $W$, so $\Delta=0$. With $G_0=4(n-4)$ the negative mass is $4(n-1)-4(n-4)=12$ at **every** $n$, and

$$\lvert\lambda_{\min}\rvert\cdot\frac{12}4=\frac1{\sqrt6}\cdot3=\sqrt{3/2}=\theta .$$

**Equality, with $G_0=32>0$ at $n=12$**, so the "only if" half genuinely fails. *The recorded $G_0$ values $0/16/32$ at $n=4,8,12$ are internally consistent with this: at $n=4$ the kernel is $\Lambda^2_-$, on which $\mathrm{ad}$ acts trivially against $W\rvert_{\Lambda^2_+}$, so $G_0=0$ there and the $n$-dependence starts at the mixed block.*

### The one defect: the repair moved a contradiction rather than removing it

The commit's stated grievance is that *"the canon contradicted its own conventions file"*. **The repaired statement contradicts it in the other clause.**

| source | the second identity |
| --- | --- |
| [conventions.md](../findings/conventions.md), $g_k,G_2$ row | *"$\sum_k\lambda_kg_k=-4P(W)$, both from (A) and (B) with the cubic identity and **neither needing criticality**"* |
| [L41](../findings/target.md) as repaired | *"$\sum_\gamma\lambda_\gamma g_\gamma=-4P(W)$ **at a critical point**"* |

And L41's own proof paragraph sharpens the clash: *"The **first** identity additionally consumes [L153](../findings/bounds.md), and needs no criticality, that claim is genuine"*, whose contrast asserts that the second does need it. **Both sides are degree $3$ and the ingredients the proof names, Petersen–Wink 1.7, total symmetry of $T$, $A(W)=2W$, are criticality-free**, so the qualifier is at best unexplained and at worst wrong. *One of the two files is carrying a false hypothesis and the record does not say which; it should be settled before either is cited, since the bound is derived from the second identity and inherits whatever it needs.*

---

## Item 6, [L71](../findings/bounds.md), the determinant route

**The struck inference, as a schema:** *$\sigma$ is inner and its defining matrix has $\det=+1$, therefore Cartan's classification up to $\mathrm{Aut}$ delivers $SO(8)$-conjugacy.* **This is a non-sequitur on its face**, $\mathrm{Aut}$-conjugacy of two *inner* involutions still permits the conjugating automorphism to be outer, which is the whole of what $\mathrm{Out}(D_4)=S_3$ is for. The determinant tells you $\sigma\in SO(8)$; it says nothing about the automorphism that matches two involutions.

**The witness is genuine, and I rebuilt it three ways.**

- **Both are inner with $\det=+1$.** $\det\mathrm{diag}(-1_2,1_6)=(-1)^2=+1$. An orthogonal complex structure $J$ has $J^2=-I$, so its eigenvalues are $\pm i$ in four conjugate pairs and $\det J=+1$; both lie in $SO(8)$, so both $\mathrm{Ad}$'s are inner.
- **They are $\mathrm{Aut}$-conjugate.** The fixed algebras are $\mathfrak{so}(2)\oplus\mathfrak{so}(6)$ and $\mathfrak u(4)$, both of dimension $16$, and the corresponding symmetric spaces are $D_4/P_1$ (the $6$-dimensional quadric $\widetilde G_2(\mathbb R^8)$) and $D_4/P_4$ (the spinor variety). **Triality permutes the three end nodes of $D_4$**, so it carries one to the other. The same fact in real-form language is the classical isomorphism $\mathfrak{so}^*(8)\cong\mathfrak{so}(6,2)$, whose two maximal compacts are exactly $\mathfrak u(4)$ and $\mathfrak{so}(6)\oplus\mathfrak{so}(2)$.
- **They are not $O(8)$-conjugate.** $\mathrm{Ad}(g)$ carries fixed algebra to fixed algebra, so $O(8)$-conjugacy of the involutions would give $O(8)$-conjugacy of the subalgebras and hence equivalence of their representations on $\mathbb R^8$. $\mathfrak{so}(2)\oplus\mathfrak{so}(6)$ splits $\mathbb R^8=\mathbb R^2\oplus\mathbb R^6$; $\mathfrak u(4)$ contains $iI$, so any invariant real subspace is a complex subspace of the $\mathbb C$-irreducible $\mathbb C^4$, and the action is $\mathbb R$-irreducible. **CONFIRMED.**

**The weight route is sound, and I verified it from the weights rather than from the block.** Write $\sigma=\mathrm{diag}(I_4,-I_4)=\exp\big(\pi(L_{56}+L_{78})\big)$, so $t=(0,0,1,1)$ and a weight $\lambda$ contributes $e^{i\pi\langle\lambda,t\rangle}$.

| representation | weights | eigenvalues of $\sigma$ |
| --- | --- | --- |
| $V$ | $\pm\epsilon_j$ | $\langle\lambda,t\rangle\in\{0,0,\pm1,\pm1\}$, $(1^4,(-1)^4)$ |
| $S^\pm$ | $\tfrac12(\pm\epsilon_1\pm\epsilon_2\pm\epsilon_3\pm\epsilon_4)$, even/odd sign count | $\langle\lambda,t\rangle=\tfrac12(s_3+s_4)\in\{0,\pm1\}$: $s_3s_4=+1$ forces $s_1s_2=\pm1$ to match parity, giving **four** weights at $-1$ and **four** at $+1$, $(1^4,(-1)^4)$ |

**All three patterns agree**, so a triality image of $\sigma$ projects to an $SO(8)$ element with the same $V$-spectrum and is therefore $O(8)$-conjugate to $\sigma$. *The same computation correctly reports the other pair as moving*: $\mathrm{diag}(-1_2,1_6)$ has $t=(1,0,0,0)$, giving $((-1)^2,1^6)$ on $V$ but $\langle\lambda,t\rangle=\pm\tfrac12$ and hence eigenvalues $\pm i$ on $S^\pm$, a different pattern, so triality moves it. **CONFIRMED, and it does carry $n=8$ alone**, every other even $n$ being covered by $\mathrm{Aut}(\mathfrak{so}(n))=\mathrm{Ad}(O(n))$ and every odd $n$ by $B_m$ having no diagram symmetry.

### The one line the block says is owed, supplied

> *"**And the step from $O(8)$-conjugacy to $SO(8)$-conjugacy is owed**, one line that the weight route does not itself supply."*

**It is one line, and it closes.** Suppose $\mathrm{Ad}(g)\mathfrak a=\mathfrak b:=\mathfrak{so}(4)\oplus\mathfrak{so}(4)$ with $g\in O(8)$, $\det g=-1$. Put $h=\mathrm{diag}(-1,1,1,1,1,1,1,1)$, a reflection inside the first block: $\mathrm{Ad}(h)\mathfrak b=\mathfrak b$, and $\det h=-1$. Then $g'=hg$ has $\det g'=+1$ and $\mathrm{Ad}(g')\mathfrak a=\mathrm{Ad}(h)\mathfrak b=\mathfrak b$. **So $O(8)$-conjugacy upgrades to $SO(8)$-conjugacy for this subalgebra**, because its $O(8)$-normaliser meets the non-identity component. *This is exactly the reason [conventions.md](../findings/conventions.md) records the $O(n)$/$SO(n)$ split as bearing on $\mathfrak u(n/2)$ and not on $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$: $\mathfrak u(4)$'s normaliser in $O(8)$ contains no $\det=-1$ element preserving the complex structure's orientation, which is why that one class splits in two.*

**No number was needed anywhere in this item, and none was used.**

---

## Item 7, [L26](../findings/nondegeneracy.md), why five splits missed $(3,4)$

**Every figure reproduces from $\mu=\frac{n-2}{2(p-1)(q-1)}$ and $\lambda_m=\frac{m-2}{2(m-1)}$.**

| $(p,q)$ | $n$ | $\mu$ | $\lambda_{\max(p,q)}$ | $(p-2)(q-3)$ | second-largest | gap |
| --- | --- | --- | --- | --- | --- | --- |
| $(3,4)$ | $\mathbf7$ | $\tfrac5{12}$ | $\tfrac13$ | $1$ | $\mu$ | $\tfrac1{12}$ |
| $(3,5)$ | $8$ | $\tfrac38$ | $\tfrac38$ | $\mathbf2$ | tie | $\tfrac18$ |
| $(4,4)$ | $8$ | $\tfrac13$ | $\tfrac13$ | $\mathbf2$ | tie | $\tfrac16$ |
| $(3,7)$ | $10$ | $\tfrac13$ | $\tfrac5{12}$ | $4$ | $\lambda$ | $\tfrac1{12}$ |
| $(5,5)$ | $10$ | $\tfrac14$ | $\tfrac38$ | $6$ | $\lambda$ | $\tfrac18$ |
| $(4,6)$ | $10$ | $\tfrac4{15}$ | $\tfrac25$ | $6$ | $\lambda$ | $\tfrac1{10}$ |

**Both halves of the strike are exact, and both are complete rather than sampled.** $(p-2)(q-3)=2$ over $q\ge p\ge3$ forces $p=3,q=5$ or $p=4,q=4$ and nothing else, since $p\ge5$ gives $(p-2)(q-3)\ge6$; so *"two of the five"* is the whole equality locus, not two instances of it. And $(p-2)(q-3)<2$ over the same range admits only $(3,3)$ and $(3,4)$, which closes the exception list, **I re-derived the factorisation cold**, $\lambda_{\max}<\mu$ clearing to $pq-3p-2q+4<0$ and $pq-3p-2q+4=(p-2)(q-3)-2$.

### But "false in both halves" overstates it, and the replacement reason is the weaker of the two available

**The struck sentence was:** *"the reason five splits ($(3,5)$, $(4,4)$, $(3,7)$, $(5,5)$, $(4,6)$), missed it is that it is a single lattice point in the region the inequality closes off."*

- **The "single lattice point" half is not false.** In $\{q\ge p\ge3\}$ the region $(p-2)(q-3)<2$ holds exactly $(3,3)$ and $(3,4)$, and $(3,3)$ is disposed of separately as the degeneracy case one paragraph above. **So $(3,4)$ genuinely is the one remaining lattice point in that region**, the block's own next sentence says so. What is false is only that *thinness explains the miss*; the description itself stands, and striking it "in both halves" loses a true statement along with a bad inference.
- **The replacement reason is true of its referent but names a symptom.** The five splits carry $n\in\{8,8,10,10,10\}$, **every one of them even.** $(3,4)$ has $n=7$, and **no odd $n$ appears anywhere in those five checks**, so any odd-$n$ exception would have been invisible to them regardless of where it sat. *"$n\ge8$, so it lay below the range"* is a statement about the minimum of a set whose parity is the real obstruction, and it invites the false inference that pushing the range down to $n=7$ would have been enough, when the same file records kernel checks *"over $\mathbb Q$ at $n=6$"*, below $7$, that also could not have seen it.

**The addition about the equality locus is the item's real content and is new.** *Two of the five sat on the boundary of the very region the exception lives in and still reported nothing*, because on that boundary $\mu$ ties $\lambda_{\max(p,q)}$ and the gap $1/(2\max(p,q)-2)$ comes out unchanged, $\tfrac18$ at $(3,5)$ and $\tfrac16$ at $(4,4)$, matching the general formula exactly. **That is a much stronger account of the miss than either the struck sentence or its replacement**: the check was blind on the boundary, not merely aimed elsewhere.

*The order-dependence nit the same edit adds checks out:* $(5,3)$ gives $(p-2)(q-3)=0<2$ and would be declared an exception, while $\mu=\lambda_5=\tfrac38$ is the tie already covered by $(3,5)$.

**Nothing in L26's mathematics moves under this item.** The statement, the closed form, the criterion and the exception list are untouched; what is contested is a sentence about the history of a numerical check that lives in a *different* block, at [nondegeneracy.md](../findings/nondegeneracy.md)'s L27 material, which still carries the neutral wording.

---

## What would falsify each refutation I confirmed, and what I did to look for it

| item | the object that would falsify it | what I did |
| --- | --- | --- |
| **1** | a $k_0\le\binom{12}2$ making the level-2 bound's ratio $58.9$ *unreachable*, i.e. any reading under which $58.9$ is not $k_0=66$'s own output | Inverted the chain exactly at $k_0=66,74,34$ and at the two printed bounds $1.7974$, $1.3951$. $k_0=66$ gives $58.9194$ and the map $k_0\mapsto$ ratio is strictly decreasing, so no admissible $k_0$ reaches it from below. **Found the opposite defect instead**: the *second* strike's $S^6\times S^6$ reductio needs a reading the struck sentence's own "larger $k_0$ only lowers $\lambda$" clause contradicts |
| **2** | a pair $(\mathop{\mathrm{tr}}S^3,\mathop{\mathrm{tr}}S^4)$ the working edge excludes and Cauchy–Schwarz admits, which would rescue the relabelled sentence | Tested the block's own $(\tfrac12,\tfrac15)$ in both index orders. **The relabelling is false in the block's own ordering**, and no substitute is offered. Also chased whether the working edge can exclude the corner at all, it can, through its equality case, which is why the headline survives |
| **4** | a reading of *"the true $\theta$"* under which $(\mathfrak{so}(9),\mathfrak{so}(8))$ still overshoots | Found one: against the **matching** sphere product $\theta_{a,b}$, L39 overshoots at **all four** $n=9$ splits, $(1,8)$ included. The struck sentence's own gloss *"$1.389084$ against $\Theta_9^2$"* rules that reading out, so the strike holds, but the record must say which reading it struck. Also enumerated the four splits at $n=9$ and found two better witnesses |
| **5** | an $n$ at which padded $W_{\mathbb{CP}^2}$ fails equality, or a scale at which the bracket stays positive | Rebuilt the bound from the split and got the exact slack; equality holds at every $n$ because $G_-=4(n-1)-4(n-4)=12$ is $n$-free, and the bracket's sign flip is forced by mixing degree $0$ with degree $2$. **Found a live contradiction instead**, between the repaired statement's *"at a critical point"* and [conventions.md](../findings/conventions.md)'s *"neither needing criticality"* |
| **6** | an $O(8)$ element conjugating $\mathfrak{so}(2)\oplus\mathfrak{so}(6)$ to $\mathfrak u(4)$ | Reduced to the $\mathbb R^8$-representation: one is reducible, one is $\mathbb R$-irreducible because $\mathfrak u(4)\ni iI$. **No such element can exist**, so the witness is safe. Confirmed the $\mathrm{Aut}$-conjugacy independently through $\mathfrak{so}^*(8)\cong\mathfrak{so}(6,2)$ and through the $D_4$ node permutation, and verified the weight test from the weights |
| **7** | a sixth checked split, or a member of the five at odd $n$, or a point of the equality locus outside $\{(3,5),(4,4)\}$ | Enumerated the locus $(p-2)(q-3)=2$ over $q\ge p\ge3$ in closed form (it is exactly those two) and read the five $n$ values, all even. **The strike survives; its stated reason does not survive as the best one** |

**Item 3 is not in this table because I did not confirm it as a refutation.** The object that would have falsified my verdict is a version of the block, at any commit, that lacked the *"CAPPED DOES NOT MEAN BELOW THE TARGET"* box; `git show d25f6c6d` shows the box present in the parent, in the strike's own words, under a Gate 2 `CONFIRMED`.
