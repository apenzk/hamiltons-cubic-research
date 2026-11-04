# Review r590, Lemma L30 (a small negative eigenspace forces a small support)

**Reviewer**: r590, independent adversarial audit, cold brief.
**Target**: `Lemma L30 (a small negative eigenspace forces a small support), canonical statement and proof`, in [findings/stratum-two-negative.md](../findings/stratum-two-negative.md).
**Footing**: analysis only. No computation was run beyond screens of seconds on objects constructed for the purpose, and any such screen is labelled a screen.

Verdicts are appended below as they are reached.

## Log

- Report file created before any mathematics.

---

## D1, the provenance line. **REFUTED** (first clause), CONFIRMED (second clause)

The block's note at [stratum-two-negative.md:210](../findings/stratum-two-negative.md#L210) reads *"Moved here from [results.md](../results.md) on 2026-08-31, where the argument was the only copy. That file now carries the statement and points here."*

**The move is real and dated correctly.** A distinctive-phrase search puts the heading's first appearance in commit `a9e4b8c0` `refactor(results): the proofs move to findings, results.md states and points`, 2026-08-31 19:34:41 +0200, parent `84cada75`. That one commit adds the identical note to **38** blocks across ten findings files, so it is a stamp rather than a per-block claim, consistent with what [r586](REVIEW_r586.md) found.

**First clause, "the argument was the only copy", false, and the other copy was already in the destination file.** At the parent commit `84cada75`, [findings/stratum-two-negative.md](../findings/stratum-two-negative.md) already carried, in the section that today sits **directly above** the block:

| parent line | content | where it is today |
| --- | --- | --- |
| 75 | $\mathrm{Ric}(W)(x,x)=\sum_\alpha\lambda_\alpha\lVert v_\alpha x\rVert^2$ and the PSD identity $\sum_\alpha\lambda_\alpha v_\alpha^{\mathsf T}v_\alpha=0$ | line 184 |
| 77 | a complete **Proof.** that $W$ vanishes on $u\wedge u^\perp$, ending in $\square$ | line 186 |
| 114 | **Proposition (padding reduction)** carrying $\lVert W'\rVert=\lVert W\rVert$, $\theta(W')=\theta(W)$ and the Ricci-flatness of the restriction | line 249 |

So every ingredient of the moved block (the identity, a proof of the vanishing, and the padding claim with norm and $\theta$), was already in this file, 30 to 40 lines from where the block landed. The move created a second copy inside one file, and the note asserts the opposite.

**Second clause, true.** [results.md:418](../results.md#L418) carries the statement verbatim and [results.md:422](../results.md#L422) points at `findings/stratum-two-negative.md`; the landscape entry at [results.md:146](../results.md#L146) is consistent with it.

---

## D2, the mathematics of the proof. **CONFIRMED**, with one sentence literally false and three conjuncts unproved

Rebuilt from the definitions, in the conventions [conventions.md](../findings/conventions.md) fixes: bivector $\leftrightarrow$ skew matrix with $x\wedge y=xy^{\mathsf T}-yx^{\mathsf T}$, pairing $\langle X,Y\rangle=\tfrac12\mathop{\mathrm{tr}}(X^{\mathsf T}Y)$ (the half-trace bullet, the one the record runs in).

**Step 1, the PSD identity is right, and it is an identity, not an implication.** For $W=\sum_\alpha\lambda_\alpha\,v_\alpha\otimes v_\alpha$ with $\{v_\alpha\}$ $\Lambda^2$-orthonormal,
$$\langle v,x\wedge y\rangle=\tfrac12\big(\mathop{\mathrm{tr}}(v^{\mathsf T}xy^{\mathsf T})-\mathop{\mathrm{tr}}(v^{\mathsf T}yx^{\mathsf T})\big)=x^{\mathsf T}vy,$$
so $\sum_i\langle v_\alpha,x\wedge e_i\rangle^2=\lVert v_\alpha^{\mathsf T}x\rVert^2=\lVert v_\alpha x\rVert^2$ and
$$\mathop{\mathrm{Ric}}(W)(x,x)=\sum_i\langle W(x\wedge e_i),x\wedge e_i\rangle=x^{\mathsf T}\Big(\sum_\alpha\lambda_\alpha v_\alpha^{\mathsf T}v_\alpha\Big)x .$$
The bracketed matrix is symmetric, so Ricci-flatness is **equivalent** to its vanishing. The block's first sentence is exactly this. **Correct.** *(Derived by hand; no computation run.)*

**Step 2, image containment. Correct, and it gives equality.** With $P=\sum_{\lambda_\alpha>0}\lambda_\alpha v_\alpha^{\mathsf T}v_\alpha$ and $Q=\sum_{\lambda_\alpha<0}\lvert\lambda_\alpha\rvert v_\alpha^{\mathsf T}v_\alpha$, the identity is $P=Q$. For skew $v$, $\mathop{\mathrm{im}}(v^{\mathsf T}v)=\mathop{\mathrm{im}}v$, and images of positive semidefinite matrices add, so $\mathop{\mathrm{im}}Q=U$ and hence $\mathop{\mathrm{im}}P=U$, giving $\mathop{\mathrm{im}}v_\alpha\subseteq U$ for every $\lambda_\alpha>0$.

**Step 3, one sentence is literally false, harmlessly.** The block writes *"For $u\perp U$ this gives $v_\alpha u=0$ **for all $\alpha$**"*. It holds only for $\alpha$ with $\lambda_\alpha\ne0$. **Witness**: at padded $W_{\mathbb{CP}^2}$ in $\mathcal W_{10}$ with $U=\mathbb R^4$, the bivector $e_9\wedge e_{10}$ is a $0$-eigenvector and $u=e_9\perp U$ has $(e_9\wedge e_{10})u=-e_{10}\ne0$. The conclusion survives because the $\lambda_\alpha=0$ terms drop out of $W(u\wedge w)=\sum_\alpha\lambda_\alpha\langle v_\alpha,u\wedge w\rangle v_\alpha$ regardless. **One-word repair**: "for every $\alpha$ with $\lambda_\alpha\ne0$".

**Step 4, the vanishing. Correct, and stronger than stated.** $\langle v_\alpha,u\wedge w\rangle=-\langle v_\alpha u,w\rangle$, so $W(u\wedge w)=0$ for **every** $w\in\mathbb R^n$, not merely $w\perp u$, and $W$ *kills* the subspace rather than merely having zero quadratic form on it, which is what the downstream "at least $n-1$ zero eigenvalues" needs.

**Where $\dim U<n$ enters: nowhere in the argument.** Every step above runs unchanged when $\dim U=n$; the conclusions are then vacuous ($U^\perp=0$) or trivial ($W$ is a padding of itself). **$\dim U<n$ is a non-vacuity condition, not a hypothesis.**

**Three conjuncts of the statement are asserted and not proved in the block.**

| conjunct | status inside the block |
| --- | --- |
| $W$ is supported on $\Lambda^2U$ | the step from "kills $u\wedge\mathbb R^n$ for each $u\perp U$" to "$\mathop{\mathrm{im}}W\subseteq\Lambda^2U$" needs the self-adjointness of $W$ and is not written |
| $W'$ satisfies the **first Bianchi identity**, so $W'\in\mathrm{Weyl}_{\dim U}$ | never mentioned; only Ricci-flatness of the restriction is argued |
| "**with the same norm and the same $\theta$**" | **no line of the proof addresses either** |

All three are true and each is one line, supplied below, but a block headed *canonical statement and proof* carries them as assertions.

---

## D3, the norm and $\theta$ under padding. **CONFIRMED**, and here is the proof the block omits

Let $\iota:\Lambda^2U\hookrightarrow\Lambda^2\mathbb R^n$ be the inclusion induced by $U\subseteq\mathbb R^n$, and $W=\iota W'\iota^{\mathsf T}$.

**The embedding is an isometry, in either $\Lambda^2$ normalisation.** For an orthonormal basis of $\mathbb R^n$ adapted to $U\oplus U^\perp$, the set $\{e_i\wedge e_j\}_{i<j,\ e_i,e_j\in U}$ is orthonormal for $\langle X,Y\rangle=\tfrac12\mathop{\mathrm{tr}}(X^{\mathsf T}Y)$ inside $\Lambda^2\mathbb R^n$ and is the corresponding basis of $\Lambda^2U$. So the padded operator has the spectrum of $W'$ together with $\binom n2-\binom{\dim U}2$ extra zeros, and $\lVert W\rVert^2=\mathop{\mathrm{tr}}(W^2)=\mathop{\mathrm{tr}}(W'^2)=\lVert W'\rVert^2$. The record's second normalisation $\lvert W\rvert^2=4\lVert W\rVert_F^2$ ([conventions.md](../findings/conventions.md), norms bullet) is a fixed scalar multiple, so the equality is normalisation-independent, **which is the check the brief asks for, and it passes against the pairing rather than against the block's usage**.

**$Q$ commutes with padding.** $\mathop{\mathrm{tr}}(W^3)=\mathop{\mathrm{tr}}(W'^3)$ is immediate from the spectrum. For the sharp part, $W^\#=\tfrac12\sum_{\alpha\beta}\lambda_\alpha\lambda_\beta\,[v_\alpha,v_\beta]\otimes[v_\alpha,v_\beta]$ sums only over $\lambda_\alpha\ne0$, and by D2 every such $v_\alpha$ lies in $\mathfrak{so}(U)$. Since **$\mathfrak{so}(U)$ is a subalgebra**, $[v_\alpha,v_\beta]\in\mathfrak{so}(U)$, and the structure constants $\langle[v_\alpha,v_\beta],v_\gamma\rangle$ computed in $\mathfrak{so}(n)$ agree with those computed in $\mathfrak{so}(U)$ because the inner product restricts. Hence $\mathop{\mathrm{im}}W^\#\subseteq\Lambda^2U$ and $(\iota W'\iota^{\mathsf T})^\#=\iota(W'^\#)\iota^{\mathsf T}$.

Therefore $P(W)=\langle W,W^2+W^\#\rangle=P(W')$ and $\lVert W\rVert=\lVert W'\rVert$, so $\theta(W)=\theta(W')$. $\square$

**The first Bianchi identity restricts** because $\mathop{\mathrm{Alt}}(W)_{ijkl}=\tfrac13(W_{ijkl}+W_{iklj}+W_{iljk})$ ([conventions.md](../findings/conventions.md)) is an identity per index quadruple, and the quadruples with all four indices in $U$ are a subset of those on $\mathbb R^n$.

**This matches [conventions.md](../findings/conventions.md)'s standing line** *"Padding commutes with $Q$, and preserves both the norm and $\theta$"*, which is tabled there with **no source and no proof**. The nearest thing to an argument on the record is [nondegeneracy.md:409](../findings/nondegeneracy.md#L409), which gives the same subalgebra reason ("$[\Lambda^2\mathbb R^{n_0},\Lambda^2\mathbb R^{n_0}]\subseteq\Lambda^2\mathbb R^{n_0}$ forces $W^\#$ back into the block") alongside a numerical check. **Neither L30 nor conventions.md points at it.**

---

## D4, the quantifier and the hypothesis "at most two". **REFUTED as a necessary hypothesis**; the lemma is strictly more general than stated

**"At most two negative eigenvalues" is inert.** Nothing in D2 used the count. Set
$$U:=\mathop{\mathrm{im}}\Big(\textstyle\sum_{\lambda_\alpha<0}\lvert\lambda_\alpha\rvert\,v_\alpha^{\mathsf T}v_\alpha\Big)=\sum_{\lambda_\alpha<0}\mathop{\mathrm{im}}v_\alpha ,$$
manifestly independent of the choice of eigenbasis in each negative eigenspace. Then the block's own three steps give, for **every** $W\in\mathcal W_n$ and any number of negative eigenvalues:

> $W$ kills $u\wedge\mathbb R^n$ for every $u\perp U$, and $W$ is a padding of a $W'\in\mathcal W_{\dim U}$ with $\lVert W'\rVert=\lVert W\rVert$ and $\theta(W')=\theta(W)$.

**So "what happens at three negative eigenvalues" is: the same conclusion, verbatim.** The count enters only to make the two-summand formula for $U$ meaningful. This is a **scope understatement** of the kind commit `98e7521d` already had to fix once on [L29](../findings/stratum-two-negative.md#L69) in this same file.

**$\dim U=n-1$ survives.** The hypothesis is $\dim U<n$, so $n-1$ is admitted; $U^\perp$ is then a line $\mathbb Ru$ and the conclusion reads "$W$ kills $u\wedge\mathbb R^n$ and is a padding of a $\mathcal W_{n-1}$ tensor". Nothing in D2 needs $\dim U$ even, and no step degrades.

**Two loose ends in the statement as written, both harmless.**

- With **fewer than two** negative eigenvalues the symbol $v_{N-1}$ names a non-negative eigenvector, and if $\lambda_{N-1}=0$ that eigenvector is not determined by $W$, so $U$ is not well defined. The conclusion still holds for every admissible choice, because such a $U$ only contains the invariant one.
- With a **repeated** negative eigenvalue $v_{N-1},v_N$ are individually undetermined, but $U$ is not: it is $\mathop{\mathrm{im}}$ of the basis-free matrix $\lvert\lambda\rvert(v_{N-1}^{\mathsf T}v_{N-1}+v_N^{\mathsf T}v_N)$. **The block's "Scope, stated" paragraph is right about this**, and it is the point that distinguishes $U$ from the individual ranks.

---

## D5, the "Scope, stated" clause. **REPAIRED**, the dimension list is incomplete, and the same file gives the right one

The block reads: *"the rank-sum form fails to apply at padded $W_{\mathbb{CP}^2}$ for $n=6,7,8$, where the ranks are $4+4=8\ge n$ while $\dim U=4$ and the conclusion holds."*

**$n=5$ belongs in that list and is missing.** Triple-checked:

1. $\dim\mathcal W_5=\tfrac{5\cdot2\cdot6\cdot7}{12}=35$, and padding a $\mathcal W_4$ tensor gives a Weyl tensor ([nondegeneracy.md:409](../findings/nondegeneracy.md#L409), [ungraded-slack.md:21](../findings/ungraded-slack.md#L21)), so padded $W_{\mathbb{CP}^2}\in\mathcal W_5$ exists, and the record names it explicitly at [results.md:592](../results.md#L592) as *"$W_0$, the zero-padding of $W_{\mathbb{CP}^2}$"* on $\mathcal W_5$.
2. Both negative eigenvectors are complex structures on the $\mathbb R^4$ block, so $r_1=r_2=4$ and $r_1+r_2=8\ge5$: the rank-sum form fails.
3. $\dim U=4<5$: L30's hypothesis holds and the conclusion holds.

**The correct range is $n=5,6,7,8$, and the correct phrasing is 22 lines above in the same file.** The development-form proof at [stratum-two-negative.md:186](../findings/stratum-two-negative.md#L186) reads *"misses padded $W_{\mathbb{CP}^2}$ **below $n=9$**"*, which is exactly $5\le n\le8$. **The canonical block degraded a scope clause that its own file states correctly**, which is the brief's check (4) landing.

*Provenance of the slip*: [REVIEW_r58.md](REVIEW_r58.md) Claim 2 wrote "n = 6, 7, 8" and [REVIEW_r59.md:157](REVIEW_r59.md#L157) wrote "below $n=9$". The block copied the narrower of the two.

---

## D6, what is proved here and what is asserted, and the Gate 2 line. **REFUTED** (the Gate 2 clause)

**The heading's promise is half kept.** The vanishing on $u\wedge u^\perp$ is proved (D2). The padding conjuncts (support in $\Lambda^2U$, first Bianchi for $W'$, equal norm, equal $\theta$), are asserted (D2 table); D3 supplies them.

**The block's proof is [REVIEW_r58.md](REVIEW_r58.md)'s Claim 2, uncredited at this heading.** r58 wrote the PSD-identity route, the sharpened hypothesis $\dim(\mathop{\mathrm{im}}v_{N-1}+\mathop{\mathrm{im}}v_N)<n$, and the single-step conclusion to $\mathcal W_{\dim U}$; the block is that text. The development-form section above does credit "Reviewer 58" and "Reviewer 59"; the canonical block credits no one.

**"Gate 2 passed, both reviewers independently, each reaching the identity by its own route", false in two ways.**

- **The record's own index says otherwise.** [INDEX-results.md](../findings/INDEX-results.md), the file that by its own header owns the numbering and the Gate 2 status, carries at row **30**: *"**Gate 2: no verdict on the record.** a small negative eigenspace forces a small support"*. The block and the index cannot both be read at face value.
- **The Gate 2 that exists examined a different statement.** [r58](REVIEW_r58.md) and [r59](REVIEW_r59.md) both confirmed *"Padding reduction"*, the rank-sum Proposition now at [line 249](../findings/stratum-two-negative.md#L249), and each filed the $\dim U$ form as a **correction** to it. The $\dim U$ statement is the *output* of that Gate 2, not a statement that passed it.
- **"Each reaching the identity"** overstates r59. [r59](REVIEW_r59.md) Claim 2 never states $\sum_\alpha\lambda_\alpha v_\alpha^{\mathsf T}v_\alpha=0$; it reaches the same conclusion through $\mathop{\mathrm{Ric}}(u,u)=\sum_i\langle W(u\wedge e_i),u\wedge e_i\rangle$ and a zero-sum-of-nonnegatives argument. Two routes to the **conclusion**, one route to the identity.

*One thing the record does have and does not cite: [r59](REVIEW_r59.md) Claim 2 step 6 proves the $\theta$-preservation by the same subalgebra argument as D3 above, "for a new pair $a=(i,n)$, $[\varphi_a,\varphi_m]$ lands in the span of new pairs whenever $m$ is old, so the sharp has no off-block rows". Neither L30 nor [conventions.md](../findings/conventions.md)'s standing padding line points at it.*

---

## D7, the pointers. **REFUTED**, the one link that resolves *into* the block is dead

| pointer | target | verdict |
| --- | --- | --- |
| [stratum-two-negative.md:176](../findings/stratum-two-negative.md#L176), `#lemma-30--a-small-negative-eigenspace-...` | the L30 heading | **DEAD**. The heading is `#### Lemma L30, …`, whose slug is `lemma-l30--…`. The `l` is missing. |
| [stratum-two-negative.md:210](../findings/stratum-two-negative.md#L210) → `../results.md` | results.md | resolves |
| [results.md:422](../results.md#L422) → `findings/stratum-two-negative.md` | the file holding the proof | resolves (file-level, unanchored) |
| [LEDGER.md:1056](../findings/LEDGER.md#L1056), [INDEX-results.md:45](../findings/INDEX-results.md#L45) → `stratum-two-negative.md` | same | resolve |

**The file's own convention settles it**: every other in-file anchor here is `lemma-l<NN>-…`, lines 82, 84, 86, 116, 130, 200, 253, 389, 427, 451, 504. Exactly two lines drop the `l`: **line 176 (L30's own inbound link)** and line 11 (L29's). *Outside the counted scope, [REVIEW_r172.md:82](REVIEW_r172.md#L82) links L30 to `../response.md`, a file that no longer exists.*

---

## D8, what cites it, and whether the use is inside the hypotheses. **The genuine figure is 5**

Counting in [findings/](../findings/), [results.md](../results.md) and [report/](../report/) only. **Eleven** literal occurrences of the identifier, of which six are the result itself:

| occurrence | kind |
| --- | --- |
| [stratum-two-negative.md:208](../findings/stratum-two-negative.md#L208), [:176](../findings/stratum-two-negative.md#L176) | the heading and its own inbound pointer |
| [results.md:146](../results.md#L146), [:418](../results.md#L418) | the canonical mirror, landscape gloss and statement |
| [report/sections/07-gradedness-split.tex:1013](../report/sections/07-gradedness-split.tex#L1013) | the statement transcribed into the report |
| [INDEX-results.md:45](../findings/INDEX-results.md#L45) | the index row |

**Five genuine consuming sites**, and two of them sit outside L30's hypotheses:

| site | the use | inside the hypotheses? |
| --- | --- | --- |
| [report/sections/diagram.tex:68](../report/sections/diagram.tex#L68) | *"support $s$ forces a padding with $\theta\le M(s)$"*, tagged `L66, L30` | **no**, the clause carries no bound on the number of negative eigenvalues, which L30 requires. It is nonetheless **true**, and the record's own source for it is the support dichotomy at [fence-posts.md:283](../findings/fence-posts.md#L283) and [09-status.tex:174](../report/sections/09-status.tex#L174) ($\ker T$ for $T_{ip}=\sum_{jkl}W_{ijkl}W_{pjkl}$ is the annihilator), which needs no such hypothesis. A mislabel, not a false claim. |
| [report/sections/diagram-closed.tex:79](../report/sections/diagram-closed.tex#L79) | the same clause | **no**, same reason |
| [findings/LEDGER.md:1056](../findings/LEDGER.md#L1056) | records the repair that put L30 on those two figure nodes | inherits the same mislabel |
| [findings/bounds-relaxations.md:110](../findings/bounds-relaxations.md#L110) | *"any contraction of Prop 1.7 against a $\gamma$-independent weight recovers only Lemma L30/31"* | **loose**. Such a contraction returns the Killing marginal $\rho_\alpha=2(n-2)$ and $\sum_{\alpha\beta}\lambda_\alpha\lambda_\beta R_{\alpha\beta}=-2$; the second is a form of Ricci-flatness, which is L30's **input**, not its conclusion, and neither is L31's cap or its equality case. Traced to commit `6d3c62db` (2026-08-23), where the phrase already read "Lemma 30/31" against the same two statements. |
| [report/sections/07-gradedness-split.tex:1036](../report/sections/07-gradedness-split.tex#L1036) | *"the descent through Lemma 30 does not close this stratum"*, given [L34](../findings/stratum-two-negative.md#L361) | **correct**, a statement about L30's reach, and L34 is exactly the witness that $\dim U<n$ can fail |

**Content-level uses that do not name L30**, all consistent with it: [stratum-two-negative.md:370](../findings/stratum-two-negative.md#L370) and [:391](../findings/stratum-two-negative.md#L391) (L34's $\dim U$), [isotropy-cap.md:285](../findings/isotropy-cap.md#L285), [:300](../findings/isotropy-cap.md#L300), [:308](../findings/isotropy-cap.md#L308).

**A third copy of the D2 Step-3 slip, and in the statement rather than the proof.** Both [results.md:146](../results.md#L146) and [report/07-gradedness-split.tex:1013](../report/sections/07-gradedness-split.tex#L1013) read *"**every** eigenvector's image lies in $U$"* with no qualifier, false for the $\lambda=0$ eigenvectors by the same witness as D2. Three copies need the same three words, *with nonzero eigenvalue*.

---

## Conventions this block leans on that [conventions.md](../findings/conventions.md) does not fix

Read in full before deriving. Three of the block's four load-bearing symbols are absent from it.

- **"read as skew matrices".** The file fixes the *norms* under the identification $\Lambda^2\mathbb R^n\cong\mathfrak{so}(n)$, two bullets, half-trace against plain Frobenius, with the warning that both numbers are true of different pairings, but **never states the map**. $\varphi_{ab}=E_{ab}-E_{ba}$ appears only inside the plain-Frobenius half of one bullet, and the scale of $x\wedge y\mapsto xy^{\mathsf T}-yx^{\mathsf T}$ is nowhere fixed. The proof's pivot $\langle v,x\wedge y\rangle=x^{\mathsf T}vy$ (D2) is exactly where that scale would enter. **Inert here** (L30's conclusions are all "$=0$" statements and survive any positive rescaling) but the next result that carries a constant through this identification will not be so lucky.
- **$\mathop{\mathrm{im}}$.** Undefined. It is used in the block for the image of a *bivector read as an $n\times n$ matrix*, a subspace of $\mathbb R^n$; the same file uses $\mathop{\mathrm{im}}$ for the image of $W$ as an operator on $\Lambda^2$ (line 265). The block's usage is the first and is consistent throughout.
- **The padding relation.** [conventions.md](../findings/conventions.md) carries only *"Padding commutes with $Q$, and preserves both the norm and $\theta$. The stratum reduction turns on this."*, **an assertion with no definition of the operation, no embedding named, and no source column entry.** L30's conclusion is stated entirely in its terms. D3 supplies the derivation; [r59](REVIEW_r59.md) Claim 2 step 6 already held one.
- **$\mathrm{Weyl}_n$ against $\mathcal W_n$.** The block and [results.md](../results.md) write $\mathrm{Weyl}_n$; the conventions table only defines $\mathcal W_n$. The identification is never stated.
- *Inert but worth saying so a reader does not apply it*: [conventions.md](../findings/conventions.md)'s note that [stratum-two-negative.md](../findings/stratum-two-negative.md) is written throughout in Bourguignon–Karcher's $ikjl$ order, and that its $\mathring R$ statements need a sign flip to reach the record's Li order, **does not touch L30**, the block never uses the second-kind operator.

---

## Overall verdict

**The mathematics is CONFIRMED. The statement is understated, one of its sentences is false as written in three places, its provenance note is false, its Gate 2 claim contradicts the record's index, and the only link that points into it is dead.**

| # | defect | verdict |
| --- | --- | --- |
| 1 | *"the argument was the only copy"*, a proof of the vanishing and the padding claim with norm and $\theta$ were **already in this same file** at the parent commit, 30–40 lines from where the block landed | **REFUTED** |
| 2 | *"That file now carries the statement and points here"* | **CONFIRMED** |
| 3 | The PSD identity, image containment, vanishing on $u\wedge u^\perp$ | **CONFIRMED**, rebuilt from the definitions |
| 4 | *"this gives $v_\alpha u=0$ for all $\alpha$"*, false for $\lambda_\alpha=0$; witness $e_9\wedge e_{10}$, $u=e_9$ at padded $W_{\mathbb{CP}^2}$ in $\mathcal W_{10}$. Two further copies in the **statement** at [results.md:146](../results.md#L146) and [07-gradedness-split.tex:1013](../report/sections/07-gradedness-split.tex#L1013) | **REPAIRED**, insert *with nonzero eigenvalue*, three sites |
| 5 | *"with the same norm and the same $\theta$"*, the support step, and first Bianchi (asserted with no proof under a heading reading *canonical statement and proof* | **REPAIRED**), derivation in D3 |
| 6 | *"at most two negative eigenvalues"* is inert; the lemma holds for any number of negatives with $U=\sum_{\lambda_\alpha<0}\mathop{\mathrm{im}}v_\alpha$, and $\dim U<n$ is a non-vacuity condition rather than a hypothesis | **REFUTED as stated hypotheses**; the true statement is stronger |
| 7 | *"fails to apply … for $n=6,7,8$"* omits $n=5$; [line 186](../findings/stratum-two-negative.md#L186) of the same file has the right range, *below $n=9$* | **REPAIRED** |
| 8 | *"Gate 2 passed, both reviewers independently, each reaching the identity by its own route"* against [INDEX-results.md:45](../findings/INDEX-results.md#L45)'s *"Gate 2: no verdict on the record"*; and the Gate 2 that exists ([r58](REVIEW_r58.md), [r59](REVIEW_r59.md)) examined the **rank-sum** Proposition, filing this statement as its correction, while r59 reached the conclusion without ever stating the identity | **REFUTED** |
| 9 | [line 176](../findings/stratum-two-negative.md#L176)'s anchor `#lemma-30--…` is dead; the slug is `lemma-l30--…` | **REPAIRED** |
| 10 | Citation count: **5** genuine consuming sites, two of which (the figure nodes) attach an unqualified *"support $s$ forces a padding"* to a lemma that needs at most two negative eigenvalues | **REFUTED** as hypothesis-clean; harmless, since the support dichotomy carries the clause |

**Nothing here threatens the stratum reduction.** The load-bearing content, that a small negative eigenspace confines the whole tensor to $\Lambda^2U$, with norm and $\theta$ intact, is true, and true more generally than the block claims. What fails is the block's account of itself: its provenance, its Gate 2, its dimension list, its inbound link, and the three words missing from its statement.
