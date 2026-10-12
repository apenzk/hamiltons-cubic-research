# Gate 2 brief, the fresh sweep at I121's small-mass node: classification, the matching-rotation reduction, and the matching family's floor

**Cold brief. The claims are quoted verbatim from [reviews/2026-09-28c-LIT-step8-sweep.md](2026-09-28c-LIT-step8-sweep.md) as it stands at dispatch. You are asked to break them.** Verdicts per claim: CONFIRMED, PLAUSIBLE or REFUTED with corrections. **Analysis-only footing**: argue from the definitions, reading the written chain link by link; compute only to refute or to check a value, the smallest computation that does it (numpy under `sage -python`). A run of a few minutes on objects you construct is allowed; no sweeps or open-ended searches. **Screens are screens, not evidence for a positive claim.**

## Definitions

- $\mathcal W_n$: algebraic Weyl tensors as symmetric operators on $\Lambda^2\mathbb R^n$, Hilbert–Schmidt norm, $Q(R)=R^2+R^\#$, $P(W)=\langle Q(W),W\rangle$. In an orthonormal frame: $a_{ij}$ the sectional values, $t^2=\sum_{i<j}a_{ij}^2$ at unit $W$, the pair part and the four-set part. A **globally maximal frame** maximises $t$ over $O(n)$.
- **(MG)**: at a unit global maximiser, in a globally maximal frame, $\rho\le\max\{\sqrt{3/2},P(A)/\lVert A\rVert^3\}$.
- For a perfect matching $M$ and an edge pair $e=\{i,j\},f=\{k,l\}\in M$, the $4\times4$ block on $\{e_{ik},e_{il},e_{jk},e_{jl}\}$ written in the products of $I,Z,X$ and $J\otimes J$, with coefficients $\alpha_{II},\alpha_{IZ},\dots$, and $V_M$ the visible energy (four-set combinations plus pair terms), as in the first sweep's matching inequality.

## Givens

- **The matching inequality** (Gate 2, [r1836](REVIEW_r1836.md), [r1837](REVIEW_r1837.md)): in a globally maximal frame every perfect matching satisfies $E(M)+\sum(x^e_k+x^e_l)^2+\tfrac14\sum s_{ef}^2\le t^2-\sum_{e\in M}a_e^2$.
- **The double-rotation block structure** ([r1797](REVIEW_r1797.md), [r1798](REVIEW_r1798.md)): conjugation by rotations of angles $\theta_1,\theta_2$ in the two planes rotates the $(Z,X)$ pair in each factor by twice the angle and fixes $I$ and $J\otimes J$, and the block's diagonal mass is $4(\alpha_{II}^2+\alpha_{IZ}^2+\alpha_{ZI}^2+\alpha_{ZZ}^2)$.
- **Post F81** and **route R6**, as filed in [findings/fence-posts.md](../findings/fence-posts.md), [findings/diagonality.md](../findings/diagonality.md) and [routes.md](../routes.md).

## The claims

## Batch 1, the record: candidate 1 is route R6, and the node is the lifting lemma

- **Candidate 1, decomposable overlap of the top eigenspace, is [R6](../routes.md) (diagonalisability) under another name**, CLOSED in [diagonality.md](../findings/diagonality.md): padded $W_{\mathbb{CP}^2}$ is a **local maximum** with $\max\operatorname{spec}(L_e|_{W^\perp})=\tfrac12$ exactly **and** Plücker-obstructed (its $2$-dimensional eigenspace at $-0.408248$ has $\min\lVert\omega\wedge\omega\rVert=0.5$), so local data at a non-diagonalisable point is indistinguishable from a maximiser's and only the value separates them. "High value forces a decomposable top eigenvector" is a bound on $\theta$ over the non-diagonal locus, which [post F22](../findings/fence-posts.md) fences, and R6 is **the record's lifting lemma renamed** ([problem.md](../findings/problem.md) item 11, three closed attacks in [ATTEMPTS.md](../ATTEMPTS.md)). R6's successor criterion reads: *separate a maximiser from an obstructed local max by something other than the value.*
- **So (MG)'s small-mass node is the lifting lemma in frame language.** At small maximal-frame mass, (MG) says $\theta\le\sqrt{3/2}$ at a global maximiser far from diagonal. Every frame-free argument tried stops at $t\sim n^{-1/2}$, the scale of [post F81](../findings/fence-posts.md)'s witness. And the one global use of the frame on the table, decomposable overlap, is R6. *The matching inequality and the pair identity separate a maximiser from other points only through the value. **One tool does meet R6's criterion: frame maximality at fourth order across several planes**, which excludes F81's witness because its frame is not maximal, with no appeal to the value. And R6's own obstruction, padded $W_{\mathbb{CP}^2}$, sits at $t^2=\tfrac12$ in its maximal frame, where (MG)'s $\sqrt{3/2}$ branch covers it, so it is not a small-mass point.* **So the small-mass node is the lifting lemma's small-mass part, and the frame vehicle has the one non-value separator R6's criterion asks for.**

## Phase 3b

| route | closes | attackable | margin | analytic | value | reach toward P |
|---|---|---|---|---|---|---|
| I121 continued: a property of the maximal frame, beyond local and matching conditions, separating a maximiser from an obstructed point by something other than the value | 3 | 1 | 1 | 1 | 3 | Conjecture A at even $n\ge12$; no method, and it must clear R6's criterion |
| [I73](../plan.md), the two-value spectrum, the plan's named fallback | 3 | 1 | 1 | 1 | 3 | Conjecture A via [L105](../findings/bounds-relaxations.md); no method for the asymmetric spectra |
| the four-set line in full ([I104](../plan.md)), where the pair identity lands small mass | 1 | 1 | 1 | 1 | 1 | the four-set-dominated regime only |

**The table has no route with a method, and the top two tie.** The tie-break is R6's criterion: I121 carries the one non-value separator on the table, the fourth-order multi-plane frame condition, and I73 carries none. **Recommendation: keep I121 on top, its next step the fourth-order frame condition as that separator.** This goes to the manager as a DECISION because the user aimed the cycle at this node.

## The separator made precise: along matching rotations it is the matching inequality (derived here, unreviewed)

For a pair-free $W$ and a perfect matching $M$, rotate every plane of $M$ by the same angle $\varphi$. On each edge-pair block write the diagonal mass as $4(\alpha_{II}^2+\alpha_{IZ}^2+\alpha_{ZI}^2+\alpha_{ZZ}^2)$ ([the double-rotation note](2026-09-28-I121-MG-audit.md)). With no pair part, $\alpha_{IX}=\alpha_{XI}=\alpha_{ZX}=\alpha_{XZ}=0$, so $\alpha_{IZ},\alpha_{ZI}$ scale by $c=\cos2\varphi$ and $\alpha_{ZZ}\mapsto\alpha_{ZZ}c^2+\alpha_{XX}s^2$, $s=\sin2\varphi$. Summing over the edge pairs of $M$,
$$f(\varphi)-f(0)=4s^2\,g(s^2),\qquad g(u)=-S_{IZ}-2S_{ZZ}+2S_{ZX}+u\,(S_{ZZ}-2S_{ZX}+S_{XX}),$$
with $S_{IZ}=\sum(\alpha_{IZ}^2+\alpha_{ZI}^2)$, $S_{ZZ}=\sum\alpha_{ZZ}^2$, $S_{ZX}=\sum\alpha_{ZZ}\alpha_{XX}$, $S_{XX}=\sum\alpha_{XX}^2$. **$g$ is linear in $u=s^2$, so global maximality along the whole family is exactly two conditions**: $g(0)\le0$, the second-order condition along $\xi_M$, and $g(1)\le0$, the $\tfrac\pi4$ matching inequality. **So the fourth-order multi-plane separator, along matching rotations, is the matching inequality itself.** It excludes [post F81](../findings/fence-posts.md)'s witness in the witness frame ($E(M)=\tfrac{11}{12}>t^2=\tfrac1{12}$) with no appeal to the value. *What it still needs is visibility in the maximal frame, and frame-free visibility decays like $0.7/n$. So the separator exists, and I121's open step is whether a high-value tensor's maximal frame is more visible than an adversarial frame.* Unequal angles and overlapping planes give further conditions, which this family does not see.

## The matching family alone is too weak (a screen)

([screen_I121_matching_feasible.py](../scripts/misc/screen_I121_matching_feasible.py), descent on $O(8)$ minimising $\max_M V_M-t^2$ with $t^2$ held near $0.2$.) **Frames of the balanced product exist at $t^2\approx0.20$ to $0.24$ satisfying all $105$ matching inequalities with room $0.10$ to $0.13$**, although the product's maximal frame has $t=1$. So the matching family, second order plus the $\tfrac\pi4$ inequality along every matching, cannot exclude small diagonal mass even at the maximiser, and **the non-value separator has to be the full $O(n)$ maximality of the frame** (unequal angles, overlapping planes, finite rotations beyond matchings). *This weakens the premise of the recommendation to keep I121: its separator is global frame optimality, which is non-value but has no tractable finite family yet.* **Lower caps locate the family's floor**: with $t^2$ held near $0.1$ or $0.07$, every matching inequality still holds at $t^2\approx0.09$ (room $0.005$ to $0.019$) and starts to fail at $t^2\approx0.08$ (excess $0.004$ to $0.006$). **So at $n=8$ the matching family allows the maximiser down to $t^2\approx0.085\approx0.7/n$**, the frame-free visibility floor and just above Schur's $0.067$. *Every family tried today, local conditions, matching rotations and frame-free visibility, lands on the same $n^{-1/2}$ barrier, and only the full $O(n)$ maximality of the frame lies beyond it.*

## The Lean table

| claim | declaration | what it covers |
|---|---|---|
| the block at angle $\varphi$, and $g$ affine in $s^2$ | `block_angle`, `block_linear` in the draft MatchingAngle.lean (at /private/tmp/claude-501/-Users-ap-code-private-hamiltons-cubic/d3790d3b-3383-4c5d-9548-46ea15965c86/scratchpad/MatchingAngle.lean, awaiting placement) | the per-block algebra; **not** the block decomposition of the rotated operator or the vanishing pair components |
| candidate 1 is R6; the node is the lifting lemma's small-mass part | none: a classification against the record; check it | |
| the fourth-order separator along matching rotations is the matching inequality | none beyond the per-block algebra; check the summation and the two endpoint conditions | |
| the matching family's floor $t^2\approx0.7/n$ at $n=8$ | none: screens; check that nothing claims more than they show | |

## What to attack

1. The classification: is candidate 1 really R6, and is "the small-mass node is the lifting lemma's small-mass part" supported, including the claim that padded $W_{\mathbb{CP}^2}$ has $t^2=\tfrac12$ in its maximal frame?
2. The reduction: with no pair part, do $\alpha_{IX},\alpha_{XI},\alpha_{ZX},\alpha_{XZ}$ vanish, and is the change exactly $4s^2g(s^2)$ with $g$ affine? Are $g(0)\le0$ and $g(1)\le0$ the second-order condition and the $\tfrac\pi4$ matching inequality?
3. The screens: are the reported frames' feasibility and floor stated as screens, and is "every family lands on the same $n^{-1/2}$ barrier" supported or overstated?
4. The recommendation's premise: does the matching family's weakness leave "the full $O(n)$ maximality is a non-value separator" standing, and is it correctly described as having no tractable finite family?
