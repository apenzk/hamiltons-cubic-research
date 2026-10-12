# Step 8 position file, 2026-09-02, everything this sweep needs, and nothing else

**Purpose.** This file is the whole input to step 8's literature sweep and route proposal. It is written on Opus from the record so that the sweep (which runs on Fable, where the context window compacts near 160k tokens), never has to re-read [findings/](../findings/), [plan.md](../plan.md), [routes.md](../routes.md) or [references/INDEX.md](../references/INDEX.md) to know where the programme stands. Read this, then search, then write outcomes back into [2026-09-02-LIT-step8-sweep.md](2026-09-02-LIT-step8-sweep.md) after every batch.

**Standing rule, which the sweep inherits and must state in any brief it writes.** [analysis-only.md](../.claude/rules/analysis-only.md): computation requires per-task approval. Screening a claim about to be recorded is permitted, seconds of compute, on objects constructed for that purpose, reported as a screen and never as evidence for a positive claim. Searches, sweeps, censuses and falsifier hunts wait for approval. When a proposed route needs computation, name what the run would decide and stop.

## 1. The problem, and the two numbers

$\mathcal W_n$ is the space of algebraic Weyl curvature operators on $\mathbb R^n$; $Q(W)=W^2+W^\#$ is Hamilton's quadratic map, which sends $\mathcal W_n$ to itself; $P(W)=\langle W,Q(W)\rangle$ is the cubic form. **Goal: $P$ on the unit sphere of $\mathcal W_n$ is maximised by the Weyl tensor of $S^{n/2}\times S^{n/2}$, for even $n\ge12$, granting the diagonal case.** Conjecture A is the step taken toward it.

Two constants govern every bound on the record: $\theta_0(n)$, the value at the balanced sphere product ($\theta_0(12)=1.236$), and $\sqrt{3/2}\approx1.2247$, the residual ceiling that the non-diagonal $\{Q(W)=\theta W,\ S=0\}$ locus must be shown to respect. A candidate bound that lands above $\theta_0(n)$ is not a closure; the recorded failures are usually slack by factors of $2$–$25$, so *margin* is the thing to ask of any new route.

## 2. The six open nodes of Figure 1

These are what a route must close. Anything else is build work.

| Node | What is open |
|---|---|
| **(G) gradedness** | a maximiser must be graded, unproven |
| **residual** | $\sup\{\theta:Q(W)=\theta W,\ S=0,\ \text{non-diagonal}\}\le\sqrt{3/2}$ |
| **non-diagonal half** | the half $\{\Delta>0\}$ itself, never graded as a planning region |
| **(c) L24 as exclusion** | Lemma L24 turned into an exclusion theorem off the diagonal locus |
| **second-kind dichotomy** | **hollow on the target set**, $\mathrm{CD}_n$ there reads $\lambda\le\sqrt{3/2}$, the target verbatim; LOSS $=\mu(\mu-\lambda)$ identically; branch 2 fires at $0$ of $11$ non-diagonal points |
| **degree-six certificate at $n\ge12$** | a machine certificate, so it has **no analytical endgame** by the skill's own rule |

## 3. The route register, compressed

**Closed, with the clearance criterion a successor must meet.** R1 universal SOS certificate (endgame is a machine certificate, produce a statement a reader can check). R2 Cauchy–Schwarz on the sharp term (post F34: restates $\theta\le\theta_0$; loss largest where the conjecture is slack). R3 the $\sqrt3$ cap (post F35: cannot close below $n=356$; the $M(n)/\sqrt2$ conversion is valid only on $\circ$-decomposables). R4 localization around $SO(n)\cdot W_{\mathbb{CP}^2}$ (Nienhaus's $n=12$ flip is structural: $\Gamma_1(\alpha)=(1+\alpha)\sqrt{1-2\alpha}$ vanishes identically at $\alpha=1/3$). R5 support dichotomy (borrowed quantities left their domain). R6 diagonalizability (padded $W_{\mathbb{CP}^2}$ is a local max and Plücker-obstructed). R7 gradient flow / cone invariance (the only cone giving the conjecture is $\mathcal W_n$, where invariance is vacuous). R8 Peirce calculus (post F37: every conclusion is an identity on the orbit tangent). R9 bi-spectral coupling (Lemma L52 is an identity on the diagonal family; beaten off it by a one-line bound and post F33). R10 the $\Delta$-half (stalled: six sub-routes closed in one cycle for one reason). R13 spectral Turán transfer and R14 the deficiency identity, both closed in the cycle that opened them.

**Live.** **R15, mine the exact diagonal families, primary**, opened by the previous step-8 sweep: [DGK 2023](../references/deninger-grundhoefer-kramer-2023-srg-quadratic/notes.md) solve this record's diagonal criticality equation exactly, two-eigenvalue solutions corresponding to strongly regular graphs, most of them not sphere products. Its first sub-step I26 is **closed**: the saturating SRG members are exactly the balanced sphere products (Lemma L74 = DGK Theorem 5.1 with $\theta_{\text{rec}}=\sqrt2\hat\theta$). What remains: the theorem list past DGK §3, and the SRG-to-$W$ normalisation pinned before any $\theta$ is quoted. **R12 isotype census, stalled.** **R11 the conjunction, fallback**: at a local maximum with positive excess the fourth-order inequality $\langle b,B^+b\rangle\le\theta/2$ becomes live. **Reserve: empty.**

## 4. The live plan items, with the theorem each would produce

**Section 1 is empty and stays empty until the user picks a node**, it was rebuilt around the second-kind dichotomy and then found hollow on the target set, and listing an item whose `moves` column names a node that cannot carry it is the error the emptiness prevents.

**Section 2, build.** I9: every recorded spectral bound as a dual certificate of the pinned LP, one multiplier vector $(\alpha,\beta,\gamma)$ against relations (A),(B),(C), plus the balanced-product certificate, grade 3. I21: the $SO(n)$-saturation of the diagonal locus is compact, and every critical point in the diagonal family's closure is diagonal, grade 3. I10: tube exclusion around the padded $\mathbb{HP}^2$ orbit, giving $\max P\le\sqrt{56/45}<\theta_0(n)$ inside the tube, grade 3, transverse-eigenvalue step unscreened. I11: Lemma L57 lifted to every frame with the defect isolated, grade 2. I12: the four-index certificate off the diagonal locus, grade 4; its sub-step is closed by post F46 (the half-flat single-four-set family carries exactly one critical point, $\pm W_{\mathbb{CP}^2}$), and what it still owns is $\Sigma\le\theta^2(1+c^2)^2$ with $\sum_Sc_S^2\le1-t_F/2$ and the question whether it ever bites at $n\ge12$. I13: the pinned LP at three eigenvalues, kernel-free, grade 2; **what is owed is one thing, a cross-row constraint**, the per-row multiplier route being closed by posts F43 and F45. I14: the second variation at every diagonal critical point, block-diagonalised over the sign-character decomposition, grade 6; L120–L122 supply three of the blocks and the fourth is the granted diagonal locus, so what is owed is a scope correction and the branching clause. I15: what a fourth relation on the signed constants has to be, grade 2, its stated mechanism refuted by r347/r348.

**Section 3, disprove.** I16: the pinned class cannot bound $\theta$ once a kernel is allowed ($n=12$, spectrum $(-a)^4,b^3,0^{59}$, $\theta=2.2913$), so every spectral item must be kernel-free or carry a relation non-vacuous on zero rows. I17: the symmetric doubly-stochastic reading is HLP majorisation and carries no $\theta$.

**Blocked on the analysis-only rule** (all numerical): I19 the falsifier hunt on the non-diagonal part of $\{S=0,\Delta>0\}$; I13a the LP feasibility census; I11a the frame search; I24a the LP at the $n=12$ witness spectrum.

## 5. Structural facts a route must respect

- **The three per-index relations on $T_{abc}=c_{abc}^2$ are complete**, (A) Killing row mass, (B) the per-row identity $A(W)=2W$, (C) criticality. [Reviewer 331](REVIEW_r331.md) closed all four hunting grounds for a fourth: Bianchi, Jacobi's square-producing contractions, the off-diagonal criticality block, and the quartic Casimir.
- **The joint reading of the three beats every per-row bound built from them**, and the pinned class is exact at all seven catalogued spectra tested. **But only kernel-free**, a zero class of multiplicity $\ge3$ makes (A) vacuous on the nonzero rows.
- **The pinned/free split holds only at spectra with $\ge3$ distinct eigenvalues of multiplicity $\ge3$.** A new lever must name the spectra where it is free, not merely its weight pattern.
- **Post F33**: two moments plus a one-sided support cannot supply the coupling, so a coupling must use the operator, not the spectrum.
- **Post F37**: the third/fourth-variation calculus is vacuous on the orbit tangent at every critical point.
- **Warnings**: the gradedness screen is vacuous when $\ker W\ne0$; a critical point carries several inequivalent gradings, so no $\mathfrak p$-block quantity is defined until the grading is named; the nondegeneracy margin decays like $1/(2(M-1))$, $M=\max(p,q)$; $L_e$ is scalar on irreducibles, not on isotypes.

## 6. What the literature has already been asked

Five sweeps are on file, and a sixth ran on Fable and was lost to compaction, its outcomes are reconstructed in §7.

| Report | What it settled |
|---|---|
| [LIT-invariants](LIT-invariants.md) | relations (A) and (B) are published, [Böhm–Wilking](../references/boehm-wilking-2008-space-forms/notes.md) Lemma 2.1 gives $I\#I=(n-2)I$ and $W\#I=-W$ directly |
| [LIT-jacobi](LIT-jacobi.md) | the Schur law $\sum f(\lambda_a)g(\lambda_b)T_{abc}=-\sum_ia_i\langle\pi_if(W),\pi_ig(W)\rangle$ |
| [LIT-laplacian-block](LIT-laplacian-block.md) | the block Laplacian reading |
| [LIT-spectra](LIT-spectra.md) | **no realizability criterion for Weyl spectra exists in print for $n\ge5$**; [Payne](../references/payne-2010-soliton-metrics/notes.md) covers the squares but not per-row moment ranges; the hull condition is moment-map convexity ([Lauret–Will](../references/lauret-will-2006-einstein-solvmanifolds-moment-map/notes.md) Prop 3.2(i)), **the group whose moment map is the per-row system is still owed** |
| [LIT-srg-forward](LIT-srg-forward.md) | opened R15 (DGK 2023) |

**References coverage: 63 sources, 44 transcribed.** Well covered: the second-kind literature (13 sources, Li, Cao–Gursky–Tran, Cheng–Wang, Dai–Fu, Nienhaus–Petersen–Wink, Petersen–Stanfield, Fu–Lu), Böhm–Wilking, Wilking's Lie-algebraic cones, Wolf's isotropy-irreducible tables, Schwahn, Payne, Lauret–Will, DGK. **Absent from the record**: Margerin, Hsiang algebras, Kirwan / Kempf–Ness, Böhm–Wang–Ziller's simplicial-complex method, Lasserre.

## 7. The Fable sweep that was lost, reconstructed

Twelve searches ran and their conclusions survive only as the lines below. **Do not repeat these.**

**Searched, nothing usable found.** Fox–Tkachev 2024 (cubic minimal cones, quasicomposition and tripling) and 2026 (palintropic algebras), Peirce machinery, no curvature contact. Margerin's $n=4$ maximisation, it is $P|_{\mathcal W^+}=c\det$ on traceless $3\times3$, which is the record's Lemma L124 ($9\det V_+$); nothing to export. Böhm's simplicial complexes and Böhm–Wang–Ziller's graph, existence criteria for invariant Einstein metrics via intermediate subalgebras, no contact with the $[ijk]$ system as a constraint calculus. Lauret's moment-map stratification, the energy $E(\mu)=\lVert m(\mu)\rVert^2$ on Lie brackets $\Lambda^2(\mathbb R^n)^*\otimes\mathbb R^n$, a different representation from $\mathrm{Sym}^2\Lambda^2$. Structure constants as a doubly-stochastic/hypermatrix polytope, nothing in print. Orbit-closure and common-eigenframe closedness (for I21), standard facts only. Sectional-matrix row sums in a frame (for I11), nothing.

**Three leads, none yet judged.**

1. **The Fox exact / Killing-metrised identity.** [Fox 2019](../references/fox-2019-nonassociative-curvature-algebra/notes.md) line 17: an irreducible isometric $G$-action forces the algebra to be **exact and Killing metrised**, $\tau(x,y)=\operatorname{tr}L_xL_y$ a multiple of the metric, a class that already contains $\mathcal W_n$. At an idempotent $e$ with Peirce eigenvalues $\lambda_i$ this gives $\sum\lambda_i=0$ and $\theta^2=\kappa_n/(1+\sum_{i\ne0}\lambda_i^2)$: **the critical value is determined by the Peirce second moment.** That invariant is exactly what post F6 measured and found $49.7\times$ short, so the lead lives or dies on whether a constraint *beyond* the second moment is available, the candidates are Lemma L24's $\lambda_i\le\tfrac12$, the orbit's $\dim E(\tfrac12)$ from Lemma L127, and the multiplicity data. **Unjudged.**
2. **The Kronecker-square reading of $\#$.** $R^\#=\tfrac12\beta(R\otimes R)$ with $\beta((a\otimes b)\otimes(c\otimes d))=[a,c]\otimes[b,d]$, so Hamilton's algebra splits into a Jordan part and a Kronecker-square-of-$\mathfrak{so}(n)$ part. No literature located. **Unjudged, and the searches for it are unfinished.**
3. **Lasserre 2020, [arXiv:2010.07066](https://arxiv.org/abs/2010.07066), "Homogeneous polynomials and spurious local minima on the unit sphere."** Characterises local minima of a degree-$d$ form on the sphere by three quantities at a point (value, gradient norm, the two smallest Hessian eigenvalues) and constructs a resultant $\mathrm{Res}(f)$ whose vanishing makes every second-order point a genuine local minimum. **Not on file. Adjacent to node (c) and to I10's tube step.** File it under `references/lasserre-2020-spurious-local-minima/` if the sweep uses it.

**Closed by search: the moment-map/GIT framing.** The compact-group moment map on $\mathrm{Sym}^2\Lambda^2$ is trivial, and the $GL$ action lands in $\mathfrak{gl}(n)$ rather than $\mathcal W_n$, so no group whose moment map is $Q$ was found, which is the same debt LIT-spectra recorded against Lauret–Will. **A successor proposing a GIT route must name the group first.**

## 8. What the sweep still owes

**Per-item searches, not yet run**: I9, I21, I10, I11, I12, I13's cross-row constraint, I14's branching clause, I15, I16, I17, I19. **Per-node searches, not yet run**: (G) gradedness, the residual, the non-diagonal half, (c) as exclusion, the dichotomy, the certificate. **New-route searches, not yet run**: fixed points of the ODE $\dot R=R^2+R^\#$ as an algebraic classification; equivariant bifurcation and Michel-type symmetry breaking for I14's branching clause; a sharp constant for $\lVert W^2+W^\#\rVert$ in terms of $\lVert W\rVert^2$; the Kronecker-square algebra of $\mathfrak{so}(n)$.

**The standing instruction from the user**: *"also consider new routes that we have not thought about yet"*, the sweep must propose routes that add nodes to the map, not only routes against existing nodes.

**Then phase 3**: 2–4 ranked routes, analytical-first, each with mechanism / what it takes / what it delivers / falsifier / sources, each screened by grepping [findings/](../findings/) for its mechanism, against the fence posts in §5 and [INDEX-traps.md](../findings/INDEX-traps.md), and through [ATTEMPTS.md](../ATTEMPTS.md)'s mechanism index. Say which one you would pick, then **wait for the user's choice**; nothing goes into [plan.md](../plan.md) before then.
