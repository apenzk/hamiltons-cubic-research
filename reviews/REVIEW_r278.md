# REVIEW r278, Gate 2, route S and the decomposable branch

Reviewer 278. Commits under review: `cfa6619` (primary), `ebba97f`, `cf074b2`, `d8a34c2`.
Primary file: [findings/support-dichotomy.md](../findings/support-dichotomy.md). Supporting: [findings/second-order.md](../findings/second-order.md), [findings/nondegeneracy.md](../findings/nondegeneracy.md), [findings/fence-posts.md](../findings/fence-posts.md) posts 34/35, [plan.md](../plan.md) route S, [response.md](../response.md), [findings/graded-half.md](../findings/graded-half.md), [.claude/hooks/research_loop_stop.py](../.claude/hooks/research_loop_stop.py), [scripts/salvage_reviewer.py](../scripts/salvage_reviewer.py).
Scripts: [scripts/reviewers/r278/](../scripts/reviewers/r278/). Reviewer 277 runs the identical brief concurrently and independently.

Every number below is rebuilt from the definitions through [review_r30_core.py](../scripts/review_r30_core.py)'s `Q`, `circ` and `weyl_basis`, with criticality re-certified at each point rather than assumed. The support dimension of a piece is computed frame-covariantly, as the rank of $G_{ip}=\sum_{jkl}R_{ijkl}R_{pjkl}$, whose image is the smallest $V$ with $W\in S^2(\Lambda^2V)$.

| # | Claim | Verdict |
|---|---|---|
| 1 | The decomposable-branch theorem | **THE LAW IS RIGHT AND THE THEOREM IS WRONG AT BOTH ENDS.** (a) The harmonic-square law re-derives in three lines and criticality of the *pieces* is exactly what makes it possible, criticality of the sum gives nothing. (b) $W_A\circ W_B=0$ is the right hypothesis and is strictly weaker than coordinate-disjointness, witnessed here: a $\Lambda^+/\Lambda^-$ pair on the **same** four coordinates is $\circ$-orthogonal, $2.1\times10^{-16}$, and obeys the law exactly. **But "in dimension $n_i<n$" is REFUTED by the record's own example**: $(S^4)^3$ at $n=12$ splits as $S^4\times S^8\ \oplus_\circ\ \mathrm{pad}(S^4\times S^4)$ with support dimensions $\mathbf{12}$ and $8$. (c) $\lvert\theta\rvert<\min_i\lvert\theta_i\rvert$ holds, and the absolute values are load-bearing. (d) **The caveat is wrong**, under the theorem's own hypothesis the conclusion is $\lvert\theta\rvert<1<\theta_0(n)$ unconditionally, which is what [nondegeneracy.md](../findings/nondegeneracy.md) already states |
| 2 | The induction and its base cases | **THE INDUCTION DOES NOT DESCEND, AND THE BASE-CASE OBLIGATION IS MISDESCRIBED, THEN VANISHES ENTIRELY.** $\theta_0$ is increasing with $\theta_0(n)^2=2-6/n+4/n^2<2$ ✔; $n_i\ge4$ because $\dim\mathrm{Weyl}_3=0$ ✔; the $n_i=4$ base case is exact, $P=9(\det W^++\det W^-)$ verified to $10^{-14}$ and $\max P=1.224744871392=\sqrt{3/2}$ over $40$ starts ✔. **But the stated inductive claim $\lvert\theta_i\rvert\le\theta_0(n_i)$ is false at every one of its own base cases** ($\sqrt{3/2}>\theta_0(n)$ for all $n\le11$; at $n=4$ by exactly $\sqrt2$), and the hypothesis actually consumed is $\lvert\theta_i\rvert<\sqrt2$, which is **not** the low-dimensional half of Conjecture A. **And stated for the maximiser the branch needs no induction and no base cases at all**, three lines, given below |
| 3 | The contradiction in [second-order.md](../findings/second-order.md) | **THE READING IS FAIR AND THE CONTRADICTION IS REAL, AND IT IS [POST F35](../findings/fence-posts.md) RESTATED.** [second-order.md:206](../findings/second-order.md) does exactly what the new file says, in three consecutive sentences, and carries no annotation. What must change: the clause *"What the cap needs is $\lvert\theta\rvert\le M(n)/\sqrt2\le\sqrt{3/2}$"* is struck, on the residual $M(n)\le\sqrt3$ buys only $\theta\le1.7321$ against $\theta_0(12)=1.2360$. The finding is not new: post F35 states it, and r275/r276 both filed it as *Claim 1 REFUTED* |
| 4 | Is route S itself fenced? | **NOT FENCED, AND NOT YET A MECHANISM.** Posts 6, 22, 28, 11/12, 34 and 35 each miss S2: it is a dimension count, not a spectral moment, not $\ker\Phi_W$, not a rearrangement of $\theta$, not a norm-type cap, and not padding-invariant. **But S2's premise misreads its own source.** [Lemma L23](../response.md)'s count $r\le n(n-2)/4$ holds on the *whole* subalgebra family because $S_{\mathfrak{mmm}}\ge0$ is a sum of squares; $S_{\mathfrak{mmm}}=0$ is the **equality case**, not the domain. The real restriction is the two-eigenvalue subalgebra form, and off it neither $r$ nor $S_{\mathfrak{mmm}}$ is defined, which is exactly where the residual's sharp case, padded $W_{\mathbb{CP}^2}$ (four eigenvalues, $\theta=\sqrt{3/2}$), lives |
| 5 | The diagonal grant, `cf074b2` | **EXACTLY RIGHT, with one attribution owed.** Jäger's Theorem A is quoted verbatim in [the reference note](../references/jaeger-2016-diagonal-case/README.md) as *"Let $n\ge16$ be an even integer"*, and the sentence after it leaves $n=12,14$ open; [response.md](../response.md) Lemma L1 closes $n=12,14$. Union: even $n\ge12$, odd $n$ untreated. The half at $n=12,14$ is this project's own unpublished work, so "Proved and audited" carries a published half and an in-house half |
| 6 | The hook fix, `d8a34c2` | **BOTH FAILURE DIRECTIONS SURVIVE; FIVE CONSTRUCTED CASES, ALL RUN.** A corpse still silences the loop for up to $45$ minutes, and **indefinitely** if anything keeps its log warm, a leftover polling shell appending to `agent_logs/rNNN.log` defeats the window entirely. A live reviewer with a $46$-minute heartbeat gap is still declared dead, on $5.7$ minutes of margin over a max-of-eight. A trailing blank line after `DONE` reads as still-running. **And `salvage_reviewer.py` does not close the log in its most likely case**: the "full report exists, refused" branch returns before the append, which is precisely the reviewer that obeyed the protocol's *file as soon as you have your first verdict* |

---

## Claim 1, the decomposable-branch theorem

Evidence: [r278_piece_dimension.py](../scripts/reviewers/r278/r278_piece_dimension.py), [r278_hypothesis_checks.py](../scripts/reviewers/r278/r278_hypothesis_checks.py).

### (a) The harmonic-square law is true, and criticality of the pieces is the whole of it

$Q$ is the quadratic form of the symmetric bilinear $\circ$, so $Q(\sum a_iA_i)=\sum a_i^2Q(A_i)$ once $A_i\circ A_j=0$ for $i\ne j$. Criticality of each piece turns that into $\sum a_i^2\theta_iA_i$, and criticality of the sum then reads $\sum a_i^2\theta_iA_i=\theta\sum a_iA_i$. The $A_i$ are Frobenius-orthogonal, $\langle A\circ B,C\rangle$ is the polarisation of the cubic and hence totally symmetric, so $0=\langle A_i\circ A_j,A_i\rangle=\theta_i\langle A_i,A_j\rangle$ with $\theta_i\ne0$, so coefficients match: $a_i\theta_i=\theta$ for every $i$, and $\sum a_i^2=1$ gives $1/\theta^2=\sum_i1/\theta_i^2$.

**What criticality of the pieces buys is the coefficient matching, and criticality of the sum buys nothing without it.** Criticality of $W$ alone says $\sum a_i^2Q(A_i)\in\mathbb R\,W$; with $Q(A_i)$ unconstrained that is one equation in $k$ unknown vectors and yields no relation among the $\theta_i$. The step $Q(A_i)=\theta_iA_i$ is the hypothesis that makes the sum diagonal in the $A_i$, and it is not a consequence of anything else in the statement.

Reproduced exactly at the record's own witness: $(S^4)^3$ at $n=12$ has $1/\sqrt{1/\theta_A^2+1/\theta_B^2}=0.829156198$ against a measured $\theta=0.829156198$, with $\lVert Q(W)-\theta W\rVert=1.4\times10^{-16}$.

### (b) $W_A\circ W_B=0$ is the right hypothesis; "$n_i<n$" is not a consequence of it

Two halves, and the file gets one right and one wrong.

**Right.** Frobenius orthogonality is genuinely insufficient: at $n=6$, $\langle W_{S^3\times S^3},W_{\mathbb{CP}^2}\rangle=-1.8\times10^{-17}$ while $\lVert W_{S^3\times S^3}\circ W_{\mathbb{CP}^2}\rVert_F=\mathbf{0.263523}$. *The file's $0.2152$ is that number divided by $\theta_{\mathbb{CP}^2}=\sqrt{3/2}$*, i.e. it pairs a unit-norm operator against an **idempotent** $e=W/\theta$, mixing two normalisations; $0.263523/1.224745=0.215166$. Nothing load-bearing turns on it, but the honest cross term at unit norm is $0.2635$.

And coordinate-disjointness is sufficient without being necessary, with a witness rather than an assertion: embed the Fox point $W_{\mathbb{CP}^2}$ and its mirror under a reflection of $\mathbb R^4$ (a $\Lambda^+/\Lambda^-$ pair on the **same** four coordinates), into $n=6$. Then $\langle A^+,A^-\rangle=2.2\times10^{-16}$, $\lVert A^+\circ A^-\rVert_F=2.1\times10^{-16}$, both critical at $\theta=1.224745$ with residual $4.9\times10^{-16}$, and the combination is critical at $\theta=0.866025404$, matching $\sqrt{3/2}/\sqrt2$ to nine digits. Sufficiency itself is two lines: on orthogonal coordinate blocks the operators annihilate each other's ranges, so $AB=BA=0$, and $[\Lambda^2V,\Lambda^2V^\perp]=0$ kills $A\# B$.

**Wrong.** The theorem's hypothesis list contains *"each $W_i$ critical of unit norm in dimension $n_i<n$"*, and $\circ$-orthogonality does not deliver it. [second-order.md](../findings/second-order.md) itself names the counterexample two hundred lines earlier, *"the multi-block sphere products are $\circ$-decomposable across index blocks that overlap"*, with $(S^4)^3=S^4\times S^8\oplus_\circ S^4\times S^4$, and $4+8=12=n$. Measured:

| object at $n=12$ | $\theta$ | criticality residual | support dimension |
|---|---|---|---|
| $(S^4)^3$ | $0.829156$ | $1.4\times10^{-16}$ | $12$ |
| $S^4\times S^8$ | $1.201561$ | $4.8\times10^{-16}$ | $\mathbf{12}$ |
| $\mathrm{pad}(S^4\times S^4)$ | $1.145644$ | $3.3\times10^{-16}$ | $8$ |

with $\langle A,B\rangle=-2.4\times10^{-17}$, $\lVert A\circ B\rVert_F=2.1\times10^{-17}$, $a=0.690065559$, $b=0.723746864$, $a^2+b^2=1.000000000000$ and $\lVert aA+bB-W_{(S^4)^3}\rVert_F=3.9\times10^{-16}$.

**So a $\circ$-splitting need not lower the dimension.** The hypothesis as written excludes the record's own worked example from the branch that is supposed to cover it, and it is the hypothesis the induction of Claim 2 rests on.

### (c) $\lvert\theta\rvert<\min_i\lvert\theta_i\rvert$, absolute values included

From $1/\theta^2=\sum_i1/\theta_i^2>1/\theta_j^2$ for each $j$ whenever $k\ge2$ and every $\theta_i\ne0$. Both side conditions are needed and neither is stated: $\theta_i=0$ forces $\theta=0$ and the law is vacuous there.

The absolute values are load-bearing for a reason the record states and the arithmetic confirms: **a $\circ$-decomposition is only determined up to the sign of each piece**, since $A_i\mapsto-A_i$ flips $\theta_i$ and $a_i$ together and leaves $W$ fixed. At $n=8$, $W=(F+G)/\sqrt2$ with $F,G$ the two Fox blocks is simultaneously the splitting $\{F,G\}$ with $\theta_i=+1.224745$ and the splitting $\{F,-G\}$ with $\theta_2=-1.224745$; measured $\theta=0.866025$ with residual $3.6\times10^{-16}$ in both readings. So $\min_i\theta_i$ is not a well-defined function of $W$ and $\min_i\lvert\theta_i\rvert$ is. *A first pass of mine built $(F-G)/\sqrt2$ instead and got criticality residual $0.87$; that combination is not critical, and it is not what the record's witness names.*

### (d) The caveat is wrong, and the file has weakened its own source

The theorem's stated conclusion is qualified: *"this gives $\lvert\theta\rvert<\theta_0(n)$ **only where** $\min_i\lvert\theta_i\rvert\le\theta_0(n)$"*. Under the theorem's own hypotheses that qualification is unnecessary. From $1/\theta^2=\sum_i1/\theta_i^2\ge k/\max_i\theta_i^2$ with $k\ge2$,

$$\lvert\theta\rvert\le\frac{\max_i\lvert\theta_i\rvert}{\sqrt k}\le\frac{\max_i\lvert\theta_i\rvert}{\sqrt2}<\frac{\sqrt2}{\sqrt2}=1<1.236033=\theta_0(12)\le\theta_0(n)\quad(n\ge12),$$

using only the hypothesis $\lvert\theta_i\rvert<\sqrt2$ that the theorem already assumes. This is [nondegeneracy.md](../findings/nondegeneracy.md)'s own sentence, *"What survives is $\lvert\theta\rvert\le\max_iM(n_i)/\sqrt2<1<\theta_0(n)$ for every $n\ge12$, with $\theta/\theta_0\le0.706$, requiring only $\theta_i<\sqrt2$"*, so the assembly has restated a $\max/\sqrt k$ bound as a $\min$ bound and then added a caveat that the $\max/\sqrt k$ form does not need. **The branch is unconditional given its hypotheses; the caveat should be deleted.**

## Claim 2, the induction and its base cases

Evidence: [r278_n4_base.py](../scripts/reviewers/r278/r278_n4_base.py), [r278_piece_dimension.py](../scripts/reviewers/r278/r278_piece_dimension.py).

### What checks out

$\theta_0(n)^2=2(n-1)(n-2)/n^2=2-6/n+4/n^2$, so $\theta_0(n)<\sqrt2$ at every $n$ and $\frac{d}{dn}\theta_0^2=(6n-8)/n^3>0$ for $n>4/3$: **increasing and bounded by $\sqrt2$, both confirmed analytically.** Measured: $0.866025$, $1.054093$, $1.145644$, $1.200000$, $1.219673$, $1.236033$, $1.261680$, $1.280869$ at $n=4,6,8,10,11,12,14,16$, and $1.392982$ at $n=100$.

**A piece cannot have $n_i<4$**: $\dim\mathrm{Weyl}_n=(n+2)(n+1)n(n-3)/12$ vanishes at $n=3$, so a nonzero Weyl operator has support dimension at least $4$. Confirmed by construction, [weyl_basis](../scripts/review_r30_core.py) returns $10$ generators at $n=4$ and none at $n=3$.

**The $n_i=4$ base case is exactly right.** $P=9(\det W^++\det W^-)$ reproduces $P$ to $\le1.4\times10^{-14}$ at six random points of $\mathrm{Weyl}_4$, with $W^\pm$ read off in orthonormal bases of the Hodge eigenspaces; and Nelder–Mead from $40$ random starts on the unit sphere of $\mathrm{Weyl}_4$ returns $\max P=1.224744871392$ against $\sqrt{3/2}=1.224744871392$. The analytic reason is one line: a trace-free symmetric $3\times3$ of Frobenius norm $t$ has $\det\le t^3/(3\sqrt6)$ at spectrum $(2,-1,-1)t/\sqrt6$, and $t\mapsto t^3$ is convex, so the optimum puts all the norm in one chirality and $\max P=9/(3\sqrt6)=\sqrt{3/2}$.

### The inductive claim as written is false at every one of its own base cases

The file's sentence is *"the hypothesis needed at each piece is $\lvert\theta_i\rvert<\sqrt2$, which the inductive claim $\lvert\theta_i\rvert\le\theta_0(n_i)<\sqrt2$ supplies"*. The premise of that supply is false wherever it is invoked:

$$\Theta_4=\sqrt{3/2}=1.224745>0.866025=\theta_0(4),\qquad \text{ratio exactly }\sqrt2,$$

and $\sqrt{3/2}>\theta_0(n)$ for every $n\le11$, the crossover being the record's own $6+2\sqrt7=11.2915$. The record states this twice ([second-order.md](../findings/second-order.md): *"above $\theta_0$ at $n=8$ and $n=10$, below it from $n=12$ on"*; and the supremum over $\mathrm{Weyl}_n$ measured as $\max(\sqrt{3/2},\theta_0(n))$ at $n=6,8,10$). **So "$\lvert\theta_i\rvert\le\theta_0(n_i)$" is not a claim the base cases could ever supply; it is false on the whole base range.** What is true, and what the branch actually consumes, is $\Theta_{n_i}<\sqrt2$.

That correction propagates to the file's closing sentence on the point. *"This is the low-dimensional half of Conjecture A, and route S inherits it rather than avoiding it"* is **incorrect**: the low-dimensional half of Conjecture A in the $\theta_0$ form is false, and what route S inherits is the strictly weaker $\Theta_{n_i}<\sqrt2$. [nondegeneracy.md](../findings/nondegeneracy.md) draws the distinction correctly, it attaches "the open low-dimensional half of Conjecture A" to the hypothesis of the **refuted** $\theta\le\sqrt3/2$ bound and says the survivor requires "only $\theta_i<\sqrt2$". The assembly has carried the refuted route's obligation onto the surviving one.

### The induction does not descend, and the base-case range is incomplete either way

Claim 1(b) settles the first: a $\circ$-piece can have $n_i=n$. An induction on $n$ therefore has no descent, and *"the induction is sound and the branch is conditional only on its base cases"* does not hold as written.

Even granting descent, "$4\le n_i\le11$" would not be the base-case set. The inductive statement is available only at **even $n\ge12$**, [plan.md](../plan.md)'s own S3 and `cf074b2` scope it there, so a piece at odd $n_i\ge13$ (an $n_i=13$ piece inside $n=14$, say) sits in neither the base range nor the inductive range. The honest obligation is $\Theta_{n_i}<\sqrt2$ at **every** $4\le n_i\le n$, of which $n_i=4$ is proved and the rest is open.

### And the whole obligation is avoidable, the branch needs no induction at all

$P$ is continuous on the compact unit sphere of $\mathrm{Weyl}_n$, so it attains a maximum $\theta^\ast>0$ at some $W^\ast$ ($\theta_0(n)>0$ is achieved). $\nabla P=3\,W\circ W=3Q(W)$ and $Q$ preserves $\mathrm{Weyl}_n$, so the Lagrange condition gives $Q(W^\ast)=\theta^\ast W^\ast$. Suppose $W^\ast=\sum_{i\le k}a_iA_i$ is a $\circ$-splitting with $k\ge2$, every $a_i\ne0$ and every $A_i$ critical of unit norm. Then $a_i\theta_i=\theta^\ast>0$, so $\theta_i\ne0$, the $A_i$ are pairwise Frobenius-orthogonal, $\sum a_i^2=1$, and hence $\lvert a_i\rvert<1$ and $\lvert\theta_i\rvert=\theta^\ast/\lvert a_i\rvert>\theta^\ast$. Then $\varepsilon_iA_i$ with $\varepsilon_i=\mathop{\mathrm{sign}}\theta_i$ is a unit Weyl operator with $P(\varepsilon_iA_i)=\lvert\theta_i\rvert>\theta^\ast$, contradicting maximality. **So the maximiser is $\circ$-indecomposable.**

Three lines, no induction, no dimension bookkeeping, no $\sqrt2$, and no base cases, and it is all Conjecture A needs from this branch, since the conjecture is a statement about the maximum. **The base-case obligation the file calls inherited is an artefact of stating the branch as an induction on $n$ instead of as a statement about the maximiser.** That is the one substantive change I would make to [support-dichotomy.md](../findings/support-dichotomy.md).

## Claim 3, the contradiction, and whether the reading is fair

The paragraph, quoted whole from [second-order.md](../findings/second-order.md):

> **What this settles and what it leaves.** Decomposable points are capped by their own pieces and can never set a new maximum, so Reviewers 56/57's infinite direct-sum family costs route B nothing: the residual narrows to **$\circ$-indecomposable** non-diagonal $S=0$ points. Padding is the $b=0$ case and preserves indecomposability, so padded $W_{\mathbb{CP}^2}$ at $\sqrt{3/2}$ stays in the residual as the sharp case. What the cap needs is $\lvert\theta\rvert\le M(n)/\sqrt2\le\sqrt{3/2}$, i.e. an *a priori* bound $M(n)\le\sqrt3$, strictly weaker than Conjecture A, since $\theta_0(n)<\sqrt2<\sqrt3$ at every $n$.

**The reading is fair.** Sentence one defines the residual as $\circ$-indecomposable, sentence two puts padded $W_{\mathbb{CP}^2}$ in it as the sharp case, sentence three proposes a conversion whose $\sqrt2$ is the harmonic-square law's $1/\sqrt k$ at $k=2$, established in that same file, twenty-five lines above, as requiring "$k\ge2$ nonzero pieces". Nothing in the paragraph is making a different point, and the file carries no annotation there.

**The contradiction is real**, and the arithmetic is on record twice over: on the residual, $M(n)\le\sqrt3$ gives $\theta\le1.7321$ against $\theta_0(12)=1.2360$, and at the residual's own sharp case $\theta=1.224745$ against $F/\sqrt2=0.995782$, the divisor fails by $23\%$ in the direction that matters.

**What must change in [second-order.md](../findings/second-order.md):** the final clause of that paragraph (from *"What the cap needs is"* to the end), is withdrawn or marked, with the pointer to [post F35](../findings/fence-posts.md). The rest of the paragraph stands, including the narrowing of the residual, which is what makes the last clause inadmissible.

**But the finding is not new, and [support-dichotomy.md](../findings/support-dichotomy.md) should say so more plainly than it does.** Post F35 states exactly this, *"The $\sqrt2$ is the harmonic-square law ... It therefore lives only on $\circ$-decomposables (precisely the set the sum law removes"*) and [reviews/INDEX.md](INDEX.md) records it as *Claim 1 REFUTED* from both r275 and r276. The new file cites post F35, which is correct attribution; what it adds is the identification of the specific unmarked paragraph, and that is worth having on its own.

## Claim 4, is route S itself fenced?

### The posts, one at a time

| post | what it fences | does it reach S2? |
|---|---|---|
| [6](../findings/INDEX.md) | spectral moments of $L_W$ are the wrong invariants; the obstruction is directional | **No.** $S_{\mathfrak{mmm}}$ is a structure-constant sum over an orthogonal splitting of $\mathfrak{so}(n)$, not a moment of $L_W$; and $r=\dim\mathfrak h$ is not spectral data of $W$ beyond its two-eigenvalue form |
| [22](../findings/target.md) | $\ker\Phi_W$ decides diagonality and carries no $\theta$ information | **No.** S2 never touches $\Phi_W$; its invariant is a dimension, and it separates $\theta$ by construction, $\theta=\frac2n\sqrt{rN/(N-r)}$ is monotone in $r$ |
| [28](../findings/INDEX.md) | $\theta\le\Pi/4$ is the target restated, because $\Pi/4=\theta$ identically at every tight point | **No** as a mechanism, $r\le n(n-2)/4$ is an inequality between integers with a strict gap at every non-symmetric pair, so it is not an identity in disguise. *But see the caution below* |
| [11](../findings/second-order.md), [12](../findings/second-order.md) | splitting $P$ in two, and a single flatness inequality, cannot cap $M(n)$ | **No.** S2 abandons $M(n)$; it never forms an a priori norm bound |
| [34](../findings/fence-posts.md) | Cauchy–Schwarz on the sharp term restates $\theta\le\theta_0$ and loses most where the conjecture is slack | **No.** S2 makes no relaxation of $\langle M^\#,M\rangle$ |
| [35](../findings/fence-posts.md) | no norm-type cap converts to $\theta$ on $\circ$-indecomposables below $n=356$ | **No, and S2 is shaped to clear it.** Post F35's exit condition is "a conversion valid on $\circ$-indecomposables"; a dimension count is not a conversion from a cap at all |

The padding test [plan.md](../plan.md) applies to itself also passes. Every fenced route bounded a padding-invariant quantity while $\theta_0(n)$ grows; the subalgebra family is **not** closed under padding, $\mathrm{pad}(\Pi_{\mathfrak h}-\frac rN\mathrm{Id})$ acquires a third eigenvalue and leaves the family, so the count genuinely sees $n$. **Route S is not fenced.**

### But S2's premise misreads [Lemma L23](../response.md), and the misreading is the crux

[plan.md](../plan.md) S2 says *"[response.md](../response.md)'s count holds when $[\mathfrak m,\mathfrak m]\subseteq\mathfrak h$ ($S_{\mathfrak{mmm}}=0$)"*, and [support-dichotomy.md](../findings/support-dichotomy.md) repeats the framing. **That is the equality case, not the domain of validity.** Both [Lemma L23](../response.md) and [graded-half.md](../findings/graded-half.md) derive

$$S_{\mathfrak{mmm}}=(N-r)\Big[2(n-2)-\frac{4(n-1)r}{N}\Big]\ \ge0\ \text{ because it is a sum of squares}\ \Longrightarrow\ r\le\frac{n(n-2)}4,$$

*"with equality in either place exactly when $S_{\mathfrak{mmm}}=0$"*. The count therefore already holds on the **whole** subalgebra family, graded and ungraded alike; $\mathfrak{su}(3)$ at $\theta=0.836660$ is an ungraded member the count covers. So "extend the count off the graded family" describes work that is already done, and the real gap is elsewhere.

**The real gap is the subalgebra form itself, and it is wider than S2 admits.** The count's inputs are: $W=\Pi_{\mathfrak h}-\frac rN\mathrm{Id}$ up to scale, hence exactly **two** eigenvalues; $\mathfrak h$ a subalgebra, which is what gives $[\mathfrak h,\mathfrak h]\perp\mathfrak m$ and hence both marginal identities $S_{\mathfrak{hhh}}+S_{\mathfrak{hmm}}=\kappa r$ and $2S_{\mathfrak{hmm}}+S_{\mathfrak{mmm}}=\kappa(N-r)$. Off that form there is no $\mathfrak h$, so **neither $r$ nor $S_{\mathfrak{mmm}}$ is defined**, and both identities the proof eliminates through are gone. Taking $\mathfrak h$ to be a top eigenspace of a general $W$ does not repair it: an eigenspace need not be a subalgebra, and the marginal identities fail the moment it is not.

That is not a fence, but it is a much larger step than *"treat the grading defect as the correction term"* suggests, and the deliverable [plan.md](../plan.md) names (*"an inequality with the defect on one side"*), is not yet well-posed on the set it must cover. **The residual's own sharp case makes this concrete**: padded $W_{\mathbb{CP}^2}$ at $n=12$ is $\circ$-indecomposable, critical, non-diagonal, at $\theta=\sqrt{3/2}=0.9909\,\theta_0(12)$, and it has four distinct eigenvalues $(2,-1,-1,0^{\cdots})/\sqrt6$, so it is outside the family by two independent conditions. [Lemma L23](../response.md)'s own "What it does not reach" lists the exclusions and includes *"every symmetry-free critical point"*.

**One caution against post F28, not a fence.** [Lemma L23](../response.md) records that on this family the graded-compression slack has the closed form $S=\frac r{nN}[4(N-r)-n^2]$, *"so the cap is that inequality restricted here, a sum-of-squares re-derivation and a cross-check rather than independent leverage"*. The count and the graded-compression bound are therefore the same inequality on the family. Any extension has to keep them apart off it, or post F28's mechanism (a quantity that equals the target wherever it is tight), recurs.

**Verdict: S2 is a genuinely new mechanism rather than a restatement, and it is not yet a mechanism.** Its stated premise is a misreading of its own source; its two objects are undefined on its target set; and its target set's sharp case is excluded from the family by construction. What S2 needs first is a statement of what $r$ and $S_{\mathfrak{mmm}}$ mean at a general $\circ$-indecomposable critical point.

## Claim 5, the diagonal grant, `cf074b2`

**"Even $n\ge12$" is exactly right**, and the two halves are separable.

- **Even $n\ge16$ is published.** [The reference note](../references/jaeger-2016-diagonal-case/README.md) quotes Jäger's Theorem A verbatim from p. 113 of the extraction: *"Let $n\ge16$ be an **even** integer, and let $W\in\langle W\rangle_d$ with $\lVert W\rVert=1$ be given such that $W^2+W^\#=\theta W$ for a $\theta\ge\theta_0(n)$. Then $\theta=\theta_0(n)$, and $W$ is the normalized Weyl curvature of $S^{n/2}\times S^{n/2}$."* The parity is in the hypothesis, not in the note's paraphrase.
- **The sentence after it leaves $12$ and $14$ open**, *"The conjecture is that this is also true for all even integers $n\ge12$."*, so those two dimensions are open **in the diagonal case** in print.
- **$n=12,14$ is closed in-house.** [response.md](../response.md) Lemma L1: exact evaluation of Jäger's own expression at his own case endpoints reaches $n=14$, and $n=12$ needs the replacement of his $(\mathop{\mathrm{tr}}S^3,\mathop{\mathrm{tr}}S^4)$ box by the true moment body, discharged by a convex dual, exact root isolation on a quartic and validated interval arithmetic.
- **Odd $n$ is untreated and cannot be patched from here.** [response.md](../response.md) says Jäger's endgame *"genuinely needs evenness"*, and [Lemma L23](../response.md) supplies the structural reason: for odd $n$ the cap $n(n-2)/4$ is not an integer, the inequality is strict, and the equality case that identifies the maximiser does not exist.

Union of what is available: **even $n\ge12$.** The wording of the corrected [plan.md](../plan.md) line matches this exactly, including the attribution split.

**One thing the line still owes.** It sits under "**Proved and audited**", and half of it ($n=12,14$), is this project's own unpublished Lemma L1 rather than a published theorem. The grant the problem statement makes is to the *published* diagonal case; anything the programme builds on $n=12,14$ leans on in-house work, and the line reads as though both halves have the same standing.

**A separate inconsistency in the same list, found while checking this one.** [plan.md](../plan.md) and [findings/INDEX.md](../findings/INDEX.md) both record $\Theta_5=\sqrt{3/2}$ as proved (*"$\Theta_5=\sqrt{3/2}$, proved by an exact rational SOS certificate"*) while [sym3-blocks.md](../findings/sym3-blocks.md), the file that holds the certificate, says under "What the certificate **would** establish": *"$\Theta_5=\sqrt{3/2}$, which the record does not have, only $n=4$ is proved"*, and leaves the restricted rank *"open in $[1,13]$"* with consistency as *"the open necessary condition"*. [support-dichotomy.md](../findings/support-dichotomy.md)'s *"for $5\le n_i\le11$ the record's own word is presumed"* agrees with the body file and contradicts the index. **The body file is the conservative reading and I would take it; the index rows are the ones to correct.**

## Claim 6, the hook fix, `d8a34c2`

Evidence: [r278_hook_cases.py](../scripts/reviewers/r278/r278_hook_cases.py), which imports [research_loop_stop.py](../.claude/hooks/research_loop_stop.py) and [salvage_reviewer.py](../scripts/salvage_reviewer.py) as committed and runs each case against a temporary tree.

| case | `_agents_running` | reading |
|---|---|---|
| A, corpse aged $10$ min, log ends in `HEARTBEAT` | `True` | **a corpse still silences the loop** |
| B, same corpse aged $46$ min | `False` | the window shrink works, and is the whole of the fix |
| C, **live** reviewer, $46$-minute heartbeat gap | `False` | **a live reviewer is declared dead** |
| D, corpse whose log a leftover poller keeps warm | `True` | **the window is defeated entirely** |
| E, closed with `DONE`, then one blank line | `True` | a stray newline reads as still-running |
| F, closed with `DONE`, no trailing blank | `False` | the intended path |

### Can a corpse still silence the loop? Yes, in two ways

**Bounded.** The mechanism is untouched: a killed reviewer's log has no closing line, and for as long as it is warm `_agents_running` returns `True` and the hook exits $0$ emitting nothing. The fix shortens the silence from $90$ minutes to $45$; it does not remove it. If the turn ends inside that window (which is the case the commit message describes), the loop stops with no message, exactly as before.

**Unbounded.** Case D is the one the window cannot reach. Anything that keeps touching `agent_logs/rNNN.log` refreshes `getmtime` and the log never goes stale, so a corpse whose leftover background job still appends to its own log silences the loop **indefinitely**. This is not hypothetical for this programme, the brief I am working from opens by recording that *"a previous reviewer left seven polling shells behind"*, and a polling shell that logs its own waiting is the exact shape of case D. Against this failure the $90\to45$ change buys nothing.

**And `salvage_reviewer.py` does not always close the log**, which is the half of the fix meant to make the closure unforgettable. Two paths return before the append:

- `if os.path.exists(out)` and the file lacks `PARTIAL` → *"reviews/REVIEW_r{n}.md exists and is a full report, refused"*, at [scripts/salvage_reviewer.py:43](../scripts/salvage_reviewer.py). Measured: the log's tail stays `'HEARTBEAT phase 2\n'`. **This is the modal case.** The reviewer brief instructs *"FILE reviews/REVIEW_&lt;TAG&gt;.md AS SOON AS YOU HAVE YOUR FIRST VERDICT"*, so a reviewer killed after its first verdict has a full-looking report on disk and its log is refused closure, the corpse the salvage exists to bury is the one it walks past.
- `if not os.path.exists(log)` at [scripts/salvage_reviewer.py:39](../scripts/salvage_reviewer.py), harmless, since there is nothing to close.

A third, narrower one: the append assumes the log ends in a newline. With a log ending `'...HEARTBEAT phase 2'` the result is `'HEARTBEAT phase 2FAILED salvaged and closed by scripts/salvage_reviewer.py\n'`, which the anchored `^\s*(DONE|FAILED)` correctly refuses, the script reports *"log closed"* while the log is not closed. Measured.

### Can a live reviewer still be declared dead? Yes, and the margin is $5.7$ minutes

Case C. A reviewer whose heartbeat gap exceeds $45$ minutes has a stale log, is skipped by the `continue`, and (if it is the only one), makes `_agents_running` return `False`; the hook then fires and demands reviewers that are already working. The commit takes this risk deliberately and calls the direction *"loud and self-correcting"*.

**Two reasons to hold that judgement loosely.**

- **$45$ minutes is not a bound, it is a max-of-eight.** The function's own comment records *"39.3 minutes in one case, 14.1 in another, with five of eight logs exceeding five minutes"*. Setting the window $5.7$ minutes past the largest of eight observations of a heavy-tailed quantity is a coin flip on the ninth. The programme's own memory records Sage workers at $5.5$ GB, i.e. exactly the runs that produce these gaps.
- **The loud direction has its own documented pathology, in the same docstring.** *"the hook then demands reviewers that are already working, once per turn, indefinitely, with the turn's only available action being to re-launch them."* That is the failure the third naming convention was added to fix. Calling it self-correcting is a claim the file contradicts four paragraphs above the change.

### What would actually decide it

The two directions are separable and the code currently uses one signal for both. Liveness of the *work* is what `getmtime` measures badly; liveness of the *agent* is what the abandoned PID check measured badly. A cheap third signal exists and is not used: `_agents_running` could require both a warm log **and** a live process before returning `True`, falling back to the window alone only when no PID is recoverable, the log's first line is required by protocol to contain `PID <pid>`, and the docstring's objection (the logged PID is a shell that exits at once) is an argument for fixing what the protocol asks reviewers to log, not for discarding the signal. Failing that, closing the loop on case D costs one line: skip a log whose tail is unchanged since the previous invocation even though its mtime moved.

---

*Filed by r278. Scripts: [r278_piece_dimension.py](../scripts/reviewers/r278/r278_piece_dimension.py), [r278_hypothesis_checks.py](../scripts/reviewers/r278/r278_hypothesis_checks.py), [r278_n4_base.py](../scripts/reviewers/r278/r278_n4_base.py), [r278_hook_cases.py](../scripts/reviewers/r278/r278_hook_cases.py). Log: [agent_logs/r278.log](../agent_logs/r278.log).*
