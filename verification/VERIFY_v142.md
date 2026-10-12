# VERIFY v142, Lemma L70: the deficiency identity, the nonnegativity of $D(v)$, and its equality case

*Cold brief, verifier v142, round L70. **No numerical work was done**: no script was run, no numeric library was touched, and every value below is an exact hand evaluation of a closed form on the record. Log: [agent_logs/verify-L70-v142.log](../agent_logs/verify-L70-v142.log). Sources read: [findings/bounds.md](../findings/bounds.md):182–240 and :255–335, :625–675, [results.md](../results.md):39, :194, :581, [findings/conventions.md](../findings/conventions.md), [findings/stratum-two-negative.md](../findings/stratum-two-negative.md), [lean/INDEX.md](../lean/INDEX.md), [ATTEMPTS.md](../ATTEMPTS.md), [reviews/REVIEW_r565.md](../reviews/REVIEW_r565.md), [reviews/REVIEW_r566.md](../reviews/REVIEW_r566.md).*

## Verdicts

| # | claim, read alone as a consumer would | verdict |
|---|---|---|
| C1 | the boxed identity $\theta=\lambda_{\min}+(n-2)\lambda_{\max}-D(v)/\lvert\lambda_{\min}\rvert$ at every critical point, every unit $v\in E_{\min}$ | **CORRECT**, derives in four lines from three cited ingredients; the assembly itself is written nowhere |
| C2 | $D(v)\ge0$: every factor $\lambda_a\lambda_b-\lambda_{\min}\lambda_{\max}$ nonnegative, at every pair type | **CORRECT**, checked at both-positive, both-negative, mixed and zero-index pairs |
| C3 | the strictness hypothesis, and $\operatorname{tr}W=0$ at $W\ne0$ supplying it | **CORRECT in [bounds.md](../findings/bounds.md); UNDERSTATED in [results.md](../results.md)** at both :194 and :581, which write $\lambda_{\min}<0\le\lambda_{\max}$ |
| C4 | equality $\iff\mathrm{ad}(v)$ supported on $E_{\min}\otimes E_{\max}$, for every unit $v\in E_{\min}$ | **CORRECT**, and the $\forall v$ is automatic rather than an extra hypothesis |
| C5 | the $\lVert W\rVert=1$ hypothesis | **BROKEN AS WRITTEN**, [bounds.md](../findings/bounds.md):222 states it, [bounds.md](../findings/bounds.md):224 denies it two lines below, and the denial is the false half |
| C6 | [results.md](../results.md):581's excluded-index sentence | **FALSE AS WRITTEN**, the repair that ran in [bounds.md](../findings/bounds.md) did not propagate to the canonical form |
| C7 | saturation forces $\dim E_{\min}\ge n/2$, $\dim E_{\max}\ge(n-2)/2$ | **CORRECT**, argument on file at [REVIEW_r566.md](../reviews/REVIEW_r566.md) §4; absent from [results.md](../results.md) |
| C8 | what [Lemma L71](../results.md) consumes is what this block establishes | **YES**, the three inclusions follow from the support condition, and the scalar hypothesis reaches the support condition through C3's strictness |

**Verdict: `PROVEN, hypotheses corrected`.** The mathematics of L70 is right at every point I could reach by hand, I reproduce the identity's slack exactly at four independent objects, but three of its written statements are defective, one of them a live self-contradiction inside the source block and one a false sentence standing alone in the canonical form.

## 0. Conventions, fixed once

Quoted from [conventions.md](../findings/conventions.md), not restated:

- $Q(W)=W^2+W^\#$, $P(W)=\langle W,Q(W)\rangle$, $\theta=P(W)/\lVert W\rVert^3$, and **at a critical point $Q(W)=\theta W$**. "Critical point" means critical for $P$ on the unit sphere of $\mathcal W_n$ ([problem.md](../findings/problem.md):108).
- Inner product $\langle X,Y\rangle=\tfrac12\operatorname{tr}(X^{\mathsf T}Y)$ on $\Lambda^2\mathbb R^n=\mathfrak{so}(n)$, so $\operatorname{tr}(v^2)=-2$ at a unit bivector; Killing form $B(X,Y)=(n-2)\operatorname{tr}(XY)$.
- $c_{abc}=\langle[v_a,v_b],v_c\rangle$ is totally antisymmetric, $T_{abc}=c_{abc}^2$ totally symmetric and hollow. **Sums over pairs are over ORDERED pairs.**
- $\{v_a\}$ is an orthonormal eigenbasis of $W$ on $\mathfrak{so}(n)$ with $Wv_a=\lambda_a v_a$; $c_{vab}=\langle[v,v_a],v_b\rangle$ for $v\in E_{\min}$.
- $E_{\min}=\mathfrak m$, $E_{\max}=\mathfrak h$, $\mathfrak r$ everything else, kernel included.
- **[Lemma L153](../findings/bounds.md)** (the Killing row marginal): $\sum_\beta\lVert[v,v_\beta]\rVert^2=2(n-2)\lVert v\rVert^2$ for **any** $v\in\mathfrak{so}(n)$, at every $n\ge2$, the general-$v$ form, which is the one L70 needs and which the block was repaired to state.
- **[Lemma L31](../findings/stratum-two-negative.md)** (the pair cap): $\sum_\gamma T_{\alpha\beta\gamma}=\lVert[v_\alpha,v_\beta]\rVert^2\le2$ for orthonormal $X,Y\in\mathfrak{so}(n)$, stated for an orthonormal *pair*, not for basis elements, so it applies to a general unit $v\in E_{\min}$ against a basis eigenvector orthogonal to it.

## 1. The hypothesis inventory

A pass without one is not a pass. Every hypothesis the block carries, every hypothesis of every imported result, and then which the written proof uses.

| # | hypothesis | carried where | used where | status against the object |
|---|---|---|---|---|
| H1 | $W$ is a critical point of $P$ on the unit sphere of $\mathcal W_n$ | both forms | supplies $Q(W)=\theta W$, hence $\langle v,W^\#v\rangle=\theta\lambda_{\min}-\lambda_{\min}^2$; this is relation (C) | **used, essential** |
| H2 | $\lVert W\rVert=1$ | [bounds.md](../findings/bounds.md):222 only | makes the criticality eigenvalue equal the scale-invariant $\theta$ | **used, essential, and denied two lines below (§5)** |
| H3 | $v\in E_{\min}$, unit | both forms | $Wv=\lambda_{\min}v$; and $\lambda_{\min}\ne0$ for the division | **used, essential; unit norm of $v$ is in fact removable (§4)** |
| H4 | $\lambda_{\min}<0<\lambda_{\max}$ strictly | [bounds.md](../findings/bounds.md):222 strict; [results.md](../results.md):194 and :581 non-strict | needed for $D\ge0$'s equality clause, **not** for the identity | **used for C2/C4; understated in the canonical form (§6)** |
| H5 | $\operatorname{tr}W=0$ at $W\ne0$ | [bounds.md](../findings/bounds.md):222, [results.md](../results.md):581 | supplies H4 on $\mathcal W_n$ | **correct: trace-free and nonzero forces both strict signs** |
| H6 | $W\in\mathcal W_n$ (Ricci-flat, first Bianchi) | statement | **only through H5.** The identity itself is a fact about any symmetric $W$ on $\mathfrak{so}(n)$ with $Q(W)=\theta W$ | **used only indirectly** |
| H7 | the mass identity $\sum_{a,b}c_{vab}^2=2(n-2)$ | both forms, cited to [L153](../findings/bounds.md) | supplies the $(n-2)$ in the bound; the *general-$v$* form is required, since $v$ need not be a basis vector | **imported, correct, and the quantifier repair it needed has landed** |
| H8 | the $\#$ eigenbasis formula $\langle v,W^\#v\rangle=\tfrac12\sum_{a,b}\lambda_a\lambda_b c_{vab}^2$ | [bounds.md](../findings/bounds.md):188 | the whole left side | **imported foundation.** Anchored on the record at [LEDGER.md](../findings/LEDGER.md):1107, where two reviewers rebuild $\theta(W_{\mathbb{CP}^2})=\sqrt{3/2}$ from $\mathfrak{so}(4)$ structure constants by hand; the $\#$ normalisation is [conventions.md](../findings/conventions.md)'s halved Böhm–Wilking product |
| H9 | the pair cap $\lVert[v_\alpha,v_\beta]\rVert^2\le2$ ([L31](../findings/stratum-two-negative.md)) | [bounds.md](../findings/bounds.md):226 | **only** the dimension theorem C7, never the identity | **imported, correct, orthonormality satisfiable by choosing the eigenbasis of $E_{\min}$ to contain $v$** |
| H10 | $n\ge4$ | nowhere stated | $\mathcal W_3=0$, so the statement is empty below $4$ | **unstated and harmless** |
| H11 | [Lemma L23](../results.md)'s admissibility cap | the two-eigenvalue corollary only | the step from "symmetric pair" to "balanced sphere product" | **imported; the block's own footnote says the unbalanced and $\mathfrak u(m)$ members are not in $\mathcal W_n$ at all, which is a numerical claim I cannot check (§8)** |

**What the written proof uses that the statement does not carry:** H2 at [results.md](../results.md):581 and :194, and H8 at both sites. **What the statement carries that the proof does not use:** H6 beyond H5, and, at [results.md](../results.md):194, nothing else.

## 2. Pre-registered question 1, the derivation, step by step, with the hypothesis each step spends

The block asserts the identity in one sentence, *"The bound replaces every product $\lambda_a\lambda_b$ by its minimum $\lambda_{\min}\lambda_{\max}$ over the spectrum and spends the fixed mass"*, and then displays the box. **The assembly is written out nowhere I could find**, in [bounds.md](../findings/bounds.md), [results.md](../results.md) or [ATTEMPTS.md](../ATTEMPTS.md). What *is* on file is each of its three ingredients, separately and with its own citation. Here is the assembly, four lines, with the spend recorded against each.

**Step 1, criticality.** $Q(W)=\theta W$ with $Q=W^2+W^\#$ gives $W^\#=\theta W-W^2$. Pairing against a unit $v\in E_{\min}$, and using $Wv=\lambda_{\min}v$:
$$\langle v,W^\#v\rangle=\theta\lambda_{\min}-\lambda_{\min}^2 .$$
*Spends H1 and H3. Spends H2:* the $\theta$ appearing here is the criticality eigenvalue, and it equals the scale-invariant $P/\lVert W\rVert^3$ only at $\lVert W\rVert=1$.

**Step 2, the $\#$ formula.** $\langle v,W^\#v\rangle=\tfrac12\sum_{a,b}\lambda_a\lambda_b c_{vab}^2$. *Spends H8. Spends no criticality and no Weyl membership.*

**Step 3, add and subtract the constant, and spend the mass.**
$$\tfrac12\sum_{a,b}\lambda_a\lambda_b c_{vab}^2=\underbrace{\tfrac12\sum_{a,b}\big(\lambda_a\lambda_b-\lambda_{\min}\lambda_{\max}\big)c_{vab}^2}_{=\,D(v)}+\tfrac12\lambda_{\min}\lambda_{\max}\underbrace{\sum_{a,b}c_{vab}^2}_{=\,2(n-2)}=D(v)+(n-2)\lambda_{\min}\lambda_{\max}.$$
*Spends H7, and the general-$v$ form of it, since $v$ is an arbitrary unit vector of $E_{\min}$ and need not be a basis element. Spends no sign hypothesis: this is pure bookkeeping.*

**Step 4, divide.** Combining, $\theta\lambda_{\min}-\lambda_{\min}^2=D(v)+(n-2)\lambda_{\min}\lambda_{\max}$, so
$$\theta=\lambda_{\min}+(n-2)\lambda_{\max}+\frac{D(v)}{\lambda_{\min}}=\lambda_{\min}+(n-2)\lambda_{\max}-\frac{D(v)}{\lvert\lambda_{\min}\rvert}.$$
*Spends $\lambda_{\min}\ne0$ for the division and $\lambda_{\min}<0$ for the last rewriting, the only place the sign of $\lambda_{\min}$ enters the identity.*

**So the identity is correct, and its hypothesis footprint is smaller than the statement's**: it needs H1, H2, H3, H7, H8 and $\lambda_{\min}<0$. It does **not** need $\lambda_{\max}>0$, Weyl membership beyond what supplies $\lambda_{\min}<0$, $\theta>0$, or $n\ge5$. The nonnegativity of $D$ is a separate claim with a separate footprint, and §3 treats it separately.

**No finding: the homogeneity check the block gives is right.** Under $W\mapsto sW$ the left side is fixed ($\theta=P/\lVert W\rVert^3$ is degree $0$) while $\lambda\mapsto s\lambda$ makes $\lambda_{\min}+(n-2)\lambda_{\max}$ degree $1$, $D$ degree $2$ and $D/\lvert\lambda_{\min}\rvert$ degree $1$. So the right side is homogeneous of degree one and the identity holds at exactly one scale. That is precisely [bounds.md](../findings/bounds.md):222's argument, and it is sound.

## 3. Pre-registered question 2, is $D(v)\ge0$, and under what condition exactly

**The factor is $\lambda_a\lambda_b-\lambda_{\min}\lambda_{\max}$ and the weight is $c_{vab}^2\ge0$.** The question is whether $\lambda_{\min}\lambda_{\max}$ is the minimum of $\lambda_a\lambda_b$ over the spectrum. Assume $\lambda_{\min}<0<\lambda_{\max}$ strictly. Every pair $(a,b)$ occurring in the sum falls in one of four cases, and I check all four:

| case | factor | argument |
|---|---|---|
| both positive, $\lambda_a,\lambda_b>0$ | $\lambda_a\lambda_b>0>\lambda_{\min}\lambda_{\max}$ | a positive number exceeds a negative one |
| both negative, $\lambda_a,\lambda_b<0$ | $\lambda_a\lambda_b>0>\lambda_{\min}\lambda_{\max}$ | same |
| one index in $\ker W$ | $0>\lambda_{\min}\lambda_{\max}$ | **strictly** positive factor, so kernel mass always costs |
| mixed, $\lambda_a<0<\lambda_b$ | $\lambda_a\lambda_b=-\lvert\lambda_a\rvert\lambda_b\ \ge\ -\lvert\lambda_{\min}\rvert\lambda_{\max}=\lambda_{\min}\lambda_{\max}$ | $\lvert\lambda_a\rvert\le\lvert\lambda_{\min}\rvert$ and $\lambda_b\le\lambda_{\max}$, both factors nonnegative |

**So $D(v)\ge0$, and the only pairs achieving the factor $0$ are the mixed ones with $\lambda_a=\lambda_{\min}$ and $\lambda_b=\lambda_{\max}$**, the last row's two inequalities are simultaneously tight only there. The block's phrase *"a nonnegative weight against a nonnegative factor"* is exactly right, and the case list it does not write is the four rows above.

**What fails when the strictness fails, and it is not what the block implies.** The block says only *"on an all-negative spectrum the termwise step fails and $D$ goes negative"*. There are two distinct failure modes and the record names one:

- **$\lambda_{\max}<0$ (all-negative spectrum).** Then $\lambda_{\min}\lambda_{\max}>0$ and it is *not* the minimum product: with $\lambda=(-0.684,-0.570,-0.456)$, $\lambda_{\min}\lambda_{\max}=0.684\times0.456=0.311904$ against the smaller $0.456^2=0.207936$ and $0.570\times0.456=0.259920$. Both of the block's figures check out to three places by hand. **The sign fails, and with it the bound; the identity survives**, since Steps 1–4 never used a sign beyond $\lambda_{\min}<0$.
- **$\lambda_{\max}=0$, the case the record's own $\le$ permits and nobody treats.** Then every $\lambda_a\le0$, so every product $\lambda_a\lambda_b\ge0=\lambda_{\min}\lambda_{\max}$ and **$D\ge0$ still holds**. What breaks is the *equality characterisation*: $D=0$ now means every support pair has $\lambda_a\lambda_b=0$, i.e. at least one index in $\ker W=E_{\max}$, which is strictly weaker than "supported on $E_{\min}\otimes E_{\max}$". So at $\lambda_{\max}=0$ the "only if" direction of C4 is false while the "if" direction and $D\ge0$ both survive. **This is unreachable on $\mathcal W_n\setminus\{0\}$** ($\operatorname{tr}W=0$ with $W\ne0$ forces some $\lambda>0$) which is exactly why [results.md](../results.md)'s non-strict $\le$ has never bitten. It is nonetheless a hypothesis the canonical form states too weakly for the conclusion it draws; §6.

**And $\lambda_{\min}=0$ is unreachable for the same reason** and would leave the identity's division undefined rather than false. **$\ker W\ne0$ is fully compatible with everything above**: it only adds strictly positive factors, so saturation forces $\lVert[\mathfrak m,\mathfrak r]\rVert=0$, which is precisely the third of [Lemma L71](../results.md)'s three inclusions.

## 4. Quantifier order, scope, and every edge of the range

- **"At every critical point and for every unit $v\in E_{\min}$"**, the $\forall v$ is genuine and, at a critical point, automatic. $W^\#=\theta W-W^2$ is a polynomial in $W$, so $W^\#$ acts on $E_{\min}$ by the scalar $\theta\lambda_{\min}-\lambda_{\min}^2$ and $\langle v,W^\#v\rangle$, hence $D(v)$, is constant on the unit sphere of $E_{\min}$. So $D(v)=0$ at one $v$ iff at all, and the equality clause's $\forall v$ carries no extra content. **This argument is on file** at [bounds.md](../findings/bounds.md):257 and it is correct; note it consumes criticality, so off the critical locus the constancy is not available.
- **$v$'s unit norm is removable.** $\langle v,W^\#v\rangle=(\theta\lambda_{\min}-\lambda_{\min}^2)\lVert v\rVert^2$ and, by [L153](../findings/bounds.md)'s general form, the mass is $2(n-2)\lVert v\rVert^2$; both sides of Step 3 scale by $\lVert v\rVert^2$, so Step 4 is unchanged. *No finding, the record simply states more than it needs here.*
- **$\ker W\ne0$.** Identity unaffected; nonnegativity unaffected; saturation forces $[\mathfrak m,\ker W]=0$. Consistent with the record: $W_{\mathbb{CP}^2}$ at $n=4$ saturates **with a $3$-dimensional kernel**, and [lean/INDEX.md](../lean/INDEX.md):270 records the inclusion $[\mathfrak m,\mathfrak r]=0$ checked there on the nose.
- **$\lambda_{\min}=0$.** Excluded by $\operatorname{tr}W=0$, $W\ne0$; would make Step 4 undefined. Stated correctly.
- **Smallest admissible $n$.** $\mathcal W_3=0$, so $n\ge4$; at $n=4$ the mass is $2(n-2)=4$ and the statement is non-vacuous. The block's *"the identity does not need $n\ge5$"* is right, and $n=4$ is where its equality case has its most interesting witness.
- **Odd $n$.** The identity holds unchanged. §7's dimension theorem then reads $\dim E_{\min}\ge\lceil n/2\rceil$ and $\dim E_{\max}\ge\lceil(n-2)/2\rceil$, neither of which is contradictory on its own at odd $n$, it is [Lemma L71](../results.md)'s Lie theory, not L70, that empties the saturating set there. **No finding: L70 makes no parity claim and correctly makes none.**
- **$\dim E_{\min}>1$.** This is the whole of §6's defect, and it is also the *generic* case at every saturating point: §7 forces $\dim E_{\min}\ge n/2\ge2$.
- **$\dim E_{\min}=1$.** Then the only $E_{\min}$ index is $v$ itself and $c_{vvb}=\langle[v,v],v_b\rangle=0$, so **no support pair can lie in $E_{\min}\times E_{\max}$ and $D(v)>0$ strictly.** Saturation is impossible at simple $\lambda_{\min}$, a free corollary, consistent with §7 and stated on the record only inside [REVIEW_r565.md](../reviews/REVIEW_r565.md) as its D4.

## 5. DISCREPANCY 1, the $\lVert W\rVert=1$ hypothesis is asserted and denied two lines apart, in one block

**Locate it exactly.** [findings/bounds.md](../findings/bounds.md):222, the sentence immediately under the box:

> **And it needs $\lVert W\rVert=1$**: under [conventions.md](conventions.md)'s $\theta=P(W)/\lVert W\rVert^3$ the left side is scale-invariant while the right is homogeneous of degree one, so the identity holds at one scale only. *The list of what the identity does not need carried "unit norm" until this audit, and [r323](../reviews/REVIEW_r323.md) and [r324](../reviews/REVIEW_r324.md) both propagated it, each reading $\theta$ as the criticality eigenvalue.*

[findings/bounds.md](../findings/bounds.md):224, the closing clause of the blockquote **two lines below it**:

> *What the identity does **not** need*: unit norm, Weyl membership, $\theta>0$, or $n\ge5$.

**The correcting sentence claims the list was repaired (*"carried 'unit norm' until this audit"*) and the list still carries it.** The correction landed beside the statement it corrects, and the uncorrected statement is the one a consumer skimming for a hypothesis list will read, because it is the one shaped like a hypothesis list.

**Exhibit the failure concretely.** Take the balanced sphere product at $n=6$, whose spectrum I evaluate exactly in §8: $\lambda_{\min}=-\sqrt{2(n-2)/(n-1)}/n=-\tfrac{1}{6}\sqrt{8/5}$, $\lambda_{\max}=\sqrt{2/((n-1)(n-2))}=\sqrt{1/10}$, $D=0$, $\theta=\theta_0(6)=\sqrt{40}/6=\sqrt{10}/3$. Now rescale to $W'=2W$, still a critical *direction* and still in $\mathcal W_6$. Then $\theta(W')=P(W')/\lVert W'\rVert^3=\theta(W)=\sqrt{10}/3$ unchanged, while $\lambda'_{\min}+(n-2)\lambda'_{\max}=2(\lambda_{\min}+4\lambda_{\max})=2\sqrt{10}/3$ and $D(v)'/\lvert\lambda'_{\min}\rvert=0$. **The two sides read $\sqrt{10}/3$ against $2\sqrt{10}/3$ and the identity is false by a factor of $2$.** The failure is generic in the scale, not special to this point.

**Argue the opposite, the most charitable reading the words support.** Two readings would save line 224.

1. *"Unit norm" could mean $v$'s unit norm rather than $W$'s.* §4 shows that reading makes the clause **true**: $v$'s normalisation cancels out of Step 3. But line 222's own gloss forecloses it, it says in as many words that this list is the one that carried the wrong entry, and its subject is $\lVert W\rVert$. Under the record's own account of the sentence, the reading is unavailable.
2. *$\theta$ could mean the criticality eigenvalue rather than $P/\lVert W\rVert^3$.* Under that reading $\theta$ is homogeneous of degree one, both sides scale together, and line 224 is right. This is exactly the reading [r323](../reviews/REVIEW_r323.md) and [r324](../reviews/REVIEW_r324.md) took, per line 222. But [conventions.md](../findings/conventions.md) fixes $\theta=P(W)/\lVert W\rVert^3$ and the record's rule is that conventions are quoted and not restated, so a consumer is bound to the scale-invariant reading.

**Neither reading survives the block's own text, so the candidate stands.** The defect is not that the record does not know the answer (line 222 states it correctly) but that the wrong statement was left standing underneath the right one, which is this record's catalogued failure mode.

**What it costs.** Nothing to the mathematics; everything to a consumer who reads the list. It is the reason [r323](../reviews/REVIEW_r323.md) and [r324](../reviews/REVIEW_r324.md) propagated the error once already, and the list is still in the state that produced them.

## 6. DISCREPANCY 2, the canonical form at [results.md](../results.md):581 carries a sentence [bounds.md](../findings/bounds.md) has already refuted

**Locate it exactly.** [results.md](../results.md):581, inside Lemma L70's canonical statement:

> The subtracted constant $\lambda_{\min}\lambda_{\max}$ is attained only on pairs containing the row index, which $c_{vab}$'s support excludes, so the boxed form is the weakened member of a per-row family whose sharp member subtracts $m_1$, the minimum of $\lambda_a\lambda_b$ over the support; the two coincide whenever $\lambda_{\min}$ has multiplicity at least $2$, which covers every saturating point on the record.

Against [findings/bounds.md](../findings/bounds.md):224, which opens by refuting exactly that sentence:

> **THE EXCLUDED-INDEX EFFECT REACHES THIS BOUND ONLY WHEN $\dim E_{\min}=1$.** *The sentence that opened here (that $\lambda_{\min}\lambda_{\max}$ is attained only on a pair containing the row index), is **false whenever $\dim E_{\min}\ge2$**…*

**Exhibit the failure concretely, at a named object.** Take $W_{\mathbb{CP}^2}$ at $n=4$, spectrum $(2,-1,-1,0,0,0)/\sqrt6$ on $\Lambda^2\mathbb R^4$. Here $\dim E_{\min}=2$: write $E_{\min}=\mathrm{span}\{v,w\}$ and $E_{\max}=\mathrm{span}\{u\}$, all three inside the self-dual $\Lambda^+\cong\mathfrak{su}(2)$. The pair $(w,u)$ has $\lambda_w\lambda_u=\lambda_{\min}\lambda_{\max}$ **and lies in $c_{vab}$'s support**: total antisymmetry kills $c_{vab}$ only when $a$ or $b$ *is* $v$, and $w\ne v$. Indeed §8 shows $c_{vwu}^2=2$ there, the maximum the pair cap allows. So the minimum product is attained inside the support, $m_1=\lambda_{\min}\lambda_{\max}$, and the sentence's *"which $c_{vab}$'s support excludes"* is false at the very point the record's own $n=4$ classification names as saturating.

**Argue the opposite.** The most charitable reading is that *"the row index"* means the *eigenvalue* $\lambda_{\min}$ rather than the *vector* $v$, under which the exclusion would be of every $E_{\min}$ index and the sentence would be true. That reading makes the sentence's second half incoherent: if all of $E_{\min}$ were excluded then $m_1$ would never equal $\lambda_{\min}\lambda_{\max}$ and the clause *"the two coincide whenever $\lambda_{\min}$ has multiplicity at least $2$"* (in the same sentence), would be false rather than true. **A sentence cannot be rescued by a reading that refutes its own second clause.** [REVIEW_r565.md](../reviews/REVIEW_r565.md):85 reaches the same disposal: *"it excludes the vector $v$, not the eigenvalue $\lambda_{\min}$."*

**Two further defects in the same sentence, both from the same failed propagation.**

- **The population hedge outlived its replacement.** [bounds.md](../findings/bounds.md):226 replaced *"covers every saturating point on the record"* with the theorem $\dim E_{\min}\ge n/2$, and says so in as many words: *"This replaces the population hedge that stood here with a proof."* [results.md](../results.md):581 still carries the hedge, and carries the theorem nowhere. A consumer of the canonical form therefore has a claim about a catalogue where the record has a claim about all $n$.
- **The strictness is understated at both [results.md](../results.md) sites.** :581 reads *"so $\lambda_{\min}<0\le\lambda_{\max}$ by $\operatorname{tr}W=0$"* and :194 *"given $\lambda_{\min}<0\le\lambda_{\max}$"*, while [bounds.md](../findings/bounds.md):222 says the equality characterisation **needs the strict inequality**. §3 shows the gap is real: at $\lambda_{\max}=0$ the nonnegativity survives but the "only if" of the equality clause does not, and both [results.md](../results.md) sites state that equality clause. What $\operatorname{tr}W=0$ at $W\ne0$ actually gives is the strict $\lambda_{\min}<0<\lambda_{\max}$, so :581 both cites the right reason and records less than that reason yields.
- **$\lVert W\rVert=1$ appears at neither [results.md](../results.md) site.** It is recoverable from [problem.md](../findings/problem.md):108's definition of a critical point as an idempotent of $P$ on the unit sphere, so this is a thinner defect than §5's, but it is the hypothesis [bounds.md](../findings/bounds.md) singles out as having been missing once already, and the canonical form is where a consumer reads the hypotheses.

**Reading each citable claim alone, as a consumer would, the named trap, discharged.** [results.md](../results.md):581 stands alone in the record as L70's canonical statement; it links to [bounds.md](../findings/bounds.md) only as *"Proof:"*. A consumer who cites it inherits one false sentence, one superseded hedge, one understated spectral hypothesis and one absent normalisation hypothesis, with no signal that any of the four has been repaired eighty lines away in another file.

## 7. The dimension theorem, an argument is on file, and it is correct

**The block asserts it without proof** ([bounds.md](../findings/bounds.md):226): *"Saturation forces $\dim E_{\min}\ge n/2$ and $\dim E_{\max}\ge(n-2)/2$, from the pair cap [Lemma L31](../findings/stratum-two-negative.md) and the Killing marginal alone"*, citing *"Gate 2, [r565](../reviews/REVIEW_r565.md) and [r566](../reviews/REVIEW_r566.md)"*. **Before recording that as unargued I read those two reports.** [REVIEW_r566.md](../reviews/REVIEW_r566.md) §4 carries the derivation in full, and it is sound. Reconstructing it independently:

At saturation the mass $2(n-2)$ sits entirely on $E_{\min}\times E_{\max}\cup E_{\max}\times E_{\min}$, and by $c_{vab}=-c_{vba}$ the two halves are equal, so each carries $n-2$. Choose the eigenbasis of $E_{\min}$ to contain $v$, always possible, and it makes $v$ orthonormal to every other $E_{\min}$ index, which is what [Lemma L31](../findings/stratum-two-negative.md) requires.

- **Along the $E_{\max}$ index.** For fixed $b\in E_{\max}$, $\sum_a c_{vab}^2=\lVert[v_b,v]\rVert^2\le2$ by the pair cap. Summing over $b\in E_{\max}$: $n-2\le2\dim E_{\max}$, so $\dim E_{\max}\ge(n-2)/2$.
- **Along the $E_{\min}$ index.** For fixed $a\in E_{\min}$, $\sum_b c_{vab}^2=\lVert[v,v_a]\rVert^2\le2$; and the index $a=v$ contributes $0$ by antisymmetry. Summing over the remaining $\dim E_{\min}-1$ indices: $n-2\le2(\dim E_{\min}-1)$, so $\dim E_{\min}\ge n/2$.

**No criticality beyond what puts $v$ in $E_{\min}$, no spectrum and no Lie theory**, the block's characterisation of the input is exact. **And both bounds are attained**, at $W_{\mathbb{CP}^2}$ at $n=4$: $\dim E_{\min}=2=n/2$ and $\dim E_{\max}=1=(n-2)/2$, checked by hand in §8.

**Two consequences the block draws, and both are right.** (i) $\dim E_{\min}\ge n/2\ge2$ at every $n\ge4$, so the sharp and weak members of the per-row family agree at every saturating point and the [L107](../findings/bounds.md)-style sharpening is void where L70 is used. (ii) $W_{\mathbb{CP}^m}$ cannot saturate at $m\ge3$: there $n=2m$ and the requirement is $\dim E_{\max}\ge m-1\ge2$ against the recorded $\dim E_{\max}=1$. *That last input ($\dim E_{\max}(W_{\mathbb{CP}^m})=1$), is imported from the record and I did not re-derive it.*

**No finding on the citation**: the block's *"from the pair cap and the Killing marginal alone"* is a faithful description of an argument that exists at the cited place. What is missing is only that the argument is not in [findings/](../findings/) and is nowhere in [results.md](../results.md).

## 8. Pre-registered question 3, and the universal claim's witnesses, one object from each structured family

*"At every critical point" is a universal claim. Below, four objects, one from each family the record names, each evaluated in closed form by hand. Every number here is exact arithmetic on a closed form, not a measurement.*

**The family's closed forms, fixed once.** For the two-eigenvalue family $W\propto\Pi_{\mathfrak h}-\tfrac rN I$ with $r=\dim\mathfrak h$, $N=\binom n2$, the record's closed form is $\theta=\tfrac2n\sqrt{rN/(N-r)}$ ([README.md](../README.md), item 12). Normalising, $\lVert\Pi_{\mathfrak h}-\tfrac rNI\rVert^2=r(N-r)/N$, so with $s=\sqrt{r(N-r)/N}$,
$$\lambda_{\max}=\frac{N-r}{Ns},\qquad \lambda_{\min}=-\frac{r}{Ns},\qquad \theta=\frac{2r}{ns},\qquad \lambda_{\min}+(n-2)\lambda_{\max}=\frac{(n-2)(N-r)-r}{Ns}.$$

### 8.1 Sphere products, the balanced split $\mathfrak{so}(m)\oplus\mathfrak{so}(m)$, $n=2m$: **saturates at every even $n$, proved by hand**

$r=m(m-1)$, $N=m(2m-1)$, $N-r=m^2$, so $s=m\sqrt{(m-1)/(2m-1)}$ and
$$\lambda_{\min}+(n-2)\lambda_{\max}=\frac{(2m-2)m^2-m(m-1)}{m(2m-1)s}=\frac{(m-1)(2m-1)}{(2m-1)s}=\frac{m-1}{s},\qquad \theta=\frac{2m(m-1)}{2m\,s}=\frac{m-1}{s}.$$
**The two agree identically, so $D(v)=0$ at every even $n$**, an exact algebraic saturation, with no numerics anywhere. As a cross-check, $\tfrac{m-1}s=\tfrac1m\sqrt{(m-1)(2m-1)}=\tfrac{\sqrt{2(n-1)(n-2)}}{n}=\theta_0(n)$, which is [conventions.md](../findings/conventions.md)'s closed form. At $n=6$ this reads $\lambda_{\min}=-\sqrt{10}/15$ with multiplicity $9$ and $\lambda_{\max}=\sqrt{10}/10$ with multiplicity $6$; $\sum\lambda^2=9\cdot\tfrac{10}{225}+6\cdot\tfrac{10}{100}=\tfrac25+\tfrac35=1$ and $\sum\lambda=-\tfrac{9\sqrt{10}}{15}+\tfrac{6\sqrt{10}}{10}=0$, so the point is unit and trace-free as required, and $\lambda_{\min}+4\lambda_{\max}=\tfrac{5\sqrt{10}}{15}=\tfrac{\sqrt{10}}3=\theta_0(6)$.

**This confirms the record's *"slack $0.000000000$ at $n=6,8,10,12$"* row as an identity rather than a measurement.**

### 8.2 $W_{\mathbb{CP}^2}$ and a padding, saturates at $n=4$, and the padded deficiency is exactly $(n-4)/3$

Spectrum $(2,-1,-1,0,0,0)/\sqrt6$ on $\Lambda^2\mathbb R^4$, so $\lambda_{\min}=-1/\sqrt6$ (multiplicity $2$), $\lambda_{\max}=2/\sqrt6$ (multiplicity $1$), $\ker W$ of dimension $3$.

- **At $n=4$:** $\lambda_{\min}+(n-2)\lambda_{\max}=\tfrac{-1+4}{\sqrt6}=\tfrac3{\sqrt6}=\sqrt{3/2}=\theta(W_{\mathbb{CP}^2})$. **$D(v)=0$: it saturates**, with $\dim E_{\min}=2=n/2$ and $\dim E_{\max}=1=(n-2)/2$, both bounds of §7 attained exactly. The mass is $2(n-2)=4$, and with $E_{\min}=\mathrm{span}\{v,w\}$, $E_{\max}=\mathrm{span}\{u\}$ the only surviving support pairs are $(w,u)$ and $(u,w)$, so $2c_{vwu}^2=4$ and $c_{vwu}^2=2$, which forces $\lVert[v,w]\rVert^2=2$, the pair cap [L31](../findings/stratum-two-negative.md) attained on the nose. That is consistent: $E_{\min}$ and $E_{\max}$ lie in the self-dual $\Lambda^+\cong\mathfrak{su}(2)$, where the record's own hand check gives $[\omega_1,\omega_2]=-\sqrt2\,\omega_3$ and $c_{123}^2=2$ ([LEDGER.md](../findings/LEDGER.md):1107).
- **Padded to $n\ge5$:** padding preserves norm and $\theta$ ([conventions.md](../findings/conventions.md)) and adds only zero eigenvalues, so $\lambda_{\min},\lambda_{\max}$ are unchanged and $\lambda_{\min}+(n-2)\lambda_{\max}=\tfrac{2n-5}{\sqrt6}$ against $\theta=\tfrac3{\sqrt6}$. Hence
$$\frac{D(v)}{\lvert\lambda_{\min}\rvert}=\frac{2n-8}{\sqrt6}\ \Longrightarrow\ D(v)=\frac1{\sqrt6}\cdot\frac{2(n-4)}{\sqrt6}=\frac{n-4}{3}.$$
**This reproduces the record's *"padded $W_{\mathbb{CP}^2}$ has … deficiency $(n-4)/3$, never $0$"* exactly, in closed form**, and it shows the deficiency vanishing precisely at $n=4$, the one dimension where the record says $W_{\mathbb{CP}^2}$ saturates. It is also a live witness that $\ker W\ne0$ is compatible with saturation at $n=4$, so the record's *"saturation forces $\ker W=0$"* is correctly scoped to $n\ge5$.

### 8.3 A subalgebra Casimir, the maximal torus, and $\mathrm{ad}(\mathfrak{su}(3))$: the whole slack column reproduced in closed form

**Maximal torus $\mathfrak{so}(2)^{m}$, $n=2m$.** $r=m$, $N=m(2m-1)$, $N-r=m(2m-2)$, so $s=\sqrt{m(2m-2)/(2m-1)}$ and
$$\lambda_{\min}+(n-2)\lambda_{\max}=\frac{(2m-2)\cdot m(2m-2)-m}{m(2m-1)s}=\frac{(2m-2)^2-1}{(2m-1)s}=\frac{2m-3}{s},\qquad \theta=\frac{2m}{2m\,s}=\frac1s .$$
**So the slack is exactly $(2m-4)/s=(n-4)\,\theta$**, a closed form the record does not state. Evaluating:

| $n$ | $s^2=r(N-r)/N$ | $\theta=1/s$ | slack $=(n-4)\theta$ | record's row |
|---|---|---|---|---|
| $6$ | $12/5$ | $\sqrt{15}/6$ | $\sqrt{15}/3=1.290994\ldots$ | $1.291$ ✓ |
| $8$ | $24/7$ | $\sqrt{42}/12$ | $\sqrt{42}/3=2.160247\ldots$ | $2.160$ ✓ |
| $10$ | $40/9$ | $3/\sqrt{40}$ | $6\cdot3/\sqrt{40}=2.846050\ldots$ | $2.846$ ✓ |
| $12$ | $60/11$ | $\sqrt{11/60}$ | $8\sqrt{11/60}=3.425394\ldots$ | $3.425$ ✓ |

**$\mathrm{ad}(\mathfrak{su}(3))\subset\mathfrak{so}(8)$.** $r=8$, $N=28$, $N-r=20$, $s=\sqrt{8\cdot20/28}=\sqrt{40/7}$. Then $\theta=\tfrac{2\cdot8}{8s}=\tfrac2s=\sqrt{70}/10$ and $\lambda_{\min}+6\lambda_{\max}=\tfrac{6\cdot20-8}{28s}=\tfrac4s$, so **slack $=\tfrac2s=\sqrt{70}/10=0.836660\ldots$**, the record's $0.836660$ exactly, and equal to $\theta$ itself at this point.

**All five slack figures in the block's table are reproduced by hand, in closed form, with no computation.** The table is confirmed, not merely unfalsified.

### 8.4 Something with a kernel

Padded $W_{\mathbb{CP}^2}$ (§8.2) has a kernel of dimension $\binom n2-3$ and is the record's own kernel witness; §3's third row shows why every unit of mass on a kernel pair costs a strictly positive $\lvert\lambda_{\min}\rvert\lambda_{\max}$. **No separate finding.**

### 8.5 A bonus check the block does not carry, saturation on the two-eigenvalue family is a dimension count

Setting the two closed forms equal, $n\big[(n-2)(N-r)-r\big]=2rN$ with $N=n(n-1)/2$ gives $n(n-2)N=r\big[n(n-2)+n+2N\big]=2rn(n-1)$, hence
$$\boxed{\ r=\dim\mathfrak h=\frac{n(n-2)}4\ }$$
**So on the two-eigenvalue family, L70 saturation is exactly the statement that $\dim\mathfrak h$ attains [Lemma L23](../results.md)'s cap.** This reproduces by hand, from the identity alone, the *"required $\dim\mathfrak h=n(n-2)/4$"* that [Lemma L71](../results.md) asserts and that [L117](../findings/bounds.md)'s block calls a quantity the record elsewhere records as underived. It also checks the three witnesses against each other: the balanced split has $r=m(m-1)=n(n-2)/4$ exactly, the torus $r=n/2$ and $\mathrm{ad}(\mathfrak{su}(3))$ $r=8$ against a required $12$, both short, both therefore slack, which is what §8.3 measures.

## 9. Comparing the forms, [bounds.md](../findings/bounds.md), [results.md](../results.md):39/:194/:581, and the Lean row

| | [bounds.md](../findings/bounds.md):216–240 | [results.md](../results.md):194 (landscape) | [results.md](../results.md):581 (canonical) | [results.md](../results.md):39 (achievements) | [lean/INDEX.md](../lean/INDEX.md):271 |
|---|---|---|---|---|---|
| spectral hypothesis | $\lambda_{\min}<0<\lambda_{\max}$ **strict** | $\lambda_{\min}<0\le\lambda_{\max}$ | $\lambda_{\min}<0\le\lambda_{\max}$ | none | strict, and **proved** to follow from tracelessness |
| $\lVert W\rVert=1$ | stated at :222, **denied at :224** | absent | absent | absent | not applicable (both sides degree $1$) |
| equality clause | $\mathrm{ad}(v)$ on $E_{\min}\otimes E_{\max}$, $\forall v$ | same | same | absent | **owed** |
| excluded-index sentence | present but **qualified**: false when $\dim E_{\min}\ge2$ | absent | present, **unqualified, false** | absent | absent |
| dimension theorem | present, with the $n/2$ and $(n-2)/2$ bounds | absent | **absent**, the superseded population hedge stands in its place | absent | absent |
| the identity itself | asserted; assembly written nowhere | asserted | asserted | asserted | **owed** |

**On the Lean row.** [lean/INDEX.md](../lean/INDEX.md):271 marks L70 **partial** and is honest about the split: what is kernel-checked is the three facts under $D(v)\ge0$, that strict signs make $\lambda_{\min}\lambda_{\max}$ the minimum product, that tracelessness at $W\ne0$ supplies them, and that the step fails on an all-negative spectrum, while *"the identity in general, and its equality case … are owed"*, and [lean/INDEX.md](../lean/INDEX.md):351 carries the same as an open box. **That is the right split and it matches §2–§3 of this report exactly**: what Lean has proved is §3, and what it owes is §2 and §4.

**One error in that row.** It reads *"at padded `W_{ℂP²}` the deficiency **vanishes**, `λ_min + (n-2)λ_max = -1 + 2·2 = 3`"*. The arithmetic uses $n-2=2$, so $n=4$, the **unpadded** $W_{\mathbb{CP}^2}$. §8.2 shows the padded point has deficiency $D=(n-4)/3>0$ at every $n\ge5$, so the deficiency vanishes at exactly the dimension where the point is not padded. The mathematics in the row is right and the word *"padded"* is wrong; the block it is checking against ([bounds.md](../findings/bounds.md):640) says in as many words that padded $W_{\mathbb{CP}^2}$ has *"deficiency $(n-4)/3$, never $0$"*, so the row contradicts its own source.

**A row that does not exist and what it would have to claim.** There is no Lean row for the *identity*. It would have to claim: for a symmetric $W$ on $\mathfrak{so}(n)$ with $Q(W)=\theta W$ and $\lVert W\rVert=1$, and a $v$ with $Wv=\lambda_{\min}v$, $\lambda_{\min}<0$, given $\langle v,W^\#v\rangle=\tfrac12\sum\lambda_a\lambda_bc_{vab}^2$ and $\sum c_{vab}^2=2(n-2)\lVert v\rVert^2$, the boxed equation holds. That is §2's four lines and needs no analysis, it is arithmetic over an abstract index set with two hypotheses supplied as parameters.

## 10. The gap between what is proven and what is used, and what [Lemma L71](../results.md) consumes

**Does L71 consume what L70 establishes?** Yes, and the chain is tight, but it passes through the strictness hypothesis that [results.md](../results.md) understates.

L71's stated hypothesis is *"Lemma L70 holds with equality, the scalar condition $\theta=\lambda_{\min}+(n-2)\lambda_{\max}$"*. Its first move is to read that as three inclusions. The bridge is:

1. **Scalar $\Rightarrow$ $D(v)=0$.** Immediate from the identity, since $\lvert\lambda_{\min}\rvert\ne0$.
2. **$D(v)=0\Rightarrow$ support condition.** By §3's case list, $D(v)=0$ forces every support pair to have $\lambda_a\lambda_b=\lambda_{\min}\lambda_{\max}$, and **under the strict $\lambda_{\min}<0<\lambda_{\max}$** the only such pairs are $(\lambda_{\min},\lambda_{\max})$ ones. *This step is where the strictness is load-bearing, and it is the step whose hypothesis [results.md](../results.md):194 and :581 record as $\le$.*
3. **Support condition $\Rightarrow$ the three inclusions.** For $v\in\mathfrak m$: if $v_a\in\mathfrak m$ then $c_{vab}\ne0$ forces $b\in\mathfrak h$, giving $[\mathfrak m,\mathfrak m]\subseteq\mathfrak h$; if $v_a\in\mathfrak h$ then $b\in\mathfrak m$, giving $[\mathfrak m,\mathfrak h]\subseteq\mathfrak m$; if $v_a\in\mathfrak r$ then no $b$ survives, giving $[\mathfrak m,\mathfrak r]=0$. **All three, and nothing more, and the quantifier "$\forall$ unit $v\in E_{\min}$" is exactly what promotes a per-$v$ support statement to a statement about the subspace $\mathfrak m$.**

**So L71 consumes precisely L70's structural equality case, and the $\forall v$ quantifier is not decoration, L71 would not get $[\mathfrak m,\mathfrak m]\subseteq\mathfrak h$ from a single $v$.** §4 shows the $\forall v$ is free at a critical point, so no debt is created.

**What a consumer may cite, stated exactly.**

- **May cite unconditionally:** the boxed identity, at a **unit-norm** critical point of $\mathcal W_n$ and any $v\in E_{\min}$ (unit or not); $D(v)\ge0$; equality $\iff\mathrm{ad}(v)$ supported on $E_{\min}\otimes E_{\max}$ for every $v\in E_{\min}$; $D(v)$ constant on $E_{\min}$; saturation $\Rightarrow\dim E_{\min}\ge n/2$ and $\dim E_{\max}\ge(n-2)/2$; and, on the two-eigenvalue family, saturation $\iff(\mathfrak{so}(n),\mathfrak h)$ symmetric, equivalently $\dim\mathfrak h=n(n-2)/4$.
- **May NOT cite:** *"the subtracted constant $\lambda_{\min}\lambda_{\max}$ is attained only on pairs containing the row index"*, false at $\dim E_{\min}\ge2$, which is every saturating point; *"what the identity does not need: unit norm"*, false; *"which covers every saturating point on the record"*, superseded by a theorem; *"$\lambda_{\min}<0\le\lambda_{\max}$"* as the hypothesis of the **equality** clause, too weak, and the right hypothesis is available free.
- **Cites an unread source:** the step from *"$(\mathfrak{so}(n),\mathfrak h)$ is a symmetric pair"* to *"the balanced sphere product"* runs through **Cartan's classification**, which [conventions.md](../findings/conventions.md) records as *"invoked in four findings files and cited to no source anywhere on the record; [references/](../references/) holds no Helgason or Cartan entry."* I confirm: no Cartan or Helgason entry is in [references/](../references/). **That link of the chain rests on an unread source.** It is L71's and L23's debt rather than L70's, but a consumer following L70's two-eigenvalue corollary to its stated conclusion inherits it.
- **Rests on a run I cannot check:** the block's claim that unbalanced $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ and $\mathfrak u(m)$ *"are not Weyl tensors at all"*, with distances $0.4237$, $0.7638$, $0.2664$, $0.7454$. §8.5 shows why this matters rather than being decoration: **the unbalanced symmetric pairs have $\dim\mathfrak h=n(n-2)/4+t^2>n(n-2)/4$, so the dimensional criterion says they do not saturate while the Lie criterion says every symmetric pair does.** The two criteria are reconciled only by $\mathcal W_n$-membership failing for them, which is exactly what that run asserts. **A consumer of the two-eigenvalue corollary should know that this is where its consistency is carried.**

## 11. What would break it, and what I did to look

**The object that would falsify the statement.** A critical unit $W\in\mathcal W_n$ and a $v\in E_{\min}$ carrying $c_{vab}\ne0$ on a pair with $\lambda_a\lambda_b<\lambda_{\min}\lambda_{\max}$, that is, a critical point whose spectrum is nowhere positive, or nowhere negative. **$\operatorname{tr}W=0$ at $W\ne0$ forbids it outright**, so any falsifier would have to be a $W$ the record calls a critical point of $\mathcal W_n$ while failing trace-freeness, which is a failure of $\mathcal W_n$-membership, not of L70. Weaker falsifiers: a critical point where $W^\#$ is not a polynomial in $W$ (would break the $\forall v$ clause) (forbidden by $Q(W)=\theta W$; or a saturating point with $\dim E_{\min}<n/2$), forbidden by §7's two lines.

**What I did to look.** Case-analysed the factor over all four pair types including the zero-eigenvalue and both-negative rows (§3); evaluated the identity in exact closed form at the balanced split at every even $n$, at $W_{\mathbb{CP}^2}$ at $n=4$ and padded at general $n$, at the maximal torus at $n=6,8,10,12$, and at $\mathrm{ad}(\mathfrak{su}(3))\subset\mathfrak{so}(8)$, reproducing every slack figure the block's table carries (§8); checked both edges of the dimension theorem at its attaining point; and derived the family's saturation criterion independently as a dimension count and checked it against all three family witnesses (§8.5). **No falsifier, and the closed forms agree with the record everywhere they meet.**

## 12. Verdict, `PROVEN, hypotheses corrected`

**The mathematics passes.** The identity derives in four lines; $D(v)\ge0$ holds at every pair type; the equality case is an exact iff under the strict spectral hypothesis; the $\forall v$ quantifier is free; the dimension theorem is sound and has an argument at the place the block cites; and what [Lemma L71](../results.md) consumes is exactly what the equality case delivers. Every closed form I evaluated agrees with the record.

**Four corrections are owed before the statements match the mathematics.**

1. **[findings/bounds.md](../findings/bounds.md):224, delete *"unit norm"* from the list of what the identity does not need.** Line 222 states the correction and says the list was repaired; it was not. This is the record's signature failure mode, live, two lines apart, in one block. (§5)
2. **[results.md](../results.md):581, the excluded-index sentence is false as written** and must be qualified to $\dim E_{\min}=1$, exactly as [bounds.md](../findings/bounds.md):224 was. It is false at $W_{\mathbb{CP}^2}$, at every balanced sphere product, and at every saturating point there is or could be. (§6)
3. **[results.md](../results.md):581, replace *"which covers every saturating point on the record"* with the theorem** $\dim E_{\min}\ge n/2$, $\dim E_{\max}\ge(n-2)/2$, which [bounds.md](../findings/bounds.md):226 already carries and which makes the clause hold at every $n$ rather than over a catalogue. (§6, §7)
4. **[results.md](../results.md):194 and :581, write $\lambda_{\min}<0<\lambda_{\max}$**, which is what $\operatorname{tr}W=0$ at $W\ne0$ gives and what the equality clause both sites state actually needs. And state $\lVert W\rVert=1$ at :581, since it is the hypothesis [bounds.md](../findings/bounds.md) records as having gone missing once already. (§3, §6)

**One correction outside this block's scope:** [lean/INDEX.md](../lean/INDEX.md):271 should read *"at $W_{\mathbb{CP}^2}$ at $n=4$"* rather than *"at padded $W_{\mathbb{CP}^2}$"*; padded, the deficiency is $(n-4)/3$ and never zero. I have not touched the file. (§9)

**No finding:** on the quantifier order; on the smallest admissible $n$; on odd $n$; on $\ker W\ne0$; on $\dim E_{\min}>1$ as it affects the identity or its equality case; on the block's homogeneity argument; on the block's description of the dimension theorem's inputs; on the slack table, every row of which I confirmed in closed form; and on the Lie-theoretic reduction to symmetric pairs on [Lemma L23](../results.md)'s family, which I re-derived and which is correct as written.
