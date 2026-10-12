# ROUND L68, the diagonal symmetry defect, the entry cap, and a traced identity audited by one reader

**Id:** L68. **Source:** [findings/diagonal-half.md](../findings/diagonal-half.md):86–112, with the canonical line at [results.md](../results.md):777. **Date:** 2026-09-07. **Verifiers allocated:** v113, v114, v115. **Phase:** 6, closed. **Verdict:** `PROVEN, hypotheses corrected`, repaired, impact `CONTAINED`.

**Why this id.** Tier 1, cited eight or more times, and recorded in four places as **single-audited**, *which this round found to be false*: [r519](REVIEW_r519.md) and [r520](REVIEW_r520.md) had both confirmed it on identical briefs, and the stale status was itself the round's first finding.

**Pre-registered questions.** *(Questions, not verdicts. No adjudication has run on any.)*

1. **Which hypotheses does the traced identity (iv) use?** *It sums a per-edge equality over positive edges and lands on $\lVert M\rVert_1=\sum_{a<b}\lvert M_{ab}\rvert$, which counts negative edges too.* **Do the sum over positive edges and the norm over all edges reconcile, and if so by what property of $M$, and is that property stated anywhere in the block?**
2. **Is "equality exactly at twin pairs" right in both directions?** **Check that $g_{ab}=0$ forces the twin condition and that the twin condition forces $g_{ab}=0$, and say what "twin" must mean for each direction to hold.**
3. **What does the cap actually need?** *The block says criticality and hollowness.* **Check each step against the object, and say whether any further property (of the row sums, the sign pattern, or the eigenvalue), is used without being named.**

**A source is read, never cited from memory.** *If a source is not in [references/](../references/), say the claim rests on an unread source.* Petersen–Wink is on file.

## The brief as dispatched

*Provenance stripped, mathematics verbatim, quoted from the current source.*

Write $M_a$ for row $a$ of $M$ and $s_a=\lVert M_a\rVert^2$, and let $g_\gamma:=\lVert[\mathrm{ad}(v_\gamma),W]\rVert^2$ be the [Petersen–Wink](../references/petersen-wink-2019-bochner-technique/notes.md) Prop 1.7 density whose trace over the strictly positive eigenspace is the symmetry defect $\Delta$ of [bounds.md](bounds.md). On the diagonal locus every eigenvector is a coordinate bivector $\varphi_{ab}=E_{ab}-E_{ba}$, the structure tensor is the single monomial $[\varphi_{ab},\varphi_{bd}]=\varphi_{ad}$ for distinct $a,b,d$, and everything becomes explicit.

**(i) The density, with no hypothesis at all.** $[\mathrm{ad}(\varphi_{ab}),W]$ moves only the $2(n-2)$ directions $\varphi_{ad},\varphi_{bd}$, sending $\varphi_{bd}\mapsto(M_{bd}-M_{ad})\varphi_{ad}$ **and $\varphi_{ad}\mapsto(M_{bd}-M_{ad})\varphi_{bd}$**, **two moved families, which is where the factor $2$ comes from**, each $2\times2$ block carrying two nonzero entries; the pairing throughout is [conventions.md](conventions.md)'s half-trace, in which $\lVert\varphi_{ab}\rVert^2=1$ and $\{\varphi_{ab}\}_{a<b}$ is orthonormal

$$g_{ab}=2\sum_{d\ne a,b}(M_{ad}-M_{bd})^2=2\lVert M_a-M_b\rVert^2-4M_{ab}^2=2(s_a+s_b)-4(M^2)_{ab}-4M_{ab}^2,$$

the middle step because $M$ is hollow, which makes both dropped coordinates equal to $M_{ab}^2$. **This is the diagonal specialisation of the recorded decomposition** $g_\gamma=2\sum_\alpha\lambda_\alpha^2R_{\gamma\alpha}-2Q_\gamma$ of [bounds.md](bounds.md), not a new identity: on this locus $R_{\gamma\alpha}$ is the indicator that two pairs share exactly one index, so $\sum_\alpha\lambda_\alpha^2R_{(ab)\alpha}=s_a+s_b-2M_{ab}^2$, and $Q_{(ab)}=2(M^2)_{ab}$. What the specialisation buys is that both terms become elementary functions of one weighted graph.

**(ii) $\Delta=0$ is a blow-up condition.** Since $\Delta=\sum_{M_{ab}>0}g_{ab}$, it vanishes exactly when every **positive** edge joins **twins**, $M_{ad}=M_{bd}$ for every $d$ outside the pair. Linkage is then transitive, because $a\!-\!b$ and $b\!-\!c$ positive force $M_{ac}=M_{bc}>0$. So the components of $G^+=\{ab:M_{ab}>0\}$ are cliques of mutually twin vertices, $M$ is constant inside each and across each pair of them, and every entry between distinct components is $\le0$; conversely any such $M$ has $\Delta=0$. **Block-constancy alone is not the condition**, the $C_5$ blow-up is block-constant and carries $\Delta=12$, its non-adjacent block pairs being positive. *Corollary (Reviewer 292):* a singleton block forces an identically zero row, since all its entries are cross entries, hence $\le0$, and they sum to $0$. So $\Delta=0$ with $\ker W=0$ forces every block to have size $\ge2$, on this locus $\Delta=0$ is already the generalised sphere-product shape, which is the converse to the "$\ker W=0$ is load-bearing" note in [b_symmetry_defect.py](../scripts/lib/b_symmetry_defect.py).

**(iii) At a critical point the density is affine in the entry, and caps it.** The criticality equation above reads off-diagonally $M_{ab}^2+(M^2)_{ab}=\theta M_{ab}$, and substituting into (i) cancels both quadratic terms:

$$g_{ab}=2(s_a+s_b)-4\theta M_{ab}\qquad(a\ne b).$$

Since $g_{ab}\ge0$, **every entry of a diagonal critical point is capped by its own two row norms**, $2\theta M_{ab}\le s_a+s_b$, with equality exactly at twin pairs; so for $\theta>0$

$$\theta\ \le\ \min_{M_{ab}>0}\frac{s_a+s_b}{2M_{ab}},\qquad\text{and exactly}\qquad \theta=\frac{s_a+s_b}{2M_{ab}}-\frac{g_{ab}}{4M_{ab}}\ \text{ at every positive edge.}$$

The cap needs criticality **and hollowness**, hollowness is what makes the two dropped coordinates equal $M_{ab}^2$ in the very inequality that follows: $\lVert M_a-M_b\rVert^2\ge2M_{ab}^2$ by dropping all but two coordinates of the row difference, *which is $g_{ab}\ge0$ written out, not an independent argument*, and criticality converts the left side. **Criticality is load-bearing**: maximising the violation over the diagonal locus without it reaches $+0.075$, $+0.227$, $+0.334$, $+0.370$, $+0.368$ at $n=5,6,8,10,12$.

**(iv) Traced over $\mathfrak p$**, with $d_a^+=\#\{b:M_{ab}>0\}$ and $\lVert M\rVert_1=\sum_{a<b}\lvert M_{ab}\rvert$:

$$\theta\,\lVert M\rVert_1=\sum_a d_a^+s_a-\tfrac12\Delta .$$

**This is route R10's conversion of defect into $\theta$ deficit, exact and with no estimate anywhere, on the diagonal locus only.** Both (iii) and (iv) are **equalities** at $S^{\lfloor n/2\rfloor}\times S^{\lceil n/2\rceil}$, returning $\theta_0(n)$ at $n=6,\dots,20$, and at the $C_5$ blow-up, returning $0.670820$.

### The canonical line, quoted alongside without comment

**Lemma L68**, the symmetry defect on the diagonal locus in closed form, $g_{ab}=2(s_a+s_b)-4\theta M_{ab}$ at a critical point, the entry cap $2\theta M_{ab}\le s_a+s_b$, and the traced identity $\theta\lVert M\rVert_1=\sum_ad_a^+s_a-\tfrac12\Delta$.

## Phase 2, the clustering

**Reports:** [VERIFY_v113](VERIFY_v113.md), [VERIFY_v114](VERIFY_v114.md), [VERIFY_v115](VERIFY_v115.md) (**all three `PROVEN), hypotheses corrected`, unanimous.**

| # | clause attacked | mechanism | support |
|---|---|---|---|
| **C1** | **(iv)'s hypothesis list** | the identity needs $M\mathbf1=0$ and says so nowhere. **It is false by a factor of two without it**: $M=c(J-I)$ is symmetric, hollow, unit-norm and satisfies the boxed criticality equation, part (iii) holds at it exactly, and (iv) reads $3$ against $6$ at $n=4$ | v113, v114, v115 |
| **C2** | **(iii)'s hypothesis list** | "the cap needs criticality and hollowness" omits symmetry, $M\mathbf1=0$ upstream (which kills the Ricci multiplier and is what makes the off-diagonal equation the one written) and $\operatorname{tr}M^2=2$, without which $\theta$ is a scale-dependent multiplier | v113, v114, v115 |
| **C3** | "equality exactly at twin pairs" | true both ways **only** in the off-pair sense; under the equal-rows reading the forward direction is false, and hollowness makes the clause empty at every positive edge, which is where the cap is used. (ii) defines the right sense eight lines and a display earlier | v113, v114, v115 |
| **C4** | $\Delta$'s pairing | summed over **unordered** positive pairs, against [conventions.md](../findings/conventions.md)'s ordered default, under which $\Delta$ doubles and (iv) carries $\tfrac14\Delta$. Two earlier reviewers asked for this label and it was never applied | v113, v114 |
| **C5** | the round's own premise | **"single-audited" is false**, [r519](../reviews/REVIEW_r519.md) and [r520](../reviews/REVIEW_r520.md) both confirmed on identical briefs. Four status lines were stale, including this round's brief | v113, v114 |
| **C6** | [results.md](../results.md):777 read alone | "at a critical point" scopes only the first of three clauses, so the cap and the traced identity were citable unqualified | v113, v114 |
| **C7** | [L130](../findings/diagonal-half.md):527 | restates the cap as **"unconditional"**, 421 lines below its source, and divides by $2\theta$ where L68 said it cleared | v115 |
| **C8** | "generalised sphere-product shape" | used once on the whole record, defined nowhere; under a two-factor reading it is false, and the derived shape admits $k\ge3$ blocks | v113, v115 |
| **C9** | the $R/Q$ decomposition pointer | mis-pointed to [bounds.md](../findings/bounds.md); the form lives in [bounds-relaxations.md](../findings/bounds-relaxations.md) | v114 |
| **C10** | "every eigenvector is a coordinate bivector" | false at repeated eigenvalues, harmless since $\Delta$ is a basis-independent trace | v114, v115 |

## Phase 3, adjudication

**Every mathematical statement in (i)–(iv) is correct, and each was re-derived cold three times.** The three verifiers cross-checked (i) against both pinned moments, $\sum_\gamma g_\gamma=4(n-1)$ and $\sum_\gamma\lambda_\gamma g_\gamma=-4\theta$, and verified all four parts exactly at the balanced product and at the $C_5$ blow-up. **No verifier contradicted another anywhere.**

**The defect is entirely in the hypothesis lists, and C1 is the one that bites.** *A lemma false at an object satisfying every hypothesis it states is the failure this loop was built to find*, and it is invisible to anyone checking the algebra, which is correct. All three verifiers found the same witness independently, one at $n=3$, two in general.

**C5 is a finding against this round's own brief**, and it is recorded as such: the round was convened on a premise the record's own ledger refutes four hundred lines from where the status was printed.

**C3's two senses of "twin" are what let C1 hide.** The block proves the right thing in (ii) and cites it loosely in (iii), and the loose reading is the one a consumer carries to (iv).

**No adjudication split, and no finding required computation.**

## Phase 4, the fix

**Verdict: `PROVEN, hypotheses corrected`. Impact: `CONTAINED`**, every clause is true under its corrected hypotheses, and **(iv), the part whose list was wrong, has no consumer on the record**, so nothing downstream inherited the gap.

- **(iv) now names $M\mathbf1=0$ and criticality at the step**, with the factor-of-two failure at $M=c(J-I)$ written in beside it, and $\Delta$ labelled as the unordered positive-pair sum with the ordered alternative's $\tfrac14$ given.
- **(iii)'s list is completed**, criticality, symmetry, hollowness, $M\mathbf1=0$, with $\operatorname{tr}M^2=2$ named as what fixes the coefficient, and the $\theta>0$ guard identified as needed only to divide.
- **"Twin" is disambiguated at the point of use**, with the reason the equal-rows reading fails.
- **[results.md](../results.md):777 carries the full hypothesis list**, the corrected equality clause, and the witness; "single-audited" is gone from it, from [LEDGER.md](../findings/LEDGER.md) and from [plan.md](../plan.md), **whose pointer also named the wrong findings file**.
- **[L130](../findings/diagonal-half.md)'s "unconditional" restatement now carries L68's hypotheses**, and the $R/Q$ pointer is corrected.

*The missing hypothesis was on the record three times before this round, [r519](../reviews/REVIEW_r519.md)'s F3 repair, [r520](../reviews/REVIEW_r520.md)'s derivation, and [lean/INDEX.md](../lean/INDEX.md):110, and none of the three was beside the statement. **The Lean form has carried every hypothesis correctly throughout.***
