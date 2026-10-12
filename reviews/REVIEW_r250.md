# REVIEW r250 -- Gate 2, claims 3 and 4

Reviewer 250, on the brief that produced [REVIEW_r247.md](REVIEW_r247.md) and [REVIEW_r248.md](REVIEW_r248.md). Commits under review: 6536b2f, 2cdff7b, 6338def. Reviewer 249 runs claims 1, 2 and 5 concurrently.

| # | Claim | Verdict |
|---|---|---|
| 3 | Padding makes independence at $n=12$ imply independence at every $n\ge12$ | **CONFIRMED**, in the direction claimed, with one hypothesis that must be named |
| 4 | The refutation record of 6536b2f is faithful and complete | **FAITHFUL IN VERDICT, OVERSTATED IN MECHANISM** -- two of its statements do not survive |

Scripts: [c3_padding.py](../scripts/reviewers/r250/c3_padding.py), [c4_witness_and_scope.py](../scripts/reviewers/r250/c4_witness_and_scope.py). All arithmetic exact over $\mathbb{Q}$ or $\mathbb{Z}$.

---

## Claim 3 -- CONFIRMED. The surprising direction is the true one

### The statement, and why the direction is the easy one

Zero-padding is an inclusion $\iota:\mathcal W_m\hookrightarrow\mathcal W_n$ for $m\le n$. Independence transfers along the map that goes the *other* way: **restriction of functions**. Write $T(f)=\pi\circ f\circ\iota$, where $\pi$ truncates output index ranges back to $1..m$. Then

- $T$ is linear on functions;
- $T\bigl(J_D^{(n)}\bigr)=(n/m)^{L}\,J_D^{(m)}$ for every contraction diagram $D$ with $L$ free metric loops;
- if $\{T v_i\}$ is independent then $\{v_i\}$ is independent.

Applied with $m=12$: a relation $\sum x_c J_c^{(n)}=0$ on $\mathcal W_n$ restricts to $\sum x_c (n/12)^{L_c} J_c^{(12)}=0$ on $\mathcal W_{12}$, and the scalars are nonzero. **Independence at $12$ therefore gives independence at every $n\ge12$.** The claimed direction is correct, and it is the direction that needs no stable range: it is the standard "a linear map that separates the images separates the sources".

### What I verified exactly

| check | result |
|---|---|
| $\iota$ lands in $\mathcal W_n$ | Riemann symmetries, first Bianchi and tracelessness all hold on the padded tensor, verified over $\mathbb{Q}$ for $5\to6,7,9$ and $6\to8$ |
| reduced diagrams are unchanged | $A$, $C$, $I_1=\mathrm{tr}\,M^3$, $I_2=\mathrm{tr}\,B^3$ take **identical rational values** before and after padding (e.g. $I_1=-42029/288$ at every target dimension) |
| a free loop only rescales | $\delta_{aa}\cdot A$ picks up exactly $n/m$ -- $6/5$, $7/5$, $9/5$, $4/3$ as predicted |

### Three findings the record does not contain

**1. The no-free-loop lemma is not a hypothesis of this step.** [plan.md](../plan.md) line 76 lists "the covariant no-free-loop question" as unaudited, and [run_n24_via_diagrams.py](../scripts/runs/run_n24_via_diagrams.py) step 2 cites the lemma by name. It is not needed here: a free loop contributes $(n/m)^L\neq0$, and rescaling basis elements by nonzero scalars preserves independence. With $T$ taken as *truncate after restrict*, even a covariant carrying bare metrics on its free legs maps to its own level-$m$ version, because $\pi(g^{(n)})=g^{(m)}$. The lemma buys a cleaner statement, not the theorem.

**2. The one hypothesis that IS load-bearing: the carrier must have $n$-independent coefficients.** The lemma is about diagrams. Coefficients that see $n$ break it, and trace removal supplies exactly those ($1/n$, $1/(n-2)$ -- [brauer-pairing.md](../findings/brauer-pairing.md) says so itself). Counterexample, built from the two diagrams above, which are independent as functions for every $n\ge6$:

$$J_1^{(n)}=I_1+\tfrac1n I_2,\qquad J_2^{(n)}=I_1+\tfrac1{24}I_2.$$

At $n=12$ these are $I_1+I_2/12$ and $I_1+I_2/24$ -- **independent**. At $n=24$ they are the same function -- **dependent**. The padding map is blameless; the level-12 family is simply not the restriction of the level-24 family. So the theorem applies to *projector-free diagram carriers*, and [run_n24_via_diagrams.py](../scripts/runs/run_n24_via_diagrams.py)'s own closing line -- the construction "emits VECTORS in a weight space, not diagrams" -- is what currently stands between the lemma and the 184 covariants. Until a carrier exists, "the covariant at $n=24$" has no referent and the implication is about objects the programme has not built.

**3. The direction genuinely matters -- the converse is false, twice, exactly.**

| witness | result |
|---|---|
| the $105$ Brauer matchings on $8$ legs, Gram $n^{\#\text{cycles}}$ | rank $105$ at $n=4,5$; rank **91** at $n=3$ |
| $I_1=\mathrm{tr}\,M^3$ and $I_2=\mathrm{tr}\,B^3$, two reduced cubic diagrams on Weyl tensors | independent at $n=6,7$; at $n=4,5$ **$I_2=I_1/2$ identically**, on every sample and every seed |

The second is the sharp one: it is exactly the class of object claim 3 speaks about -- reduced contraction diagrams on Weyl tensors -- and it is independent at the larger dimension and dependent at the smaller. Downward transfer is false. Step 2 of [run_n24_via_diagrams.py](../scripts/runs/run_n24_via_diagrams.py) uses the only direction that is available, and uses it correctly.

### Consequence for the $n=24$ reuse, which does NOT rest on step 2 alone

[fence-posts.md](../findings/fence-posts.md) line 332 reuses this as "a basis found at $12$ serves at $24$". Basis-hood is independence **and** spanning, and padding gives only the first. Step 1's inference -- FFT says all diagrams span at every $n$, therefore a list spanning at $12$ spans at $24$ -- is a **non sequitur**: at the smaller dimension there are more relations, so a sublist can span there and fail to span higher; the $n=3$ rank drop above is that phenomenon. The reuse is nonetheless sound, through step 3 rather than step 1: [sym3-stability.md](../findings/sym3-stability.md) fixes the count at $184$ for every $n\ge12$, and $184$ independent functions in a $184$-dimensional space are a basis. So the record's conclusion survives while its stated route to it does not.

---

## Claim 4 -- the witness reproduces; two statements around it are overstated

### Faithful: the witness is exactly as recorded

$A=W_{abcd}W_{abcd}$ and $C=W_{abcd}W_{acbd}$ satisfy $C=A/2$ at $n=5,6,7$ in exact rational arithmetic, and the *polarised* identity $C(W,V)=A(W,V)/2$ holds too -- so as an operator on $\mathcal W_n$ the diagram $C$ is precisely $\tfrac12\mathrm{Id}$. I isolated the hypothesis: the identity holds on a Riemann tensor with traces present, and **fails** ($C-A/2=-283/4$) on a tensor with the pair symmetries but no first Bianchi. The record's attribution to the first Bianchi identity alone is exact.

Both Grams reproduce. Projector-free: $\begin{pmatrix}n^4&n^3\\n^3&n^4\end{pmatrix}$ with $\det=n^6(n^2-1)$, nonzero at $n=2,5,12,24$. With the projector: $\tfrac{\dim\mathcal W_n}{4}\begin{pmatrix}4&2\\2&1\end{pmatrix}$, determinant identically zero; and $\dim\mathcal W_n=n(n+1)(n+2)(n-3)/12$ checks against Riemann-minus-Ricci, giving $35,84,168,300$. **Nonsingular Gram, dependent functions: the refutation of the reduction stands.**

### Overstatement 1 -- "the second is not polynomial" is false, and the dichotomy does not need it

The commit's central paragraph reads: the projector-free pairing "is polynomial -- which the Sturm framing needs", while "the second is not polynomial: $\langle A,A\rangle=\dim\mathcal W_n$ ... a quartic". A quartic **is** a polynomial. What the projector-carrying pairing loses is *monomiality* -- and 2cdff7b's Sturm step never asked for monomiality, only that "each entry is ... polynomial in $n$, so $\det M(n)$ is a single univariate polynomial". By the record's own [brauer-pairing.md](../findings/brauer-pairing.md), the block Gram is *rational* in $n$ with denominators $n$ and $n-2$; clearing them leaves a polynomial whose poles sit at $n=0,2$, far below the range of interest. **A Sturm framing survives the switch to the honest pairing.**

This matters because the commit titles itself on the dichotomy -- "it mixed two pairings", "THE DICHOTOMY THAT KILLS IT". One leg of that dichotomy is sound (the projector-free form is a form on the ambient tensor space, and the witness shows it misses relations on $\mathcal W_n$); the other leg is not. The reduction is refuted by the witness alone, and by the three further failures the commit lists -- the $184\times184$ shape presupposing the basis it exists to establish, $\det\equiv0$ on a genuine spanning set, and the diagram set not existing. Padding then makes the whole apparatus unnecessary. **The verdict is right and the load-bearing reason is the witness; the polynomiality leg should be struck.**

### Overstatement 2 -- the projector-free pairing is insufficient, not useless

"Its nonsingularity says nothing about relations among functions on $\mathcal W_n$" is true as written but reads as writing the instrument off. What it actually is:

- The value $n^{\#\text{cycles}}$ **is** the Frobenius inner product of the two diagram tensors in $(\mathbb{R}^n)^{\otimes 2d}$. Over $\mathbb{R}$ it is therefore positive semidefinite, and its rank equals the true rank of the diagram span with no gap -- I checked this on the $105$ matchings on $8$ legs: Gram rank $35$ and $91$ at $n=2,3$, matching the rank of the actual tensors, and $105$ at $n=4$.
- Restriction to $\mathcal W_n$ is a linear map, so $\mathrm{rank}(\text{restrictions})\le\mathrm{rank}(\text{ambient diagrams})$. Hence **a rank-deficient projector-free Gram over $\mathbb{R}$ certifies DEPENDENCE of the covariants as functions**. At $n=3$ above it certifies $14$ independent relations with no projector anywhere.

So the pairing is a *sound test for dependence and an unsound test for independence* -- half a decision procedure, cheap, and the half that prunes. It is also the instrument behind the stable-range statement $n\ge12$ that claim 3's own step 3 leans on. "Useless" is not the right word; "insufficient on its own, and pointed the wrong way for what the reduction wanted" is.

### Two smaller points of fidelity

- "Reviewer 247 refuted all three claims of 2cdff7b." [REVIEW_r247.md](REVIEW_r247.md)'s table gives claims 1 and 2 as REFUTED and claim 4 as **NOT A FAIR TEST** -- a screen that cannot express the failure mode, which is a different finding from a refutation. The commit's own "MY SCREEN WAS BLIND BY CONSTRUCTION" states it correctly two paragraphs later; the summary line does not.
- The mod-$p$ caveat is real and correctly recorded: [run_n5_diagram_gram.py](../scripts/runs/run_n5_diagram_gram.py) does set $p=10007$, and anisotropy -- the hypothesis the free direction actually needs -- exists only over $\mathbb{R}$.

---

## Summary

**Claim 3 stands**, in the surprising direction, and I could not break it: the restriction map runs from level $n$ down to level $12$, free loops only rescale, and the exact padding checks pass. Two things should be written into the record with it -- the carrier must be a projector-free diagram, on pain of the $J_1,J_2$ counterexample, and the $n=24$ *basis* reuse needs the stability count as well as the padding step, because step 1's spanning inference is a non sequitur.

**Claim 4's verdict is faithful and the witness is exact.** The record is not complete: it retires the Sturm framing partly on a false statement (a quartic is a polynomial, and rational entries still admit Sturm), and it leaves the projector-free pairing looking worthless when it is an exact and cheap certificate of dependence.
