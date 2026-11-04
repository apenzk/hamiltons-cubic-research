# Review r336, Lemma L73, the T10 closure, T9, the Payne fence, and the per-row (C) family

**Reviewer 336, cold brief, own implementation.** Everything below was computed from the definitions with code written for this review: $\mathfrak{so}(n)$ realised as $v_{ij}=E_{ij}-E_{ji}$ with $\langle A,B\rangle=\tfrac12\mathop{\mathrm{tr}}(A^{\!\top}B)$ (so the $v_{ij}$ are orthonormal and $c_{abc}=\langle[v_a,v_b],v_c\rangle$ is totally antisymmetric); $\mathcal W_n$ as the nullspace of first Bianchi plus Ricci inside $\mathrm{Sym}^2(\Lambda^2)$, returning $35,84,168,300$ at $n=5,6,7,8$; and $W^\#_{ab}=\tfrac12c_{agd}c_{bef}W_{ge}W_{df}$, which reproduces $\langle v,W^\#v\rangle=-\tfrac12\mathop{\mathrm{tr}}(\mathrm{ad}(v)W\mathrm{ad}(v)W)$. Controls: $Q$ maps $\mathcal W_n$ to itself to $5\times10^{-16}$; every catalogue point returns criticality residual $\le4\times10^{-15}$; $\theta_0(6)=1.054093$ and $\sqrt{3/2}=1.224745$ are hit on the nose. Scratch in [scripts/reviewers/r336/](../scripts/reviewers/r336/). Nothing from r335 was read.

**Method note.** Every numeric statement is a *screen* of a claim asserted on other grounds, and is labelled as one. The verdicts on S1, S4 and S5 are settled by algebra; the screens only refuse to contradict them.

---

## Verdicts at a glance

| claim | verdict |
|---|---|
| **S1** Lemma L73 derivation, normalisation, symmetrisation | **CONFIRMED** |
| **S1** "at every critical point" | **REFUTED AS STATED**, holds on all of $\mathcal W_n$ (already folded in); and the record's repair still understates it, see the strengthening below |
| **S1** not implied by tracelessness | **CONFIRMED** |
| **S1** constant $n-2$ sharp on $\mathbb{CP}^m$ and every maximal torus, mechanism as stated | **CONFIRMED** |
| **S1** slack at every sphere product | **CONFIRMED** |
| **S1** nonvacuous off the critical set | **CONFIRMED in the $\varepsilon$ sense, UNDECIDED for exact saturation** |
| **S2** the T10 closure, the pinned LP is unsharp at generic critical points | **CONFIRMED**, on $20$ points rather than $2$ |
| **S2** the $0.2296/0.2287$ residue | **COINCIDENCE**, settled |
| **S3** $\max\theta=1.340542$ at $n=6$ | **REFUTED AS STATED**, that is a lower bound; I reach $1.366272$ |
| **S3** outcome (iv), "realizable overshooting spectrum $\Rightarrow$ counterexample" | **REFUTED**, the optimal spectrum *is* realizable and is not a counterexample |
| **S4** "no route may propose to reach Jacobi through $T$" | **REFUTED AS STATED**, three separate defects, repair below |
| **S5** the case split $\lambda_a\gtrless0$ | **CONFIRMED** |
| **S5** the range $[m_a,M_a]$ over distinct $b,c\ne a$ | **CONFIRMED** |
| **S5** "Lemma L70 is exactly the $\lambda_{\min}$ member" | **REFUTED AS STATED**, Lemma L70 is the *weaker* all-pairs form |
| **S5** $2.041241$ at padded $W_{\mathbb{CP}^2}$ | **CONFIRMED** (it is the $n=8$ figure) |
| **S5** "coinciding with both at the balanced products and at the tori" | **REFUTED**, at the tori it coincides with Lemma L70 only, and is $3$–$5\times$ worse than the $\Pi$-bound |

---

# S1, LEMMA L73

## The derivation is correct, line by line

Row $a$ of (A) reads $\sum_{b,c}T_{abc}=2(n-2)$ over **ordered** pairs, so $\mu_a(b,c):=T_{abc}/2(n-2)$ is a probability measure. Row $a$ of (B) reads $\sum_{b,c}\lambda_bT_{abc}=-2\lambda_a$, so $\mathbb E_{\mu_a}[\lambda_b]=-\lambda_a/(n-2)$. Total symmetry of $T$ gives $\mathbb E_{\mu_a}[\lambda_c]=\mathbb E_{\mu_a}[\lambda_b]$, hence $\mathbb E_{\mu_a}[\tfrac{\lambda_b+\lambda_c}2]=-\lambda_a/(n-2)$. The symmetrisation is therefore cosmetic ($\mathbb E_{\mu_a}[\lambda_b]$ alone carries the whole argument) but it is not *wrong*, and it is what makes the strengthening below visible. An expectation lies in the closed convex hull of its integrand's values, so $\lambda_{\min}\le-\lambda_a/(n-2)\le\lambda_{\max}$; at $a=\arg\max$ this is $\lambda_{\max}\le(n-2)\lvert\lambda_{\min}\rvert$ and at $a=\arg\min$ it is $\lvert\lambda_{\min}\rvert\le(n-2)\lambda_{\max}$. **Confirmed.**

## Criticality: settled, and the coordinator's follow-up on $\mu_a$

(A) needs nothing at all, and this is worth writing down because the record treats it as an input rather than an identity. For any $X\in\mathfrak{so}(n)$,

$$\sum_{b,c}\langle[X,v_b],v_c\rangle^2=\lVert\mathrm{ad}(X)\rVert_{\mathrm{HS}}^2=-\mathop{\mathrm{tr}}(\mathrm{ad}X\,\mathrm{ad}X)=-K(X,X)=2(n-2)\langle X,X\rangle,$$

using the Killing form $K(X,Y)=(n-2)\mathop{\mathrm{tr}}(XY)=-2(n-2)\langle X,Y\rangle$ in this normalisation. So the row mass is $2(n-2)$ for *every unit vector of $\mathfrak{so}(n)$*, hence in every orthonormal basis, hence in $W$'s eigenbasis, no Weyl condition, no criticality, no choice of $W$ at all. **$\mu_a$ is a probability measure for free.** *Screen: the row mass is exactly $6,8,10$ at $n=5,6,7$ in the standard basis and unchanged under the eigenbasis rotation.*

(B) is where the hypotheses live, and an isolation run pins them exactly. Building four subspaces of $\mathrm{Sym}^2(\Lambda^2\mathbb R^6)$ and testing $\big\lvert\sum_{bc}\lambda_bT_{abc}+2\lambda_a\big\rvert$ on random elements of each:

| subspace | dimension | max (B) residual |
|---|---|---|
| $\mathcal W_6$ (Bianchi + Ricci-flat) | $84$ | $4.2\times10^{-15}$ |
| algebraic curvature tensors (Bianchi only) | $105$ | $8.1\times10^{-1}$ |
| Ricci-flat only | $99$ | $9.5\times10^{-1}$ |
| $\mathrm{Sym}^2(\Lambda^2)$, no condition | $120$ | $1.0\times10^{0}$ |

So (B) consumes **both** conditions and **no criticality**, and Lemma L73 holds on all of $\mathcal W_n$. This matches what the coordinator reports as independently verified and already folded in. *Screen at $n=5,6,7,8$ over $400$ random Weyl tensors each: the minimum slack in Lemma L73 is $0.55,0.96,1.19,1.37$, the inequality never comes close to failing off the critical set.*

## A strengthening the record still misses

The support of $\mu_a$ excludes $b=c$ **and** $b,c=a$, because $T$ vanishes on repeated indices. So $\tfrac{\lambda_b+\lambda_c}2$ does not range over $[\lambda_{\min},\lambda_{\max}]$ but over the average of two *distinct* eigenvalues, neither of them $\lambda_a$. Writing $\lambda_{(1)}\ge\lambda_{(2)}\ge\dots\ge\lambda_{(N)}$,

$$\frac{\lvert\lambda_{\min}\rvert}{n-2}\;\le\;\frac{\lambda_{(1)}+\lambda_{(2)}}2,\qquad \frac{\lambda_{\max}}{n-2}\;\le\;\frac{\lvert\lambda_{(N)}\rvert+\lvert\lambda_{(N-1)}\rvert}2 .$$

This is **strictly stronger than Lemma L73 whenever the relevant extreme eigenvalue is simple**, and identical when it is repeated. It costs nothing: both saturating families keep it tight, because at $\mathbb{CP}^m$ the minimum has multiplicity $\dim\mathfrak m=m(m-1)$ and at the torus it has multiplicity $N-m$, measured slack $0.0$ to $5\times10^{-13}$ at $n=6,8,10$ in both families. It changes nothing on the two-eigenvalue family (both eigenvalues repeated for $2\le r\le13$), and it is exactly what bites at generic critical points, where all $15$ eigenvalues are simple. **This is the same excluded-index effect that turns out to govern S5 below, and the record has now missed it twice.**

## Tracelessness

$0=\sum_a\lambda_a\ge\lambda_{\max}+(N-1)\lambda_{\min}$ gives $\lambda_{\max}\le(N-1)\lvert\lambda_{\min}\rvert$, attained at $(N-1,-1,\dots,-1)$, so $N-1$ is exactly what tracelessness gives. $N-1=\tfrac{n(n-1)}2-1>n-2$ iff $n>2$. **Confirmed for every $n\ge3$**, and the gap is enormous, $14$ against $4$ at $n=6$.

## Sharpness, and the mechanism

Reproduced independently, own Weyl basis, own $\#$, criticality residuals $\le4\times10^{-15}$:

| point | $n$ | $\theta$ | $\lambda_{\max}/\lvert\lambda_{\min}\rvert$ | $n-2$ |
|---|---|---|---|---|
| $\mathbb{CP}^3$ | $6$ | $1.054093$ | $\mathbf{4.000000}$ | $4$ |
| maximal torus | $6$ | $0.645497$ | $\mathbf{4.000000}$ | $4$ |
| $S^3\times S^3$ | $6$ | $1.054093$ | $1.500000$ | $4$ |
| $\mathbb{CP}^4$ | $8$ | $0.986013$ | $\mathbf{6.000000}$ | $6$ |
| maximal torus | $8$ | $0.540062$ | $\mathbf{6.000000}$ | $6$ |
| $S^4\times S^4$ | $8$ | $1.145644$ | $1.333333$ | $6$ |
| $\mathbb{CP}^5$ | $10$ | $0.948683$ | $\mathbf{8.000000}$ | $8$ |
| maximal torus | $10$ | $0.474342$ | $\mathbf{8.000000}$ | $8$ |
| $S^5\times S^5$ | $10$ | $1.200000$ | $1.250000$ | $8$ |

The mechanism is correct and reads off the equality case cleanly. Saturation of $\lambda_{\max}\le(n-2)\lvert\lambda_{\min}\rvert$ is equality in $\mathbb E_{\mu_a}[\tfrac{\lambda_b+\lambda_c}2]=\lambda_{\min}$ at $a=\arg\max$, i.e. $\mu_{\arg\max}$ concentrated on $E_{\min}\times E_{\min}$: for unit $v\in E_{\max}$, $c_{vbc}=0$ unless $b,c\in E_{\min}$. Taking $b\in E_{\max}$ forces $[E_{\max},E_{\max}]=0$; taking $b\notin E_{\min}$ forces $\mathrm{ad}(v)$ to annihilate $E_{\min}^{\perp}$; and what remains is $\mathrm{ad}(v)E_{\min}\subseteq E_{\min}$. That is exactly the record's "$E_{\max}$ abelian, $[E_{\max},E_{\max}]=0$, $[E_{\max},\cdot]\subseteq E_{\min}$", **confirmed**, with the refinement that the abelian condition is the *consequence*, not the hypothesis; the hypothesis is the support condition.

Both families satisfy it structurally. At the torus, $E_{\max}=\mathfrak h$ (multiplicity $m=n/2$: measured $3,4,5$ at $n=6,8,10$) and $E_{\min}$ is the root space; $[\mathfrak h,\mathfrak h]=0$ and $[\mathfrak h,\mathfrak g_\alpha]\subseteq\mathfrak g_\alpha$. At $\mathbb{CP}^m$, $\Lambda^2\mathbb R^{2m}$ splits under $\mathfrak u(m)$ as $\mathbb R z\oplus\mathfrak{su}(m)\oplus\mathfrak m$ of dimensions $1,\,m^2-1,\,m(m-1)$ (measured $1,8,6$ at $n=6$ and $1,15,12$ at $n=8$), with $E_{\max}=\mathbb Rz$, $E_{\min}=\mathfrak m$; $z$ is central in $\mathfrak u(m)$ so it annihilates $\mathbb Rz\oplus\mathfrak{su}(m)=E_{\min}^\perp$ and preserves $\mathfrak m$. **The record's claimed mechanism is right, and it is the same mechanism in both families.** The identity $2(m-1)=n-2$ is trivial arithmetic once $n=2m$.

*One point of order:* the equality case does **not** read as $[\mathfrak h,\mathfrak h]=0$ "at the torus" in the sense of a check independent of the derivation, $[\mathfrak h,\mathfrak h]=0$ is a *consequence* of the support condition and holds for any $W$ whose $E_{\max}$ is $\mathfrak h$. It is a consistency check, not an independent one. The record's sentence overstates it mildly.

## Slack at the sphere products, and the two-eigenvalue boundary

Slack at every sphere product tested, unbalanced ones included, and the slack widens with $n$: $S^3\times S^5$ gives $2.5$ against $6$, $S^3\times S^7$ gives $3.5$ against $8$, $S^4\times S^6$ gives $2.0$ against $8$, and the balanced ones sit at $1.5,\,1.333,\,1.25$ for $n=6,8,10$. **So the bound cuts away from the extremum, as claimed.**

The two-eigenvalue claim is exact and checkable by hand. With $r$ copies of $a>0$ and $15-r$ of $b<0$, tracelessness gives $a/\lvert b\rvert=(15-r)/r$, and Lemma L73 is $(15-r)/r\le4$ and $r/(15-r)\le4$, i.e. $3\le r\le12$. *Screen: my own pinned LP is infeasible at $r=1,2,13,14$ and feasible at $3\le r\le12$, matching the record's line exactly.*

## The coordinator's three follow-ups

**(a) Does anything reintroduce criticality?** No. Settled above: (A) is the Killing form and is free of every hypothesis; (B) consumes Bianchi and Ricci-flatness and nothing else. Note that (C) (the only relation carrying criticality), **does not appear in the derivation at all**.

**(b) Is $n-2$ still unimprovable on all of $\mathcal W_n$?** Yes, and the question answers itself once the hypothesis is dropped: the saturating points are elements of $\mathcal W_n$, so the supremum of $\lambda_{\max}/\lvert\lambda_{\min}\rvert$ over $\mathcal W_n$ is squeezed between the lemma ($\le n-2$) and the $\mathbb{CP}^m$ witness ($=n-2$). Nothing can push past it, because the lemma is now a theorem on $\mathcal W_n$. **Recorded as a trap:** a Nelder–Mead maximisation of the ratio over $\mathcal W_n$ returned only $2.43,\,2.77,\,3.12,\,3.17$ at $n=5,6,7,8$ (*below* the known witness value $n-2$) because the optimiser cannot navigate $35$ to $300$ dimensions. Anyone who runs that search and reports its output as the maximum will conclude the constant can be improved, and be wrong.

**(c) Is the strengthened form nonvacuous off the critical set?** **Yes in the quantitative sense, and that is the sense that matters for I24.** Perturbing $W_{\mathbb{CP}^3}$ inside $\mathcal W_6$ along a random Weyl direction:

| $t$ | $\lambda_{\max}/\lvert\lambda_{\min}\rvert$ (bound $4$) | criticality residual |
|---|---|---|
| $0$ | $4.000000$ | $0$ |
| $10^{-3}$ | $3.995591$ | $0.0014$ |
| $10^{-2}$ | $3.948005$ | $0.0151$ |
| $3\times10^{-2}$ | $3.900990$ | $0.0400$ |
| $10^{-1}$ | $3.594075$ | $0.1354$ |

The constraint is active to within any $\varepsilon$ on an open set of **non-critical** Weyl tensors, so it is not a statement whose content lives only on the critical locus. **But exact saturation is another matter, and I could not produce a non-critical saturator.** In both known saturating families the saturation condition forces $W$ into the invariant subspace, $x\,P_{\mathfrak h}+y\,P_{\mathrm{roots}}$ at the torus, $x\,P_z+y\,P_{\mathfrak{su}(m)}+z\,P_{\mathfrak m}$ at $\mathbb{CP}^m$, and intersecting that with $\mathcal W_n$ leaves a line, which is the critical point up to scale. So within those two families exact saturation *is* confined to the critical set. Whether some third configuration saturates off it is **UNDECIDED**; what would decide it is a classification of the pairs $(E_{\max},E_{\min})$ with $\mathrm{ad}(E_{\max})$ supported on $E_{\min}$, which is a Lie-algebraic question and not a numerical one.

**A caution for I24 that the record should carry.** At the pinned relaxation's own free-spectrum maximiser (S3 below), $\lambda_{\max}/\lvert\lambda_{\min}\rvert=1.4026$ against a bound of $4$. **Lemma L73 is completely inactive there.** Adding it to the spectral optimisation at $n=6$ removes nothing from the overshoot, so a *family* of such conditions has to be genuinely different in kind from this one to reach $\theta\le\theta_0$; more moment ranges read off the same two rows will not do it.

---

# S2, THE T10 CLOSURE

**CONFIRMED, and on a much wider base than the record's two points.** Own Newton solve (least-squares on $Q(W)-\theta W$ in Weyl coordinates, exact projection, residuals $\le5\times10^{-15}$) produced $20$ distinct critical points of $\mathcal W_6$ with $10$ to $15$ distinct eigenvalues. Own LP: $455$ unordered-triple variables $T_{a<b<c}$ plus $\theta$, with $45$ equalities

$$\sum_{b<c}T_{abc}=n-2,\qquad \sum_{b<c}(\lambda_b+\lambda_c)T_{abc}=-2\lambda_a,\qquad \sum_{b<c}\lambda_b\lambda_cT_{abc}-\lambda_a\theta=-\lambda_a^2 .$$

**The LP is unsharp at all $20$.** Gaps $\max_{\mathrm{LP}}\theta-\theta$ run from $0.0888$ to $0.5206$, mean $\approx0.29$, standard deviation $\approx0.11$. The record's conclusion (sharpness is a property of the symmetric, eigenvalue-degenerate catalogue and fails off it), **stands, and is now supported by ten times the evidence.**

**The residue is a coincidence, and I can say so with evidence rather than by assertion.** The gap is not a conserved quantity: it varies continuously across a range of width $0.43$. My own $20$-point sample independently contains gaps $0.230284$ and $0.231181$ at two unrelated critical points, near-agreement at three digits recurs at exactly the density you expect from $20$ draws out of a spread that wide. **There is nothing to explain.** *Verdict: the residue is closed, and the line in [plan.md](../plan.md) recording that "nothing explains that" should be struck rather than carried forward.*

---

# S3, T9, AND ITS CLOSURE LOGIC

## The number is a lower bound, not the maximum

Independent free-spectrum run at $n=6$, outer Nelder–Mead over trace-free unit $\lambda\in\mathbb R^{15}$, inner elastic LP over $T\ge0$ with all of (A), (B), (C), reaches

$$\max\theta \;\ge\; \mathbf{1.366272}\qquad\text{against the record's }1.340542,$$

with zero constraint slack at the optimum. Both figures are lower bounds on a nonconvex outer problem; mine is simply better. **The qualitative conclusion is CONFIRMED, the pinned class overshoots $\sqrt{3/2}=1.224745$ and does not close the conjecture, but $1.340542$ must be quoted as a lower bound, not as "$\max\theta$".** Any later claim that some added relation "closes $x$ of the gap" computed against $1.340542$ is measuring against a moving floor.

Trace-freeness, incidentally, is *forced* by the system rather than imposed: summing (B) over $a$ and using total symmetry gives $2(n-2)\sum\lambda_b=-2\sum\lambda_a$, so $\sum\lambda=0$. Summing (C) over $a$ is an identity and pins nothing, which is why $\lVert\lambda\rVert=1$ must be imposed by hand.

## The optimal spectrum, and the realization attempt the record asked for

The maximiser, sorted:

$$(-0.363479,\,-0.332306,\,-0.284347,\,-0.270098,\,-0.048547,\,-0.041405,\,-0.030021,\,-0.006669,\,-0.000795,\,-0.000288,\,0.016014,\,0.044212,\,0.332727,\,0.475172,\,0.509830)$$

trace $4\times10^{-16}$, norm $1$, $\lambda_{\max}/\lvert\lambda_{\min}\rvert=1.4026$, generic, with four near-zero entries.

**It is realizable.** Minimising $\lVert\mathrm{sort}\,\mathrm{spec}(W)-\lambda\rVert^2$ over unit $W\in\mathcal W_6$ converges to $3.1\times10^{-29}$, i.e. an exact match at machine precision. The fitter discriminates: it returns distance $0$ on a control spectrum drawn from an actual Weyl tensor, and is bounded away from zero, $0.479$ and $0.353$, on two targets that violate Lemma L73.

**And it is not a counterexample.** The realizing $W$ has

$$\theta(W)=0.266701,\qquad \lVert Q(W)-\theta W\rVert=0.5752 .$$

It is not critical, and its $\theta$ is a fifth of the LP value and a quarter of $\theta_0(6)=1.054093$.

## The taxonomy's outcome (iv) is a non-sequitur

> *"(iv) feasible above $\theta_0$ at a spectrum that is realizable, a counterexample to Conjecture A."*

**This is false, and the run above is the witness.** $\theta$ is **not a function of the spectrum**: it depends on $T$ through $\theta=\mathop{\mathrm{tr}}W^3+\tfrac12\sum\lambda_a\lambda_b\lambda_cT_{abc}$, and the LP's optimal $T$ need not be the $T$ of any Weyl tensor with that spectrum, let alone of a critical one. Realizing the *spectrum* buys nothing. A counterexample requires a critical $W\in\mathcal W_n$ of unit norm with $P(W)>\theta_0$, that is, the spectrum must be realized **by a critical $W$ whose own $T$ attains the LP optimum**, which is a vastly stronger demand.

So T9's actual outcome is a cell the taxonomy does not have: **feasible above $\theta_0$ at a spectrum that IS realizable, with no counterexample.** That in turn undercuts the redirect at the top of [plan.md](../plan.md):

> *"If the pinned relaxation is exact at every catalogued spectrum but its maximum over all spectra exceeds $\theta_0$, then the conjecture is a statement about which spectra are realizable."*

**It is not.** The overshooting spectrum is realizable, so spectral realizability is not the missing ingredient. What is missing is the realizability of the **pair** $(\lambda,T)$, that $T$ be the squared structure-constant array of an orthonormal *eigenframe* of an actual critical $W$. The record has localised the gap one level too coarse, and I24 inherits that error if it is written as a hunt for spectral conditions alone. *S1's finding sharpens the same point from the other side: at the maximiser, Lemma L73 is inactive.*

---

# S4, THE PAYNE FENCE

The fence, as written in [plan.md](../plan.md) and [findings/bounds.md](../findings/bounds.md):

> *"Jacobi is quadratic and sign-dependent ([Payne Thm 13](../references/payne-2010-soliton-metrics/notes.md)), so it is not expressible in $T$ at all. **No route may propose to reach Jacobi through $T$.**"*

**REFUTED AS STATED, on three counts.** Two are wording, the third is a category error.

**1. It contradicts the source it cites, in the same file.** [notes.md](../references/payne-2010-soliton-metrics/notes.md) item 1 records that Jacobi *does* have a consequence $T$ sees: Theorem 13 forbids a diagram carrying exactly one $-1$ edge in a Jacobi position, which is a condition on $\mathop{\mathrm{supp}}T$. "Not expressible in $T$ at all" is therefore stronger than the notes support and stronger than Payne states. The honest form is *not expressible as a linear or low-degree condition on the values of $T$*, the notes' own elimination remark gives the shape: removing the signs from $\sum_i\varepsilon_ix_i=0$ yields $\prod_{\varepsilon}\big(\sum_i\varepsilon_ix_i\big)=0$, degree $2^{m-1}$ in the magnitudes and a **union of hyperplane pieces**, so a linear functional of $T$ is forced only if it vanishes on every piece. That is a real fence and it is provable; "at all" is not.

**2. The $\mu_7/\mu_8$ witness proves a different theorem from the one it is cited for.** $\mu_7$ and $\mu_8$ are **both Lie algebras** (both satisfy Jacobi) that are non-isometric with the same structure vector $[\alpha^2]$. So the witness shows that **$T$ does not determine the algebra**. It does not show that Jacobi-satisfiability fails to be a function of $T$; as an existential predicate on $T$ ("does some signing of these magnitudes satisfy Jacobi") it *is* a function of $T$, just a semialgebraic one of exponential degree. The distinction matters for the wording, because the two support different fences:

- *supported by $\mu_7/\mu_8$:* **no route may propose to recover the algebra, the structure constants, or any sign-dependent quantity, from $T$.**
- *supported by Theorem 13 plus the elimination:* **no route may propose to add Jacobi to a linear relaxation in $T$ as linear constraints**, because its content is a union of high-degree pieces.
- *supported by neither:* "$T$ never sees Jacobi."

**3. The deeper problem: in this programme, Jacobi is free.** Payne's Theorem 13 is stated for $B$-**triangular** $\mu$, a nilpotent Lie algebra whose structure constants are the unknowns. In $\mathcal W_n$ the structure constants are **not** unknowns: $c_{abc}=\langle[v_a,v_b],v_c\rangle$ for an orthonormal basis of $\mathfrak{so}(n)$, and $\mathfrak{so}(n)$ **is** a Lie algebra, so the Jacobi identity holds identically for every realizable $T$ and imposes nothing beyond what (A), (B), (C) already carry, which is exactly what [Reviewer 331](REVIEW_r331.md) found by termwise vanishing. **The binding condition on $T$ is not Jacobi at all; it is that $c$ be the structure-constant array of $\mathfrak{so}(n)$ in an orthonormal frame**, a far more rigid condition of which Jacobi is a weak consequence. Naming Jacobi as the missing ingredient points every successor at the wrong object.

Consequently **"the failure mode is published" overstates the transfer.** Payne's $\Sigma_6$ is a genuine instance of *a* linear-plus-positivity relaxation being strictly larger than its realizable set, and as an analogy for that phenomenon it is apt and worth keeping. But the cutting there is done by Jacobi, and here Jacobi cuts nothing; and my S3 result shows the gap here is not even at the level of spectra. **Recommended rewording, and it is a strengthening rather than a retreat:**

> The pinned system's feasible set is strictly larger than the set of $(\lambda,T)$ arising from critical Weyl tensors, an overshooting spectrum was realized at $n=6$ and its realization has $\theta=0.267$. The cutting is done by the condition that $c$ be the structure constants of $\mathfrak{so}(n)$ in an orthonormal eigenframe, of which the Jacobi identity is an automatic consequence carrying no extra information ([r331](REVIEW_r331.md)). Payne §6.4 is the published analogue of the *phenomenon* (relaxation strictly larger than realizable set); it is not the mechanism here. No route may propose to recover the frame, the structure constants, or any sign-dependent quantity from $T$ ([Payne Thm 13](../references/payne-2010-soliton-metrics/notes.md), the $\mu_7/\mu_8$ witness); and no route may propose to add frame-realizability to a linear relaxation as linear constraints in $T$.

---

# S5, THE PER-ROW BOUND FAMILY

## The case split is right

Row $a$ of (C) divided by $2(n-2)$ is $\mathbb E_{\mu_a}[\lambda_b\lambda_c]=\lambda_a(\theta-\lambda_a)/(n-2)$, so $m_a\le\lambda_a(\theta-\lambda_a)/(n-2)\le M_a$. For $\lambda_a>0$ the upper half divides straight through: $\theta\le\lambda_a+(n-2)M_a/\lambda_a$. For $\lambda_a<0$ the **lower** half is the one that gives an upper bound, and dividing by $\lambda_a<0$ flips it: $\theta-\lambda_a\le(n-2)m_a/\lambda_a$. **Both branches CONFIRMED as recorded.** Rows with $\lambda_a=0$ give $0=0$ and are vacuous, which is correct and worth stating since kernel-carrying points have many of them.

**The record omits half the family.** The other half of each range gives a *lower* bound on $\theta$ by the same division: $\theta\ge\lambda_a+(n-2)m_a/\lambda_a$ for $\lambda_a>0$ and $\theta\ge\lambda_a+(n-2)M_a/\lambda_a$ for $\lambda_a<0$. *Screen: at padded $W_{\mathbb{CP}^2}$ the best lower bound is $0.816497$ against $\theta=1.224745$; at $S^3\times S^3$ it is $-0.527$.* Weak, but it is a spectral **exclusion** criterion, a spectrum whose best lower bound exceeds its best upper bound is not realizable by a critical point, and I24 is exactly the item that should own it.

## The range is right, and it is the exclusion that does the work

$m_a$ and $M_a$ must be taken over ordered pairs with $b\ne c$ and $b,c\ne a$. **Confirmed**, both exclusions are real, since $T$ vanishes on repeated indices and its support excludes $a$ in rows indexed by $a$.

## "Lemma L70 is exactly the $\lambda_{\min}$ member", REFUTED AS STATED

The record derives Lemma L70 with $\lambda_b\lambda_c\ge\lambda_{\min}\lambda_{\max}$, a bound over **all** pairs. But at $a=\arg\min$ the index $\arg\min$ is excluded from the support, so the correct $m_a$ is $\lambda_{(N-1)}\lambda_{(1)}$, not $\lambda_{(N)}\lambda_{(1)}$. Since $\lambda_{(N-1)}\ge\lambda_{(N)}$ and $\lambda_{(1)}>0$, we have $m_a\ge\lambda_{\min}\lambda_{\max}$, and dividing by $\lambda_{\min}<0$,

$$\theta\;\le\;\lambda_{\min}+(n-2)\frac{m_a}{\lambda_{\min}}\;\le\;\lambda_{\min}+(n-2)\lambda_{\max},$$

the right-hand side being Lemma L70. **So Lemma L70 is the weaker, all-pairs form; the true $\lambda_{\min}$ member of the family is strictly stronger, with equality iff $\lambda_{\min}$ is a repeated eigenvalue.** Every catalogued point has $\lambda_{\min}$ repeated, which is why the two have never been seen to differ.

*Screen at two generic critical points of $\mathcal W_6$ with all $15$ eigenvalues simple:*

| $\theta$ | Lemma L70 as recorded | $\lambda_{\min}$ row, exclusion applied | $\Pi$-bound |
|---|---|---|---|
| $0.742003$ | $1.697531$ | $\mathbf{1.311507}$ | $1.478076$ |
| $0.423298$ | $1.220030$ | $\mathbf{1.138457}$ | $1.407305$ |

**Lemma L70 as recorded should be restated with the exclusion.** It is free, it is strictly better at every point where $\lambda_{\min}$ is simple, and it loses nothing where it is not. *This is the same defect as the S1 strengthening, the record's row calculus keeps forgetting that row $a$ does not see index $a$.*

## The numbers, and where the family actually improves

Padded $W_{\mathbb{CP}^2}$ (built independently: $\mathfrak u(2)\subset\mathfrak{so}(4)$, projected to $\mathcal W_4$, zero-padded, reprojected, renormalised; $\theta=1.224745$ at criticality residual $\le3\times10^{-15}$ at every $n$):

| $n$ | $\theta$ | Lemma L70 | $\Pi$-bound | row family, min over rows |
|---|---|---|---|---|
| $4$ | $1.224745$ | $1.224745$ | $1.224745$ | $1.224745$ |
| $6$ | $1.224745$ | $2.857738$ | $2.041241$ | $1.632993$ |
| $8$ | $1.224745$ | $\mathbf{4.490731}$ | $\mathbf{2.857738}$ | $\mathbf{2.041241}$ |

**The record's three figures are CONFIRMED exactly, they are the $n=8$ row.** The record does not say which $n$ they belong to, and at $n=6$ the same point gives a different triple; **that should be stated when the numbers are quoted.**

**"Coinciding with both at the balanced products and at the tori" is REFUTED.** At the balanced products all three coincide with $\theta$, as claimed. At the tori they do not:

| point | $\theta$ | Lemma L70 | $\Pi$-bound | row family |
|---|---|---|---|---|
| max torus, $n=6$ | $0.645497$ | $1.936492$ | $\mathbf{0.645497}$ | $1.936492$ |
| max torus, $n=8$ | $0.540062$ | $2.700309$ | $\mathbf{0.540062}$ | $2.700309$ |

At every torus the row family reproduces **Lemma L70 only**, and is $3\times$ to $5\times$ worse than the $\Pi$-bound, which is **exactly sharp** there. The $\Pi$-bound is not a member of this family, it comes from feeding $Y\le X^2$ and $(X-\lambda_{\min})(\lambda_{\max}-X)\ge0$ into the (B) *and* (C) moments jointly, so it is a second-moment argument, not a range argument. **The family therefore does not dominate the standing bounds and must be used as a minimum against them, not in place of them.**

## Is it valid, and where does it improve?

**Valid everywhere tested**, never below $\theta$ at $\mathbb{CP}^2,\mathbb{CP}^3,\mathbb{CP}^4$, the tori at $n=6,8$, the balanced products at $n=6,8$, padded $W_{\mathbb{CP}^2}$ at $n=4,6,8$, and generic critical points of $\mathcal W_6$.

**The improvement is not a kernel effect, and the coordinator's framing of that question should be dropped.** Two separate sources:

- **Reading a row other than $\arg\min$.** At $\mathbb{CP}^3$ (kernel dimension $0$) the minimising row is $a=\arg\max$ and the family returns $1.054093=\theta$ **exactly**, against Lemma L70's $3.162278$. Same at $\mathbb{CP}^4$: $0.986013=\theta$ against $4.930066$. That is the family's real content and it has nothing to do with kernels.
- **The excluded index**, which bites exactly when the extreme eigenvalue is **simple**, generic critical points, as tabulated above. Also nothing to do with kernels; at padded $W_{\mathbb{CP}^2}$ the exclusion is worth zero, because $\lambda_{\min}$ there has multiplicity $2$.

---

# What I would change in the record

1. **[findings/bounds.md](../findings/bounds.md), Lemma L73**, add the excluded-index strengthening. It is free, it is sharp on both saturating families, and it is what bites at generic critical points.
2. **[findings/bounds.md](../findings/bounds.md), Lemma L70**, restate with $m_{\arg\min}=\lambda_{(N-1)}\lambda_{(1)}$ rather than $\lambda_{\min}\lambda_{\max}$, and drop "Lemma L70 is exactly the $\lambda_{\min}$ member" in favour of "Lemma L70 is the all-pairs weakening of the $\lambda_{\min}$ member".
3. **[findings/bounds.md](../findings/bounds.md), the row family**, say the $2.041241/4.490731/2.857738$ triple is at $n=8$; strike "coinciding with both … at the tori"; add the lower-bound half of the family.
4. **[plan.md](../plan.md), T9**, quote $1.340542$ as a lower bound, note that $1.366272$ is reachable, and replace outcome (iv) with the correct condition (a critical $W$ attaining the LP value, not a realizable spectrum).
5. **[plan.md](../plan.md), the redirect**, withdraw "the conjecture is a statement about which spectra are realizable". The overshooting spectrum is realizable; the gap is at the level of $(\lambda,T)$ pairs.
6. **[plan.md](../plan.md), T10**, strike the residue line; the gap distribution explains it.
7. **[plan.md](../plan.md), the fence**, replace with the two provable fences given in S4, and stop naming Jacobi as the missing ingredient in a problem where Jacobi is automatic.
8. **A trap for the warnings list**, local optimisers on $\mathcal W_n$ under-report spectral extrema badly ($2.77$ against the true $4$ at $n=6$); never quote an unconstrained search maximum over $\mathcal W_n$ as a maximum.
