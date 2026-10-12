# REVIEW r899: does [Lemma L208](../findings/curvature-invariants.md#lemma-l208-ricci-flatness-of-the-fox-square-on-the-diagonal-locus-derived-in-this-records-own-normalisation) establish what it claims, and is its premise true?

*Reviewer r899, on a brief worked independently by a second reviewer. **This round checked an argument being made**, so the premise the Lean file declines to prove was re-derived here from the record's own definitions rather than accepted. What I read: the [L208 block](../findings/curvature-invariants.md), [L208RicciFoxSquare.lean](../lean/HamiltonsCubic/Results/L208RicciFoxSquare.lean), its row in [lean/INDEX.md](../lean/INDEX.md), [WeylReal.lean](../lean/HamiltonsCubic/Base/WeylReal.lean), [conventions.md](../findings/conventions.md), [Families.lean](../lean/HamiltonsCubic/Base/Families.lean), and the diagonal-locus criticality material at [diagonal-half.md:67](../findings/diagonal-half.md#L67). What I computed: the sharp half of $Q$ on the diagonal locus by hand from the record's structure constants, then three exact-rational **screens** in seconds on objects built for the screen (the $n=5$ sharp operator on a random hollow symmetric $K$, the witness `Kss`, and the same conclusion under the doubled-$\#$ convention), plus `lake build` and `#print axioms` on the file. Log: [agent_logs/review-r899-l208.log](../agent_logs/review-r899-l208.log).*

## The claim table

| # | Item | Verdict | Reason |
|---|---|---|---|
| 1 | The premise, $(W^2)_{ab}=K_{ab}^2$ and $(W^\#)_{ab}=(K^2)_{ab}$ | **CONFIRMED, EXACTLY AND NOT UP TO A FACTOR** | both halves are pair-diagonal on the locus, and the record's $\tfrac12$-carrying index formula gives the sharp entry as $\sum_{c\notin\{a,b\}}K_{ac}K_{cb}=(K^2)_{ab}$, the same $\tfrac12$ that its mandatory $\mathrm{id}^\#=(n-2)\mathrm{id}$ anchor pins |
| 2 | "Ricci-flatness on this locus is $K\mathbf 1=0$" | **CONFIRMED, AND STRONGER THAN STATED** | $\operatorname{Ric}(W)_{ab}=0$ holds identically for $a\ne b$ at any pair-diagonal operator, so the diagonal conditions $\operatorname{Ric}(W)_{aa}=(K\mathbf 1)_a$ are the whole of Ricci-flatness there |
| 3 | The cancellation | **CORRECT IN EVERY STEP, NO UNSTATED HYPOTHESIS** | $K^2\mathbf 1=0$, $\sum_{c\ne a}(K^2)_{ac}=-(K^2)_{aa}$, $(K^2)_{aa}=\sum_cK_{ac}^2$ by symmetry, $\sum_{c\ne a}K_{ac}^2=\sum_cK_{ac}^2$ by hollowness: the three hypotheses used are the three stated |
| 4 | Is the Lean statement the lemma? | **IT IS THE ARITHMETIC CORE, AND ONE SENTENCE OF THE FILE OVERSTATES IT** | `rowSum_sq_add_sq_cancel` is item 3 alone, dimension-free and geometry-free as claimed, while [line 13](../lean/HamiltonsCubic/Results/L208RicciFoxSquare.lean#L13) calls it "the whole lemma on this locus" against the file's own two disclaimers, and [lean/INDEX.md](../lean/INDEX.md) repeats that phrasing |
| 5 | The witness `Kss` | **IT IS THE OBJECT IT IS NAMED AFTER, AND $\theta=\sqrt3/2$ EXACTLY** | $(2/3,-1/3)$ is the Weyl part of $S^2\times S^2$ with unit-curvature factors, $\lVert W\rVert^2=4/3$, $Q(W)=W$, $P=4/3$, $\theta=(4/3)^{-1/2}=\sqrt3/2=\theta_0(4)$, and the two `Kss_sq` entries are exact |
| 6 | What the lemma does not reach | **THE LIST IS INCOMPLETE BY ONE ITEM, AND THE CLOSURE BOUGHT IS SMALLER THAN THE HEADLINE SUGGESTS** | the premise itself is owed (asserted in the block, derived in no block and in no Lean file), and what the lemma buys is $\circ$-closure of $\mathcal D_n$, which reaches the diagonal criticality map and leaves [L24](../findings/second-order.md)'s $L_e$ on $W^\perp$ untouched |

**One line the cycle can act on.** The lemma is true, its premise is true exactly, and its witness is the object it is named after, so nothing here needs withdrawing: what needs doing is three documentary repairs, namely the "whole lemma" phrasing in the Lean file and its index row, the premise added to the owed list, and a cross-reference to [diagonal-half.md's multiplier paragraph](../findings/diagonal-half.md#L73), which already carries these same four lines for a different purpose and which the block presents as new.

## 1. The premise, and it holds with the record's own $\tfrac12$

**The square half is immediate.** A coordinate-diagonal $W$ acts on $\Lambda^2$ by $W\varphi_{ab}=K_{ab}\varphi_{ab}$, with $K_{ab}=W_{abab}=\langle W\varphi_{ab},\varphi_{ab}\rangle$ at $\lVert\varphi_{ab}\rVert=1$, which is [conventions.md's vertex-matrix section](../findings/conventions.md#L138) read against its own bivector normalisation. Then `compOp` is $X\mapsto W(WX)$, so $W^2\varphi_{ab}=K_{ab}^2\varphi_{ab}$: the square half is pair-diagonal with entry $K_{ab}^2$, the Hadamard square.

**The sharp half is four lines from the structure constants.** The record's index formula is $(W^\#)_{\alpha\beta}=\tfrac12\sum c_{\alpha\gamma\delta}c_{\beta\varepsilon\zeta}W_{\gamma\varepsilon}W_{\delta\zeta}$ at [conventions.md:77](../findings/conventions.md#L77), with $\alpha,\beta$ pair indices. At diagonal $W$ this collapses to

$$(W^\#)_{\alpha\beta}=\tfrac12\sum_{\gamma,\delta}c_{\alpha\gamma\delta}c_{\beta\gamma\delta}W_\gamma W_\delta .$$

From [StructureConstants.lean](../lean/HamiltonsCubic/Base/StructureConstants.lean)'s bracket $[\varphi_{ab},\varphi_{cd}]=\delta_{ac}\varphi_{bd}+\delta_{bd}\varphi_{ac}-\delta_{ad}\varphi_{bc}-\delta_{bc}\varphi_{ad}$ the support of $c$ is exactly the triangles: $[\varphi_{ab},\varphi_{bc}]=-\varphi_{ac}$ at distinct $a,b,c$, and every pair of bivectors on four distinct indices commutes. So for $\alpha=(ab)$ the contributing $(\gamma,\delta)$ are the two orderings of $\{(bc),(ac)\}$ for each $c\notin\{a,b\}$, each with $c_{\alpha\gamma\delta}^2=1$, giving

$$(W^\#)_{(ab),(ab)}=\tfrac12\cdot2\sum_{c\notin\{a,b\}}K_{bc}K_{ac}=\sum_cK_{ac}K_{cb}=(K^2)_{ab},$$

the last equality by $K_{aa}=K_{bb}=0$ killing the two terms the matrix product adds. **The off-diagonal entries vanish.** For $\alpha=(ab)\ne\beta$ a nonzero term needs $\{\gamma,\delta\}$ to close a triangle with $\alpha$ and with $\beta$ at once, which forces $\beta=\alpha$ or a degenerate pair in every case, so $W^\#$ is pair-diagonal too. Both halves of $Q$ are therefore pair-diagonal with entries $K_{ab}^2$ and $(K^2)_{ab}$, which is the premise verbatim.

**The factor is the record's, and it is checked where the record says to check it.** At $K_{ab}\equiv1$ off the diagonal the formula returns $(K^2)_{ab}=n-2$, so $\mathrm{id}^\#=(n-2)\,\mathrm{id}$: the premise passes [conventions.md:75](../findings/conventions.md#L75)'s mandatory pre-check on any $\#$ formula, which is what makes "exactly, and not up to a factor" the verdict rather than a hope. The $\tfrac12$ in [sharpOp](../lean/HamiltonsCubic/Base/WeylReal.lean#L153) and the $\tfrac14$ in [sharpQF](../lean/HamiltonsCubic/Base/WeylReal.lean#L102) are a separate normalisation pair belonging to the real layer's reassembly of $R^\#$ from `sharpBil`, and the L208 file calls neither, so the confusion the brief warns of has no purchase here: the premise is read off the index formula, whose own $\tfrac12$ is the one that matters and is the one used.

**Three corroborations on disk, each arrived at for another purpose.** [conventions.md's $\Phi$ row, sense (iii)](../findings/conventions.md#L51) names $\Phi(M)=M^{\circ2}+M^2$ as "the criticality map on the diagonal locus", which is the premise stated as a definition, Hadamard square for the square half and matrix square for the sharp half. [diagonal-half.md:69](../findings/diagonal-half.md#L69) runs the Euler–Lagrange condition on $(M^{\circ2}+M^2)_{ij}$ and reports it fitting at residual $10^{-16}$ at four named objects. And [LEDGER.md](../findings/LEDGER.md)'s L129 entry consumes $M^2-\theta M=L(M^{\circ2})$. The premise is therefore the one identity the record's entire diagonal-locus apparatus already runs on.

**Screen.** Built the $\binom52=10$-dimensional sharp operator at $n=5$ from the bracket above on a random hollow symmetric rational $K$, in exact arithmetic: every off-diagonal entry is $0$ and every pair entry equals $(K^2)_{ab}$ on the nose. Reported as a screen of a derivation already complete, not as its evidence.

## 2. Ricci-flatness on the locus, derived rather than accepted

`Ric` is $\operatorname{Ric}(R)_{ab}=\sum_c\langle R\varphi_{ac},\varphi_{bc}\rangle_2$ at [WeylReal.lean:106](../lean/HamiltonsCubic/Base/WeylReal.lean#L106). At any pair-diagonal $R$ with entries $N_{ac}$,

$$\operatorname{Ric}(R)_{ab}=\sum_cN_{ac}\,\langle\varphi_{ac},\varphi_{bc}\rangle_2 .$$

For $a\ne b$ the pairs $\{a,c\}$ and $\{b,c\}$ are distinct at every $c$, and $\varphi_{aa}=0$ disposes of $c=a$ and $c=b$, so **every off-diagonal Ricci entry vanishes identically on this locus, with no hypothesis on $N$ at all**. For $a=b$ the pairing is $1$ at $c\ne a$ and the term at $c=a$ is zero, so $\operatorname{Ric}(R)_{aa}=\sum_{c\ne a}N_{ac}$.

Applied to $R=W$ with $N=K$ hollow, $\operatorname{Ric}(W)_{aa}=\sum_{c\ne a}K_{ac}=(K\mathbf 1)_a$: **Ricci-flatness on the locus is exactly $K\mathbf 1=0$, and the diagonal conditions are the whole of it.** Applied to $R=Q(W)$ with $N_{ac}=K_{ac}^2+(K^2)_{ac}$, the same two facts give the block's display and also give the off-diagonal half of its conclusion for free. The block's statement $\operatorname{Ric}(Q(W))=0$ is therefore fully reached by the diagonal computation it shows, provided pair-diagonality of $Q(W)$, which is item 1 and which the argument does assert in its first clause. No normalisation of `Ric` is load-bearing anywhere here, since a constant multiple of `Ric` has the same zero set.

## 3. The cancellation, step by step

Every step holds, and I name the hypothesis each one consumes.

| Step | Holds? | Consumes |
|---|---|---|
| $K^2\mathbf 1=K(K\mathbf 1)=0$ | yes, associativity of the matrix product | $K\mathbf 1=0$ |
| $\sum_{c\ne a}(K^2)_{ac}=-(K^2)_{aa}$ | yes, the full row sums to zero | the line above |
| $(K^2)_{aa}=\sum_cK_{ac}K_{ca}=\sum_cK_{ac}^2$ | yes | symmetry of $K$ |
| $\sum_{c\ne a}K_{ac}^2=\sum_cK_{ac}^2$ | yes | $K_{aa}=0$ |
| the two sums cancel | yes, both equal $\sum_cK_{ac}^2$ | the four lines above |

**This is the part the brief expects to be correct, and it is correct, with no hypothesis used beyond the three the statement carries.** Symmetry, hollowness and zero row sums are exactly the three stated, hollowness is used twice (once in the last step and once inside the premise's $(K^2)_{ab}=\sum_{c\notin\{a,b\}}K_{ac}K_{cb}$), and nothing in the argument sees $n$, so "no dimension in it" is honest. The steps are also individually machine-checked: [sum_sqMul_offDiag](../lean/HamiltonsCubic/Results/L208RicciFoxSquare.lean#L46) carries rows two and three and [sum_sq_offDiag](../lean/HamiltonsCubic/Results/L208RicciFoxSquare.lean#L39) the fourth.

## 4. The Lean statement against the lemma, and the file's honesty about the gap

**[rowSum_sq_add_sq_cancel](../lean/HamiltonsCubic/Results/L208RicciFoxSquare.lean#L63) is section 3 and nothing else.** It quantifies over an arbitrary real matrix on an arbitrary `Fintype`, so it is a matrix fact the lemma implies once the premise and the `Ric` reading of sections 1 and 2 are supplied. The two supplied pieces are the geometry, and the file is right that they are not typed.

**Two of the file's three sentences on this are accurate and the third overstates.** [Line 25](../lean/HamiltonsCubic/Results/L208RicciFoxSquare.lean#L25) and [line 124](../lean/HamiltonsCubic/Results/L208RicciFoxSquare.lean#L124) both name the omission precisely, in the same words, once at the top and once at the bottom. Against them, [line 13](../lean/HamiltonsCubic/Results/L208RicciFoxSquare.lean#L13) reads "**THIS FILE TYPES AND PROVES THAT THE SUM VANISHES, WHICH IS THE WHOLE LEMMA ON THIS LOCUS**", and the sum vanishing is the whole lemma only **given** the premise, which is the one thing the same file says twice that it does not have. The honest form is that the file proves the lemma's arithmetic core, with the geometry in prose. The [lean/INDEX.md](../lean/INDEX.md) row carries the same construction ("`rowSum_sq_add_sq_cancel` is the lemma on the diagonal locus") and then lists the omission correctly, so both places need the same one-clause repair. **This is a wording defect and not a mathematical one**: the mathematics the file claims for itself is present and the mathematics it disclaims is true, as section 1 shows.

**What is left out is more than the sentence "the geometry" suggests, and it is small.** The premise is four lines from the structure constants, so the gap is closable in the same file the moment the layer has a diagonal Weyl operator with its sectional matrix, which [Families.lean](../lean/HamiltonsCubic/Base/Families.lean) builds as a Hadamard action of a hollow symmetric weight. That makes the gap a queued task with a known cost rather than an open question.

**Build and axioms.** `lake build HamiltonsCubic.Results.L208RicciFoxSquare` replays clean at 3006 jobs with four style warnings and no errors, the module is in the root import at [HamiltonsCubic.lean:479](../lean/HamiltonsCubic.lean#L479), and `#print axioms` returns `[propext, Classical.choice, Quot.sound]` for all five declarations the file records plus `Kss_sq_pair` and `Kss_sq_mixed`. The file's recorded axiom block matches what the toolchain prints.

## 5. The witness, and its $\theta$

**`Kss` is the Weyl part of $S^2\times S^2$ with unit-curvature factors, exactly.** That metric is Einstein with $\operatorname{Ric}=g$ and $\operatorname{scal}=4$, so the scalar piece carries sectional curvature $\operatorname{scal}/(n(n-1))=1/3$ on every coordinate $2$-plane, and subtracting it from the product's own sectional curvatures ($1$ inside a factor, $0$ across) gives $K_{12}=K_{34}=1-\tfrac13=\tfrac23$ and the four mixed entries $0-\tfrac13=-\tfrac13$. That is `Kss` entry for entry, with the pairs $\{0,1\}$ and $\{2,3\}$ the file names.

**Its arithmetic, in exact rationals.** Row sums vanish. $(K^2)_{01}=\tfrac19+\tfrac19=\tfrac29$ and $(K^2)_{02}=-\tfrac29-\tfrac29=-\tfrac49$, matching [Kss_sq_pair](../lean/HamiltonsCubic/Results/L208RicciFoxSquare.lean#L100) and [Kss_sq_mixed](../lean/HamiltonsCubic/Results/L208RicciFoxSquare.lean#L104). Then $Q(W)_{01}=\tfrac49+\tfrac29=\tfrac23$ and $Q(W)_{02}=\tfrac19-\tfrac49=-\tfrac13$, so $Q(W)=W$, and $\operatorname{Ric}(Q(W))_{aa}=0$ at all four indices. $\operatorname{Ric}(W^2)_{aa}=\tfrac49+\tfrac19+\tfrac19=\tfrac23$, which is the block's $\tfrac23I$ and the reason the cancellation is the content.

**The $\theta$ check passes.** `innerOp`'s ordered-pair doubling makes `normSq` the plain Frobenius square over unordered pairs, so $\lVert W\rVert^2=2\cdot\tfrac49+4\cdot\tfrac19=\tfrac43$. With $Q(W)=W$, $P(W)=\langle W,Q(W)\rangle=\tfrac43$, hence

$$\theta=\frac{P}{\lVert W\rVert^3}=\Big(\tfrac43\Big)^{-1/2}=\frac{\sqrt3}2=\theta_0(4),\qquad\theta^2=\tfrac34 ,$$

which is the brief's value and the record's $\theta_0(4)^2=\tfrac34$.

**One scale note, and it costs nothing.** `Kss` sits on the record's $S^2\times S^2$ ray at a third scale from the two the record writes elsewhere: [diagonal-half.md:21](../findings/diagonal-half.md#L21) gives the balanced weight as $1/(p(p-1))$ inside and $-1/(pq)$ across, which is $(\tfrac12,-\tfrac14)=\tfrac34\,$`Kss` at $p=q=2$, and [Families.lean](../lean/HamiltonsCubic/Base/Families.lean) normalises the cross entry to $-1$, which is $3\,$`Kss`. Families.lean states outright that the record fixes the family up to scale and no further, and the three quantities in play here are all insensitive to the choice: $K\mathbf 1=0$ and $\theta$ are scale-invariant and $\operatorname{Ric}(Q(cW))=c^2\operatorname{Ric}(Q(W))$ has the same zero set. `Kss` is the scale at which $Q(W)=W$, which is also the geometric one. **So the name is earned and the non-vacuity claim stands**, and the improvement available is to say which scale, since "the sectional matrix of $S^2\times S^2$" alone names a ray.

## 6. What the lemma does not reach, against the block's own list

The block names two omissions, the off-diagonal case and the Bianchi half, and both are real. **A third belongs on the list, and the headline claim about closure needs narrowing.**

**The premise is owed.** Sections 1 and 2 are asserted in the block in one clause each and derived in no block on the record and in no Lean file. They are true, and this review derives them, so the obligation is to write them down rather than to establish them. Since the block's own framing is that the Ricci half of closure was "cited in five places and derived in none", leaving its own load-bearing input in the same condition is the defect worth naming.

**These four lines are already on the record, for another purpose.** [diagonal-half.md:73](../findings/diagonal-half.md#L73), "And the multiplier vanishes", sums the off-diagonal Euler–Lagrange equation over $j\ne i$ and uses $M\mathbf 1=0$ and $(M^2)\mathbf 1=0$ to get "the left side $s_i-s_i=0$". That is L208's cancellation, with the same two ingredients in the same order, put to work showing the Lagrange multiplier $v$ of the Ricci-flatness constraint is zero. So L208 has an independent second derivation on disk, whose own consequence is verified at residual $10^{-16}$ at five named objects, and the relation runs both ways: **L208 is exactly what reconciles the record's two forms of the diagonal criticality equation**, the $v_i+v_j$ form at [diagonal-half.md:69](../findings/diagonal-half.md#L69) and the $\operatorname{diag}(s)$ form in the boxed statement below it, because $Q(W)\in\mathcal D_n$ forces $v=0$. Neither the block nor the index row cites that paragraph, and the block presents the argument as first derived here.

**How much closure this buys.** The diagonal locus contains no Weyl tensor that Conjecture A's diagonal case leaves open: that case is granted by the problem statement and, by [INDEX.md](../findings/INDEX.md)'s own row, proved outright at every $n\ge4$ in both parities via [Lemma L57](../findings/problem.md). **So the lemma adds nothing to the conjecture's coverage, and its value is elsewhere**, in three places worth stating positively. First, it makes $\mathcal D_n$ closed under $Q$, hence under $\circ$, since a sum of coordinate-diagonal tensors is coordinate-diagonal and $X\circ Y$ is the polarisation of $Q$: the diagonal locus is a subalgebra of the Fox algebra as far as the Ricci condition goes. Second, it licenses the record's diagonal criticality apparatus, which reads $Q$ through $M^{\circ2}+M^2$ and needs the result to land back in $\mathcal D_n$, as section 6's multiplier paragraph shows. Third, it is a derivation in the record's own normalisation of something the record had only by citation, which is what the block claims for it and which stands. **What it does not reach is [L24](../findings/second-order.md)'s operator $L_e=e\circ(\cdot)$ on $W^\perp$**: at diagonal $e$ and general $X$ the product leaves the locus, so the second-order apparatus still rests on the general closure statement that [r896](REVIEW_r896.md)'s identity $\operatorname{Ric}(Q(R))_{ab}=\sum_{c,d}R_{acbd}\operatorname{Ric}(R)_{cd}$ supplies and that the record has not yet promoted to a numbered result.

## 7. What would break it, and what I did to look for one

**The one line whose alteration overturns the lemma is the $\tfrac12$ at [conventions.md:77](../findings/conventions.md#L77).** Under the other $\#$ in circulation the sharp entry is $2(K^2)_{ab}$ and the conclusion becomes

$$\operatorname{Ric}(Q(W))_{aa}=\sum_cK_{ac}^2-2\sum_cK_{ac}^2=-\sum_cK_{ac}^2,$$

**nonzero at every $W\ne0$, so the lemma would be false rather than rescaled.** Screened at `Kss`, where it reads $-\tfrac23$ at all four indices. The convention the record runs in is the one that passes the record's own mandatory anchor, $\mathrm{id}^\#=(n-2)\mathrm{id}$, which I evaluated from the premise itself, and which [Sharp.lean](../lean/HamiltonsCubic/Base/Sharp.lean) discharges at $n=4$ by `native_decide`. That is two independent pins on the factor, and the record's warning that this exact factor has entered wrongly twice is what made it the first thing to check.

**Where else I looked.** (i) The bivector sign $\varphi_{ab}=E_{ba}-E_{ab}$: the sharp formula is quadratic in $c$ and $c$ is odd in the sign, so nothing moves, which is what [conventions.md:89](../findings/conventions.md#L89) already records. (ii) The `Ric` normalisation: a single sum over $c$ with no pair doubling, and any constant multiple has the same zero set, so the lemma is insensitive to it. (iii) The $\Lambda^2$ half-trace against plain Frobenius: it rescales $K$ and $\theta$ and leaves $K\mathbf 1=0$ and $\operatorname{Ric}(Q(W))=0$ where they are, though it is load-bearing for section 5's $\theta=\sqrt3/2$, which I computed under the record's half-trace convention as [Families.lean](../lean/HamiltonsCubic/Base/Families.lean) states it. (iv) Pair-diagonality of $W^\#$, the premise's least obvious half, checked by hand and screened at $n=5$ in exact arithmetic. (v) The second reading of $(W^2)_{ab}$: Hadamard square against matrix square. The block writes $K_{ab}^2$ for one and $(K^2)_{ab}$ for the other and gets both right, matching [conventions.md](../findings/conventions.md#L51)'s $M^{\circ2}+M^2$, and swapping them would give $\operatorname{Ric}(Q(W))_{aa}=0$ as well by the same cancellation, so that particular slip would be invisible here and is worth a reader's care in any consumer that reads one half alone.

## Verdict

**CONFIRMED.** The lemma is true as stated, and the premise on which the whole of it rests is true exactly, in the record's own normalisation, with the factor pinned twice by the record's own anchor. The cancellation is correct in every step and uses only the three hypotheses it states. The witness is the object it is named after, at the scale where $Q(W)=W$, and it gives $\theta=\sqrt3/2$ exactly.

**Three repairs, all documentary, none touching the mathematics.**

1. **The "whole lemma" phrasing**, at [line 13](../lean/HamiltonsCubic/Results/L208RicciFoxSquare.lean#L13) of the Lean file and in the [lean/INDEX.md](../lean/INDEX.md) row, contradicts the same file's own two disclaimers. The accurate form is that the file proves the arithmetic core and the premise sits in prose.
2. **The premise belongs on the owed list**, beside the off-diagonal case and the Bianchi half, with the note that it is four lines from the structure constants and is derived in section 1 here.
3. **The block should cite [diagonal-half.md:73](../findings/diagonal-half.md#L73)**, which carries the same four lines as the vanishing of the Ricci-flatness multiplier, and should say that L208 is what forces $v=0$ there, turning a duplication into a stated dependency.

**And one scope sentence the block would be stronger for.** What the lemma buys is that $\mathcal D_n$ is closed under $Q$, which is what the diagonal criticality apparatus needs, rather than any new coverage of Conjecture A's diagonal case, which [Lemma L57](../findings/problem.md) already carries at every $n\ge4$.
