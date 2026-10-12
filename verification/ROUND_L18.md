# ROUND L18, the priced term, the dichotomy it feeds, and a constant nobody defines

**Id:** L18. **Source:** [findings/problem.md](../findings/problem.md):291–313, with the canonical form at [results.md](../results.md):667 and the landscape line at :224. **Date:** 2026-09-07. **Verifiers allocated:** v125, v126, v127. **Phase:** 6, closed. **Verdict:** `HYPOTHESIS-DEBT`, repaired, impact `NARROWS`.

**Why this id.** Tier 1, cited eight or more times. It is the record's account of how far the granted diagonal argument lifts, and the dichotomy it feeds is what the localization route consumes.

**Phase 0's own finding.** [results.md](../results.md):224 calls this *"The diagonal proof's middle chapters, lifted"* with no condition attached, and :667 heads it *"lifted with the defect cost quantified"*. The verifiers are told neither that, nor that anything on the record disputes it.

**Pre-registered questions.** *(Questions, not verdicts. No adjudication has run on any.)*

1. **Is the pricing claim unconditional, and is its constant right?** *The Bianchi correction is stated as a positive-semidefinite Gram form with a universal constant.* **Derive the bound, check the constant against the identity it comes from, and say whether the claim holds pointwise and dimension-free as stated.**
2. **What does the dichotomy grant?** **List every hypothesis the dichotomy is conditional on, say which of them the block names, and say what a consumer citing the landscape line would believe about its status.**
3. **What is $\tilde\theta_0(n)$?** *The symbol carries the argument's threshold.* **Find its definition, or say there is none, and if there is none, say what value it must take for the chain to close and whether the record already has that quantity under another name.**

**A source is read, never cited from memory.** *If a source is not in [references/](../references/), say the claim rests on an unread source.*

## The brief as dispatched

*Provenance stripped, mathematics verbatim, quoted from the current source.*

Conjecture L16 needs a global mechanism, and the only machinery that has ever produced a sharp bound of this type is the granted diagonal argument, so the question is what its middle chapters cost off the diagonal locus. The answer is one exactly-priced term. Spectral compressions of the criticality equation turn the workhorse inequality of Jäger's §3.3 into an exact identity holding at every critical point in every frame, verified at machine precision on the named families and on generic saddle points alike.

Its two departures from the diagonal case are now pinned. The Bianchi correction is a positive-semidefinite Gram form in $\mathrm{Alt}(R)$ with universal constant $\tfrac32$, so it costs at most $24\,\|\mathrm{Alt}(W_-)\|^2\,\lambda_{\max}(\mathrm{Ric}(|W|))$, the same defect scalar Conjecture L16 is written in, saturated exactly by the $\mathbb{CP}^2$-type competitor. The operator positivity his proof invokes, false off the diagonal locus, is needed only through one scalar contraction, whose diagonal part is proven nonnegative and whose cross term provably vanishes at every named critical point, an isotropy argument forces the relevant operators to commute there. §§3.4 and 3.5 then lift at no cost at all.

Granting that cross-term bound off the class where it is already proven, the chain gives: **every critical point clearing the threshold has either scalar curvature at least $(n+1)\tilde\theta_0(n)$, or defect bounded below by an explicit constant, computed at $n=12$ to be about $1.0\times10^{-3}$.** No such point is both Bianchi-clean and scalar-small, the quantitative split Conjecture L16 needs. Comparing the two regimes' values is the global closure and remains the open core, and running the lifted chain quantitatively has now measured how sharp that comparison must be: the rival maximizer forces any closing bound into a window of width $0.011$ at $n=12$, so nothing lossy will finish it. **That width is $\theta_0(12)-\sqrt{3/2}$, between $0.0112$ and $0.0113$**, and it is the denominator [Lemma L13](curvature-invariants.md) divides by for its excess figure, so the two blocks turn on one number. Bracketed without a root in [L18.lean](../lean/HamiltonsCubic/Results/L18.lean).

### The canonical form, quoted alongside without comment

**Lemma L18 (lifting). The diagonal proof's middle chapters, lifted.** §3.3's workhorse inequality becomes an exact identity off the diagonal locus, with a positive-semidefinite correction pricing the defect.

## Phase 2, the clustering

**Reports:** [VERIFY_v125](VERIFY_v125.md), [VERIFY_v126](VERIFY_v126.md), [VERIFY_v127](VERIFY_v127.md), **all three `HYPOTHESIS-DEBT`, unanimous.**

| # | clause attacked | mechanism | support |
|---|---|---|---|
| **C1** | the pricing half | *no defect.* $J_4\le24\delta^2\lambda_{\max}(\mathrm{Ric}(\lvert W\rvert))$ derived three times, $24=6\cdot4$ confirmed; pointwise, dimension-free, needing $\mathrm{Alt}(W)=0$ and **no criticality**, contrary to its framing. Its proof exists in [r9](../reviews/REVIEW_r9.md) §2 and the block cites it nowhere | v125, v126, v127 |
| **C2** | the repair note identifying $\tilde\theta_0$, $\hat\theta_0$, $\Theta_n$ | **three strictly ordered numbers**, not one. $\hat\theta_0=\frac{n-2}{n-3}\tilde\theta_0$ by Jäger's own definition; $\tilde\theta_0$ is $\Theta_n$'s *odd* formula read at every $n$, so they agree at odd $n$ and separate at even by $\frac{8(n-1)}{n^2(n+1)(n-2)}$. **The note was screened at $n=13$, which is odd** | v125, v126, v127 |
| **C3** | the same identification in [lean/INDEX.md](../lean/INDEX.md) | carried **under a `proved` status**, while no theorem in the file mentions either symbol, the falsehood is entirely in the row's prose | v125, v126, v127 |
| **C4** | the dichotomy's grants | four to eight depending on how they are counted, and **the block names one**; among the unnamed, an E-track certificate the ledger marks *never audited* which produces the headline $c(12)$ | v125, v126, v127 |
| **C5** | "one exactly-priced term" | the source records **three** $\delta^2$ entries, **and they do not add**: three different inequalities, one carrying a $\lambda_{\max}$ factor, one an $n=12$ figure against a dimension-free constant, so the netted $208/5$ bounds nothing | v125, v126, v127 |
| **C6** | the quoted cost's level | the block quotes the numerator $J_4$ where the chain needs $(J_4-J_5)/\sqrt{1-e^2}$. **Witness: at the competitor $\sqrt{1-e^2}=\tfrac23$ and $J_5=0$, so the penalty is exactly $\tfrac32J_4$, the quoted ceiling is exceeded at the block's own equality point** | v125, v126, v127 |
| **C7** | "scalar curvature at least $(n+1)\tilde\theta_0(n)$" | literally false at every critical point, where $\operatorname{scal}(W)=0$; the source means $\operatorname{scal}(\lvert W\rvert)$ | v126, v127 |
| **C8** | the master identity's leading term | $+\sqrt{1-e^2}$ asserts $\langle\lvert W\rvert,\widehat{\mathrm{Ric}\owedge\mathrm{Ric}}\rangle\ge0$, supported only by *"positive at every point tested"*, **a debt nobody had recorded**, and if it flips the chain's dominant term reverses | v125 |
| **C9** | [results.md](../results.md):224 and :667 | present the whole result as an unconditional Lemma, naming no grant at all | v125, v126, v127 |
| **C10** | $\tilde\theta_0$ "defined nowhere" | **it is defined**, Jäger's Notation 3.0.3, read at source by all three, just not in this record | v125, v126, v127 |
| **C11** | the constant's pairing | $24$ holds under the record's $\Lambda^2$ pairing; under plain Frobenius it reads $16$ | v125 |

**Withdrawn with reasons:** the $\tfrac32$-versus-$6$ "contradiction" (one constant, two norms); "saturated exactly by" (the equality reading is right); "§§3.4–3.5 lift at no cost" (true as *no defect cost*); the multiplicity-free gap (no failure exhibitable without computation); and the $\theta\ge$ versus $\theta>$ boundary, **declined because the source PDF's bracket glyphs are mangled in extraction, and a verifier refused to decide open-versus-closed from a corrupt character.**

## Phase 3, adjudication

**C2 is the round, and it is the second time tonight a repair has been the defect.** A note written to fix this block asserted an identification that its own screen could not have established, the screen ran at $n=13$, where the two coincide, and the block's headline constant *exists only because they differ at $n=12$*. **The block refutes its own correction with its own number.**

**C3 is what makes C2 expensive.** The false identification was carried into the Lean index under `proved`, where no theorem asserts it, so a status stamp certified prose.

**C1 and C6 together are the shape of the whole result.** The pricing is genuinely unconditional and genuinely proved *elsewhere*; the failure is that the block states it without its proof, at the wrong level, and then attaches to it a dichotomy resting on grants it does not list.

**C5's second half is the round's own caution**: the count "three, not one" is right and the aggregation offered in its support is not, so a reader taking the correction wholesale inherits a new error. **Corrections are audited here on the same terms as claims.**

**No adjudication split, and no finding required computation.**

## Phase 4, the fix

**Verdict: `HYPOTHESIS-DEBT`. Impact: `NARROWS`**, the pricing lemma stands and is citable exactly; the dichotomy is an observation on grants and is now labelled one.

- **The false identification is replaced** in the block and in [lean/INDEX.md](../lean/INDEX.md), with the three squares at $n=12$, the parity explanation for the screen, and the block's own headline named as its refutation.
- **$\tilde\theta_0$ and $\hat\theta_0$ are tabled in [conventions.md](../findings/conventions.md)** from Jäger's definitions, with the even-$n$ separation in closed form.
- **The pricing proof is named and summarised** where the block said there was none, with its true hypotheses ($\mathrm{Alt}(W)=0$, no criticality) and the pairing the constant depends on.
- **The cost level is corrected with its witness**, the competitor, where the penalty is exactly $\tfrac32J_4$.
- **"One exactly-priced term" becomes three, with the warning that they do not add** and the netted total should not be cited.
- **The scalar-curvature clause is qualified to $\operatorname{scal}(\lvert W\rvert)$.**
- **[results.md](../results.md):224 now separates the two halves** and lists the four grants; the new debt on the leading term's positivity is recorded where the chain uses it.
