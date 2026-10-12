# LIT-spectra, the literature on which spectra are realizable

**Item:** [T9](../plan.md), opened by [r331](REVIEW_r331.md)'s Q3 screen. **Run:** 2026-09-01. **Log:** [lit-spectra.log](../agent_logs/lit-spectra.log). **Sources filed:** [nikolayevsky-2011-pre-einstein-derivation](../references/nikolayevsky-2011-pre-einstein-derivation/), [hashimoto-2023-hilbert-mumford-nilsolitons](../references/hashimoto-2023-hilbert-mumford-nilsolitons/), plus a T9 section appended to [payne-2010-soliton-metrics](../references/payne-2010-soliton-metrics/notes.md).

## Verdict

**No realizability criterion for the spectrum of a Weyl operator exists in the literature for $n\ge5$, and none is in prospect. But the analogue corner supplies the two things T9 actually needs: a theorem saying the record's zero-overshoot measurement was guaranteed to come out that way, and a published witness of exactly the failure mode T9 is hunting.**

Four findings, in order of what they do to the plan:

| # | Finding | What it does to T9 |
| --- | --- | --- |
| **F1** | At a **fixed support**, "the linear system in the squares has a strictly positive solution" is *equivalent* to the geometric condition, [Nikolayevsky Theorem 3](../references/nikolayevsky-2011-pre-einstein-derivation/notes.md), and [Hashimoto Theorem 1.2](../references/hashimoto-2023-hilbert-mumford-nilsolitons/notes.md) with the nice-basis hypothesis removed | **Deflates the evidence T9 was opened on.** r331's zero overshoot at seven fixed spectra is the behaviour the analogue *predicts* at fixed support. It is not evidence that the pinned class is tight, and it carries no information about the maximum over spectra |
| **F2** | Over the feasible **set** at a fixed support, realizability strictly cuts: at $\Sigma_6$ the linear system has a **one-parameter family** of nonnegative solutions and the Jacobi identity selects a **single point**, [Payne, §6.4](../references/payne-2010-soliton-metrics/notes.md) | **This is T9's failure mode, published.** T9 maximises over the relaxation rather than asking for existence, so $\Sigma_6$ and not F1 is the governing precedent |
| **F3** | The realizable spectra in the analogue are cut out in part by an **arithmetic** condition: all eigenvalues of the pre-Einstein derivation are rational, and the Einstein derivation is positively proportional to it, [Nikolayevsky Theorem 1](../references/nikolayevsky-2011-pre-einstein-derivation/notes.md) | **A convex relaxation cannot see the obstruction that decides the analogue.** If the same is true here, no amount of sharpening the LP will close the gap |
| **F4** | Nothing bounds $\theta$, or $\langle W,W^\#\rangle$, in terms of the spectrum alone | The sharp spectral bound this record wants is not published. Confirms the negative in [LIT-jacobi](LIT-jacobi.md) |

**The blunt negative, stated once and plainly.** The image of the map $\mathcal W_n\to\mathbb R^{N}$, $W\mapsto\operatorname{spec}W$, has never been described in print for $n\ge5$. Not characterized, not approximated, not conjectured. Every body of work whose title suggests otherwise turns out to ask the opposite question (assume the spectrum is constant and deduce rigidity) or to constrain a different operator. **T9 will get no help from the literature and must be settled by the record's own computation.**

## Searched

`Searched: eigenvalue distribution of the curvature operator; spectrum of the curvature operator; which symmetric operators on Lambda^2 are curvature operators; image of the spectrum map on algebraic curvature operators; algebraic curvature tensor realizability and Gilkey's geometric realization programme; prescribed spectrum for algebraic curvature tensors; Osserman conjecture (Nikolayevsky) and Ivanov-Petrova conditions; natural curvature operators of bounded spectrum (Blazic-Gilkey); Weyl operator classification in higher dimensions (Coley-Hervik bivector formalism, Segre types, discriminants); Singer-Thorpe self-dual/anti-self-dual splitting; first Bianchi as a constraint on the spectrum alone; Zoltek on Bianchi and Grassmann quadratic 2-relations; convex algebraic geometry of curvature operators (Bettiol-Kummer-Mendes); inverse eigenvalue problems for symmetric matrices in a linear subspace; Payne's structure vector and the generalized Cartan classification of Uv=-2beta[1]; Nikolayevsky's pre-Einstein derivation and nice-basis criterion; Hashimoto's Hilbert-Mumford criterion; Lauret's moment map and Kirwan stratification of the variety of Lie algebras; Einstein nilradical classification in dimension 7 (Fernandez-Culma, Kadioglu-Payne); sharp bounds on R^# and tr(R^3) in the Hamilton/Boehm-Wilking/Wilking line.`

## 1. The direct question: nobody has asked it

**The realizability question here is purely algebraic, and the literature confirms that much.** Every algebraic curvature tensor on $\mathbb R^n$ is geometrically realizable by a metric at a point, Gilkey's programme finds obstructions only for *affine* realizations, in one of eight equivariant variants ("a non-zero projectively flat Ricci antisymmetric generalized algebraic curvature is not geometrically realizable by a projectively flat Ricci antisymmetric torsion free connection", [arXiv:0811.3180](https://arxiv.org/abs/0811.3180)). So T9's realizable spectra are exactly $\{\operatorname{spec}W:W\in\mathcal W_n\}$ with $\mathcal W_n$ the linear subspace of $\operatorname{Sym}^2(\Lambda^2)$ cut out by first Bianchi and Ricci-freeness. **Geometry adds nothing to the constraint, and takes nothing away.**

**What the "spectral geometry of curvature" literature actually studies is the converse implication, and about different operators.** Osserman (the Jacobi operator $J(x)$ has spectrum independent of the unit $x$), Ivanov–Petrova (the skew-symmetric curvature operator has constant eigenvalues), Szabó, and Blažić's *Natural curvature operators of bounded spectrum* (Diff. Geom. Appl. 2006, revised by Gilkey) all fix a spectral condition and derive rigidity. **None of them asks which spectra occur.** The one place a spectrum-side classification exists is Lorentzian: Coley–Hervik's bivector formalism ([arXiv:0909.1160](https://arxiv.org/abs/0909.1160)) gives "necessary conditions on the discriminants of the associated characteristic equation" for Weyl types II and D, but that is an alignment classification in signature $(1,n-1)$ and the constraint is on the Segre type, not on which real multisets occur in Riemannian signature.

**Ambient evidence that a clean answer is unlikely.** [Bettiol–Kummer–Mendes](../references/bettiol-kummer-mendes-2021-convex-curvature/README.md) show that already the *sectional* condition on curvature operators fails to be a spectrahedral shadow for $n\ge5$, a counterexample to the Helton–Nie conjecture, with only inner and outer SDP hierarchies available. A semialgebraic set that resists exact semidefinite description at the quadratic level is not going to yield a readable spectral characterization one degree up.

## 2. The one dimension where the answer is known, and it is a warning

*Derived here from the standard Singer–Thorpe decomposition; stated in no source I found, and offered as an orientation rather than a citation.*

At $n=4$, $\Lambda^2$ splits under the Hodge star as $\Lambda^+\oplus\Lambda^-$, a Weyl operator commutes with $\star$, and $W=W^+\oplus W^-$ with each block a traceless symmetric endomorphism of a 3-dimensional space; conversely every such pair is a Weyl operator. So

> the realizable Weyl spectra at $n=4$ are exactly the multisets of six reals admitting a partition into **two** zero-sum triples.

That is **codimension two**, not one: total trace-freeness is strictly weaker, and the second condition is precisely first Bianchi, which at $n=4$ reads $\operatorname{tr}(\star W)=0$ because $\Lambda^4\mathbb R^4$ is one-dimensional.

**The moral for T9.** "First Bianchi restricts which multisets of eigenvalues can occur" is not a speculative reading, it is a theorem in the only dimension where the question has been answered, and the restriction there is invisible to the trace. Whether the $\Lambda^4$ condition still bites spectrally at $n\ge5$, where $\Lambda^4$ has dimension $\binom n4$ and is no longer a scalar, is exactly what nobody has determined.

## 3. The analogue corner, which does know things

The nilsoliton/nice-basis literature is the corner [LIT-jacobi](LIT-jacobi.md) opened. It holds this record's $T$ under the name *structure vector*, and it has now been read for the realizability question rather than the Jacobi one.

### 3.1 F1, at a fixed support the relaxation is exact, as a theorem

[Nikolayevsky, Theorem 3](../references/nikolayevsky-2011-pre-einstein-derivation/notes.md), verbatim:

> A nonabelian nilpotent Lie algebra $\mathfrak n$ with a nice basis is an Einstein nilradical if and only if any of the following two equivalent conditions hold: (i) the projection of the origin of $\mathbb R^n$ to $L$ lies in the interior of the convex hull of $F$. (ii) there exists a vector $\alpha\in\mathbb R^m$ with all the coordinates positive satisfying $YY^t\alpha=[1]_m$.

[Hashimoto, Theorem 1.2](../references/hashimoto-2023-hilbert-mumford-nilsolitons/notes.md) removes the nice-basis hypothesis, replacing it with a quantifier over all orthonormal bases diagonalising the pre-Einstein derivation, and reaches the same linear system with one added normalisation $\sum_i\alpha_i=\lVert P_0\rVert^{-2}$. His Theorem 1.1 makes the underlying criterion a Hilbert–Mumford weight $\nu(\lambda;\mu)=-\min\{\lambda_i+\lambda_j-\lambda_k:\mu^k_{ij}\ne0\}$, **a function of the support alone**.

**Consequence for the plan, and it is a demotion.** r331 measured max-$\theta$ at seven fixed spectra and found zero overshoot, and [plan.md](../plan.md) reads that as the pinned class being "STRONGER than this record hoped". In the closest analogue, exactness of the linear-plus-positivity layer at a fixed support is an *if and only if theorem*. **The measurement is consistent with the pinned class being exactly as weak as post F42 claimed and exact at fixed spectra for structural reasons.** It should stop being cited as evidence in either direction.

### 3.2 F2, over the feasible set, realizability strictly cuts, and there is a published witness

[Payne, §6.4](../references/payne-2010-soliton-metrics/notes.md), verbatim:

> It was shown in [McD] that $\Delta_6$ admits a one-parameter family of nilsoliton weightings with $\beta=-2$, and the Jacobi condition from the two dotted edges as described by Theorem 13 gives a constraint so that up to scaling, there is a unique nilsoliton metric $(\mathfrak n,Q)$ with $\Lambda(\mathfrak n,B)=\Sigma_6$ for a Ricci eigenvector basis $B$.

**A one-parameter family of nonnegative solutions to the linear system in the squares; realizability selects one point of it.** Payne's Theorem 2 says this is generic rather than exotic: whenever the Gram matrix is singular and of indefinite type, the nonnegative solution set is "a simplex of dimension $\ker A$", and Theorem 3 counts the metric-algebra solutions before Jacobi is imposed at all.

**F1 and F2 are consistent, and the distinction is the whole point.** F1 answers an *existence* question over a support (does some realizable point lie in the feasible set) and there the relaxation is exact. F2 describes the feasible *set*, and there it is strictly larger than the realizable subset. **T9 maximises a functional over the feasible set. It is the F2 question, not the F1 question.** Nothing in this literature suggests the maximum of a linear functional over the relaxation is attained at a realizable point.

### 3.3 F3, the analogue's spectral obstruction is arithmetic

[Nikolayevsky, Theorem 1](../references/nikolayevsky-2011-pre-einstein-derivation/notes.md), verbatim in part:

> (c) All the eigenvalues of $\varphi_{\mathfrak g}$ are rational numbers.

> Let $\mathfrak n$ be a nilpotent Lie algebra, with $\varphi$ a pre-Einstein derivation. If $\mathfrak n$ is an Einstein nilradical, then its Einstein derivation is positively proportional to $\varphi$ and $\varphi>0$ and $\mathrm{ad}\,\varphi\ge0$.

> The inequalities (2) are necessary, but not sufficient to guarantee that a nilpotent Lie algebra is an Einstein nilradical.

**This is the only "which spectra are realizable" theorem the search found in any analogue, and its content is a rationality condition.** The inequality part is convex and the arithmetic part is not, and the paper says outright that the inequality part alone does not decide the question. Hashimoto's Theorem 1.4 adds a second non-convex residual obstruction, stated as non-transitivity of an $\mathrm{Aut}(\mu)\cap G$-action on a symmetric space.

**If T9's answer has this shape, the outer maximisation will overshoot and the overshooting spectrum will violate no inequality the record can write down.** That is the scenario T9 should be prepared to recognise, and it is not the scenario the plan currently describes.

### 3.4 The disanalogy that limits all three, and sharpens the question

**In the nilsoliton problem the bracket varies and the metric is fixed. Here the bracket is fixed and the frame varies.** Nikolayevsky's equivalence works because the diagonal group moves the magnitudes freely inside a support while preserving Jacobi, every positive $\alpha$ on an admissible support is realized by an actual algebra carrying the original signs. This record has no such group: $T_{abc}=\langle[v_a,v_b],v_c\rangle^2$ is determined by the orthonormal frame $(v_a)$ of the *fixed* algebra $\mathfrak{so}(n)$, and there is no action moving $T$ at fixed spectrum.

Written out, the realizable pairs are

> $(\lambda,T)$ such that $T_{abc}=\langle[v_a,v_b],v_c\rangle^2$ for some orthonormal frame $(v_a)$ of $\mathfrak{so}(n)$ **and** $\sum_a\lambda_a\,v_a\otimes v_a\in\mathcal W_n$.

**The pinned relaxation drops two constraints, and (A), (B), (C) are shadows of the second one only.** The first, that $T$ is the squared structure-constant tensor of $\mathfrak{so}(n)$ in *some* orthonormal frame, is a codimension-heavy condition on a totally symmetric nonnegative 3-tensor with $\binom I3$ entries, and the record currently imposes exactly one of its consequences, the Killing row mass (A). **No literature was found on that set.** Payne's own remark that "a single nilmanifold may have different root vectors, structure vectors, and Gram matrices, depending on the choice of Ricci eigenvector basis" is as close as anyone comes to acknowledging the object, and nobody characterizes it.

## 4. Upper bounds on $\theta$ from the spectrum alone: nothing

Searched the Hamilton / Böhm–Wilking / Wilking line for a sharp estimate of $\langle R,R^\#\rangle$ or $\operatorname{tr}(R^3)+\langle R,R^\#\rangle$ in terms of eigenvalues. What exists is already on this shelf and is weaker than the record needs:

- [Böhm–Wilking Lemma 2.1](../references/boehm-wilking-2008-space-forms/notes.md), which [LIT-invariants](LIT-invariants.md) already identified as relations (A) and (B) themselves, so it is an input to the relaxation rather than a bound on it.
- [Wilking's trace form](../references/wilking-lie-algebraic-cones/notes.md) $\langle R^\#x,y\rangle=-\tfrac12\operatorname{tr}(\mathrm{ad}_xR\,\mathrm{ad}_yR)$, a formula, used in the cone-invariance argument as a sign statement ($\ge0$ on a suitable $S$), never as a sharp magnitude estimate.
- The record's own [bispectral.md](../findings/bispectral.md) note that separate Okumura caps on the two cubics reach $4.0129$ against $\theta_0(12)=1.236$.

**No source bounds $\theta$ by a function of the spectrum. The sharp spectral bound, if one exists, is unpublished.**

## 5. What would settle T9, and what the literature contributes to each branch

| branch | what it would take | literature's contribution |
| --- | --- | --- |
| **T9 answers "yes, realizability is the content"** | one spectrum $\lambda$, pinned-feasible with $\theta>\theta_0(n)$ | Payne's $\Sigma_6$ says the relaxation's feasible set exceeds the realizable set in the analogue; Nikolayevsky Thm 1 says the residual obstruction there is arithmetic. **Neither supplies a spectrum, and no source rules the branch out** |
| **T9 answers "no, the pinned class closes it"** | $\max_\lambda\max_T\theta=\theta_0(n)$ over the $3N$-row system | Nothing. No spectral bound on $\theta$ exists; the sharp inequality would be new |
| **T9 is answered by a realizability criterion** | a characterization of $\{\operatorname{spec}W:W\in\mathcal W_n\}$ | **None exists for $n\ge5$, and the search found no partial result, no conjecture, and no programme aiming at one.** At $n=4$ the answer is the two-zero-sum-triples condition, codimension two, driven by Bianchi |

## 6. What this record should change

1. **Stop citing the zero-overshoot table as evidence.** F1 makes it the predicted outcome at fixed support in the analogue. [plan.md](../plan.md)'s sentence "the pinned class is STRONGER than this record hoped" is unsupported by that measurement; it is neither stronger nor weaker than the analogue's baseline.
2. **Run the outer maximisation, and expect no help.** T9's grade of $9$ survives this search intact, it is still the one computation that decides the question, and the literature will not do it, approximate it, or bound it.
3. **Add the first dropped constraint to the statement of the question.** The relaxation drops "$T$ is the squared structure-constant tensor of $\mathfrak{so}(n)$ in some orthonormal frame" *and* "that frame diagonalises a Weyl operator with spectrum $\lambda$". Relations (A), (B), (C) are consequences of the second only, with (A) the sole consequence of the first currently imposed. **If the outer maximisation overshoots, the first constraint is the more likely culprit, and it is a statement about frames of $\mathfrak{so}(n)$ rather than about spectra.**
4. **Prepare to recognise an arithmetic obstruction.** F3 is the analogue's answer to "which spectra are realizable", and it is a rationality condition no inequality can express. If the overshooting spectrum satisfies every inequality the record can write, that is a signal rather than a failure of the search for more inequalities.
