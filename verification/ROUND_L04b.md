# ROUND L04, the generator criterion, its closed form, and a family the record twice calls non-diagonalizable

**Id:** L04. **Source:** [findings/ungraded-slack.md](../findings/ungraded-slack.md):119, :121. **Date:** 2026-09-07. **Verifiers allocated:** v104, v105, v106. **Phase:** 6, closed. **Verdict:** `BROKEN`, repaired, impact `PROPAGATES`.

**Why this id.** First of tier 1 with a numbered id, and it owes a rerun: [an earlier round](ROUND_L04.md) was stopped at three of five verifiers, two having been killed on their first log line, and **its findings were left provisional under a brief since superseded**. Nothing from it is carried into this brief.

**Phase 0's own finding, the forms disagree, and both go to the verifiers unlabelled.** [results.md](../results.md):116 states the family is **"provably non-diagonalizable"**, and [ungraded-slack.md](../findings/ungraded-slack.md):119 states **"None is coordinate-diagonalizable"** with a single named exception. The same block carries a correction saying every balanced-split member is coordinate-diagonal at every even $n$. **The verifiers are told none of this**; they are asked to check the claim against the family's own maximiser.

**Pre-registered questions.** *(Questions, not verdicts. No adjudication has run on any.)*

1. **Which hypothesis does the proof use?** *The criterion carries two, $(\Lambda^4\mathbb R^n)^K=0$ and $\dim\mathcal W_n^K=1$.* **Say which of them the written argument actually invokes, and whether the other is necessary, sufficient-only, or unused.**
2. **Is the family non-diagonalizable?** *The block says none of its members is coordinate-diagonalizable, with $\mathfrak{su}(2)\oplus\mathfrak{su}(2)$ the lone exception.* **Take the family's own stated maximiser, $\mathfrak{so}(n/2)\oplus\mathfrak{so}(n/2)$, write $\Pi_{\mathfrak h}$ in the basis $\{e_i\wedge e_j\}$, and say what you find.**
3. **Is the closed form derived or fitted?** *It is described as "checked against held-out spaces it was never fitted to".* **Find its derivation on file, or record that the support is agreement at test points.**

**A source is read, never cited from memory.** *If a source is not in [references/](../references/), say the claim rests on an unread source.*

## The brief as dispatched

*Provenance stripped, mathematics verbatim, quoted from the current source.*

### The criterion and the family

If $K\subseteq SO(n)$ satisfies $(\Lambda^4\mathbb R^n)^K=0$ and $\dim\mathcal W_n^K=1$, the $K$-invariant $W$ is a critical point automatically, by equivariance, no per-example computation. Bi-invariant metrics on compact simple Lie groups and isotropy-irreducible symmetric spaces with $b_4=0$ both qualify, giving critical points at $P=0.8367$ ($SU(3)$, $n=8$), $0.7464$ ($SU(6)/Sp(3)$, $n=14$), and others; zero-padding preserves everything, so they persist into $n=12$. Every member has just two eigenvalues, giving the closed form $P/\|W\|^3=\tfrac2n\sqrt{rN/(N-r)}$ with $r=\dim\mathfrak h$, $N=\binom n2$, checked against held-out spaces it was never fitted to. None is coordinate-diagonalizable, and for the Lie-group members that is proven rather than numerical, the lone exception being $\mathfrak{su}(2)\oplus\mathfrak{su}(2)$, which is exactly why $S^3\times S^3$ *is* diagonal, so the argument recovers its own boundary case.

### The maximum of the family

The closed form also determines the family's maximum exactly. Since $\theta$ increases with $\dim\mathfrak h$, the question is how large a subalgebra can be while still generating a critical point, and the answer is $n(n-2)/4$, attained by $\mathfrak{so}(n/2)\oplus\mathfrak{so}(n/2)$, so the balanced sphere product is itself a member and the family's maximiser. The members with **simple** isotropy, which is where the first enumeration looked, top out far below at $0.8367$.

### The canonical form, quoted alongside without comment

**Lemma L4 (landscape). A generator for critical points.** Any $K\subseteq SO(n)$ with $(\Lambda^4)^K=0$ and $\dim\mathcal W_n^K=1$ yields a critical point automatically, producing a new, provably non-diagonalizable family with a closed-form $P$.

## Phase 2, the clustering

**Reports:** [VERIFY_v104](VERIFY_v104.md) `BROKEN`, [VERIFY_v105](VERIFY_v105.md) `BROKEN`, [VERIFY_v106](VERIFY_v106.md) `HYPOTHESIS-DEBT` with four clauses `BROKEN`.

| # | clause attacked | mechanism | support |
|---|---|---|---|
| **C1** | the criterion's hypotheses | $(\Lambda^4\mathbb R^n)^K=0$ is unused and unnecessary, the argument runs verbatim without it, and $K=U(m)$ satisfies the conclusion while failing the hypothesis. Two load-bearing imports go unstated: equivariance of $Q$, and $Q$-closure of $\mathcal W_n$ | v104, v105, v106 |
| **C2** | "None is coordinate-diagonalizable", lone exception $\mathfrak{su}(2)\oplus\mathfrak{su}(2)$ | the family's **own stated maximiser** is coordinate-diagonal at every even $n$: $\mathfrak h$ and $\mathfrak m$ are each spanned by basis bivectors, so $\Pi_{\mathfrak h}$ is $0/1$ diagonal. Witnesses past the smallest: $\mathfrak{so}(4)^{\oplus2}\subset\mathfrak{so}(8)$, $\mathfrak{so}(5)^{\oplus2}\subset\mathfrak{so}(10)$ | v104, v105, v106 |
| **C3** | "Every member has just two eigenvalues" | the criterion returns an invariant line with no spectral control; $U(3)$ at $n=6$ has $\dim\mathcal W_6^{U(3)}=1$ and three eigenvalues, so the property cannot follow from the criterion's mechanism | v104, v105, v106 |
| **C4** | "zero-padding preserves everything" | the padded $SU(3)$ member at $n=12$ has spectrum $u^{(8)},v^{(20)},0^{(38)}$ and fails $\dim\mathcal W_{12}^K=1$; the closed form read there gives $\sqrt{22/87}$ against the true $\sqrt{7/10}$ | v104, v105, v106 |
| **C5** | "simple isotropy tops out at $0.8367$" | $\mathfrak{spin}(9)\subset\mathfrak{so}(16)$, the isotropy of $\mathbb{OP}^2$, has $b_4=0$ and gives $\tfrac34\sqrt{10/7}=0.896421$ | v105, v106 |
| **C6** | the closed form's support | derived in full at L23, forty lines below, and **neither site that states it cites that derivation**, both offering agreement at test points | v104, v105, v106 |
| **C7** | two quantifiers | the maximiser clause needs $n$ even; "$\theta$ increases with $\dim\mathfrak h$" holds at fixed $n$ only, and the block's own two members reverse it across dimensions | v104, v105, v106 |
| **C8** | "for the Lie-group members that is proven rather than numerical" | nothing on file, [diagonality.md](../findings/diagonality.md) certifies three objects, all by numerical minimisation, none a Lie-group member | v105, v106 |
| **C9** | the correction box itself | it announces four false clauses and omits the padding one, which is the only refuted clause carrying a wrong number | v106 |
| **C10** | [problem.md](../findings/problem.md):158's replacement clause | "their positive eigenspaces contain no decomposable bivector" is false at the same object it was written to repair: $E_{\max}=\mathfrak h$ contains $e_1\wedge e_2$ | v104, v105 |
| **C11** | $(\Lambda^4\mathbb R^n)^K\cong H^4(G/K)$ | reading $b_4=0$ as the vanishing of invariant $4$-forms uses Cartan, and [references/](../references/) holds no such entry | v105, v106 |

## Phase 3, adjudication

**Every finding is corroborated and nothing was withdrawn.** Nine of eleven clusters carry all three verifiers; each of the three re-derived the closed form independently and all three reproduced it exactly.

**The round's verdict is `BROKEN` on the block and `PROVEN, hypotheses corrected` on the criterion**, and the two verdicts are not in tension: the criterion is true from strictly weaker hypotheses than it states, and the paragraphs around it are false. v106's `HYPOTHESIS-DEBT` differs only in which of C3 and C8 it treats as the headline, it marks the same clauses broken.

**C2 is the round.** *The claim is refuted by the object the next paragraph names as the family's maximiser*, the refutation and the claim are eight lines apart, and a correction saying so has stood above them in the same block. **The record then repaired the wrong file**: [problem.md](../findings/problem.md):158 substituted a replacement universal that is false at the same object.

**C9 is the trap operating on a correction.** A box announcing which clauses are false is itself a citable claim, and this one undercounts.

**No finding required computation**, and no adjudication split.

## Phase 4, the fix

**Verdict: `BROKEN`. Impact: `PROPAGATES`**, the criterion, the closed form, the cap and the elimination in [results.md](../results.md) all `SURVIVE`; the diagonalizability clause and its downstream restatement are `UNSUPPORTED` and were repaired with it.

**The block is rewritten rather than annotated.** The correction box is gone, and what it corrected is gone with it; the block now states the criterion from the hypotheses it actually uses, names the two imports, marks the Cartan dependency unread, separates the Casimir family's two-eigenvalue property from the criterion's output and says nothing bridges them, gives both quantifiers, states padding as preserving $\theta$ and losing membership, corrects the ceiling to $\tfrac34\sqrt{10/7}$, and states diagonalizability positively, the balanced tower is diagonal, the bi-invariant simple members are not, and for the Lie-group members generally the record carries no proof.

[results.md](../results.md):116 and [problem.md](../findings/problem.md):158 are corrected at the sites a consumer reads.
