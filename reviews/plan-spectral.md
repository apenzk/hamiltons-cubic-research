# plan-spectral, graded plan items for the spectral route (conditions on the eigenvalues alone)

Planner: plan-spectral (relaunch, 2026-09-02). Log: [agent_logs/plan-spectral.log](../agent_logs/plan-spectral.log). Screens run this session: seconds each, on objects I wrote down (a 10–20-variable LP built by hand, script kept at [vt_lp.py](../scripts/reviewers/plan-2026-09-02/vt_lp.py)); every figure below marked SCREEN is transcription insurance for a statement the executor proves by hand, and is evidence for nothing on its own.

**Notation.** $N=n(n-1)/2$; $\lambda$ the unit, trace-free $\Lambda^2$ spectrum; $T_{abc}=c_{abc}^2$ the squared structure constants of $\mathfrak{so}(n)$ in the eigenframe; the three complete per-index relations of [r331](REVIEW_r331.md): (A) $\sum_{bc}T_{abc}=2(n-2)$ on all of $\mathcal W_n$, (B) $\sum_{bc}\lambda_bT_{abc}=-2\lambda_a$ on all of $\mathcal W_n$, (C) $\sum_{bc}\lambda_b\lambda_cT_{abc}=2\lambda_a(\theta-\lambda_a)$ at a critical point. "The pinned LP at $\lambda$" is $\max\theta$ over totally symmetric hollow $T\ge0$ satisfying (A),(B),(C) at the fixed spectrum $\lambda$, with the pair cap $\sum_cT_{abc}\le2$ optional. Its domain: every $T$ that arises from a critical point of $\mathcal W_n$ with spectrum $\lambda$ is feasible, so its value upper-bounds $\theta$ at every such point.

**The two facts every item below turns on, both new to the record and both hand-provable:**

- **Value-type reduction.** The pinned LP at a spectrum with $d$ distinct values and multiplicities $m_1,\dots,m_d$ is invariant under $S_{m_1}\times\dots\times S_{m_d}$ permuting indices within a value class; averaging a feasible $T$ over that group preserves every constraint and $\theta$, so the optimum is attained at a class-uniform $T$, and the LP collapses to $\binom{d+2}{3}$ type-masses $N_{ijk}$ with $3d$ equalities of rank $3d-2$. At $d=3$ that is ten unknowns and seven independent equations. SCREEN: it returns exactly the record's values at $S^p\times S^q$ for $(p,q)\in\{(6,6),(5,7),(4,8),(3,9),(2,10),(4,4),(3,5),(5,5)\}$ and at padded $W_{\mathbb{CP}^2}$ for $n=5,8,12$, [r331](REVIEW_r331.md)'s seven-for-seven, re-derived.
- **Padding lemma.** If $(T,\theta)$ is feasible at $\lambda$ for $n$, then at $n'>n$ the padded spectrum $(\lambda,0^{N'-N})$ admits $(T',\theta)$ with $T'=T$ on old indices, a uniform mass $t=2(n'-n)/((N'-N)(N'-N-1))$ on (old, new, new) triples, a uniform mass $s\ge0$ on (new, new, new) triples fixed by (A) at the new rows, and zero elsewhere. (B) and (C) at old rows see no new mass because every new eigenvalue is $0$; (B) and (C) at new rows vanish because $\sum\lambda=0$ and the (new, old, old) block is empty. The true padded Weyl tensor has exactly this bracket pattern ($[\mathfrak{so}(n),\text{mixed}]\subset\text{mixed}$), which is why padded $W_{\mathbb{CP}^2}$ stays exact.

---

## Section 1, advance

### I27. The pinned LP at any fixed spectrum is a hand computation, and it excludes DERIVE-t11's witness

**Theorem it would produce.** We would be able to state that at every spectrum with $d$ distinct values the maximum of $\theta$ over the pinned class equals the maximum of a $\binom{d+2}3$-variable linear programme whose dual is a certificate of $3d$ numbers checkable by hand; and in particular that no critical point of $\mathcal W_{12}$ with the spectrum $(-m)^{30},(1.2m)^{20},(0.375m)^{16}$, $m=1/\sqrt{61.05}$, has $\theta>0.9243$, so [DERIVE-t11](DERIVE-t11.md)'s three-eigenvalue witness, which passes every per-row and budget condition at $\theta=1.29$, is excluded by the joint reading of (A),(B),(C) with $T\ge0$.

**Route.**
1. Prove the value-type reduction above from total symmetry and the class-invariance of (A),(B),(C) (domain: any totally symmetric hollow $T\ge0$; no Weyl input). Write the reduced system for $d=3$ explicitly: unknowns $N_{ijk}$ over multisets, row $i$ of (A): $\sum_{(j,k)\text{ ordered}}N_{ijk}=2(n-2)m_i$; of (B): $\sum\mu_jN_{ijk}=-2\mu_im_i$; of (C): $\sum\mu_j\mu_kN_{ijk}=2\mu_i(\theta-\mu_i)m_i$.
2. Prove the two dependencies: $\sum_i\mu_i(\mathrm A_i)=\sum_i(\mathrm B_i)$ and $\sum_i\mu_i(\mathrm B_i)=\sum_i(\mathrm C_i)$ (both by total symmetry and $\sum m_i\mu_i=0$, $\sum m_i\mu_i^2=1$), so the rank is $3d-2$. This is [Theorem C(c)](DERIVE-t11.md)'s consistency check in matrix form.
3. State the dual: multipliers $(\alpha_i,\beta_i,\gamma_i)$ per class with $\sum_i\gamma_i\mu_im_i=\tfrac12$ and, for every type $\{i,j,k\}$, $F_{ijk}:=\mathrm{Sym}[\alpha_i+\beta_i\mu_j+\gamma_i\mu_j\mu_k]\le0$, give $\theta\le\sum_im_i[\mu_i\beta_i+\mu_i^2\gamma_i-(n-2)\alpha_i]$. Domain: any critical point with that spectrum.
4. At the witness spectrum, solve the $10$-variable system by hand: the optimum vertex has $N_{000}=N_{012}=N_{122}=N_{222}=0$ (classes $0,1,2$ for $-m,1.2m,0.375m$), and $\theta_{\max}=0.9243$; record the seven-number dual certificate. SCREEN: max $0.924264$, min $-0.656987$, with and without pair caps.
5. Record the consequence for [DERIVE-t11 §5](DERIVE-t11.md): the per-row family and the budget are the one-row and uniform-multiplier sub-cases of step 3, and the witness is a statement about those sub-cases only.

**Grade.** closes 2 (it settles the blocked run [DERIVE-t11](DERIVE-t11.md) names and answers [r331 §6 item 6](REVIEW_r331.md)'s "exact at every critical spectrum?" in the fixed-spectrum half) × attackable 3 (the route is a group-averaging argument plus a ten-variable elimination; nothing on the record has tried it) × margin 1 (0.924 against 1.236 at the witness is 25% of room; at two-value spectra the LP is exact, so sharpness is intrinsic) × analytic 1 (ends in a seven-number certificate) $=6$.

**Fence-post screen.** Quantity bounded: $\theta$ at a fixed spectrum, from (A),(B),(C) and $T\ge0$. Grep over findings/ for "value-type", "type-mass", "doubly stochastic", "LP relaxation": hits are [bounds.md](../findings/bounds.md) (r331's value-type screen at padded $W_{\mathbb{CP}^2}$, $9\times6$ rank 6) and [post F42](../findings/fence-posts.md), whose closure is withdrawn in both directions and whose restated rule closes levers proved from (A),(B),(C) only when the lever is a pinned value; this item's lever is $T\ge0$ on the free part, which the rule names as live. [Post F10](../findings/fence-posts.md) concerns the (A)-only marginal LP. No recorded negative.

**Record screen.** Nearest: [r331 §2.2](REVIEW_r331.md)'s value-type averaging, used there as a numerical screen at one spectrum. Difference: this item proves the averaging is lossless (group invariance), which turns the 45,760-variable programme into a hand computation everywhere.

**What would falsify it.** A feasible $T$ at the witness spectrum with $\theta>0.9243$ found by any means; or a flaw in step 1's invariance (the pair cap and the hollow condition are both class-invariant, so I see none). If it fails, the failure is a fence post on the reduction. Worth: the reduction stands on its own even if the witness figure moves.

**Consumes / unblocks.** Consumes nothing. Unblocks I13, I9, I15, and retires the blocked run in [DERIVE-t11](DERIVE-t11.md).

### I13. Closed form of the pinned LP at two and three eigenvalues, kernel-free

**Theorem it would produce.** We would be able to state that at a two-value spectrum ($h>0$ with multiplicity $p$, $-m$ with multiplicity $q$, $\rho=h/m$, unit norm) every critical point has $\theta\le m\cdot\min\{n-1,\ (n-2)\rho^2-2\rho-1\}$, which improves [Theorem A](DERIVE-t11.md)'s chord $m[(n-2)\rho-1]$ on $\rho<n/(n-2)$ and agrees with it at the balanced product; and that the analogous piecewise-algebraic function at three values is $\max\theta$ over the pinned class, with its supremum over kernel-free three-value spectra at $n=12$ either $\le\theta_0(12)$ (then the pinned class closes the three-value regime) or $>\theta_0(12)$ at a named spectrum (then the spectral route needs Jacobi, I15).

**Route.**
1. Two values: four type masses $x=N_{+++},y=N_{++-},z=N_{+--},w=N_{---}$, rank-4 system, one free parameter. Show the optimum sits at $w=0$ for $\rho\le n/(n-2)$ and at $y=0$ for $\rho\ge n/(n-2)$ (nonnegativity of the last mass ends the family), and read off $\theta$. SCREEN: closed forms above, matching the LP at $k=20,25,29,30,31,33,40$ at $n=12$; the LP peaks at exactly $\theta_0(12)$ at $k=30$ and is strictly below Theorem A at $k=31$ ($1.0993$ vs $1.1921$).
2. Prove $\max_\rho$ of the two-value closed form is $\theta_0(n)$ at $\rho=n/(n-2)$, re-deriving Theorem A's conclusion with the stronger bound (domain: kernel-free two-value critical points; the branch $w=0$ says no three-negative brackets, $y=0$ says $E_+$ is a subalgebra, Lemma L71's structure appears at the vertex).
3. Three values: enumerate the vertices of the four-dimensional feasible polytope (ten masses, seven independent equalities, $\theta$ free) by hand; each vertex is four vanishing types, and $\theta$ at each is rational in $(\mu,m)$ after substituting the trace and norm constraints. Keep the vertex list as the deliverable.
4. Reduce the supremum over kernel-free three-value spectra at $n=12$ to one continuous parameter per multiplicity triple $(m_1,m_2,m_3)$, $\sum m_i=66$, all $m_i\ge3$ and all $\mu_i\ne0$, and bound each vertex expression by hand where possible (the $\Pi$-branch $\theta\le(n-1)|\lambda_{\min}|$ is one of them).
5. BLOCKED sub-item: evaluate the reduced LP over all multiplicity triples and the one-parameter family at $n=12$ (each LP ten variables, milliseconds; the sweep is a census and waits for approval). Outcome $\sup\le\theta_0(12)$: the pinned class closes the three-value kernel-free regime, and step 4 becomes a proof target. Outcome $\sup>\theta_0(12)$ at a spectrum $\lambda^\ast$: record $\lambda^\ast$ as the three-value analogue of r335's $n=6$ overshoot, and the route must consume Jacobi (I15).

**Grade.** closes 2 (the open regime named in the brief is three or more distinct eigenvalues) × attackable 2 (the two-value half is an hour; the three-value vertex enumeration is real labour and its supremum may need the blocked sweep) × margin 1 (the two-value profile is exact at the balanced product, so margin is intrinsic sharpness; the three-value margin is unknown) × analytic 1 $=4$.

**Fence-post screen.** Quantity: $\theta$ from (A),(B),(C), $T\ge0$, at fixed spectrum, then over spectra. Grep "over spectra", "T9", "bilinear": [bounds.md](../findings/bounds.md) records the $n=6$ free-spectrum overshoot $\ge1.392879$ ([r335](REVIEW_r335.md)) at a fifteen-value spectrum with eight near-zero eigenvalues, which is the kernel mechanism of I16 and is why step 4 is kernel-free. [Post F42](../findings/fence-posts.md) withdrawn. No negative on kernel-free three-value spectra.

**Record screen.** Nearest: [Theorem A](DERIVE-t11.md) (two values, $\theta\le B_n(\rho)$). Difference: the LP's small-$\rho$ branch is quadratic in $\rho$ and strictly below $B_n$; Theorem A's is linear.

**What would falsify it.** A three-value kernel-free spectrum at $n=12$ where the ten-variable LP returns $>\theta_0(12)$: step 5 finds it if it exists, and it is then worth a fence post naming the spectrum and the pinned class's failure in the kernel-free regime.

**Consumes / unblocks.** Consumes I27. Unblocks a proof of Conjecture A on the three-value stratum, or I15.

---

## Section 2, build

### I9. Every recorded spectral bound is a dual certificate of the pinned LP, and the balanced-product certificate in closed form

**Theorem it would produce.** We would be able to state the multiplier vector $(\alpha,\beta,\gamma)$ that turns each of Lemma L73, the $\Pi$-bound, the $\Sigma$-bound (Theorem C(e)), Theorem B's chord and tangents, and the improved two-value bound of I13 into one line: multiply (A),(B),(C) by the multipliers, add, and observe every type coefficient $F_{ijk}\le0$; and we would hold the certificate at the balanced product that proves $\theta\le\theta_0(n)$ at its spectrum with equality.

**Route.**
1. Take the dual form from I27 step 3 (domain: any critical point, any spectrum).
2. The $\Pi$-bound $\theta\le(n-1)|\lambda_{\min}|$: multipliers supported on the $\lambda_{\min}$ row; identify $\alpha,\beta,\gamma$ from [bounds.md](../findings/bounds.md)'s proof and check $F\le0$ on every type.
3. Lemma L73 and the $\Sigma$-bound: Lemma L73 uses (A),(B) at one row; the $\Sigma$-bound uses uniform $\gamma$ over negative rows and $\alpha,\beta$ chosen to cancel, read them off [Theorem C](DERIVE-t11.md)'s proof (e).
4. Theorem B's chord (i) and tangents (ii),(iii): each is a one-row certificate with $F$ the linear functional vanishing on the chord or tangent line of the two-moment hull ([r337](REVIEW_r337.md)).
5. The balanced-product certificate: at $\rho=n/(n-2)$ both vertex branches of I13 meet; solve the four-multiplier dual by hand and record it. SCREEN at $S^5\times S^7$: the optimal dual puts its weight on the (C) multipliers of every class and on (B) of the two smaller classes, with (A) multipliers of order $10^{-3}$.
6. State which recorded bounds are one-row certificates (Lemma L73, $\Pi$, Theorem B) and which couple rows (the $\Sigma$-bound, the LP optimum), the answer to the brief's "what the joint reading says beyond the per-row triangle family".

**Grade.** closes 1 (a sub-step: it organises, and supplies the certificate I13 step 4 needs) × attackable 3 (each step is a substitution into a filed proof) × margin 1 (intrinsic sharpness at the balanced product) × analytic 1 $=3$.

**Fence-post screen.** Quantity: $\theta$ from the same data as I27. Grep "certificate", "dual": no hits in findings/ for an LP dual reading. [Post F42](../findings/fence-posts.md)'s retro-explanation (all recorded bounds are $\{p,1,1\}$ or $\{p,0,0\}$ weights) is the same observation stated without the dual; no negative.

**Record screen.** Nearest: [Corollary B2/B3](DERIVE-t11.md) (per-row bounds dominate Lemma L70). Difference: this item shows the per-row family is the LP dual restricted to one row's multipliers, and names the coupling that the full dual adds.

**What would falsify it.** A recorded bound whose proof uses more than (A),(B),(C) and $T\ge0$, then it is outside the LP and worth recording as such (none is expected: [post F42](../findings/fence-posts.md) already lists them as pinned-weight bounds).

**Consumes / unblocks.** Consumes I27. Feeds I13 step 4.

### I15. What a fourth relation on the signed structure constants has to be: a support pattern the LP vertex must realise as a grading

**Theorem it would produce.** We would be able to state that any relation beyond (A),(B),(C) that cuts the pinned polytope is quadratic in the signed $c_{abc}$ (the Jacobi identity $\sum_d(c_{abd}c_{dce}+c_{bcd}c_{dae}+c_{cad}c_{dbe})=0$, i.e. $\sum_d\sigma_{abcde}\sqrt{T_{abd}T_{dce}}+\dots=0$ with a sign tensor $\sigma$ that no polynomial in $T$ carries), and that at an LP vertex it acts through the vanishing types: the set of nonvanishing types $\{i,j,k\}$ must be the multiplication table of a grading $\mathfrak{so}(n)=\bigoplus_iE_i$, $[E_i,E_j]\subset\bigoplus_{k:\,N_{ijk}\ne0}E_k$, closed under Jacobi; at two values the two branches are "$E_+$ is a subalgebra" ($\Pi$-branch) and "$[E_-,E_-]\perp E_-$" (chord branch), and both together are a symmetric pair with $\dim E_+=n(n-2)/4$, which is Lemma L71.

**Route.**
1. Write Jacobi in the eigenframe and observe that each term is a product of two signed constants sharing the summed index; squaring and summing over free indices gives the quartic contractions [r331 Q1](REVIEW_r331.md) shows reduce to (A),(B),(C); the cross terms carry $\sigma$. Domain: all of $\mathfrak{so}(n)$ in any orthonormal frame.
2. Prove: at a vertex of the value-type LP with vanishing types $Z$, any realising $T$ has $[E_i,E_j]\perp E_k$ for $\{i,j,k\}\in Z$, hence the grading rule. Read Jacobi as the closure condition $[E_i,[E_j,E_k]]\subset[E_i,\bigoplus_{l}E_l]$ on the pattern.
3. Two values: derive the subalgebra statement on the $\Pi$-branch and compute the Killing mass of $E_+$ as the LP's $x=N_{+++}=n(n-1)(n-\rho-2)/(\rho+1)^2$; since $x$ must be the Killing trace of a $p$-dimensional subalgebra of $\mathfrak{so}(n)$ in the ambient metric, the branch is cut to a classification list, the record's [Nikolayevsky Thm 1](../references/nikolayevsky-2011-pre-einstein-derivation/notes.md) arithmetic obstruction in this setting.
4. Three values at the witness of I27: the vertex pattern $Z=\{000,012,122,222\}$ gives $[E_2,E_2]\subset E_0$, $[E_1,E_2]\subset E_1$, $[E_0,E_2]\subset E_2$, $[E_0,E_0]\subset E_1\oplus E_2$; test Jacobi on it by hand.
5. State the shape: the fourth relation is the frame-realisability of the pattern, a Lie-theoretic (classification) constraint, and record it as the answer to the brief's question.

**Grade.** closes 1 (a sub-step of the Jacobi door [post F42](../findings/fence-posts.md) leaves open) × attackable 2 (step 3 is startable; steps 4–5 need judgement) × margin 1 × analytic 1 $=2$.

**Fence-post screen.** Grep "Jacobi", "signed", "grading": [LIT-jacobi](LIT-jacobi.md) (no source treats $T$ as an object), [post F42](../findings/fence-posts.md) names Jacobi/Bianchi as the live cases, [Payne Thm 13](../references/payne-2010-soliton-metrics/notes.md) (Jacobi quadratic and sign-dependent). No negative; the record predicts exactly this shape.

**Record screen.** Nearest: [Lemma L71](../findings/bounds.md) (saturation forces the balanced product). Difference: Lemma L71 is the case where both vertex branches vanish; this item gives the general vertex-to-grading rule.

**What would falsify it.** A vertex pattern that is Jacobi-closed for every spectrum (then the rule cuts nothing); worth a fence post on the "signed fourth relation" line.

**Consumes / unblocks.** Consumes I27 and I13's vertex lists. It is the route a $\sup>\theta_0$ outcome in I13 step 5 would need.

---

## Section 3, disprove

### I16. The pinned class cannot bound $\theta$ at $n=12$ once a kernel is allowed, a ten-variable hand witness

**Theorem it would produce.** We would be able to state that at $n=12$ the spectrum $(-a)^4,(b)^3,0^{59}$ with $a=\sqrt{3/28}$, $b=4a/3$ admits a totally symmetric hollow $T\ge0$ satisfying (A),(B),(C) and the pair cap with $\theta=2.2913>\theta_0(12)=1.2360$; hence no bound proved from (A),(B),(C), positivity and support alone can close Conjecture A over all unit Weyl operators, and every spectral-route item must either be kernel-free or carry a relation that is non-vacuous on zero rows.

**Route.**
1. Prove the padding lemma (top of file). Domain: any feasible $(T,\theta)$ at any $n$.
2. Prove its corollary: at a spectrum with a zero class of multiplicity $\ge3$, rows (B) and (C) at zero indices are vacuous and (A) at nonzero rows relaxes to $\le2(n-2)$ (the (old, new, new) mass is free). So the pinned LP at such a spectrum is at least the LP with (A) relaxed on the nonzero rows.
3. Solve the ten-variable value-type LP at $(-a)^4,(b)^3,0^{59}$ by hand and exhibit the optimal masses as the witness. SCREEN: $2.291288$ with caps at $n=12$ and $n=16$; $1.127459$ for the same nonzero values at $n=6$ with $0^8$. The same value $2.291288$ is on the record as the $n=8$ ceiling of the row-cap-dropped LP ([bounds.md](../findings/bounds.md), R14 closure), the same relaxation reached from the other side.
4. Record that padded $W_{\mathbb{CP}^2}$ stays exact under padding ($1.224745$ at $n=5,8,12$) while $S^3\times S^3$ padded from $6$ to $12$ rises from $1.054$ to $2.319$: exactness at a kernel spectrum is the exception. UNSCREENED beyond these two cases.
5. State the consequence for [T9](../plan.md) at $n=12$: the free-spectrum pinned LP at $n=12$ exceeds $\theta_0(12)$ (r335's $n=6$ spectrum pads to $\ge2.75$, SCREEN), so the kernel-allowed question is answered by hand and the live question is the kernel-free one (I13).

**Grade.** closes 2 (it decides a named open step, T9 at $n=12$, in the negative for kernel spectra, by hand) × attackable 3 (a page of algebra plus a ten-variable elimination) × margin 1 (overshoot $2.29$ against $1.24$) × analytic 1 $=6$.

**Fence-post screen.** Quantity: the pinned LP's value at kernel spectra. Grep "padding", "kernel", "zero eigenvalue": [bounds.md](../findings/bounds.md) padding-gap law (padded balanced products stay nondegenerate), [DERIVE-t11](DERIVE-t11.md)'s "kernel-free" hypothesis, [r335](REVIEW_r335.md)'s note that the $n=6$ optimiser drives eight eigenvalues to a near-kernel. No negative; the record observed the mechanism without naming it.

**Record screen.** Nearest: [bounds.md](../findings/bounds.md) "T9 has been run at $n=6$, and the pinned class does not close the conjecture", an $n=6$ statement, outside the conjecture's range. Difference: this item carries the failure to $n=12$ by hand and locates it in the kernel.

**What would falsify it.** An error in the padding lemma's (B)/(C) bookkeeping at zero rows (each is a two-line check), or a proved relation on zero rows beyond (A),(B),(C), which would itself be the fourth relation the brief asks for. If it fails, nothing is lost; if it holds, it is the fence post that keeps every future spectral item kernel-free.

**Consumes / unblocks.** Consumes nothing. Scopes I13 and I9 to kernel-free spectra; retires the free-spectrum T9 run at $n=12$ as a decision tool.

### I17. The symmetric doubly-stochastic reading is Hardy–Littlewood–Pólya majorisation and carries no $\theta$

**Theorem it would produce.** We would be able to state that [r338](REVIEW_r338.md)'s subset-sum family is exactly the majorisation $-\lambda/(n-2)\prec\lambda$ that follows from $\lambda$ being an eigenvector of the doubly stochastic $P=S/2(n-2)$; that it is implied by the pinned LP at every fixed spectrum; that its $|A|=1$ case is Lemma L73 in both directions ($\lambda_{\max}\le(n-2)|\lambda_{\min}|$ and $|\lambda_{\min}|\le(n-2)\lambda_{\max}$); and that no Schur-convexity argument on the spectrum reaches $\theta$, because every object the SDIEP toolbox produces is built from (A) and (B), which contain no $\theta$.

**Route.**
1. From (A),(B): $S=\sum_cT_{\cdot\cdot c}$ is symmetric, hollow, nonnegative, $S\mathbf1=2(n-2)\mathbf1$, $S\lambda=-2\lambda$ (domain: all of $\mathcal W_n$, [r338 U2](REVIEW_r338.md)). $P=S/2(n-2)$ is doubly stochastic, so $P\lambda\prec\lambda$ (HLP).
2. Unpack the partial sums: for every $k$, $\frac1{n-2}\sum_{i\le k}|\lambda|_{(i)}^{-}\le\sum_{i\le k}\lambda_{(i)}^{+}$ and its mirror, [r338](REVIEW_r338.md)'s family verbatim.
3. Show the family is a consequence of $T\ge0$ and (A),(B) alone, hence of the pinned LP at fixed spectrum, so it can exclude nothing the LP admits.
4. Show $\theta$ enters only through (C), i.e. through $R_{ab}=\sum_c\lambda_cT_{abc}$ with $R\mathbf1=-2\lambda$, $R\lambda=2\lambda\circ(\theta-\lambda)$, and that $R$ has mixed signs with no pinned row-sum for $|R|$, so no stochastic structure carries $\theta$. Record as the answer to the brief's Schur-convexity question.

**Grade.** closes 1 (settles a question the brief poses) × attackable 3 (HLP is a textbook theorem) × margin 1 × analytic 1 $=3$.

**Fence-post screen.** Grep "majoris", "Schur", "doubly stochastic": [bispectral.md](../findings/bispectral.md)'s shared-frame majorisation (a different pair of spectra, $\mu$ and $\omega$), [diagonal-half.md](../findings/diagonal-half.md)'s doubly stochastic $\tfrac n2M^{\circ2}$ (diagonal locus), ATTEMPTS entries 110–113 (Horn). None concerns $S$; no negative.

**Record screen.** Nearest: [r338](REVIEW_r338.md)'s subset-sum family, marked unexplored. Difference: it is named as HLP majorisation and placed inside the LP.

**What would falsify it.** A partial-sum inequality of the family that the LP at some fixed spectrum violates, impossible by step 3; so the item is a fence post by construction.

**Consumes / unblocks.** Nothing; closes the SDIEP line so no cycle is spent on it.

---

## (a) Where the region stands

The spectral route's whole content at a fixed spectrum is one linear programme, and this session reduced it from 45,760 variables to a hand computation whose dual is a short certificate; at every symmetric spectrum on the record it is exact, at two-value spectra it is strictly stronger than Theorem A and peaks at exactly $\theta_0(n)$ at the balanced product, and at DERIVE-t11's three-value witness it returns $0.924$, so the "three eigenvalues admit $\theta>\theta_0$" lead is closed. Against the goal it cannot finish alone: a zero eigenvalue class of multiplicity three makes two of the three relations vacuous on those rows, and a ten-variable witness at $n=12$ then reaches $2.29$, so any proof of Conjecture A over all unit Weyl operators from (A),(B),(C) must add a relation that sees kernel rows, and that relation is Jacobi on signed constants. The live analytic question is therefore the kernel-free one, whether the LP's supremum over kernel-free spectra with three or more values at $n=12$ stays below $\theta_0(12)$, and it is a finite piece of hand algebra per multiplicity pattern with one census blocked behind approval.

## (b) Claims on the record found doubtful, verification-loop candidates

- [DERIVE-t11 §5](DERIVE-t11.md): "the budget, the only joint relation available" and the witness "passes every condition ... with $\theta=1.29$". The joint LP is available and excludes the witness at $0.924$ (I27); the sentence is true of the per-row and budget sub-family only.
- [DERIVE-t11 Q4](DERIVE-t11.md): "S1 ... says nothing about $S$". The LP couples rows through $S$ and $R$ jointly, and it beats Theorem A at $\rho<n/(n-2)$ (I13 screen), so the joint content is more than the budget.
- [bounds.md](../findings/bounds.md) "T9 has been run at $n=6$, and the pinned class does not close the conjecture": the $n=6$ overshoot is against a maximum the conjecture does not assert; the statement holds at $n=12$ only through the kernel mechanism (I16), and the kernel-free case is unmeasured and unproved.
- [INDEX-traps.md](../findings/INDEX-traps.md) post F42 row still quotes "the full pinned relaxation ceilings at $1.5$–$3.7\times\theta_0$" beside "largely withdrawn"; [r337](REVIEW_r337.md) cites r324's figure as the full pinned system. Both are the single-row LP.
- [bounds.md](../findings/bounds.md): "the positive half is the $\Pi$-bound" is refuted by r337/r338's positive-row product criterion and by the two-value LP's chord branch.
- Lemma L73 is credited to (B) alone in [bounds.md](../findings/bounds.md) and derived from (C) twice in [DERIVE-t11](DERIVE-t11.md); I17 shows it is the $k=1$ HLP inequality from (A),(B).
- Lemmas 75–103 in [INDEX-results.md](../findings/INDEX-results.md) carry no Gate 2 audit.
