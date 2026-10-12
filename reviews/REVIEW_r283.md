# REVIEW r283, Gate 2, route D and the diagonality instruments

Reviewer 283. Commits under review: `5b50431` (primary), `d4813d1`, `37cac5b`.
Primary file: [findings/diagonality.md](../findings/diagonality.md). Supporting: [findings/stratum-two-negative.md](../findings/stratum-two-negative.md), [findings/second-order.md](../findings/second-order.md), [findings/fence-posts.md](../findings/fence-posts.md), [findings/target.md](../findings/target.md), [plan.md](../plan.md) route D, [references/jaeger-2016-diagonal-case/](../references/jaeger-2016-diagonal-case/), [report/sections/07-gradedness-split.tex](../report/sections/07-gradedness-split.tex) Lemma L66, [report/sections/09-status.tex](../report/sections/09-status.tex).
Scripts: [scripts/reviewers/r283/](../scripts/reviewers/r283/). Reviewer 284 runs the identical brief concurrently and independently.

Nothing below imports [scripts/b_diagonality_split.py](../scripts/b_diagonality_split.py), [scripts/b_cpm_closed_form.py](../scripts/b_cpm_closed_form.py) or [scripts/review_r30_core.py](../scripts/review_r30_core.py). [c2_instruments.py](../scripts/reviewers/r283/c2_instruments.py) builds $W_{\mathbb{CP}^m}$ from the **Fubini–Study curvature tensor** and subtracts the scalar part, then checks Ricci-flatness ($\le9.7\times10^{-17}$) and first Bianchi ($0$ exactly) before anything is measured, no isotypic closed form, no stored spectrum.

| # | Claim | Verdict |
|---|---|---|
| 1 | The direction argument, and D2's retracted lever | **THE RETRACTION IS CORRECT AND THE SOURCE SAYS WHAT IT IS QUOTED AS SAYING, BUT ITS "WHAT IS OWED" LIST IS PART ALREADY CLOSED AND PART MISDIRECTED.** [stratum-two-negative.md:59](../findings/stratum-two-negative.md) does read tight $\Rightarrow$ rank-$4$ $2$-plane $\Rightarrow$ non-diagonalisable, and composing with maximality yields nothing. **But item 1 of "what is owed" (whether a maximiser must make the chain tight), is answered by the same file**: the whole $k\le2$ stratum is capped at $\sqrt{3/2}<\theta_0(n)$ from $n=12$, so no maximiser is in it, tight or slack. And the tension **does** have a usable form in the direction it already points, which the file does not record: by [line 31](../findings/stratum-two-negative.md) the cap is saturated **identically** on that stratum, so *every* one-positive/two-negative element is Plücker-obstructed, verified here at padded $W_{\mathbb{CP}^2}$, negative eigenspace $\dim2$, $\min\lVert\omega\wedge\omega\rVert=0.5000$ |
| 2 | The three instruments and their domains | **(a) CONFIRMED with a scope correction, (b) CONFIRMED, (c) REFUTED, (d) EVERY NUMBER CONFIRMED.** Independently: $0.6124$, $0.6325$, $0.5000$ for Plücker and $0.836660$, $0.866025$, $0.707107$ for the frame-minimal mass, control $9\times10^{-7}$. **(c) is wrong in the record's own words**: the unitary-isotropy argument's flagship application in [ATTEMPTS.md](../ATTEMPTS.md) *is* padded $W_{\mathbb{CP}^2}$ (isotropy $U(2)\times O(n-4)$, measured here, $\dim=5,10,19$ at $n=6,8,10$), and it is applied there at $m\ge4$ as well. **And the table drops the one exact instrument**: [plan.md](../plan.md) names $\ker\Phi_W$ as the third, D1 substitutes the weakest |
| 3 | Is route D fenced? | **UNFENCED AS A STATEMENT, AND THE POST-22 READING IS BACKWARDS.** No post bounds it, because it produces no bound, confirmed post by post. But post F22 says the diagonality handle **carries no $\theta$ information**, which is the decoupling D2 must bridge, not a specification. **Post F3 is route D's real precursor and goes uncited**, and the maximiser-specific case is recorded as open in [problem.md](../findings/problem.md) item 11, so D re-opens a question on file. **Decisive: D2 is logically EQUIVALENT to Conjecture A** given the diagonal case, so [target.md](../findings/target.md)'s standing classification of restatements applies to it |
| 4 | Lemma L66 as it now stands | **STATEMENT AND PROOF CORRECT, MATCHING [support-dichotomy.md](../findings/support-dichotomy.md); TWO DEFECTS, ONE OF THEM IN THE RENDERED PDF.** The $\lvert a_i\rvert^3$ repair is present and load-bearing. `37cac5b` inserted the lemma **between Lemma L41 and Lemma L41's own `\begin{certificate}`**, so p.58 of [report.pdf](../report/report.pdf) reads that Verification as Lemma L66's, where "the identity holds to $12$ digits", "equality at all nine symmetric-space points" and "$1.236033=\theta_0(12)$" are all false of Lemma L66. And **r281's unstated ingredient is still unstated**: additivity needs total symmetry of the polarised trilinear form |
| 5 | What route D would buy | **CONFIRMED, AND IT BUYS MORE THAN D3 CLAIMS.** Maximiser diagonalisable $\Rightarrow$ Conjecture A at even $n\ge16$ by Jäger's Theorem A verbatim ($W^2+W^\#=\theta W$ **is** the sphere-critical equation, and $\theta\ge\theta_0(n)$ holds free because the sphere product is a competitor); $n=12,14$ by Lemma L1, which the ledger rules out of scope rather than unproven. **Nothing else would remain at even $n$.** D3's "odd $n$ is untouched" is stale: [findings/INDEX.md](../findings/INDEX.md) carries the diagonal case as proved at **every $n\ge4$, odd included** |
| 6 | Sweep r259–r282 and the index | **FIVE INDEX ROWS STILL MISSING AT THE THIRD ASKING, AND THREE MATHEMATICAL ITEMS STILL UNAPPLIED.** [reviews/INDEX.md](INDEX.md) runs $259$–$268$ then jumps to $274$; r269–r273 have files, and [REVIEW_r273.md](REVIEW_r273.md) is a full report. r279, r281 and r282 each filed this. Also live: [second-order.md:206](../findings/second-order.md)'s $M(n)/\sqrt2$ clause, killed by post F35; r281's total-symmetry ingredient, absent from both Lemma L66 and [support-dichotomy.md](../findings/support-dichotomy.md); and **post F26, cited by [plan.md](../plan.md) route D's own paragraph and defined in no findings file** |

---

## 1. The direction argument

**The source says what the retraction quotes.** [stratum-two-negative.md:59](../findings/stratum-two-negative.md) reads, in one sentence: the $(+--)$ term is tight only at $\lVert[v_{N-1},v_N]\rVert^2=2$; the cap forces both bivectors to rank $4$; a $2$-plane of rank-$4$ bivectors contains no decomposable element; that is the Plücker certificate. Every arrow points from *tightness* to *non-diagonalisability*. So the composition D2 wanted (maximality to diagonality), is not available, and `5b50431`'s reading is right. The plane really is all rank $4$: at the cap $\mathrm{im}\,X=\mathrm{im}\,Y$ is a $4$-plane and $X,Y$ anticommute with equal singular values ([line 128](../findings/stratum-two-negative.md)), so $\mathrm{span}\{X,Y\}\subseteq\Lambda^2_+$ of that $4$-plane, where $\omega\wedge\omega=\lvert\omega\rvert^2\mathrm{vol}\ne0$.

**But the first thing owed is already closed, in the file the lever comes from.** "Whether a maximiser must make that chain tight" is moot: the chain lives on the stratum with at most two negative eigenvalues, and that stratum is capped at $\sqrt{3/2}$, which is below $\theta_0(n)$ from $n=12$. So at every $n\ge12$ a maximiser is *outside* the domain where tightness is even defined. The bullet asks for something the same file proved unnecessary.

**And the tension has a usable form, running the way it already points.** [Line 31](../findings/stratum-two-negative.md) says the pair cap is saturated **identically** on the stratum (every orthonormal pair in $\Lambda^+\cong\mathfrak{su}(2)$ brackets to norm-squared $2$), not merely at the extremiser. Composed with line 59 that is a theorem, and it is not on file:

> **Every $W\in\mathrm{Weyl}_n$ with one positive and two negative eigenvalues is Plücker-obstructed, hence coordinate-diagonalisable in no frame.**

Measured at the stratum's extremiser: padded $W_{\mathbb{CP}^2}$ has spectrum $+0.816497$ (dim $1$), $-0.408248$ (dim $2$), $0$, and $\min\lVert\omega\wedge\omega\rVert=0.5000$ on **both** nonzero eigenspaces ([c2_instruments.py](../scripts/reviewers/r283/c2_instruments.py)).

**What that is worth to D2, stated exactly.** It is the *shape* D2 needs, proved on one stratum: the implication that closes Conjecture A is not "maximiser $\Rightarrow$ diagonalisable" but its contrapositive-friendly form

$$\text{Plücker-obstructed}\;\Longrightarrow\;\theta\le\sqrt{3/2},$$

which needs no arrow out of maximality at all, and of which [Lemma L35](../findings/stratum-two-negative.md) is the proved rank-$\le4$ case. **That is the mechanism the file says is missing, and it is a restatement of the record's own live target** ($\sup\{\theta:Q(W)=\theta W,\ S=0,\ \text{non-diagonal}\}\le\sqrt{3/2}$, [findings/INDEX.md](../findings/INDEX.md)) with "non-diagonal" strengthened to "Plücker-obstructed" and $S=0$ dropped. So the retraction is sound and the replacement it asks for is a route the record has been on for months under another name.

*One sharpening of the retraction's own hedge.* It writes "if a maximiser *did* make the chain tight, the implication would give maximiser $\Rightarrow$ non-diagonalisable". At $n\ge12$ that branch is empty by the stratum cap, so the hedge overstates the risk: the tension is vacuous at maximisers rather than dangerous.

## 2. The three instruments

### (a) Plücker, sufficient, and the argument is two lines

If $W$ is diagonal in the basis $\{e_a\wedge e_b\}$ of some orthonormal frame, every eigenspace is **spanned** by those $e_a\wedge e_b$ carrying its eigenvalue, hence contains decomposable elements. Contrapositive: an eigenspace meeting the Grassmann cone only at $0$ forbids any diagonalising frame. Rank is $O(n)$-conjugation invariant, so the test is frame-free. **Sufficient, never necessary** (an eigenspace can contain a decomposable without being spanned by one) which is [r75](REVIEW_r75.md)'s "only necessary" said from the other side, and the two are consistent.

**"Certified rather than numerical" is true of the three catalogued points and false of the instrument.** At $\mathbb{CP}^4$ and $\mathbb{CP}^5$ the obstructed eigenspace is **one-dimensional**, measured here: eigenvalue $+0.845154$ with $\dim1$ at $\mathbb{CP}^4$, $+0.843274$ with $\dim1$ at $\mathbb{CP}^5$, so "$\min$ over the eigenspace's unit sphere" is a single evaluation of the Kähler form's Pfaffian, with no search in it. At padded $W_{\mathbb{CP}^2}$ the obstruction is $\Lambda^2_\pm$ of a $4$-plane, where $\omega\wedge\omega=\lvert\omega\rvert^2\mathrm{vol}$ closes it in one line. At a general $W$ with a wide eigenspace the quantity is a non-convex minimisation over a sphere and carries no more certification than the mass does. The table's domain column should say so.

### (b) Frame-minimal mass, exact, and the reason is compactness

$O(n)$ is compact and $g\mapsto\lVert\text{offdiag}(\Lambda^2(g)W\Lambda^2(g)^{\mathsf T})\rVert$ is continuous, so the infimum is attained; it is $0$ exactly at a diagonalising frame. **Exact, and a global search, confirmed as stated.**

### (c) "Native dimension $4$ only", REFUTED, by the record and by the argument

Three separate failures.

1. **The record applies it above dimension $4$.** [ATTEMPTS.md](../ATTEMPTS.md) states the Proposition for $\dim V=2m\ge2$ with $K_1\subseteq U(m)$ and applies it *"in one shot"* to Fox's $\mathcal S^4(\alpha)$, the hyperkähler family $\mathbb B_r$ at $r\ge8$, and $\mathbb{HP}^m$ with $\mathrm{Sp}(m)\mathrm{Sp}(1)\subset U(2m)$.
2. **The stated witness is the argument's flagship case, not a counterexample to it.** D1 says padded $W_{\mathbb{CP}^2}$ is non-diagonalisable *"while its isotropy is not unitary"*. Padded $W_{\mathbb{CP}^2}$ **is** $\mathcal S^4(\alpha)$, and its isotropy is $\mathfrak u(2)\oplus\mathfrak{so}(n-4)$, measured here as $\dim=5,10,19$ at $n=6,8,10$ against $4+\binom{n-4}2=5,10,19$ ([c2c_isotropy.py](../scripts/reviewers/r283/c2c_isotropy.py)). The proposition asks for a unitary block on $V$, which is exactly what that is; it never asks for the whole isotropy to be unitary.
3. **The parity clause has no mechanism.** The lemma needs no element of the isotropy to be a reflection. For $g$ in the stabiliser of $W_{\mathbb{CP}^m}$, $gJg^{-1}=\pm J$. If $gJg^{-1}=J$ then $g\in U(m)$ and its $(-1)$-eigenspace has even dimension, so $g$ is no reflection; if $gJg^{-1}=-J$ then $J$ embeds the $(+1)$-eigenspace into the $(-1)$-eigenspace, so a reflection would need $2m-1\le1$. **Neither branch mentions the parity of $m$**, and grep finds no source in the record for *"$\mathbb{CP}^m$ at odd $m$ fails likewise"*.

### (d) The six numbers, every one reproduced

| point | Plücker $\min\lVert\omega\wedge\omega\rVert$ | recorded | frame-minimal mass | recorded |
| --- | --- | --- | --- | --- |
| $\mathbb{CP}^4$ ($n=8$) | $0.6124$ | $0.61$ | $0.836660=\sqrt{7/10}$ | $0.837$ |
| $\mathbb{CP}^5$ ($n=10$) | $0.6325$ | $0.63$ | $0.866025=\sqrt3/2$ | $0.866$ |
| padded $W_{\mathbb{CP}^2}$ ($n=8$) | $0.5000$ | $0.50$ | $0.707107=1/\sqrt2$ | $0.707$ |
| control, rotated $S^3\times S^3$ | $0.0000$ on every eigenspace |, | $9.0\times10^{-7}$ from $0.429$ | $0$ |

Convention for the wedge: $(\omega\wedge\omega)_{ijkl}=w_{ij}w_{kl}-w_{ik}w_{jl}+w_{il}w_{jk}$, which is what returns $0.5$ at a unit self-dual $2$-form on $\mathbb R^4$, worth naming in the file, since the doubled convention returns $1.00$ for the same point. **Two of the masses have closed forms the record quotes only as decimals**, $\sqrt{7/10}$ and $\sqrt3/2$.

### (e) The instrument the table drops

[plan.md](../plan.md) route D names the record's three instruments as *"the Plücker obstruction, the frame-minimal off-diagonal mass, and $\ker\Phi_W$"*. D1 keeps the first two and replaces $\ker\Phi_W$ with unitary isotropy, trading the only **necessary-and-sufficient** test for the one the file itself calls *"the one to distrust"*. [r75](REVIEW_r75.md)'s test is $W$ diagonal in some frame $\iff$ some $A\in\ker\Phi_W$, $\Phi_W(A)=[W,\delta_A]$, has pairwise-distinct sums $a_i+a_j$; the dimension corollary $\dim\ker\Phi_W<n$ is a hard non-diagonality certificate. A route whose crux is a diagonality statement should carry its exact test. *One caution the table would need if it did*: the dimension corollary is one-directional, padded $W_{\mathbb{CP}^2}$ has $\dim\ker\Phi_W=11\ge n=8$ ([target.md](../findings/target.md)) and is still non-diagonalisable, so it is the distinct-sums clause, not the dimension, that decides.

## 3. Is route D fenced?

**Post by post, no post reaches it, and for the reason the plan gives.** Posts 1, 2, 2b, 8, 10, 11, 12, 15, 17, 18, 19, 20, 21, 23, 26, 28, 29, 34, 35 each fence a *bound* on $\theta$ or on $M(n)$; route D's theorem contains no inequality. Posts 4, 5 fence the Łojasiewicz and chain-tightening routes; 7 asks a candidate *inequality* to see the crossover; 9 and 13 fence enumeration and census; 14, 16, 27 are about hypotheses and sampling. **Confirmed unfenced in the letter.**

**Post F22 does not specify route D; it is the obstacle route D has to cross.** Its sentence is *"use it to define the target set, not to bound $\theta$ on it"*, and the measurement behind it is that $\dim\ker\Phi_W=1$ at every $\mathbb{CP}^m$ **and** at random Weyl tensors whose $\theta$ differ by an order of magnitude. That is a statement that the diagonality invariant and $\theta$ are decoupled *in both directions*, and D2 is precisely an implication from a $\theta$-extremality hypothesis to a diagonality conclusion. Post F22 supplies route D with a **well-posed target set**, which is real and worth having; calling it "the specification" reads a licence into a negative result.

**Post F3 is route D's precursor and is cited nowhere in the new material.** *"Universal lifting is false, three independent ways"*, and [problem.md](../findings/problem.md) item 11 states the residue in as many words: *"not whether the lifting lemma holds universally (it doesn't), but whether it holds specifically for the actual global maximizer once $n\ge12$"*. **That is D2 verbatim.** So the answer to "has this been attempted and closed?" is: attempted at length, closed only in its universal form, and left open in exactly D2's form, with the instruments D1 tabulates built *for that attempt*. Route D is a re-opening, which is legitimate, but the file presents it as new ground and the honest framing changes what D2 may assume.

**And D2 is equivalent to Conjecture A, not weaker than it.** Given the diagonal case, maximiser-diagonalisable $\Rightarrow$ Conjecture A (claim 5); conversely Conjecture A says the maximiser is $S^{n/2}\times S^{n/2}$, which is diagonal, so Conjecture A $\Rightarrow$ maximiser-diagonalisable. The two are the same statement. [target.md](../findings/target.md)'s standing verdict on reformulations (*"Conjecture A rewritten, neither easier nor harder"*), therefore applies, and route D's grade of $3\times3\times2\times1=18$ prices an equivalence as though it were a reduction. *What survives that*: an equivalent statement can still be worth pursuing when it changes the admissible tools, and this one moves the problem from analysis to rank geometry. That case can be made; it is not the case the file makes.

## 4. Lemma L66

**The statement matches [support-dichotomy.md](../findings/support-dichotomy.md) word for word in content**, and the proof is right. $A_i\circ A_j=0$ for $i\ne j$ kills the cross terms, $\lvert P(A_i)\rvert\le M(n)$ needs only that $A_i$ is a unit vector and $P$ odd, $\sum\lvert a_i\rvert^3\le\max\lvert a_i\rvert\sum a_i^2$ is Hölder in one step, and $\max_i\lvert a_i\rvert<1$ follows from $k\ge2$ with every $a_i\ne0$. The **$\lvert a_i\rvert^3$ repair is present and is load-bearing** exactly as the remark says.

**Defect 1, the additivity step's real hypothesis is still unstated.** With $W=\sum a_iA_i$, $P(W)=\sum_{i,j,k}a_ia_ja_k\,T(A_i,A_j,A_k)$ where $T(X,Y,Z)=\langle X,Y\circ Z\rangle$. Killing every cross term needs $T(A_i,A_i,A_k)=0$ for $k\ne i$, which does **not** follow from $A_i\circ A_k=0$ until one knows $T$ is **totally symmetric**, then $T(A_i,A_i,A_k)=T(A_k,A_i,A_i)=\langle A_k,A_i\circ A_i\rangle=\langle A_i,A_k\circ A_i\rangle=0$. Total symmetry holds ($P$ is a cubic form and $\circ$ its polarisation), so the lemma is fine; but this is [r281](REVIEW_r281.md)'s claim-4 finding, filed against the same one-line proof, and it is unapplied in **both** the report and [support-dichotomy.md](../findings/support-dichotomy.md).

**Defect 2, the insertion point puts Lemma L41's Verification under Lemma L66, and it is in the PDF.** `37cac5b` added the lemma at [07-gradedness-split.tex:973](../report/sections/07-gradedness-split.tex), between the end of Lemma L41 and Lemma L41's `\begin{certificate}`. On p.58 of [report.pdf](../report/report.pdf) the block now reads immediately after Lemma L66's proof and remark:

> *"The identity holds to $12$ digits at $n=5,6,7,8,10$ … Equality holds at all nine symmetric-space points … at the balanced product the bound returns $1.236033=\theta_0(12)$ exactly, so it is sharp at the conjectured maximizer."*

Lemma L66 has no identity, no equality case (its conclusion is a strict inequality that *excludes* points), and no relation to $\theta_0(12)$; every clause belongs to Lemma L41's $\theta\le\lvert\lambda_{\min}\rvert(4(n-1)-\Delta-G_0)/4$, as does the paragraph after it about $\lvert\lambda_{\min}\rvert$ being uncontrolled. **Move Lemma L66 below the certificate and the paragraph.**

## 5. What route D would buy

**The assembly works, and Jäger's hypotheses are met without extra work.** Theorem A, quoted verbatim in [the reference note](../references/jaeger-2016-diagonal-case/README.md): *"Let $n\ge16$ be an even integer, and let $W\in\langle W\rangle_d$ with $\lVert W\rVert=1$ be given such that $W^2+W^\#=\theta W$ for a $\theta\ge\theta_0(n)$. Then $\theta=\theta_0(n)$, and $W$ is the normalized Weyl curvature of $S^{n/2}\times S^{n/2}$."* Three checks:

- **Criticality in his form is free.** $\nabla P=3Q(W)$, so a constrained maximiser has $Q(W)=\mu W$, and pairing with $W$ gives $\mu=P(W)=\theta$. That is $W^2+W^\#=\theta W$ exactly.
- **$\theta\ge\theta_0(n)$ is free.** $S^{n/2}\times S^{n/2}$ is a unit-norm competitor at $\theta_0(n)$, so the maximum is at least that.
- **Diagonality is $O(n)$-invariantly stated and $\theta$ is $O(n)$-invariant**, so "diagonalisable in some frame" may be replaced by "diagonal", without loss.

So a proof of D2 gives Conjecture A at **even $n\ge16$ outright**, and **nothing further would remain there**. At $n=12,14$ it rests on [response.md](../response.md) Lemma L1, whose status the record states plainly: [LEDGER.md](../findings/LEDGER.md) marks it *"NEVER AUDITED, and OUT OF SCOPE"* because the problem statement **grants** the diagonal case, and the grant, not Lemma L1, is what carries $12$ and $14$. That is the right reading and D3 should say it: what $12,14$ rest on is a grant, not a proof this project owns.

**D3's $n$-range clause is stale.** *"Odd $n$ is untouched and route D inherits nothing there"* contradicts [findings/INDEX.md](../findings/INDEX.md), which carries the diagonal case as *"now proved outright at every $n\ge4$, odd included"* with its one open lemma closed by **two independent Gate 2 proofs** (Reviewers 123, 124), and the odd constant $\Theta_n^2=\frac{2(n-1)(n-3)}{(n+1)(n-2)}$ agreeing with Reviewer 89's independent values. If that theorem stands, D2 closes the maximisation at **every** $n\ge4$, odd included, and route D's payoff is strictly larger than D3 claims. *The record is not self-consistent here and route D should not have to guess*: [problem.md](../findings/problem.md) heads the same result **"CANDIDATE … Gate 2 owed"** and says *"none audited"* of the steps other than step 3. One of the two lines is wrong, and D3 quoting neither is the visible symptom.

## 6. Sweep r259–r282, and the index

**The index, at the third asking.** [reviews/INDEX.md](INDEX.md)'s numbered rows run $259,\dots,268$ and then jump to $274$. Files exist for all five of r269–r273: r269–r272 are salvaged partials, and **[REVIEW_r273.md](REVIEW_r273.md) is a full report** on the ad-form / Cauchy–Schwarz route, co-source of post F34. r279 filed this, r281 filed it again with the row list enumerated, r282 filed it a third time. **Unrepaired.**

**Still unapplied, verified live in the tree today.**

| item | filed by | state |
| --- | --- | --- |
| [second-order.md:206](../findings/second-order.md) still reads *"What the cap needs is $\lvert\theta\rvert\le M(n)/\sqrt2\le\sqrt{3/2}$"* | r278, r279, r280 | **live**, post F35 says that conversion is the harmonic-square law and holds only on $\circ$-decomposables, which is the complement of the residual the sentence is about |
| the total-symmetry ingredient in the one-line theorem | r281 claim 4 | **live** in [support-dichotomy.md](../findings/support-dichotomy.md) *and* now in report Lemma L66 |
| **post F26 is defined in no findings file** | r282 | **live**, [plan.md](../plan.md) route D's own paragraph cites *"posts 6, 26, 33, 34, 35"*; the only occurrence outside the [findings/INDEX.md](../findings/INDEX.md) one-line index row is [ad-form-attempt.md:32](../findings/ad-form-attempt.md), which says it *failed at its own anchor*. A route is being justified against a post whose statement lives in an index row and whose refutation lives in a third file |
| [sym3-blocks.md](../findings/sym3-blocks.md) still heads its closing section *"What the certificate **would** establish"* | r280, r281, r282 | **live** |

**Applied, and correctly.** r281's $\lvert a_i\rvert^3$ repair reached both [support-dichotomy.md](../findings/support-dichotomy.md) and report Lemma L66; r281's refutation of the criticality-derives-$\circ$-orthogonality claim reached the file with its witnesses ($0.664362$, $0.272738$); r282's padding-dichotomy verdict reached [09-status.tex](../report/sections/09-status.tex) as the $s\ge12$ residual; the r259–r268 validations are in [plan.md](../plan.md)'s ledger with their validating reviewers named.

## Outside the brief

- **The two masses have closed forms.** $0.836660=\sqrt{7/10}$ at $\mathbb{CP}^4$ and $0.866025=\sqrt3/2$ at $\mathbb{CP}^5$, reproduced to $6$ digits by BFGS over $O(n)$ from $12$ starts. A minimiser hitting a surd to $6$ digits from every start is evidence the minimum is global, which is what the instrument's "global search" caveat asks for.
- **The Plücker obstruction is not confined to the top eigenspace.** At $\mathbb{CP}^4$ *every* nonzero eigenspace is obstructed, $0.5000$ at $-0.140859$ (dim $12$), $0.4564$ at $+0.056344$ (dim $15$), $0.6124$ at $+0.845154$ (dim $1$), and likewise at $\mathbb{CP}^5$. The zero eigenspace of padded $W_{\mathbb{CP}^2}$ contains decomposables ($0.0000$, dim $25$), as it must. So the instrument has more margin than the single quoted number suggests, and quoting one number per point hides which eigenspace it came from.
