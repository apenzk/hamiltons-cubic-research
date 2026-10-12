# Step 9 sweep, 2026-09-25, round 2: (c)'s asymmetric survivors

*Position file: [2026-09-25-step9-position-round2.md](2026-09-25-step9-position-round2.md).*

## Batch 1, the three fields, searched

| query | what came back | verdict |
|---|---|---|
| eigenvalue inequalities for the Lie-algebra square $R^\#$ in terms of $R$'s eigenvalues | Böhm–Wilking's algebraic identity for how linear maps of curvature operators change $Q(R)=R^2+R^\#$, used to build invariant pinching cones ([math/0606187](https://arxiv.org/pdf/math/0606187)); Wink's Thorpe trick for the Bochner technique ([2609.11653](https://arxiv.org/abs/2609.11653)), homology-sphere theorems under $(\lceil n/2\rceil+\varepsilon)$-positivity | **invariant-cone machinery, which is [R32](../routes.md)'s field**, held closed; no eigenvalue bound on $R^\#$ at a critical point $W^2+W^\#=\theta W$ |
| critical points of cubic Weyl invariants, classification by spectrum | conformally invariant energies in dimension 4 ([2402.15032](https://arxiv.org/pdf/2402.15032)), quadratic curvature functionals ([1808.04644](https://arxiv.org/pdf/1808.04644)), a cubic invariant of the $SU(3)$ instanton on $S^6$ | **functionals over metrics**, not the algebraic maximum on $\mathcal W_n$; searched, nothing found |
| realisability of squared structure constants in an orthonormal basis of $\mathfrak{so}(n)$ | general moment-problem theory and textbook structure constants | searched, nothing found under this phrasing |

**Recorded as searched, nothing proposable from the literature.**

## Batch 2, what the record itself offers

- **The sharp seven-frame lemma** ($T\le42$, attained by the octonion frames, conjectured by [L238](../findings/second-order.md) section 10 and bounded by [L240](../findings/second-order.md) at $54.064$): it excludes [L241](../findings/bounds-relaxations.md), whose spectrum is infeasible once $T_7\le44$. *Its reach over the asymmetric survivors is screened in this round before it is graded.*
- **The unsummed per-pair inequalities** ([L234](../findings/second-order.md)): non-local in $(\lambda,T)$, so they need per-index data; any certificate over per-index variables at $n=12$ is a machine certificate, `analytic` $0$.

**Screened (a screen, five directions per triple, $\theta=1.2361$ above $\theta_0(12)$, every class constraint on file):** replacing L240's $54.064$ by the sharp $T_7\le42$ cuts the survivors from **190 to 147**, of which 9 symmetric and **138 asymmetric**. *The sharp seven-frame lemma is worth proving for L241 and a quarter of the survivors, and does not reach the majority.*

## Phase 3b, the routes, graded on section 1's rubric

| route | closes | attackable | margin | analytic | value | how close it gets to Problem P |
|---|---|---|---|---|---|---|
| **R-δ, the sharp seven-frame lemma** $T\le42$, by sharpening L240's stability count toward the octonion frames | 1 | 2 | 1 | 1 | **2** | removes L241 and 43 of 190 screened triples; leaves 138 asymmetric |
| **[R38](../routes.md), the symmetric family by hand**, via $\theta=(3\tau_{002}-3\tau_{022}+\tau_{222}-\tau_{000})/(4p\sqrt{2p})$ | 1 | 2 | 1 | 1 | **2** | settles the 9 to 11 symmetric survivors; leaves the asymmetric ones |
| **R-ε, a per-index relaxation** carrying the unsummed pair inequalities of L234 | 2 | 2 | 1 | **0** | **0** | could close (c) at $n=12$ as a machine certificate over $\sim$48k per-index variables; no analytic endgame |

**The recommendation works R38 and R-δ, in that order, and records that (c)'s asymmetric majority has no analytic route.** *R38 is concrete and closes a family; R-δ is the one sharpening the class system can still take, and it removes L241. Neither reaches the 138, and R-ε, which might, ends in a certificate the programme's goal rules out, so the honest state of (c) is "no route known" for the asymmetric majority, to be recorded in the plan rather than worked around.*
