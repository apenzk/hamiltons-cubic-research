# ROUND_L24, second-order optimality as an eigenvalue bound on the multiplication operator

**Date:** 2026-09-07. **Phase:** 6, closed. **Verdict:** `PROVEN, hypotheses corrected`, repaired, impact `CONTAINED`. **Verifiers:** v155, v156, v157.

**The most heavily cited row on the queue: 55 citations across the record.**

## Sources, verbatim

| what | where |
|---|---|
| Canonical statement | [results.md](../results.md), block `##### Lemma L24, second-order optimality, as an eigenvalue bound on the multiplication operator` |
| Landscape statement | [results.md](../results.md), the `Lemma L24 (second-order)` bullet |
| Proof block | [second-order.md](../findings/second-order.md) lines 50–73 |
| Lemma L125, cited by the argument | [second-order.md](../findings/second-order.md) lines 74–90 |
| Conventions | [conventions.md](../findings/conventions.md) |
| Brief | [BRIEF_L24.md](BRIEF_L24.md) |

## What phase 0 hands the verifiers

**The block carries two of its own prior versions as refuted, both found by the same Gate 2 pair.** The sharpness argument once rested on $\langle e,L_ee\rangle=1$, which is $\theta^{-2}$; the scope paragraph once claimed the inequality reverses at negative $\theta$, which is impossible since $e(-W)=e(W)$ and $(-W)^\perp=W^\perp$. *A block that has been repaired twice at the same two places is where a third defect is cheapest to miss.*

**The statement is Krasnov–Tkachev Proposition 6.6**, derived here independently and retained as confirmation. The record notes their paper prints $c\otimes c$ where the argument needs the normalised projector.

**Three hypotheses to test against the object**: $\theta>0$, which the scope paragraph argues is automatic at a maximiser through [L51](../findings/second-order.md); criticality, which gives $L_ee=e$ and hence the invariance of $W^\perp$; and *maximiser* rather than *critical point*, which is what turns $\mathrm{Hess}\le0$ into the bound.

## Clustering, all three in, unanimous

**The core holds.** v155 re-derived $\nabla P=3Q(W)$, $D^2P=6\theta L_e$, the multiplier's $-3\theta\,\mathrm{Id}$ as $2\mu$ with $\mu=\tfrac32\theta$, self-adjointness of $L_e$ through the $\#$ slot transposition at sign $(-1)^2$, the invariance of $W^\perp$, the bound, and the simplicity of $1$, all by hand and all clean. **Both prior repairs hold**: the orbit directions are exact $\tfrac12$-eigenvectors by differentiating $Q(gW)=gQ(W)$, and $Q$ even with $P$ odd gives $e(-W)=e(W)$ and $(-W)^\perp=W^\perp$.

**The Riemannian-versus-ambient worry does not fire**, the second fundamental form $\mathrm{II}(V,V)=-\lVert V\rVert^2W$ contributes exactly $-3\theta$, matching the multiplier route. **The unitality trap does not fire either**, read at source: Krasnov–Tkachev's *Euclidean metrised algebra* is their (48) plus positive-definiteness, carrying no unit.

| id | step attacked | mechanism | support |
|---|---|---|---|
| **E1** | *"$\theta>0$ is automatic at a maximiser"* | argued for the **global** maximiser alone, while consumers apply L24 at **local** ones. The chordal argument reaches $\theta\ge0$ and **the $\theta=0$ branch has no argument on file**, where $e$ and hence the statement are undefined, while [LEDGER.md](../findings/LEDGER.md) records it as closed | v155, v157 |
| **E2** | the scope paragraph's citation of [L51](../findings/second-order.md) | invoked at $\theta<0$, outside L51's own stated $\theta>0$. *The conclusion survives, L51's proof of the three consumed facts being sign-free; the citation does not* | v155, v157 |
| **E3** | the sharpness clause's citation of [L32](../findings/isotropy-cap.md) | L32 is marked **REFUTED AS STATED** on the record and concerns *bivector* centralisers rather than Weyl-tensor stabilisers, decorative, and to be deleted, the conclusion needing nothing from it | v155, v157 |
| **E4** | [krasnov-tkachev notes.md](../references/krasnov-tkachev-2018-idempotent-variety/notes.md) | glosses *extremal idempotent* as a **local** maximum where Definition 6.4 and the minimal-norm remark say **global**. Witness: $S^4\times S^4$ at $n=8$ with $\lVert c\rVert^2=16/21$ against padded $W_{\mathbb{CP}^2}$'s $2/3$. **And a second misprint alongside the $c\otimes c$ one already on file**: the notes' verbatim $\sigma(c)\subset(-\infty,\tfrac12]$ contradicts the paper's own $1\in\sigma(c)$, and the pointer *"(their (19))"* is to an unrelated syzygy | v155, v157 |
| **E5** | four wordings | *"maximizer"* wants *local*; *"the Hessian of $P$ restricted to the unit sphere"* admits a parse false by $3\theta\,\mathrm{Id}$; *"$\theta>0$ enters at exactly one place"* undercounts; and $T(X,Y,Z)=\langle X\circ Y,Z\rangle$ is untabled in [conventions.md](../findings/conventions.md), where $T$ already carries two senses | v155 |
| **E6** | [second-order.md](../findings/second-order.md)'s introductory paragraph, **LIVE** | it still asserted *"at $\mathfrak u(2)\subset\mathfrak{so}(4)$, $\theta=-0.866$ and the inequality reverses (Reviewer 27)"*, verbatim what the canonical block thirteen lines below refutes three ways, unmarked, so a reader taking the criterion from the top carried away a refuted witness with a reviewer's name on it. **Repaired in this round** | v156, v157 |
| **E7** | [bounds-relaxations.md](../findings/bounds-relaxations.md)'s *"And that settles what the route is worth"* | it restated $\lambda_{\max}(L_e\vert_{\mathcal D})=1$ unqualified, **the exact step [L115](../findings/bounds-relaxations.md) grades a `GAP` eighteen lines above**, L24's cap living on $\mathcal W_n\cap W^\perp$ while $\mathcal D$'s elements are generically neither trace-free nor Bianchi | v156 |
| **E8** | [results.md](../results.md)'s landscape bullet | *"at every critical point"* needs $\theta\ne0$, since $e=W/\theta$ is undefined otherwise | v156 |

## The object v157 built, and it strengthens the record

**At $S^2\times S^2\subset\mathcal W_4$ the splitting $\mathcal W_4=\mathcal W^+\oplus\mathcal W^-$ is $\circ$-orthogonal, so $Q(W^\pm)=\theta W^\pm$ separately and $Z=W^+-W^-$ is an exact $1$-eigenvector of $L_e$ lying in $W^\perp$.** That is a closed-form proof that *maximiser* cannot be weakened to *critical point*, a hypothesis the record asserted and never witnessed. It replaces the refuted $\theta$-sign claim at line 19 as the reason the hypothesis is load-bearing.

**The factor $6\theta$ and the $-3\theta\,\mathrm{Id}$ are confirmed three ways**, the Lagrange multiplier at $\mu=\tfrac32\theta$, the sphere's second fundamental form, and Krasnov–Tkachev's own equation (56) evaluated at $c$, which runs in the *source's* normalisation and so rules out a lost factor.

## Withdrawn by v155, so the round does not re-spend them

The L24/L125 circularity; $\ker W\ne0$ and padded objects; $n=4$ as a counterexample, the $\lambda_{\max}=1$ point is a saddle and $M(4)=\sqrt{3/2}>\sqrt3/2$; odd and small $n$; and the unitality trap.

## The consumer sweep

**No live misuse across the 55 citations.** Every risk the brief named (application at a bare critical point, application off $W^\perp$, the premise inverted), is already on the record with a correction attached, at [bounds.md](../findings/bounds.md), [bounds-relaxations.md](../findings/bounds-relaxations.md) and [target.md](../findings/target.md). **The one unrecorded exposure is that the local-maximality contrapositives inherit E1's $\theta=0$ debt.**

## Adjudication

**Verdict `PROVEN, hypotheses corrected`, repaired. Impact `CONTAINED`.** All three verifiers returned the same verdict, and the mathematics is the strongest result any round has produced this session: **the Hessian identity is confirmed by four independent routes**, the Lagrange multiplier at $\mu=\tfrac32\theta$, the sphere's second fundamental form $\mathrm{II}(V,V)=-\lVert V\rVert^2W$, a great-circle expansion carrying no multiplier at all, and Krasnov–Tkachev's own equation (56) evaluated at $c$ in the *source's* normalisation, which rules out a lost factor. Self-adjointness, the invariance of $W^\perp$, the bound, the simplicity of $1$ and the splitting corollary all close, and **both twice-repaired passages survive**.

**Every defect is in the apparatus around the theorem.** Two live restatements of things the same files declare refuted or gapped; three citations pointing at results that do not say what they are cited for; one reference note inverting its source's own quantifier; and one genuine debt.

### The debt, and it is the round's only mathematical one

**Nothing on file excludes a local maximiser with $\theta=0$**, where $e=W/\theta$ and the whole statement are undefined. The scope argument closes $\theta<0$ by the chordal curve and reaches $\theta>0$ only at a *global* maximiser; the middle branch is untouched, and [LEDGER.md](../findings/LEDGER.md) recorded the question as closed. **What would close it is that no real $2$-nilpotent of $\mathcal W_n$ is a local maximiser.** No consumer is known to depend on it, and the local-maximality contrapositives are where it would land.

### The object the round gained

**At $S^2\times S^2\subset\mathcal W_4$, $Z=W^+-W^-$ is an exact $1$-eigenvector of $L_e$ lying in $W^\perp$**, the $\circ$-orthogonal splitting $\mathcal W_4=\mathcal W^+\oplus\mathcal W^-$ giving $Q(W^\pm)=\theta W^\pm$ separately. *A critical point at which the bound fails by a factor of two, in closed form.* The record had asserted that *maximiser* cannot be weakened to *critical point* and defended it with a claim about the sign of $\theta$ that is impossible; it now has the witness instead. **$S^3\times S^3$ supplies the complement**, the bound is met there and the point is still a saddle, so the condition is necessary and not sufficient.

### The repairs, all applied

| finding | what changed |
|---|---|
| E6 | the refuted $\theta$-sign claim deleted from the entry point and replaced by the $S^2\times S^2$ witness for the hypothesis it was defending |
| E1 | the scope paragraph now separates the global branch from the local one, names $\theta=0$ as owed and says what would close it; the [ledger](../findings/LEDGER.md) row that read as closing the question now closes the one branch it closes |
| E2 | the L51 citation carries the line that its proof of the three consumed clauses is sign-free |
| E3 | the L32 citation deleted; sharpness now runs on the equivariance identity alone, which is all it needed |
| E4 | the reference notes corrected to *global*, the *"(their (19))"* pointer removed, the second misprint recorded beside the first, and the absence of a unit hypothesis stated with its line numbers |
| E5, E8 | *local* maximiser in both statements, *Riemannian* Hessian with the $-3\theta\,\mathrm{Id}$ named, $\theta>0$'s two consuming places counted, and $T$'s third sense tabled |
| E7 | the unqualified restatement replaced by what L115 actually licenses (coordinate-diagonal global maximisers and $S^m\times S^m$ at $m\ge4$), with the residual obligation named |

### Queued elsewhere

**Research loop.** Whether a real $2$-nilpotent of $\mathcal W_n$ can be a local maximiser, which closes E1's branch. And the cap on $\lambda_{\max}(L_W\vert_{\mathcal W_n^\perp})$ that L115 needs, which is nowhere on the record.
