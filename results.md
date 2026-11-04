# Results

*The numbered canon of the programme: every result stated with its hypotheses, organised by strategy, each pointing at the [findings/](findings/) file that proves it. Claims only, a result appears here once Gate 2 has passed; single-audited results are listed by number in the closing section. Numbering is owned by [findings/INDEX.md](findings/INDEX.md) and adopted here, so gaps are correct; the format is [results-spec.md](.claude/skills/research-loop/results-spec.md).*

## Where this stands

The conjecture is not proven. What exists is a problem with a definite **shape**, the maximizer is a critical point; every critical point is either diagonal in some frame or not; the diagonal side is a theorem at every $n\ge4$ of either parity; the non-diagonal side is the whole remaining problem, and a live target on that side, $\sup\{\theta:Q(W)=\theta W,\ S=0,\ W\text{ non-diagonal}\}\le\sqrt{3/2}$, with criticality part of the statement. Everything the record has measured on that side sits at or below $\sqrt{3/2}$, attained at $W_{\mathbb{CP}^2}$ and its paddings, and $\theta_0(n)>\sqrt{3/2}$ exactly when $n\ge12$.

| Piece | State |
| --- | --- |
| The problem $P$ and Conjecture A are one statement, at the constant $\Theta_n$ | **Proven at both parities at $\Theta_n$** (Lemma L0), *the $(\Leftarrow)$ half resting on a cited witness rather than an argument*, *refuted at $\theta_0(n)$, which is $\Theta_n$ at even $n$ only* |
| The diagonal case, every $n\ge4$, both parities, with its equality case | **Proven** by this record's own theorem (Lemma L57), the published grant covering even $n\ge16$. **Its $\mathop{\mathrm{tr}}W^3$ bridge is machine-checked** (Lemmas L231, L232), **and so is the whole theorem**: the bound at every diagonal $W$ at both parities (`L57_diagonal`, `L57_diagonal_odd`) and its equality case at the balanced and the unbalanced product in both directions (`L57_equality_even`, `L57_equality_odd`: a unit diagonal $W$ attains the bound iff its weight is a positive multiple of the sphere product's weight at the extremal split), in [L57Diagonal.lean](lean/HamiltonsCubic/Results/L57Diagonal.lean), [L57Odd.lean](lean/HamiltonsCubic/Results/L57Odd.lean), [L57OddEq.lean](lean/HamiltonsCubic/Results/L57OddEq.lean), [L57Attain.lean](lean/HamiltonsCubic/Results/L57Attain.lean) and [L57Sphere.lean](lean/HamiltonsCubic/Results/L57Sphere.lean) |
| Threshold $n=6+2\sqrt7$ exact, and $n\ge12$ necessary | **Proven** (Lemmas 2, 43, 44) |
| Conjecture A on every compact **Einstein** **GLOBALLY** symmetric space, $n\ge12$ | **Proven**, Gate 2 by four reviewers (Lemmas 46–48), and by two more at the wave 0 audit which added the Einstein hypothesis this row had dropped |
| Every named rival eliminated; the reducible-isotropy and two-eigenvalue families in closed form | **Proven** (Lemmas 4, 5, 10, 38, 39) |
| Diagonality decided by one kernel, frame-free | **Proven** (Lemma L37), for every linear operator on $\Lambda^2$ |
| Graded half of the critical set, over equivariant graded points | **Settled** (Lemmas 7, 8, 23, 69), above $\sqrt{3/2}$ only sphere products with both factors $\ge5$, all nondegenerate |
| Graded half over non-equivariant graded points | **Open**, a graded point at $1.088948$ on $(\mathfrak{so}(8),\mathfrak{so}(3)\oplus\mathfrak{so}(5))$ is a candidate awaiting Gate 2, and the graded set is wider than the subalgebra family (Lemma L58) |
| No maximizer near the $\mathbb{CP}^2$ orbit, $n\ge12$ | **Proven** modulo one eigenvalue bound (Lemmas 20–22); free of circular inputs, and $\alpha\le\tfrac13$ is imported without a discharging citation |
| Nondegeneracy of sphere products and $\mathbb{CP}^m$ | **Proven** (Lemmas 11, 26–28), $S^3\times S^3$ the sole exception |
| The $\le2$-negative stratum, capped at $\sqrt{3/2}$ | **Proven** (Lemmas 29–36, 42) |
| Spectral necessary conditions on all of $\mathcal W_n$, and the deficiency identity at critical points | **Proven** (Lemmas 70, 71, 73), saturation classifies, forcing the balanced sphere product at $n\ge5$ |
| $M(5)=\sqrt{3/2}$ by exact sum-of-squares certificate, and the $n=12$ block table | **Certificate: an inequality on a machine certificate, and the bound is sound**, the equality case is unproven and unreachable by that route ([L61](findings/sym3-blocks.md)). *[L62](findings/sym3-blocks.md)'s value is a proof rather than a measurement: its points are exact rationals, so its mod-$p$ rank is a rigorous lower bound and a lower bound under an exact cap is all that is needed. **[L87](findings/sym3-blocks.md)'s rank is drawn inside $\mathbb F_{46337}$ and reduces from nothing**, so the step joining it to a characteristic-zero dimension is owed, and two reviews supply routes that have not reached the lemma.* [L90](findings/sym3-blocks.md)'s stated proof was withdrawn as circular, its repair sitting twelve lines below it, and [L90](findings/sym3-blocks.md)'s stated proof was withdrawn as circular, its repair sitting twelve lines below it. **Block table: $\dim\mathcal W_{12}=1638$ is a `Lemma`; the census of $77$ constituents and $191$ multiplicities is an `Observation` at $n=12$** ([L63](findings/sym3-stability.md)). *The object is $M(5)$, the global maximum, $\Theta_5=2\sqrt2/3$, and writing $\Theta_5$ here was warning W5.* |
| $\theta$ of every strongly regular graph in closed form, with the balanced product the only saturating member | **Proven** (Lemma L74) |
| Second-order optimality, the variation calculus, two spectra | **Proven** (Lemmas 24, 50–52, 54, 67) |
| The diagonal proof lifted off the diagonal locus | **Proven**, defect priced to one term (Lemmas 15, 17–19); the closing inequality is Conjecture L16 |
| The middle band on slack alone | **Refuted**, $S^5\times S^7$ at $1.228239$ is diagonal with $S=0$, so the load-bearing hypothesis is diagonality, and $S=0$ is a consequence of it rather than a substitute |
| The non-diagonal half | **Open**, the whole remaining problem |
| Odd $n$ | The diagonal case is proved at every $n$; the non-diagonal half is open, as at even $n$ |

**The shape of what remains.** Every critical point with $S=0$ that exceeds $\sqrt{3/2}$ on the record is diagonal in some frame, and every non-diagonal critical point on the record sits at or below $\sqrt{3/2}$ (Observation L40). The diagonal side is closed by Lemma L57. The non-diagonal side is where the argument goes, and the route that carries it works the exact diagonal families of Lemma L74 for what they say about the boundary between the two sides.

## What has been achieved

- **The diagonal case is a theorem at every $n\ge4$, both parities, by this record's own argument** (Lemma L57): a Dirichlet–Cauchy–Schwarz step, a projection onto the Ricci-flat slice with an explicit kernel, and a fourth-moment lemma proved two ways. The published grant is Jäger's Theorem A at even $n\ge16$, and the dependence on it is gone.
- **Conjecture A holds on every compact Einstein symmetric space for $n\ge12$** (Lemmas 46–48): *Einstein is load-bearing and was missing from this claim, [Lemma L46](findings/problem.md)'s identity needs $\mathrm{Ric}=\lambda g$, and a reducible symmetric space whose factors carry different Einstein constants does not have it.* the Weyl part of a locally symmetric Einstein space is critical with $\theta$ a quadratic function of $\lVert W\rVert$, a dimension lemma covers the irreducible spaces, and Jensen on the partition covers the reducible ones, meeting exactly at the threshold polynomial $n^2-12n+8$.
- **The threshold is the problem's, and it is exact**: $\theta_0(n)$ crosses $\sqrt{3/2}$ at $n=6+2\sqrt7$ (Lemma L2), the invariance criterion at $a=0$ demands $\theta_0(n)$ and nothing weaker (Lemma L43), and padded $W_{\mathbb{CP}^2}$ makes the cone non-invariant for $4\le n\le11$ (Lemma L44).
- **The graded half is settled over the equivariant graded points**: above $\sqrt{3/2}$ they are two-factor sphere products with both factors $\ge5$, every one Morse–Bott nondegenerate (Lemma L69), and the subalgebra family is capped at $\theta_0(n)$ by a dimension count (Lemma L23).
- **The critical set carries exact spectral constraints**: $\lambda_{\max}\le(n-2)\lvert\lambda_{\min}\rvert$ on all of $\mathcal W_n$ (Lemma L73), the deficiency identity $\theta=\lambda_{\min}+(n-2)\lambda_{\max}-D/\lvert\lambda_{\min}\rvert$ at every critical point (Lemma L70), and saturation forces the balanced sphere product at every $n\ge5$ (Lemma L71).
- **The low strata are closed**: at most two negative eigenvalues caps $\theta$ at $\sqrt{3/2}$ (Lemmas 29–35), $S=0$ caps the negative eigenspace at $\lfloor n^2/4\rfloor$ (Lemma L36), and $M(5)=\sqrt{3/2}$ holds on all of $\mathcal W_5$ by an exact rational certificate (Lemma L61).
- **The neighbourhood of the rival is closed** for every $n\ge12$ by [Lemmas L20 and L21](#lemma-l20-no-maximizer-lies-near-the-rival-maximizers-orbit-for-every-nge12), **conditional on the four $F_\lambda$ having $m$-free entries**, L21's debt, and the only thing the tube argument still owes. *[Observation L22](#observation-l22-the-estimate-the-localization-theorem-needs-at-n121416) closes the estimate Nienhaus states and leaves open, and stands beside this bundle rather than inside it: nothing on the record consumes it.*
- **The exact diagonal families are in hand**: every strongly regular graph gives a diagonal critical point with $\theta$ in closed form, and the balanced sphere product is the only saturating member (Lemma L74).

## Relation to the existing literature

- **Böhm–Wilking** supply the invariance criterion; the cone-bridge (Lemma L43) shows the $a=0$ criterion collapses to $\langle W,Q(W)\rangle\le c(n-1)\lVert W\rVert^2$ at every point of the slice, and on $\partial\Omega_0$, where $c/\lVert W\rVert$ is fixed, to $\langle W,Q(W)\rangle\le\theta_0(n)\lVert W\rVert^3$. **That collapse does not compose into the identification at odd $n$**: Conjecture A's constant is $\Theta_n$, and $\theta_0(n)^2-\Theta_n^2=\tfrac{8(n-1)}{n^2(n+1)(n-2)}$, *$\tfrac{48}{13013}$ at $n=13$*. **What Lemma L0 gives is the identification at $\Theta_n$**, its $(\Leftarrow)$ half closed by the balanced-split witness of Nienhaus Proposition 2.25.
- **Jäger (2016)** proves the diagonal case at even $n\ge16$; Lemma L57 proves it at every $n\ge4$ by a different argument, and the equality case $S^{\lfloor n/2\rfloor}\times S^{\lceil n/2\rceil}$ comes with it.
- **Nienhaus** handles the complement of the $\mathbb{CP}^2$ tube for $10\le n\le11$ conditionally; Lemma L20 closes the tube itself for $n\ge12$, conditional on the eigenvalue bound $\alpha\le\tfrac13$ **and does not rest on Lemma L22**, while Lemma L22 addresses the estimate his Theorem 4.19 leaves open **conditionally rather than outright**, see both entries below.
- **Krasnov–Tkachev** Proposition 6.6 is Lemma L24, derived here independently; the credit is theirs.
- **Dai–Fu** Lemma 3.3 at $s=0$ is the two-spectra identity of Lemma L50; **Li (2022)** Theorem 1.8 supplies the product rule behind Lemma L67; **Nienhaus–Petersen–Wink** supply the basis of Lemma L54 and **Petersen–Wink** the density of Lemma L68.
- **Huisken (1985)** is the expansion of Lemma L45, term for term, coefficient $\tfrac3{n-2}$ included.
- **Deninger–Grundhöfer–Kramer (2023)** solve the diagonal criticality equation on strongly regular graphs; Lemma L74 re-derives their correspondence in this record's normalisation and adds the closed form for $\theta$ and the saturation classification.
- **Fox, Nienhaus** supply the rival families of Lemma L5, all eliminated on value.
- **Case–Tyrrell (2023)** state the per-block cubic bound squared and two-sided, and its vector form is the sample-skewness bound of **Wilkins (1944)** and **Kirby (1974)**. Lemma L225 reaches the signed form with its equality case by a tangent cubic, a confirmation.

## The route that now carries the argument

**R27, block induction with coupled arguments** ([routes.md](routes.md)). On the block subalgebra $\mathcal S_J$, the fixed space of the sign flips off $J$, a Weyl tensor is a family of symmetric $\lvert J\rvert\times\lvert J\rvert$ blocks $M_a$, a curvature block $R_J$ fixed by $\sum_aM_a$, and an outer diagonal. The route climbs $\lvert J\rvert$ one index at a time, each step asking that $\sup P=\Theta_n$ on the unit sphere of $\mathcal S_J$, attained at commuting blocks, until $\mathcal S_{[n]}=\mathcal W_n$. Lemma L57 is $\lvert J\rvert=1$, Lemma L224 is $\lvert J\rvert=2$, and Lemma L225 bounds each block's cubic at $\lvert J\rvert\ge3$. The step at $\lvert J\rvert=3$ is open, and the route is abandoned if it reduces to a bound of the block cubics against the couplings taken separately, which post F67 fences.

**R17, the lifted Jäger chain**, is the fallback, its closing inequality Conjecture L16. R24 to R26 were the primaries before R27, and R15's exact diagonal families are largely closed, their records in the register.

**R12, the isotype census** is stalled. Routes R1–R10, R13 and R14 are closed against their stated criteria and their closing reasons are in the register; among them, the $\Delta$-half (R10) closes because every object it names is equivariant and cannot see the violation, the spectral Turán transfer (R13) closes on refutation, and the deficiency identity (R14) closes because $D$ is a function of $(\theta,\lambda_{\min},\lambda_{\max})$ at a critical point, so Lemma L71 classifies and cannot serve as a proof step.

## What is missing to prove the conjecture

- **The $\lvert J\rvert=3$ step of R27.** That $\sup P=\Theta_n$ on the unit sphere of the block subalgebra $\mathcal S_J$ with $\lvert J\rvert=3$, attained at commuting blocks, where each block couples to the curvature block $R_J$ and to the others through the outer diagonal.
- **The non-diagonal half.** A proof that every non-diagonal critical point with $S=0$ has $\theta\le\sqrt{3/2}$. Everything measured agrees (Observation L40) and nothing proves it beyond the strata of Lemmas 29–35 and the equivariant graded points of Lemma L69.
- **Gate 2 on the second graded point.** A graded, non-equivariant critical point on $(\mathfrak{so}(8),\mathfrak{so}(3)\oplus\mathfrak{so}(5))$ at $\theta=1.088948$ is a candidate; it sits below $\sqrt{3/2}$ and above every other non-equivariant graded value on file.
- **The closing inequality of the lifted proof** is Conjecture L16, and its Lemma L18 cross-term bound is unproven on the non-commuting remainder.
- **A separator that sees the value rather than the defect.** the triality image of $S^3\times S^5$ is a strict transverse local maximum below $\theta_0(8)$ (Lemma L9), the carrier inequality of Observation L12 fails to separate, and the moment and shared-frame relaxations (Lemmas 13, 52) are identities on the diagonal family and weaker than one-line estimates off it.

## How the attack is organised

**Two levels.** A **strategy** is a family of approach; there are five, every result below carries one as a tag, and they do not close. A **route** is a specific mechanism proposed to close the conjecture, which opens, is worked, and closes against a stated criterion; fifteen are on record in [routes.md](routes.md), and a route sits inside a strategy.

- **Direct bounds.** Inequalities that hold for every $W$, or for every critical $W$: spectral necessary conditions, the deficiency identity, the min-entry bound, exact certificates, and the exact diagonal families of route R15.
- **Landscape.** The critical-point map. Any maximizer is a critical point of $P$ on $\{\lVert W\rVert=1\}$, so locating, classifying and eliminating critical points narrows what a counterexample can look like; this is where the graded half and the low strata are settled.
- **Lifting.** The diagonal proof carried off the diagonal locus, with the obstruction identified as one term and priced.
- **Localization.** The sphere split around the rival maximizer's orbit, the one strategy that has produced a near-unconditional theorem about the whole sphere rather than about critical points.
- **Second-order.** Constraints on the maximizer beyond criticality, the eigenvalue bound on the multiplication operator, the variation calculus along a critical orbit, the two-spectra identity, and the support dichotomy.

**Conjecture D (extending the localization reduction to $n\ge12$).** *For every $n\ge12$, if Conjecture A holds at every critical point outside $SO(n).W_{\mathbb{CP}^2}$, then $P(W)\le\theta_0(n)$ for every unit Weyl operator $W$ at angular distance $\ge\gamma$ from that orbit, for some $\gamma\le0.5748$.* This is Nienhaus's Theorem 4.19 with its dimension range extended, stated with the conditionality his proof carries. With Lemma L20 it would give the conjecture from the critical-point case for even $n\ge12$.

## Preliminary: the granted assumption, and its repair

The problem statement grants the diagonal case. The published diagonal case is Jäger's 2016 Münster thesis, whose Theorem A covers **even $n\ge16$** and leaves $n=12,14$ and odd $n$ untreated, so at the threshold dimensions the grant is unpublished. This record carries the diagonal case as its own theorem at every $n\ge4$, both parities, with its equality case (Lemma L57), and the grant is a courtesy rather than a dependency. Lemma L1, which repairs Jäger's own argument at $n=12,14$, is a correction offered to the setter and is listed in the closing section as audit owed.

## Scope note: parity

The problem statement does not fix the parity of $n$. The balanced maximizer $S^{n/2}\times S^{n/2}$ exists only for even $n$, so the headline statement is an even-$n$ one; the odd analogue is $S^m\times S^{m+1}$, and Lemma L57's threshold is $\Theta_n^2=2(n-1)(n-2)/n^2$ at even $n$ and $2(n-1)(n-3)/((n+1)(n-2))$ at odd $n$, attained at $S^{\lfloor n/2\rfloor}\times S^{\lceil n/2\rceil}$. Lemma L71's saturation statement has no odd-$n$ member, since $\dim\mathfrak m=n^2/4$ is then not an integer. What remains conjectural at odd $n$ is the non-diagonal half, as at even $n$; Lemma L2's crossover and **Lemma L3's local maximality is even-$n$ only** ($W^*$ exists at no odd $n$) and its warrant in its *integer* conclusion. **The real crossover is not**: at odd $n$ it is $n^2-13n+18=0$, root $\frac{13+\sqrt{97}}2=11.4244$, against $6+2\sqrt7=11.2915$ at even $n$.

## The results at a glance

Each result carries the strategy it serves, *landscape*, *direct*, *lifting*, *localization* or *second-order*; the foundation results stand outside the strategies. Labels are literal: **Lemma** is proven with Gate 1 and Gate 2 passed, **Observation** is verified numerically at the dimensions stated, **Conjecture** is a candidate. Sections 9 and 10 mirror each other exactly.

#### Foundation, the problem, its threshold, and the diagonal case

Every strategy leans on these: the diagonal theorem, the exact constant, and the symmetric-space case.

- **Lemma L231 (diagonal-half). $P$ on the diagonal locus is the weighted-graph functional.** At every $n$ and every weight $w$ of $\mathcal D_n$, $P(\mathrm{diag}\,w)=\tfrac12(\sum_{a,b}w_{ab}^3+\mathop{\mathrm{tr}}w^3)$. Machine-checked on the standard axioms. The record carried this identity on four test points until 2026-09-18.
- **Lemma L232 (diagonal-half). $\theta=\theta_{p,q}$ at every sphere product.** At every split with $p,q\ge2$, the unit-norm member has $\theta=\sqrt{2(n-1)(p-1)(q-1)/((n-2)pq)}$. Machine-checked. This is the lower half of $\sup\ge\Theta_n$, leaving only the choice of split.

- **Lemma L57. The diagonal case at every $n\ge4$, both parities, with its equality case.** For every $n\ge4$ and every unit $W$ diagonal in some frame, $\theta\le\Theta_n$ with $\Theta_n^2=2(n-1)(n-2)/n^2$ at even $n$ and $2(n-1)(n-3)/((n+1)(n-2))$ at odd $n$, equality exactly at $S^{\lfloor n/2\rfloor}\times S^{\lceil n/2\rceil}$. Three steps, each proved.

- **Lemma L43. The invariance criterion at $a=0$ demands $\theta_0(n)$ and nothing weaker.** The cone bridge $\Phi(cI+W)=c^2(n-1)I+\Phi(W)$ collapses Böhm–Wilking's criterion on the Einstein slice to $\langle W,Q(W)\rangle\le c(n-1)\lVert W\rVert^2$, and on $\partial\Omega_0$ at $\lVert W\rVert=1$ the boundary forces $c(n-1)=\theta_0(n)$ exactly. So the problem's constant is forced by the criterion, and the $a\to n/4$ end is Beitz's.

- **Lemma L44. $n\ge12$ cannot be weakened.** Zero-padded $W_{\mathbb{CP}^2}$ keeps $\theta=\sqrt{3/2}$ at every $n$, and the operator $cI+W$ it defines lies on $\partial\Omega_0$, so Böhm–Wilking's invariance criterion fails there exactly when $\theta_0(n)<\sqrt{3/2}$. The cone is non-invariant for $4\le n\le11$ by a witness: the dimension hypothesis is the problem's.

- **Lemma L45. Off the slice: five surviving triples, and one coupling.** For $n\ge4$ and $R=cI+Y+W$ with $Y$ the traceless-Ricci part, five of the cubic's ten triples vanish and five survive; the one surviving triple containing $W$ absent from the slice is $(Y,Y,W)=\tfrac3{n-2}\langle W,\mathrm{Ric}_0\wedge\mathrm{Ric}_0\rangle$. Demanding the criterion at both signs of $W$ gives a two-sided bound.

- **Lemma L46. At a locally symmetric Einstein space the Weyl part is critical, with $\theta$ quadratic in $\lVert W\rVert$.** For $\mathrm{Ric}=\lambda g$ of either sign and $W=R-\frac\lambda{n-1}I\ne0$, $Q(W)=\lambda W$, so $W/\lVert W\rVert$ is a critical point with $\theta=\lambda/\lVert W\rVert$, and at $\lambda=\tfrac12$, $\theta^2=1/(4(\lVert R\rVert^2-(\mathop{\mathrm{tr}}R)^2/N))$. No compactness is used. The cubic problem on these spaces is a quadratic condition on $\lVert W\rVert$.

#### Landscape, the critical-point map

Where the threshold comes from; the peak is real; the graded half and the low strata settled; every rival eliminated.

- **Lemma L2 (landscape). Exact dimension threshold.** The two named competitors swap ranks in closed form at $n=6+2\sqrt7\approx11.29$ at even $n$ and at $\frac{13+\sqrt{97}}2\approx11.42$ at odd $n$; no integer lies between the two roots, so the integer cutoff is $12$ at both parities, reproducing the conjecture's $n\ge12$ exactly rather than approximately. Below the crossover the $\mathbb{CP}^2$-type competitor genuinely wins of the two.

- **Lemma L3 (landscape). The balanced product is a local maximum in $\mathcal W_n$, at every even $n\ge8$.** Not merely within $\mathcal D_n$, and strictly so transverse to its orbit, with transverse Hessian at most $-6\theta/(n-2)$: Lemmas L24 and L27 give the Hessian, Nienhaus's Proposition 2.25 gives $\theta>0$, and a tubular neighbourhood of the orbit turns the Hessian into local maximality. **At $n=6$ the argument stops**, that being L27's excluded $(3,3)$, where nine Hessian null directions lie transverse to the orbit.

- **Lemma L4 (landscape). A generator for critical points.** Any $K\subseteq SO(n)$ with $\dim\mathcal W_n^K=1$ yields a critical point automatically, by equivariance of $Q$ and $Q$-closure of $\mathcal W_n$; $(\Lambda^4)^K=0$ is unused and unnecessary. The two-eigenvalue Casimir family it draws on has the closed form $\theta=\tfrac2n\sqrt{rN/(N-r)}$, **derived** at Lemma L23. **The family is not non-diagonalizable**: its own maximiser $\mathfrak{so}(n/2)\oplus\mathfrak{so}(n/2)$ is coordinate-diagonal at every even $n$, and only the bi-invariant simple members are established as non-diagonalizable.

- **Observation L5 (landscape). Rival critical-point families.** Seven families examined and compared against the two named competitors. **The comparison that holds is against the balanced product**, at every $n$ and both parities, read against $\Theta_n$. **No family is eliminated against padded $W_{\mathbb{CP}^2}$**: Fox's $r=4$ subalgebra attains $\sqrt{3/2}$ exactly and beats $\theta_0(8)$, and every two-factor product with $\tfrac1{p-1}+\tfrac1{q-1}-\tfrac1{p+q-1}<\tfrac13$ exceeds it, $S^5\times S^7$ at $\theta=1.2282392$ being the first. The highest closed-form supremum among the families closed in full is $\theta(\mathbb{HP}^2)=\sqrt{56/45}=1.1155467$.

- **Conjecture L6 (landscape). The zero-defect set, and why it hides no rival.** Where the defect vanishes the diagonal argument applies verbatim, but that set is much larger than the diagonal orbit (codimension $\binom n4$) and does contain non-diagonalizable critical points. All of them sit low: proven for the symmetric family, tested for the symmetry-free remainder.

- **Lemma L7 (landscape). A bound at every critical point, and its equality class.** A compression of the criticality equation bounds the value against the defect and one Ricci term, with equality exactly where $\mathop{\mathrm{ran}}W_+\oplus\mathop{\mathrm{ran}}W_-$ is a $\mathbb Z_2$-graded subalgebra with even part $\mathop{\mathrm{ran}}W_+$ (**a symmetric pair only when $\ker W=0$**) and the eigenspace ranges are bracket-graded **modulo $\ker W$**, which is wider than the compact symmetric pairs. A companion closed form pins such a point by its pair's dimensions alone.

- **Lemma L154 (landscape). The trace of $X_{\mathrm{inv}}$ vanishes only where the operator does.** At every critical point $W\ne0$, $\mathop{\mathrm{tr}}X_{\mathrm{inv}}=0$ exactly when $X_{\mathrm{inv}}=0$, the three spectral-diagonal blocks being positive semidefinite. At scalar $\mathrm{Ric}(\lvert W\rvert)$ this upgrades Lemma L7's equality class from a trace to the operator.

- **Lemma L155 (landscape). $X_{\mathrm{inv}}$ vanishes exactly on the $\mathbb Z_2$-graded subalgebras, with no criticality.** For every symmetric $W\ne0$, $X_{\mathrm{inv}}=0$ exactly when $\mathop{\mathrm{ran}}W_+\oplus\mathop{\mathrm{ran}}W_-$ is a graded subalgebra of $\mathfrak{so}(n)$ with even part $\mathop{\mathrm{ran}}W_+$, so $J_5=0$ there whatever $h$ is. This retires Lemma L7's *modulo $\ker W$* hedge.

- **Lemma L156 (second-order). The balanced orbit's contour constant, corrected, and its optimum.** $C=\tfrac{\alpha(1+\alpha)}{d(d-\gamma)}$ with $d=\min(\alpha,D-\alpha)$, replacing a form valid only while $\lambda_-$ is the spectral point nearest the contour. The objective $C/\gamma$ is least at the equidistant contour, giving $\tfrac{42}{11}$ at $n=12$.

- **Lemma L157 (second-order). The reach parameter is determined by a fixed point, not chosen.** Holding the second-derivative coupling along the whole segment makes $\eta=r/\rho$ self-consistent, with largest solution $\eta^*=(2t+1-\sqrt{4t+1})/(2t)$. Freezing $\eta=\tfrac12$ cost about $2.9$ at the binding direction, and two reviewers had declared the fixed point absent.

- **Lemma L158 (second-order). Which tube branch binds is one dimension-dependent constant.** Branch 1's infimum sits below its value at $u=0$, and branch 2's at the homogeneity kink $w_0=(n-4)/n$. The threshold is $T=18.00$ at $n=12$ against $\sup\lvert P\rvert\le4.162$, so branch 2 binds there with a factor-$4$ margin.

- **Lemma L159 (landscape). The involutions of the compact $\mathfrak{so}(n)$, classified.** For $n\ge3$ and $n\ne8$, every involutive automorphism is $O(n)$-conjugate to exactly one of $\lfloor n/2\rfloor+1$ standard classes at odd $n$ and $+2$ at even $n$, with fixed algebra $\mathfrak{so}(p)\oplus\mathfrak{so}(n-p)$ or $\mathfrak u(n/2)$. $\mathfrak{spin}(7)$ is what excludes $n=8$.

- **Lemma L160 (landscape). The mixed summand dies, and every corank reduces to the maximal-rank branch.** $\mathop{\mathrm{Hom}}(\ker x,\mathop{\mathrm{im}}x)$ contributes nothing to $\mathfrak z(\mathfrak c)\cap\mathfrak c^\perp$ exactly when $m\ne3$, so Lemma L32's maximal-rank computation covers every corank, and the $\mathfrak{su}(2)$ exception is rank two at every corank.

- **Conjecture L8 (landscape). The graded case reduces to a check that is finite only if a classification this record does not hold is available.** An equivariant graded point's value follows from its pair's dimensions and one Casimir ratio **when the isotropy is simple and $2q>p$**, **not in general**: the formula has a pole on an infinite Pell family, $2q-p=0$ at $n\in\{6,25,96,361,\dots\}$, including $\mathbb{CP}^2$ itself, and at reducible isotropy no single Casimir exists. So the classification of compact symmetric pairs makes the equivariant graded case finite. Every equivariant graded point above the rival maximizer is a sphere product, and every sphere product is defect-free.

- **Lemma L9 (landscape). The high ground at $n=8$ has at least two peaks.** Two strict local maxima transverse to their $O(8)$-orbits, at different values: the balanced product (Lemma L3) at $\theta_0(8)^2=\tfrac{21}{16}$, and the triality image $\tau W_{3,5}$ of $S^3\times S^5$ at $\theta^2=\tfrac{56}{45}$. *Its identification with the quaternionic-Kähler operator on $\mathbb{HP}^2$ is owed.*

- **Lemma L10 (landscape). The one-parameter-per-factor families carry two critical points each, and the $\mathbb{CP}^m$ family attains the threshold at $m=2$.** Each such family is one-dimensional, so its points are $\pm W$ and are forced rather than found; one per family. For $\mathbb{CP}^m$, $\theta^2=(m+1)(2m-1)/(3m(m-1))$, exactly $3/2$ at $m=2$ and decreasing; every other family's point sits below the threshold.

- **Lemma L11 (landscape). $S^p\times S^q$ is Morse–Bott nondegenerate for $p,q\ge3$ with $(p,q)\ne(3,3)$, at the unpadded dimension $n=p+q$.** *One degenerate case in that range, $(3,3)$. At $\min(p,q)=2$ the dangerous eigenvalue exceeds $\tfrac12$ by $\frac1{2(n-3)}$, which costs **maximality** rather than nondegeneracy, a different failure, and one whose nondegeneracy side is owed. **At a padded dimension the $p=2$ family is genuinely degenerate**, so the two readings the record carried were each true of a different object.* The Hessian's kernel is exactly the tangent space to the critical orbit, of dimension $k\,l$, verified at all 36 splits up to $n=14$ and proven in exact arithmetic at eight. The one exception is representation-theoretic rather than dimensional, and the rival maximizer satisfies the same identity.

- **Observation L12 (landscape). The ungraded half is open; its carrier inequality holds but does not separate.** The inequality is valid and sharp at the rival maximizer. But $(S^m)^3$ (zero-defect, exactly critical, on the strict side), drives its bound to $4/3$, so it cannot separate the two classes. Any repair must be sensitive to $n$ or to the value.

- **Lemma L23 (landscape). Conjecture A on the subalgebra family, with gradedness doing the separating.** For $W\propto\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id}$ **that satisfies $Q(W)=\theta W$** the value depends on $\dim\mathfrak h$ alone; a sum of squares then caps that dimension at $n(n-2)/4$, where the value is $\theta_0(n)$ and $W$ is graded. **The cap is not a Lie-theoretic dimension bound**, without the eigen-equation it is false, $\mathfrak u(3)\subset\mathfrak{so}(6)$ sitting at $r=9$ against $6$ and $\mathfrak g_2\subset\mathfrak{so}(7)$ at $14$ against $35/4$, **and it is not convention-free**: a general Killing constant $\kappa$ gives $\kappa N/2(\kappa+2)$. The family excludes every frontier point.

- **Observation L25 (landscape). Every ungraded critical point on file fails that bound, except on the $W_{\mathbb{CP}^2}$ orbit.** Across $155$ converged points at $n=6$ and every structured ungraded point, $\lambda_{\max}>\tfrac12$ **except at $W_{\mathbb{CP}^2}$ and its paddings, where it is exactly $\tfrac12$**, that point being the $n=4$ maximiser, where [Lemma L24](findings/second-order.md) forces equality. *The range $1.17$ to $96.3$ described the $n=6$ solver population alone.* Graded points can fail the bound too, so it detects non-maximality.

- **Lemma L26 (landscape). One eigenvalue family of the sphere-product spectrum, in closed form.** For a 2-plane in each block, the Bianchi-projected product is an eigenvector with $\mu=(n-2)/(2(p-1)(q-1))$, so $\mu\ge\tfrac12$ at exactly two splits and for different reasons: strictly above at $\min(p,q)=2$, equal at $(3,3)$. The eigenvector and the eigenvalue $\lambda=\tfrac12(\varepsilon_{PP}+\varepsilon_{QQ})-\varepsilon_{PQ}$ hold for any three-block diagonal operator, with no criticality; criticality enters only to fix the three block values, which is what collapses $\lambda$ to $\mu$. It bounds $\lambda_{\max}$ from below only.

- **Lemma L27 (landscape). Sphere products $S^p\times S^q$ with $p,q\ge3$, $(p,q)\ne(3,3)$, $n=p+q$, are Morse–Bott nondegenerate.** Each of the ten summands is $O(p)\times O(q)$-irreducible and their Young labels are distinct, so the decomposition is multiplicity-free and $L_e$ is scalar on each, each value an eigenvalue, not a lower bound. **The maximum $\tfrac12$ is over $W^\perp$**, $\langle W\rangle$ carrying $1$. *$n=p+q$ is part of the statement: padding destroys nondegeneracy.* For $p,q\ge3$ other than $(3,3)$, $\lambda_{\max}=\tfrac12$ on the orbit alone.

- **Lemma L28 (landscape). The $\mathbb{CP}^m$ family is nondegenerate at every $m\ge3$.** The $U(m)$-decomposition is multiplicity-free, so Schur fixes one eigenvalue per summand, and each is $1-\frac{c_S+q_S^2}{4(m+1)}$. **Besides the orbit tangent, which carries $\tfrac12$ at every $m$**, only $\tfrac2{m+1}$ reaches $\tfrac12$, at $m=3$, where that summand is **absent**, by an $\mathfrak{su}(3)$ tensor-product argument rather than by the stable branching rule, which starts at $m\ge4$.

- **Lemma L29 (landscape). One positive and two negative eigenvalues (counted WITH multiplicity), cap $\theta$ at $\sqrt{3/2}$.** *The counting convention is load-bearing on the positive side: under the distinct-value reading the proof fails, and no covering result closes that case.* Dimension-free, attained at $(2,-1,-1)/\sqrt6$, padded $W_{\mathbb{CP}^2}$. Three sign-blocks of the cubic vanish structurally, the pair cap bounds the fourth, and trace-freeness collapses the estimate to one closed form with a single maximum.

- **Lemma L30 (landscape). A small negative eigenspace forces a small support.** Ricci-flatness is the positive-semidefinite identity $\sum_\alpha\lambda_\alpha v_\alpha^{\mathsf T}v_\alpha=0$, so the positive and negative sides share an image, and every eigenvector with **nonzero** eigenvalue has its image inside $U=\sum_{\lambda_\alpha<0}\mathop{\mathrm{im}}v_\alpha$. *The qualifier is necessary: a kernel eigenvector escapes it.* **The hypothesis is $\dim U<n$ and no count of negative eigenvalues replaces it.** *The support claim is proved, and so is the norm-and-$\theta$ clause that makes the reduction useful: it is [Lemma L164](findings/stratum-two-negative.md) at L30's $U$, the negative support, kernel-checked there as `L30_padding` and at every nonzero linear Weyl operator as `L30_padding_exists`.*

- **Lemma L31 (landscape). The bracket cap, characterised.** For orthonormal $X,Y\in\mathfrak{so}(n)$, $\|[X,Y]\|^2=2$ exactly when they anticommute, both have rank $4$ with every singular value $1/\sqrt2$, and their images agree. The root system gives $\max_Y\|[X,Y]\|^2=(s_1+s_2)^2$ as an identity, Cauchy–Schwarz gives the cap and the rank, and a separate triangle-equality step gives the anticommuting and the images. **The cap $\lVert[X,Y]\rVert^2\le2$ is the half seven consumers cite.**

- **Lemma L32 (landscape). A bivector's centraliser collapses to a line, REQUIRES $\mathfrak c\ne0$, a hypothesis this entry omitted.** *Refuted as stated by two reviewers with the witness $x=e_{12}$ in $\mathfrak{so}(3)$, which the stated exception does not cover.* For skew $x$ with $\mathfrak c=\mathfrak z(x)\cap x^\perp\ne0$, $\mathfrak z(\mathfrak c)\cap\mathfrak c^\perp=\mathbb Rx$ unless $x$ is a multiple of a complex structure on a $4$-plane, where it is an $\mathfrak{su}(2)$. Three root-system lines, uniform in the singular values.

- **Lemma L33 (landscape). One eigenvalue of one sign forces the tensor to vanish.** If $W\in\mathrm{Weyl}_m$ has a **one-dimensional** eigenspace on one side, exactly one eigenvalue counted *with multiplicity* and that eigenvector is not a complex-structure multiple on a $4$-plane, then $W=0$. This answers the question item B0 had been reduced to; the padded $\mathrm{Weyl}_4$ family is the only boundary case.

- **Lemma L34 (landscape). Full support with two negative eigenvalues, at $m=6$, $m=7$ and $m=8$.** Two padded signature-$(2,1)$ $\mathrm{Weyl}_4$ tensors at $q=r>0$, on 4-planes in a named relative position, sum to a $\mathrm{Weyl}_m$ element with $\dim U=m$, **refuting the descent statement B0 rested on, at those dimensions.** The claim is existential: **two 4-planes span at most eight dimensions, so the family provably cannot reach $m\ge10$**, which is where the stratum argument needed it. *Members with $\theta>0$ exist and the family's supremum is measured rather than derived.*

- **Lemma L35 (landscape). At most two negative eigenvalues caps $\theta$ at $\sqrt{3/2}$, at every dimension.** The eigenframe cubic relaxes to a transportation problem in the bracket tensor; dropping its row marginals leaves a pair-capped triangle packing on the support alone, free of $n$. **Proved in Lean in full** ([L35Statement.lean](lean/HamiltonsCubic/Results/L35Statement.lean), through [L35Weyl.lean](lean/HamiltonsCubic/Results/L35Weyl.lean)); its closing inequality is closed form on $(0,\tfrac13]$, an exact factorisation with a double root at the endpoint, and rational interval arithmetic in the kernel between.

- **Lemma L36 (landscape). $S=0$ caps the negative eigenspace at $\lfloor n^2/4\rfloor$.** Slack zero says the negative eigenspace is isotropic for the Cartan 3-form $\langle[x,y],z\rangle$, and such a subspace of $\mathfrak{so}(n)$ has dimension at most $\lfloor n^2/4\rfloor$, attained by the mixed planes $\mathbb R^p\otimes\mathbb R^q$ at $p=\lceil n/2\rceil$, **not by the symmetric pair, which is their complement and is not isotropic**. A continuous analogue of Mantel's theorem.

- **Lemma L37 (landscape). Diagonality is decided by a single kernel.** Let $\delta_A(X)=AX+XA$ for symmetric $A$ and $\Phi_W(A)=[W,\delta_A]$. Then $W$ is diagonal in some orthonormal frame if and only if some $A\in\ker\Phi_W$ has pairwise-distinct sums $a_i+a_j$, **which is exactly simple spectrum of $\delta_A$ on $\Lambda^2$**. *The quantifier is load-bearing, $\mathrm{Id}$ always lying in the kernel with all sums equal.* The corollary $\dim\ker\Phi_W<n$ certifies non-diagonality, and the residual case reduces to **one generic test** rather than an $O(n)$ search, the distinct-sums condition being the non-vanishing of $\mathop{\mathrm{disc}}(\chi_{\delta_A})$, polynomial in $A$. **Nothing here needs criticality or $W\in\mathcal W_n$.**

- **Lemma L38 (landscape). Two families in closed form, strictly decreasing, meeting at $W_{\mathbb{CP}^2}$.** On the $\mathbb{CP}^m$ family $\theta^2=(m+1)(2m-1)/(3m(m-1))$, and on the Kähler family of $(\mathfrak{su}(m),\mathfrak{so}(m))$ inside $\mathfrak{so}(2m)$, $\theta^2=m(m+1)/((m-1)(m+2))$. **Both strictly decreasing on $m\ge2$ with common maximum $\tfrac32$ at their shared $m=2$ member.** *That maximum is a fence rather than a separation: it is attained at $W_{\mathbb{CP}^2}$, and at their own $n=2m$ both families exceed $\theta_0$ at the small members.* **Owed: Weyl-ness of the second family at general $m$.**

- **Lemma L39 (landscape). The two-eigenvalue formula for an arbitrary symmetric pair.** For any symmetric pair $(\mathfrak g,\mathfrak k)$ inside $\mathfrak{so}(n)$ with $p=\dim\mathfrak k$, $q=\dim\mathfrak m$, the two-eigenvalue point has $S_{\mathfrak{kkm}}=S_{\mathfrak{mmm}}=0$ and $\theta^2=(S_{\mathfrak{kkk}}q^2+3S_{\mathfrak{kmm}}p^2-2p^3+2pq^2)^2/(4p^3q(p+q)^3)$; for simple $\mathfrak g$ the constants come from $c=2h^\vee/I_\rho$.

- **Observation L40 (landscape). The surviving target, measured.** Over every catalogued critical point, with diagonality decided by Lemma L37, $\sup\{\theta:Q(W)=\theta W,\ S=0,\ W\text{ non-diagonal}\}=\sqrt{3/2}$, attained at $W_{\mathbb{CP}^2}$ and every padding of it. Diagonal controls, $S^5\times S^7$ at $1.228239$ among them, are excluded by the criterion.

- **Lemma L42 (landscape). The sharp dual weight.** For a positive spectrum $\lambda_P$ with at least three entries, the pair-capped triangle packing $M(\lambda_P)$ satisfies $3M(\lambda_P)\le h(s^2-u)$ with $h$ the harmonic mean of the three largest positives, $s=\sum\lambda$, $u=\sum\lambda^2$, and the constant cannot be improved.

- **Lemma L47 (landscape). The dimension lemma for symmetric spaces.** Cauchy–Schwarz gives $\dim\mathfrak h\le\frac{3n^2(n-1)}{2(7n-4)}\Rightarrow\lVert W\rVert^2\ge\frac16$, covering every compact irreducible symmetric space of rank $\ge2$ **with $W\ne0$**, plus $\mathbb{OP}^2$, each by a nonnegative-coefficient certificate. *The step is sharp, with equality on every simple-isotropy space; the certificates themselves live in a script rather than in the record.*

- **Lemma L48 (landscape). The reducible case, and the symmetric-space theorem.** For a product of Einstein factors sharing a constant, $R$'s mixed terms vanish and $\lVert W\rVert^2=\sum_a\lVert W_a\rVert^2+B$ with **$B$ depending on the partition alone**, *not $\lVert W\rVert^2$, which $\mathbb{CP}^3\times S^6$ and $S^6\times S^6$ separate at one partition.* Convexity puts the minimum at the balanced split. The two halves meet at $n^2-12n+8$, the threshold polynomial, **recovered rather than assumed.** *The Theorem needs $W\ne0$, and its equality set is the balanced products of two space forms of equal constant positive curvature, $\mathbb{RP}^{n/2}\times\mathbb{RP}^{n/2}$ included.*

- **Lemma L49 (landscape). The collapse space.** Writing $\theta=\sum\lambda_\alpha^3+3\sum_{\alpha<\beta<\gamma}T_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta\lambda_\gamma$ in an eigenframe, at $\langle A,B\rangle=-\tfrac12\mathop{\mathrm{tr}}(AB)$, the $T$ for which one $c$ gives $\theta=c\sum\lambda_\alpha^3$ at every trace-free spectrum form a subspace, and it is exactly the $T$ constant on distinct triples, at every $N\ge3$.

- **Observation L56 (landscape). The named graded families have a floor; the graded set has another.** Among sphere products at fixed $n$ the smallest gap sits at the most unbalanced factorisation, $0.062994$ at $S^3\times S^7$, $0.038925$ at $S^3\times S^9$, and the balanced product at the largest; the vertex entries $-q/(p-1)$, $-p/(q-1)$, $1$ make this elementary.

- **Lemma L58 (landscape). The graded set is strictly wider than the subalgebra family.** A Casimir point $W_{\mathfrak h}=c(\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id})$ has exactly two eigenvalues, both nonzero, so no critical point with three distinct eigenvalues or a nonzero kernel lies in the subalgebra family. The Einstein product $S^5\times S^7$ at $n=12$, pair-graded with three eigenvalues and $\theta^2=\tfrac{264}{175}>\tfrac32$, and $W_{\mathbb{CP}^2}$ at $n=4$, with a kernel, are graded and outside it.

- **Lemma L69 (landscape). Above $\sqrt{3/2}$ the equivariant **pair-graded** points, with $\ker W=0$ and $n\ne8$, are nondegenerate sphere products with factors $\ge5$.** For $n\ge12$, every such critical point with $\theta\ge\sqrt{3/2}$ is $S^p\times S^q$ with $p,q\ge5$, **the three scope conditions are load-bearing**, padded $W_{\mathbb{CP}^2}$ at $n=12$ being a word-for-word counterexample without them, **and the enumeration behind "every" rests on Cartan's classification, which [references/](references/) does not hold.** Each is Morse–Bott nondegenerate with $\lambda_{\max}(L_e|_{W^\perp})=\tfrac12$ on the orbit tangent alone. The split condition is $\frac1{p-1}+\frac1{q-1}-\frac1{n-1}\le\frac13$, which at $p=5$ reads $n\ge12$.

#### Direct bounds, inequalities for every $W$, and for every critical $W$

Spectral necessary conditions, the deficiency identity and its saturation, exact certificates, and the exact diagonal families of route R15.

- **Lemma L13 (direct). The spectral-moment ceiling.** From criticality and $O(n)$-equivariance alone, $\theta^2(1+k_0/4)\le\kappa_n$ at every critical point, so the **best output the method can conceivably give** is $\theta\le2-o(1)$ against a true value below $\sqrt2$. *What is closed is a truncation: three universal moment identities do not separate $\theta$, the second being constant in $W$, and the fourth moment reaches only $14\times$ granting an oracle.* **For a known $L_W$ the moment sequence does determine $\theta$**, so the method is not closed by the moments being the wrong invariants. $\kappa_n$ is proven at even $n$ and open at odd $n\ge15$.

- **L14 (direct), WITHDRAWN**, by two reviewers independently: the entry promised a bound on $\langle W^\#,W\rangle$ and displayed no inequality. The identity behind the candidate is exact in the coordinate-$2$-plane frame and saturated there by the sphere product at every even $n$ tested, but it is a fact about that frame rather than a tensorial one and does not survive rotation. [curvature-invariants.md](findings/curvature-invariants.md)

- **Lemma L41 (direct). A $\lambda$-weighted identity, and the bound it gives.** With $g_\gamma=\lVert[\mathrm{ad}(v_\gamma),W]\rVert^2$ in an orthonormal eigenbasis, $\sum_\gamma g_\gamma=4(n-1)\lVert W\rVert^2$ on all of $\mathcal W_n$ and $\sum_\gamma\lambda_\gamma g_\gamma=-4P(W)$ on all of $\mathcal W_n$. **At unit norm** this gives $\theta\le\lvert\lambda_{\min}\rvert(4(n-1)-\Delta-G_0)/4$, equality exactly on $E_{\lambda_{\min}}\oplus\ker W$. *It saturates on the whole of L23's subalgebra family, so it is a different equality case from L70's rather than the same one in other coordinates.*

- **Lemma L55 (direct). The min-entry bound, sharp for even $n$.** For $n\ge3$ and $K$ hollow with zero row sums and $\lVert K\rVert_F^2=t$, $\lvert\min_{a\ne b}K_{ab}\rvert\ge\sqrt{t/(n(n-1)(n-2))}$; for $K$ also symmetric with $t>0$, equality holds exactly at the perfect matchings, $K_{ab}=(n-2)c$ on a fixed-point-free involution and $-c$ elsewhere with $c>0$, which exist exactly at even $n$.

- **Lemma L70 (direct). The deficiency identity, and what saturates it.** At every critical point and every unit $v\in E_{\min}(W)$, $\theta=\lambda_{\min}+(n-2)\lambda_{\max}-D(v)/\lvert\lambda_{\min}\rvert$ with $D(v)=\tfrac12\sum_{a,b}(\lambda_a\lambda_b-\lambda_{\min}\lambda_{\max})c_{vab}^2\ge0$, given $\lambda_{\min}<0\le\lambda_{\max}$. At $\lambda_{\max}>0$, which on $\mathcal W_n$ holds at every $W\ne0$ since $\mathop{\mathrm{tr}}W=0$, equality holds exactly when $\mathrm{ad}(v)$ is supported on $E_{\min}\otimes E_{\max}$ for every such $v$.
- **Lemma L111 (direct). Criticality in bracket coordinates, and the bracket form is strictly weaker.** $Q(W)=\theta W$ if and only if $M_{kl}=2\lambda_k(\lambda_k-\theta)\delta_{kl}$ in an eigenbasis, while the bracket form, vanishing across distinct eigenvalues only, is $[W,Q(W)]=0$ and is strictly weaker at every $n\ge4$.
- **Lemma L113 (direct). Moment inequalities in the $g$-distribution give nothing sharper than Lemma L107.** At unit norm, every conclusion drawn from inequalities valid for every nonnegative $g$ on the spectrum, with $m_0=4(n-1)$, $m_1=-4\theta$ and the free moments eliminated, follows from $\lambda_{\min}m_0\le m_1\le\lambda_{\max}m_0$, and Cauchy–Schwarz with the support bound attains it. Lemma L109's row cap lies outside the class.
- **Lemma L115 (direct). $\theta>\max_\alpha\lambda_\alpha$ at every global maximiser, and $\lambda_{\max}(M)=\theta$ on the coordinate-diagonal locus.** $\theta-\lambda_\alpha\ge\sqrt{3/2}-1$ from $\lVert\lambda\rVert=1$ and $M(n)\ge\sqrt{3/2}$. With $M$ formed in the coordinate frame, $\lambda_{\max}(M)=\theta$ at every coordinate-diagonal global maximiser and at every $S^m\times S^m$, $m\ge2$. At every global maximiser the equality is open, needing a cap off $\mathcal W_n$ and a fixed eigenbasis.

- **Lemma L71 (direct). Saturation forces the balanced sphere product, unconditionally for $n\ge5$.** A critical point of $\mathcal W_n$ at unit norm, $n\ge5$, saturating Lemma L70 has $\mathfrak{so}(n)=E_{\max}\oplus E_{\min}$ a symmetric pair with $\mathfrak h=[\mathfrak m,\mathfrak m]$ and $\mathfrak r=0$, **two eigenvalues derived rather than assumed** (the ideal argument consumes nothing downstream of it) and $\dim\mathfrak h=\tfrac{n(n-2)}4$, forcing the balanced split at every even $n$ at once. *No critical point saturates at odd $n\ge5$, since $\dim\mathfrak m=n^2/4$ is not an integer.* **Owed: the sentence identifying the resulting operator with the sphere product's Weyl tensor**, and the $O(8)\to SO(8)$ collapse the weight route does not supply.

- **Lemma L73 (direct). A spectral necessary condition on all of $\mathcal W_n$.** Every unit $W\in\mathcal W_n$ satisfies $\lambda_{\max}\le(n-2)\lvert\lambda_{\min}\rvert$ and its mirror, with no criticality hypothesis; $S^2\times S^{n-2}$ attains it at every $n$, and $\mathbb{CP}^m$ and the maximal tori at even $n$. It strengthens to $\lambda_{\max}\le-\tfrac{n-2}2(\lambda_{(1)}+\lambda_{(2)})$.

- **Lemma L74 (direct). $\theta$ in closed form for every strongly regular graph.** Every strongly regular graph $\Gamma=(v,k,\lambda,\mu)$ determines a unit diagonal critical point of $\mathcal W_v$, with $\theta/\lVert W\rVert=\frac{(v-1)^2\lambda+2k(v-1)-k^2v+w^2}{w^2}\sqrt{\frac{2w}{vk(v-1)}}$, $w=v-1-k$; the admissibility condition is the SRG identity itself. The only saturating members of Lemma L70 are $K_{m,m}$ and $2K_m$, the two sign branches of $S^m\times S^m$.

- **Lemma L59 (direct). The certificate's linear condition.** For $\mu_K$ into the $14$ invariant sextics with adjoint $\mathrm{Cat}$ and $\mathrm{ANN}=\ker\mathrm{Cat}$, $\mathrm{rank}(\mu_K)=14-\dim\mathrm{ANN}$ and $F_5\in\mathrm{image}(\mu_K)\iff F_5\perp\mathrm{ANN}$; a count decides the condition only when $\dim\mathrm{ANN}=0$. The $65$ invariant forms split as $36+29$. *The concrete $\mu$, the identification of $\mathrm{ANN}$ with $\{F:\mathrm{Cat}_F(K,K)=0\}$, and the reduction from a certificate are owed.*

- **Lemma L61 (direct). $M(5)=\sqrt{3/2}$, the global maximum on $\mathcal W_5$**, *the diagonal maximum $\Theta_5$ is $2\sqrt2/3$, and naming this one $\Theta_5$ is warning [W5](findings/INDEX-traps.md).* $F_5=\tfrac32\lVert W\rVert^6-9\mathop{\mathrm{tr}}(W^3)^2$ is a sum of squares of cubics vanishing on the $O(5)$-orbit of padded $W_{\mathbb{CP}^2}$, with exact rational coefficients. Hence $\lvert\theta\rvert\le\sqrt{3/2}$ on all of $\mathcal W_5$, critical or not, with equality on that orbit, the equality set is not identified, and no certificate of this shape can identify it.

- **Lemma L62 (direct). $\dim\mathrm{ANN}=1$, so the rank is $13$.** Order-one vanishing at $W_0$ caps the restricted catalecticant rank at $13$; a sampled rank is a lower bound and reduction modulo $p$ can only lower it, the points being exact rationals, so a sampled rank attaining $13$ forces equality. Hence $\mathrm{ANN}$ is spanned by $A(W_0^6)$ and $F_5\perp\mathrm{ANN}$.

- **Lemma L63 (direct), with an observation. The $n=12$ block table.** Lemma: $\dim\mathcal W_{12}=1638$ and $\dim\mathrm{Sym}^3\mathcal W_{12}=\binom{1640}3$. Observation, from a decomposition run: $\mathrm{Sym}^3(\mathcal W_{12})$ carries $77$ $SO(12)$ constituents with $191$ multiplicities, and orientation reversal fuses six chiral pairs so that $O(12)$ sees $71$ blocks and $184$ multiplicities.

- **Lemma L64 (direct). The transfer mechanism.** An $O(n_0)$-invariant form of degree $d$ on $\mathcal W_{n_0}$ has an $O(n)$-invariant extension to $\mathcal W_n$ at every $n\ge n_0$. When $n_0\ge k_B(d)$, the presentation degree of $\{\mathrm{Sym}^d\mathcal W_n^*\}$ over the signed permutation groups $\{B_n\}$, that extension is the unique $B_n$-invariant one. $k_B(d)\ge4d$, it is finite with no value on file, and the extension carries a sign only on the padded copy. With $SO$ in place of $O$, uniqueness holds as stated and existence holds when $n_0$ is odd or $n_0\ge4d$.

- **Lemma L65 (direct). The seed is the inclusion padded by cups.** For $n\ge1$ and an $O(n)$-admissible label $\lambda$ with $\lvert\lambda\rvert\in\{0,2,\dots,12\}$, with $k=(12-\lvert\lambda\rvert)/2$ and $\iota_\lambda\colon V_\lambda\hookrightarrow V^{\otimes\lvert\lambda\rvert}$ the inclusion, the seed $\iota_\lambda\otimes\mathrm{cup}^{\otimes k}$ is a nonzero $O(n)$-equivariant map $V_\lambda\to V^{\otimes12}$, so it is constructed rather than searched for. Admissibility holds whenever $\lvert\lambda\rvert\le n$.

- **Lemma L194 (direct). A rank-three Weyl tensor's three image forms have equal squares and equal self-wedges.** The distinct-and-collinear branch of the criticality criterion is empty at every $n$, because $\Phi(\omega)=(\omega^2,\omega\wedge\omega)$ sends the unit sphere of $\Lambda^2$ into a sphere and a line meets a sphere twice.

- **Lemma L195 (direct). A common square with two distinct eigenvalues forces two forms equal up to sign.** No dimension, no Weyl hypothesis, no orthogonality: the wedge's cross term is a rank-one tensor, which pins its factors up to reciprocal scalars.

- **Lemma L196 (direct). Two complex structures sharing a self-wedge agree up to sign above four dimensions.** Hard Lefschetz on a symplectic vector space makes $\Lambda^2\to\Lambda^4$ injective at $m\ge3$; at $m=2$ its kernel is five-dimensional, which is where the equality case lives.

- **Theorem (direct). Every Weyl tensor of $\Lambda^2$-rank at most three satisfies $\theta\le\sqrt{3/2}$, with equality exactly at padded $W_{\mathbb{CP}^2}$.** Ranks two and three are empty above four dimensions, rank one is impossible, and L178 caps a four-dimensional support.

- **Lemma L178 (direct). Rank at most three on a four-dimensional support caps $\theta$ at $\sqrt{3/2}$.** Rank $\le3$ forces (anti-)self-duality, each summand being trace-free on a three-dimensional space, and the bound is the reality of a cubic. Equality exactly at $W_{\mathbb{CP}^2}$, up to positive scale and an $O(n)$ frame.

- **Lemma L181 (direct). Ricci-flatness and first Bianchi are the diagonal and off-diagonal of one matrix.** Both are read off $M^{\mathsf T}\Lambda M$, so a Weyl tensor whose eigenforms are simultaneously block-diagonal for a common splitting into planes cannot exist.

- **Lemma L183 (direct). A rank-three Weyl tensor is a triple whose $\Phi$-images coincide or are distinct and collinear.** With $\Phi(\omega)=(\omega^2,\omega\wedge\omega)$, collinearity is joint in the direct sum. Bare collinearity is not enough: exactly-two-coincident is the configuration excluded.

- **Lemma L184 (direct). No orthonormal triple with a common six-dimensional support has both coincidences.** No Weyl hypothesis anywhere; the coincident case at $\dim V=6$ being empty is the corollary. Three separable cases, set by how many eigenvalues of the common square agree.

- **Lemma L185 (direct). No rank-three Weyl tensor has three decomposable image forms.** Ricci-flatness alone empties the branch at every width: the three planes are forced to coincide, and three orthonormal forms do not fit in a one-dimensional space.

- **Lemma L186 (direct). No rank-three Weyl tensor has exactly one non-decomposable image form.** First Bianchi collapses the case, and the statement is confirmed and vacuous: the configuration it excludes cannot arise for a second reason.

- **Lemma L189 (direct). A rank-three Weyl tensor has three non-decomposable image forms.** The two-non-decomposable case is empty at every dimension, so with L185 and L186 the image-form census closes and only the all-non-decomposable branch survives.

- **Lemma L190 (direct). The surviving rank-three case is inhabited at $\dim V=4$.** A five-parameter family of witnesses, with the Minkowski determinant inequality saturated there. The cross term is six-dimensional only and the determinant route dies at four on the Ricci leg.

- **Lemma L191 (direct). Two forms with a common six-dimensional support and both coincidences are equal up to sign.** A rigidity statement rather than an emptiness one, and it closes the rank-two branch at $\dim V=6$.

- **Lemma L192 (direct). The Bianchi defect is the weighted Laplacian of the Pfaffian, in every even dimension.** $L[\mathrm{Pf}(w)]=\tfrac1{(m-2)!}\star[\mathcal B\wedge w^{m-2}]$ at $\dim V=2m$, with $L=\sum\lambda_i\partial^2/\partial x_i^2$.

- **Lemma L199 (direct). The orbit-tangent form is $4(W^2\#I)-4W^\#$.** The symmetric operator whose diagonal in an eigenbasis is $g_k=\lVert[\mathrm{ad}(v_k),W]\rVert^2$, at every symmetric $W$ on $\Lambda^2\mathbb R^n$ and under no hypothesis at all. Through Lemma L131 its Bianchi term $12\,\mathrm{Alt}(W^2)$ is the exact deficit of the record's diagonal-locus form.

- **Lemma L201 (direct). Integrality of the pairwise plane traces forces a common frame.** An orthonormal basis of $\mathfrak{so}(n)$, $n\ge3$, by rank-two elements whose pairwise brackets are each zero or of unit norm is the standard basis of some orthonormal frame, up to signs.

- **Lemma L79 (landscape). The $\mathcal A$ eigenvalue theorem.** The map $\mathcal A(W)=\sum_{g,h}W_{gh}\,\mathrm{ad}(\varphi_g)\mathrm{ad}(\varphi_h)$ is linear and $O(m)$-equivariant, with eigenvalues $+2$, $-(m-4)$, $-2(m-2)$ and $-4$ on the four summands of $S^2(\Lambda^2)$.

- **Lemma L95 (landscape). $\kappa^2(\mathbb{CP}^m)=3/(m+1)$, in closed form.** The bispectral constant at complex projective space is $3/(m+1)$ exactly, with a closed-form derivation and agreement to $10^{-15}$ at $m=2,\dots,7$.

- **Lemma L105 (direct). Every two-eigenvalue critical point has $\theta\le\theta_0(n)$.** For a critical point whose spectrum takes exactly two values, $\theta$ is at most the minimum of two explicit expressions in them, and that minimum is at most $\theta_0(n)$, with the equality case identified.

- **Lemma L106 (landscape). The zero-defect set is exactly where every positive eigenvector is an infinitesimal symmetry.** $\Delta(W)=0$ if and only if $[\mathrm{ad}(x),W]=0$ for every $x\in\mathfrak p$, so the positive eigenvectors are infinitesimal symmetries and $\mathfrak p$ is a subalgebra acting on each eigenspace.

- **Lemma L109 (direct). The per-coordinate cap $g_\gamma\le2(n-2)(\lambda_{\max}-\lambda_{\min})^2$.** An unconditional cap on each coordinate of the bracket-mass vector, in the spectral spread alone. Saturation is a theorem rather than a measurement.

- **Lemma L120 (second-order). $L_M$ is block-diagonal over the sign characters at every diagonal critical point.** Against the full diagonal sign group, $\mathcal W_n$ splits into the diagonal part, $\binom n4$ two-dimensional blocks and $\binom n2$ pair blocks, and $L_M$ preserves every summand.

- **Lemma L123 (second-order). A zero-diagonal operator contributes nothing to a single-character Rayleigh quotient.** If $X$ lies in one sign-character space and $R$ has zero diagonal in the frame, then $\langle X,R\circ X\rangle=0$.

- **Lemma L161 (landscape). $\kappa_n=\tfrac{(n-1)(2n-1)}4$ at every $n\ge6$, both parities.** The spectral-moment constant in closed form at every dimension from six, odd and even alike, where the record previously had it at even $n$ only.

- **Lemma L163 (landscape). The kernel of $\Phi$ at $\mathbb{CP}^m$, and the padding formula as an equality.** $\ker\Phi_{W_{\mathbb{CP}^m}}=\mathbb R\,\mathrm{Id}$ at every $m\ge2$, and zero-padding adds exactly $\binom{k+1}2+k\dim K(W_0)$ to the kernel dimension.

- **Lemma L164 (direct). Padding preserves the norm and $\theta$.** A Weyl tensor supported on $\Lambda^2U$ restricts to a Weyl tensor on $U$ with the same norm, the same $P$ and the same $\theta$.

- **Lemma L166 (landscape). For the Kähler family, Ricci-flatness and first Bianchi are one linear condition.** On the two-parameter family built from $\mathfrak{su}(m)\subset\mathfrak{so}(2m)$, the two Weyl conditions coincide, so the family is cut by a single equation rather than two.

- **Lemma L170 (second-order). At every critical point with $\theta\ne0$ the $\tfrac12$-eigenspace is the Hessian kernel.** $E(\tfrac12)=\ker\mathrm{Hess}(P|_S)_W$, so Morse–Bott nondegeneracy is exactly $E(\tfrac12)=T_W\mathcal O$. Maximality is not a hypothesis.

- **Observation L83 (landscape). The $24$-block table of $\mathrm{Sym}^3(\mathcal W_5)$.** Twenty-four $O(5)$ blocks with their multiplicities, from a character computation. Every dimension follows from Weyl's formula and the Casimir at $B_2$'s own $\rho$, and $\sum m_\lambda d_\lambda=\binom{37}3=7770$ is the table's one external check.

- **Lemma L84 (landscape). Casimir separation is forced.** $C_2$ and any quartic central generator $C_4\notin\mathbb R[C_2]$ together separate every dominant $B_2$ weight, through the Harish-Chandra isomorphism onto $\mathbb R[p_2,p_4]$. On the $24$ labels of Observation L83, $C_2$ alone takes $21$ values.

- **Observation L85 (landscape). $\dim(\mathrm{Sym}^6\mathcal W_5)^{O(5)}=14$.** A Weyl-integration count run at $n=5$, only its degree-two neighbour argued.

- **Lemma L86 (landscape). The parity rule $\dim V_\lambda^H=1\iff\lambda_2$ even.** On $O(5)$-modules where $-I$ acts trivially, the invariants of the stabiliser $H$ of padded $W_{\mathbb{CP}^2}$ are one-dimensional exactly when the second highest-weight coordinate is even, granting the stabiliser, which bounds the certificate's unknown count from below by thirty-six.

- **Lemma L88 (landscape). The unknown count is real symmetric, and the $24$ antisymmetric invariants are gauge.** On Observation L83's multiplicities, with every block of real type, the invariant symmetric forms on $\mathrm{Sym}^3(\mathcal W_5)$ number $\sum\binom{m+1}2=65$ and the antisymmetric ones $\sum\binom m2=24$; the latter change no sextic.

- **Lemma L89 (landscape). $\mathop{\mathrm{rank}}(\mu|_{\mathrm{inv}})=\dim(\mathrm{Sym}^6\mathcal W_5)^{O(5)}$, by exactness.** Multiplication of cubics onto sextics is onto, and averaging over $O(5)$ carries that to invariants. On Observation L85's $14$ and L88's $65$ the rank is $14$ and the nullity $51$, with those Observations' standing.

- **Lemma L90 (landscape). Evaluation is injective on the image, given one measured rank.** For the map $\mu_K$ from invariant Grams on the orbit-vanishing cubics to sextics, $\mathrm{rank}(\mathrm{ev}\circ\mu_K)=\mathrm{rank}\,\mu_K$ makes evaluation at the sample points injective on the image; the cap $\mathrm{rank}\,\mu_K\le13$ is proved and the lower bound $13$ at the certificate's $40$ points is a modular rank.

- **Lemma L91 (landscape). The identity Gram on $K$ gives $\mathrm{rank}\,\mu_K\ge1$.** It maps to $\Delta=\sum q_a^2$, a psd invariant sum of squares of cubics vanishing on the orbit and nonzero because $K\ne0$. Given L90's measured rank it adds no bound.

#### Lifting, the diagonal proof carried off the diagonal locus

The obstruction identified exactly, the single inequality it forces, and that inequality's proven supports.

- **Observation L15 (lifting). The Bianchi defect of the spectral parts, priced exactly, and one obstruction of the two named.** The identity holds for every symmetric $R$ on $\Lambda^2\mathbb R^n$, with constant exactly $6$ and no cross-term, and prices the Bianchi failure at $+24\lVert\mathrm{Alt}(W_-)\rVert^2$, a factor of exactly three at Fox's $\mathcal S^4(\alpha)$, at every $n\ge4$. **The second obstruction, $X_{\mathrm{inv}}\succeq0$, is established nowhere**: only its trace and its equality locus are proven, and it is refuted off the diagonal locus. It is [Lemma L131](findings/isotropy-cap.md) contracted against $R$, the two determining each other.

- **Conjecture L16 (lifting). The defect-penalty inequality, stated against $\Theta_n$.** $P\le\Theta_n+\kappa_n\|\mathrm{Alt}(W_-)\|^2$ for $n\ge12$, **restated 2026-09-04, performing the repair its Gate 2 required**, since the earlier $\theta_0(n)$ form settled the conjecture at even $n$ only. *It settles the conjecture at even $n$ only*: the sphere-product maximum is $\Theta_n$, and at odd $n$ that is **strictly below** $\theta_0(n)$, $\Theta_{13}=1.2483756$ against $\theta_0(13)=1.2498521$, so the bound leaves a gap that shrinks and never closes. **Stating it against $\Theta_n$ repairs both parities at no cost, the crossover $\Theta_n>\sqrt{3/2}$ still falling exactly at $n\ge12$.** *Equality at the sphere product likewise fails at odd $n\ge13$, so "equality exactly" held only at even $n$;* equality at the $\mathbb{CP}^2$-type competitor stands, with the penalty's sign flipping exactly at $n=6+2\sqrt7$. Survived adversarial falsification at $n=12$ and $n=14$.

- **Lemma L17 (lifting). First-order protection at the rival maximizer.** Proven: at the $\mathbb{CP}^2$-type competitor, the penalized functional cannot increase to first order in any direction, for $n\ge12$, the sign of $\kappa_n$ being what the step needs, and below the crossover the same formula reverses sign, which is exactly the escape the numerics see there. *What is dimension-free is $d^+\delta^2\le0$; the $\Phi$ conclusion needs $\kappa_n\le0$, hence $n\ge12$ ([r475](reviews/REVIEW_r475.md), [r476](reviews/REVIEW_r476.md)).* **Criticality of the competitor is load-bearing and was stated nowhere until 2026-09-07**, and the equality set is a proper subspace, **measure zero among directions**, not the $89\%$ a dimension ratio suggests.

- **Lemma L18 (lifting). One unconditional pricing lemma, and a dichotomy resting on four grants.** **The pricing half is a Lemma**: $J_4\le24\delta^2\lambda_{\max}(\mathrm{Ric}(\lvert W\rvert))$, from a positive-semidefinite Gram form, pointwise and dimension-free, needing $\mathrm{Alt}(W)=0$ and **not** criticality, under the record's $\Lambda^2$ pairing, where plain Frobenius would read $16$. **The dichotomy half is an Observation on four grants**, of which the block named one: $J_5\ge0$ off $\{[H,W]=0\}$; an E-track certificate the ledger marks never audited, which produces the headline $c(12)$; the frame-free assembly of Jäger's Lemma 3.4.7, spot-checked numerically only; and his Lemma 3.5.6 below $n=16$. **Nothing about the dichotomy may be cited as a lemma.**

- **L19 (lifting), WITHDRAWN**, by two reviewers independently: the entry stated no checkable proposition, and its three bundled claims grade separately, the lift unlocatable and recorded as failing at padded $W_{\mathbb{CP}^2}$, the rigidity an `Observation` at $19$ orbits whose *"every sphere pair"* clause needs [L11](findings/nondegeneracy.md)'s $(3,3)$ exclusion, and the sharpening naming no quantity. **The open core is the missing isolation radius**, without which the localisation has no content. [problem.md](findings/problem.md)

#### Localization, splitting the sphere around the rival orbit

The one strategy that has produced an unconditional theorem about the whole sphere.

- **Lemma L20 (localization). No maximizer lies within $0.5748$ **geodesic angular** distance of the rival maximizer's orbit, for every $n\ge12$.** The chain from the expansion to $\max P\le\sqrt{3/2}$ is proved by bootstrap on the attained maximum and is **conditional on one input nothing on the record proves**, that $\tfrac13\theta^*$ is the largest eigenvalue of $F_u$ on $u^\perp\cap T_u\mathcal O^\perp$: inside the tube the exact cubic expansion forces $\max P\le\sqrt{3/2}$, contradicting the larger value $\Theta_n$ of $S^{\lfloor n/2\rfloor}\times S^{\lceil n/2\rceil}$, which is $\theta_0(n)$ at even $n$. The contradiction is with the value, not the location.

- **Lemma L21 (localization). The eigenvalue bound Lemma L20 rests on is structural at every $n\ge9$.** $W_{\mathbb{CP}^2}$ lives in $\Lambda^2(\mathbb{R}^4)$, so the construction is $SO(n-4)$-equivariant and Schur applies with **no multiplicity-free hypothesis**, needing absolute irreducibility instead. **The census is a theorem**: six types with multiplicities $20,20,6,10,4,1$, free of $m$, the last two annihilated by $F_u$ for a dimension-free reason. **The four remaining $F_\lambda$ having $m$-free entries is the one unproved input**, exact at a single in-range dimension.
- **Lemma L100 (localization). At $8\le n\le11$, either $\max P=\sqrt{3/2}$ or no maximizer lies within $0.5748$ geodesic angular distance of the rival maximizer's orbit.** Given Lemma L21's $\alpha\le\tfrac13$, at $n=8$ by zero-padding into $\mathcal W_9$. It is Lemma L20's argument stopped before the witness.
- **Lemma L101 (localization). The $SO(n)$-invariance identity at the rival, and $P\equiv0$ on its $\tfrac12$-eigenspace at $n\ge9$.** For eigenvectors $x,y$ of $F_u$ with labels $\lambda,\mu$, $T(x,y,[\rho(A),u])=(\lambda-\mu)\theta^*\langle A\cdot x,y\rangle$ at every $n$ and with no criticality, so $Q(x)\perp T_u(SO(n).u)$. With criticality of $u$ and Lemma L21, $V_{1/2}=T_u(SO(n).u)$ at $n\ge9$ and $P\equiv0$ there.

- **Observation L22 (localization). The localization theorem's missing estimate, at $n=12,14,16$.** *The label is literal: the load-bearing vanishing $M_{W_1}\Pi_{\ker}Q(W_1)=0$ is measured at those three dimensions and not proven, and $n=20,24$ were reached by zero-padding, which re-reports the datum padded from.* **Both branches take $\sup\{P(K):K\in\ker F_u,\lVert K\rVert=1\}\le\theta_0(n)$ as their constant**, a proper-subspace bound at one critical point that is weaker than Conjecture A and carries its inequality half; *and the conjecture enters twice more in the surrounding thesis argument, at §4.5 and at Theorem 4.19's second case, so discharging this dependence alone frees nothing.* **The overlap of the two branches is unchecked**: neither coverage endpoint has a closed form on the record. **Nothing on the record consumes this block**, so what it owes propagates nowhere. Nienhaus states the estimate and records that he could not supply it.

#### Second-order, constraining the maximizer beyond criticality

What the extremal-idempotent calculus and the two spectra can and cannot see.

- **Lemma L24 (second-order). Second-order optimality bounds the multiplication operator.** A **local** maximiser with $\theta\ne0$ has $\lambda_{\max}(L_e|_{W^\perp})\le\tfrac12$, with $\tfrac12$ attained by orbit directions at every critical point where $e$ is defined. This is Krasnov–Tkachev's Proposition 6.6, derived here independently before the literature was found; the credit is theirs.

- **Lemma L50 (second-order). The potential is a function of two spectra.** With $\mu$ the $\Lambda^2$ spectrum and $\omega$ that of the second-kind operator on $S^2_0$, $\theta=\tfrac32p_3(\mu)-\tfrac12p_3(\omega)$ on $\mathrm{Weyl}_n$. The identity is Dai–Fu's Lemma 3.3 at $s=0$, and the reading is new. **It collapses to one spectrum for $n\le5$ as an identity of trilinear forms, and fails at every $n\ge6$.** Pointwise the collapse is not a characterisation, padded $W_{\mathbb{CP}^2}$ collapsing at every $n$. Both links are proved in [bispectral.md](findings/bispectral.md) and kernel-checked: $\beta=2\langle M^\#,M\rangle$, which the coefficient pair is, and the generalised-Kronecker display, derived from the $720$-term expansion. The failure at $n\ge6$ is the padded $S^3\times S^3$ weight, with $\beta-\tfrac\alpha2=1260$.

- **Lemma L51 (second-order). The variation calculus is an identity along a critical orbit.** At any critical point, differentiating equivariance twice gives $B(X^2\!\cdot\!W)=(X\!\cdot\!W)\circ(X\!\cdot\!W)$. This forces the third-order condition, the fusion rule and the fourth-order inequality to hold with equality on the orbit tangent, with no maximality hypothesis. Any variational route must consume transverse directions.

- **Lemma L52 (second-order). The shared-frame coupling is sharp on the diagonal family and can be weak away from it.** Both operators carry the same sectional curvatures on their diagonals, so **Schur's theorem** plus support bounds couples $\mu$ and $\omega$; the resulting bound is an *identity* wherever both are diagonal in one shared frame (so the coupling is sharp rather than useless), and since the one-line $\tfrac32(M_++m)$ is strict and both bounds are continuous, it beats the one-line bound on a neighbourhood of that family. Away from the family it can be weak: at padded $W_{\mathbb{CP}^2}$ it gives $3.9804$ against the one-line $2.4495$.

- **Observation L53 (second-order). The champion split.** Ascent in the direction $(a,b)$ maximising $a\,p_3(\mu)+b\,p_3(\omega)$ over $\mathcal W_n$ lands, at $n=6,8,10$: on the balanced sphere product for $(0,-1)$, and at $n=12$; on $W_{\mathbb{CP}^2}$ at $\sqrt{3/2}$ for $(\tfrac32,-\tfrac12)$, which is $\theta$; on $\theta_0(6)$ and $\mathbb{CP}^4$'s $0.986013$ for $(1,0)$.

- **Lemma L54 (second-order). The two diagonals, and rigidity at $t=2$.** In a frame $F$, with the $\varphi$-vectors of Nienhaus–Petersen–Wink and $\psi_k$ an eigenbasis of $K$ on $\mathbf1^\perp$, the $\varphi$-diagonal of $\mathring W$ and of $M$ is $K$ and the $\psi$-block of $\mathring W$ (Li's convention) is $-K$ on $\mathbf1^\perp$, and Schur's theorem gives $\mu\succ d_\varphi$ and $\omega\succ d$; $t_F\le2$ with equality exactly when $W$ is coordinate-diagonal **in $F$**, and there both majorizations are equalities.

- **Lemma L94 (second-order). The vertex-matrix budget.** $\kappa^2=\max_F\lVert K(F)\rVert_F^2$ over orthonormal frames is attained, $\kappa^2\le2\lVert M\rVert_F^2$, and equality holds exactly when $W$ is coordinate-diagonal in some frame.

- **Lemma L66 (second-order). No maximizer is $\circ$-decomposable.** Call $W=\sum_{i=1}^ka_iA_i$ $\circ$-decomposable if $k\ge2$, each $A_i$ a unit Weyl tensor, $\sum a_i^2=1$, every $a_i\ne0$ and $A_i\circ A_j=0$ for $i\ne j$. Then for $n\ge4$ no maximizer of $P$ on the unit sphere of $\mathcal W_n$ is $\circ$-decomposable. **No criticality of the pieces is needed**, which is what makes the statement reach non-critical splittings and ones sharing coordinates. At a critical point split into two critical pieces with $A\circ B=0$, the harmonic-square law $\frac1{\theta^2}=\frac1{\theta_A^2}+\frac1{\theta_B^2}$ ([nondegeneracy.md](findings/nondegeneracy.md)) gives the sharper $\lvert\theta\rvert<\min(\lvert\theta_A\rvert,\lvert\theta_B\rvert)$. **That bound needs the criticality this lemma disclaims**: without it, as one coefficient tends to $1$, $P(W)$ tends to that piece's own value.

- **Lemma L67 (second-order). The second-kind spectrum of the balanced product.** At $S^m\times S^m$, $n=2m$, $m\ge2$, normalised to $\lVert W\rVert_F=1$ as an operator on $\Lambda^2$, the second-kind operator $\mathring W$ in Li's $iklj$ order has exactly three eigenvalues: $mA$ with multiplicity $(m-1)(m+2)$, $-(m-1)A$ with multiplicity $m^2$, and $-2m(m-1)A$ with multiplicity $1$, where $A=1/\big(m\sqrt{(m-1)(2m-1)}\big)$. Li's Theorem 1.8 gives the same spectrum as a product rule.

- **Lemma L133 (second-order). The balanced orbit's stability threshold, in closed form.** For $n=2m\ge12$, the supremum of $\tfrac12\mathrm{Hess}(P|_S)_{W^*}[H,H]\big/\lVert D(\mathrm{Alt}\,W_-)_{W^*}[H]\rVert^2$ over directions with nonzero denominator is $\kappa_n^{\mathrm{Hess}}=\tfrac{27}2\theta_0(n)\big(\tfrac2{n-2}-\tfrac12\big)$, attained on [Lemma L26](findings/nondegeneracy.md)'s direction in every $(2,2)$-split four-subset, and $\kappa_n^{\mathrm{Hess}}\le\kappa_n$ strictly, by a factor of $49.3$ at $n=12$ decreasing to $5.598$. **So [Conjecture L16](findings/problem.md) is not refuted at its own conjectured maximiser.**

- **Lemma L140 (second-order). The defect's first-order response is a $\tfrac12$-contraction.** For every unit $H\in\mathcal W_n$ and every base point, $\lVert\mathrm{Alt}(\mathcal D[H]+D_-)\rVert^2\le\tfrac14$, because $\mathrm{Alt}$ annihilates Weyl tensors (so the first-order coefficient may be recentred by any multiple of $H$) and the divided-difference multiplier of $x\mapsto x_-$ has range of length one. **The constant is convention-free**, both signs giving a range of length one.

- **Lemma L206 (bounds). The trace-form bound on $\theta$, attained, and loosest where the conjecture is an equality.** At every critical point with $\theta\ne0$, writing $e=W/\theta$, $p=\dim E_1(L_e)$, $m=\dim E_{1/2}(L_e)$, $k=\dim\mathcal W_n-p-m$ and $\kappa(n)=(2n-1)(n-1)/4$, the algebra's two trace identities give $\theta^2\le\kappa(n)\big/\big[p+\tfrac m4+\tfrac{(2p+m)^2}{4k}\big]$. It is attained at $S^2\times S^2$ in dimension four, where $p=2$ and the value is $\theta_0(4)^2=\tfrac34$ exactly. It is increasing in $m$, so at zero excess it exceeds $\sqrt{3/2}$ at every $n\ge5$, and at padded $W_{\mathbb{CP}^2}$, which attains $\sqrt{3/2}$ with excess zero, it is loose by $2.09\times$ at $n=12$ with the looseness growing in $n$.

- **Lemma L207 (nondegeneracy). The complete $L_e$ spectrum at a two-factor sphere product, and the excess at every split.** At $S^p\times S^q$ with $p,q\ge2$ and $e=W/\theta=-M/(n-1)$, the multiplicity of the eigenvalue $\tfrac12$ is $pq+\binom p2\binom q2\big[\mu=\tfrac12\big]$ with $\mu=\tfrac{n-2}{2(p-1)(q-1)}$, and $\mu=\tfrac12$ exactly when $(p-2)(q-2)=1$, which is $p=q=3$ alone. The orbit dimension is $\binom n2-\binom p2-\binom q2=pq$, so the excess is zero at every split except $S^3\times S^3$, where it is $9$. The mechanism is that each cross-pair block carries $\tfrac12$ exactly once and the orbit direction is that eigenvector, so the orbit inclusion is an equality rather than $\tfrac12$ being unreachable.

- **Lemma L209 (curvature-invariants). The Fox square preserves the Weyl module, in this record's own normalisation.** For every linear, bivector-preserving, self-adjoint $R$ satisfying first Bianchi, $Q(R)=R^2+R^\#$ satisfies the same three conditions and $\mathop{\mathrm{Ric}}(Q(R))_{ab}=\sum_{c,d}R_{ac,bd}\mathop{\mathrm{Ric}}(R)_{cd}$, with no Ricci hypothesis used. So $Q(\mathcal W_n)\subseteq\mathcal W_n$ and $X,Y\in\mathcal W_n\Rightarrow X\circ Y\in\mathcal W_n$, the closure the whole $L_e$ apparatus rests on. Derived from the record's structure-constant $\#$ through Hamilton's $B_{ijkl}=\sum_{pq}R_{ip,kq}R_{jp,lq}$, neither half of $Q$ preserving either condition alone. Corroborates [BW08](references/boehm-wilking-2008-space-forms/notes.md) eq. (6) and the $n=4$ closure of [r896](reviews/REVIEW_r896.md). **Gate 2 passed**, [r914](reviews/REVIEW_r914.md) and [r915](reviews/REVIEW_r915.md) on identical briefs, agreeing on eleven items.

- **Lemma L210 (problem). The de Rham reduction, done at the algebra so it costs no topology.** For every locally symmetric space with $\mathop{\mathrm{Ric}}=\lambda g$ and $\lambda\ne0$, the curvature tensor is block-diagonal over a decomposition into irreducible factors with the mixed blocks exactly zero, there is no Euclidean factor, and every factor inherits the same $\lambda$. So [L47](findings/problem.md)'s irreducible case and [L48](findings/problem.md)'s product case together cover every compact Einstein symmetric space, the step by which the symmetric-space theorem reaches products at all. Derived from Gorodski's Propositions 3.1.2 and 2.1.3, neither of which carries a topological hypothesis, so the splitting is available before covers or compactness are settled. **The passage to L47 and L48 needs more than this lemma gives**: $\lambda>0$ rather than $\lambda\ne0$, since Gorodski's irreducible includes the noncompact type while L47's census is of compact type, and compactness together with global symmetry is what supplies it. **Gate 2 passed with that corollary corrected** ([r918](reviews/REVIEW_r918.md), [r919](reviews/REVIEW_r919.md)).

- **Lemma L211 (problem). A compact Einstein symmetric space has $\lambda>0$, and that is where compactness and global symmetry do their work.** For a compact globally symmetric $M$ with $\mathop{\mathrm{Ric}}=\lambda g$ and $W\ne0$, $\lambda>0$ and every irreducible factor is of compact type. The type of a factor is the sign of its curvature, so one global Einstein constant fixes one type; if that type were noncompact the transvection group would be noncompact while fibring over a compact base with compact fibre, which is impossible. **Compactness and global symmetry are spent at that one step and nowhere else**, which is why [L210](findings/problem.md) is stated for locally symmetric spaces. With L210 it closes the quantifier of the symmetric-space Theorem **under the GLOBAL reading only**, which is why that Theorem now says *globally* symmetric: a compact quotient of $\mathbb{CH}^6$ sits in the difference at $n=12$ with $W\ne0$. **Gate 2 passed with four repairs** ([r920](reviews/REVIEW_r920.md), [r921](reviews/REVIEW_r921.md)), among them that its own tightness witness was false.

- **Lemma L216 (second-order). An explicit isolation radius at every quantitatively nondegenerate critical orbit.** If $L_e\le\tfrac12-\gamma$ on unit normals to $W_0$ and its orbit, no critical point lies within $4\theta_0\gamma/(9(1+\sqrt{n-2}))$ of the orbit except the orbit itself. **At the balanced product $r_n=4\theta_0/(9(n-2)(1+\sqrt{n-2}))$, a sufficient radius of order $n^{-3/2}$**, the first explicit isolation radius on the record. *It closes the radius half of the localisation route, not the route.* **Gate 2 landed, CONFIRMED** ([r931](reviews/REVIEW_r931.md), [r932](reviews/REVIEW_r932.md)).
- **Lemma L217 (second-order). The value bootstrap at a gapped critical orbit.** At a unit critical orbit of value $\theta_u>0$ with transverse gap $\gamma$, a global maximiser within geodesic angle $\arcsin\min(3\gamma,\tfrac12)$ has value exactly $\theta_u$, so the orbit is itself maximal. At the balanced orbit, $\gamma=1/(n-2)$ and $\theta_0(n)\le\sup P$, so a global maximiser within $\arcsin\frac3{n-2}$ forces $\sup P=\theta_0(n)$; at every sub-maximal gapped sphere product the angle is an exclusion tube. The proof is [Lemma L20](findings/route-a.md)'s bootstrap with the maximiser's own value bounding the cubic remainder. *Gate 2 passed ([r933](reviews/REVIEW_r933.md), [r934](reviews/REVIEW_r934.md)).* **Proof:** [second-order.md](findings/second-order.md)
- **Lemma L218 (second-order). The off-diagonal coupling at a diagonal point is exactly $\sqrt3/2$.** For $n\ge4$, $\sup\{\langle L_DN,N\rangle:D\in\mathcal D_n,\ N\in\mathcal D_n^\perp\cap\mathcal W_n\text{ unit}\}=\tfrac{\sqrt3}2$, attained on a four-set block at padded $S^2\times S^2$ and on a pair block at $K=G_x/\sqrt3$, and $\tfrac{\sqrt3}2<\Theta_n$ at every $n\ge5$ of either parity. So Banach's form of the maximum, $\sup P=\sup T(x,y,z)$, refutes nothing through this coupling. *Gate 2 passed ([r935](reviews/REVIEW_r935.md), [r936](reviews/REVIEW_r936.md)).* **Proof:** [second-order.md](findings/second-order.md)
- **Lemma L219 (second-order). The reflection split.** For a unit $u$, the reflection $\sigma_u$ and $W=b+c$ split into $\sigma_u$-even and odd parts, $P(W)=P(b)+3\langle L_bc,c\rangle$ and $P(c)=0$. At a critical point $Q(W)=\theta W$, $2\,b\circ c=\theta c$, $\langle L_bc,c\rangle=\tfrac\theta2\lVert c\rVert^2$ and $P(b)=\theta(\lVert b\rVert^2-\tfrac12\lVert c\rVert^2)$. $W$ is coordinate-diagonal in a frame exactly when the odd part at each of $n-1$ frame vectors vanishes, and at a global maximiser $\lVert c_u\rVert^2\le\tfrac34$ for every unit $u$. *Gate 2 passed ([r937](reviews/REVIEW_r937.md), [r938](reviews/REVIEW_r938.md)).* **Proof:** [second-order.md](findings/second-order.md)
- **Lemma L220 (second-order). The diagonal theorem on a four-set subalgebra.** For $n\ge5$ and a four-set $Q$, every unit critical point of $P$ in $\mathcal D_n\oplus V_Q$ with nonzero $V_Q$ component and $\theta>0$ has $\theta\le\sqrt{3/2}$, with equality exactly at padded $W_{\mathbb{CP}^2}$. So at $n\ge12$, $\sup P=\Theta_n$ on $\mathcal D_n\oplus V_Q$, attained only on the diagonal. **Corollary**: inequality (J), $P(d)<3e(d)-4e(d)^3/\Theta_n^2$ at every unit diagonal $d$ with $e(d)>\Theta_n/2$. *Gate 2 passed ([r939](reviews/REVIEW_r939.md), [r940](reviews/REVIEW_r940.md)).* **Proof:** [second-order.md](findings/second-order.md)
- **Lemma L221 (second-order). L220 on several four-set blocks.** (a) For pairwise disjoint four-sets, every unit critical point of $P$ in $\mathcal D_n\oplus\bigoplus_iV_{Q_i}$ with a nonzero block component has $\theta\le\sqrt{3/2}$. (b) For two four-sets sharing two indices, every unit critical point in $\mathcal D_n\oplus V_{Q_1}\oplus V_{Q_2}\oplus V_{Q_1\triangle Q_2}$ with at least two nonzero components and $\tau=\langle\nu_1\circ\nu_2,\nu_3\rangle\le0$ has $\theta^2\le\tfrac65$. *Gate 2 passed ([r941](reviews/REVIEW_r941.md), [r942](reviews/REVIEW_r942.md)).* **Proof:** [second-order.md](findings/second-order.md)
- **Lemma L222 (second-order). The pair-block calculus.** On $\mathcal D_n\oplus V_{jk}$, $\nu\circ\nu=G_x$ with $\lVert\nu\circ\nu\rVert=\tfrac{\sqrt3}2\lVert\nu\rVert^2$; at a unit critical point with $\nu\ne0$, $\langle D,G_x/\lVert G_x\rVert\rangle=\theta/\sqrt3$ and $2L_{D^+}D^-=\theta D^-$ under the $(j,k)$-swap; $L_{G_x}$ acts on the swap-odd part as $y\mapsto\tfrac12\lVert x\rVert^2y+x\langle x,y\rangle$; at an angle of the $(j,k)$-rotation minimising $\lVert\nu\rVert^2$, $\langle x,K_{j\cdot}-K_{k\cdot}\rangle=0$ and $\lVert\nu\rVert^2\le\tfrac12\sum_a(K_{ka}-K_{ja})^2$; and at a diagonal critical point $\theta\langle D,G_x\rangle=\langle L_{G_x}D,D\rangle$, all at $n\ge4$. *Gate 2 passed, [r943](reviews/REVIEW_r943.md) and [r944](reviews/REVIEW_r944.md).* **Proof:** [second-order.md](findings/second-order.md)
- **Lemma L223 (problem). The stability of L57.** For unit $S\in\mathcal D_n$, $n\ge4$, with $S\circ S=\lambda S+E$, $E\in\mathcal D_n$, $\lambda>\lvert E\rvert$: with $\bar\Theta=\sqrt{2(n-1)(n-2)}/n$, $\Delta=\bar\Theta-\lambda+e_-/\mu\ge0$ bounds L57's three defects, and when $4\sqrt{n-2}\sqrt{\Delta/\bar\Theta}<2(1-\Delta/\bar\Theta)$, $S$ is within $\big(\sqrt2+4\sqrt{n-2}/(1-\Delta/\bar\Theta)\big)\sqrt{\Delta/\bar\Theta}$ of the unit vertex matrix of some $S^p\times S^q$, $p,q\ge2$, with $w_i=+1/\sqrt n$ at $v_i=0$. *Gate 2 passed, [r945](reviews/REVIEW_r945.md) and [r946](reviews/REVIEW_r946.md).* **Proof:** [problem.md](findings/problem.md)
- **Lemma L224 (second-order). The pair-block supremum.** For $n\ge4$ and $j\ne k$, every unit $W\in\mathcal D_n\oplus V_{jk}$ has $P(W)\le\Theta_n$, with equality exactly at $e^{\varphi\xi}\cdot B$ for an L57 maximiser $B$ and a rotation of the $(j,k)$-plane. So a global maximiser of $P$ lying in some $\mathcal D_n\oplus V_{jk}$ is a sphere product in another frame, and at $4\le n\le11$ none lies there. *Gate 2 passed, [r945](reviews/REVIEW_r945.md) and [r946](reviews/REVIEW_r946.md).* **Proof:** [second-order.md](findings/second-order.md)
- **Lemma L225 (second-order). The per-block cubic.** For $k\ge2$ and trace-free symmetric $k\times k$ $M^0$, $\mathop{\mathrm{tr}}\big((M^0)^3\big)\le\frac{k-2}{\sqrt{k(k-1)}}\lvert M^0\rvert^3$, with equality exactly at $M^0=0$ and at a simple positive eigenvalue beside a negative one of multiplicity $k-1$. Case–Tyrrell's bound and the sample-skewness bound, reached by a tangent cubic. *Gate 2 passed, [r947](reviews/REVIEW_r947.md).* **Proof:** [second-order.md](findings/second-order.md)
- **Lemma L226 (second-order). $P$ on the block subalgebra.** On $\mathcal S_J$ every coupling carries coefficient $3$: $P=P(R_J)+\sum_a\big(\mathop{\mathrm{tr}}M_a^3+3\mathop{\mathrm{tr}}(R_J\Lambda^2M_a)\big)+\sum_{a<b}\big(K_{ab}^3+3K_{ab}\mathop{\mathrm{tr}}(M_aM_b)\big)+3\sum K_{ab}K_{ac}K_{bc}$, and at $\lvert J\rvert=3$ Ricci-flatness fixes $R_J=N-\tfrac12(\mathop{\mathrm{tr}}N)I$. *Gate 2 passed, [r948](reviews/REVIEW_r948.md) and [r949](reviews/REVIEW_r949.md).* **Proof:** [second-order.md](findings/second-order.md)
- **Lemma L227 (second-order). The three-index block step at $n=5$.** On $\mathcal S_J\cap\mathcal W_5$ with $\lvert J\rvert=3$, $\sup P=\Theta_5$, attained at commuting blocks, since $U=X_1+X_2$ and $V=X_1-X_2$ leave one frame pairing $\mathop{\mathrm{tr}}(UV^2)$ against a frame-free norm. A model case outside $n\ge12$. *Gate 2 passed, [r950](reviews/REVIEW_r950.md) and [r951](reviews/REVIEW_r951.md).* **Proof:** [second-order.md](findings/second-order.md)
- **Lemma L228 (second-order). The three-index block step on two strata.** At every $n\ge4$, $P\le\Theta_n\lVert W\rVert^3$ on $\mathcal S_J\cap\mathcal W_n$, $\lvert J\rvert=3$, whenever all outer blocks but one share an eigenframe, or all but two do and those two blocks' sum joins it. Contains L227. *Gate 2 passed, [r952](reviews/REVIEW_r952.md) and [r953](reviews/REVIEW_r953.md).* **Proof:** [second-order.md](findings/second-order.md)
- **Lemma L229 (second-order). The common-eigenvector stratum of the two-block step.** For $\sup\big(\tfrac{15}4\mathop{\mathrm{tr}}\hat U^3+\tfrac94\mathop{\mathrm{tr}}(\hat UV^2)+\langle\hat U,A\rangle+\langle V,C\rangle\big)$ at fixed $\tfrac32\lvert\hat U\rvert^2+\tfrac12\lvert V\rvert^2$, with $A,C$ diagonal in a frame $F$, the supremum over the stratum where $\hat U$ and $V$ share an eigenvector of $F$ is attained with both diagonal in $F$. The phase maximum is a cap affine in the squared amplitudes less one squared distance in the plane, and that distance vanishes exactly where a diagonal pair attains the cap. *Its identification with freeing two outer blocks of $\mathcal S_J\cap\mathcal W_n$ at $\lvert J\rvert=3$ is a separate step, given rather than proved here.* *Gate 2 passed, [r955](reviews/REVIEW_r955.md) and [r956](reviews/REVIEW_r956.md).* **Proof:** [second-order.md](findings/second-order.md)
- **Lemma L215 (second-order). An explicit bound on the quadratic map.** $\lVert X^{\#}\rVert\le(n-2)\lVert X\rVert^2$ and $\lVert Q(X)\rVert\le(n-1)\lVert X\rVert^2$ at every $X$ in $\mathrm{Sym}^2(\Lambda^2)$, from [L153](findings/bounds.md)'s invariant polarised. **It is the upper bound on $\kappa$ that [I96](plan.md) owed.** *The isolation radius the first version drew from it is WITHDRAWN, refuted in a fixed frame by a gauge-rotated balanced product and vacuous where stated* ([r929](reviews/REVIEW_r929.md), [r930](reviews/REVIEW_r930.md)). **Gate 2 landed, the bound CONFIRMED.**
- **Lemma L214 (second-order). The frame split: two exact relations in every frame, and one inequality under the second-order cap.** For a unit critical point split in ANY orthonormal frame as $W=D+N$ with $t=\lVert D\rVert^2$ and $a=\langle L_DN,N\rangle$: $\theta t=P(D)+a$, $\theta(1-t)=2a+P(N)$, and under [L24](findings/second-order.md)'s cap $a\ge\tfrac\theta2t(1-t)$. **The foundation of [R24](routes.md), the primary route**, and the first statement constraining a critical point through an arbitrary frame rather than its eigenframe. *Its whole structural input is one scalar from [L120](findings/second-order.md).* **Gate 2 landed, CONFIRMED, with the decoupled bound it first suggested refuted as [post F67](findings/fence-posts.md)** ([r926](reviews/REVIEW_r926.md), [r927](reviews/REVIEW_r927.md)).
- **Lemma L213 (problem). Each irreducible factor is itself compact.** For a compact globally symmetric $M$ with $\mathop{\mathrm{Ric}}=\lambda g$ and $W\ne0$, every de Rham factor of the universal cover is a compact simply connected irreducible symmetric space of compact type, and $\theta(M)=\theta(\widetilde M)$, so [L47](findings/problem.md)'s census of compact spaces applies to each factor by name where [L211](findings/problem.md) gives compact type. **It is the type rather than $M$'s own compactness that carries it**, a compact quotient of $\mathbb{CH}^m\times\mathbb{CH}^m$ being compact with noncompact factors. *[Ziller](references/ziller-2010-lie-groups-symmetric-spaces/notes.md)'s Proposition 6.38(c) is cited for the conclusion, its hypotheses supplied by Myers--Steenrod, rebuilding it through $\mathrm{Inn}(\mathfrak g_i)$ needing Weyl's finiteness of the centre.* **Gate 2 landed, CONFIRMED with four repairs** ([r924](reviews/REVIEW_r924.md), [r925](reviews/REVIEW_r925.md)).
- **Lemma L212 (graded-half). The multi-block vertex solution is critical at every partition, and its second moment is the norm identity.** $Q(W)=\theta_gW$ at every partition with each $n_a\ge2$, and $t=8R\theta_g^2$ identically, so at unit norm $\theta^2=1/(4R)$ and $\theta<\sqrt{2/(k-1)}$ strictly. **Criticality is what lets [L05](findings/graded-half.md)'s chain stop consuming [L46](findings/problem.md)**, a lemma stated for irreducible spaces while its objects are products, and the general-$k$ identity retires the norm identity's debt above $k=4$. *The $\lambda=\tfrac12$ normalisation stays, $\theta_g$ being the Einstein constant, and the value is [ungraded-slack.md](findings/ungraded-slack.md)'s closed form by a second route* ([r922](reviews/REVIEW_r922.md), [r923](reviews/REVIEW_r923.md)).

## The results in detail

Same order and numbering as the glance. Each entry states the result with its hypotheses and ends with the findings file that carries the canonical block and the argument.

#### Foundation, the problem, its threshold, and the diagonal case

##### Lemma L57, the diagonal case at every $n\ge4$, both parities, with its equality case

Let $W\in\mathcal W_n$, $n\ge4$, be diagonal in some orthonormal frame, so $W$ is the hollow symmetric zero-row-sum matrix $M$ of sectional curvatures with $\lVert M\rVert$ normalised to $\lVert W\rVert=1$. Then $\langle W,Q(W)\rangle\le\Theta_n$ with $\Theta_n^2=\frac{2(n-1)(n-2)}{n^2}$ for even $n$ and $\Theta_n^2=\frac{2(n-1)(n-3)}{(n+1)(n-2)}$ for odd $n$, and equality holds exactly at the Weyl tensor of $S^{\lfloor n/2\rfloor}\times S^{\lceil n/2\rceil}$. The argument has three steps: a Dirichlet–Cauchy–Schwarz inequality $\lambda\le(n-1)\mu/n$ relating the top eigenvalue of $M$ to its row structure; the projection of $v\otimes v$ onto the Ricci-flat slice, $Z(v)_{ij}=v_iv_j+\frac{v_i^2+v_j^2}{n-2}-\frac1{(n-1)(n-2)}$, whose kernel is explicit; and a fourth-moment lemma, proved once in full with a second route sketched. Every step holds at both parities, so the odd case rests on this theorem and on nothing published, as do $n=12$ and $n=14$, the published diagonal case covering even $n\ge16$ alone. It does not reach any $W$ that is diagonal in no frame; that is the non-diagonal half.

**Proof:** [problem.md](findings/problem.md)

##### Lemma L231, $P$ on the diagonal locus is the weighted-graph functional

Let $w$ be a weight of $\mathcal D_n$, that is a symmetric hollow matrix with zero row sums, and let $\mathrm{diag}\,w$ be the operator on $\Lambda^2$ acting by $w_{ab}$ on $\varphi_{ab}$. Then $P(\mathrm{diag}\,w)=\tfrac12\big(\sum_{a,b}w_{ab}^3+\mathop{\mathrm{tr}}w^3\big)$, at every $n$ and with no further hypothesis. The two terms are proved separately: $\mathop{\mathrm{tr}}W^3=\tfrac12\langle w^{\circ2},w\rangle$ needs hollowness alone and holds at every $w$ symmetric or not, and $\langle W,W^\#\rangle=\tfrac12\langle w^2,w\rangle$ needs symmetry as well. The evaluation underneath is $\langle(\mathrm{diag}\,w)^\#\varphi_{ab},\varphi_{ab}\rangle=\sum_{d\notin\{a,b\}}w_{ad}w_{bd}$, which holds at every symmetric $w$ with no hollowness and no row-sum hypothesis.

**What it does not reach.** It says nothing about $W$ diagonal in some *other* frame: the statement is about the coordinate-diagonal locus, and the $O(n)$-invariance carrying one to the other is not part of it. $\mathcal D_n$'s row-sum clause is never used, so the identity holds on a strictly wider class than the locus.

*Machine-checked, `diagCubicFormula` in [SharpDiag.lean](lean/HamiltonsCubic/Base/SharpDiag.lean), standard three axioms and no `sorry`. The record described this as the same statement as [L57](findings/problem.md)'s $\mathop{\mathrm{tr}}W^3$ bridge. It is the SUM of that bridge's two identities rather than their conjunction, so it follows from the bridge and does not imply it, and what discharges L57 is the two conjuncts being proved separately.*

**Proof:** [diagonal-half.md](findings/diagonal-half.md)

##### Lemma L232, $\theta=\theta_{p,q}$ at every unit-norm sphere product

Let $S$ partition the $n$ indices with $p=\lvert S\rvert\ge2$ and $q=n-p\ge2$, let $w_{p,q}$ be the two-block weight with entries $q/(p-1)$ inside $S$, $p/(q-1)$ outside it and $-1$ across, and let $t>0$ scale it to unit norm. Then $\theta(\mathrm{diag}(t\,w_{p,q}))=\theta_{p,q}=\sqrt{2(n-1)(p-1)(q-1)/((n-2)pq)}$.

**What it does not reach.** It gives the value at each split and not the maximum over splits, so $\sup\ge\Theta_n$ still needs the arithmetic choosing the balanced one. That is arithmetic on $\theta_{p,q}$ and involves no curvature operator.

*Machine-checked, `sphereProductValue` and `theta_sphereProduct_value` in [SphereValue.lean](lean/HamiltonsCubic/Base/SphereValue.lean), standard three axioms and no `sorry`. The value is Nienhaus Proposition 2.25, and this is an independent machine-checked derivation of it rather than a new result.*

**Proof:** [diagonal-half.md](findings/diagonal-half.md)

##### Lemma L43, the invariance criterion at $a=0$ demands $\theta_0(n)$ and nothing weaker

Write $R=cI+W$ on the **Einstein** slice $R_{\mathrm{ric}_0}=0$, *Ricci-flatness is $c=0$, where the boundary forces $\lVert W\rVert=0$ and the statement is vacuous*, $F=\lVert R\rVert^2/\lVert\mathop{\mathrm{ric}}R\rVert^2$ and $\Omega_a=\{\mathop{\mathrm{scal}}(R)>0\}\cap F^{-1}((-\infty,\frac4{n-2+4a}])$. The quotient-rule expansion of the invariance condition uses $\Phi(cI+W)=c^2(n-1)I+\Phi(W)$ and the $\lVert\mathop{\mathrm{ric}}\rVert^2$ identity, and at $a=0$ the whole condition collapses to $\langle W,Q(W)\rangle\le c(n-1)\lVert W\rVert^2$ at every point of the slice with $c>0$, and on $\partial\Omega_0$ at $\lVert W\rVert=1$ the boundary forces $c(n-1)=\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$. The cone family runs over $a\in[0,n/4]$; Beitz proves the degenerate end $a\to n/4$ for every $n$, and $n\ge12$ enters that end nowhere. The full symmetry of the cubic's trilinear form is a theorem rather than a hypothesis of the collapse. It does not reach $a$ strictly between $0$ and $n/4$; Lemma L45 gives the two-sided bound the criterion demands off the slice.

**Proof:** [problem.md](findings/problem.md)

##### Lemma L44, $n\ge12$ cannot be weakened

Zero-padded $W_{\mathbb{CP}^2}$ is a critical point of $\mathcal W_n$ at every $n\ge4$ with $\theta=\sqrt{3/2}$, and the curvature operator $cI+W$ it defines lies on $\partial\Omega_0$. Böhm–Wilking's invariance criterion at that point is exactly $\sqrt{3/2}\le\theta_0(n)$ (Lemma L43), which fails for $4\le n\le11$ and holds from $n=12$, **the direction *invariance $\Rightarrow dF_R(\Phi(R))\le0$* being the first clause of [Beitz](findings/problem.md)'s Lemma 2.3.4 read through its proof**, which uses only the level set of $F$ through the point, so invariance of $\Omega_0$ alone suffices where the clause as stated assumes every sublevel set invariant. *The witness is padded and every step is kernel-blind; $\lVert W\rVert=1$ is what makes the criterion's inequality homogeneous.* So the cone is non-invariant for $4\le n\le11$, by a witness, and the hypothesis $n\ge12$ in the conjecture is forced by the problem rather than by any method. It says nothing about whether the cone is invariant at $n\ge12$, which is the conjecture itself.

**Proof:** [problem.md](findings/problem.md)

##### Lemma L45, off the slice: five surviving triples, and one coupling

Let $n\ge4$ and $R=cI+Y+W$ with $Y=R_{\mathrm{ric}_0}$. Of the ten distinct triples of the cubic $\langle R,\Phi(R)\rangle$, five vanish identically and five survive, with multiplicities $1,3,1,3,1$ from the total symmetry of $T(A,B,C)=\langle A,\Phi(B,C)\rangle$: $\langle R,\Phi(R)\rangle=c^3(n-1)\lVert I\rVert^2+3c\langle I,\Phi(Y)\rangle+\langle Y,\Phi(Y)\rangle+3\langle W,\Phi(Y)\rangle+\langle W,Q(W)\rangle$, the first three terms even in $W$ and the last two odd. Every $I$–$W$ pairing vanishes, and the only surviving triple containing $W$ that is absent from the slice is $(Y,Y,W)$, equal to $\tfrac3{n-2}\langle W,\mathrm{Ric}_0\wedge\mathrm{Ric}_0\rangle$ in Böhm–Wilking's normalisation of $\mathrm{Ric}$ and $\wedge$; the expansion is Huisken's, term for term. The $\Omega_0$ constraint depends on $\lVert W\rVert$ alone, so $cI+Y-W\in\Omega_0$ whenever $cI+Y+W$ is, and the criterion at both signs gives $\lvert\mathrm{LHS}_{\rm odd}-\mathrm{RHS}_{\rm odd}\rvert\le\mathrm{RHS}_{\rm even}-\mathrm{LHS}_{\rm even}$ with $\mathrm{LHS}_{\rm odd}=3\langle W,\Phi(Y)\rangle+\langle W,Q(W)\rangle$ and $\mathrm{RHS}_{\rm even}$, $\mathrm{RHS}_{\rm odd}$ the $W$-even and $W$-odd parts of $F(R)\langle\mathrm{ric}(R),\mathrm{ric}(\Phi(R))\rangle$. It is a bookkeeping identity for the general criterion and proves no case of the conjecture by itself.

**Proof:** [problem.md](findings/problem.md), the off-slice paragraph; the block is in [target.md](findings/target.md)

##### Lemma L46, at a locally symmetric Einstein space the Weyl part is critical, with $\theta$ quadratic in $\lVert W\rVert$

Let $(M,g)$ be a locally symmetric Einstein space of dimension $n$, $\mathrm{Ric}=\lambda g$ with $\lambda$ of either sign, with curvature operator $R$ on $\Lambda^2$, $N=\binom n2$, and Weyl part $W\ne0$. Then $Q(W)=W^2+W^\#=\lambda W$, so $W/\lVert W\rVert$ is a critical point of $P$ on the unit sphere with value $\theta=\lambda/\lVert W\rVert$, and $\lVert W\rVert^2=\lVert R\rVert^2-(\mathop{\mathrm{tr}}R)^2/N$. Compactness is not used. Normalising to Einstein constant $\tfrac12$ makes $\theta^2=\frac1{4(\lVert R\rVert^2-(\mathop{\mathrm{tr}}R)^2/N)}$, $\mathop{\mathrm{tr}}R=n/4$ and the centre constant $c=\frac1{2(n-1)}$, so $\theta\le\theta_0(n)$ becomes $\lVert W\rVert^2\ge\frac1{4\theta_0(n)^2}$. **That is not $\lVert W\rVert^2\ge\tfrac16$**, which is [Lemma L47](#lemma-l47-the-dimension-lemma-for-symmetric-spaces)'s **irreducible** threshold: *the balanced product $S^6\times S^6$ has $\lVert W\rVert^2=\tfrac9{55}<\tfrac16$ while attaining $\theta_0(12)$ exactly*, and the two inequalities coincide only at $n=6+2\sqrt7$, which is not an integer. **[Lemma L48](#lemma-l48-the-reducible-case-and-the-symmetric-space-theorem) carries the reducible floor $\frac1{4\theta_0(n)^2}$ and L47 the irreducible $\tfrac16$**, and the two halves meet because $\tfrac16\ge\frac{n^2}{8(n-1)(n-2)}$ exactly when $n^2-12n+8\ge0$. The lemma reaches locally symmetric spaces only; a general Einstein space has no reason to be critical.

**Proof:** [problem.md](findings/problem.md)

#### Landscape, the critical-point map

##### Lemma L2, exact dimension threshold

Needed to pin down where the known critical points rank. At even $n$ the balanced sphere-product overtakes the $\mathbb{CP}^2$-type competitor (Fox's $\mathcal S^4(\alpha)$) at $n=6+2\sqrt7\approx11.29$; at odd $n$ the best split is $S^{(n-1)/2}\times S^{(n+1)/2}$ and the crossover is $\frac{13+\sqrt{97}}2\approx11.42$. No integer lies between the two roots, so the integer threshold $n\ge12$ is reproduced exactly at both parities, not just approximately.

**Proof:** [problem.md](findings/problem.md)

##### Lemma L3, the balanced product is a local maximum in $\mathcal W_n$ at every even $n\ge8$

For every even $n\ge8$, the unit Weyl tensor $W^*$ of $S^{n/2}\times S^{n/2}$ with $P(W^*)>0$ is a local maximum of $P$ on the unit sphere of $\mathcal W_n$ (not merely within $\mathcal D_n$), strictly so transverse to its $O(n)$-orbit, with transverse Hessian at most $-6\theta/(n-2)$, attained. **At $n=6$ the argument stops**, that being the case Lemma L27 excludes, where nine Hessian null directions lie transverse to the orbit and the second-order test decides nothing. So at every even $n\geq12$, the range the conjecture concerns, the balanced product is a strict local maximum transverse to its orbit, and what remains open is whether it is the global one.

**Proof:** [second-order.md](findings/second-order.md)

##### Lemma L4, a generator for critical points, and a new family

**Proof:** [ungraded-slack.md](findings/ungraded-slack.md)

##### Observation L5, the census of rival critical-point families, at the families examined

A record of which critical-point families have been examined and how each compares with the two named competitors, evidence about the families listed and about no others, carrying no quantifier over $n$ except where a clause states one. **Seven families:** multi-block sphere products at $k\ge3$ factors, bounded by $\theta<\sqrt{2/(k-1)}$ and so below $1$ throughout; Fox's $5$-dimensional hyper-Kähler subalgebra and its $r\ge8$ extension, which attain $\sqrt{3/2}$ **exactly** at $r=4$; quaternionic-Kähler operators on $\mathbb{HP}^m$, with $\sup_m\theta=\sqrt{56/45}$ proved for every $m$; strongly-regular-graph solutions, below $\tfrac12$ at every primitive graph and every $n$; the simple-isotropy members of Lemma L4's family, reaching $\tfrac34\sqrt{10/7}=0.896421$ at $\mathfrak{spin}(9)\subset\mathfrak{so}(16)$; the $\mathfrak{so}(5)=\mathfrak{sp}(2)$ spin point at $0.387$; and a Ricci-flat Kähler family on $\mathbb C^m$ peaking at the $\mathbb{CP}^2$ competitor itself.

**What it establishes is a comparison against the balanced product alone**, and that comparison holds at every $n$ and both parities, read against $\Theta_n$: $\theta_0(12)^2=\tfrac{55}{36}$ against $S^5\times S^7$'s $\tfrac{264}{175}$ is $9625>9504$, and convexity of $1/(n_a-1)$ carries it everywhere. **What it does not establish is any statement of the form *every rival family loses*, at any $n$**, Fox's $r=4$ ties $\sqrt{3/2}$ and beats $\theta_0(8)=\sqrt{21}/4$, and unbalanced two-factor products beat padded $W_{\mathbb{CP}^2}$ whenever $\tfrac1{p-1}+\tfrac1{q-1}-\tfrac1{p+q-1}<\tfrac13$. One class remains genuinely open: the non-Lie-group simple-isotropy members, whose $(n,r)$ list is nowhere on the record.

**Proof:** [graded-half.md](findings/graded-half.md)

##### Conjecture L6, the zero-defect set, and why it hides no rival

**Proof:** [curvature-invariants.md](findings/curvature-invariants.md)

##### Lemma L7, a bound at every critical point, and the graded-subalgebra equality class

Compressing the criticality equation onto the negative spectral part gives, at every critical point,

$$\theta\mathop{\mathrm{tr}}(W_-)+\mathop{\mathrm{tr}}(W_-^2)\;\le\;\|\mathrm{Ric}(W_-)\|^2+6\,\delta^2,$$

with $\delta^2$ the defect of Observation L15. **The hypotheses are criticality, Ricci-flatness and the first Bianchi identity**, and the proof also uses $W_+W_-=0$, the spectral character of $\Pi_-$, and the convention $\mathop{\mathrm{scal}}=2\mathop{\mathrm{tr}}$, which is what makes its two halves meet. The value is in the equality case: **equality holds precisely when $\mathop{\mathrm{ran}}W_+\oplus\mathop{\mathrm{ran}}W_-$ is a $\mathbb Z_2$-graded subalgebra of $\mathfrak{so}(n)$ with even part $\mathop{\mathrm{ran}}W_+$**, a condition on $W$ rather than on a pair. **That is the condition defining a compact symmetric pair with $E_+$ the isotropy algebra only when $\ker W=0$**: at $W_{\mathbb{CP}^2}$ the graded condition holds while $\dim E_+=1$ is the even part of no involution of $\mathfrak{so}(4)$, and the converse direction fails because a graded pair need not be critical. **Equality is not confined to the high-value points**: it holds at $S^2\times S^4$ with $\theta^2=\tfrac{15}{16}$ and at $\mathbb{CP}^4$ with $\theta^2=\tfrac{35}{36}$, both below $1$. The equality class is also not stable under $W\mapsto-W$, while the critical set is.

**Proof:** [bounds.md](findings/bounds.md)


##### Lemma L154, the equality locus of $\mathop{\mathrm{scal}}(X_{\mathrm{inv}})\ge0$ is $X_{\mathrm{inv}}=0$, and at scalar $h$ that is the grant's equality

At every critical point $W\ne0$, $\mathop{\mathrm{tr}}X_{\mathrm{inv}}=0$ if and only if $X_{\mathrm{inv}}=0$, the three spectral-diagonal blocks are PSD, a zero block kills its row, and Theorem A's form is then supported in one zero block. When $h=\mathrm{Ric}(\lvert W\rvert)=\lambda\,\mathrm{id}$, as under any isotropy acting irreducibly over $\mathbb R$, $H=2\lambda\,\mathrm{Id}$ and $J_5=\lambda\mathop{\mathrm{scal}}(X_{\mathrm{inv}})\ge0$ with equality exactly at $X_{\mathrm{inv}}=0$. This upgrades Lemma L7's equality class from a trace to the operator. **Corollary, Gate 2 owed**: $X_{\mathrm{inv}}=0$ iff $\mathop{\mathrm{ran}}W_+\oplus\mathop{\mathrm{ran}}W_-$ is a Lie subalgebra graded as a symmetric pair, so $J_5=0$ on that class whatever $h$ is.

**Proof:** [findings/bounds.md](findings/bounds.md), Lemma L154. Gate 2: [r699](reviews/REVIEW_r699.md), [r700](reviews/REVIEW_r700.md).

##### Lemma L155, $X_{\mathrm{inv}}=0$ exactly on the $\mathbb Z_2$-graded subalgebras, with no criticality

For every symmetric $W\ne0$ on $\Lambda^2\mathbb R^n$, $X_{\mathrm{inv}}=0$ if and only if $\mathop{\mathrm{ran}}W_+\oplus\mathop{\mathrm{ran}}W_-$ is a $\mathbb Z_2$-graded subalgebra of $\mathfrak{so}(n)$ with even part $\mathop{\mathrm{ran}}W_+$, a symmetric pair, proper whenever $\ker W\ne0$. Each spectral-diagonal block is a bracket Gram sum with strictly positive weights, so its vanishing is one bracket inclusion, the kernel block giving closure; conversely the inclusions collapse $X_{\mathrm{inv}}$ by expansion. Hence $J_5=0$ on that class with no hypothesis on $h$. This retires Lemma L7's *modulo $\ker W$* hedge and corrects its caveat that $W_{\mathbb{CP}^2}$ at $n=4$ carries no grading: $\mathop{\mathrm{ran}}W$ there is $\mathfrak{so}(3)$ graded as $(\mathfrak{so}(3),\mathfrak{so}(2))$, and it is $\mathop{\mathrm{ran}}W_+$ alone that is the even part of none.

**Proof:** [findings/bounds.md](findings/bounds.md), Lemma L155. Gate 2: [r701](reviews/REVIEW_r701.md), [r702](reviews/REVIEW_r702.md).

##### Lemma L156, the balanced-orbit contour constant, corrected, and its optimum at the equidistant contour

For $m\ge2$ at $W^*=S^m\times S^m$, with $W(z)=W^*+zH$ affine and $\lVert H\rVert_{op}\le1$, and with $\Gamma$ the circle of radius $\alpha g_n$ centred at the negative eigenvalue $\lambda_-$, where $\lvert\lambda_-\rvert=g_n$, since trace-freeness gives $\lambda_+/\lvert\lambda_-\rvert=m/(m-1)>1$, and $\rho=\gamma g_n/\lVert H\rVert_{op}$ the radius of the disc in $z$, the constant governing the tube radius about $SO(n)\cdot W^*$ is $C(\alpha,\gamma)=\tfrac{\alpha(1+\alpha)}{d(d-\gamma)}$ with $d=\min(\alpha,D-\alpha)$ and $D=\tfrac{2m-1}{m-1}$, on the domain $0<\alpha<D$, $0<\gamma<\min(d,1)$, and it is the constant in $M\le C\gamma g_n$; the earlier $\tfrac{1+\alpha}{\alpha-\gamma}$ holds only while $\lambda_-$ is the spectral point nearest the contour. Its objective $J=C/\gamma$ has both branches strictly monotone toward $\alpha=D/2$, so the minimum is interior and attained at $\alpha^*=D/2$, $\gamma^*=D/4$ (the contour equidistant from $\lambda_-$ and $\lambda_+$), with $C^*=2+\tfrac{4(m-1)}{2m-1}$ and $J^*=\tfrac{4(1+\alpha^*)}{\alpha^{*2}}=\tfrac{8(m-1)(4m-3)}{(2m-1)^2}$, which is $\tfrac{42}{11}$ and $\tfrac{840}{121}$ at $n=12$. **Both constants are read at the dimension in hand**: the $m=2$ endpoints $\tfrac{10}3$ and $\tfrac{40}9$ lie outside the programme's $n\ge12$. The binding condition is the switch of the nearest spectral point, not encirclement of $0$ or of $\lambda_+$. **$\gamma^*$ minimises $J$ and is not the reach's optimum**: the reach $\sigma\rho$ carries a $(1-\sigma)^2$ that rises with $\gamma$, so its maximiser $\gamma^\dagger$ satisfies $\gamma^\dagger/(d-\gamma^\dagger)=\sqrt{1+4t}>1$ and $J^*$ is the reach's constant only to $O(t^2)$, the licence being exactly $1/(1-\eta^{*2})$, about $16\%$ at $n=12$. The error runs in the conservative direction, leaving a downstream lower bound on the radius sound and loose.

**Proof:** [findings/second-order.md](findings/second-order.md), Lemma L156. Gate 2: [r705](reviews/REVIEW_r705.md), [r706](reviews/REVIEW_r706.md).

##### Lemma L157, the reach parameter is determined by a fixed point, not chosen

The tube chain's reach parameter is the record's own $\eta$, r450 D7 defines the validity branch by the coupling $\lVert A''(s)\rVert\le2M/(\rho-\lvert s\rvert)^2$, and second-order.md carries it frozen at $\eta=\tfrac12$. What is new is that $\eta$ is **not free**: the bound must hold along the whole segment, so $\eta=r/\rho$ and the branch is the self-consistency condition $r\le\sqrt c/\sup_{\lvert s\rvert\le r}\lVert A''(s)\rVert$, whose largest solution is the crossing root $\eta^*=(2t+1-\sqrt{4t+1})/(2t)$ with $t=\lambda\sqrt{c_p+w^2}/(2J\gamma)$. r450 D7 and r451 A4 both declared this fixed point absent. The exact identity is $\eta^*\gamma=\tfrac{\lambda\sqrt{c_p+w^2}}{2J}(1-\eta^*)^2$; the factor $(1-\eta^*)^2$ does not drop and does not vanish with $n$, $\gamma$ does not cancel, and freezing $\eta=\tfrac12$ cost about $2.9$ at the binding direction rather than the factor $4$ first claimed. At $w=0$ the branch is absent, the defect vanishing identically there.

**Proof:** [findings/second-order.md](findings/second-order.md), Lemma L157. Gate 2: [r709](reviews/REVIEW_r709.md), [r710](reviews/REVIEW_r710.md).

##### Lemma L158, the branch comparison turns on one dimension-dependent constant, and $\sup\lvert P\rvert$ must grow before I31 can bind

In Lemma L149's parametrisation, **branch 1 is $(c_p+u^2)/(S+au)$ in its own variable $u$, and its infimum is not the value at $u=0$**: $f'(0)=-ac_p/S^2<0$, so $u=0$ is never its minimum, and its infimum is $f(u^*)=2u^*/a$ at $u^*=(\sqrt{S^2+a^2c_p}-S)/a\le\sqrt{c_p}=\Theta(n^{-1/2})$, *the recorded $\kappa/(nS)$ is $f(0)$, which the branch falls below*. **The order of that infimum is not settled here**: a joint minimisation over the shared variable is owed, and the $\Theta(n^{-3/2})$ recorded briefly against it read the numerator and the coefficient at two different points. Branch 2 has an infimum of order $n^{-1}$ (*its minimum sits at the homogeneity kink $w_0=(n-4)/n$, which is $\tfrac23$ at $n=12$), **a strict kink minimum rather than a stationary point**, the one-sided log-derivatives being $-0.2405$ and $+0.3595$ there, with $\phi'(w_0)=\tfrac n{2(n-2)}$ in closed form; *the $\tfrac1{\sqrt{1+4t}}$ elasticity is load-bearing, and the sufficient condition behind it is claimed at $n=12$ only, failing at $n=14$ where the chain gives $0.586$ against $\phi'(w_0)=0.5833$, which leaves $n=14$ open rather than refuted*, the envelope being $\lVert H\rVert_{op}\le\min(a_0n^{-1/2}\sqrt{1-w^2}+w,1)$ with $a_0=\sqrt{2n/(n-2)}$, so that $a_0n^{-1/2}=\sqrt{2/(n-2)}=1/\sqrt{m-1}$, **the constant this file spent without defining**, and the one that fixes both $w_0$ and $\phi'(w_0)=\tfrac n{2(n-2)}$ and equal to $1$ above $w_0$*, and the $n^{-1}$ cancels, so which branch binds is an inequality between absolute constants, $S$ against $\sqrt{\kappa(1+\kappa)}/K$. Here $\kappa=nc_p=3\sqrt{2(n-1)/(n-2)}\approx4.45$, fixed by the record's margin $c_p=3\theta_0/(n-2)$. Since the known bounds on $\sup\lvert P\rvert$ are upper ones and Lemma L143 gives $\sup\lvert P\rvert\le1+\sqrt{n-2}$, branch 2 binds at $n=12$ and branch 1 can bind only if $\sup\lvert P\rvert$ genuinely grows past an absolute constant, so if I31 succeeds in showing it dimension-free and small, branch 1 never binds and branch 2 alone governs the radius. **The threshold is a number and not a dispute:** $T=\kappa\sqrt2J/(\lambda(1-\eta^*)^2s_\rho(w_0))$ is $18.00$ at $n=12$, against $\sup\lvert P\rvert\le4.162$, so branch 2 binds there with a factor-$4$ margin. *The earlier readings $21$, $3.98$, $52.92$ and the band $17$–$19$ are withdrawn; the spread was $\lambda$ and $J^*$ each read at an asymptotic value at finite $n$.* **The claim that branch 2 binds up to $n\approx1800$ is withdrawn**, it had no argument and reconstructs only at the superseded coefficient; the corrected crossing is $n\approx1140$, above every dimension this programme evaluates. *$T$ carries the largest dimension-dependence in the entry: $\lambda=2/\sqrt{\lvert\kappa_n\rvert}$ has a pole at $n=6+2\sqrt7$, just below the admissible range, so $T$ runs from $18$ at $n=12$ to about $35$ in the limit.*

**Proof:** [findings/second-order.md](findings/second-order.md), Lemma L158. Gate 2: [r711](reviews/REVIEW_r711.md), [r712](reviews/REVIEW_r712.md). The branch-2 infimum is corrected per [r717](reviews/REVIEW_r717.md), [r718](reviews/REVIEW_r718.md), and the entry was audited as [ROUND_L158](verification/ROUND_L158.md), v38, v39, v40, with two findings adjudicated by v41 and v42.

##### Lemma L159, the involutions of the compact $\mathfrak{so}(n)$, classified, and the conjugacy notion the record consumes

Let $n\ge3$, $n\ne8$, and let $\mathfrak{so}(n)$ be the **compact** real form. Every involutive automorphism of $\mathfrak{so}(n)$ is $\mathrm{Ad}_g$ for some $g\in O(n)$ with $g^2=\pm I$, unique up to sign, and is conjugate under $\mathrm{Ad}(O(n))$ to exactly one of $\mathrm{Ad}_{\mathrm{diag}(-1^p,1^{n-p})}$, $0\le p\le\lfloor n/2\rfloor$, with fixed algebra $\mathfrak{so}(p)\oplus\mathfrak{so}(n-p)$; or, for even $n$ only, $\mathrm{Ad}_J$ for an orthogonal complex structure, with fixed algebra $\mathfrak u(n/2)$. The count is $\lfloor n/2\rfloor+1$ at odd $n$ and $\lfloor n/2\rfloor+2$ at even $n$, the identity included, and the isomorphism type of the fixed algebra separates the classes. **Three hypotheses, each load-bearing at a named point**: compactness at the $g^2=-I$ branch and at $\mathrm{Inn}=\mathrm{Ad}(SO(n))$; $n\ge3$ once, in $\ker(\mathrm{Ad}|_{O(n)})=\{\pm1\}$; and $n\ne8$, which is what makes every automorphism preserve the vector representation. **The exclusion at $n=8$ is a theorem**: $\mathfrak{spin}(7)\subset\mathfrak{so}(8)$ is the fixed algebra of a genuine involution and acts irreducibly on $\mathbb R^8$, so it is $O(8)$-conjugate to nothing on the list; the abstract-isomorphism form survives there and the $O(8)$ form does not. **The divergence inside the conjecture's own range is $O(n)$ against $SO(n)$, at every $n$ divisible by four**: the $\mathfrak u(n/2)$ class is one $O(n)$-class and two $SO(n)$-classes when $n/2$ is even, giving eight $O(12)$-classes against nine $SO(12)$-classes, while the $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ family never splits. Classes are separated by isomorphism type and never by $\dim\mathfrak g_0$, which collides whenever $n/2$ is a perfect square, at $n=18$, $\mathfrak{so}(6)\oplus\mathfrak{so}(12)$ and $\mathfrak u(9)$ both having dimension $81$.

**Proof:** [findings/graded-half.md](findings/graded-half.md), Lemma L159. Derived in-round to discharge the appeal [L23](findings/ungraded-slack.md), [L27](findings/nondegeneracy.md), [L08](findings/graded-half.md) and [L69](findings/graded-half.md) were making bare. Gate 2: [REVIEW_I40a](reviews/REVIEW_I40a.md), [REVIEW_I40b](reviews/REVIEW_I40b.md), identical briefs, each building the argument independently and each constructing the same falsifier at $n=8$. Stated independently by [Holland–Ion](references/holland-ion-2012-symmetric-spaces/) Chapter 8 and [Etingof](references/etingof-2024-real-forms-involutions/) §41.2, with the $\mathrm{Aut}=\mathrm{Ad}(O(n))$ step corroborated by [Ziller](references/ziller-2010-lie-groups-symmetric-spaces/) Proposition 4.43 and [Yokota](references/yokota-2009-exceptional-lie-groups/) Theorem 1.3.5.

##### Lemma L160, the mixed summand dies, and every corank reduces to the maximal-rank branch

Let $x\in\mathfrak{so}(m)$ be nonzero, $V=\mathop{\mathrm{im}}x$, $K=\ker x$ and $\mathfrak c=\mathfrak z(x)\cap x^\perp$. The mixed summand $\mathop{\mathrm{Hom}}(K,V)$ contributes nothing to $\mathfrak z(\mathfrak c)\cap\mathfrak c^\perp$ **if and only if $m\ne3$**, and then $\mathfrak z(\mathfrak c)\cap\mathfrak c^\perp=\mathfrak z_{\mathfrak{so}(V)}(\mathfrak c_V)\cap\mathfrak c_V^{\perp_V}$, **so every corank reduces onto Lemma L32's maximal-rank branch.** The two conditions on the mixed block decouple and are killed by different facts: at $\dim K\ge2$ the standard representation of $\mathfrak{so}(K)$ carries no invariant vector, and at $\dim K=1$, where that is **false**, not vacuous, $\mathfrak c_V$ has trivial common kernel on $V$, which holds exactly at $\mathop{\mathrm{rank}}x\ge4$. They are jointly empty only at $(r,k)=(1,1)$, which is $m=3$. *Corollaries: $r=1$ returns $\mathbb Rx$ at every $m\ne3$ with no root argument, and the $\mathfrak{su}(2)$ exception is $r=2$ with $a\propto(1,1)$ at every corank.*

**Proof:** [isotropy-cap.md](findings/isotropy-cap.md), Lemma L160. Derived to discharge the one step three verifiers of [ROUND_L32](verification/ROUND_L32.md) named and none wrote. Gate 2: [REVIEW_I41a](reviews/REVIEW_I41a.md), [REVIEW_I41b](reviews/REVIEW_I41b.md), identical briefs, agreeing on every case.

##### Conjecture L8, the graded case reduced to a finite check, and settled across the classical families

An equivariant graded critical point on a compact symmetric pair $(\mathfrak{so}(n),\mathfrak k)$ with $p=\dim\mathfrak k$, $q=\dim\mathfrak m$ is pinned by its pair's dimensions, $\theta=(c_{\mathfrak k}q^2+2q^2+p^2)/[(2q-p)\sqrt{pq(p+q)}]$, **and only under three hypotheses the earlier form omitted**: $\mathfrak k$ **simple**, so that a single $c_{\mathfrak k}$ exists; $2q>p$; and $\mathfrak h$ irreducible on $\mathbb R^n$. **As a universal statement over all compact symmetric pairs it is false**, at three objects this record already holds: at $(\mathfrak{so}(8),\mathfrak{so}(3)\oplus\mathfrak{so}(5))$ the two ideals carry adjoint Casimirs $2$ and $6$ and no single $c_{\mathfrak k}$ exists, the formula giving $1.130862$ against $\sqrt{56/45}=1.115547$; at $(\mathfrak{so}(4),\mathfrak u(2))=\mathbb{CP}^2$ it is a **pole**, $2q-p=0$; and at $\mathbb{CP}^3$ it returns $1.229772$, **above $\sqrt{3/2}$**, where the truth is $\sqrt{10}/3$. *The poles are an infinite family, $2q-p=0$ at $n\in\{6,25,96,361,\dots\}$.* **What covers the reducible case is the ideal-wise system**, which reproduces $\theta^2=56/45$ at $S^3\times S^5$ and $264/175$ at $S^5\times S^7$. A second identity, counting the pair's structure constants two ways, reduces $c_{\mathfrak k}$ to a tabulated Casimir ratio, **and the table is a lookup into a classification this record does not hold**: [references/](references/) has no Cartan, Helgason, Berger or Besse entry, one exceptional row cannot be evaluated at all, and the sweeps behind "finite" truncate at $N,m\le40$. So the value follows from three integers and one table lookup, with no curvature operator built at any stage; **whether the equivariant graded case is a *finite* check is owed, not established**; it reproduces the Ricci-flat Kähler family and the sphere pairs identically. The lemma is stated in the pair-graded sense and pins the pair's equivariant point only; graded points are outside it (Lemma L58, whose two surviving witnesses are *equivariant* symmetric pairs; the non-equivariant case is witnessed instead by the $(\mathfrak{so}(8),\mathfrak{so}(3)\oplus\mathfrak{so}(5))$ point at $1.088948$, which has trivial kernel), and Lemma L69 carries the classification above $\sqrt{3/2}$.

**Proof:** [graded-half.md](findings/graded-half.md)

##### Lemma L9, the high ground has more than one peak

At $n=8$, the triality image $\tau W_{3,5}$ of the unit Weyl tensor of $S^3\times S^5$, taken with $P>0$, is a strict local maximum of $P$ on the unit sphere of $\mathcal W_8$ transverse to its $O(8)$-orbit, at $\theta^2=\tfrac{56}{45}$: triality preserves $Q$ and $\mathcal W_8$, Nienhaus's Proposition 2.25 gives $\theta>0$, Lemma L27 at $(3,5)$ and Lemma L24 give the Hessian, and Lemma L3's tubular-neighbourhood step turns it into local maximality. The balanced product is another at $\theta_0(8)^2=\tfrac{21}{16}$, so $n=8$ has at least two peaks. The record identifies $\tau W_{3,5}$ with the quaternionic-Kähler operator on $\mathbb{HP}^2$; that identification, with its sign, is owed.

**Proof:** [graded-half.md](findings/graded-half.md)

##### Lemma L10, the reducible-isotropy families carry one critical point each, all below the threshold

Each of the listed one-parameter-per-factor families spans a one-dimensional space of Weyl operators, so its critical points are forced rather than found: they are $\pm W$, **two of them**, with multipliers $\pm\theta$, and the stated value belongs to the one carrying $P>0$. For the $\mathbb{CP}^m$ family, $m\ge2$, the value is $\theta^2=\frac{(m+1)(2m-1)}{3m(m-1)}$ (**derived from Fox's norm identity**, not from the dimension count), strictly decreasing in $m$, falling to $2/3$ unattained, and **exactly $\tfrac32$ at $m=2$, so this family ATTAINS the threshold $\sqrt{3/2}$**; every $m\ge3$ member and every other listed family's point is strictly below it. The one-dimensionality is a computation at nine members of five families rather than an argument, and is owed. The lemma reaches the families named in [graded-half.md](findings/graded-half.md) and no larger class: $\mathfrak{so}(6)\oplus\mathfrak{so}(6)$ is one-parameter-per-factor and sits at $\theta^2=\tfrac{55}{36}$, above the threshold.

**Proof:** [graded-half.md](findings/graded-half.md)

##### Lemma L11, nondegenerate for $p,q\ge3$ with $(p,q)\ne(3,3)$, at the unpadded dimension

**At $n=p+q$**, for $p,q\ge3$ with $(p,q)\ne(3,3)$, $S^p\times S^q$ is Morse–Bott nondegenerate, the Hessian kernel being exactly the orbit tangent of dimension $pq$. **The one degenerate case in that range is $(3,3)$.** *$\min(p,q)=2$ is a different failure: $\mu=\tfrac12+\frac1{2(n-3)}$ is strictly above $\tfrac12$ there, which costs maximality and not nondegeneracy, and **that the family is nondegenerate has no argument on file**, its two cited supports forming a circle.* **The dimension is part of the statement**: at a padded dimension the $p=2$ family IS degenerate, [L126](findings/second-order.md)'s padded four-set carrying exactly $\tfrac12$ at $p=2$.

**Proof:** [nondegeneracy.md](findings/nondegeneracy.md)

##### Observation L12, the ungraded half, measured, and its slack has a closed form

Lemma L7 splits the critical points by whether its inequality is an equality; Lemma L8 settles the equality side over the equivariant graded points. The strict side is measured by its slack, $S(W):=\lVert\mathrm{Ric}(W_-)\rVert^2+6\delta^2-\theta\mathop{\mathrm{tr}}(W_-)-\mathop{\mathrm{tr}}(W_-^2)\ge0$, which has a closed form on the subalgebra family (Lemma L23). The carrier inequality is valid and sharp at $W_{\mathbb{CP}^2}$, and it separates nothing: $(S^m)^3$, exactly critical with zero defect and on the strict side, drives its bound to $4/3$, so any repair must see $n$ or the value. The ungraded half is measured here and proved nowhere.

**Proof:** [ungraded-slack.md](findings/ungraded-slack.md)

##### Lemma L23, the conjecture on the subalgebra family, and gradedness as the cap

Let $\mathfrak h\subseteq\mathfrak{so}(n)=\Lambda^2\mathbb R^n$ be a subalgebra with $\mathfrak m=\mathfrak h^\perp$, $r=\dim\mathfrak h$, $N=\binom n2$ and $0<r<N$, and let $W_{\mathfrak h}$ be the unit-norm multiple of $\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id}$. If $Q(W_{\mathfrak h})=\theta W_{\mathfrak h}$, then

$$\theta=\frac2n\sqrt{\frac{rN}{N-r}},\qquad S_{\mathfrak{mmm}}:=\sum_{a,b,c\in\mathfrak m}\langle[\varphi_a,\varphi_b],\varphi_c\rangle^2=(N-r)\Big[2(n-2)-\frac{4(n-1)r}{N}\Big],$$

*the $2(n-2)$ being the Killing row marginal, **[Lemma L153](findings/bounds.md)**, summed over the $N-r$ rows of $\mathfrak m$.*

hence $r\le n(n-2)/4$ and $\theta\le\theta_0(n)$, with equality in either place exactly when $S_{\mathfrak{mmm}}=0$, that is, when $[\mathfrak m,\mathfrak m]\subseteq\mathfrak h$, when $W_{\mathfrak h}$ is $\mathbb Z_2$-graded, and when $(\mathfrak{so}(n),\mathfrak h)$ is a symmetric pair. For $n$ even the equality case is $\mathfrak h=\mathfrak{so}(n/2)\oplus\mathfrak{so}(n/2)$ alone, $n=8$ included, where triality's two extra $\mathbb Z_2$-gradings have dimensions $21$ and $13$ against the cap $12$, so the maximum over the family is attained exactly at the Weyl operator of $S^{n/2}\times S^{n/2}$; for $n$ odd the cap is not an integer and the inequality is strict.

**Proof:** [ungraded-slack.md](findings/ungraded-slack.md)

##### Observation L25, every ungraded critical point on file fails the second-order bound

Across $155$ converged critical points at $n=6$ and every structured ungraded critical point on file, $\lambda_{\max}(L_e\vert_{W^\perp})>\tfrac12$, **except on the $SO(n)$-orbit of $W_{\mathbb{CP}^2}$ and its paddings, where it is exactly $\tfrac12$**, so every point outside that orbit fails the maximizer bound of Lemma L24. *$\lambda_{\max}\ge\tfrac12$ holds at every critical point with $\theta\ne0$ from equivariance alone, so the content is that equality is attained only there; and the range $1.17$ to $96.3$ described the $n=6$ solver population, not the union.* Graded points can fail it too ($\mathbb{CP}^m$ at $m\ge3$ does (Lemma L28)) so the bound detects non-maximality and says nothing about gradedness. The observation is a census at the dimensions stated.

**Proof:** [second-order.md](findings/second-order.md)

##### Lemma L26, the dangerous eigenvalue of the two-block spectrum, in closed form

Let $n=p+q$ with $p,q\ge2$, let $\pi$ be a coordinate $2$-plane inside the $p$-block and $\rho$ one inside the $q$-block, and let $X$ be $\phi_\pi\odot\phi_\rho$ with its $\Lambda^4$ component removed. Then $X\in\mathrm{Weyl}_n$, and for the sphere product's $e$,

$$e\circ X=\mu X,\qquad \mu=\frac{n-2}{2(p-1)(q-1)},\qquad \mu\ge\tfrac12\iff(p-2)(q-2)\le1 .$$

So the criterion $\mu\ge\tfrac12$ binds at exactly two splits, and it binds differently at each: at $\min(p,q)=2$, where $\mu$ **exceeds** $\tfrac12$ by the recorded $\tfrac1{2(n-3)}$, and at $(p,q)=(3,3)$, where it **equals** it. *Only the equality is degeneracy*, [Lemma L24](#lemma-l24-second-order-optimality-as-an-eigenvalue-bound-on-the-multiplication-operator)'s kernel is an eigenspace at $\tfrac12$, so a single word covering both cases inverts the consequence. For $p,q\ge3$ other than $(3,3)$ and $(3,4)$ the gap below $\tfrac12$ is $1/(2\max(p,q)-2)$; at $(3,4)$ this family's own $\mu=\tfrac5{12}$ overtakes $\lambda_m=\frac{m-2}{2(m-1)}$ at $m=\max(p,q)$ and the gap is $\tfrac1{12}$. **The gap clause is an upper bound on the whole spectrum, which an exhibited eigenvector cannot give; it is [Lemma L27](#lemma-l27-sphere-products-are-morsebott-nondegenerate)'s, and holds in L27's range.**

**Proof:** [nondegeneracy.md](findings/nondegeneracy.md)

##### Lemma L27, sphere products are Morse–Bott nondegenerate

Let $p,q\ge3$ with $(p,q)\ne(3,3)$ and $n=p+q$. Then $\lambda_{\max}(L_e|_{W^\perp})=\tfrac12$ at $W_{p,q}$, attained exactly on the orbit tangent, so $\dim E(\tfrac12)=pq=\dim(\text{orbit})$ and $S^p\times S^q$ is Morse–Bott nondegenerate.

**Proof:** [nondegeneracy.md](findings/nondegeneracy.md)

##### Lemma L28, the $\mathbb{CP}^m$ family is nondegenerate at every $m\ge3$

For every $m\ge3$, the $\mathfrak u(m)$-invariant line in $\mathrm{Weyl}_{2m}$ is spanned by a critical $W_{\mathbb{CP}^m}$ with $\theta^2=\frac{(m+1)(2m-1)}{3m(m-1)}$, and

$$\dim E(\tfrac12)=\dim(\text{orbit})=m(m-1),\qquad \lambda_{\max}(L_e|_{W^\perp})=\frac{m+2}{2(m+1)}=\tfrac12+\frac1{2(m+1)} .$$

So $\mathbb{CP}^m$ is Morse–Bott nondegenerate and, since $\lambda_{\max}>\tfrac12$, is not a maximiser.

**Proof:** [nondegeneracy.md](findings/nondegeneracy.md)

##### Lemma L29, one positive and two negative eigenvalues cap $\theta$ at $\sqrt{3/2}$

Let $W\in\mathrm{Weyl}_n$ have $\|W\|=1$ and exactly one positive and two negative eigenvalues, $\lambda_1>0>-a\ge-b$. Then $\theta(W)\le\sqrt{3/2}$, attained at the spectrum $(2,-1,-1)/\sqrt6$. The bound carries no dimension restriction. **The converse comes in two strengths and neither is the lemma the record credited.** *Equality forces the spectrum* follows in two lines from this proof's own equality case, needing no further result; *equality forces the support to have $r=4$* is [Lemma L31](#lemma-l31-the-bracket-cap-characterised)'s, in three. **The credit to Lemma L72 is withdrawn**, L72 quantifies over *critical* points and this clause over *equality* points, and the containment runs the wrong way.

**Proof:** [stratum-two-negative.md](findings/stratum-two-negative.md)

##### Lemma L30, a small negative eigenspace forces a small support

Let $W\in\mathrm{Weyl}_n$ and set $U=\sum_{\lambda_\alpha<0}\mathop{\mathrm{im}}v_\alpha$, the sum over **all** negative eigenvectors read as skew matrices. If $\dim U<n$ then $W$ vanishes on $u\wedge u^\perp$ for every $u\perp U$, and $W$ is a padding of a $\mathrm{Weyl}_{\dim U}$ tensor with the same norm and the same $\theta$.

> **THE HYPOTHESIS IS ON $U$, AND A COUNT OF NEGATIVE EIGENVALUES CANNOT REPLACE IT.** *Under "at most two distinct", $\mathrm{pad}_{V_1}(W_{\mathbb{CP}^2})+\mathrm{pad}_{V_2}(W_{\mathbb{CP}^2})$ on $\mathbb R^8$ has one distinct negative eigenvalue of multiplicity four, satisfies the hypothesis and breaks the conclusion; under "at most", the one-negative case leaves $\dim U$ undetermined.* **Owed: "with the same norm and the same $\theta$" (the clause the lemma exists for), has no argument on the record.** *The four steps that would close it are named in the block, and the Lie-subalgebra property reaches only one of them.*

**Proof:** [stratum-two-negative.md](findings/stratum-two-negative.md)

##### Lemma L31, the bracket cap, characterised

For **unit** $X,Y\in\mathfrak{so}(n)$, $\lVert[X,Y]\rVert^2\le2$, **with equality if and only if** $XY=-YX$, both $X$ and $Y$ have rank $4$ with all **nonzero** singular values equal to $1/\sqrt2$, and $\mathrm{im}\,X=\mathrm{im}\,Y$. *The cap is the half the consumers cite and stood only inside the proof. Orthogonality is a consequence of the equality case rather than a hypothesis: the forward direction uses only the unit norms, and $XY=-YX$ gives $\mathop{\mathrm{tr}}(XY)=0$ by itself.* **The norm is this record's $\tfrac12\mathop{\mathrm{tr}}(Z^{\mathsf T}Z)$, and the constant $2$ rests on that and nothing else.** The equality set is non-empty from $n=4$, and no condition in it is droppable.

**Proof:** [stratum-two-negative.md](findings/stratum-two-negative.md)

##### Lemma L32, a bivector's centraliser collapses to a line

Let $m\ne3$, let $x\in\mathfrak{so}(m)$ be nonzero and $\mathfrak c=\mathfrak z(x)\cap x^\perp$. Then $\mathfrak z(\mathfrak c)\cap\mathfrak c^\perp=\mathbb Rx$, except when $x$ is a multiple of a complex structure on a $4$-dimensional subspace, where it is a $3$-dimensional $\mathfrak{su}(2)$. **The restriction is necessary**: at $m=3$ the centraliser $\mathfrak c$ is zero and the statement fails, which is [r463](reviews/REVIEW_r463.md)'s witness $x=e_{12}\in\mathfrak{so}(3)$. *That reviewer named this line for repair and it was missed; only the landscape entry above got it.*

**Proof:** [isotropy-cap.md](findings/isotropy-cap.md)

##### Lemma L33, one eigenvalue of one sign forces the tensor to vanish

Let $W\in\mathrm{Weyl}_m$ have a **one-dimensional** eigenspace on one side, exactly one eigenvalue counted *with multiplicity*. If that eigenvector is not a multiple of a complex structure on a $4$-dimensional subspace, then $W=0$. In particular no rank-$3$ $\mathrm{Weyl}_m$ tensor at even $m\ge6$ has a nondegenerate minority-side eigenvector.

**Coverage.** The statement is proved at even $m$ with nondegenerate $x$, and at degenerate $x$ with $\dim\ker x\ge2$. **At corank $1$ (the generic odd-$m$ case), the conclusion is true and its proof is not on file**, the gap being [Lemma L32](findings/isotropy-cap.md)'s: its degenerate branch invokes $\mathfrak{so}(\ker x)$, which is zero there. *The result is vacuous at $m=4$, where a single positive eigenvalue forces one of $W^\pm=0$ and the exception always applies, which is why the "in particular" clause's $m\ge6$ is sharp.*

**This is classical and is cited, not claimed.** It is the Weitzenböck curvature term on 2-forms, $q(R)\omega=\mathrm{Ric}\circ\omega+\omega\circ\mathrm{Ric}-2\mathring R\omega$, from the Lichnerowicz Laplacian ([Besse, *Einstein Manifolds*, §1.143](https://link.springer.com/book/10.1007/978-3-540-74311-8)), specialised to Ricci-flat curvature; [Petersen–Wink Proposition 1.6](https://arxiv.org/abs/1908.09958) gives the eigenbasis rewriting and not the evaluation. **First Bianchi is the load-bearing hypothesis** (it alone gives $\mathcal A(R)=2R-(\mathrm{Ric}\cdot\omega+\omega\cdot\mathrm{Ric})$) while Ricci-flatness only deletes the correction, and fails on its own because $\Lambda^4$ is itself Ricci-flat and carries eigenvalue $-4$ rather than $+2$.

**Proof:** [stratum-two-negative.md](findings/stratum-two-negative.md)

##### Lemma L34, full support with two negative eigenvalues, at $m=6$, $m=7$ and $m=8$

For $m=6$, $m=7$ and $m=8$ there is a $W\in\mathrm{Weyl}_m$ with exactly two negative eigenvalues and $\dim U=m$, where $U=\mathrm{im}\,v_{N-1}+\mathrm{im}\,v_N$. The witnesses are sums of two padded copies of $W_4(q,r)$ at $q=r>0$, on 4-planes in a named relative position: orthogonal complementary planes at $m=8$ give $\{-1/\sqrt3\,(\times2),\ 1/(2\sqrt3)\,(\times4)\}$ with $\theta=-\sqrt3/2$, and planes meeting in a 2-plane at $m=6$ give $(-3,-1,1,1,1,1)/\sqrt{14}$ with $\theta=-27\sqrt{14}/98$. **Two 4-planes span at most eight dimensions, so the family provably stops at $m\le8$** and says nothing at $m\ge10$.

**Proof:** [stratum-two-negative.md](findings/stratum-two-negative.md)

##### Lemma L35, at most two negative eigenvalues caps $\theta$ at $\sqrt{3/2}$

Let $W\in\mathrm{Weyl}_m$ have **unit norm** and at most two negative eigenvalues, at any number of positive ones and any $m$. Then $\theta\le\sqrt{3/2}$. *The norm is a normalisation rather than a restriction, $\theta$ being $0$-homogeneous, and it carries the eigenframe identity the proof opens with, and it excludes $W=0$, the one point the hypotheses otherwise admit and at which $\theta$ is $0/0$.*

**Proof:** [stratum-two-negative.md](findings/stratum-two-negative.md)

##### Lemma L36, $S=0$ caps the negative eigenspace at $\lfloor n^2/4\rfloor$

Let $\mathfrak m\subseteq\mathfrak{so}(n)$ satisfy $\langle[u,v],w\rangle=0$ for all $u,v,w\in\mathfrak m$, *isotropic*, which the negative eigenspace of a Weyl operator with $S=0$ is. Then $\dim\mathfrak m\le\lfloor n^2/4\rfloor$, with equality attained by the mixed planes $\mathfrak m\cong\mathbb R^p\otimes\mathbb R^q$ at $p=\lceil n/2\rceil$, of dimension $pq$, $n^2/4$ at even $n$ and $\frac{n^2-1}4$ at the odd split, so sharpness holds at both parities. Sharp, every $n\ge3$, no genericity hypothesis. *The converse of the first clause fails at $n=3$, where $\dim\mathcal W_3=0$ while isotropic $2$-planes exist; and the maximiser is the mixed planes rather than $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$, which is $\mathfrak m^\perp$, falls short of the cap by $n/2$, and is inadmissible since an isotropic subalgebra is abelian.*

**Proof:** [isotropy-cap.md](findings/isotropy-cap.md)

##### Lemma L37, diagonality is decided by a single kernel

For $W\in\mathcal W_n$ and symmetric $A\in\mathrm{Sym}^2(\mathbb R^n)$ let $\delta_A$ act on $\Lambda^2$ by $\delta_A(X)=AX+XA$, and let $\Phi_W(A)=[W,\delta_A]$. Then $W$ is diagonal in some orthonormal frame of $\mathbb R^n$ (every $\varphi_{ij}=e_i\wedge e_j$ an eigenvector) if and only if $\ker\Phi_W$ contains an $A$ whose eigenvalues have pairwise-distinct sums $a_i+a_j$. The test is frame-independent, necessary and sufficient, and **needs neither criticality nor $W\in\mathcal W_n$**, it holds for every linear operator on $\Lambda^2\mathbb R^n$. Since the matrices diagonal in a given frame supply an $n$-dimensional subspace of $\ker\Phi_W$ when $W$ is diagonal there, $\dim\ker\Phi_W<n$ certifies non-diagonality outright; **the threshold is $n$ because $A$ ranges over $\mathrm{Sym}^2$, and would be $n-1$ over $\mathrm{Sym}_0$.** It is the criterion by which Observation L40 separates the two sides of the critical set.

> **THE TEST SAYING NOTHING ABOUT $\theta$ IS NOT THIS LEMMA'S CLAIM.** *It belongs to post F22 and is false on its literal reading, diagonality bounding $\theta\le\Theta_n$ through [Lemma L57](#).* **What L37 establishes is the equivalence and the corollary, nothing about the value.** *Two of its remarks rest on measured or unnamed witnesses (the non-vacuity at $n=4$, and the one-directionality of the corollary) and closed forms for both were derived during its audit and are filed rather than adopted.*

**Proof:** [target.md](findings/target.md)

##### Lemma L38, two families in closed form, strictly decreasing, meeting at $W_{\mathbb{CP}^2}$

For the $\mathbb{CP}^m$ family, $m\ge2$, the unit Weyl tensor has $\theta^2=\frac{(m+1)(2m-1)}{3m(m-1)}$. For the two-eigenvalue point of the symmetric pair $(\mathfrak{su}(m),\mathfrak{so}(m))$ inside $\mathfrak{so}(2m)$, with $p=\dim\mathfrak k=\binom m2$ and $q=\dim\mathfrak m=\binom{m+1}2-1$, $\theta^2=\frac{m(m+1)}{(m-1)(m+2)}=\frac X{X-2}$ with $X=m(m+1)$. Both are strictly decreasing in $m$ with maximum $\tfrac32$ at $m=2$, and the $m=2$ member of the second family is $W_{\mathbb{CP}^2}$ itself, so neither family exceeds $\sqrt{3/2}$ anywhere. The lemma is a value statement about two families and says nothing about points outside them.

> **"CAPPED" WOULD MEAN "CAPPED AT $\sqrt{3/2}$, ATTAINED", NOT "BELOW THE TARGET".** *At each member's own $n=2m$ the small members run the other way*: $\mathbb{CP}^m$ exceeds $\theta_0(2m)$ at $m=2$ and **equals it exactly at $m=3$**, falling below only from $m\ge4$; the Kähler family exceeds it at $m=2$ and $m=3$. **Where the cap is useful, at $n\ge12$, it is attained at padded $W_{\mathbb{CP}^2}$, so it fences and never separates.** *The $\mathbb{CP}^m$ half duplicates [Lemma L10](#), which states the range and the limit this entry drops.* **Owed: that the Kähler family's members are Weyl tensors at all**, which is on file only as a screen at sampled $m$.

**Proof:** [ungraded-slack.md](findings/ungraded-slack.md)

##### Lemma L39, the two-eigenvalue formula for an arbitrary symmetric pair

Let $(\mathfrak g,\mathfrak k)$ be a symmetric pair with $\mathfrak g\subseteq\mathfrak{so}(n)$, $p=\dim\mathfrak k$, $q=\dim\mathfrak m$, and let $W$ be the two-eigenvalue operator constant on $\mathfrak k$ and on $\mathfrak m$. Then $S_{\mathfrak{kkm}}=S_{\mathfrak{mmm}}=0$ identically and $\theta^2=\frac{(S_{\mathfrak{kkk}}q^2+3S_{\mathfrak{kmm}}p^2-2p^3+2pq^2)^2}{4p^3q(p+q)^3}$, where $S_{\mathfrak{abc}}$ is the bracket mass on the named blocks. When $\mathfrak g$ is simple with Killing constant $c$, **three invariants suffice**: the $\mathfrak m$-row gives $S_{\mathfrak{kmm}}=cq/2$, hence $S_{\mathfrak{kkk}}=c(p-q/2)$, and the display reduces exactly to $\theta^2=\frac{(cq(3p-q)-4p(p-q))^2}{16p^3q(p+q)}$. *The four-invariant form is the general one and survives where $\mathfrak g$ is not simple.*

> **FOUR HYPOTHESES ARE LOAD-BEARING AND WERE STATED IN NEITHER COPY.** *The $\Lambda^2$ metric normalisation, since $c$ scales inversely with it and $n$ appears nowhere in the formula; the extension by zero on $\mathfrak g^\perp$, without which the spectrum is $(a,b,0)$ at every proper $\mathfrak g$; $p,q\ge1$; and $\mathfrak k\perp\mathfrak m$ in the **ambient** metric, which fails for $\mathfrak{su}(2)\oplus\mathfrak{su}(2)$ in $\mathfrak{so}(12)$ at unequal multiplicities.* **And $c=2h^\vee/I_\rho$ is generic-$m$ table data that breaks at small members** (at $\mathfrak{so}(3)$ it returns $4$ against the true $c=2$), *though a metric-doubling argument rescues every $c$ value the record uses.*

**Proof:** [target.md](findings/target.md)

##### Observation L40, the surviving target, measured

Over the catalogued critical points of $\mathcal W_n$ (the symmetric-space sweep and the closure sweeps at $n=6$ and $n=8$), with diagonality decided by the kernel criterion of Lemma L37 rather than by frame inspection, the supremum of $\theta$ over non-diagonal points with $S=0$ is $\sqrt{3/2}$, attained at $W_{\mathbb{CP}^2}$ and at every zero-padding of it. Diagonal points are excluded by the criterion, $S^5\times S^7$ at $\theta=1.228239$ among them, which is why the target is stated over non-diagonal points and why diagonality rather than $S=0$ is its load-bearing hypothesis. This is a measurement over a catalogue and proves nothing about points outside it.

**Proof:** [target.md](findings/target.md)

##### Lemma L42, the sharp dual weight

Let $\lambda_P$ be a list of at least three positive eigenvalues and let $M(\lambda_P)$ be the maximum of $\sum_{\alpha<\beta<\gamma}t_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta\lambda_\gamma$ over $t\ge0$ with $\sum_{\gamma\notin\{\alpha,\beta\}}t_{\alpha\beta\gamma}\le2$ for every pair, the relaxation of the bracket tensor's pair cap that Lemma L35 uses. Then $3M(\lambda_P)\le h\,(s^2-u)$ with $h$ the harmonic mean of the three largest entries, $s=\sum\lambda$ and $u=\sum\lambda^2$, and the constant is attained, so no better weight exists for this relaxation. It bounds the relaxation, and it is the relaxation rather than $P$ that it is sharp for.

**Proof:** [stratum-two-negative.md](findings/stratum-two-negative.md)

##### Lemma L47, the dimension lemma for symmetric spaces

For a compact irreducible symmetric space of rank $\ge2$ **with $W\ne0$**, and for $\mathbb{OP}^2$, normalised to Einstein constant $\tfrac12$ so that $\lVert W\rVert^2=\lVert R\rVert^2-\frac n{8(n-1)}$ (Lemma L46), Cauchy–Schwarz gives $\dim\mathfrak h\le\frac{3n^2(n-1)}{2(7n-4)}$, and that dimension bound implies $\lVert W\rVert^2\ge\frac16$, i.e. $\theta\le\sqrt{3/2}$, each space by a nonnegative-coefficient certificate. **$W\ne0$ is load-bearing and is not Lemma L46's $\lambda\ne0$**: $S^n$ has $\lambda=\tfrac12$, $W=0$ and $\theta$ undefined. *The Cauchy–Schwarz step needs only $\mathop{\mathrm{rank}}R\le\dim\mathfrak h$ and $\mathop{\mathrm{tr}}R=n/4$, and is **sharp**, equality holds on every simple-isotropy space.* Among the irreducible spaces equality holds only at $\mathbb{CP}^2$: the two rank-one closed forms stay at or above their $m=2$ values at every $m\ge2$, proved in [problem.md](findings/problem.md) and kernel-checked. **The certificate polynomials and their family assignments are transcribed in [L47Cert.lean](lean/HamiltonsCubic/Results/L47Cert.lean), generated from the script's tables and kernel-checked.** The rank-one spaces other than $\mathbb{OP}^2$ are $\mathbb{CP}^m$ at Lemma L10, $\mathbb{HP}^m$ at Observation L5, and $S^n$ and $\mathbb{RP}^n$, where $W=0$.

**Proof:** [problem.md](findings/problem.md)

##### Lemma L48, the reducible case, and the symmetric-space theorem

For a product of $k\ge2$ factors, each Einstein with the same constant normalised to $\lambda=\tfrac12$, with $n_a\ge2$ and $n=\sum_an_a$: $R$ is block-diagonal on $\Lambda^2$ with vanishing mixed terms, so $\lVert W\rVert^2=\sum_a\lVert W_a\rVert^2+B$ with $B=\sum_af(n_a)-\frac n{8(n-1)}$ and $f(m)=\frac m{8(m-1)}$, **$B$ depending on the partition alone, which $\lVert W\rVert^2$ does not.** Convexity of $f$ puts the minimum at the balanced split at fixed $k$ and fixed $\sum n_a$; $kf(n/k)$ increases in $k$; and $\lVert W_a\rVert^2$ vanishes exactly when that factor has **constant curvature**. So at even $n$ the reducible minimum is $\frac{n^2}{8(n-1)(n-2)}=\frac1{4\theta_0(n)^2}$, and the two halves meet with no gap because $\tfrac16\ge\frac{n^2}{8(n-1)(n-2)}\iff n^2-12n+8\ge0$, **the threshold polynomial recovered rather than assumed.**

> **Theorem.** For every $n\ge12$, every compact **Einstein** **GLOBALLY** symmetric space of dimension $n$ **with $W\ne0$** satisfies $\theta\le\theta_0(n)$, with equality exactly at a **balanced product of two space forms of the same constant positive curvature**, when $n$ is even. *$\mathbb{RP}^{n/2}\times\mathbb{RP}^{n/2}$ attains it as well as $S^{n/2}\times S^{n/2}$; $W\ne0$ excludes $S^n$, $\mathbb{RP}^n$ and the flat tori, where $\theta$ is $0/0$.*

**Proof:** [problem.md](findings/problem.md)

##### Lemma L49, the collapse space, and its dimension

In an eigenframe $\{v_\alpha\}$ of $W$, with $\langle A,B\rangle=-\tfrac12\mathop{\mathrm{tr}}(AB)$ on $\mathfrak{so}(n)$ and Böhm–Wilking's $\#$, write $\theta=\sum_\alpha\lambda_\alpha^3+3\sum_{\alpha<\beta<\gamma}T_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta\lambda_\gamma$ with $T_{\alpha\beta\gamma}=\langle[v_\alpha,v_\beta],v_\gamma\rangle^2$. The condition that one $c$ give $\theta=c\sum_\alpha\lambda_\alpha^3$ for every spectrum with $\sum_\alpha\lambda_\alpha=0$, $T$ held fixed, is linear in $T$, so the collapsing configurations form a subspace, and it is exactly the $T$ constant on distinct triples, at every $N\ge3$. *Open and not consequences of this lemma: that the number of trace conditions is the number of irreducible summands of $\mathcal W_n$ under $SO(n)$; that constant $T$ is realised by no $\mathfrak{so}(n)$; and whether the cubic is spectral at a critical point, at $n\ge5$ or at $n=4$.*

**Proof:** [target.md](findings/target.md)

##### Observation L56, the named graded families have a floor; the graded set has another

For the two-block sphere products $S^p\times S^q$ at fixed $n=p+q$, the smallest modulus among the vertex entries $-q/(p-1)$, $-p/(q-1)$ and $1$ is $p/(q-1)$, which is $3/(n-4)$ at $p=3$ before normalisation, so the gap is smallest at the most unbalanced factorisation and largest at the balanced one: $0.062994$ at $S^3\times S^7$ for $n=10$ and $0.038925$ at $S^3\times S^9$ for $n=12$. Multi-block products interleave rather than extend the trend, $(S^3)^4$ at $0.0580$ sits between $S^3\times S^9$ and $S^4\times S^8$. The floor is a property of the named families at the dimensions stated; the graded set is wider than the families (Lemma L58) and its floor is a different number.

**Proof:** [ungraded-slack.md](findings/ungraded-slack.md)

##### Lemma L58, the graded set is strictly wider than the subalgebra family

A Casimir operator $W_{\mathfrak h}=c(\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id})$ with $0<r<N$ and $c\ne0$ has exactly two eigenvalues, $c(1-\tfrac rN)$ on $\mathfrak h$ and $-c\tfrac rN$ on $\mathfrak h^\perp$, both nonzero. Hence a critical point with three distinct eigenvalues or a nonzero kernel lies outside the subalgebra family of Lemma L23. The Einstein product $S^5\times S^7$ at $n=12$ is one: its Weyl part has eigenvalues $\tfrac{7\lambda}{44},\tfrac{5\lambda}{66},-\tfrac\lambda{11}$ at multiplicities $10,21,35$, Lemma L46 makes it critical with $\theta^2=\tfrac{264}{175}>\tfrac32$, and it is pair-graded. $W_{\mathbb{CP}^2}$ at $n=4$, pair-graded and critical at $\sqrt{3/2}$ with a $3$-dimensional kernel, is another. Consequently Lemma L23's cap at $\theta_0(n)$ is a statement about the family; Lemma L69 classifies the pair-graded kernel-free points at $n\ge12$ above $\sqrt{3/2}$, which is narrower than the graded case.

**Proof:** [ungraded-slack.md](findings/ungraded-slack.md)

##### Lemma L69, above $\sqrt{3/2}$ the equivariant graded points are nondegenerate sphere products, factors $\ge5$

Let $n\ge12$ and let $W$ be an equivariant graded critical point, the Weyl operator of a compact symmetric space, the correspondence proved by the invariant count in [graded-half.md](findings/graded-half.md) rather than by Lemma L8, which assumes it, with $\theta\ge\sqrt{3/2}$. Then $W$ is the Weyl tensor of a two-factor sphere product $S^p\times S^q$ with $p,q\ge5$, and every such point is Morse–Bott nondegenerate with $\lambda_{\max}(L_e\vert_{W^\perp})=\tfrac12$ attained exactly on the orbit tangent. Irreducible spaces have $\theta\le\sqrt{3/2}$ with equality only at $\mathbb{CP}^2$ (Lemma L47); for reducible ones $\lVert W\rVert^2$ depends on the partition alone with every non-sphere factor adding to it (Lemma L48), so above the threshold every factor is a sphere and $k=2$; and with $f(m)=\frac m{8(m-1)}$ the condition $\lVert W\rVert^2\le\frac16$ reads $\frac1{p-1}+\frac1{q-1}-\frac1{n-1}\le\frac13$, which fails outright at $p\le4$ for every $n$ and at $p=5$ is $n^2-7n-54\ge0$, i.e. $n\ge12$. Nondegeneracy is Lemma L27, whose gap to the next eigenvalue is $\frac1{2(M-1)}$ with $M=\max(p,q)$. At an $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ pair the $\mathrm{ad}(\mathfrak p)$-commutant in $\mathcal W_n$ is one-dimensional, so the equivariant point is the sphere product by that alone; at a $\mathfrak u(m)$ pair the unique invariant is $\mathbb{CP}^m$, which the threshold excludes. The lemma is stated in the pair-graded sense and reaches no non-equivariant graded point; the $\mathbb Z_2$-grading enumeration it quotes is complete for $n\ne8$, and $\Delta=0$ certifies equivariance only where $\ker W=0$.

**Proof:** [graded-half.md](findings/graded-half.md)

#### Direct bounds, inequalities for every $W$, and for every critical $W$

##### Lemma L13, the spectral-moment ceiling

Let $W$ be a critical point of $P$ on the unit sphere of $\mathcal W_n$ with $\theta=P(W)>0$, let $L_W\colon H\mapsto W\circ H$, and let $k_0=\dim(O(n)\cdot W)$. Then

$$\theta^2\Big(1+\frac{k_0}4\Big)\ \le\ \mathop{\mathrm{tr}}(L_W^2)\ =\ \kappa_n,\qquad \kappa_n=\frac{(n-1)(2n-1)}4 ,$$

so with $k_0\le\binom n2$ the **best output the method can conceivably give** is $\theta\le2-o(1)$, against a true value below $\sqrt2$.

> **THE CEILING IS A LIMIT ON THE METHOD, NOT A BOUND IT DELIVERS.** *A larger orbit gives a stronger bound, so at a point with a small orbit the same inequality is far weaker, padded $W_{\mathbb{CP}^2}$ at $n=12$ is a local maximum with orbit $34$, where it gives only $\theta\le2.58$.* **$\kappa_n$ is proven at even $n\ge6$ and at $n=4$, verified at odd $n\le13$, and open at odd $n\ge15$**, so the asymptotic ceiling rests on the unproven parity. *The recorded $58.9$ at $n=12$ is $(\text{bound}-\theta_0)/(\theta_0-\sqrt{3/2})$, an overshoot in units of the window Conjecture A must resolve, the multiplicative excess is $1.54\times$, and it is large because $n=12$ is the first dimension above the crossover $6+2\sqrt7$.*

**Proof:** [curvature-invariants.md](findings/curvature-invariants.md)

##### L14, WITHDRAWN as a numbered result: it states no bound

**Withdrawn.** *Gate 2, [r462](reviews/REVIEW_r462.md) and [r463](reviews/REVIEW_r463.md) on identical briefs, independently.* **The heading promised a bound and the block displays no inequality**, it names a quantity and describes progress toward bounding it, as its own text says: *"partial progress on the bound, not yet a full proof, and not sufficient alone even if finished"*. The identity behind the candidate holds in the coordinate-$2$-plane frame and is a fact about that frame rather than a tensorial one, so it does not survive rotation as stated.

**Record:** [curvature-invariants.md](findings/curvature-invariants.md)

##### Lemma L41, a $\lambda$-weighted identity, and the bound it gives

Let $W\in\mathcal W_n$ with **orthonormal** eigenbasis $\{v_\gamma\}$ and $g_\gamma=\lVert[\mathrm{ad}(v_\gamma),W]\rVert^2$. Then $\sum_\gamma g_\gamma=4(n-1)\lVert W\rVert^2$ on all of $\mathcal W_n$, critical or not, and $\sum_\gamma\lambda_\gamma g_\gamma=-4P(W)$ on all of $\mathcal W_n$. **At $\lVert W\rVert=1$**, with $\Delta$ the $g$-mass on the strictly positive eigenspace and $G_0$ the mass on $\ker W$, $\theta\le\lvert\lambda_{\min}\rvert\cdot\frac{4(n-1)-\Delta-G_0}4$, **with equality exactly when $g$ is supported on $E_{\lambda_{\min}}\oplus\ker W$.**

> **THE UNIT-NORM HYPOTHESIS IS LOAD-BEARING AND WAS ABSENT FROM EVERY COPY.** *Both identities are scale-covariant and were written scale-invariant; the bound is worse, its bracket mixing degree $0$ with degree $2$, so it **changes sign** off the sphere, at $2\times$ padded $W_{\mathbb{CP}^2}$ in $\mathcal W_{12}$ it asserts $\theta\le-17.1$.* **[conventions.md](findings/conventions.md) already carried both identities correctly.** *The equality clause was [L107](findings/bounds.md)'s, copied onto a sharper bound: the kernel is unconstrained because $G_0$ is already subtracted, and padded $W_{\mathbb{CP}^2}$ attains equality with $G_0=4(n-4)$.* **And this equality case is NOT [L70](findings/bounds.md)'s in other coordinates**, L41 saturates on all of L23's subalgebra family where L70 separates within it, so citing the two together double-counts.

**Proof:** [target.md](findings/target.md)

##### Lemma L55, the min-entry bound, sharp for even $n$

Let $n\ge3$ and let $K$ be a hollow $n\times n$ matrix with zero row sums and $\lVert K\rVert_F^2=t$, a sum over ordered pairs. Then $\lvert\min_{a\ne b}K_{ab}\rvert\ge\sqrt{t/(n(n-1)(n-2))}$: in the row achieving the minimal entry $-m$ each off-diagonal entry $x$ lies in $[-m,(n-2)m]$, so $x^2\le(n-3)mx+(n-2)m^2$, and summing with the zero row sum gives $(n-1)(n-2)m^2$ per row. If $K$ is also symmetric and $t>0$, equality forces every entry to $-m$ or $(n-2)m$ with exactly one large entry per row, and symmetry pairs the rows into a fixed-point-free involution, so the extremizers are exactly the perfect matchings with $c>0$, existing exactly at even $n$; at odd $n$ and $t>0$ the bound is strict, and $K=0$ attains it at every $n$. The lemma is about hollow zero-row-sum matrices and holds on and off the diagonal locus alike.

**Proof:** [diagonal-half.md](findings/diagonal-half.md)

##### Lemma L70, the deficiency identity, and what saturates it

Let $W\in\mathcal W_n$ be a critical point **with $\lVert W\rVert=1$** (the identity holds at one scale only, its two sides being homogeneous of different degrees) so $\lambda_{\min}<0<\lambda_{\max}$ by $\mathop{\mathrm{tr}}W=0$ at $W\ne0$; *the sign of $D$ needs only $\lambda_{\min}\le0\le\lambda_{\max}$, and the strict form is what the equality characterisation needs*, and let $v$ be a unit vector in the $\lambda_{\min}$ eigenspace with structure constants $c_{vab}=\langle[v,v_a],v_b\rangle$, whose row mass is $\sum_{a,b}c_{vab}^2=2(n-2)$ by **[Lemma L153](findings/bounds.md)**, applied at the non-basis vector $v$. Then $\theta=\lambda_{\min}+(n-2)\lambda_{\max}-D(v)/\lvert\lambda_{\min}\rvert$ with $D(v)=\tfrac12\sum_{a,b}(\lambda_a\lambda_b-\lambda_{\min}\lambda_{\max})c_{vab}^2\ge0$, each summand a nonnegative weight against a nonnegative factor. The bound $\theta\le\lambda_{\min}+(n-2)\lambda_{\max}$ is one step of this identity, and equality holds exactly when $\mathrm{ad}(v)$ is supported on $E_{\min}\otimes E_{\max}$ for every unit $v\in E_{\min}$. **The excluded-index effect reaches this identity only when $\dim E_{\min}=1$**: the claim that $\lambda_{\min}\lambda_{\max}$ is attained only on pairs containing the row index is false whenever $\dim E_{\min}\ge2$, where a second $E_{\min}$ index pairs with an $E_{\max}$ one inside the support. So the boxed form is the weakened member of a per-row family whose sharp member subtracts the minimum of $\lambda_a\lambda_b$ over the support. **The two coincide at every saturating point**, not as a survey of the record but as a theorem: **saturation forces $\dim E_{\min}\ge n/2$**, from the pair cap and the Killing marginal alone. The equality case and the $g_\gamma$ cap of Lemma L41 are one result in two coordinate systems. On the two-eigenvalue family of Lemma L23 saturation is exactly the condition that $(\mathfrak{so}(n),\mathfrak h)$ be a symmetric pair. At a critical point $D$ is a function of $(\theta,\lambda_{\min},\lambda_{\max})$, so the identity rearranges the target rather than bounding it.

**Proof:** [bounds.md](findings/bounds.md)

##### Lemma L111, criticality in bracket coordinates, and the bracket form is strictly weaker

Let $W\in\mathcal W_n$, $n\ge4$, with an orthonormal eigenbasis $\{\varphi_k\}$ on $\Lambda^2$ and $M_{kl}=\mathop{\mathrm{tr}}(\mathrm{ad}(\varphi_k)W\,\mathrm{ad}(\varphi_l)W)$. Then $M=-2W^\#$, so $Q(W)=\theta W$ if and only if $M_{kl}=2\lambda_k(\lambda_k-\theta)\delta_{kl}$. The bracket form $\sum_{\alpha\beta}\lambda_\alpha\lambda_\beta c_{k\alpha\beta}c_{l\alpha\beta}=0$ for $\lambda_k\ne\lambda_l$ is $[W,Q(W)]=0$, implied by criticality and strictly weaker: the coordinate-diagonal $W$ with $w_{12}=w_{34}=1$, $w_{13}=w_{24}=-1$, $w_{14}=w_{23}=0$ satisfies it and is critical for no $\theta$.

**Proof:** [bounds.md](findings/bounds.md)

##### Lemma L113, moment inequalities in the $g$-distribution give nothing sharper than Lemma L107

Let $\lVert W\rVert=1$ and $g_k=\lVert[\mathrm{ad}(v_k),W]\rVert^2$ with moments $m_j=\sum_k\lambda_k^jg_k$. Every conclusion about $(\lambda,\theta)$ drawn from inequalities in the moments that hold for every nonnegative $g$ supported on the spectrum, with $m_0=4(n-1)$, $m_1=-4\theta$ and every free moment eliminated, follows from $\lambda_{\min}m_0\le m_1\le\lambda_{\max}m_0$, since a two-atom $g$ realises every pair of first moments satisfying it. At $\theta\ge0$ that is Lemma L107, and Cauchy–Schwarz with the support bound $m_2\le(\lambda_{\min}+\lambda_{\max})m_1-\lambda_{\min}\lambda_{\max}m_0$ attains it. Lemma L109's cap, from (A) and $T\ge0$, is a further constraint and excludes equality when $\lambda_{\min}$ is simple.

**Proof:** [bounds.md](findings/bounds.md)

##### Lemma L115, $\theta>\max_\alpha\lambda_\alpha$ at every global maximiser, and $\lambda_{\max}(M)=\theta$ on the coordinate-diagonal locus

Let $W\in\mathcal W_n$, $n\ge4$, be a unit Weyl tensor with spectrum $\lambda$ and $M=M(\lambda)$ its Rayleigh matrix in an orthonormal eigenbasis. At every global maximiser $\theta-\lambda_\alpha\ge\sqrt{3/2}-1$. If $W$ is a coordinate-diagonal global maximiser and $M$ is formed in the coordinate frame, $\lambda_{\max}(M)=\theta$, since the coordinate-diagonal operators split into a Weyl part, capped at $\theta$ by Lemma L24, and a complement $\{u_i+u_j\}$ capped by $\tfrac12\lambda_{\max}(\Lambda)<1/\sqrt2$, with no cross term. The same equality holds at every $S^m\times S^m$, $m\ge2$, in its coordinate frame, with no maximality assumed. At every global maximiser the equality is open: it needs a cap at level $\theta$ on the part of $\mathcal D$ orthogonal to $\mathcal W_n$, and $M$ depends on the eigenbasis at repeated eigenvalues.

**Proof:** [bounds-relaxations.md](findings/bounds-relaxations.md)

##### Lemma L71, saturation forces the balanced sphere product, unconditionally for $n\ge5$

Let $W$ be a critical point of $\mathcal W_n$ **at unit norm**, $n\ge5$, with $\lambda_{\min}<0<\lambda_{\max}$, at which Lemma L70 holds with equality, the scalar condition $\theta=\lambda_{\min}+(n-2)\lambda_{\max}$. Write $\mathfrak m=E_{\min}$, $\mathfrak h=E_{\max}$ and $\mathfrak r$ for the remaining eigenspaces, kernel included. The equality case reads $[\mathfrak m,\mathfrak m]\subseteq\mathfrak h$, $[\mathfrak m,\mathfrak h]\subseteq\mathfrak m$, $[\mathfrak m,\mathfrak r]=0$; then $\mathfrak g'=\mathfrak m+[\mathfrak m,\mathfrak m]$ is a subalgebra normalised by $\mathfrak h$ and centralised by $\mathfrak r$, hence an ideal of the simple $\mathfrak{so}(n)$, hence all of it. So $\mathfrak r=0$, $\mathfrak h=[\mathfrak m,\mathfrak m]$, $(\mathfrak{so}(n),\mathfrak h)$ is a symmetric pair, $W$ has exactly two eigenvalues, and with $\dim\mathfrak h=n(n-2)/4$ the pair is $\mathfrak{so}(n/2)\oplus\mathfrak{so}(n/2)$ by Cartan's classification, $\dim(\mathfrak{so}(\tfrac n2+t)\oplus\mathfrak{so}(\tfrac n2-t))=\tfrac{n^2}4+t^2-\tfrac n2$ forces $t=0$, $\mathfrak u(n/2)$ has the wrong dimension, and at $n=8$ the balanced involution is fixed by triality, **its determinant is $+1$, so $\mathrm{Ad}(\mathrm{diag}(-1_4,1_4))$ is inner and Cartan's classification up to $\mathrm{Aut}$ already delivers $SO(8)$-conjugacy**, and its weight pattern $(1^4,(-1)^4)$ agrees on $V$, $S^+$ and $S^-$. *Dimension does not decide this: triality carries $S^3\times S^5$ to a point of the same isotropy dimension in a different $O(8)$-class.* Hence $W$ is the Weyl tensor of $S^{n/2}\times S^{n/2}$, $\theta=\theta_0(n)$, and no critical point saturates at odd $n\ge5$. The converse holds: if $D(v)=0$ at a critical unit $W$ then $\lambda_{\max}=n\lvert\lambda_{\min}\rvert/(n-2)$ and $\theta=(n-1)\lvert\lambda_{\min}\rvert\ge\theta_0(n)$, with equality for $n\ge5$. At $n=4$, where $\mathfrak{so}(4)$ is not simple, the critical points are $\pm S^2\times S^2$ and $\pm W_{\mathbb{CP}^2}$ up to $O(4)$ and the saturating ones are $S^2\times S^2$ and $W_{\mathbb{CP}^2}$. Since the hypothesis is checkable from $(\lambda,\theta)$ alone, the lemma classifies saturating points and serves as no step of a proof of the conjecture.

> **THE TWO-EIGENVALUE CONCLUSION IS DERIVED AND THE FINAL IDENTIFICATION IS NOT.** *The ideal argument removes the hypothesis: nothing upstream of $\mathfrak r=0$ consumes it, so the spectrum's length is a conclusion.* **What is asserted without argument is the last clause**, that $W$ is the sphere product's Weyl tensor. *The grading is pinned and the two eigenvalues are in the ratio $(n-2)\lambda_{\max}=n\lvert\lambda_{\min}\rvert$, which determines $W$ as an operator; the sentence matching that to the sphere product is what is missing.* **The $n=8$ uniqueness rests on the weight route alone**, the determinant route printed beside it is a non-sequitur, $\mathrm{diag}(-1_2,1_6)$ and an orthogonal complex structure being both inner with $\det=+1$ and not $O(8)$-conjugate. *Cartan reaches $SO(n)$-conjugacy at $n\ne8$ through $\mathrm{Aut}(\mathfrak{so}(n))=\mathrm{Ad}(O(n))$, which the record consumed everywhere and stated nowhere.*

**Proof:** [bounds.md](findings/bounds.md)

##### Lemma L73, a spectral necessary condition on all of $\mathcal W_n$

For every $W\in\mathcal W_n$, $\lambda_{\max}(W)\le(n-2)\lvert\lambda_{\min}(W)\rvert$ and, by $W\mapsto-W$, $\lvert\lambda_{\min}\rvert\le(n-2)\lambda_{\max}$; the condition needs Ricci-flatness and first Bianchi only, and criticality nowhere. It is attained at $S^2\times S^{n-2}$ for every $n$ and at $\mathbb{CP}^m$ and the maximal tori $\mathfrak{so}(2)^{n/2}$ at even $n$, and it strengthens to $\lambda_{\max}\le-\tfrac{n-2}2(\lambda_{(1)}+\lambda_{(2)})$ with $\lambda_{(1)}\le\lambda_{(2)}$ the two smallest eigenvalues. Lemma L70 is the $\lambda_{\min}$ row and this bound the $\lambda_{\max}$ row of one pinned system, read at two rows; the two together bound the pinned relaxation and at $n=6$ that relaxation overshoots $\theta_0$, so neither row separates on its own.

**Proof:** [bounds.md](findings/bounds.md)

##### Lemma L74, $\theta$ in closed form for every strongly regular graph

Let $\Gamma$ be strongly regular with parameters $(v,k,\lambda,\mu)$ and let $M=aA+b(J-I-A)$ be the two-eigenvalue hollow zero-row-sum matrix constant on edges and non-edges, with $b=-ak/(v-1-k)$ and $a$ fixed by unit norm. Then the diagonal criticality equation $(M\circ M)+M^2=\theta M$ (Deninger–Grundhöfer–Kramer's equation with no conversion factor), reduces to one scalar condition, $k(k-\lambda-1)=(v-k-1)\mu$, which is the strongly regular graph identity; so every strongly regular graph is a critical point of the diagonal locus at $n=v$, and $\theta/\lVert W\rVert=\frac{(v-1)^2\lambda+2k(v-1)-k^2v+w^2}{w^2}\cdot\sqrt{\frac{2w}{vk(v-1)}}$ with $w=v-1-k$. Criticality is odd in $M$, so $\pm M$ are both critical with $\theta\mapsto-\theta$, and the eigenvalue ratio $\lambda_{\max}/\lvert\lambda_{\min}\rvert$ is $w/k$ on one branch and $k/w$ on the other. Saturation of Lemma L70 requires that ratio to equal $v/(v-2)$, which under the graph identity leaves exactly $\mathrm{SRG}(2m,m,0,m)=K_{m,m}$ and its complement $\mathrm{SRG}(2m,m-1,m-2,0)=2K_m$, the two sign branches of one point, the balanced sphere product $S^m\times S^m$, where the closed form returns $\theta_0(2m)$. Every conference graph, the pentagon and the Petersen graph among them, has $\theta=0$ exactly; the octahedron $\mathrm{SRG}(6,4,2,4)$ is the $n=6$ maximal torus in eigenvalues, multiplicities and eigenvectors. The family lives on the diagonal locus and says nothing directly about non-diagonal points; it is the object route R15 works.

**Proof:** [diagonal-half.md](findings/diagonal-half.md)

##### Lemma L59, the certificate's linear condition, $F_5\perp\mathrm{ANN}$, and when a count decides it

For an inner product on the $14$-dimensional space $V$ of $O(5)$-invariant sextics on $\mathcal W_5$, a linear map $\mu_K$ into $V$ and its adjoint $\mathrm{Cat}$, $\ker\mathrm{Cat}=\mathrm{image}(\mu_K)^\perp$, so with $\mathrm{ANN}=\ker\mathrm{Cat}$, $\mathrm{rank}(\mu_K)=14-\dim\mathrm{ANN}$ and $F_5\in\mathrm{image}(\mu_K)\iff F_5\perp\mathrm{ANN}$; the dimension count decides the condition only when $\dim\mathrm{ANN}=0$. Over Lemma L83's multiplicities the $65$ invariant symmetric forms split as $36$ supported on the orbit-constrained span $K$ and $29$ killing $K\times K$, an identity that holds block by block for any multiplicities. Owed: the concrete pairing and $\mu$, the identification of $\mathrm{ANN}$ with the invariant sextics $F$ satisfying $\mathrm{Cat}_F(K,K)=0$ (an equivariance and averaging step), surjectivity of the unrestricted $\mu$, and the reduction from a positive semidefinite certificate to $F_5\in\mathrm{image}(\mu_K)$. Lemma L62 consumes the abstract form.

**Proof:** [sym3-blocks.md](findings/sym3-blocks.md)

##### Lemma L61, $M(5)=\sqrt{3/2}$, the global maximum on $\mathcal W_5$

On $\mathcal W_5$ the sextic $F_5=\tfrac32\lVert W\rVert^6-9\mathop{\mathrm{tr}}(W^3)^2$ is a sum of squares of cubic forms, each vanishing on the $O(5)$-orbit of $W_0$, the zero-padding of $W_{\mathbb{CP}^2}$, with an exact rational certificate. Since $\langle W,W^\#\rangle=2\mathop{\mathrm{tr}}(W^3)$ on $\mathcal W_5$ (the cubic collapses to one spectrum, Lemma L50), $P(W)=3\mathop{\mathrm{tr}}(W^3)$ there and the certificate gives $\lvert\theta\rvert\le\sqrt{3/2}$ for every unit $W\in\mathcal W_5$, with equality on the orbit of $W_0$; the equality set is not identified. The bound is on the whole sphere, and it is the one dimension at which the programme holds a complete certificate; the corresponding object at $n=12$ is the block table of Lemma L63.

**Proof:** [sym3-blocks.md](findings/sym3-blocks.md)

##### Lemma L62, $\dim\mathrm{ANN}=1$, so the rank is $13$

In the setting of Lemma L59, evaluation at $W_0$ is a nonzero functional on the $14$ invariant sextics and every product of two cubics of $K$ vanishes there, so the restricted rank is at most $13$. A rank read off finitely many evaluation points bounds the true rank from below, and reduction modulo a prime can only lower it further --- the sample points being exact rationals fixed before any prime is chosen, so the matrix reduced is the reduction of a rational one --- and a sampled rank equal to $13$ therefore forces equality; it equals $13$ at four primes, and exactly over $\mathbb Q$. Hence $\dim\mathrm{ANN}=1$, spanned by $A(W_0^6)$, and $F_5\perp\mathrm{ANN}$, which is the necessary condition of Lemma L59 met. The argument is exact, the sampling being a lower bound rather than a numerical estimate.

**Proof:** [sym3-blocks.md](findings/sym3-blocks.md)

##### Lemma L63, the $n=12$ block table

**Lemma.** $\dim\mathcal W_{12}=1638$, from $\dim\mathcal W_n=\tfrac1{12}n(n+1)(n+2)(n-3)$, and $\dim\mathrm{Sym}^3\mathcal W_{12}=\binom{1640}3=733\,813\,080$; Weyl's dimension formula gives $1638$ at the $D_6$ weight $(2,2,0,0,0,0)$, whose identification with $\mathcal W_{12}$ is classical and unsourced on the record. **Observation at $n=12$**, from a decomposition run: $\mathrm{Sym}^3(\mathcal W_{12})$ carries $77$ $SO(12)$-constituents with total multiplicity $191$, twelve chiral in six pairs with $\lambda_6\ne0$ at multiplicities $2,1,1,1,1,1$; given that, and that no non-chiral constituent occurs as both $[\lambda]$ and $[\lambda]\otimes\det$, $O(12)$ sees $71$ blocks with $184$ multiplicities. The table is the size of the certificate problem at the threshold dimension; it supplies the unknowns and no certificate.

**Proof:** [sym3-stability.md](findings/sym3-stability.md)

##### Lemma L64, the transfer mechanism

Fix $d\ge1$, and let $k_B(d)$ be the presentation degree of the module $\{\mathrm{Sym}^d\mathcal W_n^*\}$ over the base $\{\mathbb R^n\}$ with the signed permutation groups $\{B_n\}$, zero-padding giving the embeddings. Let $F$ be an $O(n_0)$-invariant form of degree $d$ on $\mathcal W_{n_0}$. Then for every $n\ge n_0$, $F$ has an $O(n)$-invariant extension to $\mathcal W_n$, and when $n\ge n_0\ge k_B(d)$ it is the unique $B_n$-invariant extension. With $SO$ in place of $O$, uniqueness holds as stated and existence holds when $n_0$ is odd or $n_0\ge4d$, failing at $n_0=4$, $d=2$. The first fundamental theorem writes $F$ as a combination of complete contractions, each of which restricts correctly under padding because every slot sits on a Weyl factor, and Proposition 2.9 gives uniqueness. **No value of $k_B(d)$ is known**: it is finite, and $k_B(d)\ge4d$, so $k_B(6)\ge24$ and the lemma does not reach the degree-$6$ certificate at $n_0=12$. **The extension carries an element and its invariance, and a sign only on the padded copy**, so transferring a nonnegativity certificate needs an argument of its own.

**Proof:** [fence-posts.md](findings/fence-posts.md)

##### Lemma L65, the seed is the inclusion padded by cups

For $n\ge1$ and a block label $\lambda$, $O(n)$-admissible with $\lvert\lambda\rvert\in\{0,2,\dots,12\}$, write $k=(12-\lvert\lambda\rvert)/2$, let $\iota_\lambda\colon V_\lambda\hookrightarrow V^{\otimes\lvert\lambda\rvert}$ be the inclusion of the irreducible into the tensor power, and let $\mathrm{cup}=\sum_ae_a\otimes e_a$ be the invariant metric element. Then the seed $c_0=\iota_\lambda\otimes\mathrm{cup}^{\otimes k}$ is a nonzero element of $\mathop{\mathrm{Hom}}_{O(n)}(V_\lambda,V^{\otimes12})$: $\mathrm{cup}$ is $O(n)$-invariant, and a tensor product of nonzero vectors is nonzero. The seed is $\iota_\lambda$ followed by a padding diagram of $k$ cups, and at $\lvert\lambda\rvert=12$ it is $\iota_\lambda$ itself. Admissibility makes $V_\lambda$ nonzero and holds whenever $\lvert\lambda\rvert\le n$, since $\lambda'_1+\lambda'_2\le\lvert\lambda\rvert$. The lemma removes a search from the certificate pipeline and adds no certificate.

**Proof:** [brauer-pairing.md](findings/brauer-pairing.md)

##### Lemma L194, a rank-three Weyl tensor's three image forms have equal squares and equal self-wedges

Let $W=\sum_{i=1}^3\lambda_i\,\omega_i\otimes\omega_i\in\mathcal W_n$ with the $\omega_i$ orthonormal and every $\lambda_i\ne0$. Then $\Phi(\omega_1)=\Phi(\omega_2)=\Phi(\omega_3)$, so [L183](#lemma-l183-a-rank-three-weyl-tensor-is-a-triple-whose-phi-images-coincide-or-are-distinct-and-collinear)'s distinct-and-collinear branch is empty at every $n$. The reason is that $\Phi$ sends the unit sphere of $\Lambda^2$ into a sphere, by $\mathop{\mathrm{tr}}(\omega^4)+\lVert\omega\wedge\omega\rVert_\perp^2=2\langle\omega,\omega\rangle^2$ in the multi-index-orthonormal norm on $\Lambda^4$, and a line meets a sphere in at most two points. Jointness of the collinearity is the one hypothesis this cannot lose.

**Proof:** [diagonal-half.md](findings/diagonal-half.md)

##### Lemma L195, a common square with two distinct eigenvalues forces two forms equal up to sign

Let $\omega_1,\omega_2$ be $2$-forms with $\omega_1^2=\omega_2^2=-A$ for $A$ positive definite, and $\omega_1\wedge\omega_1=\omega_2\wedge\omega_2$. If $A$ has at least two distinct eigenvalues then $\omega_2=\pm\omega_1$. No dimension hypothesis, no Weyl hypothesis and no orthogonality: the wedge's cross term on a pair of eigenspaces is a rank-one tensor, which determines its factors up to reciprocal scalars, and complex structures having fixed norm pins those to one sign. It subsumes two of [L184](#lemma-l184-no-orthonormal-triple-with-a-common-six-dimensional-support-has-both-coincidences)'s three cases.

**Proof:** [diagonal-half.md](findings/diagonal-half.md)

##### Lemma L196, two complex structures sharing a self-wedge agree up to sign above four dimensions

Let $J_1,J_2$ be orthogonal complex structures on $\mathbb R^{2m}$ with $\omega_1\wedge\omega_1=\omega_2\wedge\omega_2$. Then $J_2=\pm J_1$ at every $m\ge3$. Equal self-wedges is $\alpha\wedge\beta=0$ at $\alpha=\omega_1-\omega_2$, $\beta=\omega_1+\omega_2$; hard Lefschetz on a symplectic vector space, which needs only nondegeneracy, makes $\Lambda^2\to\Lambda^4$ injective at $m\ge3$; and both factors degenerate at once is impossible because $\alpha$ annihilates $\ker(T-I)$ and $\beta$ annihilates $\ker(T+I)$ at $T=-J_1J_2$. At $m=2$ the Lefschetz map has a five-dimensional kernel, which is where the equality case lives.

**Proof:** [diagonal-half.md](findings/diagonal-half.md)

#### Theorem, the $\Lambda^2$-rank-$\le3$ family, closed

*Every $W\in\mathcal W_n$ whose operator on $\Lambda^2$ has rank at most three satisfies $\theta(W)\le\sqrt{3/2}$, with equality exactly at padded $W_{\mathbb{CP}^2}$ up to positive scale and an $O(n)$ frame change.*

**Proof:** [diagonal-half.md](findings/diagonal-half.md)
**Why it matters, and what it does not do.** *The bound is ATTAINED on this family, so it is the sharpest test the conjecture has and a single member above $\sqrt{3/2}$ would refute Conjecture A outright.* **It does not advance the main line**: it bounds nothing outside the family, and the reduction from general rank is [I68](plan.md), which has no proof. *Read its value as a falsifier hunt survived.*

**Proof.** *Rank one is impossible, trace-freeness forcing the single eigenvalue to vanish. At rank three, [Lemma L183](findings/diagonal-half.md) makes criticality a statement about $\Phi(\omega)=(\omega^2,\omega\wedge\omega)$ at the three image forms, and [Lemma L194](findings/diagonal-half.md) empties its distinct branch at every $n$, so the three images coincide. [Lemma L195](findings/diagonal-half.md) then forces the common square to be $c\,\mathrm{Id}$ and [Lemma L196](findings/diagonal-half.md) forces two of the forms equal up to sign above four dimensions, against orthogonality.* **At rank two, trace-freeness makes both Weyl conditions coincidences and nothing else**, so the same two lemmas apply. *So the support is four-dimensional, and [Lemma L178](findings/diagonal-half.md) caps $\theta$ there with the stated equality case.*

**Audit.** *L194, L195 and L196 each passed Gate 2 on 2026-09-10, on identical briefs: [r832](reviews/REVIEW_r832.md) and [r833](reviews/REVIEW_r833.md), [r834](reviews/REVIEW_r834.md) and [r835](reviews/REVIEW_r835.md), [r836](reviews/REVIEW_r836.md) and [r837](reviews/REVIEW_r837.md).* **The rank-two trace composing them is the author's and is UNAUDITED.**

##### Lemma L178, Rank at most three on a four-dimensional support caps $\theta$ at $\sqrt{3/2}$

*Let $W\in\mathcal W_n$ be nonzero, supported on $\Lambda^2V$ for a four-dimensional $V\subseteq\mathbb R^n$, with $\mathop{\mathrm{rank}}(W:\Lambda^2\to\Lambda^2)\le3$. Then $\theta(W)\le\sqrt{3/2}$, with equality exactly when $W$ is $W_{\mathbb{CP}^2}$ up to POSITIVE scale and an $O(n)$ frame change.* **The frame group is $O(n)$ and not $SO(n)$**, so that the anti-self-dual mirror is reached. *On $\Lambda^2V$ the operator splits as $W^+\oplus W^-$ with each summand trace-free on a three-dimensional space, so each has rank $0$, $2$ or $3$ and never $1$; a total rank of at most three forces one summand to vanish.* **The four-dimensional support is ASSUMED and not proved here**, that it always holds is [the rank-three theorem](#theorem-the-lambda2-rank-le3-family-closed).

**Proof:** [diagonal-half.md](findings/diagonal-half.md)
##### Lemma L181, Ricci-flatness and first Bianchi are the diagonal and the off-diagonal of one matrix

*The two conditions are the diagonal and the off-diagonal parts of $M^{\mathsf T}\Lambda M$ for the matrix $M$ of the eigenforms against a splitting into planes.* **So a Weyl tensor whose eigenforms are simultaneously block-diagonal for one common splitting does not exist**, the two halves of a single matrix equation being unsatisfiable together. *This is what closes the $\mathfrak t^3$ stabiliser case of the rank-three census.*

**Proof:** [diagonal-half.md](findings/diagonal-half.md)
##### Lemma L183, A rank-three Weyl tensor is a triple whose $\Phi$-images coincide or are distinct and collinear

*Define $\Phi:\Lambda^2\mathbb R^n\to S^2(\mathbb R^n)\oplus\Lambda^4\mathbb R^n$ by $\Phi(\omega)=(\omega^2,\ \omega\wedge\omega)$. Then $W=\sum_{i=1}^3\lambda_i\,\omega_i\otimes\omega_i$ with the $\omega_i$ orthonormal and every $\lambda_i\ne0$ lies in $\mathcal W_n$ IF AND ONLY IF the three points $\Phi(\omega_i)$ either all coincide or are distinct and collinear*, **collinear JOINTLY in the direct sum**, which is strictly stronger than collinear in each factor. *Bare collinearity is not enough: exactly-two-coincident is collinear and is exactly the configuration the criterion must exclude, and it never occurs for a genuine rank-three Weyl tensor.* **Mutual orthogonality is unused; equal nonzero norms are consumed**, tracelessness being Ricci's trace only because $\mathop{\mathrm{tr}}(\omega_i^2)=-2$.

**Proof:** [diagonal-half.md](findings/diagonal-half.md)
##### Lemma L184, No orthonormal triple with a common six-dimensional support has both coincidences

*No Weyl hypothesis enters anywhere: the statement is that three orthonormal $2$-forms on a six-dimensional $V$ cannot have both their squares and their self-wedges coincident.* **The coincident case of [L183](#lemma-l183-a-rank-three-weyl-tensor-is-a-triple-whose-phi-images-coincide-or-are-distinct-and-collinear) at $\dim V=6$ being empty is the corollary.** *Three separable cases, set by how many of the common square's eigenvalues agree, and each closes on its own. Audited four times.*

**Proof:** [diagonal-half.md](findings/diagonal-half.md)
##### Lemma L185, No rank-three Weyl tensor has three decomposable image forms

*Ricci-flatness alone empties the branch at EVERY width: $\sum_i\lambda_i\Pi_i=0$ at unit decomposable forms forces the three planes to coincide, and three orthonormal forms do not fit in the one-dimensional $\Lambda^2P$.* **The record previously had this branch as bounded at six with non-orthogonal planes**, which excluded orthogonality rather than the branch.

**Proof:** [diagonal-half.md](findings/diagonal-half.md)
##### Lemma L186, No rank-three Weyl tensor has exactly one non-decomposable image form

*First Bianchi collapses the case.* **Confirmed and VACUOUS**: the configuration it excludes cannot arise for a second and independent reason, so the lemma is true and carries no weight the census does not already have.

**Proof:** [diagonal-half.md](findings/diagonal-half.md)
##### Lemma L189, A rank-three Weyl tensor has three non-decomposable image forms

*The two-non-decomposable case is empty at every dimension.* **So with [L185](#lemma-l185-no-rank-three-weyl-tensor-has-three-decomposable-image-forms) and [L186](#lemma-l186-no-rank-three-weyl-tensor-has-exactly-one-non-decomposable-image-form) the image-form census closes**, and only the all-non-decomposable branch survives. *A non-decomposable form has support of dimension at least four on its own, which is what sets the width question the rest of the strand answers.*

**Proof:** [diagonal-half.md](findings/diagonal-half.md)
##### Lemma L190, The surviving rank-three case is inhabited at $\dim V=4$

*A five-parameter family of witnesses at four dimensions, with the Minkowski determinant inequality saturated at padded $W_{\mathbb{CP}^2}$.* **So the surviving branch is not empty and the question is whether it reaches above four**, which is what the rest of the strand settles. *The cross term is six-dimensional only, and the determinant route dies at $\dim V=4$ on the Ricci leg.*

**Proof:** [diagonal-half.md](findings/diagonal-half.md)
##### Lemma L191, Two forms with a common six-dimensional support and both coincidences are equal up to sign

*A rigidity statement rather than an emptiness one: $\omega_2=\pm\omega_1$.* **It closes the rank-two branch at $\dim V=6$**, orthogonality being violated. *Its proof is [L184](#lemma-l184-no-orthonormal-triple-with-a-common-six-dimensional-support-has-both-coincidences)'s three cases run on pairs, so the two are not independent confirmations of one another.*

**Proof:** [diagonal-half.md](findings/diagonal-half.md)
##### Lemma L192, The Bianchi defect is the weighted Laplacian of the Pfaffian, in every even dimension

*At $\dim V=2m$, with $L=\sum_i\lambda_i\,\partial^2/\partial x_i^2$,* $$L[\mathrm{Pf}(w)]=\tfrac1{(m-2)!}\star\big[\mathcal B\wedge w^{m-2}\big],$$ *so the first-Bianchi defect $\mathcal B$ is recovered from a second-order operator applied to the Pfaffian.* **It holds in every even dimension** and not only at six, which the block's own account of its scope understated.

**Proof:** [diagonal-half.md](findings/diagonal-half.md)
##### Lemma L201, integrality of the pairwise plane traces forces a common frame

Let $\{\omega_\alpha\}$ be an orthonormal basis of $\Lambda^2\mathbb R^n$, $n\ge3$, every element decomposable, with $P_\alpha$ the plane of $\omega_\alpha$ and $\Pi_\alpha$ the orthogonal projection onto it. If $\mathop{\mathrm{tr}}(\Pi_\alpha\Pi_\beta)\in\{0,1\}$ at every pair $\alpha\ne\beta$, meaning every two planes either share a line or are mutually orthogonal, then some orthonormal frame of $\mathbb R^n$ has the $P_\alpha$ as exactly its coordinate $2$-planes. **Equivalently, through the bridge $\lVert[\omega_\alpha,\omega_\beta]\rVert^2=\mathop{\mathrm{tr}}(\Pi_\alpha\Pi_\beta)$ for $\Lambda^2$-orthogonal decomposable unit forms**: an orthonormal basis of $\mathfrak{so}(n)$ by rank-two elements whose pairwise brackets are each either zero or of unit norm is $\{\varphi_{ab}\}$ in some frame, up to signs.

**One identity carries it**: in principal position $\Pi_\alpha\Pi_\beta=\cos\vartheta_1\,uu'^{\mathsf T}$, so $\mathop{\mathrm{tr}}([\Pi_\alpha,\Pi_\beta]^{\mathsf T}[\Pi_\alpha,\Pi_\beta])=2S_{\alpha\beta}(1-S_{\alpha\beta})$ at $S_{\alpha\beta}=\mathop{\mathrm{tr}}(\Pi_\alpha\Pi_\beta)$, the norm being the PLAIN Frobenius trace, which the factor $2$ requires. So integrality at every DISTINCT pair says the projections commute pairwise, and simultaneous diagonalisation gives the frame, the words "exactly its coordinate planes" needing one line more: distinct planes because $\Lambda^2P$ is a line and the forms are orthonormal, then the count $\binom n2$. Two further identities place it. $\sum_\alpha\Pi_\alpha=(n-1)\mathrm{Id}$ gives $\sum_{\beta\ne\alpha}\mathop{\mathrm{tr}}(\Pi_\alpha\Pi_\beta)=2(n-2)$ at every $\alpha$, which is [Lemma L153](findings/bounds.md)'s row marginal composed with the bridge, and $\Lambda^2$-orthogonality forces one principal angle to be right, so the trace is $\cos^2$ of the other and lies in $[0,1]$. **Hence $\Xi=\lVert\sum_\alpha\Pi_\alpha\otimes\Pi_\alpha\rVert^2\le n^2(n-1)$ with equality exactly at the coordinate configurations**, and coordinate-diagonality of a $W$ carrying such an eigenbasis is $\sup\Xi=n^2(n-1)$ over reselections inside the eigenspaces, with no existential at all once the spectrum is simple. *That last branch is empty at $n=4$, where a coordinate-diagonal Ricci-flat $W$ has spectrum $a,a,b,b,c,c$, and non-empty from $n=5$.* **The theorem itself names no eigenvalue, so it is blind to $\ker W$ and needs no Weyl hypothesis, no Ricci-flatness and no criticality.**

**Proof:** [diagonal-half.md](findings/diagonal-half.md)

##### Lemma L199, the orbit-tangent form is $4(W^2\#I)-4W^\#$

Let $W$ be any symmetric operator on $\Lambda^2\mathbb R^n$ and $G_W$ the symmetric operator with $\langle G_Wx,x\rangle=\lVert[\mathrm{ad}(x),W]\rVert^2$, whose diagonal in an eigenbasis of $W$ is the record's $g_k$. Then $G_W=4(W^2\#I)-4(W\#W)$, with no hypothesis of any kind: not first Bianchi, not Ricci-flatness, not criticality, not a dimension restriction. Composing with Lemma L131's $\mathrm{Ric}(R)\wedge\mathrm{id}=R+R\#I-3\,\mathrm{Alt}(R)$ at $R=W^2$ gives $G_W=4(\mathrm{Ric}(W^2)\wedge\mathrm{id})+12\,\mathrm{Alt}(W^2)-4W^2-4W^\#$. Two consequences. **The deficit of the record's diagonal-locus identity is exactly $12\,\mathrm{Alt}(W^2)_{\gamma\gamma}$**, which is $\tfrac{4(2m-1)}{3m}$ at $\mathbb{CP}^m$ and vanishes identically wherever $W$ is coordinate-diagonal, the square of such a $W$ having no four-index-distinct entry. **And $\langle G_Wv_k,v_k\rangle\ge0$ at a critical Weyl tensor of unit norm reads $\theta\lambda_k\le\lambda_k^2+\tfrac12R_k$ with $R_k=\sum_{\alpha\beta}\lambda_\alpha^2T_{k\alpha\beta}$**, which is Lemma L198's upper half with the pair cap not yet spent, so the two are nested rather than independent and this one reaches neither L198's lower half nor its global corollary.

**Proof:** [bounds.md](findings/bounds.md)

##### Lemma L79, the $\mathcal a$ eigenvalue theorem

The map $\mathcal A(W)=\sum_{g,h}W_{gh}\,\mathrm{ad}(\varphi_g)\mathrm{ad}(\varphi_h)$ is linear and $O(m)$-equivariant, and its eigenvalues on the four summands are $+2$, $-(m-4)$, $-2(m-2)$ and $-4$. **The group is $O(m)$ and not $SO(m)$**, which the record read wrongly until 2026-09-03; the weaker group licenses two scalars on $\Lambda^4$ at $m=8$ and two on $\mathrm{Weyl}$ at $m=4$. Two checks the table cannot pass by accident: the dimensions sum to $\dim S^2(\Lambda^2)$, and each eigenvalue was rebuilt by a route sharing nothing with the block's.

**Proof:** [isotropy-cap.md](findings/isotropy-cap.md)

##### Lemma L95, $\kappa^2(\mathbb{cp}^m)=3/(m+1)$, in closed form

$\kappa^2(\mathbb{CP}^m)=\dfrac3{m+1}$ at every $m\ge2$. *Verified to $10^{-15}$ at $m=2,\dots,7$ and derived in closed form.* **The `Lemma` label was unearned when the result was written and is earned now**, the audit having supplied the global maximality the first version assumed.

**Proof:** [bispectral.md](findings/bispectral.md)

##### Lemma L105, every two-eigenvalue critical point has $\theta\le\theta_0(n)$

Let $W$ be a $\theta$-critical point of unit norm whose spectrum takes exactly two values, $u>0$ with multiplicity $r$ and $-w<0$ with multiplicity $N-r$. Then $$\theta\ \le\ \min\Big\{(n-1)w,\ \frac{(n-2)u^2-2uw-w^2}{w}\Big\}\ \le\ \theta_0(n),$$ with equality in the second inequality exactly at the balanced sphere product. *The bound uses $T\ge0$ and the reduced system, and two of the block's three "does not need" clauses are refuted: it does need them.*

**Proof:** [bounds-relaxations.md](findings/bounds-relaxations.md)

##### Lemma L106, the zero-defect set is exactly where every positive eigenvector is an infinitesimal symmetry

$\Delta(W)=0\iff[\mathrm{ad}(x),W]=0$ for every $x\in\mathfrak p$, that is $\mathfrak p\subseteq\mathfrak k(W)$: **every positive eigenvector of $W$ is an infinitesimal symmetry of $W$.** *Then $\mathrm{ad}(x)$ preserves each eigenspace of $W$, so $[\mathfrak p,\mathfrak p]\subseteq\mathfrak p$.* **The biconditional is a restatement rather than a theorem**, cite it for the containment and the grading it produces, not as an independent step.

**Proof:** [bounds.md](findings/bounds.md)

##### Lemma L109, the per-coordinate cap $g_\gamma\le2(n-2)(\lambda_{\max}-\lambda_{\min})^2$

For every $\gamma$, $g_\gamma\le2(n-2)(\lambda_{\max}-\lambda_{\min})^2$. **The cap is unconditional**, and saturation is a theorem the block first reported as a measurement. *Its two constructors were its authors, so it stood unaudited until 2026-09-05; the water-filling reason originally given for it is a non sequitur, though the conclusion survives.*

**Proof:** [bounds-relaxations.md](findings/bounds-relaxations.md)

##### Lemma L120, $l_m$ is block-diagonal over the sign characters at every diagonal critical point

Let $\Gamma=\{\mathop{\mathrm{diag}}(\varepsilon_1,\dots,\varepsilon_n):\varepsilon_i=\pm1\}\subset O(n)$ be the full diagonal sign group. Then $$\mathcal W_n=\mathcal D_n\ \oplus\ \bigoplus_{\{i,j,k,l\}}V_{ijkl}\ \oplus\ \bigoplus_{\{i,j\}}V_{ij},$$ of dimensions $n(n-3)/2$, $2$ and $1$, and $L_M$ is block-diagonal for it at every diagonal critical point. **$\mathcal D_n$ is cut by $\langle M\rangle$**, which the sentence thirteen citations quoted omitted; read literally it made no diagonal critical point exist.

**Proof:** [second-order.md](findings/second-order.md)

##### Lemma L123, a zero-diagonal operator contributes nothing to a single-character rayleigh quotient

Let $F$ be an orthonormal frame of $\mathbb R^n$, $\Gamma=\{\mathop{\mathrm{diag}}(\pm1)\}\subset O(n)$ its full sign group, and $X\in\mathrm{Sym}^2(\Lambda^2)$ a vector lying in a single $\Gamma$-character space. If $R$ has zero diagonal in the frame $F$, then $\langle X,R\circ X\rangle=0$. *It is more general than the use it was found for, holding for any single character space.*

**Proof:** [second-order.md](findings/second-order.md)

##### Lemma L161, $\kappa_n=\tfrac{(n-1)(2n-1)}4$ at every $n\ge6$, both parities

For every $n\ge6$ and every nonzero $W\in\mathcal W_n$, $\mathop{\mathrm{tr}}(L_W^2)=\kappa_n\lVert W\rVert^2$ with $$\kappa_n=\frac{(n-1)(2n-1)}4 .$$ *This is the spectral-moment ceiling's constant, previously derived at even $n$ by summing Peirce components.* **Corroborated free of both normalisations at $n=4$**, and the unital hypothesis that killed an earlier route cannot recur here, the source's own text excluding it.

**Proof:** [curvature-invariants.md](findings/curvature-invariants.md)

##### Lemma L163, the kernel of $\phi$ at $\mathbb{cp}^m$, and the padding formula as an equality

(a) For every $m\ge2$, $\ker\Phi_{W_{\mathbb{CP}^m}}=\mathbb R\,\mathrm{Id}$; in particular $\dim\ker\Phi_W=1<4$ at $n=4$, so the diagonality corollary is not vacuous. (b) For $W_0$ on $\Lambda^2\mathbb R^m$ zero-padded to $\Lambda^2\mathbb R^n$ with $k=n-m$, $$\dim\ker\Phi_{W_0\oplus0}=\dim\ker\Phi_{W_0}+\binom{k+1}2+k\dim K(W_0)$$ **as an EQUALITY.** *The first version stated an inequality and it is strict, witnessed by $W_{\mathbb{CP}^2}\oplus0$.*

**Proof:** [target.md](findings/target.md)

##### Lemma L164, padding preserves the norm and $\theta$

Let $W\in\mathcal W_n$ be nonzero and vanish on $u\wedge u^\perp$ for every $u\perp U$, so that $W$ is supported on $\Lambda^2U$. Then the restriction $W'=W|_{\Lambda^2U}$ lies in $\mathcal W_{\dim U}$, and $$\lVert W'\rVert=\lVert W\rVert,\qquad P(W')=P(W),\qquad \theta(W')=\theta(W).$$ **This is what makes a classification by SUPPORT dimension a classification at every ambient $n$ at once.** *The sharp term is the only step needing $\Lambda^2U=\mathfrak{so}(U)$ to be a subalgebra.*

**Proof:** [stratum-two-negative.md](findings/stratum-two-negative.md)

##### Lemma L166, for the kähler family, ricci-flatness and first bianchi are one linear condition

Fix $m\ge2$ and let $\mathfrak k=\mathfrak{so}(m)$ and $\mathfrak m=i\,\mathrm{Sym}_0(m)$ be the two summands of $\mathfrak{su}(m)\subset\mathfrak{so}(2m)$, with $p=\binom m2$ and $q=\binom{m+1}2-1$. For $W_{a,b}=a\Pi_{\mathfrak k}+b\Pi_{\mathfrak m}$, Ricci-flatness and first Bianchi are the same linear condition on $(a,b)$. *The scalarity of $C_{\mathfrak k}$ needs a direct computation rather than Schur, which fails at $m=2$ where the module is of complex type.*

**Proof:** [ungraded-slack.md](findings/ungraded-slack.md)

##### Lemma L170, at every critical point with $\theta\ne0$ the $\tfrac12$-eigenspace is the hessian kernel

Let $W$ be a critical point of $P|_S$ at unit norm with $\theta\ne0$, and let $E(\tfrac12)$ be the $\tfrac12$-eigenspace of $L_e$. Then $$E(\tfrac12)=\ker\mathrm{Hess}(P|_S)_W,\qquad\text{so}\qquad E(\tfrac12)=T_W\mathcal O\iff W\ \text{is Morse–Bott nondegenerate.}$$ **MAXIMALITY IS NOT A HYPOTHESIS**: the equality holds at every critical point with $\theta\ne0$, and the local-maximum version stated first was unused.

**Proof:** [second-order.md](findings/second-order.md)

##### Observation L83, the $24$-block table of $\mathrm{Sym}^3(\mathcal W_5)$

The twenty-four $O(5)$ blocks of $\mathrm{Sym}^3(\mathcal W_5)$, with their labels and multiplicities, as a character computation gives them; no argument on file derives the weight list or the multiplicities. Every dimension re-derives by hand from Weyl's $B_2$ formula, the Casimir at $B_2$'s own $\rho$ separates the two dimension-$35$ blocks, and $\sum m_\lambda d_\lambda=\binom{37}3=7770$ checks the table against an external count. The other three sums, $24$, $41$ and $65$, are moments of the multiplicity column and check nothing outside it. **Owed**: the character identity $\mathrm{ch}\,\mathrm{Sym}^3(V_{(2,2)})=\sum m_\lambda\,\mathrm{ch}\,V_\lambda$ with the printed pairs.

**Proof:** [sym3-blocks.md](findings/sym3-blocks.md)

##### Lemma L84, Casimir separation is forced

Let $C_2$ be the quadratic Casimir of $\mathfrak{so}(5)$ and $C_4$ a central element of degree four not in $\mathbb R[C_2]$. Then $\big(\chi_\lambda(C_2),\chi_\lambda(C_4)\big)$ determines the dominant weight $\lambda$: the Harish-Chandra isomorphism carries both to $W(B_2)$-invariants of $\ell=\lambda+\rho$, in which $\chi_\lambda(C_4)$ carries $p_4$ with a nonzero coefficient, and $\ell_1>\ell_2>0$ lets $(p_2,p_4)$ recover $\ell$. The condition is needed: $C_2^2$ reads $(30,900)$ on both $(4,1)$ and $(3,3)$. On the $24$ labels of Observation L83, $c_2$ takes $21$ values with collisions at $30$, $40$ and $60$, which $p_4$ separates. The separation holds for every dominant weight and does not depend on the table's multiplicities.

**Proof:** [sym3-blocks.md](findings/sym3-blocks.md)

##### Observation L85, $\dim(\mathrm{Sym}^6\mathcal W_5)^{O(5)}=14$

$\dim(\mathrm{Sym}^6\mathcal W_5)^{O(5)}=14$, the output of a Weyl-integration computation for $SO(5)$, the $O(5)$ count agreeing because $-I$ acts trivially on $\mathcal W_5$. No argument on file derives the $14$ or the degree-$3$ to degree-$5$ values $1,4,5$. Degree $2$ is argued: $\mathcal W_n$ is absolutely irreducible, so that count is $1$ at every $n\ge4$, equal to the stable-range value. **Owed**: a derivation of the $14$.

**Proof:** [sym3-blocks.md](findings/sym3-blocks.md)

##### Lemma L86, the parity rule $\dim V_\lambda^H=1\iff\lambda_2$ even

For an $O(5)$-module $V_\lambda$ on which $-I$ acts trivially and $H$ the stabiliser of padded $W_{\mathbb{CP}^2}$, $\dim V_\lambda^H=1$ exactly when $\lambda_2$ is even; the hypothesis is needed, $\mathbb R^5$ at $(1,0)$ having $V^H=0$. The branching and the parity mechanism are proved, the stabiliser is granted. **The lemma proves $\ge36$ unknowns** on Observation L83's blocks, exactly $36$ resting on a measured rank, and $65=36+29$ is a tautology rather than a count. **Owed**: the stabiliser, $F_5(W_0)=0$ and the rank-one step.

**Proof:** [sym3-blocks.md](findings/sym3-blocks.md)

##### Lemma L88, the unknown count is real symmetric, and the $24$ antisymmetric invariants are gauge

Write $\mathrm{Sym}^3(\mathcal W_5)=\bigoplus_\lambda V_\lambda\otimes M_\lambda$ with $m_\lambda=\dim M_\lambda$ from Observation L83. Every $V_\lambda$ is of real type, self-dual and with integral coordinates, so by Schur's lemma the invariant symmetric and antisymmetric bilinear forms number $\sum\binom{m_\lambda+1}2=65$ and $\sum\binom{m_\lambda}2=24$. An invariant Hermitian form splits as $S+iA$, so the $24$ directions a Hermitian ansatz adds are the antisymmetric invariants, which contribute nothing to the sextic; they are gauge for the Gram-to-sextic map and not inside the positive semidefinite cone. $65+24=89$ holds for every multiplicity list. Both counts inherit L83's standing.

**Proof:** [sym3-blocks.md](findings/sym3-blocks.md)

##### Lemma L89, $\mathop{\mathrm{rank}}(\mu|_{\mathrm{inv}})=14$, nullity $51$, by exactness

Multiplication $\mu:\mathrm{Sym}^2(\mathrm{Sym}^3\mathcal W_5^*)\to\mathrm{Sym}^6\mathcal W_5^*$ is onto, every degree-$6$ monomial being a product of two cubic ones, and averaging over the compact $O(5)$ carries a preimage of an invariant to an invariant preimage. So $\mathop{\mathrm{rank}}(\mu|_{\mathrm{inv}})=\dim(\mathrm{Sym}^6\mathcal W_5)^{O(5)}$, which is $14$ on Observation L85, and the nullity is $51$ on L88's $65$. The sampled coefficient matrix has rank at most that, with equality when the sample separates the invariant sextics.

**Proof:** [sym3-blocks.md](findings/sym3-blocks.md)

##### Lemma L90, evaluation is injective on the image, given one measured rank

Let $K$ be the cubics vanishing to first order on the orbit of $W_0$ and $\mu_K$ the map from invariant Grams on $K$ to sextics. Since $\ker(\mathrm{ev}\circ\mu_K)\supseteq\ker\mu_K$, equal ranks make evaluation at a point set injective on $\mathop{\mathrm{im}}\mu_K$, so a sextic in the image that agrees with $F_5$ there is $F_5$. The cap $\mathrm{rank}\,\mu_K\le13$ is proved, since products of cubics of $K$ vanish at $W_0$. The lower bound $13$ at the certificate's $40$ points is a rank computed modulo a prime, and reading it over $\mathbb Q$ needs the restricted space modulo $p$ to reduce the rational one, invertible denominators, and the sampled points to be the certificate's. **Owed**: that rank over $\mathbb Q$ at those points.

**Proof:** [sym3-blocks.md](findings/sym3-blocks.md)

##### Lemma L91, the identity Gram on $K$ gives $\mathrm{rank}\,\mu_K\ge1$

The identity Gram on the orbit-vanishing cubics $K$ is an invariant form mapping to $\Delta=\sum_aq_a^2$ over an apolar-orthonormal basis, a psd invariant sum of squares vanishing on the orbit. $K\ne0$, its codimension being at most $3570$ in the $7770$-dimensional $\mathrm{Sym}^3(\mathcal W_5)$ by L86 on Observation L83's table, so $\Delta\ne0$ and $\mathrm{rank}\,\mu_K\ge1$. Given L90's measured rank $13$ the bound is not needed, and consistency reduces to $F_5(W_0)=0$.

**Proof:** [sym3-blocks.md](findings/sym3-blocks.md)

#### Lifting, the diagonal proof carried off the diagonal locus

##### Observation L15, the Bianchi defect of the spectral parts, and its price in Jäger's §3.2

**The identity.** For **every symmetric $R$ on $\Lambda^2\mathbb R^n$**, not merely for curvature operators, at which $\mathrm{Alt}(R)=0$ and the statement is empty,

$$\mathop{\mathrm{scal}}(R^2+R^\#)=\lVert\mathrm{Ric}(R)\rVert^2+6\lVert\mathrm{Alt}(R)\rVert^2,$$

with $\mathrm{Alt}$ the orthogonal projection onto $\Lambda^4$, **the constant exactly $6$ at every $n$ and no cross-term**. It is non-vacuous from $n=4$, $\Lambda^4$ being trivial below. **The constant is fixed by four normalisations**, all of which [conventions.md](findings/conventions.md) now carries: under $\mathop{\mathrm{scal}}=\mathop{\mathrm{tr}}$ both right-hand constants halve, under plain Frobenius on $\Lambda^2$ the $6$ becomes $4$, under the unnormalised Bianchi map it becomes $2/3$, and **under the other $\#$ normalisation in circulation the identity is false rather than rescaled**, $n(n-1)(2n-3)$ against $n(n-1)^2$ at $R=I$.

**What it prices.** Jäger's argument never forms either cubic term: it transfers the eigenvalue equation to the entrywise absolute value $\lvert W\rvert$ and contracts, collapsing cubic data into quadratic data about row sums. **$\lvert W\rvert$ and $W_\pm$ need not satisfy the first Bianchi identity** (they do at every sphere product) and where they fail, the identity prices the failure exactly: the master inequality carries a further $+24\lVert\mathrm{Alt}(W_-)\rVert^2$, the $24$ being $6\cdot4$ via $\mathrm{Alt}(\lvert W\rvert)=2\mathrm{Alt}(W_-)$. At Fox's $\mathcal S^4(\alpha)$ the uncorrected inequality fails by a factor of **exactly three** ($\theta\mathop{\mathrm{scal}}(\lvert W\rvert)=4$ against $4/3$) and the corrected form is saturated; all four quantities are padding-invariant, so this holds at **every $n\ge4$**.

**This is [Lemma L131](findings/isotropy-cap.md) at the scalar level, and the two determine each other**, $\Psi$ being self-adjoint, a vanishing quadratic form forces $\Psi=0$. What L15 adds is the assembled constant, the absence of a cross-term, the transfer to $\lvert W\rvert$ with its factor $4$, and the Fox and sphere-product evaluations. **The heading's second obstruction, $X_{\mathrm{inv}}\succeq0$, is established nowhere**: only its trace ([Lemma L7](findings/bounds.md), [Lemma L154](findings/bounds.md)) and its equality locus ([Lemma L155](findings/bounds.md)) are proven, and it is refuted off the diagonal locus. The identity bears on the Bianchi obstruction alone.

**Proof:** [isotropy-cap.md](findings/isotropy-cap.md), Lemma L131 contracted against $R$, with $c_4=2$; [problem.md](findings/problem.md) carries the reading and the evaluations, not the derivation.

##### Conjecture L16, the defect-penalty inequality

Everything above converges on one candidate. With $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$ the sphere-product value and $\delta^2=\|\mathrm{Alt}(W_-)\|^2$ the defect from Observation L15, the claim is $P(W)\le\theta_0(n)+\kappa_n\delta^2$ on $\{|W|=1\}$, where $\kappa_n=9(\sqrt{3/2}-\theta_0(n))$ is pinned by requiring equality at the $\mathbb{CP}^2$-type competitor, whose defect is exactly $1/9$ in every ambient dimension. The shape is forced, not fitted: equality holds at both named maximizers by construction, and $\kappa_n$ changes sign exactly at the crossover $n=6+2\sqrt7$, so the bound permits the competitor above $\theta_0$ for $n\le11$ and penalizes all defect for $n\ge12$. If true for $n\ge12$ it settles your conjecture outright, zero-defect points fall under it with no criticality hypothesis, and it is precisely the joint bound on $\langle Q(W),W\rangle$ that the failed term-by-term route showed is needed. It has survived a full adversarial battery at $n=12$ and $n=14$ (every catalogued critical point, random sampling, seeded gradient ascent of the penalized functional, and the ridge between the two equality points, which sags rather than bulges); the analogous interpolation statement for $n\le11$ is refuted by an explicit violation at $n=8$, and the refutation needs the penalty's other sign, so it leaves the $n\ge12$ claim untouched. A direct sweep of the critical set's value–defect frontier at $n=8$ and $n=12$ lands the same way: no critical point sits above the bound, the frontier touches it exactly at the two maximizers, and the window of values between them contains no defective critical point at all.

**Proof:** [problem.md](findings/problem.md)

##### Lemma L17, first-order protection at the rival maximizer

Let $u$ be the padded $\mathbb{CP}^2$-type competitor in $\mathcal W_n$, $n\ge4$, **critical** ($Q(u)=\theta u$ with $\theta=\sqrt{3/2}$) and let $H\in\mathcal W_n$ be **tangent**, $\langle H,u\rangle=0$. With $\delta^2=\lVert\mathrm{Alt}(W_-)\rVert^2$ and $\Phi=P-\kappa_n\delta^2$,

$$d^+\delta^2(u;H)=-2a\,F(H)\le0,\qquad a=\tfrac1{3\sqrt6},$$

at every $n\ge4$. Hence $d^+\Phi(u;H)=2a\kappa_nF(H)\le0$ **for exactly those $n$ with $\kappa_n\le0$, which is $n\ge12$.** *Criticality is load-bearing and $\lVert H\rVert=1$ is inert.* The equality set is the linear subspace $\{H\in T_uS:\Pi_{ASD}H\Pi_{\ker u}=0\}$, of codimension at most $186$ at $n=12$ (the count of those conditions), **a proper subspace, so measure zero among directions**. **$\kappa_n$ here is the penalty coefficient and not the Killing constant [conventions.md](findings/conventions.md) tables under that name.**

**Proof:** [route-a.md](findings/route-a.md)

##### Lemma L18, the diagonal proof's middle chapters, lifted with the defect cost quantified

**Proof:** [problem.md](findings/problem.md)

##### L19, WITHDRAWN as a numbered result: the lift, the rigidity and the sharpening, graded separately

**Withdrawn.** *Gate 2, [r605](reviews/REVIEW_r605.md) and [r606](reviews/REVIEW_r606.md) on identical briefs, both reaching the verdict independently: there is no checkable statement, no hypothesis, no conclusion, no quantifier over $n$, no displayed inequality.* **The three claims the old heading bundled have three different standings.** *The rest lifts* is unlocatable as a numbered result, its source recording the step **failing at padded $W_{\mathbb{CP}^2}$**, the one point that matters off the diagonal locus. *The top orbits are rigid* is an `Observation` supported at $19$ orbits at $n=8,12,14$, and its *"every sphere pair"* clause is false without [L11](findings/nondegeneracy.md)'s $(3,3)$ exclusion, $S^3\times S^3$ being degenerate at $\Theta_6$. *The gap sharpens* names no sharpened quantity. **The open core is a gap in a nameable place**: the localisation says every critical point at or above the rival's value lies within $\varepsilon_n$ of a rigid orbit, and rigidity finishes it only if $\varepsilon_n\le\min_ir_i$, **no isolation radius is anywhere on the record**, and nondegeneracy as kernel-equals-orbit-tangent gives isolation qualitatively and no radius. *The claim that the remainder is strictly weaker than [Conjecture L16](findings/problem.md) is withdrawn with it: the two are incomparable.*

**Record:** [problem.md](findings/problem.md)

#### Localization, splitting the sphere around the rival orbit

##### Lemma L20, no maximizer lies near the rival maximizer's orbit, for every $n\ge12$

Write $\theta^*=\sqrt{3/2}=P(W_{\mathbb{CP}^2})$ and $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$, so that $\theta_0(n)>\theta^*$ exactly when $n>6+2\sqrt7$. For every $n\ge12$, no maximizer of $P$ on the unit sphere of $\mathcal W_n$ lies within angular distance $0.5748$ of the orbit $SO(n).W_{\mathbb{CP}^2}$. The proof is a bootstrap on the attained maximum: inside the tube the exact cubic expansion about the orbit, with the eigenvalue bound $\alpha\le\tfrac13$ of [Lemma L21](findings/route-a.md) and the self-bootstrap $\gamma_V\le m$, forces $\max P\le\theta^*$, contradicting the value $\Theta_n>\theta^*$ attained by $S^{\lfloor n/2\rfloor}\times S^{\lceil n/2\rceil}$, with $\Theta_n=\theta_0(n)$ at even $n$ and $\Theta_n^2=\frac{2(n-1)(n-3)}{(n-2)(n+1)}$ at odd $n$. The contradiction is with the value.

> **UNCONDITIONAL IN THE SENSE THAT MATTERS, AND NOT INPUT-COMPLETE.** *[r464](reviews/REVIEW_r464.md).* **It is free of every circular input**, no a priori cap $P\le\theta^*$, no [Lemma L22](findings/route-a.md) directly or through L21, no [Observation L102](findings/route-a.md), *which is what makes it the programme's one tube theorem that does not assume its own conclusion.* **But $\alpha\le\tfrac13$ rests on four $F_\lambda$ spectra tabulated at $n=10,12,14$ and asserted stable beyond**, which [route-a.md](findings/route-a.md) calls L20's one external input, twice, and which this entry omitted.

> **THIS ENTRY HAS CARRIED THREE WRONG DESCRIPTIONS OF THAT PROOF, TWO OF THEM MINE.** *It first named [Lemma L22](findings/route-a.md), which the proof never invokes ([r463](reviews/REVIEW_r463.md)). The repair named [Lemma L21](findings/route-a.md) and was then over-corrected to a "multiplicity-free orbit decomposition" on the grounds that the block cites no lemma number, **but the block cites Nienhaus 4.14(c) for a statement that is L21's verbatim**, so citation is not dependency, and the decomposition named has multiplicities $6,4,1$ and does not give the bound alone ([r464](reviews/REVIEW_r464.md)). The L21 reading is restored.*

**Proof:** [route-a.md](findings/route-a.md)

##### Lemma L21, the eigenvalue bound $\alpha\le\tfrac13$, structural at every $n\ge9$

Let $n\ge9$, $m=n-4$, and let $u=W_{\mathbb{CP}^2}$ padded to $\mathcal W_n$ at unit norm, with $\theta^*=P(u)=\sqrt{3/2}$ and $F_u(h)=\tfrac12(uh+hu)+u\#h$. Then for every unit $V\in u^\perp\cap T_u(SO(n).u)^\perp$,

$$\alpha:=\sqrt{2/3}\,\langle F_uV,V\rangle\ \le\ \tfrac13,$$

and $\tfrac13$ is attained. **The range is $n\ge9$ and it is sharp for the argument**: at $m=4$ both $\Lambda^2(\mathbb R^4)$ and $\mathrm{Weyl}_4$ split under $SO(4)$, and at $m=2$ the group is abelian.

> **THE STRUCTURAL HALF IS PROVED AND THE SPECTRA ARE NOT.** *Proved identically in $m$: the six $SO(m)$-types with multiplicities $20,20,6,10,4,1$, none containing $m$; the dimension identity as a polynomial in $m$; the annihilation of the two higher types, which is $940$ of $1638$ dimensions at $n=12$; and the orbit at $2\cdot(\text{trivial})\oplus4\cdot(\text{vector})$, of dimension $4n-14$.* **Unproved: that the four remaining $F_\lambda$ have $m$-free entries.** *Their spectra were checked exactly at $n=6,8,10$, and $m\ge5$ admits only $n=10$, so the in-range exact evidence is one dimension.* **Schur here needs the $V_\lambda$ absolutely irreducible rather than multiplicity-free**, which holds at $m\ge5$ and is stated in the block.

**Proof:** [route-a.md](findings/route-a.md)

##### Lemma L100, the $8\le n\le11$ dichotomy at the $\mathbb{CP}^2$ orbit

Let $8\le n\le11$ and let $d$ be geodesic angular distance on the unit sphere of $\mathcal W_n$. Given $\alpha\le\tfrac13$ on $u^\perp\cap T_u(SO(n).u)^\perp$, which Lemma L21 gives at $9\le n\le11$ and which follows at $n=8$ from L21 at $n=9$ because zero-padding $\mathcal W_8\to\mathcal W_9$ is an isometry fixing $u$, intertwining $F_u$ and carrying transverse directions to transverse directions, either $\max P\le\sqrt{3/2}$ or every maximizer of $P$ lies farther than $0.5748$ from $SO(n).W_{\mathbb{CP}^2}$. Padding forces $\max P\ge\sqrt{3/2}$, so the content is one implication.

**Proof:** [route-a.md](findings/route-a.md)

##### Lemma L101, the $SO(n)$-invariance identity, and $P\equiv0$ on $V_{1/2}$ at $n\ge9$

Let $u=W_{\mathbb{CP}^2}$ padded to unit norm in $\mathcal W_n$, $\theta^*=\sqrt{3/2}$, and $V_\lambda=\{x:F_ux=\lambda\theta^*x\}$. For $x\in V_\lambda$, $y\in V_\mu$ and $A\in\mathfrak{so}(n)$, $T(x,y,[\rho(A),u])=(\lambda-\mu)\,\theta^*\langle[\rho(A),x],y\rangle$, at every $n$ and using no property of $u$ beyond $u\in\mathcal W_n$. Hence $Q(x)\perp T_u(SO(n).u)$ for every eigenvector $x$ of $F_u$. At $n\ge9$, criticality of $u$ gives $T_u(SO(n).u)\subseteq V_{1/2}$ and Lemma L21 gives the reverse inclusion, so $P\equiv0$ on $V_{1/2}$.

**Proof:** [route-a.md](findings/route-a.md)

##### Observation L22, the estimate the localization theorem needs, at $n=12,14,16$

Nienhaus's localization theorem holds for $10\le n\le11$, and what stops it above $11$ is a single estimate inside his Theorem 4.17, which he states and records that he could not supply. **At $n=12,14,16$ that estimate holds, conditionally**: at the maximiser of the inner problem the configuration is forced, so both couplings are evaluated at one pair, the inner maximisation is a hard-case trust-region problem with a closed-form frontier, and two branches cover complementary intervals of the parameter at every $n$. **Lemma L20's bootstrap does not consume it.** *This is the fourth place to name [Observation L22](findings/route-a.md) as an input to L20; the proof invokes it nowhere, and had it done so L20 would inherit L22's conditionality instead of being free of it* ([r484](reviews/REVIEW_r484.md), [r485](reviews/REVIEW_r485.md)).

**Proof:** [route-a.md](findings/route-a.md)

#### Second-order, constraining the maximizer beyond criticality

##### Lemma L24, second-order optimality, as an eigenvalue bound on the multiplication operator

Let $W$ be a critical point with $\theta=P(W)>0$, put $e=W/\theta$, and let $L_e=e\circ(\cdot)$ where $X\circ Y=\tfrac12(Q(X+Y)-Q(X)-Q(Y))$. The **Riemannian** Hessian of $P$ on the unit sphere of $\mathrm{Weyl}_n$ is $6\theta\big(L_e-\tfrac12\mathrm{Id}\big)$. Hence if $W$ is a **local** maximiser,

$$\lambda_{\max}\big(L_e|_{W^\perp}\big)\ \le\ \tfrac12 .$$

**Proof:** [second-order.md](findings/second-order.md)

##### Lemma L50, the potential is a function of two spectra, and collapses to one only below dimension six

Let $W\in\mathrm{Weyl}_n$ act on $\Lambda^2\mathbb R^n$ as $M$, with $\lVert M\rVert_F=1$ and spectrum $\mu$. Let $\mathring W$ be the curvature operator of the second kind on trace-free symmetric $2$-tensors, $(\mathring Wh)_{ij}=\sum_{k,l}W_{iklj}h_{kl}$, with spectrum $\omega$. Then

$$\theta=\langle W,Q(W)\rangle=\tfrac32\,p_3(\mu)-\tfrac12\,p_3(\omega),\qquad \sum\mu=\sum\omega=0,\quad\sum\mu^2=1,\quad\sum\omega^2=3 .$$

The index order $iklj$ is Li's and is load-bearing: the order $ikjl$ negates $\mathring W$ and the second coefficient.

**Proof:** [bispectral.md](findings/bispectral.md)

##### Lemma L51, the variation calculus is an identity along a critical orbit

Let $T$ be a fully symmetric trilinear form on a Euclidean space, $P(x)=T(x,x,x)$, and $x\circ y$ defined by $\langle x\circ y,z\rangle=T(x,y,z)$. Let a compact group $G$ act orthogonally leaving $P$ invariant, let $W$ be a unit critical point of $P$ on the sphere with $Q(W)=\theta W$, $\theta>0$, and put $L_Wx=W\circ x$, $B=\tfrac\theta2-L_W$ and $A(\tfrac12)=\ker B\cap W^\perp$. Then for $X$ in the Lie algebra of $G$, with $z=X\!\cdot\!W$ and $u=X^2\!\cdot\!W$:

$$L_Wz=\tfrac\theta2z,\qquad B\,u=z\circ z .$$

Consequently the orbit tangent lies in $A(\tfrac12)$; $T(z,z,z)=0$ there; the fusion rule $\langle z\circ z,y\rangle=0$ holds for every $y\in A(\tfrac12)$; and **with $b=\Pi(z\circ z)$ the fourth-order value at the stationary corrector $\Pi u$ is $\langle b,B^+b\rangle=\tfrac\theta2\lVert z\rVert^4$, giving $0$ exactly and needing no positivity**, *where $B\vert_{W^\perp}\succeq0$ that value is additionally a **supremum**, which is all the guard buys.* **None of this uses maximality**, nor compactness, and $\theta>0$ is spent only as $\theta\ne0$. *The identity $\langle Bu,u\rangle=0$ behind the last clause is true and has no argument on file.*

**Proof:** [second-order.md](findings/second-order.md)

##### Lemma L52, the shared-frame majorization bound, sharp on the diagonal family

Let $W\in\mathrm{Weyl}_n$, $n\ge4$, with $\lVert M\rVert_F=1$; let $M_+$ bound $\mu$ above and $-m$ bound $\omega$ below. In any orthonormal frame, $M_{(ij),(ij)}=W_{ijij}$ and $\langle\mathring W\varphi_{ij},\varphi_{ij}\rangle=W_{ijij}$ for $\varphi_{ij}=(e_i\odot e_j)/\sqrt2$. Writing $K$ for the sectional vector and $K'$ for the $\mathring W$ diagonal **in the basis whose $\psi_k$ are an eigenbasis of $K$ on $\mathbf1^\perp$** (the frame alone does not fix it), Schur's theorem gives $K\prec\mu$ and $K'\prec\omega$, and convexity of $t^3+3mt^2$ on $[-m,\infty)$ with concavity of $t^3-3M_+t^2$ on $(-\infty,M_+]$ gives

$$\theta\ \le\ \tfrac32\big[p_3(K)+3M_+(1-p_2(K))\big]-\tfrac12\big[p_3(K')+3m(p_2(K')-3)\big].$$

**The bound is an identity when both operators are diagonal in that shared basis**, so the coupling is *sharp* on the diagonal family (where the conjecture is already granted), and it beats the strict one-line $\theta\le\tfrac32(M_++m)$ on a neighbourhood of that family, both bounds being continuous. Away from the family it can lose to it: $3.9804$ against $2.4495$ at padded $W_{\mathbb{CP}^2}$. The converse, that exactness forces the shared frame, goes row by row and needs strict convexity **and** strict concavity: at equality each row of the doubly stochastic matrix is supported where the spectrum equals that row's diagonal entry, so counting with the column sums makes the diagonal a rearrangement of the spectrum, and then $\sum_iK_i^2=\sum_j\mu_j^2=\lVert M\rVert_F^2$ forces every off-diagonal entry to vanish.

**Proof:** [bispectral.md](findings/bispectral.md)

##### Observation L53, the champion split

With $\mu$ the $\Lambda^2$ spectrum and $\omega$ the second-kind spectrum of Lemma L50, ascent from six starts in the direction $(a,b)$, maximising $a\,p_3(\mu)+b\,p_3(\omega)$ over the unit sphere of $\mathcal W_n$, lands as follows at $n=6,8,10$: the second-kind cubic alone, $(0,-1)$, on the balanced sphere product at all three and at $n=12$; $\theta$ itself, $(\tfrac32,-\tfrac12)$, on $W_{\mathbb{CP}^2}$ at $\sqrt{3/2}=1.224745$; the $\Lambda^2$ cubic alone, $(1,0)$, on $\theta_0(6)$ at $n=6$ and on $\mathbb{CP}^4$'s $0.986013$ at $n=8$. These are lower bounds on each direction's maximum, at the dimensions stated, and they say that the balanced product is the champion of one spectrum's cubic and $W_{\mathbb{CP}^2}$ of the combination, so the two spectra pull in different directions.

**Proof:** [bispectral.md](findings/bispectral.md)

##### Lemma L54, the two diagonals, and rigidity at $t=2$

Let $W\in\mathrm{Weyl}_n$, $n\ge4$, with $\lVert M\rVert_F=1$. Fix a frame $F$ and take the orthonormal basis $\{\varphi_{ij},\psi_k\}$ of $S^2_0$ whose $\varphi_{ij}$ are the off-diagonal Nienhaus–Petersen–Wink vectors and **whose $\psi_k$ are an eigenbasis of $K$ on $\mathbf1^\perp$**, NPW's own staircase $\psi_k$ will not serve, being fixed by the frame alone. In that basis the diagonal of the second-kind operator $\mathring W$ on the $\varphi$-block is exactly the sectional vector $K$, the $\psi$-block of $\mathring W$ is exactly $-K$ restricted to $\mathbf 1^\perp$, and the diagonal of $M$ in the pair basis $\{e_a\wedge e_b\}$ of $\Lambda^2$ is $K$ as well, $\mathring W$ in Li's convention. Consequently $\sum d_\varphi^2=t/2$ and $\sum d^2=\tfrac32t$ for the full $S^2_0$ diagonal $d$, and Schur's half of Schur–Horn gives $\mu\succ d_\varphi$ and $\omega\succ d$. In every frame $t_F=2\sum_{a<b}M_{(ab),(ab)}^2\le2\lVert M\rVert_F^2=2$, with equality exactly when $W$ is coordinate-diagonal **in that frame** (L94 is its maximum over frames), and at $t_F=2$ majorization has equal sums and equal norms on both sides, $\sum\omega^2=3$ by Lemma L50, forcing $\mu^\downarrow=d_\varphi^\downarrow$ and $\omega^\downarrow=d^\downarrow$ by the rigidity of majorization at equal $2$-norms. The vectors agree too: at $t_F=2$, $M$ is diagonal in the pair basis and $\mathring W$ is diagonal in the $\varphi$-and-eigenbasis.

**Proof:** [bispectral.md](findings/bispectral.md)

##### Lemma L94, the vertex-matrix budget

For $W$ antisymmetric in each index pair, acting on $\Lambda^2$ as $M$, let $t_F=\lVert K(F)\rVert_F^2=\sum_{a\ne b}W_{abab}(F)^2$ in the orthonormal frame $F$, a sum over ordered pairs, and $\kappa^2=\max_Ft_F$. The maximum is attained, $\kappa^2\le2\lVert M\rVert_F^2$ with $\lVert M\rVert_F$ the Frobenius norm of the operator on $\Lambda^2$, and $\kappa^2=2\lVert M\rVert_F^2$ exactly when $W$ is coordinate-diagonal in some frame. Only the pair antisymmetries are used.

**Proof:** [bispectral.md](findings/bispectral.md)

##### Lemma L66, no maximizer is $\circ$-decomposable

Let $W=\sum_{i=1}^ka_iA_i$ with $k\ge2$, each $A_i$ a unit element of $\mathcal W_n$, $\sum_ia_i^2=1$, every $a_i\ne0$, and $A_i\circ A_j=0$ for $i\ne j$, where $\circ$ is the symmetric product with $\langle x\circ y,z\rangle=T(x,y,z)$. Then for $n\ge4$, $W$ is no maximizer of $P$ on the unit sphere of $\mathcal W_n$: $T$ is fully symmetric and $T(A_i,A_j,\cdot)=\langle A_i\circ A_j,\cdot\rangle$, so every term of $T(W,W,W)$ carrying two distinct indices vanishes, so $P(W)=\sum_ia_i^3P(A_i)$, and with $\lvert a_i\rvert<1$ for every $i$, $\lvert P(W)\rvert\le\sum_i\lvert a_i\rvert^3\lvert P(A_i)\rvert\le M(n)\max_i\lvert a_i\rvert<M(n)$, where $M(n)=\max\{P(A):\lVert A\rVert=1\}$ is the global maximum, positive because $S^k\times S^l$ with $k,l\ge2$ has $P=\theta_{k,l}>0$ (Nienhaus, Proposition 2.25). **The bound runs against $M(n)$ rather than against $\max_i\lvert P(A_i)\rvert$**, which reads $0<0$ at a splitting whose every piece has $P(A_i)=0$. The lemma is a statement about maximizers and bounds nothing about the summands' support dimensions, so it supplies no induction on $n$.

**Proof:** [support-dichotomy.md](findings/support-dichotomy.md)

##### Lemma L67, the second-kind spectrum of the balanced product

Let $m\ge2$ and let $W$ be the Weyl tensor of $S^m\times S^m$ with $n=2m$, normalised to $\lVert W\rVert_F=1$ as an operator on $\Lambda^2$, which is $\sum\omega^2=3$ by Lemma L50's norm relation, and let $\mathring W$ be its second-kind operator on $S^2_0$ in Li's $iklj$ order, with $R_{ijij}$ the sectional curvature. Then $\mathring W$ has exactly three eigenvalues: $mA$ on the trace-free parts within each factor, multiplicity $(m-1)(m+2)$; $-(m-1)A$ on the cross block, multiplicity $m^2$; and $-2m(m-1)A$ on $P_1-P_2$, multiplicity $1$; where $A=1/\big(m\sqrt{(m-1)(2m-1)}\big)$. The multiplicities sum to $\dim S^2_0=2m^2+m-1$. The proof substitutes $W=G^{(1)}+G^{(2)}-\frac{m-1}{2m-1}G$ into the operator, and Li's Theorem 1.8 gives the same spectrum as a product rule. The $\Lambda^2$ spectrum at the same point gives $p_3(\mu)=A$, and with Lemma L50 the two spectra return $\theta=\theta_0(2m)$ identically in $m$.

**Proof:** [bispectral.md](findings/bispectral.md)

##### Lemma L133, the balanced orbit's stability threshold, in closed form

Let $n=2m\ge12$, let $W^*$ be the unit-norm Weyl tensor of $S^m\times S^m$, $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$, and $\delta^2(W)=\lVert\mathrm{Alt}(W_-)\rVert^2$. Define $\kappa_n^{\mathrm{Hess}}$ as the supremum of $\tfrac12\mathrm{Hess}(P|_S)_{W^*}[H,H]\big/\lVert D(\mathrm{Alt}\,W_-)_{W^*}[H]\rVert^2$ over $H\in T_{W^*}S$ with nonzero denominator. Then
$$\kappa_n^{\mathrm{Hess}}=\tfrac{27}2\,\theta_0(n)\Big(\tfrac2{n-2}-\tfrac12\Big)\;\le\;\kappa_n=9\big(\sqrt{3/2}-\theta_0(n)\big),$$
strictly for every $n\ge12$, the comparison reducing to $\theta_0(n)\big(\tfrac3{n-2}+\tfrac14\big)\le\sqrt{3/2}$. The supremum is attained on [Lemma L26](findings/nondegeneracy.md)'s direction in every $(2,2)$-split four-subset, so its maximiser set is the span of those directions.

**Proof:** [second-order.md](findings/second-order.md)

##### Lemma L140, the defect's first-order response is a $\tfrac12$-contraction

Let $H\in\mathcal W_n$ with $\lVert H\rVert=1$, let $V$ be a base point, and let $g_1=\mathrm{Alt}\big(\mathcal D_V[H]+D_-\big)$ be the first-order coefficient of $\mathrm{Alt}(W_-)$ along $V+tH$, with $D=P_0HP_0$ and $W_-=\tfrac12(\lvert W\rvert-W)$. Then $\lVert g_1\rVert^2\le\tfrac14$.

The proof uses only that $H$ satisfies the first Bianchi identity, so $\mathrm{Alt}(H)=0$ and $g_1=\mathrm{Alt}(\mathcal D_V[H]+D_-+\mu H)$ for every scalar $\mu$; that the Daleckii–Krein multiplier of $x\mapsto x_-$ has range of length one, so $\mu=\tfrac12$ centres it; and that on a kernel block $D_-+\tfrac12D=\tfrac12\lvert D\rvert$. **It is therefore independent of the sign convention for $W_-$.**

**Proof:** [route-a.md](findings/route-a.md)


### Lemma L206 (bounds). The trace-form bound on $\theta$, attained, and loosest where the conjecture is an equality

**Hypotheses.** $W$ a critical point of $P$ on the unit sphere of $\mathcal W_n$ with $\theta\ne0$; $e=W/\theta$, an idempotent of Fox's algebra; $L_e$ its multiplication operator, self-adjoint because $\langle x\circ y,z\rangle$ is the full polarisation of $P$; $p=\dim E_1(L_e)\ge1$ and $m=\dim E_{1/2}(L_e)\ge\dim(O(n)\cdot W)$, each used only as a lower bound; $k=\dim\mathcal W_n-p-m$, which is forced positive rather than assumed.

**Statement.** With $\kappa(n)=(2n-1)(n-1)/4$ the Killing constant of the algebra in the Frobenius normalisation,

$$\theta^2\ \le\ \frac{\kappa(n)}{\,p+\dfrac m4+\dfrac{(2p+m)^2}{4k}\,}.$$

**Sharpness.** Equality holds exactly when the eigenvalues outside $E_1\oplus E_{1/2}$ are all equal, and it is attained: at $S^2\times S^2$ in dimension four the spectrum is $\{1^2,\tfrac12^4,(-1)^4\}$, so $p=2$, $m=4$, $k=4$, and the bound returns $\theta_0(4)^2=\tfrac34$. The two-moment problem behind it is sharp for every $k\ge2$, so no better inequality exists on these two identities.

**What it does not reach, and this is [post F65](findings/fence-posts.md).** The bound increases in $m$, so it is weakest where the $\tfrac12$-eigenspace is smallest. At zero excess, where $m$ is the orbit dimension and so at most $n(n-1)/2$, the cap on $\theta^2$ stays above $\tfrac32$ for every $n\ge5$ and rises only to $4$, giving $\theta\le2$ asymptotically. At padded $W_{\mathbb{CP}^2}$, which attains $\sqrt{3/2}$ and has excess zero, the bound is loose by $1.73\times$ at $n=8$ rising to $2.65\times$ at $n=20$: it is loosest on the conjecture's own equality set and the looseness grows in $n$.

**Where it does bite.** The cap falls to $\tfrac32$ once $m$ reaches $m^\ast(n)$, with $m^\ast(8)=54$ and $m^\ast(12)=150$ against $\dim SO(12)=66$. At $S^2\times S^3\times S^3$, $n=8$, where the $\tfrac12$-multiplicity is $60$ against an orbit dimension of $21$, it returns $\theta\le1.145045$ against $\theta_0(8)=1.145644$.

**It does not dominate the standing bound, and the crossover is exact.** The bound beats $\theta\le(n-1)/\sqrt{n+1}$ only from $m\ge d^\ast(n)$, where $d^\ast(n)=2n-1$ for $8\le n\le24$ and $2n$ for $n\ge25$, the real threshold being $2n-1+\tfrac2{n-1}$ and the two regimes coming from integrality. A critical point exists with orbit dimension $2n-4$, the Weyl tensor of $S^2\times S^{n-2}$ with $\theta^2=1-\tfrac1{(n-2)^2}$, so the gap is $3$ then $4$ at every $n\ge8$ and the standing bound is strictly better there. Since the orbit tangent gives only $m\ge d$, what the record carries is the minimum of the two bounds. And closing the gap would buy agreement rather than sharpness: at that family the bound tends to $\tfrac{2n-1}2$ while $\theta^2\to1$, the loose step being the Cauchy–Schwarz on the free block.

**What is owed.** A classification of critical points of orbit dimension below $d^\ast(n)$, since among two-factor sphere products only $p=2$ falls below and its value is known. A lower bound on the orbit dimension at $n\ge9$ also remains open, the obvious argument failing because $d\le n-1$ gives $\dim\mathrm{Stab}\ge\dim SO(n-1)$ rather than containment.

**Gate 2.** Passed twice. [r883](reviews/REVIEW_r883.md) and [r884](reviews/REVIEW_r884.md) on identical briefs agreed on every claim, both independently refuting the literal spectral shape first recorded. [r885](reviews/REVIEW_r885.md) and [r886](reviews/REVIEW_r886.md) then audited the debt and agreed on every claim, establishing the exact crossover, the witness family, and the identity $4(\kappa(n)/S(n)^2-1)-(2n-4)=3+\tfrac2{n-1}$ that explains the near-miss.

**Proof:** [bounds.md](findings/bounds.md), the L206 block. Machine-checked in [L206TraceFormBound.lean](lean/HamiltonsCubic/Results/L206TraceFormBound.lean), six declarations, no `sorry`.


### Lemma L207 (nondegeneracy). The complete $L_e$ spectrum at a two-factor sphere product, and the excess at every split

**Hypotheses.** $n=p+q$ with $p,q\ge2$; $W$ the Weyl tensor of $S^p\times S^q$ with sectional matrix $M$, which is a critical point of $P$ on the unit sphere; $e=W/\theta=-M/(n-1)$; $L_e$ its multiplication operator.

**Statement.** With $\mu=\dfrac{n-2}{2(p-1)(q-1)}$,

$$\dim E_{1/2}(L_e)\;=\;pq\;+\;\binom p2\binom q2\cdot\big[\,\mu=\tfrac12\,\big],$$

and $\mu=\tfrac12$ exactly when $(p-2)(q-2)=1$, hence at $p=q=3$ alone. **Since the orbit dimension is $\binom n2-\binom p2-\binom q2=pq$, the excess $\dim E_{1/2}(L_e)-\dim(O(n)\cdot W)$ is zero at every two-factor sphere product except $S^3\times S^3$, where it is $\binom32^2=9$.**

**Why the block list closes.** $L_e$ commutes with the diagonal sign group, which fixes every coordinate-diagonal $e$, so its isotypic components are the coordinate-diagonal sector, the $\binom n2$ pair blocks of [Lemma L122](findings/second-order.md) and the $\binom n4$ four-set blocks of [Lemma L121](findings/second-order.md). The count closes on the identity $\tfrac{n(n-3)}2+\binom n2(n-3)+2\binom n4=\dim\mathcal W_n$. The two sectors the record had not named are the cross pairs, which carry the $\tfrac12$, and the coordinate-diagonal sector.

**The mechanism.** Each cross-pair block has $0$ with multiplicity $n-4$ and $\tfrac12$ exactly once, and the orbit direction $[e_j\wedge e_k,W]$ is that eigenvector. So the orbit inclusion of [Lemma L120](findings/second-order.md) is an equality of multiplicity one per cross pair, and the excess vanishes for a structural reason rather than because $\tfrac12$ is hard to reach.

**Scope.** It supersedes the reach of [Lemma L27](findings/nondegeneracy.md), which covered $p,q\ge3$ apart from $(3,3)$, and extends to $p=2$, which L27 excludes by name. It also refutes [Lemma L122](findings/second-order.md)'s within-factor pair form at $p=2$, where that block is the scalar $-\mu\,\mathrm{Id}_{n-3}$ and the predicted $\tfrac{p-2}{2(p-1)}=0$ is absent.

**Gate 2.** Passed, [r887](reviews/REVIEW_r887.md) and [r888](reviews/REVIEW_r888.md) on identical briefs, agreeing on every claim, each deriving the whole spectrum cold and both refuting the parent's account of why the excess vanishes. The $(3,3)$ value $9$ is reproduced by the formula without being fitted to it.

**Proof:** [nondegeneracy.md](findings/nondegeneracy.md), the L207 block.

### Lemma L209 (curvature-invariants). The Fox square preserves the Weyl module, in this record's own normalisation

**Hypotheses.** $R$ a linear operator on $\Lambda^2\mathbb R^n$ mapping bivectors to bivectors, self-adjoint for the pairing $\langle X,Y\rangle=\tfrac12\mathop{\mathrm{tr}}(X^{\mathsf T}Y)$, and satisfying first Bianchi $R_{ij,kl}+R_{ik,lj}+R_{il,jk}=0$ in the four-index reading $R_{ij,kl}=\langle R\varphi_{ij},\varphi_{kl}\rangle$. **No Ricci hypothesis.**

**Statement.** $Q(R)=R^2+R^\#$ satisfies the same three conditions, and

$$\mathop{\mathrm{Ric}}(Q(R))_{ab}=\sum_{c,d}R_{ac,bd}\mathop{\mathrm{Ric}}(R)_{cd},\qquad \mathop{\mathrm{Ric}}(R)_{ab}=\sum_cR_{ac,bc}.$$

**Consequently $Q(\mathcal W_n)\subseteq\mathcal W_n$, and by polarisation $X,Y\in\mathcal W_n\Rightarrow X\circ Y\in\mathcal W_n$**: the Fox product is closed on the Weyl module, which is what every statement about $L_e$ on $\mathcal W_n$ rests on.

**Mechanism.** From [conventions.md](findings/conventions.md)'s structure-constant $\#$, $(R^\#)_{ij,kl}=B_{ijkl}-B_{ijlk}$ with $B_{ijkl}=\sum_{pq}R_{ip,kq}R_{jp,lq}$, and two Bianchi steps give $(R^2)_{ij,kl}=B_{ikjl}-B_{iljk}$, so $Q(R)$ is Hamilton's four-term combination of $B$, whose cyclic sum cancels identically. For the Ricci half, one Bianchi step inside $\mathop{\mathrm{Ric}}(R^\#)$ gives $\mathop{\mathrm{Ric}}(R^\#)=\sum R_{ac,bd}\mathop{\mathrm{Ric}}_{cd}-\mathop{\mathrm{Ric}}(R^2)$ exactly. **Neither half of $Q$ satisfies either condition alone.** The sign is pinned at $R=\mathrm{id}$, both sides $(n-1)^2\delta_{ab}$.

**Scope.** Corroboration of [BW08](references/boehm-wilking-2008-space-forms/notes.md) eq. (6), the Ricci half in a Ricci eigenframe, and of the exact $n=4$ closure of [r896](reviews/REVIEW_r896.md) and [r897](reviews/REVIEW_r897.md); it subsumes [Lemma L208](findings/curvature-invariants.md), the diagonal-locus case. Off $S^2_B$ the Ricci identity fails by exactly $\tfrac32\sum\mathop{\mathrm{Alt}}(R)_{iklm}\mathop{\mathrm{Alt}}(R)_{jklm}$, the wider form the record carries.

**Gate 2.** Passed, [r914](reviews/REVIEW_r914.md) and [r915](reviews/REVIEW_r915.md) on identical cold briefs, each re-deriving all four steps from the definitions rather than following the prose and agreeing on every one of eleven items, including the load-bearing Bianchi rewrite and swap of Step 4. The Bianchi hypothesis is spent in exactly two places, and off $S^2_B$ the defect is $\tfrac32\sum\mathop{\mathrm{Alt}}\mathop{\mathrm{Alt}}$ at $\mathop{\mathrm{Alt}}=\tfrac13b$.

**Proof:** [curvature-invariants.md](findings/curvature-invariants.md), the L209 block. The Ricci half is typed as `ric_Qop_eq` in [L209FoxClosure.lean](lean/HamiltonsCubic/Results/L209FoxClosure.lean) proved on the standard three axioms, both $\mathrm{id}$ anchors proved ([r1100](reviews/REVIEW_r1100.md)); the Bianchi half is `bianchi_Qop` and the closure $Q(\mathcal W_n)\subseteq\mathcal W_n$ with its polarisation is `Qop_isWeylOp` and `foxProd_isWeylOp` ([r1101](reviews/REVIEW_r1101.md)).

### Lemma L210 (problem). The de Rham reduction, done at the algebra so it costs no topology

**Hypotheses.** $M$ a locally symmetric space with $\mathop{\mathrm{Ric}}=\lambda g$ and $\lambda\ne0$, carrying the orthogonal involutive Lie algebra $(\mathfrak g,s,B)$ with $\mathfrak g=\mathfrak k\oplus\mathfrak p$ and $\mathfrak p\cong T_xM$. **Neither compactness nor simple connectivity is assumed.**

**Statement.** There is a decomposition $\mathfrak p=\bigoplus_{i=1}^r\mathfrak p_i$ into irreducible factors, with no Euclidean summand, such that the curvature tensor is block-diagonal: $R(X,Y)=0$ whenever $X$ and $Y$ lie in different factors, each factor is preserved, and $\mathop{\mathrm{Ric}}=\lambda g$ restricts to $\mathop{\mathrm{Ric}}_i=\lambda g_i$ on each factor with the same $\lambda$.

**Consequence, and what it still needs.** $r=1$ is [Lemma L47](findings/problem.md)'s irreducible case and $r\ge2$ is [Lemma L48](findings/problem.md)'s product case, with the shared-constant hypothesis that lemma needs now supplied. **Covering every compact Einstein symmetric space needs one step beyond this lemma**: $\lambda>0$, not merely $\lambda\ne0$. *Gorodski's irreducible includes the noncompact type, so the lemma removes the Euclidean factor and says nothing about type, while L47's census is of compact type. Corollary 3.1.4 with Lemma 2.1.2(b) gives each factor one-signed curvature fixed by its own $\lambda_i$, so a single global constant forces one type throughout, and compactness together with GLOBAL symmetry supplies $\lambda>0$, the noncompact-type irreducible spaces being noncompact.* **That is where the Theorem's compactness does its work.**

**Inputs, both cited.** [Gorodski](references/gorodski-symmetric-spaces-intro/notes.md)'s Proposition 3.1.2, $R_x(X,Y)Z=-[[X,Y],Z]$ on a **locally** symmetric space, and his Proposition 2.1.3, the splitting of an OIL-algebra into $s$-invariant ideals with one Euclidean and the rest irreducible, whose proof is linear algebra on $\mathfrak p$.

**Mechanism.** Distinct ideals of an internal direct sum commute, so the mixed curvature terms vanish outright by 3.1.2; the Euclidean factor has $[\mathfrak p_0,\mathfrak p_0]=0$ hence zero curvature and zero Ricci, which $\lambda\ne0$ forbids; and block-diagonality makes the global Einstein condition restrict to each factor with the same constant.

**Why at the algebra.** Propositions 2.1.3 and 3.1.2 carry no topological hypothesis, so the splitting is settled before covers, completeness or compactness arise, and those enter only where they are needed, at $\lambda>0$. *An earlier version of this entry justified the choice by saying the geometric route wants Myers; that is owed by neither route and is withdrawn.*

**Gate 2.** Passed with the corollary corrected, [r918](reviews/REVIEW_r918.md) and [r919](reviews/REVIEW_r919.md) on identical cold briefs, both confirming all four steps and both finding the reach short of what was claimed.

**Proof:** [problem.md](findings/problem.md), the L210 block. The mixed-term vanishing is typed in [L210DeRhamSplit.lean](lean/HamiltonsCubic/Results/L210DeRhamSplit.lean), three declarations `sorry`-free on `propext` alone.


### Lemma L211 (problem). A compact Einstein symmetric space has $\lambda>0$

**Hypotheses.** $M$ compact, **globally** symmetric, $\mathop{\mathrm{Ric}}=\lambda g$, and $W\ne0$.

**Statement.** $\lambda>0$, and every irreducible factor of $M$ is of compact type.

**Why it was needed.** [Lemma L210](findings/problem.md) splits the curvature and removes the Euclidean factor without any topological hypothesis, but Gorodski's *irreducible* includes the noncompact type, so L210 says nothing about type while [L47](findings/problem.md)'s census is of compact type. Both Gate 2 readers of L210 found this independently.

**Mechanism.** On an irreducible factor $K(X,Y)=\lambda_i\beta([X,Y],[X,Y])$ with $\beta|_{\mathfrak k}$ negative definite, so the type is the sign of the curvature and hence of the Einstein constant, and one global constant forces one type. If that type were noncompact then $\beta$ is positive somewhere on a semisimple $\mathfrak g$, so the transvection group $G$ is noncompact; but $M=G/K$ with $K$ compact makes $G\to M$ a compact-fibre bundle over a compact base, so $G$ would be compact.

**Which hypothesis does what.** Compactness and global symmetry enter only at the last step. *The witness is a compact quotient of $\mathbb{CH}^m$, $m\ge2$, which is compact, locally symmetric, Einstein with $\lambda<0$ and has $W\ne0$, and is excluded only by failing homogeneity. An earlier version of this entry named a closed hyperbolic manifold, which has constant curvature hence $W=0$ and so evidences nothing.*

**Consequence, and what is still owed.** With [L210](findings/problem.md), every compact GLOBALLY symmetric Einstein space with $W\ne0$ is irreducible of compact type or a product of such with one shared constant. *Two steps remain against the Theorem: the local reading is not covered, which is why the Theorem now says globally symmetric, and [L47](findings/problem.md)'s census is of compact spaces where this lemma delivers compact TYPE.*

**Gate 2.** Passed with four repairs, [r920](reviews/REVIEW_r920.md) and [r921](reviews/REVIEW_r921.md) on identical cold briefs.

**Proof:** [problem.md](findings/problem.md), the L211 block. Step 2's sign content is typed in [L211CompactType.lean](lean/HamiltonsCubic/Results/L211CompactType.lean), three declarations `sorry`-free over Mathlib's `killingForm`. Step 4 is not statable in the layer, needing a Lie group, a quotient and compactness.


### Lemma L216 (second-order). An explicit isolation radius at every quantitatively nondegenerate critical orbit

**Hypotheses.** $W_0$ a unit critical point with $\theta_0=P(W_0)>0$, $e=W_0/\theta_0$, and $\langle L_eH,H\rangle\le\tfrac12-\gamma$ for every unit $H\perp W_0$ orthogonal to $T_{W_0}\mathcal O$, with $\gamma>0$.

**Statement.** No critical point of $P$ on the unit sphere of $\mathcal W_n$ lies within geodesic distance $r=4\theta_0\gamma/(9(1+\sqrt{n-2}))$ of $\mathcal O=O(n)\cdot W_0$, other than points of $\mathcal O$. *Corollary: at $S^p\times S^q$ with $p,q\ge3$, $(p,q)\ne(3,3)$, $\gamma=\min(\tfrac1{2(p-1)},\tfrac1{2(q-1)},\tfrac12-\mu)$, and at the balanced product $\gamma=1/(n-2)$.*

**Why it matters.** The record stated that no isolation radius exists anywhere on it, and [I35](plan.md) was filed to supply one. **The obstruction I35 recorded, that the third-order remainder is a computation at one orbit and does not transfer, dissolves for $P$ itself**, whose remainder is bounded by [L143](findings/bounds.md)'s global $\sup\lvert P\rvert$.

**Mechanism.** Along the nearest-point great circle $\phi(\sigma)=P(\cos\sigma W_1+\sin\sigma H)$: $\phi'(0)=0$ by criticality, $\phi''(0)=6\theta_0(\langle L_eH,H\rangle-\tfrac12)\le-6\theta_0\gamma$, and $\phi$ is a degree-three trigonometric polynomial bounded by $M=1+\sqrt{n-2}$, so Bernstein gives $\lvert\phi'''\rvert\le27M$. Then $\phi'(\sigma)<0$ on $(0,r)$, so no point there is critical.

**Scope.** *It does not give the localisation it would finish, [L19](findings/problem.md) carrying no proposition, and padded $\mathbb{CP}^2$'s gap is not proved. The margin is attained exactly and the loss is all in the remainder.*

**Gate 1.** At $S^4\times S^4$, $S^3\times S^5$ and $S^6\times S^6$: $\tfrac12$-eigenspace of dimension $pq$, gap equal to the closed form, $\sup\phi''(0)=-6\theta_0\gamma$ to every printed digit, Bernstein slack about ten, no sampled direction turning $\phi'$ nonnegative below $0.6$.

**Gate 2.** **Landed: the lemma and its corollary CONFIRMED by both readers** ([r931](reviews/REVIEW_r931.md), [r932](reviews/REVIEW_r932.md), identical briefs, independently). *Step 1's range is stated as $0<s<r$ with $r\le\tfrac23$; the true radius is $\Omega(n^{-3/2})$, $\Theta$ belonging to the formula; [L147](findings/second-order.md)'s $P$-side branch is credited for the mechanism. At padded $\mathbb{CP}^2$ the gap is $\tfrac16$ and the radius about $0.0218$ at $n=12$, conditional on [I54](plan-verification.md).*

**Proof:** [second-order.md](findings/second-order.md#lemma-l216-an-explicit-isolation-radius-at-every-quantitatively-nondegenerate-critical-orbit), the L216 block. The Taylor step is proved in [L216IsolationRadius.lean](lean/HamiltonsCubic/Results/L216IsolationRadius.lean).


### Lemma L215 (second-order). An explicit bound on the quadratic map

**Hypotheses.** $X\in\mathrm{Sym}^2(\Lambda^2\mathbb R^n)$, symmetric and nothing else; $\mathcal W_n$ is the case the record uses.

**Statement.** $\lVert X^{\#}\rVert\le(n-2)\lVert X\rVert^2$, hence $\lVert Q(X)\rVert\le(n-1)\lVert X\rVert^2$.

**Why it matters.** It is the upper bound on $\kappa$ that [I96](plan.md)'s isolation estimate owed, which a sampled supremum cannot give ([r928](reviews/REVIEW_r928.md)). **The isolation radius the first version drew from it is withdrawn**: [r929](reviews/REVIEW_r929.md) refuted it in a fixed frame with a gauge-rotated balanced product, and [r930](reviews/REVIEW_r930.md) found it vacuous where stated, the only known gap belonging to a $D$ at which $N=0$ is forced.

**Mechanism.** [L153](findings/bounds.md)'s invariant polarised, $\sum_aA_a^{\mathsf T}A_a=2(n-2)\mathrm{Id}$, then Cauchy--Schwarz on the trace pairing followed by the identity $\sum_{ab}u_au_b=(\sum_au_a)^2$ for the sharp part, and $\sum\lambda^4\le(\sum\lambda^2)^2$ for the square. *The first version derived the invariant from Schur plus a count, which owes a clause at $n=4$; that argument is withdrawn.*

**Scope.** *The two equality cases exclude each other, rank one making $X^{\#}=0$, so the sum is never tight; measured slack is a factor of $7.9$ at $n=6$ and $8.1$ at $n=8$. A sharper constant $\sqrt{c(n-2)}$ follows from the same ingredients, its three candidate readings differing by factors of $\sqrt2$, and the sharpest coincides with [L143](findings/bounds.md)'s $1+\sqrt{n-2}$.*

**Gate 1.** L153's invariant at $n=3$ to $12$ with zero residual, both $\Lambda^2_\pm$ blocks at $n=4$ included, and the bound against sampled maxima at $n=5,6,8,10,12$.

**Gate 2.** **Landed: the bound CONFIRMED by both readers, the radius withdrawn, the engine recredited to L153** ([r929](reviews/REVIEW_r929.md), [r930](reviews/REVIEW_r930.md), identical briefs, independently).

**Proof:** [second-order.md](findings/second-order.md#lemma-l215-an-explicit-bound-on-the-quadratic-map), the L215 block. Three declarations in [L215QuadraticBound.lean](lean/HamiltonsCubic/Results/L215QuadraticBound.lean), `sorry`-free, with L153's invariant and the square bound as hypotheses.


### Lemma L214 (second-order). The frame split: two exact relations in every frame, and one inequality under the second-order cap

**Hypotheses.** $W$ a unit critical point, $F$ an **arbitrary** orthonormal frame, $D=\pi_FW$ the coordinate-diagonal part in $F$, $N=W-D$, $t=\lVert D\rVert^2$, $a=\langle L_DN,N\rangle$. For the inequality alone, $L_W\le\tfrac\theta2$ on $W^\perp$, which [L24](findings/second-order.md) gives at a maximiser with $\theta>0$.

**Statement.** $\theta t=P(D)+a$ and $\theta(1-t)=2a+P(N)$; and under the cap, $a\ge\tfrac\theta2t(1-t)$, equivalently $P(D)\le\tfrac\theta2t(1+t)$.

**Why it matters.** It is the foundation of [R24](routes.md), the primary route from 2026-09-13, and the first statement on the record that constrains a critical point through an arbitrary frame rather than its eigenframe. *Solving the first relation for $\theta$ gives the IDENTITY $\theta=\sqrt t\,P(d)+(1-t)\langle L_d\nu,\nu\rangle/\sqrt t$, whose decoupled relaxation is refuted as [post F67](findings/fence-posts.md): a successor must keep the two terms coupled.*

**Mechanism.** One scalar consequence of [L120](findings/second-order.md) at a $\Gamma$-fixed $D$, $\langle D\circ D,N\rangle=0$, kills every cross term; the two relations are criticality paired with $D$ and with $N$. The inequality is the cap at $X=tN-(1-t)D$, where $\langle L_WX,X\rangle=\theta t(1-t)-a$ and $\lVert X\rVert^2=t(1-t)$, the coefficient of $a$ collapsing to $-1$.

**Scope.** $t_F$ is the chosen frame's own value and never $\max_Ft_F$; no four-index inequality, no property of $F$ beyond orthonormality, and no diagonality of $W$.

**Gate 1.** Sixty random frames at $n=6$ and $n=8$: both relations to $3\times10^{-15}$, neither inequality violated.

**Gate 2.** **Landed: the lemma CONFIRMED by both readers, its consequence REFUTED** ([r926](reviews/REVIEW_r926.md), [r927](reviews/REVIEW_r927.md), identical briefs, independently). *The decoupled bound never improves on $\Theta_n$, the orbit direction giving $\Lambda_n\ge\Theta_n/2$ analytically, which is [post F67](findings/fence-posts.md). Two wording repairs applied and the prior art credited.*

**Proof:** [second-order.md](findings/second-order.md#lemma-l214-the-frame-split-two-exact-relations-in-every-frame-and-one-inequality-under-the-second-order-cap), the L214 block. Eight declarations in [L214FrameSplit.lean](lean/HamiltonsCubic/Results/L214FrameSplit.lean), `sorry`-free over an abstract totally symmetric trilinear form, the cancellation by an exact `linear_combination` certificate.


### Lemma L213 (problem). Each irreducible factor is itself compact

**Hypotheses.** $M$ compact, **globally** symmetric, $\mathop{\mathrm{Ric}}=\lambda g$, and $W\ne0$. **No hypothesis of its own beyond those**, which [L211](findings/problem.md) already spends.

**Statement.** Every de Rham factor $M_i$ of the universal cover $\widetilde M=\prod_iM_i$ is a compact simply connected irreducible symmetric space of compact type, and $\theta(M)=\theta(\widetilde M)$.

**Why it was needed.** [L211](findings/problem.md) delivers compact TYPE while [L47](findings/problem.md)'s census is of compact SPACES, and nothing on the record bridged the two ([r921](reviews/REVIEW_r921.md)). **It is not $M$'s own compactness that does it**: a compact quotient of $\mathbb{CH}^m\times\mathbb{CH}^m$ is compact with noncompact factors, so the type is what carries the step.

**Mechanism.** Compact type gives $\beta<0$ on $\mathfrak p_i$, Lemma 2.1.2(b) gives it on $\mathfrak k_i$ from effectiveness, and $\beta(\mathfrak k_i,\mathfrak p_i)=0$ with $\mathfrak g_i=\mathfrak k_i\oplus\mathfrak p_i$ joins them, so $\beta<0$ on $\mathfrak g_i$. Then Myers--Steenrod makes $K_i$ compact and Proposition 1.5.1(i) presents $M_i=G_i/K_i$, so $(G_i,K_i)$ is a symmetric pair of compact type and [Ziller](references/ziller-2010-lie-groups-symmetric-spaces/notes.md)'s **Proposition 6.38(c) is CITED for the conclusion** that $G_i$ and $M_i$ are compact. *Rebuilding it through $\mathrm{Inn}(\mathfrak g_i)$ fails: $\mathrm{Inn}(\mathfrak g_i)=G_i/Z(G_i)$, so that route needs Weyl's finiteness of the centre, and $S^3$ is the witness with transvection group $SO(4)$ over $SO(3)\times SO(3)$.* $\theta$ transfers to the cover because it is pointwise algebraic in $W$ and the covering is a local isometry.

**What still stands between it and the Theorem.** The word *globally*. A compact quotient of $\mathbb{CH}^6$ at $n=12$ is compact, locally symmetric, Einstein with $\lambda<0$ and has $W\ne0$, and nothing on the record bounds its $\theta$.

**Gate 2.** **Landed, the statement CONFIRMED by both readers with four repairs** ([r924](reviews/REVIEW_r924.md), [r925](reviews/REVIEW_r925.md), identical briefs, independently). *Step 4 reached the wrong group and now cites 6.38(c) instead; the hypothesis inventory was refuted, global symmetry being spent at step 2 as well; the identification of the de Rham factors with the algebra's ideals was asserted and is now sourced; and L47 needs $W_i\ne0$ per factor, which this does not deliver and does not need, L47 being consumed at $r=1$.*

**Proof:** [problem.md](findings/problem.md#lemma-l213-each-irreducible-factor-is-itself-compact-which-is-the-theorems-last-owed-clause), the L213 block. Three declarations in [L213FactorCompact.lean](lean/HamiltonsCubic/Results/L213FactorCompact.lean), `sorry`-free, `negDef_of_span` carrying the spanning as a binder after Gate 2 found the earlier statement short of definiteness.


### Lemma L212 (graded-half). The multi-block vertex solution is critical at every partition, and its second moment is the norm identity

**Hypotheses.** A partition $n=\sum_an_a$ with every $n_a\ge2$, and the **coordinate-diagonal** Weyl operator whose sectional matrix at $Q$-eigenvalue $\theta_g$ is $K_{ij}=\theta_g(n-n_a)/((n-1)(n_a-1))$ within a block $a$ and $K_{ij}=-\theta_g/(n-1)$ across blocks. **Nothing about local symmetry, Einstein metrics or irreducibility.**

**Statement.** $Q(W)=\theta_gW$ at every such partition, $t=\sum_{i\ne j}K_{ij}^2=8R\theta_g^2$ identically with $R:=\tfrac{k-1}8+\tfrac18(\sum_a\tfrac1{n_a-1}-\tfrac1{n-1})$, and at unit norm $\theta^2=1/(4R)$, whence $\theta<\sqrt{2/(k-1)}$ strictly at $k\ge2$.

**Why it matters.** [L05](findings/graded-half.md)'s chain consumed the norm-to-$\theta$ step as [L46](findings/problem.md), which is stated for IRREDUCIBLE symmetric spaces while the objects are products, failing outright on the census's strongly-regular and $\mathfrak{su}(m)$ items. **Criticality at every partition is what replaces it**, and $t=8R$ at every $k$ retires the multi-block norm identity's own debt above $k=4$, whose smallest uncovered case was $(S^2)^5$.

**Mechanism.** Criticality is $\Phi(K)=\theta_gK$ off the diagonal with $\Phi(M)=M^{\circ2}+M^2$, two displays at $\theta_g=1$ and homogeneity for the rest. The second moment is exact division: $m(n-m)^2-(n-1)^2$ vanishes at $m=1$, so summing gives $t=k-1-\tfrac1{n-1}+\sum_a\tfrac1{n_a-1}=8R$. And $\lVert W\rVert^2=t/2$ on the diagonal locus, so unit norm is $\theta_g=1/(2\sqrt R)$ where $\theta=\theta_g$ by criticality.

**Gate 1.** Exact rationals: $t=8R$ at eleven partitions to $k=7$, and $\theta^2=1/(4R)$ reproduces $\theta_0(4)$, $\theta_0(6)$, $\theta_0(12)$, $S^5\times S^7$ at $\tfrac{264}{175}$ and $S^2\times S^{10}$, all already on the record.

**Gate 2.** **Landed with two claims refuted and the value strengthened** ([r922](reviews/REVIEW_r922.md), [r923](reviews/REVIEW_r923.md), identical briefs, independently). *The $\lambda=\tfrac12$ hypothesis is NOT removed: [L46](findings/problem.md) reads $\theta=\lambda/\lVert W\rVert$, so the $2$ is $1/\lambda$ there, and $\theta_g$ is the Einstein constant. The display $\theta=1/(2\lVert W\rVert)$ with $\lVert W\rVert^2=R$ is unsatisfiable, three representatives of one family being in play, so the statement is $\theta^2=1/(4R)$. Ricci-flatness is automatic in $\mathcal W_n$ and is a well-posedness check rather than the discharge of a hypothesis. And the value and the bound are [ungraded-slack.md](findings/ungraded-slack.md)'s already, by a route with no Einstein hypothesis, so what is new here is criticality and the general-$k$ identity.*

**Proof:** [graded-half.md](findings/graded-half.md#lemma-l212-the-multi-block-vertex-solution-is-critical-at-every-partition-and-its-second-moment-is-the-norm-identity), the L212 block. The scale and bound arithmetic is typed in [L212VertexTheta.lean](lean/HamiltonsCubic/Results/L212VertexTheta.lean), three declarations `sorry`-free.


## Audit owed

Results numbered in [findings/INDEX.md](findings/INDEX.md) whose argument is on record but which a single reviewer, or none, has audited. They are listed so the reader knows they exist; none is cited above as a claim.

- **Lemma L0**, for $n\ge12$, $\sup\{P(W):\lVert W\rVert=1\}=\Theta_n$ **iff** $P\le\Theta_n$ at every critical point of $P|_{\lVert W\rVert=1}$, and each side is the $n\ge12$ clause of Conjecture A. **The constant is $\Theta_n$ and not $\theta_0(n)$**, the two agree at even $n$ and differ by $\theta_0^2-\Theta_n^2=8(n-1)/(n^2(n+1)(n-2))>0$ at every odd $n\ge13$, so the $\theta_0$ form asserted Conjecture A's own negation there ([r591](reviews/REVIEW_r591.md), [r592](reviews/REVIEW_r592.md), identical briefs, both REFUTED it and both repaired it this way). *The reduction moves the quantifier from $\mathcal W_n$ to the critical set and is separate from the cone bridge of Lemma L43, which fixes the target constant.* **The $\Leftarrow$ direction gives $\sup\le\Theta_n$; the lower half needs the balanced product as witness, which the block asserted and did not cite.** [problem.md](findings/problem.md)
- **Lemma L1**, Jäger's Theorem A repaired at even $n=12,14$ by evaluating his own expression exactly; a correction offered to the setter, audited PLAUSIBLE by [r497](reviews/REVIEW_r497.md) and [r498](reviews/REVIEW_r498.md), which reproduced the mathematics and found three load-bearing sentences unsupported. Its bound is also a corollary of Lemma L57, which supersedes it as a dependency and is proved in Lean in every orthonormal frame. [problem.md](findings/problem.md)
- **Lemma L68**, the symmetry defect on the diagonal locus in closed form. **For $M$ symmetric, hollow, with $M\mathbf1=0$ and $\mathop{\mathrm{tr}}M^2=2$, at a critical point**: $g_{ab}=2(s_a+s_b)-4\theta M_{ab}$; the entry cap $2\theta M_{ab}\le s_a+s_b$, with equality exactly at pairs agreeing off the pair; and the traced identity $\theta\lVert M\rVert_1=\sum_ad_a^+s_a-\tfrac12\Delta$, $\Delta$ summed over unordered positive pairs. **All four hypotheses are needed by the last clause**, which fails by a factor of two at $M=c(J-I)$, where only $M\mathbf1=0$ fails. Audited by [r519](reviews/REVIEW_r519.md) and [r520](reviews/REVIEW_r520.md), and again by [ROUND_L68](verification/ROUND_L68.md). [diagonal-half.md](findings/diagonal-half.md)
- **Lemma L72**, every critical point with exactly one positive and two negative eigenvalues has spectrum $(2,-1,-1)/\sqrt6$ on its support and $\theta=\sqrt{3/2}$, **not** closing Lemma L29's converse clause, that credit is withdrawn, L72 quantifying over critical points where the clause quantifies over equality points, but giving the spectrum at critical points of that signature by the criticality rows alone; one reviewer and the author. [stratum-two-negative.md](findings/stratum-two-negative.md)

- **Lemma L231** and **Lemma L232**, $P$ on the diagonal locus and $\theta$ at the sphere product, audited by one reviewer, [r1001](reviews/REVIEW_r1001.md). *One is the count the loop's own rule sets for a round comparing a machine-checked layer against the record rather than checking an argument, so this is disclosure rather than a debt.* The round CONFIRMED the definitions, the normalising constants and non-vacuity, and REFUTED the record's claim that L231 is [L57](findings/problem.md)'s bridge under another name, which is corrected wherever it appeared.
