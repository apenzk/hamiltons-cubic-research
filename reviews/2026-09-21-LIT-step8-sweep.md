# Literature sweep, step 9, 2026-09-21

**Run on Fable from [the position file](2026-09-21-step8-position.md) and nothing else of the record whole. Appended after every batch, so a compaction loses nothing.**

## Batch 0, what is already searched, so it is not repeated

*From the position file's coverage section, eight sweeps and 103 sources*: GIT and the classifying problem; Z-eigenvectors of symmetric tensors, three times; the Hamilton ODE as a classification problem; orbit spaces; Banach's theorem and global maximisers of cubic forms; DDVV, Böttcher–Wenzel, the per-matrix cubic, Horn convexity; trace polynomials over tuples, joint $c$-numerical ranges, orthostochastic matrices; the Kähler side and the Bochner tensor; Jordan cubic norms; 2025–26 arXiv on the problem or the ODE; the statement stripped of names for invariant theory and real algebraic geometry; the second-kind operator; Osserman tensors; axial algebras.

**The eighth sweep's verdict, which this one must beat: *the outside is exhausted for this statement.*** *Its top route, the Osserman endgame, was registered and closed the same day.*

**What this sweep does differently.** *It does not search the general statement again. It searches two SPECIFIC targets that did not exist as targets until [I104](../plan.md)'s accounting closed today, and both are phrased in objects outside this programme's dialect.*

1. **A step lossy at a SATURATED Gram corner.** Three planes pairwise at cosine $\tfrac13$, the Gram bound $\sum u_i^2\le\tfrac53t$ saturated, and the question is what inequality is still lossy there. *Tight frames, equiangular configurations, the geometry of three subspaces.*
2. **EXCLUDING the stratum** of critical points with two nonzero block components and $\tau>0$, rather than bounding $\theta$ within it. *Rigidity, non-existence, constraints that kill a stratum outright.*

## Batch 1, four angles in parallel, two per target

**Target 1, the saturated Gram corner, lands in a literature no previous sweep touched: FUSION FRAMES.** *Three subspaces with a bound on $\sum\lVert P_iD\rVert^2$ saturated is the definition of a TIGHT fusion frame, and three pairwise-equiangular subspaces saturating the Conway–Hardin–Sloane simplex bound are an EQUICHORDAL tight fusion frame.* Sources returned: [Equiangular subspaces in Euclidean spaces](https://arxiv.org/pdf/1703.05048), [Equiangular lines via matrix projection](https://arxiv.org/html/2110.15842), [Tight $p$-fusion frames](https://arxiv.org/pdf/1201.1798), [Certifying the novelty of equichordal tight fusion frames](https://arxiv.org/pdf/2103.03192), [Fusion Frames: Existence and Construction](https://arxiv.org/html/0906.5606v1), [Robust dimension reduction, fusion frames, and Grassmannian packings](https://www.sciencedirect.com/science/article/pii/S1063520308000249). **The mechanism, before any of these is read**: saturation of a fusion-frame bound is a RIGIDITY statement about where the vector sits relative to the subspaces, so a step that bounded something without using that rigidity is lossy exactly at saturation, which is the criterion the position file states.

**Target 2, excluding the stratum, returned a result of exactly the right SHAPE at $n=3$.** [Extremal cubics on the circle and the 2-sphere](https://arxiv.org/pdf/2110.07946), Lemma 4.9: *the critical points of a homogeneous cubic on $S^2$ cannot be scattered arbitrarily; their Gramian is constrained.* **That is a statement about WHERE critical points can lie, which is the shape of an exclusion rather than a bound.** Whether it has a higher-dimensional form is the question to read for.

**And one DIRECT hit on the problem**: [Weyl Tensors, Strongly Regular Graphs, Multiplicative Characters, and a Quadratic Matrix Equation](https://arxiv.org/pdf/2204.02706), which names Hamilton's $\#$ on Weyl tensors and strongly regular graphs, the objects of [L68](../findings/INDEX-results.md) and [L74](../findings/INDEX-results.md). *Checked against the shelf below before anything is claimed about it.*

**Nothing returned for the fourth angle**, the Hamilton equation with a block structure excluded, beyond curvature-functional papers that are not about this equation.

## Batch 2, the mechanism sharpened by a seconds-long screen, and target 2 exhausted

**THE FRAME OPERATOR'S TOP EIGENSPACE IS ONE-DIMENSIONAL.** *For three 2-planes pairwise at principal cosines $(\tfrac13,0)$, which is what the [I104 note](2026-09-14-I104-tau-positive.md) records for the three pattern planes, the frame operator $S=\sum_iP_{\Pi_i}$ has spectrum $\tfrac53$ once, $1$ three times, $\tfrac23$ twice, with the top eigenvector $a_1+a_2+a_3$ in the planes' first principal directions.* **So saturating the Gram bound pins $D$ to a LINE**, $D=\sqrt{t/5}\,(a_1+a_2+a_3)$ up to sign, **and that single vector forces $u_i=\sqrt{5t/9}=0.438432$ for all three at $t=0.346$**, which reproduces the recorded pin to six decimals and is the control that the geometry is the record's.

**What that means for the criterion.** *At the binding corner $D$ has NO freedom. Any step downstream of the Gram bound that bounds a quantity by its worst case over all $D$ of norm $\sqrt t$, or over all $D$ with the given $u_i$, is lossy there by exactly the difference between that worst case and the value at the pinned line.* **That is a step lossy at the binding corner, which is the only kind the position file says can close the $0.0148$**, and it is a MECHANISM rather than a source: it applies to every downstream step at once.

**Target 2, excluding the stratum, is EXHAUSTED by this sweep.** *Two further searches, for a higher-dimensional Gramian constraint on a cubic's critical points and for exclusion by the sign of a triple product, returned [Ivanova–Hildebrand](../references/ivanova-hildebrand-2021-extremal-cubics/notes.md) again, [Eigenvectors of tensors, a primer](https://arxiv.org/pdf/1810.05030) which is the Z-eigenvector literature three earlier sweeps read, and nothing else.* **No mechanism for emptying the stratum exists in the field as far as nine sweeps can find.**

## Phase 3a, the screen: the sweep's one mechanism is ON THE RECORD and closed there

**[The I104 note](2026-09-14-I104-tau-positive.md), line 85, written 2026-09-16**: *"the gain vanishes exactly where the Gram bound is attained, and that is derivable. Attainment puts $D$ along $G_e$'s top eigenvector, which is $(1,1,1)$... so all $\alpha_i$ are equal and maximal, $\alpha_i=1$ gives $x_i=\tfrac1{\sqrt3}$... **so the shared-pair coefficient EQUALS $\max(x,y,z)$ there, and step 8 is tight at the same configuration.**"*

**So the pinning is known, and what it does is make EVERY step tight simultaneously rather than expose a lossy one.** *The fusion-frame framing is a cleaner language for the same fact, and the one-dimensional top eigenspace is a sharper statement of it, but the consequence the record already drew is the one that matters: at the binding corner nothing is slack.* **Batch 2's mechanism is therefore not a source.** *It is, however, the strongest statement yet of WHY the chain cannot close, and it points at the one route below.*

**Nine sweeps have now read the outside**, and the ninth adds fusion frames and extremal cubics to the shelf and returns the same verdict on the general statement.

## Phase 3b, the routes, graded on section 1's rubric

**THE FINDING THAT MAKES A ROUTE: THE BINDING CORNER IS A SINGLE CONFIGURATION.** *Gram saturation pins $D$ to a line. That pins $u_i$ to $\sqrt{5t/9}$, all equal. Line 85 pins $x_i=\tfrac1{\sqrt3}$ and the shape to $(2,-1,-1)$. With equal $N_i$ confirmed today, the deficit-carrying configuration has no free parameter left but $t$, and $t=0.346$ is where the chain is worst.* **The chain bounds $\theta$ over a REGION and is short by $0.0148$; but the point where it is short is now ONE explicit configuration.**

| # | route | closes | attackable | margin | analytic | value | how close to a proof of the goal |
|---|---|---|---|---|---|---|---|
| **1** | **Check the pinned corner against the FULL criticality system.** *The chain uses three scalar consequences of criticality. The corner is now explicit enough to substitute into every equation the record holds for a critical point of this block structure. If it fails any of them, the corner is INFEASIBLE, the true worst case sits at a less-pinned configuration where the Gram bound is slack, and the $0.26$ of Gram slack the record measured there is available to the chain.* | 2 | **3** | 1 | 1 | **6** | settles [I104](../plan.md) if the corner is excluded, which clears [R25](../routes.md)'s far region and leaves the climb to the goal on R25's own terms. *If the corner IS feasible, it is a critical point the chain cannot bound, and the item is a genuine counterexample candidate to its own statement, which is a different and larger finding.* |
| 2 | Rewrite the Gram step as a fusion-frame bound so every downstream step sees the pinning explicitly | 1 | 2 | 1 | 1 | 2 | tightens nothing on its own, since line 85 shows the pinning makes steps tight rather than slack; worth doing only as the language for route 1 |
| 3 | R17 or R18, the other live routes | 2 | 1 | 1 | 1 | 2 | unchanged by this sweep, first links still without method |
| 4 | [I73](../plan.md) directly | 3 | 0 | 1 | 1 | 0 | no route, and nine sweeps found none |

**RECOMMENDATION: ROUTE 1, AND IT IS THE ONLY ONE THIS SWEEP EARNED.** *Every previous attempt on [I104](../plan.md) hunted for slack in the chain. This one says the chain's worst point is a single configuration and asks whether that configuration EXISTS. That is exclusion rather than bounding, which is the position file's target 2, reached from target 1.* **Either answer is a result**: excluded, and R25's far region clears; feasible, and the record has an explicit candidate critical point above the bound it is trying to prove, which would be the most important object found in a month.

*What it costs: substituting one explicit configuration into the criticality equations the record holds for $\mathcal D_n\oplus V_{Q_1}\oplus V_{Q_2}\oplus V_{Q_1\triangle Q_2}$, which is finite and bounded. What could falsify it before it starts: the corner may already be known infeasible under a name this sweep did not grep for, which the screen in [findings/](../findings/) at the start of the cycle would catch.*

