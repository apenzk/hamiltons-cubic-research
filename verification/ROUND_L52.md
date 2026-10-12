# ROUND L52, the shared-frame majorization bound, its equality case, and the headline still on the canonical form

**Id:** L52. **Source:** [findings/bispectral.md](../findings/bispectral.md):87–90, with the canonical form at [results.md](../results.md):721 and the landscape line at :248. **Date:** 2026-09-07. **Verifiers allocated:** v110, v111, v112. **Phase:** 6, closed. **Verdict:** `BROKEN`, repaired, impact `PROPAGATES`.

**Why this id.** Tier 1, cited eight or more times. It is the lemma that decides whether the two spectra of L50 can be coupled at all.

**Phase 0's own finding.** The block carries a refutation of its own headline; **[results.md](../results.md):248 and :721 carry that headline verbatim, uncorrected**, and results.md is where a consumer reads. The verifiers are told none of this.

**Pre-registered questions.** *(Questions, not verdicts. No adjudication has run on any.)*

1. **Does the bound follow, and is the equality case right?** *The block offers two routes, Karamata, and a row-by-row Jensen argument said to make Karamata unnecessary.* **Check the inequality and the "if and only if", and say which route the equality case actually needs.**
2. **Does the headline follow from the bound?** *The canonical form asserts the two spectra "do not couple usefully through a shared frame".* **Say whether the bound establishes that, something weaker, or its opposite, and check whether anything on the same page bears on it.**
3. **Is the second display derived or screened?** *Alongside the bound the record carries $\theta\le(t_F/2)^{3/2}\Theta_n+\tfrac92(M_++m)(1-t_F/2)$.* **Find its derivation, check its coefficient, and say whether the support is an argument or agreement at six digits.**

**A source is read, never cited from memory.** *If a source is not in [references/](../references/), say the claim rests on an unread source.*

## The brief as dispatched

*Provenance stripped, mathematics verbatim, quoted from the current source.*

### Statement and proof

In any orthonormal frame, $M_{(ij),(ij)}=W_{ijij}$ and $\langle\mathring W\varphi_{ij},\varphi_{ij}\rangle=W_{ijij}$ for $\varphi_{ij}=(e_i\odot e_j)/\sqrt2$. Writing $K$ for the sectional vector and $K'$ for the full $\mathring W$ diagonal, Schur's theorem gives $K\prec\mu$ and $K'\prec\omega$. Majorization alone bounds nothing, $t^3$ being neither convex nor concave; with $\omega_i\ge-m$ and $\mu_i\le M_+$ the functions $t^3+3mt^2$ and $t^3-3M_+t^2$ are respectively convex and concave on the relevant ranges, giving

$$\theta\ \le\ \tfrac32\big[p_3(K)+3M_+(1-p_2(K))\big]-\tfrac12\big[p_3(K')+3m(p_2(K')-3)\big].$$

The bound is **exact if and only if both operators are diagonal in one shared frame**, by strict convexity of $t^3+3mt^2$ and the equality case of Karamata. **Karamata is not needed**: the majorization here is the special one where $K$ is a diagonal and $\mu$ a spectrum, so $K_i=\sum_j|U_{ij}|^2\mu_j$ with $(|U_{ij}|^2)$ doubly stochastic, and **Jensen gives the bound row by row**, summing collapses by the column sums, with no Abel summation and no sorting. The equality case follows directly: tightness in every row makes each row a point mass under strict convexity, so $U$ is a permutation, which is the shared frame.

### A second display the record carries for the same lemma

$$\theta\ \le\ (t_F/2)^{3/2}\,\Theta_n+\tfrac92(M_++m)\big(1-t_F/2\big).$$

Its stated support is that $\tfrac92(1.632993)(0.5)=3.674235$ reproduces the first display's penalty sum exactly.

### The canonical form, quoted alongside without comment

**Lemma L52 (second-order). The two spectra do not couple usefully through a shared frame.** Both operators carry the same sectional curvatures on their diagonals, so Schur–Horn plus support bounds couples $\mu$ and $\omega$.

## Phase 2, the clustering

**Reports:** [VERIFY_v110](VERIFY_v110.md) `GAP`, [VERIFY_v111](VERIFY_v111.md) `BROKEN`, [VERIFY_v112](VERIFY_v112.md) `BROKEN`.

| # | clause attacked | mechanism | support |
|---|---|---|---|
| **C1** | the displayed inequality | *no defect*, both convexity directions correct against their ranges, both diagonals inside them, the signs of $+\tfrac32$ and $-\tfrac12$ matching an upper and a lower bound | v110, v111, v112 |
| **C2** | "Karamata is not needed" | true of the **inequality**, the row-by-row Jensen route genuinely replaces it | v110, v111, v112 |
| **C3** | the equality clause, "if" half | $K'$ is called "the full $\mathring W$ diagonal" as though the frame fixed it; the $\psi$-block carries $O(n-1)$ of further freedom, and at a coordinate-diagonal $W$ in the staircase basis the bound is **strict** | v110, v111, v112 |
| **C4** | the equality clause, "only if" half, Jensen route | *"each row a point mass, so $U$ is a permutation"* is false: Jensen's equality makes the **variable** constant on each row's support, not the weight a point mass. A $\pi/4$ rotation in a degenerate eigenplane is row-tight and no permutation, and degenerate spectra are the standing case | v110, v111, v112 |
| **C5** | the equality clause, "only if" half, Karamata route | it needs strict **concavity** of $t^3-3M_+t^2$ as well as strict convexity, and the sentence names one | v112 |
| **C6** | the headline | the bound is an *identity* on the diagonal family, so it is a **sharp** coupling, the heading asserts the opposite of what the lemma proves, and [results.md](../results.md):248 and :721 carry it uncorrected | v110, v111, v112 |
| **C7** | the second display's support | its penalty half is one line of exact algebra and the six-digit "screen" is that identity read at one point | v110, v111, v112 |
| **C8** | the second display's provenance | **derived**, in [r480](../reviews/REVIEW_r480.md), which the record cites and does not reproduce | v110, v112 (**v111 dissenting**) |
| **C9** | "a reduction of Conjecture A to a lower bound on $t_F$" | empty except at $t_F=2$: since $\frac{1-u^3}{1-u^2}\le\tfrac32$ on $[0,1]$, the display gives $\theta\le\Theta_n$ below $t_F=2$ only when $M_++m\le\tfrac13\Theta_n$, where the one-line bound already gives $\theta\le\tfrac12\Theta_n$ | v110, v112 |
| **C10** | "loses exactly when $t_F<\tfrac43$" | $\tfrac43$ is the $C\to\infty$ limit of the threshold, not a per-tensor one; refuted by hand at $t_F=\tfrac32$, $n=12$ | v111, v112 |
| **C11** | the Lean row | it narrates the false permutation step as done, and its `diagonal_le_spectrum` demands a convexity L52's $g$ lacks, so the composition it describes is blocked by hypotheses | v111, v112 |
| **C12** | "Schur–Horn", the missing domain, unread sources | only Schur's half is used; neither citable form states $W\in\mathrm{Weyl}_n$, $\lVert M\rVert_F=1$ or $n\ge4$; Schur and Karamata have no entry in [references/](../references/) | v110, v111, v112 |

## Phase 3, adjudication

**C8 was the round's only split, and it is settled by derivation rather than by a wave.** v111 recorded the leading term as having no argument on file; v110 and v112 read [r480](../reviews/REVIEW_r480.md) and found the derivation there. **The loop's rule decides it, *before recording that something has no argument on file, read the reports the record cites for it*, so the majority reading governs**, and v111's finding narrows to what is true and still worth recording: the derivation exists in a review and has never reached the findings file, which prints the display under a six-digit screen.

**C3 and C4 are one defect seen from two sides, and they are kept separate because the mechanisms differ.** C3 is a missing stipulation; C4 is a false inference. Either alone breaks the "if and only if", and they break opposite halves of it.

**C4 is the sharpest thing in the round.** The written reason is wrong and the conclusion is right (Karamata supplies it) so a reader checking the conclusion finds it holds and never reaches the step. **[DoublyStochastic.lean](../lean/HamiltonsCubic/Results/DoublyStochastic.lean) proves the two ends of that bridge and not the step between them, which is exactly the correct state**, while the Lean index narrates the step as done.

**C6 is the headline refuted by its own lemma.** An inequality that is an identity on a whole family is a sharp coupling; the heading says the coupling is not useful.

**No finding required computation.**

## Phase 4, the fix

**Verdict: `BROKEN`. Impact: `PROPAGATES`**, the inequality `SURVIVES` and is now stated with its hypotheses; the headline, the equality clause, the reduction claim and the Lean row were `UNSUPPORTED` and are repaired.

- **The block is rewritten**: hypotheses stated; $K'$ defined with the $\psi$-eigenbasis stipulation the frame does not supply; the inequality's Jensen route kept and marked as covering the inequality alone; the "if" and "only if" halves separated, with the false row-tightness inference replaced by Karamata and both strictnesses named; Schur and Karamata marked as unread sources.
- **The headline is replaced by what the lemma proves** (*sharp on the diagonal family, weak off it*), in the block and in both [results.md](../results.md) forms, which also now carry $W\in\mathrm{Weyl}_n$, $\lVert M\rVert_F=1$ and $n\ge4$, and say Schur rather than Schur–Horn.
- **The second display is marked derived in [r480](../reviews/REVIEW_r480.md) and not reproduced**, with its penalty identity shown and the six-digit screen named as that identity read at one point.
- **The reduction claim is replaced by its exact refutation**, and tied to [Post F26](../findings/INDEX-traps.md), which had said the same thing four lines away.
- **The Lean row now states which half needs Karamata**, that the file proves the two ends of the bridge and not the false step, and that the composition it described is blocked by a hypothesis rather than merely unwritten.
