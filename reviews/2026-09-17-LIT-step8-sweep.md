# Step 9 literature sweep, 2026-09-17

**Run on Fable at the user's switch, reading [2026-09-17-step8-position.md](2026-09-17-step8-position.md) and nothing else of the record whole.** Appended after every batch.

## Batch 0, what is already searched, so it is not repeated

From the position file and the seven earlier sweep files: GIT classifying problem (09-13); Z-eigenvectors of symmetric tensors, three times; the Hamilton ODE $R^2+R^\#=\lambda R$ as a classification problem (09-13b); orbit spaces (09-13c); Banach's theorem and global maximisers of cubic forms (09-14); DDVV and Böttcher--Wenzel, the per-matrix cubic, Horn convexity (09-14c); trace polynomials over tuples, joint $c$-numerical ranges, orthostochastic matrices and linear optimisation over them (09-16, batch 4 finding nothing). **Shelf: 103 sources.**

**Unsearched angles chosen for this sweep.** (1) The Kähler side: the sharp maximiser is padded $\mathbb{CP}^2$, Kähler Weyl tensors are a structured subspace (the Bochner tensor), and nothing on the shelf is about them past dimension four. (2) The cubic form's own algebra: whether $P$ restricted to natural subspaces is a Jordan cubic norm, where sharp bounds are classical. (3) Anything from 2025--26 naming the problem or the ODE directly. (4) The statement stripped of names, phrased for the invariant-theory and the real-algebraic-geometry communities rather than the Ricci-flow one.

## Batch 1, four angles in parallel: Kähler, the ODE in 2025--26, Jordan cubic norms, maximal isotropy

**Searched**: the Bochner tensor and cubic invariants on Kähler Weyl tensors; the Hamilton ODE $R^2+R^\#=\lambda R$ with "eigenvector" and "bound" restricted to 2025--26; cubic forms on curvature tensors as Jordan cubic norms; maxima of invariant cubics at points of maximal isotropy.

**Kähler**: nothing past the foundations. Bryant's [Bochner-Kähler metrics](https://arxiv.org/abs/math/0003099) defines the object and the search reached no eigenvalue estimate or cubic bound on it. *The angle is not exhausted, only unindexed by these terms; batch 2 rephrases it through the Kähler curvature ODE.*

**The ODE, 2025--26**: nothing new. The one ODE source returned is [1310.4618](https://arxiv.org/abs/1310.4618), already on the shelf as bhattacharya-2013-curvature-ode.

**Jordan**: one hit on the shelf and ONE NOT. Fox's [1901.04012](https://arxiv.org/abs/1901.04012) (on the shelf) states that in dimension four the self-dual Weyl tensors are the deunitalised Jordan algebra of $3\times3$ symmetric matrices and the cubic is Cartan's isoparametric cubic, which the record uses. **New: [1910.03929](https://arxiv.org/abs/1910.03929), the Jordan algebras of Riemann, Weyl and curvature-compatible tensors**, where tensors compatible with a fixed $K$ form a special Jordan algebra under symmetrised composition. *Screen owed: the record's product is Fox's $W\circ W=W^2+W^\#$, not the Jordan symmetrisation, so the question is whether "compatible" tensors bear on critical points at all.*

**Maximal isotropy**: [Hervik's minimal tensors](https://arxiv.org/abs/1203.3563) and [the discriminants of isotropy representations](https://arxiv.org/abs/1008.1268), both the GIT angle the 09-13 sweep already worked. *Nothing new.*

## Batch 2, the Jordan hit screened, the Kähler ODE, 2026 arXiv, and Hamilton's four-dimensional ODE

**[1910.03929](https://arxiv.org/abs/1910.03929) screened OUT.** Mantica--Molinari: a symmetric 2-tensor $b$ is $K$-compatible when $b_i{}^mK_{jklm}+\text{cyclic}=0$, and the compatible tensors form a special Jordan algebra. *The object is symmetric 2-tensors against a fixed curvature tensor, not curvature tensors under a product, and the paper says nothing of critical points or cubics.*

**The Kähler curvature ODE**: the search returned Bando--Mok's positive-bisectional cone as an invariant cone, through [Wilking's Lie-algebraic approach](https://arxiv.org/abs/1011.3561), which is on the shelf as wilking-lie-algebraic-cones. *No source on the fixed points of the Kähler ODE beyond $\mathbb{CP}^n$ as the Frankel endpoint.*

**arXiv 2026**: [2607.21538](https://arxiv.org/abs/2607.21538), conformal Kähler rigidity of Einstein four-manifolds from simplicity of the largest $W_+$ eigenvalue. *Four-dimensional and about metrics rather than algebraic tensors; the record's four-dimensional case is closed.* [2507.15237](https://arxiv.org/abs/2507.15237) treats $W=0$. Nothing else.

**Hamilton 1986 and Böhm--Wilking**: known, on the shelf, and the four-dimensional ODE's stationary points are the record's four-dimensional case.

**What batches 1 and 2 say together**: the Ricci-flow and Kähler vocabularies return the shelf. *The next batch strips the names further and goes to the one literature whose sharp cases are exactly this conjecture's two equality families.*

## Batch 3, the second-kind operator, and Osserman tensors

**The second-kind angle is the record's already.** The search returned [2601.06556](https://arxiv.org/abs/2601.06556), [2512.21496](https://arxiv.org/abs/2512.21496) and [2608.23778](https://arxiv.org/abs/2608.23778), all three on the shelf (cone-conditions-2025, new-rigidity-2025, elhasan-li-npw-2026). *And the mechanism I had in mind, that $P$ is a fixed combination of the first- and second-kind cubic traces, is [ATTEMPTS.md](../ATTEMPTS.md) line 661: the invariant cubics on $\mathrm{Weyl}_n$ form a 2-plane spanned by $\mathop{\mathrm{tr}}W^3$ and $\langle W^\#,W\rangle$ in every dimension, so the second-kind cubic trace is a multiple of $P$.* **That is post F19's $\Theta_3=32\theta$, and posts F19 to F21 record why the moment machinery cannot reach $\lambda_{\min}$.** Closed.

**Osserman, the one live thread.** [Nikolayevsky](https://arxiv.org/abs/math/0204258): an algebraic curvature tensor whose Jacobi operator has constant eigenvalues on the unit sphere is, for $n\ne16$, flat or that of a rank-one symmetric space; the [conformal version](https://arxiv.org/abs/0810.5621) says the same of a Weyl tensor for $n\ne3,4,16$. *Every known Osserman tensor except $\mathbb{OP}^2$ has a Clifford structure* ([math/0608749](https://arxiv.org/abs/math/0608749)), which is tkachev-2019-clifford on the shelf. **Why it bears**: the conjecture's non-diagonal equality case, padded $\mathbb{CP}^2$, IS Osserman, and its diagonal equality cases, the sphere products, are NOT. *A route would show a non-diagonal maximiser above $\sqrt{3/2}$ has constant Jacobi spectrum, then read $\theta$ off the rank-one census the record already carries.* **Screened against the record next, before a batch is spent on it.**

## Batch 4, the one community that works on this algebra's own shape: axial algebras

**The reframe is on the record and its literature pass was OWED.** [ATTEMPTS.md](../ATTEMPTS.md) line 1915, the 2026-08-21 route planning, names engine E2: *critical points are idempotents of Fox's commutative nonassociative algebra, $L_e$ is essentially the Hessian, and that is the setup of axial algebra theory, where idempotents whose multiplication spectrum obeys a fusion law generate rigidly classifiable configurations.* The same entry records that **an axial-algebra literature pass is owed at the head of E2 before anything is derived**, and no later sweep file mentions axial algebras. *This batch is that pass.*

**What the field has, and what is new since the reframe.** Axial algebras are commutative nonassociative algebras generated by primitive semisimple idempotents whose eigenvectors multiply by a fusion law ([Hall--Rehren--Shpectorov's programme](https://arxiv.org/abs/2209.08043)). Their founding axiom beyond the fusion law is the **Norton inequality**, $\langle x\circ x,y\circ y\rangle\ge\langle x\circ y,x\circ y\rangle$, a Cauchy--Schwarz for the product against the Frobenius form. **NEW, July 2026, [Castillo-Ramirez, 2607.03237](https://arxiv.org/abs/2607.03237)**: in any commutative real algebra with a nondegenerate Frobenius form, the Norton inequality ALONE forces, for EVERY idempotent $e$, that the eigenspaces $A_0(e)$ and $A_1(e)$ of $L_e$ are subalgebras annihilating each other, $A_0(e)A_1(e)=0$. *That is a fusion rule earned from one inequality rather than assumed.* **Fox's algebra is metrised, so the Frobenius form is the inner product and the hypothesis is exactly whether Fox's product satisfies Norton.** *Nobody has asked. Screened next, in seconds, on random Weyl tensors with the record's own product.*

Also seen: Tkachev's [metrised-algebra slides](https://users.mai.liu.se/vlatk48/conferences/2024metrized_covilha.pdf) (on the shelf) and Krasnov--Tkachev's [variety of idempotents](https://arxiv.org/abs/1801.00617), where in a metrised algebra an idempotent is indecomposable iff its Peirce 1-eigenspace is one-dimensional, *which at a maximiser is the record's [L24](../findings/second-order.md), $\lambda_{\max}(L_W\vert_{W^\perp})\le\theta/2$, read as a statement about $A_1$.*

**Norton FAILS on Fox's algebra, and the pass is closed negative.** Screened with the record's own `circ` from [review_r27_core.py](../scripts/lib/review_r27_core.py) on random Weyl tensors: $\langle x\circ x,y\circ y\rangle-\langle x\circ y,x\circ y\rangle<0$ on $300$ of $300$ pairs at $n=6$ ($\dim84$) and $300$ of $300$ at $n=7$ ($\dim168$), worst gaps $-2805$ and $-5625$, with $y=x$ giving $0$ exactly as the control. *The reversed inequality is not a theorem either, generic sign notwithstanding: at an idempotent $e$ with orbit tangent $z$, $L_ez=\tfrac12z$ makes it read $\tfrac14|z|^2\ge\tfrac12|z|^2$.* **So 2607.03237's fusion rules do not transfer, and the axial-algebra literature offers this algebra nothing beyond what Krasnov--Tkachev already gave it.** *Not filed as a source: it was read at its theorem and screened out, and the reason is recorded here.*

## Phase 3a, the screen of what the sweep produced, by mechanism, against the seven places

| candidate mechanism | INDEX-literature | fence posts | findings | ATTEMPTS | reviews | references | verification |
|---|---|---|---|---|---|---|---|
| Osserman endgame: constant Jacobi spectrum at a non-diagonal maximiser, then the rank-one census | not transcribed | none fences it | none | none | **seen twice** as a source of spectral constraints and set aside, 09-12 sweep line 21 and LIT-spectra line 28, *never as an endgame* | Nikolayevsky is on the shelf only for pre-Einstein derivations | none |
| Kähler reduction: a non-diagonal maximiser above $\sqrt{3/2}$ is Kähler-type, then the Bochner decomposition | not transcribed | none | **this is [R18](../routes.md)'s first link in other words**: an orthonormal decomposable eigenbasis is the real form of a complex structure on the top eigenspace | I75 | r976/r977 | none | none |
| Second-kind cubic trace | $\Theta_3=32\theta$ | **F19 to F21 fence it** | curvature-invariants.md | 661, 2200, 5599 | many | many | none |
| Norton fusion rules | none | none | none | E2 at 1915, pass owed | none | none | none, **and closed above by screen** |
| Jordan-compatible tensors | none | none | none | none | none | none | **screened out, wrong object** |

**What survives the screen**: the Osserman endgame is the one mechanism the record has met and never used as a route, and it is a route only if a link nobody has a method for can be invented. *Everything else the sweep touched is on the shelf, fenced, or dead.*

**Per-item coverage, stated honestly.** The position file's instruction was the outside field, and the batches were by mechanism rather than one query per live item. Of section 1, the batches bear on I73, I36, I75 and I89 (through R18 and R23's objects); I104's sub-objects were searched by the 09-14c and 09-16 sweeps; I77, I76, I71, I68, I6, I106b, I100, I81, I74 were **not searched this sweep**, each being a sub-lemma of a registered route whose headline the earlier sweeps did search. Of section 2, I39, I66, I67, I34, I44, I51 are Lean and audit tasks with no literature to search, and I33, I31, I32, I8, I9, I10, I11, I13, I15 are R17's own sub-lemmas, **not searched this sweep**.

## Phase 3b, the routes, graded on section 1's rubric, and what I recommend

**The finding of the sweep is that the outside is exhausted for this statement.** Seven sweeps have now read the Ricci-flow, GIT, tensor-eigenvalue, DDVV, Horn, orthostochastic, Kähler, Osserman, Jordan and axial literatures, and the last three of those were this sweep's. *Nothing returned a mechanism with a method that the record does not already carry.* **So the routes below are the record's own, and the one decision that moves the plan is not a route at all.**

| # | route | closes | attackable | margin | analytic | value | how close to a proof of the goal |
|---|---|---|---|---|---|---|---|
| **1** | **Approve [I106c](../plan.md)'s priced search**, unblocking I106 and I106a on [R27](../routes.md) and [R28](../routes.md) | 2 | 2 | 1 | 1 | **4** | settles the $\lvert J\rvert=3$ step of the block induction. Leaves the climb to $\lvert J\rvert=n$ and the whole $S=0$ half. *Either outcome of the search decides something, which is what makes it worth its price* |
| **2** | **Register the Osserman endgame as a node under I73 and I36**: a non-diagonal critical point above $\sqrt{3/2}$ has constant Jacobi spectrum, whence Nikolayevsky's classification ($n\ne3,4,16$) and the rank-one census finish | 3 | 1 | 1 | 1 | **3** | would settle the non-diagonal half outright. *Its link has no method, so it is I73's grade with a target statement where "no route known" stands now* |
| 3 | Kähler reduction: a non-diagonal maximiser is Kähler-type, then the Bochner decomposition | 3 | 1 | 1 | 1 | 3 | the same distance as route 2, **and it is R18's first link restated**, so it is folded into R18 rather than registered |

**My recommendation, in order.** *Route 1 first, because it is the only action that makes a value-4 item startable, and it is yours rather than mine: it costs a search this footing does not permit without approval, and the plan has carried it blocked since 2026-09-16.* **Route 2 second, as a registered node rather than a worked item**: it changes nothing about what can be started today, and it gives I73 and I36 a statement a later cycle can attack, which "no route known" does not. Route 3 is not proposed separately.

**What route 1's failure would mean for route 2**: nothing, they are independent. **What route 2's failure would mean**: I73 and I36 return to "no route known", which is where they are.

**What I would NOT do**: run another outside sweep on this statement. *The seventh confirmed the sixth.*

