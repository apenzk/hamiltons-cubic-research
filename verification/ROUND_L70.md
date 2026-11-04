# ROUND L70, the deficiency identity, its nonnegativity, and what saturates it

**Id:** L70. **Source:** [findings/bounds.md](../findings/bounds.md):216–240, with the canonical form at [results.md](../results.md):581 and the landscape line at :194. **Date:** 2026-09-07. **Verifiers allocated:** v140, v141, v142. **Phase:** 6, closed. **Verdict:** `PROVEN, hypotheses corrected`, repaired, impact `CONTAINED`.

**Why this id.** Tier 1, cited eight or more times. It is an **identity** rather than a bound, and [Lemma L71](../results.md) turns its saturation into the balanced sphere product, so what saturates it is load-bearing twice over.

**Pre-registered questions.** *(Questions, not verdicts. No adjudication has run on any.)*

1. **Does the identity hold, at every critical point and every unit $v\in E_{\min}$?** **Derive it, and say which hypotheses each step uses, criticality, the choice of $v$, the spectral hypothesis, and the mass identity $\sum c_{vab}^2=2(n-2)$.**
2. **Is $D(v)\ge0$, and under what condition exactly?** *The block says each summand is a nonnegative weight against a nonnegative factor, "provided $\lambda_{\min}<0<\lambda_{\max}$ strictly".* **Check that the factor really is nonnegative for every $(a,b)$ in the sum, and say what happens when the strictness fails, whether the identity, the sign, or both.**
3. **What saturates it?** **State the equality condition the identity itself gives, and say whether that is the same condition the record's downstream lemma consumes.**

**A source is read, never cited from memory.** *If a source is not in [references/](../references/), say the claim rests on an unread source.*

## The brief as dispatched

*Provenance stripped, mathematics verbatim, quoted from the current source.*

**The bound is one step of an identity, and keeping the step gives equality.** The bound replaces every product $\lambda_a\lambda_b$ by its minimum $\lambda_{\min}\lambda_{\max}$ over the spectrum and spends the fixed mass $\sum c_{vab}^2=2(n-2)$. Keeping the difference instead, **at every critical point and for every unit $v\in E_{\min}(W)$**,
$$\boxed{\;\theta\;=\;\lambda_{\min}+(n-2)\lambda_{\max}\;-\;\frac{D(v)}{\lvert\lambda_{\min}\rvert}\;},\qquad D(v)=\tfrac12\sum_{a,b}\big(\lambda_a\lambda_b-\lambda_{\min}\lambda_{\max}\big)c_{vab}^2\;\ge\;0 ,$$
each summand being a nonnegative weight against a nonnegative factor **provided $\lambda_{\min}<0<\lambda_{\max}$ strictly, which on $\mathcal W_n$ is supplied by $\mathop{\mathrm{tr}}W=0$ at $W\ne0$**, *the equality characterisation needs the strict inequality, and the hypothesis was missing altogether when this was first written.* **And it needs $\lVert W\rVert=1$**: under [conventions.md](conventions.md)'s $\theta=P(W)/\lVert W\rVert^3$ the left side is scale-invariant while the right is homogeneous of degree one, so the identity holds at one scale only. *The list of what the identity does not need carried \"unit norm\" until this audit, and [r323](../reviews/REVIEW_r323.md) and [r324](../reviews/REVIEW_r324.md) both propagated it, each reading $\theta$ as the criticality eigenvalue.*
**Saturation forces $\dim E_{\min}\ge n/2$ and $\dim E_{\max}\ge(n-2)/2$**, from the pair cap [Lemma L31](stratum-two-negative.md) and the Killing marginal alone (no spectrum and no Lie theory) and **both are attained exactly at $W_{\mathbb{CP}^2}$ at $n=4$**, where they read $2$ and $1$. *This replaces the population hedge that stood here with a proof, and it settles two things at once*: the [L107](../findings/bounds.md#lemma-l107-the-pi-bound-thetalen-1lvertlambda_minrvert)-style sharpening is **identically void at every saturating point**, so the boxed form stays as it is; and $W_{\mathbb{CP}^m}$ cannot saturate at $m\ge3$, since $\dim E_{\max}=1$ there against a required $m-1$. *Gate 2, [r565](../reviews/REVIEW_r565.md) and [r566](../reviews/REVIEW_r566.md).*
**So equality holds exactly when $\mathrm{ad}(v)$ is supported on $E_{\min}\otimes E_{\max}$**, every one of its $2(n-2)$ units of bracket mass landing on a pair with one index at $\lambda_{\min}$ and the other at $\lambda_{\max}$, for every unit $v\in E_{\min}$.
**On Lemma L23's two-eigenvalue family this reduces to a Lie-theoretic condition, with no computation.** There $W=\Pi_{\mathfrak h}-\tfrac rN I$, so $E_{\max}=\mathfrak h$, $E_{\min}=\mathfrak m=\mathfrak h^\perp$, and $v\in\mathfrak m$. The both-indices-in-$\mathfrak h$ mass is $\langle v,[\mathfrak h,\mathfrak h]\rangle=0$ automatically, since $\mathfrak h$ is a subalgebra and $\mathfrak m\perp\mathfrak h$. **The only surviving obstruction is the $\mathfrak m\times\mathfrak m$ mass, so saturation $\iff[\mathfrak m,\mathfrak m]\perp\mathfrak m\iff(\mathfrak{so}(n),\mathfrak h)$ is a symmetric pair.** With Lemma L23's admissibility cap, the balanced $\mathfrak{so}(m)\oplus\mathfrak{so}(m)$ is the only symmetric pair that is critical, $u(m)$ carrying defect $m$, **the saturating members of the family are exactly the balanced sphere products.**
**And that is the test which destroyed the predecessor.** [Post F40](fence-posts.md)'s correction (i) refuted "saturated exactly at the balanced sphere products" for the $\lambda$-weighted bound: it saturates on the *whole* subalgebra family, six of eight saturations being ungraded. **The salvage bound survives that population** ([run_salvage_equality_case.py](../scripts/runs/run_salvage_equality_case.py)):
| point | criticality residual | slack | mass off $E_{\min}\times E_{\max}$ |
|---|---|---|---|
| $\mathfrak{so}(m)\oplus\mathfrak{so}(m)$, $n=6,8,10,12$ | $\le5\times10^{-16}$ | $0.000000000$ | $0$ of $72,192,400,720$ |
| maximal torus $\mathfrak{so}(2)^{n/2}$, $n=6,8,10,12$ | $\le10^{-16}$ | $1.291,\;2.160,\;2.846,\;3.425$ | $\tfrac{m-2}{m-1}$ of the total, $m=n/2$ |
| $\mathrm{ad}(\mathfrak{su}(3))\subset\mathfrak{so}(8)$ | $3\times10^{-16}$ | $0.836660$ | $80$ of $240$ |
**The tori and $\mathrm{ad}(\mathfrak{su}(3))$ are genuine critical points and are strictly slack, with the slack growing in $n$**, so it separates the balanced sphere products from the rest of the subalgebra family, and [Lemma L70](../findings/LEDGER.md#lemma-l70-the-deficiency-identity-and-what-saturates-it)'s equality case explains the separation rather than merely recording it. *It was called the **first** such quantity here; [Reviewer 326](../reviews/REVIEW_r326.md)'s repaired marginal LP separates them too, and exactly, so the precedence claim is dropped and the explanation is what this contributes.* *The unbalanced $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ and $\mathfrak u(m)$ rows of that run are **not Weyl tensors at all**, distance from $\mathcal W_n$ of $0.4237$ at $\mathfrak{so}(3)\oplus\mathfrak{so}(5)$, $0.7638$ at $\mathfrak u(4)$, $0.2664$ at $\mathfrak{so}(5)\oplus\mathfrak{so}(7)$, $0.7454$ at $\mathfrak u(3)$, against $0.000000$ at every balanced split. Calling them merely non-critical understated it, and it is why they escape the theorem.* [Reviewer 324](../reviews/REVIEW_r324.md).

## Phase 2, the clustering

**Reports:** [VERIFY_v140](VERIFY_v140.md), [VERIFY_v141](VERIFY_v141.md), [VERIFY_v142](VERIFY_v142.md) (**all three `PROVEN), hypotheses corrected`, unanimous.**

| # | clause attacked | mechanism | support |
|---|---|---|---|
| **C1** | the identity | *no defect.* Derived in four steps three times over, the $\#$-diagonal expansion, criticality at the row $v$, the mass $2(n-2)$, and division by $\lambda_{\min}$. **The assembly is written on no file**; only its three ingredients are, each cited separately | v140, v141, v142 |
| **C2** | the sign's hypothesis | **the block's condition is stronger than the sign needs.** $\lambda_{\min}\lambda_{\max}$ is the corner minimum of $xy$ on $[\lambda_{\min},\lambda_{\max}]^2$ **exactly when $\lambda_{\min}\le0\le\lambda_{\max}$**, checked at both-positive, both-negative, mixed and kernel pairs. **The strict inequality belongs to the equality characterisation**, and all three forms attached it to the wrong clause | v140, v141, v142 |
| **C3** | what fails when strictness fails | *two different things.* At $\lambda_{\max}=0$ the sign survives and the *only if* fails; under an all-negative spectrum the identity survives and the sign fails | v140, v141, v142 |
| **C4** | [results.md](../results.md):583 | *"attained only on pairs containing the row index"* is **false whenever $\dim E_{\min}\ge2$**, i.e. at **every** saturating point. Refuted in the findings file and in the ledger; **the ledger's entry ends "Copied verbatim into results.md."** Two reviewers ordered the repair for both files and it landed in one | v140, v141, v142 |
| **C5** | [results.md](../results.md):583's population hedge | *"covers every saturating point on the record"*, a survey where the findings file now carries the **theorem** $\dim E_{\min}\ge n/2$ | v140, v142 |
| **C6** | the unit-norm clause | **withdrawn as a defect and repaired as prose.** The block does *not* list unit norm among what the identity does not need; it says the list *carried* it until an audit. **All three verifiers read the historical note as a live list** | v140, v141, v142 |
| **C7** | [lean/INDEX.md](../lean/INDEX.md):271 | credits a vanishing deficiency to *padded* $W_{\mathbb{CP}^2}$ while its own arithmetic ($n-2=2$) is the **unpadded** $n=4$ point; padded, $D=(n-4)/3$ | v140, v141, v142 |
| **C8** | the two $m_1$'s | the record's $m_1$ (minimum over the support) and a reviewer's (minimum over indices $\ne v$) are **different quantities**, and the coincidence clause holds for the reviewer's only. Witness at $n=4$ | v141 |

## Phase 3, adjudication

**Everything holds, and one clause holds more generally than stated.** All three derived the identity cold, all three settled the pairwise question the same way, and each produced exact witnesses: the balanced product saturating identically at every even $n$, padded $W_{\mathbb{CP}^2}$ at $D=(n-4)/3$, and the maximal-torus slack in a closed form ($(n-4)\theta$) that **the record does not state**.

**C6 is the round's own lesson, and it is about prose rather than mathematics.** The candidate was withdrawn: the block is correct. But *three independent cold readers made the same misreading*, because the sentence describes a list's history instead of its content. **A correction written as a narrative about what a passage used to say is read as what it says**, which is the record's own standing rule against history in the findings files, failing exactly where it was written to help.

**C4 is the trap with a receipt.** The ledger entry ordering the repair ends with the words *"Copied verbatim into results.md."* It was not.

**C2 is a hypothesis that was too strong rather than too weak**, the rarer direction, and worth the same correction: a reader checking the sign at $\lambda_{\max}=0$ finds the stated condition violated and the conclusion true.

**No adjudication split, and no finding required computation.**

## Phase 4, the fix

**Verdict: `PROVEN, hypotheses corrected`. Impact: `CONTAINED`**, the identity, its sign and its equality case all stand; **nothing downstream moves**, since saturation forces $\dim E_{\min}\ge n/2\ge2$ and the sharp and weak forms coincide wherever L70 is used.

- **The sign's hypothesis is weakened to $\lambda_{\min}\le0\le\lambda_{\max}$** and the strict form moved to the equality clause, with what fails on each side of the boundary.
- **[results.md](../results.md):583 carries the excluded-index correction** and the dimension theorem in place of the population hedge, and its statement now carries $\lVert W\rVert=1$.
- **The historical clause is rewritten as a present-tense fact** (the scaling witness) so the next reader is not told what a list used to contain.
- **The Lean row says unpadded**, with the padded value beside it.
