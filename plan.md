# The plan

## Goal

Prove that $P(W)=\langle W,Q(W)\rangle$ on $\{\lVert W\rVert=1\}\subset\mathcal W_n$ is maximized by the Weyl tensor of $S^{n/2}\times S^{n/2}$ for even $n\ge12$, granting the diagonal case. Stated in full in [README.md](README.md).

## Gate 2 in flight and Gate 2 owed

**NOTHING IN FLIGHT.** *The latest rounds, [r1910](reviews/REVIEW_r1910.md), [r1911](reviews/REVIEW_r1911.md), [r1913](reviews/REVIEW_r1913.md) and [r1915](reviews/REVIEW_r1915.md), are folded.*

**[LEDGER.md](findings/LEDGER.md) owns the Gate 2 debt and every landed verdict, and is the only place either is written.** *It carries all thirty-eight landed rounds with what each corrected, and the count of blocks still marked `Gate 2 pending` in the findings.*

## Lean owed, and validation owed

**[plan-lean.md](plan-lean.md) owns the Lean layer's open debts and is GENERATED from the layer**, so a debt leaves it when the debt goes and nobody prunes it. **Regenerate with `python3 scripts/misc/lean_debts.py` before reading it**, since a generated file goes stale silently and this one had drifted by three days when it was last checked.


**Validation owed** is [LEDGER.md](findings/LEDGER.md)'s, beside the Gate 2 debt.


## The step 9 decisions

- **2026-09-28p**: the [sweep aimed at the coupling](reviews/2026-09-28p-LIT-step8-sweep.md) found no mechanism, every named one closed, so [I123](#section-1-advance-the-proofs) is regraded to `attackable` $0$ and kept as the destination, and [I117](#section-1-advance-the-proofs) is the pick.
- **2026-09-28, the user's decision** (relayed by the manager): [I124](#section-1-advance-the-proofs) by [R57](routes.md) is primary, then [R58](routes.md), then [R59](routes.md), with [I123](#section-1-advance-the-proofs) secondary throughout; the $n$-parametric certificate waits behind both analytic routes.

The earlier route choices, the 28k and 28n sweeps among them, are in [routes.md](routes.md) and [ATTEMPTS.md](ATTEMPTS.md).

## Where the proof stands

**The Lean loop now runs in its own session, off [plan-lean.md](plan-lean.md)'s coverage table.**

**PRIMARY, [I124](#section-1-advance-the-proofs) by [R57](routes.md)**, the user's decision of 2026-09-28, then [R58](routes.md), then [R59](routes.md). **SECONDARY, [I123](#section-1-advance-the-proofs)**, at `attackable` $0$ since the [28p sweep](reviews/2026-09-28p-LIT-step8-sweep.md). [I117](#section-1-advance-the-proofs), statement H, stays live. **BLOCKED: [I73](#blocked), [I121](#blocked)**.


## SECTION 1, ADVANCE THE PROOFS

> **The route register [routes.md](routes.md) is the owner of every route's status**, and the primary is [R57](routes.md), [I124](#section-1-advance-the-proofs)'s, by the user's decision of 2026-09-28, with [R58](routes.md) and [R59](routes.md) queued behind it in that order. *Earlier primaries (R30, R24, R17) and what each still owes are in the register.*

> **THE IDENTIFIER STANDARD, settled 2026-09-03.** **One owner per class, one meaning per prefix, and no class shares a letter with another.**
>
> | class | id | owner |
> | --- | --- | --- |
> | results. Lemma, Observation, Conjecture | `L<n>`, sub-results `L<n>.<k>` | [findings/INDEX-results.md](findings/INDEX-results.md) |
> | fence posts | `F<n>` | [findings/INDEX-traps.md](findings/INDEX-traps.md) |
> | warnings | `W<n>` | [findings/INDEX-traps.md](findings/INDEX-traps.md) |
> | routes | `R<n>` | [routes.md](routes.md) |
> | standing method rules | `M<n>` | [findings/LEDGER.md](findings/LEDGER.md) |
> | reviewers | `r<n>` | [reviews/INDEX.md](reviews/INDEX.md) |
> | **plan items** | **`I<n>`, splits `I<n><letter>`** | **this file** |
>
> **NEXT ITEM ID: `I125`.** *This line is the only thing a new item needs.* **Assign the next id, increment this line, and never reuse a number**, an id is a permanent address, so a deleted item's number stays spent and a retired one keeps its own. *The mark DRIFTED on 2026-09-23 and was advanced past the true high water; what happened and why the "it cannot drift" clause was false is in [ATTEMPTS.md](ATTEMPTS.md) under that date.*

> **`I` is for item, and a plan item never takes a result's number**: an item is work and a result is a claim, so a reader following a citation lands on one of them without guessing. *The 2026-09-03 migration that cleared the collisions is in [ATTEMPTS.md](ATTEMPTS.md) under that date.*

> **Every live item of this section carries a row below.** *That was not true until 2026-09-13; the pass that fixed it is in [ATTEMPTS.md](ATTEMPTS.md) under that date.*

| item | moves | closes | attackable | margin | analytic | value |
| --- | --- | --- | --- | --- | --- | --- |
| **I124** | **settles the goal** with [L57](findings/problem.md): every non-diagonal critical point with $\theta\ge\theta_0(n)$ has an ascent direction ([R57](routes.md), the user's decision of 2026-09-28). *`attackable` $2$: [L24](findings/second-order.md)'s bound and the slack witness are in hand, three constructions are eliminated on the subalgebra family, and a collective direction in a nontrivial $K$-module is named and untried. `margin` $1$: padded $W_{\mathbb{CP}^2}$ saturates L24 at $\sqrt{3/2}$, $1\%$ below $\theta_0(12)$.* | 3 | **2** | 1 | 1 | **6** |
| **I117** | **adds** the sharp $\#$ half of P, a node on the path to P (the [2026-09-26e sweep](reviews/2026-09-26e-LIT-step8-sweep.md)'s pick). *`attackable` $1$: H needs only U$_{\mathrm s}'$ ([L270](findings/second-order.md)). On the torus family it is proved for $2m\ge14$ ([L276](findings/second-order.md)), with $2m=12$ open at one case, and on $\mathfrak{so}(2m+1)$'s for $m\ge7$ ([L281](findings/second-order.md)). Off the torus family no method stands ([L273](findings/second-order.md)).* | 2 | **1** | 1 | 1 | **2** |
| **I115** | **settles** [I114](#blocked) and **adds** the sharp $\#$ half of P at even $n$: statement H, via [R42](reviews/2026-09-26d-LIT-step8-sweep.md), chosen on the [2026-09-26d sweep](reviews/2026-09-26d-LIT-step8-sweep.md) *`attackable` $1$: any proof of H proves the sharp $\#$ half of P ([phase 3](reviews/2026-09-26d-LIT-step8-sweep.md)).* | 2 | **1** | 1 | 1 | **2** |
| **I36** | **settles the goal** via [L57](findings/problem.md), split into two links, and **stands on [I73](#section-1-advance-the-proofs)**: I75's remaining content is $s\le2$, which is I73, and I74 is blocked on an unbounded census. *Ranks below I73, the warrant outranking what stands on it ([r1081](reviews/REVIEW_r1081.md)).* | 3 | **1** | 1 | 1 | **3** |
| **I111** | **settles** [I104](#section-1-advance-the-proofs)'s far region. *Closed 2026-09-22 on the equal-$u$ ansatz; the lift has no named route ([r1080](reviews/REVIEW_r1080.md)) and its gain closure is a numerical minimax ([note](reviews/2026-09-14-I104-tau-positive.md)), so `analytic` $0$.* | 2 | **1** | 1 | 0 | **0** |
| **I106b** | **splits** the node: the rung at general $\lvert J\rvert$. *`attackable` $1$ since [r1058](reviews/REVIEW_r1058.md): the Jin route's part (iii) reaches no declaration, and $f''_{Jin}=2f''_{frozen}+8X$, $X\ge0$, points the needed implication uphill.* | 2 | **1** | 1 | 1 | **2** |
| **I100** | **splits** the far region at the $t$-maximising frame: the single-four-set case reduces to (J), which is [I101](#section-1-advance-the-proofs); the mixed case waits on a pair-block analogue of $e$ under the frame condition, *no route yet* | 2 | **1** | 1 | 1 | **2** |
| **I71** | **adds** a node: the $N-1$ uncontracted criticality rows, *REGRADED 2026-09-10 DOWN FROM $9$, on this cycle's own evidence rather than on an argument* | 2 | **1** | 1 | 1 | **2** |
| **I89** | **the R23 payoff, now with NO off-the-shelf method**: the spectrum separates (I87) but the algebra is not medial (I88), so Krasnov--Tkachev's classification is unavailable and a criterion pinning the maximiser must be invented | 2 | **1** | 1 | 1 | **2** |
| **I68** | **adds** a node: a rank bound at every non-diagonal critical point, *the step 9 route was worked to its end on 2026-09-10 and retired, so no method again* | 2 | **1** | 1 | 1 | **2** |
| **I76** | **open; the integrality defect does not decide it**: at two eigenvalues every orthonormal basis of $A$ is an eigenbasis, and at $n=5$ the degree-two vertices of $C_5$ give a pencil at every vertex. *Open: a configuration with all pairwise traces strictly below $1$, which needs a derivation about $A$.* | 2 | **1** | 1 | 1 | **2** |
| **I77** | **adds** a node: the (B) repair is refuted at $W_{\mathbb{CP}^2}\oplus W_{\mathbb{CP}^2}$; the pair cap binds ([r1053](reviews/REVIEW_r1053.md)), $n=12$ maximum $2.42212$ on screen; the three-nonzero-eigenvalue family is closed at $\sqrt{3/2}$ | 2 | **1** | 1 | 1 | **2** |
| **I6** | **adds** a node: the interior scenario as a perturbed criticality equation | 2 | 1 | 1 | 1 | **2** |
| **I123** | **settles the goal**: a coupling of P's two halves on the Weyl subspace, exact on the products ([R56](routes.md)). *`attackable` $0$ since the [28p sweep](reviews/2026-09-28p-LIT-step8-sweep.md): every named mechanism is closed (the invariant linear lifts, the lift family between H and P, the functional change, the cone form). The destination, no route known.* | 3 | **0** | 1 | 1 | **0** |
| **I104** | **settles** the overlapping four-set stratum with $\tau>0$, the last four-set case L221 leaves *REGRADED 2026-09-17 after [r986](reviews/REVIEW_r986.md) and [r987](reviews/REVIEW_r987.md): the $x\to\kappa_i$ link is real and too small, so no named method remains open.* | 1 | **1** | 1 | 1 | **1** |
| **I81** | **IDENTIFIED with [R11](routes.md)'s missing object rather than new**: excess $=0$ IS Morse–Bott nondegeneracy, so positive excess at a maximiser is exactly the degenerate local maximum R11 has waited on and nobody has exhibited. *What is owed is a CLASSIFICATION of critical points of orbit dimension below $2n$, not a bound* | 1 | **1** | 1 | 1 | **1** |
| **I74** | **settles** the frame half of [I36](#section-1-advance-the-proofs), whose target now has THREE equivalent forms, and it is regraded down the same day: all three off-diagonal criticality families are accounted for and none is an independent input, so a mechanism must be invented | 1 | **1** | 1 | 1 | **1** |
| **I75** | **splits** [I36](#section-1-advance-the-proofs): its unnamed FIRST link, that a maximiser carries an orthonormal decomposable eigenbasis, which fails at $W_{\mathbb{CP}^2}$ at the threshold itself | 1 | 1 | 1 | 1 | **1** |
| **I95** | the sweep's bookkeeping: post F67, that five sweeps hold no method, and the sectional identity $\theta^2=4\max_{x\perp e}K(e,x)$ as a numbered result. *A finding, not a route* | 0 | 3 | 1 | 1 | **0** |
| **I1** | **the goal itself** | 2 | 0 | 1 | 1 | **0** |
| **I37** | **closes the half [I1](#section-1-advance-the-proofs) does not**, the $S>0$ critical points, which no item covered until 2026-09-06 | 2 | 0 | 1 | 1 | **0** |
| **I3** | **settles** the competitor scenario, *but four formulations are refuted and its payoff is gated* | 2 | **0** | 2 | 1 | **0** |
| **I4** | **settles the goal outright**, *but only with (a), which is fenced with no live handle* | 2 | **0** | 1 | 1 | **0** |
| **I7** | **settles the goal**: $\theta\le\sqrt{3/2}$ on the compact non-pure set, *the destination, with no route known* | 3 | **0** | 1 | 1 | **0** |

> **THE REMAINING OPEN STATEMENT IS $\theta\le\sqrt{3/2}$ AT EVERY NON-DIAGONAL CRITICAL POINT**, in two halves: the $S=0$ half, [I1](#section-1-advance-the-proofs) and [I7](#section-1-advance-the-proofs), and the $S>0$ half, [I37](#section-1-advance-the-proofs). *Every other piece of Problem P is proved: the diagonal case outright at every $n\ge4$, and the symmetric-space case for every $n\ge12$.* **`closes` is graded against this statement and nothing else.**

**Why every item that would settle the open statement scores $0$ on `attackable`, and what was done about it**: the 2026-09-13 regrade, R24's invention and the refutation of its endgame as [post F67](findings/fence-posts.md) are recorded in [ATTEMPTS.md](ATTEMPTS.md) and in the [register](routes.md), which own them.


**Domains of every borrowed quantity are named in [LEDGER.md](findings/LEDGER.md#domains-of-the-borrowed-quantities), and a route states each one's domain before its grade is written.** *A mechanism that evaluates a quantity outside its domain is refused at the grading step rather than discovered at the audit.*


- [ ] **I124, ASCENT AT EVERY NON-DIAGONAL CRITICAL POINT ABOVE $\theta_0$.** *Theorem: every non-diagonal unit critical point with $\theta\ge\theta_0(n)$, $n\ge12$, has $v\perp W$ with $\langle v,L_ev\rangle>\tfrac12\lvert v\rvert^2$; with [L57](findings/problem.md), P.* Grade **6** ($3\times2\times1\times1$), [R57](routes.md), primary by the user's decision, then R58, then R59, with [I123](#section-1-advance-the-proofs) secondary. Statement typed as `I124` ([I124Statement.lean](lean/HamiltonsCubic/Results/I124Statement.lean)). **Where it stands** ([note](reviews/2026-09-28q-I124-ascent.md), batches 1 to 10, all through Gate 2): in a frame, $W=a\hat A+N$; the circle toward the diagonal part descends; a single sign character is closed in both branches ([L220](findings/second-order.md), [L224](findings/second-order.md)); with $\hat A$ critical, $W$ is padded from the indices $N$ touches, so at most five put it below $\theta_0$ ($M(6)$ to $M(11)$ have no ceiling); and every unit $W$ has $P(W)\le\Theta_n+P(N_F)$ in every frame (new), so a counterexample has positive off-diagonal cubic in every frame. **Next step**: $N$ over two or more sign characters, the record's R27 rungs ([I106b](#section-1-advance-the-proofs)) and [I104](#section-1-advance-the-proofs), attacked with $\theta\ge\theta_0$ in hand; the concrete lever is a frame with $P(N_F)\le0$ at a point above $\theta_0$, from maximality and exact at the balanced product.
- [ ] **I117, THE $\#$ HALF OF P BY STATEMENT H.** *Theorem: the $\#$ half is maximised at the balanced product.* Grade **2** ($2\times1\times1\times1$). H reduces to U$_{\mathrm s}'$ ([L270](findings/second-order.md)), and on each simple $\mathfrak h$ to a trace lower bound. **Settled for H**: the $\mathfrak{so}(k)$, $\mathfrak{su}(k)$ torus families at $n\ge14$, $\mathfrak g_2$, $\mathfrak{sp}(2)$, $\mathfrak{sp}(3)$ ([L286](findings/second-order.md)), every embedding with $j^2\ge\tfrac34h^\vee$ ([L287](findings/second-order.md)). **Owed**, all at index one: $\mathfrak{so}(12)$'s $m=6$ MW', $\mathfrak{sp}(k)$ for $k\ge4$, off the torus [R49](routes.md) ([note](reviews/2026-09-28l-I117-g2-torus.md)).
- [ ] **I123, A COUPLING OF P'S TWO HALVES ON THE WEYL SUBSPACE.** *Theorem: P by one inequality using both halves at one tensor.* Grade **0** ($3\times0\times1\times1$), route [R56](routes.md), the destination with no route known since the [28p sweep](reviews/2026-09-28p-LIT-step8-sweep.md). **Closed**: every $O(n)$-invariant linear enlargement of the Weyl subspace, and every lift $s\operatorname{tr}X^3+\langle X^\#X,X\rangle$, $s\in(0,1]$, misses the balanced product ([note](reviews/2026-09-28o-I123-coupling.md)). **Under H, P is owed only where $\operatorname{tr}W^3>t_0$.**
- [ ] **I115, STATEMENT H: THE FROBENIUS NORM OF HAMILTON'S $\#$ ON $\operatorname{Sym}^2\mathfrak{so}(n)$ IS $(n-2)/\sqrt N$, $n\ge9$.** *Theorem: $\langle X\#X,X\rangle\le\frac{n-2}{\sqrt N}\lVert X\rVert^3$.* Grade **2** ($2\times1\times1\times1$), route R42, reach gate fired on the [2026-09-26d sweep](reviews/2026-09-26d-LIT-step8-sweep.md). **Proved** ([L259](findings/second-order.md)): equality at $I$ and every involutive automorphism, H outside a trace window of idempotents. **Gives** [I114](#blocked) and [I117](#section-1-advance-the-proofs). **Current step**: worked through I117's U$_{\mathrm s}'$. **Falsifier**: a symmetric $X$ at $n\ge9$ with ratio above $1$.
- [ ] **I36, every local maximiser above $\sqrt{3/2}$ is coordinate-diagonal.** *Theorem: then [Lemma L57](findings/problem.md) finishes.* Grade **3**, ranked below [I73](#section-1-advance-the-proofs), its warrant. Route [R18](routes.md), detail in [diagonal-half.md](findings/diagonal-half.md)'s I36 section. **Owed**: the variational step's reach, R18's (b) and (c), gated on [I74](#section-1-advance-the-proofs) and [I75](#section-1-advance-the-proofs).
- [ ] **I111, THE $x_i<0$ REGIME, BOTH BRANCHES CLOSED ON THE EQUAL-$u$ ANSATZ**, successor to [I110](#done). *Theorem: step 8's second link gives up at least $0.0148730$ across the surviving region, closing [I104](#section-1-advance-the-proofs)'s $\tau>0$ case.* Grade **0** ($2\times1\times1\times0$), closed 2026-09-22 at [post F75](findings/fence-posts.md). **Owed: lifting the ansatz**, whose gain closure is a seven-dimensional numerical minimax (invertibility lifts, `surviving_block_invertible`), so it is worked only by the user's choice. **Falsified by** a surviving configuration off the ansatz with $\theta>\sqrt{3/2}$.
- [ ] **I106b, THE RUNG AT GENERAL $\lvert J\rvert$.** *Theorem: the maximum of R28's value over the COUPLED pair sits at a splitting frame.* Grade **2** ($2\times1\times1\times1$). **Commuting case closed, coupled pair open** against [post F69](findings/fence-posts.md), the Jin route CLOSED by [r1058](reviews/REVIEW_r1058.md). **Owed**: a condition using MAXIMALITY rather than criticality, no route. *Declarations in [lean/INDEX.md](lean/INDEX.md)'s I106b row, chronology in [ATTEMPTS.md](ATTEMPTS.md), derivations in the [working note](reviews/2026-09-17-I106b-face.md).*
- [ ] **I100, THE FAR REGION AT THE $t$-MAXIMISING FRAME. SPLIT 2026-09-14.** Its single-four-set case is [L220](findings/second-order.md), Gate 2 passed; the rest is [I104](#section-1-advance-the-proofs). *Detail in the [derivation](reviews/2026-09-14-I100-derivation.md).* Grade **2** ($2\times1\times1\times1$), moves: **splits**.

- [ ] **I71, the $N-1$ UNCONTRACTED criticality rows.** *Theorem: a constraint on $\theta$ at every critical point of every rank, from the diagonal of $Q(W)=\theta W$ read row by row.* Grade **2** ($2\times\mathbf1\times1\times1$), *regraded 2026-09-13: the only admissible lever, $\sum_k\lambda_k^2g_k$, is not tied to the conjecture.* **Owed: what the rows give at rank five and above**, free there by [L72](findings/stratum-two-negative.md#lemma-l72-the-rank-3-stratum-is-overdetermined-and-its-converse-clause-closes-in-three-lines)'s count, at [bounds.md](findings/bounds.md#what-the-uncontracted-rows-still-owe). *The regrades are in [ATTEMPTS.md](ATTEMPTS.md).*

- [ ] **I89, does the algebra structure pin the maximiser analytically, NOW WITHOUT THE CLASSIFICATION?** *Theorem it would produce: a criterion from the Fox algebra's structure identifying the balanced product among idempotents, readable by hand.* Grade **2** ($2\times1\times1\times1$), attackable **1**: Krasnov--Tkachev's classification assumes mediality and the algebra is not medial ([I88](#done)). **The spectrum separates ([I87](#done)) and non-isospectrality alone does not pin the maximiser, so a route must be invented.** *Detail at [nondegeneracy.md](findings/nondegeneracy.md)'s L207 corollary.* **Distance to P**: the separation itself, with no known mechanism.

- [ ] **I68, why a maximiser must have low $\Lambda^2$-rank.** *Theorem: a bound $\operatorname{rank}(W:\Lambda^2\to\Lambda^2)\le r$ at every non-diagonal critical point above $\sqrt{3/2}$.* Grade **2** ($2\times1\times1\times1$), `attackable` at $1$: three routes in are closed, at [F63](findings/fence-posts.md), at [F43](findings/fence-posts.md)'s kernel-free witness, and at the first step 9 of 2026-09-10, so a method must be invented. *If [I73](#section-1-advance-the-proofs) closes, this is subsumed. Detail in [diagonal-half.md](findings/diagonal-half.md).*

- [ ] **I76, is a two-eigenvalue critical point of the decomposable locus coordinate-diagonal?** *Theorem: yes would put the whole two-eigenvalue case inside the granted half, so the open half carries at least three distinct eigenvalues.* Grade **2** ($2\times1\times1\times1$), the integrality-defect test known not to decide it.

  **Where it stands.** *Settled affirmatively at $n=4$ by chirality parity and at $n=5$ by the two-removal count, which forces $(a-1)(2a-n)=2n$ and admits $a=\tfrac n2$ or $a\ge\tfrac n2+2$.* **Owed: $n=6$, and at $n=5$ whether the divisible degree admits a non-coordinate configuration.** *The isotropy of $\Theta$, its equivalence to two-valued Ricci-flatness, the graph dictionary, the rank counts and the pentagon's $\theta=0$ are all in [diagonal-half.md](findings/diagonal-half.md)'s I76 block.*

- [ ] **I77, the triangle-type linear programme at three or more eigenvalues.** *Theorem: a bound on $\theta$ over the decomposable locus from $T$'s marginal and relation (B) alone.* Grade **2** ($2\times1\times1\times1$). **LIVE**; the pair cap binds ([r1053](reviews/REVIEW_r1053.md)), screened to $2.42212$ at $n=12$. **Owed**: that bound derived and typed, by a finite hand vertex enumeration. *Detail in the I77 block of [diagonal-half.md](findings/diagonal-half.md).*

- [ ] **I6, the interior scenario as a perturbed criticality equation.** *Theorem it would produce: the pair and four-set clauses of $Q(W)-\kappa\nabla\delta^2=\theta'W$, satisfied by every interior critical point of $\Phi_\kappa$, compared with [post F47](findings/INDEX-traps.md)'s clauses for the unperturbed equation.* Grade **2** ($2\times1\times1\times1$) *Analysis in [ATTEMPTS.md](ATTEMPTS.md#i6-the-interior-scenario-as-a-perturbed-criticality-equati).*

- [ ] **I104, $\tau>0$ ON OVERLAPPING FOUR-SETS.** *Theorem: every unit critical point in $\mathcal D_n\oplus V_{Q_1}\oplus V_{Q_2}\oplus V_{Q_1\triangle Q_2}$ with two nonzero block components and $\tau>0$ has $\theta^2\le\tfrac65$.* Grade **1** ($1\times1\times1\times1$); [R41](routes.md) opened and closed 2026-09-26. **Settled** for $\tau\le0$ ([L221](findings/second-order.md)) and for $\tau>0$ on the equal-$u$ ansatz ([I111](#section-1-advance-the-proofs)). **Owed: the ansatz lift**, I111's open half ([note](reviews/2026-09-14-I104-tau-positive.md)).

- [ ] **I81: the classification of critical points of small orbit dimension. IT IS [R11](routes.md)'S OBJECT, NOT A NEW ONE.** *Theorem: a classification of critical points with orbit dimension below $d^\ast(n)\approx2n$, or positive excess at every local maximiser above $\sqrt{3/2}$.* Grade **1** ($1\times1\times1\times1$), moves: **splits** R11.

  *Grade $1$: positive excess at a maximiser is the degenerate local maximum R11 needs and nobody has exhibited ([post F65](findings/fence-posts.md), [L207](findings/nondegeneracy.md)).*

  **Owed.** *The classification among objects that are NOT two-factor sphere products, since [L207](findings/nondegeneracy.md) settles that family completely; and a lower bound on the orbit dimension at $n\ge9$, needing the classification of connected subgroups of codimension at most $n-1$.*

- [ ] **I74, integrality at a critical point, the frame half of [I36](#section-1-advance-the-proofs).** *Theorem: then [Lemma L201](findings/diagonal-half.md) puts the point in a frame and [Lemma L57](findings/problem.md) finishes.* Grade **1**, **no mechanism**. **Gate 2 PASSED on its bridge and Gram blocks** ([r997](reviews/REVIEW_r997.md), [r998](reviews/REVIEW_r998.md)), *the bridge now basis-free and the narrowing's payload withdrawn: NO family forces integrality of a chosen eigenbasis.* **OPEN DECISION**: whether $\ker S\ne0$ is impossible off the integral locus would close the item, and deciding it is an unbounded census.

  *No criticality family is an independent input ($[W,W^\#]=0$ restates criticality); the three equivalent forms and the $\Theta$ equation are in [diagonal-half.md](findings/diagonal-half.md)'s I74 block.*

- [ ] **I75: [I36](#section-1-advance-the-proofs)'s unnamed FIRST link, that a maximiser carries an orthonormal decomposable eigenbasis.** *Theorem: at a critical point above $\sqrt{3/2}$, $\mathrm{Alt}(W^k)=0$ for every $k$.* Grade **1** ($1\times1\times1\times1$). **A FINITE LIST**: exactly $\max(s-2,0)$ conditions at $s$ distinct eigenvalues, on the CONSECUTIVE block $k=2,\dots,s-1$, VANISHING at $s=2$, so [I73](#section-1-advance-the-proofs) carries it. **Gate 2 PASSED** ([r995](reviews/REVIEW_r995.md), [r996](reviews/REVIEW_r996.md), agreeing). *It still lacks any bound on $s$ at a maximiser, which is the whole of what is owed.*

- [ ] **I95, the sweep's bookkeeping: post F67 and the sectional identity.** *Both stated in [the sweep](reviews/2026-09-13b-LIT-step8-sweep.md), batches 4 and 5: five sweeps hold no method, and $\theta^2=4\max_{x\perp e}K(e,x)$ at every critical point.* Grade **0** as a route, a finding owed regardless. *Route: one findings block, one post row, one numbered Observation with its screen.*

- [ ] **I1, $\theta\le\sqrt{3/2}$ on the non-pure critical set. THE PROBLEM ITSELF, worked whatever it grades.** *Theorem: $\sup\{\theta:Q(W)=\theta W,\ S=0,\ W\text{ non-diagonal}\}\le\sqrt{3/2}$.* **It covers the $S=0$ half of the critical set and not Conjecture A**, the split and why it is there being at [From I37](findings/ungraded-slack.md#from-i37); the other half is [I37](#section-1-advance-the-proofs). Grade **0** ($2\times0\times1\times1$), the zero being *attackable*, and **it is listed first anyway.**

  *Working notes in [target.md](findings/target.md#from-i1).*

- [ ] **I37, no non-diagonal critical point with $S>0$ reaches the ceiling.** *Theorem: every non-diagonal critical point with $S>0$ has $\theta<\theta_0(n)$.* **The constant the old statement carried is gone**, and why is in [From I37](findings/ungraded-slack.md#from-i37): the critical values are finite, so uniformity is free and the item is non-attainment. Grade **0** ($2\times0\times1\times1$), the zero being *attackable*, the reframing sharpens the target and supplies no mechanism.

  **Falsifier:** such a point, which also refutes Conjecture A.

- [ ] **I3, a local quadratic ceiling on the defect at the competitor. FOUR FORMULATIONS REFUTED; the fallback condition is met.** *Theorem it would give: $\delta^2(W)\le\tfrac19+\beta\,d(W,u)^2$ near $SO(n)\cdot u$ with $\beta\le\theta^*/(2\lvert\kappa_n\rvert)$, closing [I3](#section-1-advance-the-proofs) for every $n\ge12$.* Grade **0** ($2\times\mathbf0\times2\times1$), the zero being *attackable*.

  *Working notes in [route-a.md](findings/route-a.md#from-i3).*

- [ ] **I4, the lifted Jäger chain, [R17](routes.md): the one unfenced route to the target.** *Theorem: $P(W)\le\theta_0(n)+\kappa_n\delta^2$ on the unit sphere, $\delta^2=\lVert\mathrm{Alt}(W_-)\rVert^2$ and $\kappa_n=9(\sqrt{3/2}-\theta_0(n))$, [Conjecture L16](findings/problem.md), which **settles the conjecture outright** for $n\ge12$.* Grade **0** ($2\times0\times1\times1$). **This is now the parent node**: I2, I3 and I6 are its parts, and it is worked directly only when they are.

  *Working notes in [second-order.md](findings/second-order.md#from-i4).*

- [ ] **I7, the destination: $\theta\le\sqrt{3/2}$ on the compact non-pure set. No route known.** *Theorem it would produce: the conjecture.* Grade **0** ($3\times0\times1\times1$) *Analysis in [stratum-two-negative.md](findings/stratum-two-negative.md#i7-the-destination-thetalesqrt32-on-the-compact-non-pure-set-no-route-known).*

  *Working notes in [second-order.md](findings/second-order.md#from-i7).*


## SECTION 2, BUILD WHAT THE PROOFS NEED

**The Lean layer's own debts are listed in [plan-lean.md](plan-lean.md), which is generated from the layer and never edited by hand.** *Two tables: the claims typed and not yet proved, and the ones proved by trusting the Lean compiler rather than the kernel.* **A row leaves that file when the debt leaves**, so it is read rather than maintained, and it is regenerated by [lean_debts.py](scripts/misc/lean_debts.py). *The compiler half is the one that reads as finished and is not: retiring an entry means proving the general-`n` statement and taking the fixed dimension as a corollary, which is a derivation rather than a tactic swap.*


*Ordered by cost: what unblocks the most for the least work comes first. **The four items at the foot of this section. I12, I14, I13, I15, were section 1 items until 2026-09-02**, when the `moves` column was added to the rubric and each scored **none**: every one is a sub-step of [(c) L24 as exclusion](report/sections/diagram.tex) and none turns a node of the map from open to settled. They are build work, and they keep their grades and their detail.*

  **The base layer over $\mathbb R$ at general $n$ is B1, DONE below**; what the layer still lacks, the $\mathrm{id}^\#$ anchor and the $\Lambda^\pm$ splitting as Lean statements, is stated in [lean/INDEX.md](lean/INDEX.md), and a second variation has no $\mathbb Q$-valued definition at any index type, so [I2](#section-1-advance-the-proofs) types over $\mathbb R$ or not at all.

- [ ] **I118, HAMILTON'S `#` ON A GENERAL COMPACT LIE ALGEBRA IN THE LAYER**, a definition over a finite-dimensional real Lie algebra with an invariant inner product, and the results the record states for a general simple $\mathfrak h$ retyped over it: the general symmetric pair of L262 (its block relations derived rather than assumed), a constructive $\mathfrak g_2$ for L263, the exceptional and symplectic cases of L265, and L266 (2)'s support test with a Casimir on invariant subspaces. *The $\mathfrak{so}(n)$ instances are typed now; this item is what makes the general statements typable.*
- [ ] **I119, AN ADJOINT AND AN OPERATOR ABSOLUTE VALUE ON `CurvOp2`** (*the self-adjoint case, which is all the reductions use, is built: `opSk`, `phi_sum_change`, `Ftri_eigen` and `diagOp` in I117Statements.lean prove `L260_psd_cone`; what remains is the non-self-adjoint mechanism, which nothing downstream needs*), from an inner-product structure on `skewSub`, so that L260 (1)'s mechanism $F(X)\le\tfrac12(F(|X^{\mathsf T}|)+F(|X|))$ can be stated; its consequence is typed as `L260_psd_cone`.

- [ ] **I44 and I51, MOVED HERE FROM SECTION 1 on 2026-09-13**, both failing that section's own test: an item there names the theorem it would produce, and each of these says *No theorem* in its own words. *I44 transcribes certificates out of a script and I51 settles which object the competitor is, so both unblock rather than advance, which is what this section holds.*

- [ ] **I44, transcribe [L47](findings/problem.md)'s certificates out of the script.** *No theorem: the eight polynomials and their family assignments exist only in [b_symmetric_dimension_lemma.py](scripts/route-b/b_symmetric_dimension_lemma.py), which computes them at run time and records nothing.* **Three verifiers reproduced the constants by hand and the record still cannot be read.** *Two of the eight shifts are misdescribed as "first admissible rank", both conservatively.*

- [ ] **I51, settle which object the competitor is.** *No theorem: two blocks disagree.* [problem.md](findings/problem.md) distinguishes padded $W_{\mathbb{CP}^2}$ from Fox's $\mathcal S^4(\alpha)$ while [second-order.md](findings/second-order.md) equates them, **and [L17](findings/route-a.md)'s proof commits to the padded reading**, nothing else has the spectrum it runs on. *Raised by [ROUND_L17](verification/ROUND_L17.md); every tube and first-order-protection statement at the competitor inherits the ambiguity.*

- [ ] **I35, an explicit isolation radius for the rigid orbits: PAID AT EVERY SPHERE PRODUCT as [Lemma L216](findings/second-order.md#lemma-l216-an-explicit-isolation-radius-at-every-quantitatively-nondegenerate-critical-orbit), Gate 2 PASSED.** Padded $\mathbb{CP}^2$ is one input away, **conditional on [I54](plan-verification.md)**, its gap and radius stated in L216's corollary (c). Grade **2** ($1\times2\times1\times1$).

  *Working notes in [second-order.md](findings/second-order.md#from-i35).*

- [ ] **I39, retire `native_decide` from the base layer, so the kernel carries what the record says it carries.** *A repair rather than a theorem, here for the reason [I34](#section-2-build-what-the-proofs-need) is.* The debt, its size and where it lands are in [plan-lean.md](plan-lean.md), generated; the route and the cheapest entry are in [lean/INDEX.md](lean/INDEX.md).

  **LAST IN THIS SECTION, AND RANKED BY WHAT IT PROTECTS RATHER THAN BY WHAT IT FREES.** *No result waits on it and no route opens when it closes.* **What it buys is that a row reading `proved` means proved.**

  **Owed**: the entries, then promoting `weak.linter.style.nativeDecide` to an error in [lakefile.toml](lean/lakefile.toml), which lands AFTER the retirement since it breaks the build until the last entry is gone.


- [ ] **I34, audit the canon, all of it, in dependency order.** *No theorem: it is an auditing task, and it is here because a result cited as settled without a recorded verdict is the failure [LEDGER.md](findings/LEDGER.md) opens by naming.* **89 numbered results carry no verdict and every one of them is cited somewhere**, so none is harmlessly unaudited. *The back catalogue's status is unrecoverable by search, two reconstructions were tried and both were wrong, so it is established by auditing rather than recovered.*

  *Working notes in [problem.md](findings/problem.md#from-i34).*

- [ ] **I33, the mixed directions at the balanced orbit, which nothing prices.** *Theorem: a bound on $\lVert A''\rVert$ over $T_{W^* *Analysis in [second-order.md](findings/second-order.md#i33-the-mixed-directions-at-the-balanced-orbit-which-nothing-prices).*

- [ ] **I31, the owed supremum of $\lambda_{\max}p+B_5$, dimension-free.** *Theorem: $\sup_{\lVert W\rVert=1}\big(\lambda_{\max}p+B_5\big)\le K$ for an absolute constant $K$, with $p=\sum_{\lambda>0}\lambda^2$ and $B_5=\tfrac12\big(\sum_\alpha\langle T_\alpha\mu,\mu\rangle^2\big)^{1/2}$, hence $\sup\lvert P\rvert=O(1)$.* *Analysis in [second-order.md](findings/second-order.md#i31-the-owed-supremum-of-lambda_maxpb_5-dimension-free).*

- [ ] **I32, the Pythagorean reading of the Rayleigh split.** *Theorem: $\sup\lvert P\rvert\le1+\sqrt{n-1}$, from the pair cap and the Killing row mass alone, by splitting $M=\operatorname{diag}(\lambda)+\tfrac12u$ with $u$ hollow so the parts are Frobenius-orthogonal and $\lVert M\rVert_F^2\le n-1$.* Proposed by [r445](reviews/REVIEW_r445.md) and **unaudited**; it strengthens [L143](findings/bounds.md) by a factor $1.25$ at $n=12$ for the same two inputs. **Cheap and self-contained, and it changes neither the growth rate nor [post F10](findings/fence-posts.md)'s domination of the whole marginal route**, so it is worth one cycle and no more.

  *Working notes in [second-order.md](findings/second-order.md#from-i32).*

- [ ] **I8, the two remainder constants the tube statements need.** *Theorem: explicit $C_n$ with $\lvert\Phi(\gamma(t))-\theta_0-Q(H)t^2\rvert\le C_nt^3$ near either champion orbit, hence explicit radii $r_n=c_n/C_n$ ([Lemma L141](findings/second-order.md)) and $r'_n$ at the competitor.* Grade **2** ($1\times3\times1\times1$), a section 2 item because it supplies an object rather than moving the map.

  *Working notes in [second-order.md](findings/second-order.md#from-i8).*

- [ ] **I9, every recorded spectral bound as a dual certificate of the pinned LP.** *Theorem: the multiplier vector $(\alpha,\beta,\gamma)$ that turns each of [Lemma L73](findings/bounds.md), the $\Pi$-bound, the $\Sigma$-bound, [Theorem B](reviews/DERIVE-t11.md)'s chord and tangents and I13's two-value bound into one line, multiply (A),(B),(C) by the multipliers, add, observe every type coefficient $F_{ijk}\le0$, together with the balanced-product certificate proving $\theta\le\theta_0(n)$ with equality.* Grade **3**. Unblocks I27 and I13 by making a certificate readable rather than solved for.

- [ ] **I10, tube exclusion around the padded $\mathbb{HP}^2$ orbit.** *Theorem: for $n\ge12$ no maximizer lies within an explicit angular distance of $SO(n)\cdot W_{\mathbb{HP}^2}$ (padded), by [Lemma L20](findings/route-a.md)'s bootstrap: inside the tube the cubic expansion about a local maximum with a transverse spectral gap forces $\max P\le\sqrt{56/45}<\theta_0(n)$.* Grade **3**, with the transverse-eigenvalue step **UNSCREENED**.

- [ ] **I11. Lemma L57 lifted to every frame, with the defect isolated.** *Theorem: at every critical point and every frame $F$, the sectional matrix $M_F$ is hollow with zero row sums and $\lVert M_F\rVert\le\lVert W\rVert$; steps 2 and 3 of [Lemma L57](findings/problem.md) apply verbatim; and $\theta=\mu_F-\Sigma_F/\mu_F+\varepsilon_F/\mu_F\le\Theta_n\lVert W\rVert+\varepsilon_F/\mu_F$ exactly, with $\varepsilon_F$ the contraction of the criticality equation's off-diagonal defect in that frame.* Grade **2**. *Analysis in [ATTEMPTS.md](ATTEMPTS.md#i11-lemma-l57-lifted-to-every-frame-with-the-defect-isola).*

- [ ] **I11a, the frame search.** Split out of [I11](#section-2-build-what-the-proofs-need), which stays live. **Waits on:** the user's approval for computation.


- [ ] **I13, the pinned LP at three eigenvalues, kernel-free.** *Theorem it would produce: a proved bound on $\theta^\ast(\lambda)$ at every kernel-free three-value spectrum at $n\ge12$, or a named spectrum where it exceeds $\theta_0(n)$.* Grade **2** ($2\times1\times1\times1$). Detail in [bounds-relaxations.md](findings/bounds-relaxations.md); the route's history is in [ATTEMPTS.md](ATTEMPTS.md).

  *Working notes in [bounds-relaxations.md](findings/bounds-relaxations.md#from-i13).*

- [ ] **I13a. LP feasibility per candidate support at $d=3$, and the census over kernel-free three-value spectra.** Split out of [I13](#section-1-advance-the-proofs), which stays live. **Waits on:** the user's approval for computation, under the [analysis-only rule](.claude/rules/analysis-only.md).

  *Working notes in [second-order.md](findings/second-order.md#from-i14).*

- [ ] **I15, what a fourth relation on the signed constants has to be. RESTATED, its stated mechanism refuted.** *Theorem it would produce: a relation beyond (A),(B),(C) that cuts the pinned polytope, or a proof that no $T$-expressible one exists.* Grade **2**. *Analysis in [ATTEMPTS.md](ATTEMPTS.md#i15-what-a-fourth-relation-on-the-signed-constants-has-to).*

## SECTION 3, DISPROVE


## BLOCKED

- [ ] **I73, A GLOBAL MAXIMISER HAS A TWO-VALUE SPECTRUM, BLOCKED 2026-09-28k by the churn cap.** *Theorem: two values; [L105](findings/bounds-relaxations.md) closes P.* Grade **3**, routes [R38](routes.md), [R39](routes.md). **A successor must clear two requirements** ([28k sweep](reviews/2026-09-28k-LIT-step8-sweep.md)): exact on the unbalanced products to a relative $n^{-3}$ ([L232](findings/diagonal-half.md)), and global, reading the value without passing through diagonality ([I75](#section-1-advance-the-proofs)). **Lifted by** a mechanism meeting both, or by the user.

- [ ] **I121, THE MIXING GAP ([R54](routes.md), in [R52](routes.md)'s frame), BLOCKED 2026-09-28h by the churn cap.** *Theorem: (MG) at a unit global maximiser, with [L57](findings/problem.md) Conjecture A at even $n\ge12$.* **Settled**: small mass ([note](reviews/2026-09-28d-I121-smallmass-direct.md), in Lean) and product diagonal parts above R53's threshold. **A successor must** read $\theta\ge\theta_0$ inside the band, which holds padded $W_{\mathbb{CP}^2}$ as a local maximum below $\theta_0$ ([F73](findings/INDEX-traps.md)), the obstruction in [findings/INDEX.md](findings/INDEX.md). **Lifted by** a comparison with the product scoped to the band, or by the user.
  - *Its balanced closed branch needs the sharp $\#$ value on positive operators, which is statement H by [L260](findings/second-order.md) (1), [I117](#section-1-advance-the-proofs)'s item.* I122, opened for it, was that duplicate and is deleted ([note](reviews/2026-09-28j-I122-step4.md)).

- [ ] **I114, I73'S SYMMETRIC THREE-VALUE FAMILY, BLOCKED on statement H** ([batch 30](reviews/2026-09-26-I73-class-ceiling.md), [R42](routes.md)). *Theorem: $\theta<\theta_0(n)$ at every unit critical $W=a(P_2-P_0)$, $n\ge12$.* **Unblocked by H** ([I115](#section-1-advance-the-proofs)), which gives $\theta=\langle W\#W,W\rangle<\theta_0$ directly and contains [L257](findings/second-order.md)'s quartic bound and [L255](findings/second-order.md)'s internal cap; what is proved of H is [L259](findings/second-order.md).


- [ ] **I106a, THE TANGENCY EXCLUSION AT $\lvert J\rvert=3$.** *Theorem: at fixed total norm the functional on the orthostochastic data has no interior maximum, so the maximum sits on the split locus, [L229](findings/second-order.md).* Grade **0** ($2\times0\times1\times1$). **BLOCKED**: every lever but the value comparison is closed, and that one waits on [I106c](#blocked). *Detail at the [orthostochastic note](reviews/2026-09-16-I106a-orthostochastic.md) and [LEDGER.md](findings/LEDGER.md).*
- [ ] **I106, THE $\lvert J\rvert=3$ STEP OF R27: $\sup P=\Theta_n$ ON $\mathcal S_J\cap\mathcal W_n$ AT COMMUTING BLOCKS.** Grade **0** ($2\times0\times1\times1$). SPLIT into [I106a](#blocked) and [I106b](#section-1-advance-the-proofs). **BLOCKED** on the same value comparison as I106a, which waits on [I106c](#blocked). *Detail at the [derivation](reviews/2026-09-15-I106-m3-derivation.md) and [LEDGER.md](findings/LEDGER.md).*
- [ ] **I106c, DOES ANY NON-COMMUTING CRITICAL POINT SATISFY BATCH 21 AT $\lvert J\rvert=3$? BLOCKED on a search this footing does not permit.** *A witness closes [R27](routes.md) outright by refuting the rung. An absence does not, since [r973](reviews/REVIEW_r973.md)'s three points cannot be rebuilt from the record and so cannot certify coverage.* **APPROVED 2026-09-17 for the WITNESS half only.** *The reconstruction attempt and the degeneracy that blocks it are in [ATTEMPTS.md](ATTEMPTS.md) under 2026-09-17.*

- [ ] **I76b, the general $n=6$ case of [I76](#section-1-advance-the-proofs), BLOCKED on a search this footing does not permit.** *Three open cases rather than one* ([r880](reviews/REVIEW_r880.md)), *with the cases, the candidate families, the tight-frame condition and the complex-line exclusion all in [diagonal-half.md](findings/diagonal-half.md)'s I76 section.* **What each outcome decides**: a witness makes I76 false at $n=6$ and ends the dimension-by-dimension route, an exhaustive absence moves the front to $n=8$. **Who can lift it**: the user, by approving the search.

- [ ] **I5, the non-pure critical set above $\sqrt{3/2}$ is separated from the pure locus.** *Theorem: at $n\ge12$, $\{W\in S: Q(W)=\theta W,\ \theta>\sqrt{3/2},\ W\text{ non-pure}\}$ has closure at positive distance from $O(n)\cdot\mathcal D_n$.* **BLOCKED 2026-09-03**, its only input [I18](#blocked) is blocked behind four fence posts, so *attackable* is $0$ and the grade with it. Grade **0** ($3\times\mathbf0\times1\times1$) *Analysis in [ATTEMPTS.md](ATTEMPTS.md#i5-the-non-pure-critical-set-above-sqrt32-is-separat).*

- [ ] **I18, every pure critical point above $\sqrt{3/2}$ is isolated, at $n\ge12$.** *Theorem: no such point carries the $L_e$-eigenvalue $\tfrac12$ in an L121 block, an off-orbit L122 block or a direction of $\mathcal D_n\cap W^\perp$; with [Lemma L128](findings/second-order.md) every such orbit is then isolated.* Grade **4** ($2\times2\times1\times1$). **(a) and (b) are answered, (c) is where the derivation may fail**, stated at [second-order.md](findings/second-order.md#i18-every-pure-critical-point-above-sqrt32-is-isolated-at-nge12).

- [ ] **I18e, a twin pair with disconnected deleted support, at a non-sphere-product pure critical point in the band.** Split out of [I18](#section-1-advance-the-proofs), which stays live on its four-set and $\mathcal D_n$ clauses. **Deciding it is a falsifier hunt, which the analysis-only rule blocks without approval for the specific run.** *What is already closed, and what each outcome would decide, are in [I18e, what the pair clause already covers](findings/second-order.md#i18e-a-twin-pair-with-disconnected-deleted-support-at-a-non-sphere-product-pure-critical-point-in-the-band).* **Waits on:** that approval.


- [ ] **I19, the falsifier hunt on the non-diagonal part of $\{S=0,\Delta>0\}$.** Exact-Jacobian Newton solves seeded from the isotropic Grassmannian ([run_f4b_newton.py](scripts/runs/run_f4b_newton.py)); a witness above $\sqrt{3/2}$ kills the target outright, and every witness gets its kernel dimension, isotype blocks and Morse–Bott degeneracy recorded. **Numerical, so it is blocked while the analytical-only regime holds.**

## Carried forward

- **Fence posts 1–42:** [fence-posts.md](findings/fence-posts.md). **Routes and clearance criteria:** [routes.md](routes.md), every route live or closed with what a successor must clear.
- Validation owed: see [the section above](#lean-owed-and-validation-owed), which owns the subject.
- **Canon:** [results.md](results.md), rebuilt whole 2026-09-02, every numbered result in [findings/INDEX-results.md](findings/INDEX-results.md) covered. **Audit owed** on its four least-sure entries, tracked in [LEDGER.md](findings/LEDGER.md).
- **Filed and Gate 2 owed:** [ATTEMPTS.md](ATTEMPTS.md#filed-and-gate-2-owed-as-of-the-last-plan-rewrite); the standing debt is [LEDGER.md](findings/LEDGER.md).
- **Verification-loop candidates:** [ATTEMPTS.md](ATTEMPTS.md#verification-loop-candidates-raised-by-the-planners).
- **Gate 2 debt:** [LEDGER.md](findings/LEDGER.md) owns the list of results awaiting audit; read it there rather than restated here.
- **Step 8 sweeps and their position files**, 2026-09-02 on Fable, and both passes of 2026-09-03, are in [ATTEMPTS.md](ATTEMPTS.md) under their dates, with the routes each proposed. *[routes.md](routes.md) carries every route they raised, live or closed.*
- **The excess question, parked:** five attacks failed; post F37 stands; R11 keeps the one untried angle as fallback.
- **Warnings a new session must read first:** [INDEX-traps.md](findings/INDEX-traps.md#warnings-a-new-session-must-read-first).

## DONE
- **I120, the named `sorry` of I117Statements.lean: 27 OF 28 DISCHARGED 2026-09-27**, the last three L267, L265, L263; `L254_conjA_12` stays a `sorry`, its proof being the outside certificate ([lean/INDEX.md](lean/INDEX.md)).
- **I113, both archive identities: TRUE, 2026-09-23**, Gate 2 passed ([r1095](reviews/REVIEW_r1095.md), [r1096](reviews/REVIEW_r1096.md)), in [the audit note](reviews/2026-09-23-I113-audit.md); (b) typed in [I113Reflection.lean](lean/HamiltonsCubic/Results/I113Reflection.lean).

- **I67, `StarWedgeIdentity`: PROVED 2026-09-23.** Orthogonal normal form plus `pf6_conj` give $\mathrm{pf6}(J)=\pm1$, so L184's case 2 is unconditional, and L191's case 2 no longer waits on the identity. [I67PfSign.lean](lean/HamiltonsCubic/Results/I67PfSign.lean).
- **I112, the second-kind Bochner functional: CLOSED 2026-09-23**, [R31](routes.md) dying to [post F33](findings/fence-posts.md) ([r1082](reviews/REVIEW_r1082.md)).

- **I24a, the LP at the $n=12$ witness spectrum: RAN 2026-09-21, and it ANSWERS.** [Post F43](findings/bounds-relaxations.md)'s spectrum is not realisable in the pinned class. *One witness, not the class ([r1056](reviews/REVIEW_r1056.md), [r1057](reviews/REVIEW_r1057.md)).*

- **I110, the pinned corner: SETTLED 2026-09-22, the corner is EXCLUDED**, ([note](reviews/2026-09-14-I104-tau-positive.md), [r1062](reviews/REVIEW_r1062.md), [r1063](reviews/REVIEW_r1063.md)); successor [I111](#section-1-advance-the-proofs).

- **T9, the full pinned LP over spectra.** RUN 2026-09-21. The relaxation overshoots and the overshoot GROWS with $n$, so that branch is dead. *[diagonal-half.md](findings/diagonal-half.md); [post F42](findings/fence-posts.md) stands.*
- **I108, the bridge between the two Lean layers: BUILT 2026-09-19**, Gate 2 by [r1003](reviews/REVIEW_r1003.md) and [r1004](reviews/REVIEW_r1004.md). *Detail in [lean/INDEX.md](lean/INDEX.md).*
- **I66: `DiagCubicFormula` and `SphereProductValue` PROVED 2026-09-18** as [L231 and L232](findings/diagonal-half.md), Gate 2 [r1001](reviews/REVIEW_r1001.md). Detail in [ATTEMPTS.md](ATTEMPTS.md).
- **I107, the Osserman endgame: REGISTERED AND CLOSED 2026-09-17, the same day**, its warrant false and the route with it. [post F71](findings/fence-posts.md), [R29](routes.md).
- **I48, [L35](findings/stratum-two-negative.md)'s one-negative case: PROVED 2026-09-17 as $\theta\le0$, Gate 2 PASSED** ([r988](reviews/REVIEW_r988.md), [r989](reviews/REVIEW_r989.md)). *Its content is confined to rank $\ge6$, which is open; detail at that lemma's block.*
- **I2, the balanced-orbit pencil: HANDED OFF to the verification loop 2026-09-17**, its remaining audit debt on [L147](findings/second-order.md) and [L149](findings/second-order.md) already open in [plan-verification.md](plan-verification.md). *L16(b) stays open and is not this item's.*
- **I53, the third orbit identity: PROVED 2026-09-17, Gate 2 PASSED** ([r984](reviews/REVIEW_r984.md), [r985](reviews/REVIEW_r985.md)). *$\langle Bu,u\rangle=0$ from infinitesimal invariance of $T$ alone; detail at [L51](findings/second-order.md)'s block.*
- **I96, MERGED into [I35](#section-1-advance-the-proofs) 2026-09-13, a duplicate of its isolation radius.** The Lyapunov--Schmidt version was refuted and vacuous ([r929](reviews/REVIEW_r929.md), [r930](reviews/REVIEW_r930.md)), the Taylor version being [L216](findings/second-order.md).
- **I94, the frame split: DERIVED 2026-09-13 as [L214](findings/second-order.md), Gate 2 PASSED** ([r926](reviews/REVIEW_r926.md), [r927](reviews/REVIEW_r927.md)), the decoupled bound it first suggested being [post F67](findings/fence-posts.md).
- **I92, CLOSED 2026-09-13 as a route input by [post F67](findings/fence-posts.md)**, the decoupled bound it served never improving on $\Theta_n$.
- **I93, CLOSED 2026-09-13 as a route input by [post F67](findings/fence-posts.md)**, the decoupled bound it served never improving on $\Theta_n$.
- **I12, the four-index certificate off the diagonal locus: PROVED and closed as not informative.** *Detail in [ATTEMPTS.md](ATTEMPTS.md#i12-the-four-index-certificate-off-the-diagonal-locus).*
- **I16, the pinned class cannot bound $\theta$ once a kernel is allowed: CLOSED as [L173](findings/bounds-relaxations.md).** *Detail in [ATTEMPTS.md](ATTEMPTS.md#i16-the-pinned-class-cannot-bound-theta-once-a-kernel-is-allowed).*
- **I17, the symmetric doubly-stochastic reading is HLP majorisation carrying the SPECTRUM: CLOSED as [L175](findings/bounds-relaxations.md), scoped.** *Detail in [ATTEMPTS.md](ATTEMPTS.md#i17-the-symmetric-doubly-stochastic-reading-is-hlp-majorisation-and).*
- **I105, the per-block cubic lemma: PROVED 2026-09-15 as [Lemma L225](findings/second-order.md), Gate 2 PASSED ([r947](reviews/REVIEW_r947.md))**, a confirmation of Case–Tyrrell and of the sample-skewness bound, by a tangent cubic.
- **I103, a stability form of L57: PROVED 2026-09-14 as [Lemma L223](findings/problem.md), Gate 2 PASSED ([r945](reviews/REVIEW_r945.md), [r946](reviews/REVIEW_r946.md))**, a tool; the pair-block stratum it was built for closed without it, as [L224](findings/second-order.md).
- **I101, the diagonal theorem on a four-set subalgebra: PROVED 2026-09-14 as [L220](findings/second-order.md), Gate 2 PASSED ([r939](reviews/REVIEW_r939.md), [r940](reviews/REVIEW_r940.md)).**
- **I102, the reflection lemma: R26's ABANDON CONDITION MET 2026-09-14**, its calculus kept as [L219](findings/second-order.md) ([derivation](reviews/2026-09-14-I102-derivation.md)).
- **I97, the pair mass as a measure of non-diagonality: DEAD END 2026-09-13**, its theorem being [I36](#section-1-advance-the-proofs)'s frame link ([bridge](findings/diagonal-half.md#lemma-l201-integrality-of-the-pairwise-plane-traces-forces-a-common-frame)).
- **I99, $\Lambda_n\le\Theta_n$ as a falsifier: DOES NOT FIRE, 2026-09-14, as [L218](findings/second-order.md), Gate 2 PASSED**, with $\Lambda_n=\sqrt3/2$ exactly.
- **I98, the value-bootstrap tube: DERIVED 2026-09-14 as [L217](findings/second-order.md), Gate 2 PASSED**, the far region being [I100](#section-1-advance-the-proofs).
- **I46, the multi-block norm identity at $k\ge5$: PROVED 2026-09-13 inside [Lemma L212](findings/graded-half.md#lemma-l212-the-multi-block-vertex-solution-is-critical-at-every-partition-and-its-second-moment-is-the-norm-identity), at every $k$ and every partition.**
- **I91, is each irreducible factor itself compact: YES, 2026-09-13, as [Lemma L213](findings/problem.md#lemma-l213-each-irreducible-factor-is-itself-compact-which-is-the-theorems-last-owed-clause), Gate 2 PASSED with four repairs**
- **I47, the norm-to-$\theta$ step without the Einstein hypothesis: DERIVED 2026-09-13 as [Lemma L212](findings/graded-half.md#lemma-l212-the-multi-block-vertex-solution-is-critical-at-every-partition-and-its-second-moment-is-the-norm-identity), Gate 2 LANDED with two claims refuted**

- **I14, the second variation at every diagonal critical point, block-diagonalised: RETIRED 2026-09-13, absorbed since 2026-09-02.**

- **I90, a compact Einstein symmetric space has $\lambda>0$: DERIVED 2026-09-13 as [Lemma L211](findings/problem.md), Gate 2 owed.**

- **I52, the de Rham reduction: DERIVED 2026-09-13 as [Lemma L210](findings/problem.md), Gate 2 PASSED with its corollary corrected ([r918](reviews/REVIEW_r918.md), [r919](reviews/REVIEW_r919.md)).**

- **I83, closure of the Fox product on $\mathcal W_n$: DERIVED 2026-09-13 as [Lemma L209](findings/curvature-invariants.md), both halves, Gate 2 PASSED ([r914](reviews/REVIEW_r914.md), [r915](reviews/REVIEW_r915.md)).**

- **I88, is the Fox algebra medial: ANSWERED NO 2026-09-13, Gate 2 PASSED ([r910](reviews/REVIEW_r910.md), [r911](reviews/REVIEW_r911.md)).**

- **I87, is the Fox algebra isospectral: ANSWERED NO 2026-09-13, Gate 2 PASSED ([r910](reviews/REVIEW_r910.md), [r911](reviews/REVIEW_r911.md)).**

- **I84/I85/I86, the R22 moment-map route: CLOSED at the root 2026-09-13 as [post F66](findings/fence-posts.md).** *No reductive group gives $\mathcal W_n$ a minimal-vector structure; detail at [R22](routes.md).*

- **I82, the trace on the operators of $\mathcal W_n$: CLOSED 2026-09-12, needing no explicit basis.** *Detail at [lean/INDEX.md](lean/INDEX.md)'s I82 row, audited by [r898](reviews/REVIEW_r898.md).*
- **I80, packing bounds on eigenplane multiplicities: CLOSED 2026-09-12, no cap obtainable in principle.** *Detail at [diagonal-half.md](findings/diagonal-half.md)'s I80 block, from [r889](reviews/REVIEW_r889.md) and [r890](reviews/REVIEW_r890.md).*

- **I79, purity as an algebraic criterion: CLOSED 2026-09-12, both named sources failing.** *Detail at [routes.md](routes.md)'s R20 row and the two [references/](references/) folders it names.*

- **I42, the $\tfrac12$-eigenvalue off the orbit: CLOSED 2026-09-12 as [Lemma L207](findings/nondegeneracy.md), wider than asked.** *The excess is $0$ at every two-factor sphere product except $S^3\times S^3$, where it is $9$.*

- **I78, the Killing-constant bound: CLOSED 2026-09-12 as [Lemma L206](findings/bounds.md) and [post F65](findings/fence-posts.md).** *The trace-form bound on $\theta$, sharp at $S^2\times S^2$ and loosest where the conjecture is an equality.*

- **I76c, the $\mathbb Z_5$-symmetric case at $n=5$, $\kappa=2$: CLOSED 2026-09-12, only coordinate configurations.** *Detail at [diagonal-half.md](findings/diagonal-half.md).*

- **I72, the symmetric-space census. CLOSED 2026-09-10**, the full $(n,r)$ list with $\theta\le0.896421$ at $\mathbb{OP}^2=F_4/\mathrm{Spin}(9)$, verified in exact rationals as $\theta^2=45/56$. *Detail in [graded-half.md](findings/graded-half.md).*
- **L165, L166, L167, L168, L169, L170. DONE 2026-09-07.** *Detail in [ATTEMPTS.md](ATTEMPTS.md#l165-l166-l167-l168-l169-l170-done-2026-09-07).*
- **V1, the inventory, as far as the commit record can carry it. DONE 2026-09-07.** *Detail in [ATTEMPTS.md](ATTEMPTS.md#v1-the-inventory-as-far-as-the-commit-record-can-carry-it).*
- **V2, the refutations, worked first. DONE 2026-09-07: all twenty-six examined.** *Detail in [ATTEMPTS.md](ATTEMPTS.md#v2-the-refutations-worked-first).*
- **V3, this session's own verification output. DONE 2026-09-07.** *Detail in [ATTEMPTS.md](ATTEMPTS.md#v3-this-sessions-own-verification-output).*
- **I40, the involution classification the record cited four times and held no source for. CLOSED 2026-09-07 as [Lemma L159](findings/graded-half.md).** *Detail in [ATTEMPTS.md](ATTEMPTS.md#i40-the-involution-classification-the-record-cited-four-times-and-he).*
- **I70. RETIRED ON FILING: the diagnosis it asked for was already on the record.** *[The low-rank paragraph](findings/stratum-two-negative.md#the-low-rank-case-in-development-form) decomposes the chain at its own argmax and names the driver, and five estimates have been aimed…
- **I69. RETIRED: founded on a reading the record had already superseded.** *The census form is right and confirmed; the argmax it decides is not the lever, which [the same paragraph](findings/stratum-two-negative.md#the-low-rank-case-in-development-form) records.* Grade **0**.
- **I41, the mixed summand contributes nothing at low corank. CLOSED 2026-09-07 as [Lemma L160](findings/isotropy-cap.md).** *Detail in [ATTEMPTS.md](ATTEMPTS.md#i41-the-mixed-summand-contributes-nothing-at-low-corank).*
- **I55, the competitor's stabilizer meets the mixed block trivially. CLOSED as [Lemma L167](findings/route-a.md).** *Detail in [ATTEMPTS.md](ATTEMPTS.md#i55-the-competitors-stabilizer-meets-the-mixed-block-trivially).*
- **I56, the frontier branch's coverage, as one cubic. CLOSED as [Lemma L165](findings/route-a.md), and the item's own theorem is refuted.** *Detail in [ATTEMPTS.md](ATTEMPTS.md#i56-the-frontier-branchs-coverage-as-one-cubic).*
- **I58, $\kappa_n$ at odd $n$. CLOSED 2026-09-07 as [Lemma L161](findings/curvature-invariants.md).** *Detail in [ATTEMPTS.md](ATTEMPTS.md#i58-kappa_n-at-odd-n).*
- **I59, the $\theta/2$-multiplicity at a local maximum. CLOSED as [Lemma L170](findings/second-order.md), and the theorem asked for does not exist.** *Detail in [ATTEMPTS.md](ATTEMPTS.md#i59-the-theta2-multiplicity-at-a-local-maximum).*
- **I60, padding preserves the norm and $\theta$. CLOSED 2026-09-07 as [Lemma L164](findings/stratum-two-negative.md).** *Detail in [ATTEMPTS.md](ATTEMPTS.md#i60-padding-preserves-the-norm-and-theta).*
- **I61, [L37](findings/target.md)'s two witnesses, in closed form. CLOSED 2026-09-07 as [Lemma L163](findings/target.md).** *Detail in [ATTEMPTS.md](ATTEMPTS.md#i61-l37s-two-witnesses-in-closed-form).*
- **I62, the saturating operator IS the sphere product's Weyl tensor. CLOSED as [Lemma L169](findings/bounds.md), and two hypotheses turn out redundant.** *Detail in [ATTEMPTS.md](ATTEMPTS.md#i62-the-saturating-operator-is-the-sphere-products-weyl-tensor).*
- **I65, the Kähler family's members are Weyl tensors. CLOSED as [Lemma L166](findings/ungraded-slack.md), and stronger than asked.** *Detail in [ATTEMPTS.md](ATTEMPTS.md#i65--the-kähler-familys-members-are-weyl-tensors).*
- **I38, the rank-three family. CLOSED 2026-09-10**: $\Lambda^2$-rank $\le3$ gives $\theta\le\sqrt{3/2}$, equality at padded $W_{\mathbb{CP}^2}$ ([diagonal-half.md](findings/diagonal-half.md)).
- **B1, the base layer over $\mathbb R$ at general $n$. CLOSED 2026-09-09**, all six named needs met or discharged. *What is still owed there is a Lean statement of the $\mathrm{id}^\#$ anchor and the $\Lambda^\pm$ splitting. Detail in [lean/INDEX.md](lean/INDEX.md).*

- [x] **I20 CLOSED at Gate 2, before it was opened**, true and useless; the competitor makes confinement vacuous at every $n\ge14$ ([r393](reviews/REVIEW_r393.md), [r394](reviews/REVIEW_r394.md)).
- [x] **I21 CLOSED, the compactness half is one line**, $\mathcal D_n$ being a linear subspace, which is its definition in [conventions.md](findings/conventions.md) rather than a lemma.
- [x] **I22 DELIVERED, [Lemma L128](findings/second-order.md)**, the branching clause; Gate 2 passed with corrections, both reviewers agreeing on every verdict ([r373](reviews/REVIEW_r373.md), [r374](reviews/REVIEW_r374.md)).
- [x] **I23 RETIRED, the $Z(h)$ identity is unnecessary**; [target.md](findings/target.md) carries the lift with no projection at all.
- [x] **I24 CLOSED, subsumed by [I13](#section-1-advance-the-proofs)**, its dichotomy answered on both sides.
- [x] **I25 DELIVERED, the maximiser's spectral half-plane and a lower bound on the extreme eigenvalues**, [DERIVE-mx2.md](reviews/DERIVE-mx2.md). **Gate 2 owed.**
- [x] **I26 CLOSED, the saturating SRG members are exactly the balanced sphere products**, [Lemma L74](findings/diagonal-half.md).
- [x] **I27 CLOSED, the reduction is proved and the two-eigenvalue stratum with it**, [Lemma L104](findings/bounds-relaxations.md).
- [x] **I28 CLOSED, the off-diagonal block adds nothing on $T$**, and that is now a theorem ([DERIVE-t7](reviews/DERIVE-t7.md)).
- [x] **I29 ANSWERED, the per-row hull is exact at every row of every $S^p\times S^q$**, slack zero ([DERIVE-df4.md](reviews/DERIVE-df4.md)). **Gate 2 owed.**
- [x] **I30 CLOSED, a fence post**: a degenerate global maximum satisfying every identity of the extremal-idempotent calculus ([post F37](findings/fence-posts.md)).

**Every closure with its reason and clearance criterion is in [routes.md](routes.md) and [findings/INDEX.md](findings/INDEX.md).** Retired: F5, B1 to B3, C3, V1 to V3, B-Q, F4, R8 to R10, R12 to R14.
