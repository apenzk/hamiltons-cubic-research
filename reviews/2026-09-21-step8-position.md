# Position file for the step 9 sweep, 2026-09-21

**Read this and nothing else of the record whole.** *It carries the open nodes, the fence posts bearing on them, the live items with their grades, and what eight previous sweeps already covered. The record runs to hundreds of files and reading it is neither possible nor necessary for this task.*

---

## The one question the sweep is for

**Both roads to Conjecture A are stopped, and the sweep is to find a third.** *What is wanted is a MECHANISM, from any field, that bears on one of the two blocked nodes below. A route from outside is worth more than a refinement from inside, because the inside is what the record already is.*

---

## The goal, and the two roads to it

**Conjecture A**: for $n\ge12$, $P$ on the unit sphere of $\mathcal W_n$ is maximised at the Weyl tensor of a balanced sphere product, where $\theta=\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$.

**Road 1, via [L105](../findings/bounds-relaxations.md), is PROVED from a two-value spectrum.** So it reduces entirely to:

> **[I73](../plan.md)**: a global maximiser of $P$ has a spectrum taking exactly two values. **NO ROUTE KNOWN**, graded `attackable` $0$, and it is the destination of the whole programme.

**Road 2 is [R25](../routes.md), value-bootstrap tubes, the primary route chosen by the user 2026-09-14 and running from the ROOT of $P$.** *Its near region is [L217](../findings/second-order.md) and its single-four-set far case is [L220](../findings/second-order.md), both Gate 2 passed.* It is blocked at:

> **[I104](../plan.md)**: every unit critical point in $\mathcal D_n\oplus V_{Q_1}\oplus V_{Q_2}\oplus V_{Q_1\triangle Q_2}$ with TWO NONZERO block components and $\tau>0$ has $\theta^2\le\tfrac65$.

---

## I104's obstruction, closed as an accounting on 2026-09-21

**The chain is short by $0.0148$ and cannot be repaired by adding sources to it.** *This is demonstrated rather than suspected, and it is why the sweep is being run.*

- **The target is confirmed.** Over the full three-dimensional grid of $(N_1,N_2,N_3)$ the worst configuration is ON the equal-$N_i$ diagonal, unequal $N_i$ buying $0.000000$ of extra shortfall ([screen_I104_unequal_N.py](../scripts/misc/screen_I104_unequal_N.py), control reproducing the recorded $-0.020422$ to six decimals).
- **The chain has exactly TWO named losses and both are spent.** The coupling bound $\kappa_i\le\tfrac{u_i}{\sqrt3}(t-u_i^2)$ is priced at $0.0089895$, $60.8\%$ of the deficit ([post F70](../findings/fence-posts.md)). The cross-term angle $\tfrac13$ IS the Gram geometry $\sum_iu_i^2\le\tfrac53t$, which the record proves EXACT, so it has no slack and it is the bound that PINS the binding corner.
- **The second $\tau$ bound is not independent**, giving $0.069131$ against the product bound's $0.069370$ at the binding configuration.
- **No third loss is named anywhere.**

**The criterion a successor must meet**: a step LOSSY AT THE BINDING CORNER, where the Gram bound saturates at $u=\sqrt{5t/9}=0.438432$ at $t=0.346$ and $\lvert c\rvert\ge0.575579$ (**magnitude, not $\max$**, [r1063](REVIEW_r1063.md)). *A source slack elsewhere and zero there closes nothing. That single test kills every attempt made so far, including one worth $0.2505$ in a regime that is not binding.*

---

## The fence posts that bear on these two nodes

*A route one of these kills is the most expensive kind of proposal, because it looks new.*

| post | what it closes |
|---|---|
| **F43** | **No per-row condition closes $d\ge3$.** A spectrum passing every per-row condition exceeds $\theta_0(12)$, so no inequality derived one row at a time can force the bound at three or more eigenvalues. A successor must COUPLE ROWS. |
| **F70** | The $x\to\kappa_i$ link is real, sharp and TOO SMALL for [I104](../plan.md): $0.0089895$ against $0.0148$. |
| **F71 / R29** | The Osserman endgame, registered and CLOSED the same day, its warrant false. |
| **F72** | Birkhoff settles the COMMUTING case of [R28](../routes.md) and cannot reach the rung. |
| **F69** | A maximality input phrased on a Lagrange field can be criticality restated; a genuine one must see the second variation or the value. |

**And one live warning**: [W7](../findings/INDEX-traps.md), the $\theta_0(n)$ threshold at $n\ge12$. Its one NAMED witness was killed by [I24a](../plan.md) on 2026-09-21 (max $\theta=0.9242643$, exactly $\tfrac{74239}{10280}m$, Gate 2 by [r1056](REVIEW_r1056.md) and [r1057](REVIEW_r1057.md)), but [r1057](REVIEW_r1057.md) screened nearby spectra at $1.3193$, $1.3102$ and $1.2904$, all ABOVE the threshold, so the obstruction CLASS is open.

---

## The live routes, with their states

| route | state |
|---|---|
| **R25** | **LIVE, PRIMARY**, blocked at [I104](../plan.md) as above |
| R17 | LIVE, the lifted Jäger chain, its global half split into I2, I3, I6 |
| R18 | LIVE, coordinate-diagonality as an integrality condition, **its first link has NO METHOD** |
| R16 | LIVE, reserve, blocked at I18 |
| R11 | LIVE, fallback, the conjunction |
| R12 | STALLED |

*Twenty-six of the twenty-nine registered routes are closed.*

---

## Section 1's grading, and what it says about itself

| grade | count in section 1 |
|---|---|
| 3 | 2 |
| 2 | 8 |
| 1 | 4 |
| 0 | 6 |

**Section 1 tops out at grade 3 and NONE of its items lie on a path to [I73](../plan.md).** *All six zeros are zeroed on the same factor, `closes`: they repair support under results the record already carries, which is the verification loop's work.* **That is the state the skill says to answer by inventing a route rather than working the top.**

---

## What EIGHT previous sweeps already covered, so it is not repeated

**Shelf: 103 sources.** *From the seven earlier sweep files plus 2026-09-17's:*

GIT and the classifying problem; Z-eigenvectors of symmetric tensors, three separate times; the Hamilton ODE $R^2+R^\#=\lambda R$ as a classification problem; orbit spaces; Banach's theorem and global maximisers of cubic forms; DDVV and Böttcher–Wenzel, the per-matrix cubic, Horn convexity; trace polynomials over tuples, joint $c$-numerical ranges, orthostochastic matrices and linear optimisation over them; the Kähler side and the Bochner tensor; Jordan cubic norms; 2025–26 arXiv naming the problem or the ODE; the statement stripped of names put to the invariant-theory and real-algebraic-geometry communities; the second-kind operator; Osserman tensors; axial algebras.

**AND THE EIGHTH SWEEP'S OWN CONCLUSION, WHICH THIS ONE MUST BEAT:** *"the outside is exhausted for this statement."* **Its top-ranked route, the Osserman endgame, was registered and CLOSED the same day.**

---

## So what would make this sweep different

**The previous eight searched the GENERAL statement and found the field does not carry it.** *This one has two SPECIFIC, quantified targets that no previous sweep had, because [I104](../plan.md)'s accounting was only closed today.*

1. **A step lossy at a saturated Gram corner.** The question is not "how do I bound a cubic form" but: given three planes pairwise at cosine $\tfrac13$ with the Gram bound SATURATED, what inequality is still lossy there? *That is a question about tight frames and equiangular configurations, not about curvature.*
2. **Excluding a stratum rather than bounding on it.** [I104](../plan.md) is a statement about critical points with two nonzero block components and $\tau>0$. *Nothing on the record has asked whether that stratum is EMPTY or otherwise unreachable, as opposed to bounding $\theta$ within it.*

**Both are stated in objects a mathematician outside this programme could recognise**, which the general statement is not.
