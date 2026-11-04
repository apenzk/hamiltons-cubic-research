# ROUND L07, a bound at every critical point, and an equality class its own heading misreads

**Id:** L07. **Source:** [findings/bounds.md](../findings/bounds.md):43–59, with the canonical form at [results.md](../results.md):326 and the landscape line at :122. **Date:** 2026-09-07. **Verifiers allocated:** v116, v117, v118. **Phase:** 6, closed. **Verdict:** `BROKEN`, repaired, impact `PROPAGATES`.

**Why this id.** Tier 1, cited eight or more times. It is the record's only bound holding at *every* critical point rather than on a family.

**Phase 0's own finding.** The block's heading, the canonical heading and the landscape line all name a **"symmetric-pair equality class"**; the block carries a box saying that reading is false in both directions, and locates the refutation 79 lines further down its own file. **The verifiers are told none of this** and are asked what the equality clause actually characterises.

**Pre-registered questions.** *(Questions, not verdicts. No adjudication has run on any.)*

1. **Does the compression give the inequality?** *The proof traces $Q(W)=\theta W$ against $\Pi_-$ to an exact identity and then bounds one side.* **Check the identity and the step that turns it into an inequality, and say where the $6\delta^2$ comes from and whether its coefficient is right.**
2. **What does the equality clause characterise?** *It is stated as the eigenspace ranges being graded by the Lie bracket.* **Say what that condition is, whether it is equivalent to the "symmetric pair with $E_+$ the isotropy algebra" the headings name, and if not, in which direction each implication fails and at what object.**
3. **Which hypotheses does the proof use, and how often?** *The block says criticality, Ricci-flatness and first Bianchi, "the last two used twice each in the final step".* **Check each use against the object, and say whether any further property is used without being named.**

**A source is read, never cited from memory.** *If a source is not in [references/](../references/), say the claim rests on an unread source.*

## The brief as dispatched

*Provenance stripped, mathematics verbatim, quoted from the current source.*

Compressing the criticality equation onto the negative spectral part gives, at every critical point,

$$\theta\mathop{\mathrm{tr}}(W_-)+\mathop{\mathrm{tr}}(W_-^2)\;\le\;\|\mathrm{Ric}(W_-)\|^2+6\,\delta^2,$$

with $\delta^2$ the defect of [Observation L15](problem.md), and $W_\pm$ the positive and negative spectral parts **as operators on all of $\Lambda^2$**, so that $\mathrm{Ric}(W_-)$ has its usual meaning.

### The canonical form, quoted alongside without comment

**Lemma L7 (landscape). A bound at every critical point, and its equality class.** A compression of the criticality equation bounds the value against the defect and one Ricci term, with equality exactly where the eigenspace ranges form a symmetric pair.

## Phase 2, the clustering

**Reports:** [VERIFY_v116](VERIFY_v116.md) `BROKEN`, [VERIFY_v117](VERIFY_v117.md) `GAP`, [VERIFY_v118](VERIFY_v118.md) `PROVEN, hypotheses corrected` on the block and `BROKEN` on the canonical form.

| # | clause attacked | mechanism | support |
|---|---|---|---|
| **C1** | the inequality | *no defect, and no possible falsifier*, each of its three slack terms is the compression of a PSD operator. Rebuilt cold three times and checked as an exact equality at $W_{\mathbb{CP}^2}$, $S^3\times S^3$ and $S^2\times S^4$ | v116, v117, v118 |
| **C2** | [bounds.md](../findings/bounds.md):51's rank-one identity | $vv^{\mathsf T}\#ww^{\mathsf T}=[v,w][v,w]^{\mathsf T}$ is off by a factor $2$. **Under it $W_{\mathbb{CP}^2}$ is not a critical point**, $\mathop{\mathrm{tr}}(W^\#)$ reads $-2$ against the record's $-1$, and L15's identity fails at $k=1$. The record carries the $\tfrac12$ at four other sites, and at line 187 of this same file | v116, v117, v118 |
| **C3** | the equality clause's identification | the class is *$\mathop{\mathrm{ran}}W_+\oplus\mathop{\mathrm{ran}}W_-$ a $\mathbb Z_2$-graded subalgebra with even part $\mathop{\mathrm{ran}}W_+$*, a condition on $W$, not on a pair. It coincides with the headings' "compact symmetric pair with $E_+$ the isotropy algebra" **exactly on $\{\ker W=0\}$**; forward fails at $W_{\mathbb{CP}^2}$, where $\dim E_+=1$ is the even part of no involution of $\mathfrak{so}(4)$ | v116, v117, v118 |
| **C4** | "it fails strictly at the low-value ones" | **false**: equality holds at $S^2\times S^4$ with $\theta^2=\tfrac{15}{16}$ and at $\mathbb{CP}^4$ with $\theta^2=\tfrac{35}{36}$, both below $1$ | v117, v118 |
| **C5** | $\mathop{\mathrm{scal}}=2\mathop{\mathrm{tr}}$ | the convention that makes the two halves of the proof meet, and **tabled nowhere on the record**; the $6\delta^2$ coefficient is right only under it | v116, v117, v118 |
| **C6** | the "needs only" list | it omits criticality, Ricci-flatness and first Bianchi, and the proof also uses $W_+W_-=0$, the spectral character of $\Pi_-$, and $Q$ preserving $\mathcal W_n$ | v116, v117, v118 |
| **C7** | the retired "modulo $\ker W$" hedge | still standing at [results.md](../results.md):122, [INDEX-results.md](../findings/INDEX-results.md):22 and [lean/INDEX.md](../lean/INDEX.md):179, the last recording it as owed formalisation work | v116, v117 |
| **C8** | the closure clause | it needs criticality and says it needs none: the slack equals $\tfrac12\mathop{\mathrm{tr}}X_{\mathrm{inv}}$ only because $\mathop{\mathrm{tr}}(P_0W^\#)=0$ | v118 |
| **C9** | the box's own pointer | *"79 LINES BELOW"* lands in a different block, not on the refutation | v118 |
| **C10** | the hypothesis count | "twice each" is right on the $\lvert W\rvert$-difference route and once each by direct polarisation, **route-dependent, not wrong**; *withdrawn as a defect by two verifiers* | v116, v117 |

## Phase 3, adjudication

**The inequality is the strongest thing this loop has confirmed.** Three independent cold rebuilds, three exact equality checks at named objects, and an argument that it *cannot* be falsified: every slack term is a PSD compression. **The whole defect lies between what is proven and what a consumer reads.**

**C2 is the round's own kind of lesson.** The constant is wrong *in the proof that was written to repair this block's missing proof*, a transcription error introduced by a repair, at a site the record gets right four times elsewhere. It is inert inside L7, which uses only positivity, and fatal for anyone lifting the line as an identity.

**C3 is where the false reading came from.** The phrase is true on the subalgebra family, where it is [L23](../findings/ungraded-slack.md)'s statement; it was carried from there onto a lemma quantified over every critical point, where $\ker W\ne0$ is generic.

**C10 was withdrawn under the protocol**, by two verifiers independently, for the right reason: the count depends on which of two equivalent routes the reader takes, and the block describes one of them.

**No adjudication split, and no finding required computation.**

## Phase 4, the fix

**Verdict: `BROKEN`. Impact: `PROPAGATES`**, the inequality `SURVIVES` intact; the equality identification, the low-value clause and the hypothesis list were `UNSUPPORTED` at every site a consumer reads, and are repaired there.

- **The rank-one constant is corrected to $\tfrac12$** at [bounds.md](../findings/bounds.md):51.
- **Both headings now say "graded-subalgebra equality class"**, and the canonical statement gives the class as a condition on $W$, names $\ker W=0$ as exactly when it is a symmetric pair, exhibits $W_{\mathbb{CP}^2}$ for the forward failure, and records that equality reaches $S^2\times S^4$ and $\mathbb{CP}^4$ below $\theta=1$.
- **The hypothesis list is stated** (criticality, Ricci-flatness, first Bianchi), with $W_+W_-=0$, the spectral $\Pi_-$ and $\mathop{\mathrm{scal}}=2\mathop{\mathrm{tr}}$ named as the properties used unnamed.
- **$\mathop{\mathrm{scal}}=2\mathop{\mathrm{tr}}$ is now tabled in [conventions.md](../findings/conventions.md)**, with what it is load-bearing for.
- **[report/sections/07-gradedness-split.tex](../report/sections/07-gradedness-split.tex) carries both repairs**, its two sentences having been the same claims in the prose a reader would see first.
- **The equality class is recorded as not stable under $W\mapsto-W$**, while the critical set is.
