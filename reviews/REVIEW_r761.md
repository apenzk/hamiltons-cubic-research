# Review 761, [Lemma L174](../findings/second-order.md), whether I36's shape claim is the budget claim, Gate 2

**Cold brief.** [BRIEF-g2-l174.md](BRIEF-g2-l174.md) was read in full before any file of the record, and the verdicts below were fixed before [second-order.md](../findings/second-order.md)'s own L174 block was opened. **No numerical work was done.** Every value in this report is exact (rational or symbolic) and the one screen run is named as a screen where it appears. The Lean toolchain is present at `~/.elan/bin` and [L174.lean](../lean/HamiltonsCubic/Results/L174.lean) was **built in the kernel**, not audited at statement level: `lake build HamiltonsCubic.Results.L174` completes, 825 jobs. Log: [agent_logs/g2-l174-r761.log](../agent_logs/g2-l174-r761.log).

| # | claim | verdict |
|---|---|---|
| 1 | The equivalence itself: for unit $W$, (every local maximiser with $\theta>\sqrt{3/2}$ is coordinate-diagonal in some frame) $\iff$ (every such maximiser has $\kappa^2=2$) | **CONFIRMED** |
| 2 | The $\kappa^2$ reading is the extremal one throughout, with no slide into the per-frame $t_F$ | **CONFIRMED**, no swap anywhere in the chain |
| 3 | The unit-norm step, $2\lVert M\rVert_F^2\rightsquigarrow2$ | **CONFIRMED, HYPOTHESIS OWED**, true under the record's normalisation, and the block says only *"for unit $W$"*, which is the word [r101](REVIEW_r101.md) already filed a correction on against L94 itself |
| 4 | The quantifier step, $W$ outside and the frame inside | **CONFIRMED**, and it is a first-order tautology, including on the empty class |
| 5 | L94's *"exactly"* is a genuine biconditional carrying no dropped hypothesis | **CONFIRMED** at source, [bispectral.md](../findings/bispectral.md) line 217 and [r101](REVIEW_r101.md)'s one-line proof |
| 6 | Remark (b): $\theta_0(12)^2=\tfrac{220}{144}>\tfrac32$, so $\theta>\sqrt{3/2}$ is the weaker hypothesis | **CONFIRMED**, exactly: $\tfrac{220}{144}=\tfrac{55}{36}$ |
| 7 | Remark (b): it *"covers strictly more maximisers"* | **CONFIRMED, and the record holds the witness the remark does not name**, $S^5\times S^7$ at $n=12$, $\theta^2=\tfrac{264}{175}$, strictly inside the band |
| 8 | Remark (a): the reformulation *"leaves the item exactly as open"* | **CONFIRMED**, nothing is lost in either direction, and the adjective *"continuous"* is the correct and only available regularity |
| 9 | [L174.lean](../lean/HamiltonsCubic/Results/L174.lean)'s docstring: the quantifier step *"is the whole risk"* | **REFUTED**, the quantifier step is the one part carrying no risk; the file assumes the two steps where the record's own hazards live |
| 10 | The maximiser hypothesis does work in L174 | **REFUTED**, $\theta$ and local maximality are idle; the equivalence holds for every unit $W$ and for every class whatever |
| 11 | `threshold_below_theta_zero` | **CONFIRMED**, $\tfrac32<\tfrac{220}{144}$, and it is the file's only theorem with content |

**Actionable summary.** The mathematics is right and the swap the brief feared did not happen; write the norm into the statement, state the lemma in the generality it actually has, and stop the Lean file's docstring claiming the kernel checked the risky step.

## 0. Conventions, fixed once

Fixed from [conventions.md](../findings/conventions.md), by line, before anything below was derived.

- **$t$ and $\kappa$** (line 23): $t=t_F=\lVert K(F)\rVert_F^2$ **per frame**, and $\kappa^2=\max_Ft_F$. *"The per-frame and extremal readings are distinct and have been swapped."*
- **$K$** (line 136): the symmetric hollow $n\times n$ sectional matrix, $K_{ab}=W_{abab}$, and $t=\lVert K\rVert_F^2$ summed over **ordered** pairs. Line 138 records that the unordered reading gives $\tfrac t2$ and is inconsistent with $t\le2$; the record's is the ordered one, and in operator terms $t=2\lVert\operatorname{diag}W\rVert^2$ in the pair basis.
- **Coordinate-diagonal** (line 69): diagonal in coordinate $2$-planes $e_i\wedge e_j$ of an orthonormal frame of $\mathbb R^n$, an operator diagonal on $\Lambda^2\mathbb R^n$ is a different and weaker condition.
- **$M$** is the operator on $\Lambda^2$ (line 92, $\mu=\operatorname{spec}(M)$ at $\lVert M\rVert_F=1$ with $\sum\mu^2=1$), and $\lVert M\rVert_F=\lVert W\rVert_{\Lambda^2}$: line 118 gives $\lVert\mathring W\rVert_F^2=3\lVert W\rVert_{\Lambda^2}^2$ and [bispectral.md](../findings/bispectral.md) gives $\lVert\mathring W\rVert_F^2=3\lVert M\rVert_F^2$ for the same left side.
- **The letter $M$ carries a second object** (line 153): the $n\times n$ sectional matrix in [diagonal-half.md](../findings/diagonal-half.md), where $\lVert K\rVert_F^2=2$ at a unit Weyl tensor. *The two norms differ by $\sqrt2$.*
- **A live cross-file normalisation trap** (line 93): [post F33](../findings/INDEX-traps.md) works at $\lvert W\rvert_4=1$ and [bispectral.md](../findings/bispectral.md) at $\lVert M\rVert_F=1$; line 91 relates them, $\lvert W\rvert^2=4\lVert W\rVert_F^2$.
- **Sphere-product value**, from [target.md](../findings/target.md) line 494, derived independently by two reviewers: $\theta^2(S^p\times S^q)=\dfrac{2(p-1)(q-1)(n-1)}{pq(n-2)}$ at $n=p+q$.

## Hypothesis inventory

What L174 as written consumes, what it silently consumes, and what it does not need.

| ingredient | stated in the block | actually needed |
|---|---|---|
| [Lemma L94](../findings/LEDGER.md)'s bound $\kappa^2\le2\lVert M\rVert_F^2$ | yes | yes, for the $(\Leftarrow)$ direction only in the degenerate sense; the equality case carries both |
| L94's equality case as a biconditional | yes, and it is one | yes, both directions are used, one per implication |
| $\lVert M\rVert_F=1$, with $M$ the $\Lambda^2$ operator | **no**, the block says only *"for unit $W$"* | **yes**, and it is the sole source of the numeral $2$ |
| $\kappa^2=\max_Ft_F$ attained | asserted by the symbol $\max$ | yes; supplied by compactness of $O(n)$ and continuity of $F\mapsto t_F$ |
| $\theta>\sqrt{3/2}$ | yes | **no**, idle in L174, load-bearing in I36 |
| local maximality | yes | **no**, idle in L174 |
| criticality | no | no |
| $\ker W=0$ | no | no |
| non-emptiness of the qualifying class | no | no, the equivalence is vacuously true on the empty class, both sides being $\top$ |

## 1. Attack item 1, the $\kappa^2$ reading, where the brief says the risk is

**No swap. The chain uses the extremal reading at every step, and the two quantifiers it pairs are the matching pair.**

L94 at source, [bispectral.md](../findings/bispectral.md) line 217: *"$\kappa(W):=\max_F\lVert K(F)\rVert_F$ over orthonormal frames is $O(n)$-invariant, satisfies $\kappa^2\le2\lVert M\rVert_F^2$ … with equality **iff $W$ is coordinate-diagonal in some frame**."* Both sides of that equality case are extremal: $\max_F$ on the left, $\exists F$ on the right. L174 pairs exactly those two, writing $\kappa^2=\max_Ft_F$ in its own statement and *"coordinate-diagonal in some frame"* in the shape claim. **The existential and the maximum are the same quantifier**, and that is the whole of what has to hold.

The per-frame form is on the record too, at [bispectral.md](../findings/bispectral.md) line 480 inside the L54 block: *"[Lemma L94] gives $t_F\le2$, with equality exactly when $W$ is coordinate-diagonal in that frame, the bound is per-frame, and $\kappa^2=\max_Ft_F$ is where the extremal reading belongs."* The two forms are consistent and the per-frame one is the stronger: taking $\max_F$ of $t_F\le2$ gives $\kappa^2\le2$, and

$$\kappa^2=2\iff\exists F:t_F=2\iff\exists F:W\text{ coordinate-diagonal in }F,$$

the first step by attainment and the second by the per-frame equality case. **So the extremal statement is a consequence of the per-frame one and not a substitution for it**, which is precisely the failure [conventions.md](../findings/conventions.md) line 140 fences, *"substituting the extremal value into a bound that decreases in $t$"*, the error at [DERIVE-mx1.md](DERIVE-mx1.md). Nothing in L174 substitutes into a bound; it reads an equality case.

**Arguing the opposite.** The strongest reading against L174 would be that its right-hand side means the per-frame $t_F=2$ *in the frame the maximiser is presented in*, under which the equivalence would be false, since a $W$ diagonal in some frame need not have $t_F=2$ in an arbitrary one. The block forecloses that reading in its own statement line, *"write $\kappa^2=\max_Ft_F$ for the vertex-matrix budget"*, before the display. **The reading is available only to someone who skips that clause**, and I record no discrepancy.

**One thing the machine-checked layer cannot see.** In [L174.lean](../lean/HamiltonsCubic/Results/L174.lean), `kappaSq : Weyl → ℝ` is an uninterpreted parameter. A swapped reading (`kappaSq` meaning the per-frame $t_F$ of a distinguished frame), typechecks identically and the theorem still goes through. **The kernel is blind to attack item 1 by construction.** That is not a defect in the file's mathematics; it is a defect in reading the file as evidence on this point, and section 7 takes it up.

## 2. Attack item 2, the unit-norm step, and the one hypothesis the block owes

**True as the record means it, and the block does not say what it means.**

L94's right side is $2\lVert M\rVert_F^2$. Setting it to $2$ requires $\lVert M\rVert_F=1$. The block's hypothesis is *"For unit $W$"*, and the record carries at least three live candidates for that phrase.

| reading of *"unit"* | $\lVert M\rVert_F^2$ | L94's ceiling | the budget claim would read |
|---|---|---|---|
| $\lVert W\rVert_{\Lambda^2}=1$, the record's operator norm | $1$ | $2$ | $\kappa^2=2$, **the intended one** |
| $\lvert W\rvert_4=1$, [post F33](../findings/INDEX-traps.md)'s normalisation | $\tfrac14$ | $\tfrac12$ | $\kappa^2=\tfrac12$ |
| $M$ read as the sectional matrix, [conventions.md](../findings/conventions.md) line 153 | $2$ | $4$ | $\kappa^2=4$ |

**The intended reading is recoverable and correct.** $M$ is the $\Lambda^2$ operator throughout [bispectral.md](../findings/bispectral.md), where L94 lives; line 92 of [conventions.md](../findings/conventions.md) puts that file at $\lVert M\rVert_F=1$; line 85 puts the $\tfrac12$ at the $\Lambda^2$ level and plain Frobenius at the operator level, so $\lVert M\rVert_F^2=\operatorname{tr}(M^2)=\sum\mu^2$; and line 153 gives $\sum_\alpha\lambda_\alpha^2=\operatorname{tr}(W^2)=1$ at a unit Weyl tensor. **So $\lVert M\rVert_F=1$ and $\lVert W\rVert=1$ are the same condition**, and the numeral $2$ is right.

**The third reading is self-refuting, which is worth writing down because it is the cheapest disambiguation.** Under it, $\kappa^2=\max_F\lVert K(F)\rVert_F^2$ and $\lVert M\rVert_F^2=\lVert K\rVert_F^2$ are the same kind of object, so L94 reads $\max_F\lVert K_F\rVert_F^2\le2\lVert K\rVert_F^2$, and its equality case would say a coordinate-diagonal unit $W$ has $\kappa^2=4$, against [conventions.md](../findings/conventions.md) line 136's $t=2$ at exactly that configuration. **A reader who takes the sectional $M$ gets a contradiction inside L94 itself**, so the reading cannot survive; the second reading gets no such warning and silently halves the constant.

**The discrepancy is that this word has already cost a correction on this exact lemma.** [r101](REVIEW_r101.md), one of L94's own Gate 2 pair, filed it: *"'$\kappa^2\le2\lVert W\rVert^2$' is sharp only if $\lVert W\rVert$ means $\lVert M\rVert_F$. Read as the tensor Frobenius norm it is slack by a factor 4."* L174 restates L94 and drops the word the correction was about. **Repair, one clause:** *"For $W$ with $\lVert M\rVert_F=1$, equivalently unit in the record's $\Lambda^2$ operator norm"*, in the block and in the `IsUnit` docstring of [L174.lean](../lean/HamiltonsCubic/Results/L174.lean).

## 3. Attack item 3, the quantifier step

**Immediate, and it survives the empty class.**

The shape is: from $\forall W\,(P(W)\to(A(W)\leftrightarrow B(W)))$ infer $(\forall W\,(P\to A))\leftrightarrow(\forall W\,(P\to B))$, with $P(W)$ the conjunction *unit, local maximiser, $\theta>t$*, $A(W)$ the existential $\exists F\,\mathrm{diag}(W,F)$ and $B(W)$ the equation $\kappa^2(W)=2$. **This is a tautology of first-order logic with no side condition.** The frame quantifier is inert: it sits entirely inside $A$, is never moved past $\forall W$, and is never instantiated, the pointwise biconditional is applied whole.

**The empty case.** If no unit local maximiser has $\theta>\sqrt{3/2}$, both sides are vacuously true and the biconditional holds. **The equivalence is therefore not evidence that the class is inhabited**, and the record does not claim it is, though section 6 shows the class *is* inhabited, at $S^5\times S^7$ and $S^6\times S^6$.

The kernel confirms this step in [L174.lean](../lean/HamiltonsCubic/Results/L174.lean)'s `shape_iff_budget`, whose whole proof is `constructor` followed by two `exact`s composing `h94 W hu` with the hypothesis. **Nothing else is used**, which is section 7's point.

## 4. Attack item 4, is L94's *"exactly"* a biconditional at unit norm

**Yes, and it carries no hypothesis the reformulation drops. Read at source.**

[r101](REVIEW_r101.md)'s one-line proof, which [r102](REVIEW_r102.md) agrees with: $M(F)=\Lambda^2(F)\,M\,\Lambda^2(F)^{\mathsf T}$ is an orthogonal conjugation, so $\sum_\alpha M(F)_{\alpha\alpha}^2\le\lVert M(F)\rVert_F^2=\lVert M\rVert_F^2$, with **equality iff every off-diagonal entry of $M(F)$ vanishes**, i.e. iff $M(F)$ is diagonal, i.e. iff $W$ is coordinate-diagonal in $F$. With $t_F=2\lVert\operatorname{diag}M(F)\rVert^2$ from [conventions.md](../findings/conventions.md) line 138 (the ordered-pair sum), this is $t_F\le2\lVert M\rVert_F^2$ per frame, and $O(n)$ compact with the objective continuous gives the max, hence $\kappa^2\le2\lVert M\rVert_F^2$ with equality iff some frame diagonalises.

**The equality case is the equality case of a sum of squares.** There is no majorization, no Schur–Horn, no criticality and no genericity in it: $\sum_{\alpha\ne\beta}M(F)_{\alpha\beta}^2=0$ iff each term is zero. **So there is no hypothesis available to be dropped**, and the *"exactly"* is a biconditional in the strong sense, both directions, at every $W$, with only the scaling fixed.

**Arguing the opposite.** The one place a hypothesis could hide is the identification *"$M(F)$ diagonal $=$ $W$ coordinate-diagonal in $F$"*, which is a definition ([conventions.md](../findings/conventions.md) line 69) rather than a theorem, and the definition warns that diagonality as an operator on $\Lambda^2$ is a different condition. **The $M(F)$ here is the operator written in the coordinate pair basis of $F$**, so *diagonal in that basis* is exactly *diagonal in coordinate $2$-planes*, and the two senses do not diverge. Nothing owed.

## 5. Attack item 5, remark (b), verified exactly, and the reading corrected

**The arithmetic is right.** $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$ gives $\theta_0(12)^2=\tfrac{2\cdot11\cdot10}{144}=\tfrac{220}{144}=\tfrac{55}{36}$, and $\tfrac{55}{36}-\tfrac32=\tfrac{55-54}{36}=\tfrac1{36}>0$. Cross-checked two ways: it agrees with [conventions.md](../findings/conventions.md) line 73's $\tfrac{99}{65}<\tfrac{55}{36}<\tfrac{220}{117}$ and with the stated separation $\theta_0(n)^2-\tilde\theta_0(n)^2=\tfrac{8(n-1)}{n^2(n+1)(n-2)}$, which at $n=12$ is $\tfrac{11}{2340}$ and satisfies $\tfrac{99}{65}+\tfrac{11}{2340}=\tfrac{3575}{2340}=\tfrac{55}{36}$ exactly. *(Screened in exact rationals; the screen reproduces every identity in this paragraph and is recorded as a screen.)*

**And the direction is right.** $\theta\ge\theta_0(12)$ implies $\theta>\sqrt{3/2}$, so $\{\theta>\sqrt{3/2}\}\supsetneq\{\theta\ge\theta_0(12)\}$: the hypothesis is weaker and the class larger.

**On the brief's question, is *"weaker hypothesis, more maximisers"* the right reading.** It is right and it is half the sentence. A weaker hypothesis on a universally quantified statement makes the **theorem stronger and the item harder**, and neither the block, nor [plan.md](../plan.md), nor the Lean docstring says so. The operational consequence is the one worth recording: **I36 as filed proves more than Conjecture A consumes.** Whatever [Lemma L57](../findings/problem.md) needs, it needs it at the maximisers Conjecture A is about, which sit at or above $\theta_0(n)$; I36 additionally covers the band $(\sqrt{3/2},\theta_0(12))$. **Weakening I36's threshold from $\sqrt{3/2}$ to $\theta_0(n)$ would leave the conjecture served and the item strictly easier**, and the record nowhere records that this is available. I flag it as an option, not a defect, with the caveat of section 6, that the band is populated and so the weakening is a real reduction rather than a cosmetic one.

## 6. Attack item 5, continued, *"covers strictly more maximisers"* is true, and the record holds the witness

**Confirmed, with an on-record witness the remark does not name.** Strict inclusion of the hypothesis regions does not by itself give strictly more *maximisers*; a local maximiser strictly inside the band $(\sqrt{3/2},\theta_0(12))$ is needed. The record has one.

$S^5\times S^7$ at $n=12$. From [target.md](../findings/target.md) line 494's formula, derived there independently by two reviewers,

$$\theta^2(S^5\times S^7)=\frac{2\cdot4\cdot6\cdot11}{35\cdot10}=\frac{528}{350}=\frac{264}{175},$$

matching [LEDGER.md](../findings/LEDGER.md) line 1642's $\tfrac{264}{175}$ and [INDEX-values.md](../findings/INDEX-values.md)'s $1.228239=\sqrt{264/175}$. The same formula returns $\tfrac{55}{36}$ at $(6,6)$, so it reproduces $\theta_0(12)^2$ and is not an independent convention. Then

$$\tfrac32=\tfrac{525}{350}<\tfrac{264}{175}=\tfrac{528}{350}\qquad\text{and}\qquad\tfrac{264}{175}=\tfrac{9504}{6300}<\tfrac{55}{36}=\tfrac{9625}{6300},$$

so $\sqrt{3/2}<\theta(S^5\times S^7)<\theta_0(12)$, strictly at both ends. **And it is a local maximiser**: [graded-half.md](../findings/graded-half.md) line 331 records that [Lemma L69](../results.md) *"makes each sphere product with both factors $\ge5$ a local maximum"*, and $(5,7)$ has both factors $\ge5$. It is also coordinate-diagonal, the same line placing it in the $(6,6)$ coordinate grading slice, so it satisfies both sides of L174's equivalence and by L94 has $\kappa^2=2$, consistent, and consistent with [r101](REVIEW_r101.md)'s *"every sphere product, padded or not, has $\kappa^2=2.000000$ exactly."*

**So remark (b)'s strictness holds, and the block should name the witness**, the more so because the same fact retires a natural simplification: one cannot weaken I36's threshold to $\theta_0(12)$ and call it the same item, since the band it drops is inhabited by a local maximiser.

## 7. Attack item 6, what the reformulation loses, and what the machine-checked file actually establishes

**Nothing is lost in the equivalence; something is lost in the account of what was checked.**

**The reformulation loses no information.** Both directions run through L94's single biconditional at each $W$, so the two statements are interchangeable pointwise. The gain is real and modest: $\kappa^2$ is an $O(n)$-invariant real-valued function the record already estimates, and $2-\kappa^2\ge0$ turns I36 into a **saturation claim** (*does the maximiser attain the vertex-matrix ceiling*), to which the defect $2-\kappa^2$ can be attacked as a function. **The existential over frames is not removed, it is repackaged inside $\max_F$**, which is why remark (a)'s *"leaves the item exactly as open"* is the honest half of the remark and I confirm it.

**Remark (a)'s adjective is the right one and I checked no stronger one was available.** $\kappa^2=\max_Ft_F$ is a maximum of a polynomial family over the compact $O(n)$, hence continuous, but **not differentiable in general**, and specifically not at the points the item is about: at a coordinate-diagonal $W$ the maximising frame is non-unique (permutations, signs, and the stabiliser all attain), which is exactly where a max-function loses smoothness. **The block says *"continuous"* and stops**, which is correct; a reader tempted to write *"smooth"* would be wrong at every point of interest.

**One caution on the value of the mechanism, stated with its distinction.** The section of [bispectral.md](../findings/bispectral.md) that houses L94 is headed *"$\kappa$, the frame-optimised diagonal spread, confirmed as an object, inert as a lever"*, and [r101](REVIEW_r101.md)'s Error 1 proves that *"an $\ell^2$ lower bound on the diagonal is vacuous at every attainable value, including $\kappa^2=2$."* **That inertness is about $\kappa$ as an input to the bi-spectral relaxation**, whereas I36 wants $\kappa^2=2$ as an *output*. The two uses are different and the finding does not transfer. But it does bound the optimism: **the record has no route that produces $\kappa^2=2$ at a maximiser**, and re-grading `attackable` upward on the strength of L174 would be grading a restatement.

**Where the loss actually is, [L174.lean](../lean/HamiltonsCubic/Results/L174.lean)'s account of itself.** Its docstring says the file *"lets the kernel check the quantifier step, which is the whole risk"*. That is refuted three ways.

1. **The quantifier step is the one step with no risk in it**, a first-order tautology, section 3.
2. **`shape_iff_budget` has no mathematical content about Weyl tensors.** `Weyl`, `Frame`, `IsCoordDiagonal`, `kappaSq`, `theta`, `IsUnit` and `IsLocalMax` are all uninterpreted parameters, so the theorem holds under every interpretation, the trivialising ones included. It is a schema, and it would typecheck unchanged if `kappaSq` meant the per-frame $t_F$, which is attack item 1.
3. **The two steps that do carry risk are inside `def L94`, as a hypothesis.** As typed, `L94` is `∀ W, IsUnit W → (kappaSq W = 2 ↔ ∃ F, IsCoordDiagonal W F)`, **not** L94, which is $\kappa^2\le2\lVert M\rVert_F^2$ with equality exactly at coordinate-diagonal. The passage from one to the other is the unit-norm step of section 2 and the extremal reading of section 1, and **both are assumed rather than checked.** The docstring's *"`L94` itself is taken as a hypothesis; it is on the record with its own Gate 2"* is therefore inaccurate in a specific way: what is taken as a hypothesis is L94's unit-norm specialisation with the constant already evaluated, and *that* statement has no Gate 2, it is what L174 is deriving.

**This is a defect in the file's claim about itself, not in its mathematics.** The file is true. **Repair:** rewrite the docstring to say the kernel checks the quantifier shuffle and assumes the specialisation, and if the file is to earn its keep, state the specialisation's two ingredients as named hypotheses, a `NormOne : Weyl → Prop` with `IsUnit W → kappaSqBound W = 2`, and `kappaSq` defined as a supremum over `Frame` rather than as an opaque function, so that the swap in attack item 1 becomes expressible.

`threshold_below_theta_zero` is fine: `(3 : ℚ) / 2 < 220 / 144`, `norm_num`, and it is the only theorem in the file whose content is not a tautology in its own parameters. Its docstring's report that *"an earlier version of this file asserted the reverse and the kernel refused it"* is exactly the use such a file is for, and I confirm the surviving direction.

## 8. Attack item 7, what *"local maximiser"* does here, which is nothing

**The hypothesis is idle, and the record does not say so.**

L94's proof is the equality case of a sum of squares (section 4). It consumes the scaling and nothing else: no criticality, no maximality, no $\theta$, no kernel condition. **So the biconditional $\kappa^2=2\iff\exists F\,\mathrm{diag}$ holds at every unit $W$**, and L174's equivalence holds with an arbitrary predicate in place of *"local maximiser with $\theta>\sqrt{3/2}$"*.

[L174.lean](../lean/HamiltonsCubic/Results/L174.lean) makes this visible and does not remark on it: `theta`, `IsLocalMax` and `t` appear in the statements of `I36_shape` and `I36_budget` and **nowhere in the proof of `shape_iff_budget`**. The proof is closed under replacing the filter by anything.

**So the honest statement of L174 is one line shorter and strictly more general:**

> For every unit $W$, $\kappa^2=2$ iff $W$ is coordinate-diagonal in some frame ([Lemma L94](../findings/LEDGER.md)'s equality case). Hence for **any** class $\mathcal C$ of unit tensors, $(\forall W\in\mathcal C:\exists F\,\mathrm{diag})\iff(\forall W\in\mathcal C:\kappa^2=2)$, and I36 is the instance $\mathcal C=\{$local maximisers with $\theta>\sqrt{3/2}\}$.

**Repair:** state it that way. As written the block invites the reading that something about maximisers has been established, and nothing about maximisers has been touched. This does not weaken the lemma, it is the lemma, correctly scoped.

## 9. Attack item 8, hypothesis inventory and the edges

The inventory is tabled above. The three edges the brief names:

- **$\kappa^2$ at a $W$ with kernel.** No obstruction. $t_F=\sum_{a\ne b}W_{abab}^2$ is defined at every $W$ and every $F$, and the equality case of section 4 never divides by anything. **A kernel is invisible to L94**, which is why $\kappa^2$ is defined at padded tensors, and the record uses it there, [r102](REVIEW_r102.md) reporting $\kappa^2$ at padded $W_{\mathbb{CP}^2}$.
- **Attainment of $\max_F$.** Confirmed and needed. $F\mapsto t_F$ is a polynomial in the entries of $F$, hence continuous, and $O(n)$ is compact, so the maximum is attained and $\kappa^2=\max_Ft_F$ is well posed rather than a supremum. [r101](REVIEW_r101.md) states this step explicitly in its one-line proof. **Had it been a supremum only, $\kappa^2=2$ would not license producing a diagonalising frame** and the $(\Rightarrow)$ direction of L174 would fail.
- **Non-emptiness.** Not needed (section 3), and satisfied anyway (section 6).

**A fourth edge, which the brief does not list and which is the sharpest thing in this review.** The strict inequality $\theta>\sqrt{3/2}$ is load-bearing, and the record's own catalogue sits one boundary point away from refuting I36.

- [nondegeneracy.md](../findings/nondegeneracy.md) line 646, quoting [r316](REVIEW_r316.md): padded $W_{\mathbb{CP}^2}$ is a Morse–Bott nondegenerate **local maximum at $\theta=\sqrt{3/2}$ exactly**, at $n=8,10,12$, *"so $\{\theta\ge\sqrt{3/2}\}\cap\mathrm{Crit}$ carries a non-sphere-product member at its boundary."*
- [r102](REVIEW_r102.md) line 124: *"Padded $W_{\mathbb{CP}^2}$ at $n=12$ has $\theta=1.224745=0.99087\,\theta_0(12)$ with $\kappa^2=1.0000000000$ exactly"*, consistent with [Lemma L95](../findings/bispectral.md)'s closed form $\kappa^2(\mathbb{CP}^m)=3/(m+1)$, which is $1$ at $m=2$.

**Consequently, at the non-strict threshold $\theta\ge\sqrt{3/2}$ both sides of L174 would be false**, $\kappa^2=1\ne2$, and by L94 that point is coordinate-diagonal in no frame. **The equivalence survives** (false $\iff$ false), which is a point in its favour and shows the reformulation is robust where the item is not; **I36 does not.** So the item's `<` is not stylistic, and neither the block nor remark (b) says this: remark (b) discusses the threshold's position relative to $\theta_0(12)$ above, while the live boundary is at $\sqrt{3/2}$ itself.

**The one soft link, named.** $\kappa^2(\text{padded }W_{\mathbb{CP}^2})=1$ is a $40$-start Riemannian ascent in [r102](REVIEW_r102.md), corroborated by L95's closed form at the unpadded point and by $\kappa^2(\text{padded})\ge\kappa^2(\text{unpadded})=1$, which is free since the padded frames include the unpadded ones. **What is not on file is an analytic proof that padded $W_{\mathbb{CP}^2}$ is coordinate-diagonal in no frame.** I did not construct one, the brief says I check the written proof rather than build my own, and hunting one would be a falsifier hunt this brief forbids. **Owed, and cheap enough to be worth owing**: it is what makes the strictness of I36's threshold a theorem rather than a numerical observation.

## 10. Attack item 9, what would break it

Ranked by how little would have to go wrong.

1. **The norm.** Read *"unit"* as $\lvert W\rvert_4=1$ and the budget claim becomes $\kappa^2=\tfrac12$, which is false at every sphere product. **One undefined word, and the numeral is out by a factor of four.** This is the live failure, section 2, and it has already been filed once against L94 by [r101](REVIEW_r101.md).
2. **The extremal reading.** Read $\kappa^2$ as the per-frame $t_F$ of a presented frame and the $(\Leftarrow)$ direction fails: a $W$ diagonal in some frame has $t_F<2$ in almost every other. Section 1 finds no such slide in the record, and section 7 finds the Lean file unable to detect one.
3. **The strictness of the threshold.** Replace `<` with `≤` and I36 is refuted by padded $W_{\mathbb{CP}^2}$, section 9, the equivalence surviving, the item dying.
4. **Attainment.** Replace $\max_F$ by $\sup_F$ over a non-compact group and $\kappa^2=2$ no longer yields a frame. Not a live risk on $O(n)$; it is a live risk for any generalisation off it.
5. **The equality case.** If L94's *"exactly"* were one-directional, L174 would keep whichever half survived and lose the other. Section 4 finds both halves, in one line, at source.
6. **The definition of diagonal.** Read *"coordinate-diagonal"* as *diagonal as an operator on $\Lambda^2$*, a weaker condition, fenced at [conventions.md](../findings/conventions.md) line 69, and L94's equality case no longer applies, since the Cauchy–Schwarz equality gives diagonality in the **coordinate pair basis** specifically.

**Nothing on this list is realised in the record as written.** Items 1 and 3 are unstated hypotheses that a reader can get wrong; the rest are readings the block forecloses.

## Overall verdict

**PROVEN, hypotheses corrected.**

The equivalence is true, its proof is the one L94 supports, and the reading the brief flagged as the risk (the per-frame $t_F$ substituted for the extremal $\kappa^2$), **does not occur anywhere in the chain**. Both remarks are correct; remark (b)'s arithmetic checks exactly and its strictness has an on-record witness. Three corrections are owed, none touching the mathematics:

1. **Write the norm into the statement.** *"For unit $W$"* → *"for $W$ with $\lVert M\rVert_F=1$, equivalently unit in the record's $\Lambda^2$ operator norm"*, in the block and in `IsUnit`'s docstring. [r101](REVIEW_r101.md) filed this correction against L94 itself, and L174 restates L94 without it.
2. **State the lemma in the generality it has.** Local maximality and $\theta>\sqrt{3/2}$ are idle; the content is *for every unit $W$*, and I36 is one instance.
3. **Correct [L174.lean](../lean/HamiltonsCubic/Results/L174.lean)'s docstring.** The quantifier step is a tautology and is not *"the whole risk"*; the risk lives in the specialisation the file assumes, and `def L94` is that specialisation rather than L94.

Two additions the block would be stronger for: **name $S^5\times S^7$** as the witness that the band is inhabited, and **record that the threshold's strictness is load-bearing**, padded $W_{\mathbb{CP}^2}$ sitting at $\theta=\sqrt{3/2}$ exactly with $\kappa^2=1$, with the analytic proof that it is coordinate-diagonal in no frame filed as owed.
