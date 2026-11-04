# Reviewer 762, Lemma L174: whether I36's shape claim is the budget claim, and its two remarks

*Gate 2, [BRIEF-g2-l174.md](BRIEF-g2-l174.md), read cold. **No numerical work was done**: nothing was sampled, swept or searched, and every value below is exact rational or symbolic arithmetic done by hand. The one machine action is `lake build` on the file under review plus a `#print axioms` on its two theorems, which is reading the machine-checked layer rather than computing. Log: [agent_logs/g2-l174-r762.log](../agent_logs/g2-l174-r762.log).*

| # | claim | verdict |
| --- | --- | --- |
| 1 | The equivalence uses the **extremal** reading $\kappa^2=\max_Ft_F$ consistently, in the statement, the proof, [plan.md](../plan.md) and [L174.lean](../lean/HamiltonsCubic/Results/L174.lean) | **CONFIRMED** |
| 2 | The unit-norm step, $2\lVert M\rVert_F^2=2$ | **CONFIRMED, hypothesis supplied**: true, and true only under a sense of the letter $M$ that [conventions.md](../findings/conventions.md) does not table; its one tabled sense gives $4$ |
| 3 | The quantifier step, and survival on an empty qualifying set | **CONFIRMED** |
| 4 | L94's "exactly" is a biconditional at unit norm with no hypothesis the reformulation drops | **CONFIRMED, one unstated hypothesis**: attainment of $\max_F$, used in one direction only |
| 5 | Remark (b): $\tfrac{220}{144}>\tfrac32$, and $\theta>\sqrt{3/2}$ is the weaker hypothesis | **CONFIRMED**, and **understated**, the comparison is the reduction's own closure condition, and it holds at every $n\ge12$ and fails at every $4\le n\le11$ |
| 6 | Remark (a): the item is left "exactly as open" | **CONFIRMED**, the two are equivalent, so nothing is lost; what the remark buys is narrower than it reads |
| 7 | "Local maximiser" and what L94 needs | **CONFIRMED IDLE**, L94 needs unit norm and nothing else, so the equivalence holds at every unit $W$ and both maximiser hypotheses are decoration |
| 8 | [L174.lean](../lean/HamiltonsCubic/Results/L174.lean) builds, is `sorry`-free, and its statement is faithful to the record's | **CONFIRMED** |
| 9 | The file's docstring: the quantifier step is *"the whole risk"* | **REFUTED as written**, it is the only one of three risks the abstraction can see, and the smallest |

**Actionable in one line:** L174's statement, proof and Lean file are correct as they stand; add one clause to the proof naming which $M$ carries $\lVert M\rVert_F=\lVert W\rVert$, and cut *"which is the whole risk"* from the Lean docstring, which claims kernel cover for the two risks the abstraction cannot see.

## 0. Conventions, fixed once

Quoted from [conventions.md](../findings/conventions.md), not restated from memory.

- **The sectional matrix and its budget** ([conventions.md](../findings/conventions.md), *The vertex matrix*): $K$ is the symmetric hollow $n\times n$ matrix $K_{ab}=W_{abab}$, and $t=t_F=\lVert K(F)\rVert_F^2=\sum_{a\ne b}K_{ab}^2$, **the sum over ordered pairs**. The same section gives the operator form, $t=2\lVert\mathop{\mathrm{diag}}W\rVert^2$ with the diagonal taken in the pair basis, and derives $t\le2$ from it against $\lVert W\rVert=1$.
- **Per-frame against extremal** (same file, the $t,\kappa$ row and the boxed warning): $t_F$ is the frame's own value, $\kappa^2=\max_Ft_F$ is the extremal one, *"the two differ"*, and *"write $t_F$ when the frame is fixed and $t=\max_Ft_F$ when it is not."*
- **Coordinate-diagonal** (same file, the normalisations): diagonal in the coordinate $2$-planes $e_i\wedge e_j$ of an orthonormal frame of $\mathbb R^n$, so, in the orthonormal pair basis $\{e_a\wedge e_b\}_{a<b}$ of $\Lambda^2$, the operator matrix of $W$ is diagonal.
- **The norm on $W$** (same file, the letter-$M$ row): $\lVert W\rVert^2=\sum_\alpha\lambda_\alpha^2=\mathop{\mathrm{tr}}(W^2)=1$ at a unit Weyl tensor. The half-trace convention $\lVert Z\rVert^2=\tfrac12\mathop{\mathrm{tr}}(Z^{\mathsf T}Z)$ is stated for $\mathfrak{so}(n)$, i.e. for bivectors, and is what makes $e_a\wedge e_b$ a unit vector; it is not a second norm on $W$.
- **The item** ([plan.md](../plan.md), I36): *"if $W$ is a local maximiser of $P$ on the unit sphere with $\theta>\sqrt{3/2}$ then $W$ is diagonal in some coordinate frame, after which [Lemma L57](../findings/problem.md) finishes."*
- **The consumer** ([L57](../findings/problem.md)): $\langle Q(W),W\rangle\le\Theta_n\lVert W\rVert^3$ for **every** diagonal $W$ at every $n\ge4$.

## Hypothesis inventory

What L174 actually consumes, in the order it consumes it.

| # | hypothesis | where it comes from | stated in L174? |
| --- | --- | --- | --- |
| H1 | Frames are orthonormal frames of $\mathbb R^n$; "coordinate-diagonal" means diagonal in the pair basis of one | [conventions.md](../findings/conventions.md) | inherited, unstated |
| H2 | $t_F$ is the **ordered** sum, so the constant is $2$ and not $1$ | [conventions.md](../findings/conventions.md), *The vertex matrix* | inherited, unstated |
| H3 | Per frame, $t_F\le2\lVert W\rVert^2$, with equality **iff** $W$ is diagonal in that frame | [L94](../findings/bispectral.md), Gate 2 by [r101](REVIEW_r101.md) and [r102](REVIEW_r102.md) | cited |
| H4 | $\lVert M\rVert_F=\lVert W\rVert$, i.e. $M$ is the $\Lambda^2$ operator matrix of $W$ | forced by [bispectral.md](../findings/bispectral.md)'s factor-$4$ clause; **not** by [conventions.md](../findings/conventions.md)'s letter-$M$ row | **unstated, §2** |
| H5 | $\max_Ft_F$ is attained | $O(n)$ compact, $F\mapsto t_F$ continuous | **unstated, §4** |
| H6 | $\lVert W\rVert=1$ | the item's own "on the unit sphere" | stated |
| H7 | For remark (b): $\theta_0(n)^2=2(n-1)(n-2)/n^2$, evaluated at $n=12$ | [conventions.md](../findings/conventions.md) | stated |

Criticality, local maximality and the value of $\theta$ appear in **none** of H1–H6. That is §7.

## 1. The $\kappa^2$ reading, no swap

The record's standing warning is that $t_F$ and $\kappa^2$ have been substituted for each other. Here they are not.

**What each side needs.** The shape side says *"coordinate-diagonal in **some** frame"*, an existential over $O(n)$. The budget side must therefore be a quantity that already carries that existential. It is: $\kappa^2=\max_Ft_F$ ranges over frames, so $\kappa^2=2$ is exactly *"some frame achieves $t_F=2$"*. Pairing the existential with the **per-frame** $t_F$ instead would be the swap, and would produce the false statement *"$t_F=2$ for the frame $F$" $\iff$ "$W$ is diagonal in **some** frame"*, false in the $\Leftarrow$ direction at any $W$ diagonal in one frame and read in another, and [bispectral.md](../findings/bispectral.md) supplies that configuration outright: $\min_F\lVert K(F)\rVert_F=0$ *"for every tensor tested, the conjectured maximiser included"*, so a diagonal $W$ read in the wrong frame has $t_F=0$.

**Where the record writes it.** Four sites, all extremal, all consistent:

- [second-order.md](../findings/second-order.md), L174's statement: *"write $\kappa^2=\max_Ft_F$"*, then $\kappa^2=2$ throughout.
- [plan.md](../plan.md), I36: *"at unit norm the item's shape claim is the scalar claim $\kappa^2=2$"*.
- [L174.lean](../lean/HamiltonsCubic/Results/L174.lean): `kappaSq W = 2 ↔ ∃ F : Frame, IsCoordDiagonal W F`, the existential is on the right of the iff, matching the extremal reading on the left.
- [bispectral.md](../findings/bispectral.md), the Schur–Horn passage, which states the per-frame form and then says in the same sentence *"the bound is per-frame, and $\kappa^2=\max_Ft_F$ is where the extremal reading belongs"*.

**The step between the two forms, in full.** L94 per frame: $t_F\le2\lVert W\rVert^2$, equality iff $W$ diagonal in $F$. Take $\max_F$: $\kappa^2\le2\lVert W\rVert^2$. For equality, $\Leftarrow$ is immediate, if $W$ is diagonal in $F_0$ then $t_{F_0}=2\lVert W\rVert^2$, and $\kappa^2\ge t_{F_0}$ with $\kappa^2\le2\lVert W\rVert^2$ forces equality. $\Rightarrow$ needs the maximum to be **attained**: $\kappa^2=2\lVert W\rVert^2$ gives some $F_0$ with $t_{F_0}=2\lVert W\rVert^2$, whence diagonality in $F_0$. That is H5, and it is the only place the compactness of $O(n)$ is spent. See §4.

**Argued the opposite.** The strongest case for a swap would be [conventions.md](../findings/conventions.md)'s own $t,\kappa$ row, which writes L94's extremal form and then concludes *"so $t_F\le2$ in every frame"*, an extremal statement used to license a per-frame one. That inference is sound in this direction ($t_F\le\kappa^2\le2$); the fenced error is the reverse. **No discrepancy.**

## 2. The unit-norm step, correct, and correct only under an untabled sense of $M$

L94's right-hand side is $2\lVert M\rVert_F^2$; L174 sets it to $2$. The step is right, and getting to it requires knowing which of the record's objects $M$ is.

**Located.** [second-order.md](../findings/second-order.md), L174's proof, the sentence *"At unit norm that reads: $\kappa^2=2$ holds precisely when some frame makes $W$ coordinate-diagonal."* The proof names no $M$.

**The failure, exhibited.** [conventions.md](../findings/conventions.md) tables the letter under the heading *"The letter $M$ carries two objects, and their norms differ by $\sqrt2$"*, and the two are: $M$ (or $K$), the $n\times n$ sectional matrix, *"where $\lVert K\rVert_F^2=2$ at a unit Weyl tensor"*; and $W$, the operator on $\Lambda^2$. Under the first (the only one the row actually attaches to the letter $M$), a unit $W$ gives $\lVert M\rVert_F^2=2$, so L94 reads $\kappa^2\le4$ and its equality case is $\kappa^2=4$, which no unit $W$ attains. L174's *"at unit norm that reads $\kappa^2=2$"* is then simply false. The record carries a third object under the same letter, $M(n)$, the global maximum of $P$ on the unit sphere, a scalar, under which the expression is not even type-correct.

**The sense that makes it true, and where it comes from.** $M$ is the operator matrix of $W$ in the pair basis of $\Lambda^2$, so $\lVert M\rVert_F^2=\mathop{\mathrm{tr}}(W^{\mathsf T}W)=\mathop{\mathrm{tr}}(W^2)=\lVert W\rVert^2$, and $\lVert W\rVert=1$ gives $2\lVert M\rVert_F^2=2$. What pins it is [bispectral.md](../findings/bispectral.md)'s own clause inside L94: *"the norm must be $\lVert M\rVert_F$, not the $4$-tensor norm, or the bound is slack by a factor $4$."* That factor is exact and identifies the object: with $M_{(ab)(cd)}=W_{abcd}$ over $a<b$, $c<d$, the antisymmetry in each pair gives $\sum_{a,b,c,d}W_{abcd}^2=4\sum_{a<b,\,c<d}W_{abcd}^2=4\lVert M\rVert_F^2$. A factor of $4$ between the two candidates is the signature of a pair-basis matrix against a $4$-tensor, and of nothing else.

**Independent confirmation from the record.** [conventions.md](../findings/conventions.md)'s vertex-matrix section proves the same constant without the letter $M$ at all: $t=2\lVert\mathop{\mathrm{diag}}W\rVert^2$, so $t\le2\lVert W\rVert^2$ by Pythagoras in the pair basis, with equality iff the off-diagonal part vanishes, i.e. iff $W$ is coordinate-diagonal in that frame. At $\lVert W\rVert=1$ this is $t\le2$ directly. So the constant $2$ is on the record twice, and L174's step is sound.

**Argued the opposite.** A defender says the letter-$M$ row scopes its first sense to [diagonal-half.md](../findings/diagonal-half.md) and so does not govern [bispectral.md](../findings/bispectral.md), and that the factor-$4$ clause settles the reading for anyone who reads L94 at source. Both are fair, which is why this is recorded as a supplied hypothesis rather than a defect in the mathematics. **The verdict on the step is CONFIRMED; H4 is owed as one clause.** The cheapest repair is to cite the vertex-matrix section's $t\le2$ rather than L94's $2\lVert M\rVert_F^2$ form, since that line carries no ambiguous letter.

**A second-order observation on the row itself.** *"$\lVert K\rVert_F^2=2$ at a unit Weyl tensor"* is true on the diagonal locus and false off it, [bispectral.md](../findings/bispectral.md)'s $\min_F\lVert K(F)\rVert_F=0$ exhibits unit tensors and frames where it is $0$. The row's *"in [diagonal-half.md](../findings/diagonal-half.md)"* scopes it, so this is a phrasing that invites the wrong general reading rather than a false claim.

## 3. The quantifier step

Write $A(W)$ for $\lVert W\rVert=1$, $B(W)$ for the conjunction of local maximality and $\theta(W)>\sqrt{3/2}$, $C(W)$ for $\exists F:W$ diagonal in $F$, and $D(W)$ for $\kappa^2(W)=2$. L94 at unit norm is $\forall W\,(A(W)\to(D(W)\leftrightarrow C(W)))$. The two forms of I36 are $\forall W\,(A(W)\wedge B(W)\to C(W))$ and $\forall W\,(A(W)\wedge B(W)\to D(W))$.

**Immediate, and here is why.** Fix $W$ with $A(W)\wedge B(W)$. Then $A(W)$ holds, so L94 applies at that $W$ and $C(W)\leftrightarrow D(W)$. Each direction of the outer equivalence is that biconditional used pointwise under the quantifier. The only thing that could fail is a mismatch between L94's hypothesis and the class quantified over, and there is none: the qualifying class $A\wedge B$ implies $A$.

**Empty qualifying set.** If no $W$ satisfies $A\wedge B$, both universals are vacuously true and the equivalence holds, trivially, and correctly. This is worth stating because it is where the equivalence carries no information at all, and because it is the honest content of remark (a): the biconditional survives, and says nothing, exactly when there is nothing to say.

**As the kernel has it.** [L174.lean](../lean/HamiltonsCubic/Results/L174.lean)'s `shape_iff_budget` is these four lines, with `(h94 W hu).mpr` on one side and `(h94 W hu).mp` on the other, `hu : IsUnit W` being discharged from the qualifying class. It builds. **CONFIRMED.**

## 4. Is L94's "exactly" a biconditional at unit norm

**Yes, and the equality case carries no hypothesis the reformulation drops, with one exception, attainment.**

Read at source: [bispectral.md](../findings/bispectral.md) states L94 as $\kappa^2\le2\lVert M\rVert_F^2$ *"with equality **iff $W$ is coordinate-diagonal in some frame**, which both reviewers proved in one line"*, Gate 2 by [r101](REVIEW_r101.md) and [r102](REVIEW_r102.md). The one-line proof is the Pythagoras decomposition of §2: in the pair basis of a fixed frame, $\lVert W\rVert^2=\lVert\mathop{\mathrm{diag}}W\rVert^2+\lVert\mathop{\mathrm{offdiag}}W\rVert^2$ and $t_F=2\lVert\mathop{\mathrm{diag}}W\rVert^2$, so $t_F\le2\lVert W\rVert^2$ with equality iff $\mathop{\mathrm{offdiag}}W=0$. No criticality, no genericity, no non-degeneracy, no restriction on $\ker W$. The equality case is an identity of two sums of squares.

**The one hypothesis the reformulation inherits silently.** $\max_Ft_F$ must be attained, or $\kappa^2=2$ would not deliver a frame. It is: the orthonormal frames form $O(n)$, compact; $F\mapsto t_F=\sum_{a\ne b}W(Fe_a\wedge Fe_b,Fe_a\wedge Fe_b)^2$ is a polynomial in the entries of $F$, hence continuous; a continuous function on a compact set attains its supremum. So the record's writing $\max$ rather than $\sup$ is justified, and H5 is discharged rather than owed. **Recorded because it is used in exactly one of the two directions**, and a reader repairing the argument on a non-compact frame set would lose that direction alone.

**Edges.** $\kappa^2$ at a $W$ with kernel: no issue, $t_F$ is defined by sectional entries at every $W$ and the maximum is over frames rather than over eigenvectors. The trap [W4](../findings/INDEX-traps.md) about $\ker W\ne0$ concerns the gradedness slack $S(W)$ and does not touch this. $W=0$ is excluded by $\lVert W\rVert=1$.

## 5. Remark (b), the arithmetic, and what the remark does not say

**The arithmetic, exact.** $\theta_0(12)^2=\dfrac{2\cdot11\cdot10}{144}=\dfrac{220}{144}=\dfrac{55}{36}$, and $\dfrac32=\dfrac{54}{36}$. So $\theta_0(12)^2-\dfrac32=\dfrac1{36}>0$. **CONFIRMED**, with the margin named. The Lean file's `threshold_below_theta_zero : (3 : ℚ) / 2 < 220 / 144` is that inequality over $\mathbb Q$ and builds by `norm_num`.

**And it makes $\theta>\sqrt{3/2}$ the weaker hypothesis.** $\sqrt{\cdot}$ is strictly increasing on $[0,\infty)$, so $\tfrac32<\theta_0(12)^2$ gives $\sqrt{3/2}<\theta_0(12)$, and $\theta\ge\theta_0(12)\Rightarrow\theta>\sqrt{3/2}$ while the converse fails on $(\sqrt{3/2},\theta_0(12))$. So the qualifying **region** is strictly larger. *"Covers strictly more maximisers"* is a statement about the region; whether that region contains any maximiser at all is unknown, and the remark should not be read as asserting one exists.

**The brief's question, is "weaker hypothesis, more maximisers" the right reading?** It is right and it is incomplete. A weaker hypothesis makes I36 a **stronger theorem** and therefore a **harder item**, which the remark does not say. But the sharper point is the one neither the remark nor the brief states: **the comparison is the reduction's closure condition, not a bonus.** I36 feeds [L57](../findings/problem.md), which gives $\theta\le\Theta_n$ for every diagonal $W$. Chaining them bounds every local maximiser with $\theta>\sqrt{3/2}$ by $\Theta_n$, and leaves the maximisers with $\theta\le\sqrt{3/2}$ to be handled by the threshold itself. That second half closes **iff $\sqrt{3/2}\le\Theta_n$**. So had the threshold sat above $\Theta_n$, the pair I36 + L57 would leave the band $(\Theta_n,\sqrt{3/2}]$ uncovered and prove nothing. Remark (b) is the check that this does not happen, and reads as a remark about generosity.

**And the condition holds exactly on Conjecture A's own clause.** At even $n$, $\Theta_n^2=\tfrac{2(n-1)(n-2)}{n^2}>\tfrac32\iff4(n-1)(n-2)>3n^2\iff n^2-12n+8>0$, whose roots are $6\pm\sqrt{28}$, so the condition is $n\ge12$. At odd $n$, $\Theta_n^2=\tfrac{2(n-1)(n-3)}{(n+1)(n-2)}>\tfrac32\iff4(n-1)(n-3)>3(n+1)(n-2)\iff n^2-13n+18>0$, roots $\tfrac{13\pm\sqrt{97}}2$, so again $n\ge12$. **At both parities the threshold sits below $\Theta_n$ exactly at $n\ge12$**, which is precisely the clause [problem.md](../findings/problem.md) records as the record's reading of Conjecture A. Below it the comparison reverses: $\theta_0(11)^2=\tfrac{180}{121}<\tfrac32=\tfrac{181.5}{121}$, and $\theta_0(10)^2=\tfrac{36}{25}$, which [problem.md](../findings/problem.md) already carries as *"at $n=10$, $\theta_{10}^2=36/25<3/2=P(W_{\mathbb{CP}^2})^2$"*, the live content of the published conjecture's other clause.

**One clause therefore overreaches.** *"Covers strictly more maximisers, including every one at or above the conjecture's own value"* is true at every $n\ge12$ and false at every $4\le n\le11$, where a maximiser at $\Theta_n$ is **not** covered. I36 is stated without a dimension. Under the record's own convention that *"Conjecture A means its $n\ge12$ clause alone"* the clause is correct as written; the repair is to say $n\ge12$ once, since the sentence's own evidence is an $n=12$ evaluation. **Not a defect in L174's statement**, which contains no dimension claim.

## 6. Remark (a), "exactly as open"

**Correct, because the two sides are equivalent.** A biconditional loses no information by construction: I36_shape and I36_budget are inter-derivable given L94, so neither can be strictly easier to prove than the other, and a proof of either yields a proof of the other with the frame recoverable from L94's equality case. **The reformulation is not lossy.** This is the failure the brief asks to look for, and it is absent.

**What the remark buys is narrower than it reads.** *"An extremal condition on a continuous function of $W$"* is accurate, $\kappa^2$ is continuous, being a maximum over the compact $O(n)$ of a family jointly continuous in $(W,F)$, but three things temper it.

- **$\kappa^2$ is not differentiable.** A maximum of a family is only directionally differentiable in general, so the first move the phrase *"extremal condition on a continuous function"* invites (differentiate at a local maximiser), is not available without a further argument about which frames attain the max.
- **Half the budget claim is already free.** L94 gives $\kappa^2\le2$ at unit norm unconditionally, so I36_budget reduces to the one-sided $\kappa^2(W)\ge2$. That is a genuine simplification of the target's shape which the remark does not name, and it is the strongest thing the reformulation delivers.
- **A constructive proof of $\kappa^2\ge2$ is the original existential.** Exhibiting a frame with $t_F=2$ is exhibiting a frame in which $W$ is diagonal. So the gain is confined to **non-constructive** routes to $\kappa^2\ge2$, a variational or an averaging argument that never names a frame. That is exactly the sense in which the item is *"no less open"*, and it is why the remark's own verdict is the right one.

**On *"the record already estimates $t_F$"*.** [bispectral.md](../findings/bispectral.md) records that $\kappa$ is computed by ascent and that *"single-start ascent runs $7\%$ low at $n=12$"*. An ascent under-reports $\kappa$, so it can only ever certify $\kappa^2\ge$ something, which is the direction the budget form needs, the bias points the useful way. Worth noting so that a later reader does not discard the estimates as unusable; equally, no such estimate is evidence for a positive claim here, and none is used as one.

## 7. What "local maximiser" means, and whether L94 needs it

**It needs neither criticality nor maximality.** §4's proof of L94 is the Pythagoras identity in the pair basis; the only hypothesis is the normalisation. So the true general statement is

$$\text{for every unit }W:\qquad\kappa^2(W)=2\iff W\text{ is coordinate-diagonal in some frame,}$$

and L174 is that statement relativised to an arbitrary subclass of the unit sphere. **The maximiser hypothesis is idle**, as is the threshold, as is $\theta$ itself. Saying so is not a criticism of the lemma (the record's own framing is that it restates I36 rather than proving anything new) but it does fix what L174 contributes: nothing beyond L94 plus the tautology $\forall x\,(A\to(B\leftrightarrow C))\Rightarrow(\forall x\,(A\wedge B'\to B)\leftrightarrow\forall x\,(A\wedge B'\to C))$.

**The Lean file makes this visible and that is its best feature.** `IsLocalMax` and `theta` are section variables that appear in `shape_iff_budget`'s statement and **nowhere in its proof**, and `L94` does not mention them. Anyone reading the file sees at once that the maximiser hypothesis is carried and never spent. For the record: *"local maximiser"* here is [plan.md](../plan.md)'s *"a local maximiser of $P$ on the unit sphere"*, which is the sense the Lean abstraction is faithful to, and the record's *"critical point"* ($Q(W)=\theta W$), is a consequence of it that L174 never uses.

## 8. The machine-checked file, read against the record and run

**Run.** `cd lean && PATH="$HOME/.elan/bin:$PATH" lake build HamiltonsCubic.Results.L174` → *Build completed successfully (825 jobs)*. `#print axioms` on both theorems returns `[propext, Classical.choice, Quot.sound]`, i.e. Mathlib's ambient three and nothing else; the file contains no `sorry`, no `axiom`, no `native_decide`.

**Statement against the record's.** Faithful, and in three places stronger than the record needs.

| the record | the file | reading |
| --- | --- | --- |
| $W$ unit, local maximiser, $\theta>\sqrt{3/2}$ | `IsUnit W → IsLocalMax W → t < theta W` | faithful; the threshold is left as a free real `t` rather than instantiated at $\sqrt{3/2}$, which generalises rather than weakens |
| diagonal in some frame | `∃ F : Frame, IsCoordDiagonal W F` | faithful, the existential is where the record puts it |
| $\kappa^2=2$ | `kappaSq W = 2` | faithful, on the extremal reading; §2's normalisation is baked into the numeral |
| L94 | `def L94`, taken as a hypothesis `h94` | honest, and both the file and [lean/INDEX.md](../lean/INDEX.md) say so, *"Owed: L94 itself"* |

**Does the abstraction weaken the claim?** No. `Weyl`, `Frame` and the five predicates are universally quantified section variables, so the theorem is a schema; instantiating at the record's objects yields the record's claim, provided those objects satisfy `L94`. A universally quantified statement is stronger than any instance of it. The empty-`Weyl` and empty-`Frame` cases are covered and are the vacuous cases of §3.

**The one defect, and it is in prose.** [L174.lean](../lean/HamiltonsCubic/Results/L174.lean) line 16: *"lets the kernel check the quantifier step, **which is the whole risk**"*.

- **Located.** The docstring, line 16, against the file's own body.
- **Exhibited.** There are three risks in this reformulation, and the abstraction can see one. (i) The per-frame/extremal swap, invisible, because `kappaSq` is an opaque `Weyl → ℝ` and nothing in the file distinguishes $\max_Ft_F$ from $t_F$; substitute the per-frame reading and the file compiles unchanged while the record's claim becomes false. (ii) The normalisation of §2, invisible, because `2` is a bare numeral and `IsUnit` an opaque predicate with no stated relation to it; read $M$ in [conventions.md](../findings/conventions.md)'s tabled sense, so that the constant should be $4$, and the file still compiles. (iii) The quantifier step, visible, and checked. It is also the one of the three that a reader can verify by eye in four lines. **So the sentence claims kernel cover for exactly the two risks the kernel cannot see**, and the record's standing warning is that (i) has already happened once.
- **Argued the opposite.** The next sentence of the same docstring says *"`L94` itself is taken as a hypothesis; it is on the record with its own Gate 2, and nothing here reproves it"*, and [lean/INDEX.md](../lean/INDEX.md) records the state as `partial` with *"Owed: L94 itself"*. A reader who reaches either is not misled. So the fault is that *"the whole risk"* over-reads on its own line, in a file whose whole purpose is to be quotable in isolation. **Repair: delete four words**, leaving *"lets the kernel check the quantifier step, the two statements quantify over `W` on the outside and over frames on the inside."*

**One further note on `threshold_below_theta_zero`.** It states $\tfrac32<\tfrac{220}{144}$ over $\mathbb Q$. The record's remark is $\sqrt{3/2}<\theta_0(12)$, and the passage from the squares to the roots is not formalised, trivial, since both are non-negative, but the theorem's name promises a comparison of thresholds and its statement is a comparison of numerals. The docstring's account of why it is there (*"an earlier version of this file asserted the reverse and the kernel refused it"*), is the file's strongest single justification and I have no quarrel with it.

## 9. What would break it

In descending order of how cheaply it could happen.

1. **The unordered reading of $t$.** If $t_F$ were $\sum_{a<b}K_{ab}^2$ then $t_F\le1$ at unit norm, $\kappa^2=2$ would hold at no $W$, I36_budget would be false outright, and the equivalence would force I36_shape false, refuting the item by a convention. [conventions.md](../findings/conventions.md) fences this explicitly and L174 does not restate it. **This is the single most dangerous inherited hypothesis and it is unstated in L174.**
2. **The wrong $M$.** §2: the tabled sense gives $\kappa^2\le4$ and the unit-norm step collapses.
3. **The swap.** Replacing $\kappa^2$ by $t_F$ anywhere in the budget form makes the $\Leftarrow$ direction false, with a witness already on the record ($\min_F\lVert K(F)\rVert_F=0$ at a diagonal $W$).
4. **Loss of attainment.** If the frame set were not compact, $\kappa^2=2$ would not deliver a frame and the shape direction would fail. Not a live risk over $O(n)$; a live risk for any later relaxation of the frame set.
5. **A dimension below $12$.** §5: there $\sqrt{3/2}>\Theta_n$, the I36 + L57 chain leaves a band uncovered, and remark (b)'s last clause is false. L174's statement is unaffected; the reduction it serves is not.
6. **L94's Gate 2.** Everything here is downstream of it. It is confirmed by [r101](REVIEW_r101.md) and [r102](REVIEW_r102.md), and [LEDGER.md](../findings/LEDGER.md) records that the verdict once existed in two reports and in no index, so the risk is bookkeeping rather than mathematics, and it has already been paid once.

## Verdict

**PROVEN, hypotheses corrected.**

The statement is true, the proof on file is valid, and the Lean file is faithful, `sorry`-free and builds. The extremal reading is used consistently at every site and the fenced swap has not occurred. Three things are owed, none of them mathematics:

- **H4, one clause in the proof**, which $M$ carries $\lVert M\rVert_F=\lVert W\rVert$, or a citation of [conventions.md](../findings/conventions.md)'s vertex-matrix section in place of L94's $2\lVert M\rVert_F^2$ form.
- **H2 and H5, one sentence between them**, the ordered-pair reading of $t$, and attainment of $\max_F$.
- **Four words out of [L174.lean](../lean/HamiltonsCubic/Results/L174.lean)**, *"which is the whole risk"*, which is the one claim in the record's L174 material that is false as written.

Remark (a) stands. Remark (b) stands at $n\ge12$ and its last clause needs that dimension written down.
