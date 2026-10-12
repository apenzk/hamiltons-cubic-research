# Verifier v349, whether Lemma L113's statement extends post F42 as post F42 now stands

**Cold brief ([ADJ_L113_E3.md](ADJ_L113_E3.md)), no numerical work, no scripts written, every value exact. Log: [agent_logs/verify-L113-v349.log](../agent_logs/verify-L113-v349.log).** The quoted lines were checked verbatim against [findings/bounds.md](../findings/bounds.md) lines 508, 526 and 262 and [findings/fence-posts.md](../findings/fence-posts.md) lines 417, 419 and 423, printing those lines only.

| # | Claim | Verdict |
|---|---|---|
| 1 | Under H1 to H3, every conclusion drawn from $g\ge0$, the support of the $g$-measure and the pinned moments $m_0,m_1$, with $G_2$ eliminated, is implied by the pinned system | CONFIRMED |
| 2 | Under post F42's literal definition (pinned data are the values the spectrum and $\theta$ determine), "a pinned conclusion" restricts nothing, because every conclusion about the conjecture is a relation in $(\lambda,\theta)$ | CONFIRMED AS ALGEBRA |
| 3 | "Positivity of $g$ and the support of its measure are consequences of the spectrum alone" | REFUTED AS STATED |
| 4 | By the census of line 419, $m_0$ and $m_1$ are pinned and $m_j$ for $j\ge2$ carries unpinned terms | CONFIRMED |
| 5 | Post F42, as it now stands, asserts that no route through the pinned data can close the conjecture | REFUTED |
| 6 | The step: the moral of L113 "is a theorem-shaped extension of post F42", with F42 as it now stands | REFUTED AS STATED |
| 7 | "That is now the single open door" follows from L113 together with F42 as it now stands | REFUTED |

**Summary: the reduction L113 proves is sound, but what it extends is the conclusion of F42 that line 423 withdraws, and the only surviving content of F42 is a definition and a census that L113 applies rather than extends, so the step FAILS.**

## 0. Conventions, fixed once

- $N=\dim\Lambda^2\mathbb R^n=n(n-1)/2$, spectrum $\lambda_1,\dots,\lambda_N$ of $W$ on $\Lambda^2$, $\lambda_{\min}$ and $\lambda_{\max}$ its extremes.
- $T_{abc}=c_{abc}^2\ge0$, totally symmetric. $g_k=\sum_{\alpha\beta}(\lambda_\alpha-\lambda_\beta)^2T_{k\alpha\beta}$ and $m_j=\sum_k\lambda_k^jg_k$, so $m_2=G_2$.
- The $g$-measure is $\mu=\sum_kg_k\,\delta_{\lambda_k}$ on $\mathbb R$.
- The pinned system is the full $3N$-row system: $T\ge0$ together with (A), (B), (C) at every row $k$, with the spectrum and $\theta$ held fixed. The pinned class is the set of its consequences.
- "Post F42 as it now stands" means lines 417 and 419 read under the withdrawal of line 423.

## 1. Hypothesis inventory

- **H1.** "The pinned class" in L113 means the consequences of the pinned system of Section 0, sign constraint $T\ge0$ included. Without it claim 1 is vacuous (Section 3).
- **H2.** "Moment inequalities built from" positivity and support means inequalities valid for every nonnegative measure supported on the spectrum, whose coefficients are functions of the spectrum, fed with the pinned values $m_0=4(n-1)\lVert W\rVert^2$ and $m_1=-4P(W)$. Spectrum-only caps such as L109 (Passage E) may be added.
- **H3.** $n\ge2$, so $m_0>0$ on the unit sphere, and the cubic identity used in Passage B holds as quoted.
- **H4.** (the only reading under which the step could stand) "Extends" means that L113 enlarges the set of arguments known to lie inside the pinned class, from "every relaxation the record has tried" (line 419) to every $g$-moment analysis, and the extension carries none of the moral's closing sentences. Section 5 shows the text contradicts H4.

## 2. What post F42 now asserts

Line 417, the title, makes two claims: no route through the pinned data can close the conjecture, and the census says which moment a successor must reach. Line 419 defines the pinned data through the census (a contraction $\sum\lambda_a^p\lambda_b^q\lambda_c^rT_{abc}$ is pinned exactly when at least two of $p,q,r$ are $\le1$) and says the structural conversion "applies to every relaxation the record has tried". Line 423 withdraws "this post's conclusion" in both directions, and states that the full $3N$-row system's max-$\theta$ at fixed spectrum is exact at all seven catalogued spectra tested, "so the pinned class is far stronger than this post claimed, and 'sharpening inside it cannot work' is unsupported".

Two readings of "both directions" exist. It may name the two clauses of the title, or the two polarities (the record asserts neither that the pinned class fails nor that it succeeds). Under either reading the first clause of the title is withdrawn. What survives is a definition (pinned data) and a census of which contractions are pinned, which line 419 attributes to [bounds.md](../findings/bounds.md) and which line 423 does not dispute. The remark "it applies to every relaxation the record has tried" survives only as grammar: its subject "it" is the structural conversion, which is the withdrawn conclusion.

## 3. What L113's statement asserts, and that it holds

**The reduction (claim 1).** Under H2, every inequality L113 contemplates is a consequence of the hypotheses $\{g_k\ge0,\ \operatorname{supp}\mu\subseteq\{\lambda_k\},\ m_0,\ m_1\}$. Each of these is implied by the pinned system: $g_k\ge0$ because $T\ge0$ and $(\lambda_\alpha-\lambda_\beta)^2\ge0$, the support by construction, and $m_0$, $m_1$ from (A) and (B) with the cubic identity (Passage B). A conclusion drawn from hypotheses that the pinned system implies is implied by the pinned system. Eliminating $G_2$ between two such inequalities is a further deduction from the same hypotheses, so the eliminated conclusion also lies in the pinned class. This holds however $G_2$ enters, which is the phrase "however the free moment enters".

**The sharpest such conclusion, in closed form.** Two inequalities valid for every nonnegative $\mu$ on the spectrum are

$$m_1^2\le m_0m_2\qquad\text{(Cauchy–Schwarz)},\qquad m_2\le(\lambda_{\min}+\lambda_{\max})m_1-\lambda_{\min}\lambda_{\max}m_0,$$

the second being $\sum_kg_k(\lambda_k-\lambda_{\min})(\lambda_{\max}-\lambda_k)\ge0$ expanded. With $m_0>0$ (H3), eliminating $m_2$ gives $m_1^2-(\lambda_{\min}+\lambda_{\max})m_0m_1+\lambda_{\min}\lambda_{\max}m_0^2\le0$, that is

$$(m_1-\lambda_{\min}m_0)(m_1-\lambda_{\max}m_0)\le0\iff\lambda_{\min}m_0\le m_1\le\lambda_{\max}m_0 .$$

This is exactly the feasibility criterion that feasible_iff in [L113Statement.lean](../lean/HamiltonsCubic/Results/L113Statement.lean) proves necessary and sufficient, so no pair of inequalities valid on all such measures can do better. On the unit sphere with $m_0=4(n-1)$, $m_1=-4\theta$ and $\lambda_{\min}\le0$ it reads $\theta\le(n-1)\lvert\lambda_{\min}\rvert$, which is L107 (Passage C), matching feasible_iff_theta. Adding the L109 caps changes the feasible set but every cap is again implied by $T\ge0$ and (A), so claim 1 is untouched.

**Why H1 is needed (claim 2).** Line 419 defines the pinned data as "everything a critical point's spectrum and $\theta$ already determine", that is, as values. A sign constraint such as $g_k\ge0$ is not a value, and $g_k$ itself is not pinned: it contains the row contraction $\sum_{\alpha\beta}\lambda_\alpha^2T_{k\alpha\beta}$, which no row relation (A), (B), (C) fixes. If "pinned conclusion" meant only "a relation among $(\lambda,\theta)$", then every conclusion with $G_2$ eliminated would qualify trivially, the conjecture included. So L113 has content only under H1, where the class is the consequence set of the pinned system with $T\ge0$.

**The wording of the premise (claim 3).** Positivity of $g$ is a consequence of $T=c^2\ge0$, which is a fact about real structure constants at every $W$ and is not determined by the spectrum. The spectrum supplies the weights and the support. The sentence is imprecise, and the argument above goes through with the correct attribution.

**The census check (claim 4).** $m_j=\sum_{k\alpha\beta}\lambda_k^j(\lambda_\alpha^2-2\lambda_\alpha\lambda_\beta+\lambda_\beta^2)T_{k\alpha\beta}$ splits into contractions with exponent triples $(j,2,0)$, $(j,1,1)$ and $(j,0,2)$. The triple $(j,1,1)$ is pinned for every $j$. The triples $(j,2,0)$ and $(j,0,2)$ are pinned exactly when $j\le1$. So $m_0$ and $m_1$ are pinned and $m_j$ for $j\ge2$ carries unpinned terms, in agreement with Passage B's "all free content sits at $G_2$ and above". This is a corollary of the census, derived by reading off exponents.

## 4. Where the step fails

**The line.** [findings/bounds.md](../findings/bounds.md) line 526: "**The moral, and it is a theorem-shaped extension of [post F42](fence-posts.md).**"

**What is extended.** An extension of a result states something that contains or generalises what that result asserts. Post F42 asserted a negative: routes through the pinned data cannot close. The moral of L113 asserts a larger family of routes (all $g$-moment analyses) lies inside the pinned class and draws the same negative for it: "The free data $G_2$ helps only if realizability constrains it through something positivity and support do not see ... *That is now the single open door*". The composite L113 plus F42 gives "moment analysis cannot close", and that composite is what makes the moral a moral and the last sentence a verdict on the whole route.

**The failure, exhibited.** Line 423 withdraws that negative and records that the full pinned system's max-$\theta$ is exact at all seven catalogued spectra tested. Under F42 as it now stands, then:

1. Lying inside the pinned class is no longer known to be an obstruction. Section 3 shows that $g$-moment analysis is a strict weakening of the pinned system, since it aggregates each row into one number $g_k$ and never uses (C). The class it cannot leave is the class line 423 describes as "far stronger than this post claimed".
2. "The single open door" is therefore unsupported (claim 7). The per-row relations (A), (B), (C) with $T\ge0$ constrain $G_2=\sum_k\lambda_k^2g_k$ through information positivity and support of $\mu$ do not see, and they are a second source on the table. The conclusions they give are pinned, so they matter only if the pinned class suffices, which is precisely the question line 423 reopened.
3. The only surviving content of F42 is a definition and a census (Section 2). L113 uses the definition and its moment split is a corollary of the census (claim 4). Using a definition and reading off a corollary do not extend a result. So nothing F42 still asserts is extended by L113 (claim 6).

## 5. Arguing the opposite

**The strongest reading is H4:** "extends" refers only to the membership part, enlarging "every relaxation the record has tried" (line 419) to every $g$-moment analysis. Under H1 to H4 the enlarged membership statement is true by Section 3, and it is theorem-shaped (feasible_iff proves the two-moment instance exactly).

**Why H4 does not rescue the step as written.**

- The text attaches the words "theorem-shaped extension" to "The moral", the whole paragraph of line 526, whose last two sentences declare the route closed except through Jacobi and Bianchi. H4 must cut those sentences out of the thing the author calls the extension.
- Line 419's membership remark has no standing of its own in F42 as it now stands: its subject is the structural conversion that line 423 withdraws. Under H4 the step would extend a clause of a withdrawn conclusion.
- Even granting that the membership remark survives, L113 relates to it as a stronger instance of an observation, not as an extension of a theorem, and the step asserts the latter.

**Lean.** Nothing in [L113.lean](../lean/HamiltonsCubic/Results/L113.lean) or [L113Statement.lean](../lean/HamiltonsCubic/Results/L113Statement.lean) mentions $T$, the relations (A), (B), (C), the pinned class or F42. The declarations prove linearity of a moment functional, a two-constraint convexity fact, a propositional weakening, the two-moment feasibility criterion and its $\theta$ form. They confirm the instance in Section 3 and are silent on the extension relation.

## 6. Verdict

**FAILS.** The step reads L113 as extending post F42, but the part of F42 it extends (that staying in the pinned class cannot close the conjecture) is withdrawn at [fence-posts.md](../findings/fence-posts.md) line 423, and the part that survives (the pinned-data definition and the census) is applied by L113, not extended.

- **What stands.** L113's reduction, that $G_2$-eliminated conclusions from positivity, support and the pinned moments lie in the pinned class, is CONFIRMED under H1 (the class includes $T\ge0$), H2 (inequalities valid on all nonnegative measures on the spectrum, spectrum-only coefficients) and H3 ($n\ge2$, cubic identity). Its sharpest two-moment form is L107, in closed form.
- **What a VALID reading would need.** H1 to H3 plus H4 (extension of membership only, closing sentences excluded). The text of line 526 contradicts H4, and under line 423 the membership remark is not a standing assertion of F42.
- **Consequence for the lemma's prose.** The sentence at line 526 should call L113 an application of F42's pinned-data definition, drop "single open door" or condition it on the pinned class being insufficient, and correct "consequences of the spectrum alone" to "consequences of $T=c^2\ge0$ and the spectrum".
