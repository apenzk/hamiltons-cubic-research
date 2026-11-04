# VERIFY v43, [Lemma L152](../findings/second-order.md): the numerator identity $\max_\Gamma\lvert\zeta\rvert=(1+\alpha)g_n$, the constant $C=\tfrac{1+\alpha}{\alpha-\gamma}$, and the $\alpha<1$ ruling the entry still asserts

*Verifier v43, 2026-09-05, cold brief. Target: the text of [Lemma L152](../findings/second-order.md) as dispatched in [ROUND_L152.md](ROUND_L152.md), quoted from [findings/second-order.md](../findings/second-order.md):1453–1473. **No numerical work**: no script was run, and every value below is an exact hand evaluation of a closed form, given as a fraction wherever it is one. Read at source: [Lemma L156](../findings/second-order.md), [Lemma L145](../findings/second-order.md), [Lemma L147](../findings/second-order.md), [results.md](../results.md), [findings/INDEX-results.md](../findings/INDEX-results.md), [r456](../reviews/REVIEW_r456.md), [r457](../reviews/REVIEW_r457.md), [r706](../reviews/REVIEW_r706.md), [structure-check/SKILL.md](../.claude/skills/structure-check/SKILL.md). No other verifier's report was read. Working: [agent_logs/verify-L152-v43.log](../agent_logs/verify-L152-v43.log).*

## Claim table

| # | claim, as the entry states it | verdict |
|---|---|---|
| 1 | $\max_\Gamma\lvert\zeta\rvert=\lvert\lambda_-\rvert+\alpha g_n=(1+\alpha)g_n$ on the circle of radius $\alpha g_n$ about $\lambda_-$ at $W^*$ | **PROVEN**, as an equality, for every $\alpha>0$ including $\alpha\ge1$ |
| 2 | the same identity "for any complex centre" | **BROKEN as written**; true for any centre **of modulus $g_n$**, false for any other |
| 3 | $\lvert\lambda_-\rvert=g_n$ "by definition of the gap" | **HYPOTHESIS-DEBT**: it is a theorem at $W^*$, resting on $\mathop{\mathrm{mult}}(\lambda_-)>\mathop{\mathrm{mult}}(\lambda_+)$, not a definition |
| 4 | the identity is unaffected by whether $\Gamma$ encircles $0$ | **PROVEN** (the entry does not say it; it is what [L156](../findings/second-order.md)'s citation needs, and it holds) |
| 5 | "the numerator is set by the eigenvalue the contour **encloses**" | **withdrawn as a defect**, it is set by the centre, which is the enclosed eigenvalue for this contour only |
| 6 | $\tfrac m{m-1}$ is $\lVert W^*\rVert_{op}/g_n$ in the second term of [r447](../reviews/REVIEW_r447.md)'s decomposition, and [r457](../reviews/REVIEW_r457.md) never estimates $\max_\Gamma\lvert\zeta\rvert$ | **CONFIRMED at source** ([r457](../reviews/REVIEW_r457.md) lines 70–76) |
| 7 | "**Consequence.** $C(\alpha,\gamma)=\tfrac{1+\alpha}{\alpha-\gamma}$" | **HYPOTHESIS-DEBT**: no step in the entry derives it, and the entry's own display yields a different quantity at a different scale |
| 8 | "$\alpha<1$ keeps $0$ outside and … the first binding" | **BROKEN**, refuted by [L156](../findings/second-order.md) sixteen lines above it in the same file, and contradicted by the entry's own box four lines above it |
| 9 | "Three independent computations meet at one value" ($M\le6\rho$) | **BROKEN**: [r456](../reviews/REVIEW_r456.md) states it inherited [r441](../reviews/REVIEW_r441.md)'s bookkeeping, so it is one computation checked at its own special case |
| 10 | the arithmetic, $20\%$, $9.5\%$, $17.9$ against $3.5$, the value $6$ | **CONFIRMED**, all four exact ($\tfrac65$, $\tfrac{23}{21}$, $\tfrac{700}{39}$ against $\tfrac72$, and $6$) |
| 11 | [results.md](../results.md) carries no L152 entry | **CORRECT** by that file's own rule; the surviving clause needs no entry of its own, and where it is cited it should carry its hypothesis |

**Verdict: PROVEN, hypotheses corrected**, on the surviving identity, which is what travels. The entry itself stays **BROKEN**, and in a third place its heading does not name.

**One line the round can act on:** the clause [L156](../findings/second-order.md) imports is true and needs only the $\le$ direction of one triangle inequality, so nothing downstream of L152 is at risk, but the entry that carries it also still asserts $\alpha<1$ as binding, which [L156](../findings/second-order.md) overturned, and that sentence is sixteen lines below its own refutation with no pointer.

## 0. Conventions, fixed once

- $W^*=S^m\times S^m$, $n=2m$; $\mathop{\mathrm{spec}}W^*=\{\lambda_-,\lambda_+\}$ with $\lambda_-<0<\lambda_+$, multiplicities $m^2$ and $m(m-1)$ ([second-order.md](../findings/second-order.md):897).
- $g_n$ is the absolute $\Lambda^2$ spectral gap at $0$, $\mathop{\mathrm{dist}}(\mathop{\mathrm{spec}}W^*,0)=\min_a\lvert\lambda_a\rvert$; at $W^*$ its closed form is $g_n=\sqrt{2(n-2)}/(n\sqrt{n-1})$ ([L145](../findings/second-order.md), [L147](../findings/second-order.md)).
- $\Gamma=\{\zeta\in\mathbb C:\lvert\zeta-\lambda_-\rvert=\alpha g_n\}$, the contour of the Riesz representation $W_-=-\tfrac1{2\pi i}\oint_\Gamma\zeta(W-\zeta)^{-1}d\zeta$; $\rho=\gamma g_n/\lVert H\rVert_{op}$ is the disc radius.
- $D=\lvert\lambda_+-\lambda_-\rvert/g_n=\tfrac{2m-1}{m-1}$ and $d=\min(\alpha,D-\alpha)$, both from [L156](../findings/second-order.md).
- At $n=12$, $m=6$: $\lambda_+=\tfrac65g_n$, $D=\tfrac{11}5$, $\alpha^*=\tfrac{11}{10}$, $\gamma^*=\tfrac{11}{20}$.

## 1. The hypothesis inventory

**What the entry carries in its own text.** The base point is $W^*$ with negative spectrum equal to the single eigenvalue $\lambda_-$; $\lvert\lambda_-\rvert=g_n$; $\Gamma$ is the circle of radius $\alpha g_n$ about $\lambda_-$; $\rho=\gamma g_n/\lVert H\rVert_{op}$; and, in the paragraph "Where $\lambda_+$ does enter", $\alpha<1$.

**What the entry imports, and each import's own hypotheses.**

| import | its hypotheses | holds at the object? |
|---|---|---|
| $g_n$ as the analyticity radius ([L145](../findings/second-order.md)) | $\ker W^*=0$ and the spectrum two-valued | holds at $W^*$; fails at $W_{\mathbb{CP}^2}$, $\dim\ker W=3$ |
| $\lambda_+=\tfrac m{m-1}g_n$ | $\mathop{\mathrm{tr}}W^*=0$ with multiplicities $m^2$, $m(m-1)$ | holds; recomputed cold in §2 |
| $C=\tfrac{1+\alpha}{\alpha-\gamma}$ ([r456](../reviews/REVIEW_r456.md)) | $\gamma<\alpha$, $\alpha+\gamma<D$, $\gamma<1$, **and $\alpha\le D/2$** | the last is neither stated by [r456](../reviews/REVIEW_r456.md) nor by this entry, the refuted half |
| $\lVert\mathrm{Alt}\rVert_{op}\le1$ ([conventions.md](../findings/conventions.md)) | none beyond the definition | holds |

**What the written argument for the surviving identity actually uses.** Exactly two things: that $\Gamma$ is a circle of radius $\alpha g_n$ centred at $\lambda_-$, and that $\lvert\lambda_-\rvert=g_n$. It uses **none** of: $\lambda_-$ real, $\lambda_-$ negative, $\alpha<1$, $\ker W^*=0$ beyond what makes $g_n>0$, $\mathop{\mathrm{spec}}$ two-valued, $m\ge2$, $n\ge12$, $\lVert H\rVert_{op}\le1$, or $\gamma$ at all.

**Hypotheses the entry uses and does not state.** $\ker W^*=0$ (without it $g_n=0$ and $\Gamma$ degenerates to a point); $\lvert\lambda_-\rvert\le\lambda_+$, which is what makes $g_n=\lvert\lambda_-\rvert$ rather than $g_n=\lambda_+$; a Neumann step bounding $\max_\Gamma\lVert(W-\zeta)^{-1}\rVert$ by $1/((\alpha-\gamma)g_n)$, which is used silently in the "Consequence"; and the smallest admissible dimension, which the entry never names.

*No finding on: the choice of norm, $\lVert\mathrm{Alt}\rVert\le1$, or the form of the Riesz integral, all three are correct as written and their hypotheses hold.*

## 2. Question 1, is the surviving identity proved here, and at what generality

**The claim.** $\max_\Gamma\lvert\zeta\rvert=(1+\alpha)g_n$.

**What the entry writes as its proof.** One display box: *"THE NUMERATOR IS $\max_\Gamma\lvert\zeta\rvert$, AND ON A CIRCLE ABOUT $\lambda_-$ IT IS $\lvert\lambda_-\rvert+\alpha g_n=(1+\alpha)g_n$."* That is the statement with the intermediate value $\lvert\lambda_-\rvert+\alpha g_n$ shown; no inequality and no maximiser is written.

**The derivation in full, since the entry compresses it.** Let $c\in\mathbb C\setminus\{0\}$, $r>0$, $\Gamma=\{\lvert\zeta-c\rvert=r\}$. For $\zeta\in\Gamma$, $\lvert\zeta\rvert\le\lvert c\rvert+\lvert\zeta-c\rvert=\lvert c\rvert+r$. The value is attained at $\zeta^\star=c\big(1+r/\lvert c\rvert\big)$, which lies on $\Gamma$ since $\lvert\zeta^\star-c\rvert=\lvert c\rvert\cdot r/\lvert c\rvert=r$, and has $\lvert\zeta^\star\rvert=\lvert c\rvert+r$. So $\max_\Gamma\lvert\zeta\rvert=\lvert c\rvert+r$ exactly. Putting $c=\lambda_-$ and $r=\alpha g_n$ and substituting $\lvert\lambda_-\rvert=g_n$ gives $(1+\alpha)g_n$, with the maximiser $\zeta^\star=(1+\alpha)\lambda_-=-(1+\alpha)g_n$ when $\lambda_-$ is real and negative.

**Generality, item by item.**

- **$\lambda_-$ real and negative is not needed.** The derivation above uses only $\lvert c\rvert$. If $\lambda_-$ were complex of modulus $g_n$ the identity would be unchanged, with the maximiser rotated to the ray through $c$.
- **$\lvert\lambda_-\rvert=g_n$ is needed, and it is the whole of the content.** Drop it and the identity reads $\max_\Gamma\lvert\zeta\rvert=\lvert\lambda_-\rvert+\alpha g_n$, which is not $(1+\alpha)g_n$.
- **$\Gamma$ encircling $0$ changes nothing.** $0$ is interior to $\Gamma$ precisely when $\alpha>1$, and the derivation never asks where $0$ sits. At $\alpha=\alpha^*=\tfrac{11}{10}$, the value [L156](../findings/second-order.md) optimises to, where $0$ **is** enclosed, the identity gives $\max_\Gamma\lvert\zeta\rvert=\tfrac{21}{10}g_n$, attained at $\zeta^\star=-\tfrac{21}{10}g_n$, and $\lvert\lambda_+-\lambda_-\rvert=\tfrac{11}5g_n>\tfrac{11}{10}g_n$ keeps $\lambda_+$ outside. **This is the pre-registered question's third part, and the answer is that the citation at $\alpha>1$ is safe.**
- **Only the $\le$ direction is ever used downstream.** [L156](../findings/second-order.md) feeds the quantity into an ML estimate as one factor of an upper bound. The equality direction (the maximiser $\zeta^\star$), is what makes the factor unimprovable, and nothing on file depends on it.

**Verified cold: $\lvert\lambda_-\rvert=g_n$ at $W^*$.** With $\mathop{\mathrm{tr}}W^*=0$ and multiplicities $m^2$ (negative) and $m(m-1)$ (positive), $\lvert\lambda_-\rvert m^2=\lambda_+m(m-1)$, so $\lambda_+=\tfrac m{m-1}\lvert\lambda_-\rvert>\lvert\lambda_-\rvert$ for every $m\ge2$. Hence $\min_a\lvert\lambda_a\rvert=\lvert\lambda_-\rvert$, i.e. $g_n=\lvert\lambda_-\rvert$. This also gives $D=1+\tfrac m{m-1}=\tfrac{2m-1}{m-1}$, matching the entry.

**Verdict on question 1: PROVEN, at the generality "circle of radius $\alpha g_n$ centred at a point of modulus $g_n$, any $\alpha>0$".** It needs neither $\lambda_-$ real nor $\lambda_-$ negative; it does need $\lvert\lambda_-\rvert=g_n$; and it is indifferent to $\Gamma$ encircling $0$.

## 3. Question 2, first half, quantifier order and scope

**Free, optimised, and shared.** $\alpha$ and $\gamma$ are free in the entry and optimised only by successors; $m$ (equivalently $n$) is free; $\zeta$ is bound by the $\max_\Gamma$; $z$ is bound by the disc. Nothing in the identity is quantified over $H$.

**A $\max$ **is** distributed across terms sharing a variable, and it is legitimate.** The entry's display reads

$$\lVert W_-\rVert\le\frac1{2\pi}\cdot2\pi\alpha g_n\cdot\max_\Gamma\lvert\zeta\rvert\cdot\max_\Gamma\lVert(W-\zeta)^{-1}\rVert,$$

so the two $\zeta$-dependent factors are maximised separately, where $\max_\Gamma\big(\lvert\zeta\rvert\lVert(W-\zeta)^{-1}\rVert\big)$ would be sharper. $\max fg\le\max f\max g$ holds for nonnegative $f,g$, so the inequality is sound; the loss is real but bounded, and it is inherited by [L156](../findings/second-order.md) unchanged. *No finding, but the constant is not claimed to be sharp and should not be.*

**One quantity carries two roles, and that is where the refuted half lives.** $\alpha$ enters as the contour length ($\alpha g_n$) and again through the distance to the spectrum. Writing that distance as $\alpha g_n$ rather than $d\,g_n=\min(\alpha,D-\alpha)g_n$ lets the length cancel one power of the resolvent, and it is the cancellation that produces $\tfrac{1+\alpha}{\alpha-\gamma}$ from $\tfrac{\alpha(1+\alpha)}{d(d-\gamma)}$. **The cancellation is an identity only on $\alpha\le D/2$.** *No finding beyond what the heading already carries; recorded because it is the scope question the round asked.*

## 4. The edges of every range

**The contour parameter $\alpha$.** The identity holds on $(0,\infty)$; every constraint on $\alpha$ comes from elsewhere in the chain. At $\alpha\to0$ the identity gives $\max_\Gamma\lvert\zeta\rvert\to g_n$, correct, while $C\to\infty$ through $\alpha-\gamma$. At $\alpha=\gamma$ the entry's $C$ diverges, correctly flagged as inadmissible. At $\alpha=D$ the contour meets $\lambda_+$ and the resolvent bound fails; at $\alpha>D$ the contour encloses $\lambda_+$ and $W\Pi_\Gamma$ is no longer $W_-$, the identity survives both, since it is a statement about a circle and not about a projection.

**The smallest admissible dimension.** The entry names none. Its objects need $m\ge2$ for $D=\tfrac{2m-1}{m-1}$ to be finite and for $\lambda_+>\lvert\lambda_-\rvert$; the programme's own range is $n\ge12$, i.e. $m\ge6$. The identity itself is dimension-free once $\lvert\lambda_-\rvert=g_n$ is granted. *Finding at the level of statement hygiene: L156 states $m\ge2$, L152 states nothing.*

**$\ker W\ne0$, and the named witness.** The record's witness is $W_{\mathbb{CP}^2}$ with $\dim\ker W=3$ ([second-order.md](../findings/second-order.md):255, [second-order.md](../findings/second-order.md):1173). **This entry asserts nothing there, and could not.** At such a $W$, $g_n=\mathop{\mathrm{dist}}(\mathop{\mathrm{spec}},0)=0$, so the contour has radius $\alpha g_n=0$, no contour separates the negative spectrum from $0$, and the identity degenerates to $0=0$ with no content. That is consistent with [L147](../findings/second-order.md)'s hypothesis box, which records that $g_n$, $\rho$ and $M$ *do not exist there*. **The finding is that L152 never states $\ker W^*=0$** although its every object needs $g_n>0$, the same omission [ROUND_L147](ROUND_L147.md) corrected one entry earlier.

## 5. Question 2, second half, and the round's centre, what is proven against what is used

**Where the clause is cited.** Exactly one place in the record cites it: [L156](../findings/second-order.md)'s proof at [second-order.md](../findings/second-order.md):1425, *"the maximum $\max_\Gamma\lvert\zeta\rvert=(1+\alpha)g_n$ (L152's surviving half)"*, repeated in [ROUND_L156.md](ROUND_L156.md):26. [results.md](../results.md)'s L156 entry states the resulting $C$ and does not restate the identity. No other findings file, and no entry of [plan.md](../plan.md) or [results.md](../results.md), cites it.

**Is it cited without a hypothesis it was proved under? No.** The two hypotheses the proof uses ($\Gamma$ centred at $\lambda_-$ of radius $\alpha g_n$, and $\lvert\lambda_-\rvert=g_n$), are both in force at the point of citation: [L156](../findings/second-order.md)'s statement fixes $\Gamma$ as the circle about $\lambda_-$ at the base point $W^*$, and $\ker W^*=0$ with the two-valued spectrum is in its hypothesis list. The citation is at $\alpha^*=\tfrac{11}{10}>1$, past the $\alpha<1$ that the citing entry's own source paragraph asserts, and §2 shows the identity does not use $\alpha<1$. **So the clause travels correctly.** *This is the answer to the round's central question, and it is "no finding", with the argument above rather than by silence.*

**Two things that do not travel with it, and should.**

1. **The clause is not L152's.** [r456](../reviews/REVIEW_r456.md) line 70 already carries *"$\max_\Gamma\lvert w\rvert\le(1+\alpha)g_n$"* inside the derivation of $C$. What L152 adds is the upgrade from $\le$ to $=$, and that upgrade is what nothing downstream uses. Calling it "L152's surviving half" attributes to a refuted entry a step its own source had.
2. **The hypothesis $\lvert\lambda_-\rvert=g_n$ is invisible at the citation.** The identity is quoted as a fact about the contour, and the contour is described by $\alpha$ alone. A successor who re-centres $\Gamma$ at the perturbed $\lambda_-(z)$ (which "the circle about $\lambda_-$" invites at an interior base point), has $\lvert\lambda_-(z)\rvert\in[(1-\gamma)g_n,(1+\gamma)g_n]$ by $\lvert\lambda_-(z)-\lambda_-\rvert\le\lVert zH\rVert\le\gamma g_n$, and the true numerator can reach $(1+\gamma+\alpha)g_n$. At $(\alpha^*,\gamma^*)=(\tfrac{11}{10},\tfrac{11}{20})$ that is $\tfrac{53}{20}g_n$ against the quoted $\tfrac{21}{10}g_n$, a factor $\tfrac{53}{42}$ understated. **Nothing on file does this**; it is named here as the failure mode the missing hypothesis leaves open.

## 6. Question 2, does the refutation reach the whole entry

The heading names two falls: the constant with no range, and the disagreement that was never one. **Both are correct, and both are narrower than what the text actually contains.**

**The constant's fall is understated: the entry contains no derivation of $C$ at all.** Its display bounds $\lVert W_-\rVert$, and with the (unstated) Neumann step $\max_\Gamma\lVert(W-\zeta)^{-1}\rVert\le1/((\alpha-\gamma)g_n)$ the three named factors multiply to

$$\lVert W_-\rVert\;\le\;\alpha g_n\cdot(1+\alpha)g_n\cdot\frac1{(\alpha-\gamma)g_n}\;=\;\frac{\alpha(1+\alpha)}{\alpha-\gamma}\,g_n,$$

a quantity of size $g_n$. The "Consequence" asserts $M\le C\rho$ with $C=\tfrac{1+\alpha}{\alpha-\gamma}$, a quantity of size $\rho$. These are different objects at different scales, and the entry writes no step between them. The step that exists is [L156](../findings/second-order.md)'s: the resolvent **difference** available from $A(0)=0$, which introduces the two further factors $\lVert zH\rVert\le\gamma g_n$ and a second resolvent $1/(dg_n)$, giving $\alpha g_n\cdot(1+\alpha)g_n\cdot\tfrac1{(d-\gamma)g_n}\cdot\gamma g_n\cdot\tfrac1{dg_n}=\tfrac{\alpha(1+\alpha)}{d(d-\gamma)}\gamma g_n$, which at $d=\alpha$ is $\tfrac{1+\alpha}{\alpha-\gamma}\gamma g_n$. **So $C$ is imported from [r456](../reviews/REVIEW_r456.md) and presented as a consequence of a display that does not yield it.**

**A third clause falls, and the heading does not name it.** [second-order.md](../findings/second-order.md):1467 reads *"the contour must separate $\lambda_-$ from both $0$ and $\lambda_+$, so $\alpha<1$ keeps $0$ outside and $\alpha<1+\tfrac m{m-1}$ keeps $\lambda_+$ outside, **the first binding**"*, repeated at :1473. [L156](../findings/second-order.md) rules the opposite sixteen lines above, at :1427: *"$\alpha<1$ is **not a constraint**: $\mathop{\mathrm{spec}}(W^*)$ is two points, so a contour enclosing $0$ adds no spectral point"*, and every value L156 records sits at $\alpha^*>1$. The sentence stands with no forward pointer, in the same file, and it is the ruling under which L156's own optimum would be inadmissible.

**A fourth clause is unsupported.** [second-order.md](../findings/second-order.md):1471, *"Three independent computations meet at one value"*. [r456](../reviews/REVIEW_r456.md) line 74 presents $C=6$ at $(\tfrac12,\tfrac14)$ as a check of its own generalisation against [r441](../reviews/REVIEW_r441.md), whose Neumann bookkeeping it states it inherited (line 70, *"Running r441's own Neumann bookkeeping"*). One computation checked at its own special case is not three.

**What survives besides the identity.** The attribution of $\tfrac m{m-1}$ to $\lVert W^*\rVert_{op}/g_n$ in the second term of [r447](../reviews/REVIEW_r447.md)'s decomposition, which I confirmed at source: [r457](../reviews/REVIEW_r457.md) lines 70–76 bound $\lVert\Pi(z)\rVert\lVert W(z)-W^*\rVert\le\tfrac\alpha{\alpha-\gamma}\rho$ and $\lVert\Pi(z)-\Pi(0)\rVert\lVert W^*\rVert\le\tfrac\rho{(\alpha-\gamma)g_n}\cdot\tfrac m{m-1}g_n$, summing to $\tfrac{\alpha+m/(m-1)}{\alpha-\gamma}\rho$. **No $\max_\Gamma\lvert\zeta\rvert$ appears anywhere in [r457](../reviews/REVIEW_r457.md).** The entry is right that there was no disagreement, and right in the reason it gives for that half.

**The arithmetic, all exact.** $\tfrac{\alpha+6/5}{1+\alpha}$ at $\alpha\to0$ is $\tfrac65$, the claimed $20\%$; at $\alpha^*=\tfrac{11}{10}$ it is $\tfrac{23/10}{21/10}=\tfrac{23}{21}=1.0952\ldots$, the claimed $9.5\%$. At $(\tfrac43,\tfrac23)$ with $m=6$: $D-\alpha=\tfrac{11}5-\tfrac43=\tfrac{13}{15}=d$, $d-\gamma=\tfrac{13}{15}-\tfrac{10}{15}=\tfrac15$, so $C=\tfrac{(4/3)(7/3)}{(13/15)(1/5)}=\tfrac{28/9}{13/75}=\tfrac{700}{39}=17.949\ldots$ against the recorded $\tfrac{7/3}{2/3}=\tfrac72$. And $\tfrac{1+1/2}{1/2-1/4}=6$. **All four confirmed.**

## 7. Question 5, the absence of a canonical form

[results.md](../results.md)'s preamble states the rule: *"a result appears here once Gate 2 has passed"*. L152's Gate 2 ([r705](../reviews/REVIEW_r705.md), [r706](../reviews/REVIEW_r706.md)) returned REFUTED AS STATED, and [findings/INDEX-results.md](../findings/INDEX-results.md):171 records exactly that, naming both the surviving identity and the supersession by [L156](../findings/second-order.md). The withdrawn [L150](../findings/second-order.md) and [L151](../findings/second-order.md) likewise have no [results.md](../results.md) row, so the treatment is consistent. [structure-check/SKILL.md](../.claude/skills/structure-check/SKILL.md) requires a row in [findings/INDEX-results.md](../findings/INDEX-results.md) for every numbered result and imposes no [results.md](../results.md) requirement.

**So the absence is correct, and the surviving clause needs no canonical entry of its own**, it is not a result of the programme, it is one line of the proof of [L156](../findings/second-order.md), which does have a canonical entry stating the $C$ it produces. *What is owed instead is one word at the point of use*: [L156](../findings/second-order.md)'s proof should read "$\max_\Gamma\lvert\zeta\rvert=\lvert\lambda_-\rvert+\alpha g_n=(1+\alpha)g_n$, since $\lvert\lambda_-\rvert=g_n$" rather than citing a refuted entry for it. That removes the only channel by which the clause travels without its refutation.

## 8. The candidate record, three steps each

**C1, "for any complex centre". REAL.**
*Locate*: [second-order.md](../findings/second-order.md):1457, *"$\max_\Gamma\lvert\zeta\rvert=(1+\alpha)g_n$, the numerator identity below, for any complex centre"*.
*Exhibit*: take the centre $c=2g_n$ and radius $\alpha g_n$. Then $\max_\Gamma\lvert\zeta\rvert=(2+\alpha)g_n\ne(1+\alpha)g_n$ for every $\alpha$. The centre-independent statement is $\max=\lvert c\rvert+r$; the $(1+\alpha)g_n$ form needs $\lvert c\rvert=g_n$.
*Argue the opposite*: "complex" is most charitably read as contrasting with "real negative", the centre is still $\lambda_-$ throughout, and the clause means only that reality of $\lambda_-$ is not used. Under that reading it is correct, and §2 confirms the reading's content.
*Kept*, because the words as written are what a citer reads, and the correct qualifier is one clause long: **for any centre of modulus $g_n$**.

**C2, "$\lvert\lambda_-\rvert=g_n$ by definition of the gap". REAL.**
*Locate*: [second-order.md](../findings/second-order.md):1459.
*Exhibit*: $g_n$ is defined as $\mathop{\mathrm{dist}}(\mathop{\mathrm{spec}},0)=\min_a\lvert\lambda_a\rvert$. For a traceless symmetric operator with spectrum $\{-2,1\}$ one has $g=1$ and $\lvert\lambda_-\rvert=2$, so the identification is not definitional. At $W^*$ it holds because $\mathop{\mathrm{mult}}(\lambda_-)=m^2>m(m-1)=\mathop{\mathrm{mult}}(\lambda_+)$ forces $\lambda_+=\tfrac m{m-1}\lvert\lambda_-\rvert>\lvert\lambda_-\rvert$.
*Argue the opposite*: at $W^*$ the two coincide, so the sentence is true where it is used and the word "definition" is loose rather than wrong.
*Kept as HYPOTHESIS-DEBT*, because it is the hypothesis that fails first at any other base point, and calling it a definition is what makes it invisible.

**C3, the "Consequence" $C$ has no step in the entry. REAL.**
*Locate*: [second-order.md](../findings/second-order.md):1461 (the display) against :1469 (*"Consequence. $C(\alpha,\gamma)=\tfrac{1+\alpha}{\alpha-\gamma}$"*).
*Exhibit*: §6 above, the display yields $\tfrac{\alpha(1+\alpha)}{\alpha-\gamma}g_n$ as a bound on $\lVert W_-\rVert$; the Consequence asserts a bound of size $\rho$ on $M=\sup_{\lvert z\rvert=\rho}\lVert A\rVert$. At $(\tfrac12,\tfrac14)$ the display gives $3g_n$ and the Consequence gives $6\rho=\tfrac32g_n/\lVert H\rVert_{op}$; the two agree at no $\lVert H\rVert_{op}$ by accident of algebra, and no written step connects them.
*Argue the opposite*: the entry's stated purpose is to settle which numerator enters $C$, importing $C$ itself from [r456](../reviews/REVIEW_r456.md); under that reading it asserts no derivation and merely quotes.
*Kept*, because the word is "Consequence", and because the imported form is quoted without the range that makes it true.

**C4, "$\alpha<1$ … the first binding". REAL.**
*Locate*: [second-order.md](../findings/second-order.md):1467, repeated :1473.
*Exhibit*: at $\alpha=\alpha^*=\tfrac{11}{10}$ the disc bounded by $\Gamma$ contains $0$, and $0\notin\mathop{\mathrm{spec}}(W^*)$, so the enclosed spectral set is still $\{\lambda_-\}$ and $\Pi_\Gamma$ is still the negative projection; $\lvert\lambda_+-\lambda_-\rvert=\tfrac{11}5g_n$ keeps $\lambda_+$ outside. The whole of [L156](../findings/second-order.md) sits at that point.
*Argue the opposite*: the entry marks the range question open and attributes the three readings to their sources, so the sentence could be read as reporting rather than ruling. It cannot: it says "the first binding", flatly, four lines after its own box reports the record supporting both.
*Kept*, and it is the one clause of L152 that a reader could act on wrongly today.

**C5, "the numerator is set by the eigenvalue the contour encloses". WITHDRAWN.**
*Locate*: [second-order.md](../findings/second-order.md):1463.
*Exhibit*: a circle of radius $3g_n$ about $\lambda_+$ encloses both eigenvalues and has $\max_\Gamma\lvert\zeta\rvert=\lambda_++3g_n=\tfrac{21}5g_n$, so the enclosed set does not determine the numerator; the **centre** does.
*Argue the opposite*: within the entry $\Gamma$ is always the circle about $\lambda_-$, where centre and enclosed eigenvalue coincide, and the sentence is a description of that contour rather than a principle.
*Withdrawn*, the charitable reading being the accurate one.

**C6, the numerals. NO FINDING.** All four checked exactly in §6.

## 9. What would falsify the surviving identity, and what I did to look

**The object that would break it: a base point whose negative eigenvalue has modulus strictly greater than the gap**, i.e. $\lvert\lambda_-\rvert>\min_a\lvert\lambda_a\rvert$. At such a $W$ the circle of radius $\alpha g_n$ about $\lambda_-$ has $\max_\Gamma\lvert\zeta\rvert=\lvert\lambda_-\rvert+\alpha g_n>(1+\alpha)g_n$, and every downstream constant built on the identity is understated, the unsafe direction.

**How I looked.** Three ways, all by hand.

1. **Inside the family.** For a traceless symmetric $W$ with two eigenvalues, $\lvert\lambda_-\rvert\mathop{\mathrm{mult}}(\lambda_-)=\lambda_+\mathop{\mathrm{mult}}(\lambda_+)$, so $\lvert\lambda_-\rvert>\lambda_+$ requires $\mathop{\mathrm{mult}}(\lambda_-)<\mathop{\mathrm{mult}}(\lambda_+)$. At $W^*=S^m\times S^m$ the multiplicities are $m^2$ and $m(m-1)$, and $m^2>m(m-1)$ for every $m\ge1$. **No falsifier exists at the base point the chain uses**, at any $m$.
2. **At a moving base point.** $\lvert\lambda_-(z)\rvert\ne g_n$ in general on the disc, and re-centring $\Gamma$ there breaks the identity by up to the factor $\tfrac{1+\gamma+\alpha}{1+\alpha}=\tfrac{53}{42}$ at the optimum (§5). I checked every citation of the clause, one, in [L156](../findings/second-order.md)'s proof, and it holds $\Gamma$ fixed about $\lambda_-(W^*)$, so no live use is exposed. **This is the falsifier that would exist if a successor re-centred, and the reason C2 matters.**
3. **At a kernel.** $W_{\mathbb{CP}^2}$, $\dim\ker W=3$: $g_n=0$, the contour degenerates, and the identity has no content rather than a false one. Not a falsifier; recorded as the boundary of the statement.

**No script was run at any point, and no value above came from one.**

## Verdict

**PROVEN, hypotheses corrected**, on the surviving identity: $\max_\Gamma\lvert\zeta\rvert=(1+\alpha)g_n$ holds for the circle of radius $\alpha g_n$ centred at any point of modulus $g_n$, for every $\alpha>0$, needing neither $\lambda_-$ real, nor $\lambda_-$ negative, nor $\alpha<1$, nor $0$ outside $\Gamma$, and needing $\lvert\lambda_-\rvert=g_n$, which the entry calls a definition and which is a theorem at $W^*$. Its single citation, in [L156](../findings/second-order.md)'s proof, is within those hypotheses, so nothing downstream is at risk.

**The entry remains BROKEN, in three places rather than the two its heading names**: the constant with no range (recorded), the straw-man refutation (recorded), and the assertion at [second-order.md](../findings/second-order.md):1467 that $\alpha<1$ binds, which [L156](../findings/second-order.md) overturned sixteen lines above and which still stands. A fourth clause, *"three independent computations meet at one value"*, is unsupported at source. **The repair that removes the clause's ability to travel is one sentence**: have [L156](../findings/second-order.md)'s proof carry $\max_\Gamma\lvert\zeta\rvert=\lvert\lambda_-\rvert+\alpha g_n=(1+\alpha)g_n$ with its own one-line reason, and stop citing a refuted entry for a triangle inequality.
