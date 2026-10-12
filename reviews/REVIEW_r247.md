# REVIEW_r247 -- Gate 2, the independence reduction (claims 1, 2, 4)

Commits under review: 2cdff7b (primary), d82dea0, cf4020b, fbc58b1.
Primary file: scripts/runs/run_n12_diagram_independence.py.
Reviewer 247. Claims 1, 2, 4. (Reviewer 248 takes 3 and 5.)

| # | Claim | Verdict |
|---|---|---|
| 1 | The reduction: independence-as-functions iff diagram Gram nonsingular | **REFUTED** -- witness below |
| 2 | det M(n) is one polynomial (is the diagram SET n-independent?) | **REFUTED**, though not by the route the brief expected |
| 4 | The criterion screen: independent vectors, singular Gram | **NOT A FAIR TEST** -- structurally blind |

Status: in progress.

---

## Claim 1 -- REFUTED, with a witness valid at every n >= 12

### The hypothesis the step needs

For a symmetric bilinear form $B$ on a real space and vectors $v_1,\dots,v_k$ with $G_{ij}=B(v_i,v_j)$:

| direction | hypothesis |
|---|---|
| dependent $\Rightarrow$ $G$ singular, i.e. **$G$ nonsingular $\Rightarrow$ independent** | none -- but $B$ must be a form **on the space the $v_i$ live in** |
| $G$ singular $\Rightarrow$ dependent, i.e. independent $\Rightarrow$ $G$ nonsingular | $B$ **anisotropic** (definite) on the span |

Two things follow. First, **nondegeneracy is the wrong hypothesis**: a nondegenerate indefinite form has isotropic vectors, and a single nonzero isotropic $v$ has singular $1\times1$ Gram. The hypothesis is *anisotropy*, strictly stronger. Second, and this is where the reduction actually fails, the direction the reduction consumes is free **only if the pairing is a form on the space the covariants live in**.

### Does the apolar pairing supply anisotropy at $n \ge 12$?

**Yes, and it cannot degenerate at any particular $n$** -- but the guarantee is field-specific. The apolar (Bombieri/Frobenius) pairing is positive definite on real tensors, and the restriction of a positive definite form to any subspace is positive definite. There is no $n$ at which it goes indefinite, so no $n$-dependent degeneration of *that* hypothesis exists. Two caveats:

- The guarantee is **over $\mathbb{R}$ only**. The repo's diagram machinery runs mod $p$ ([run_n5_diagram_gram.py](../scripts/runs/run_n5_diagram_gram.py) sets `P = 10007`), and over $\mathbb{F}_p$ a Gram of independent vectors is routinely singular. See [c4_screen_planted.py](../scripts/reviewers/r247/c4_screen_planted.py).
- Anisotropy is supplied by the pairing that carries the **Weyl projector**. That is not the pairing whose entries are monomial in $n$.

### The witness

Two **reduced** degree-2 contraction diagrams on rank-4 tensors (no bare metric, so reviewer 241's reducedness debt is not what is at work here):

$$A(R)=R_{abcd}R_{abcd},\qquad C(R)=R_{abcd}R_{acbd}.$$

| | value |
|---|---|
| as functions on $\mathcal W_n$ | **dependent at every $n$**: $C=A/2$, from the first Bianchi identity alone (verified exactly at $n=5,6,7$ on Bianchi- and trace-verified Weyl tensors) |
| projector-free diagram Gram | $\begin{pmatrix}n^4&n^3\\n^3&n^4\end{pmatrix}$, $\det=n^6(n^2-1)$ -- **nonsingular at every $n\ge2$** (verified exactly at $n=2,3,4,5$) |
| apolar Gram with the Weyl projector | $\tfrac{\dim\mathcal W_n}{4}\begin{pmatrix}4&2\\2&1\end{pmatrix}$, **singular**, as the dependence requires (verified at $n=5,6,7,8$) |

So "nonsingular diagram Gram" and "independent as functions" come apart at every $n$ in the range. The relation lives in $\ker(\text{projection onto }\mathcal W_n)$ -- the first Bianchi identity -- and the pairing graph never sees it.

### The dichotomy, which is the real finding

Only one pairing can be meant, and neither serves the reduction:

| pairing | claim 1 | claim 2 |
|---|---|---|
| projector-free gluing (value $n^L$) | **fails** -- the witness above | entries monomial in $n$, so $\det M(n)$ polynomial |
| apolar with the Weyl projector | holds, by positive definiteness | **fails** -- $\langle A,A\rangle=\dim\mathcal W_n=n(n+1)(n+2)(n-3)/12$, a quartic, not a monomial $c\,n^L$; and [brauer-pairing.md](../findings/brauer-pairing.md)'s own "two things owed" says the block Gram is *rational*, with $1/n$ and $1/(n-2)$ from trace removal |

The commit uses the anisotropy of the second pairing and the polynomiality of the first. The projector-free value $n^4$ is $\dim(\mathbb{R}^n)^{\otimes4}$: **the monomial theorem is measuring the ambient tensor space, not $\mathcal W_n$.**

Script: [c1_bianchi_witness.py](../scripts/reviewers/r247/c1_bianchi_witness.py).

---

## Claim 4 -- the screen is not a fair test, and cannot be made one

The screen is `INDEP` = the standard basis of $\mathbb{Q}^3$ plus one dependent member, run through `gram_rank_exact`. Two objections.

- **The miniature is orthonormal.** Under a positive definite form the criterion is a theorem requiring no validation, so the screen tests nothing that could have failed.
- **It cannot express the failure mode.** The pairing is not a parameter of `gram_rank_exact`; it is `sum(a*b for a, b in zip(u, v))`, hardcoded as the Euclidean form. No input makes the screen see a singular Gram of independent vectors.

Three plants, all of which a screen for this criterion must catch, and none of which this one can be shown ([c4_screen_planted.py](../scripts/reviewers/r247/c4_screen_planted.py)):

| plant | setup | true rank | Gram rank | screen reports |
|---|---|---|---|---|
| 1 | signature $(2,2)$ form on $\mathbb{Q}^4$, totally isotropic plane $\langle(1,0,1,0),(0,1,0,1)\rangle$ | 2 | **0** (Gram is the zero matrix) | 2 |
| 2 | ambient $\mathbb{Q}^2$, covariants are images under projection onto $\langle e_1\rangle$; vectors $(1,0),(1,1)$ | ambient 2, **functions 1** | ambient Gram nonsingular | 2 |
| 3 | $\mathbb{F}_p$, $p=10007$: $v=(1,245,4)$, $v\cdot v\equiv0$ | 1 | **0** | n/a (rationals only) |

Plant 1 is the claim-1 hypothesis test: the form is **nondegenerate** and the Gram is still zero, so nondegeneracy is not what the criterion needs -- anisotropy is. Plant 2 is [c1_bianchi_witness.py](../scripts/reviewers/r247/c1_bianchi_witness.py) in two dimensions and is the failure that actually bites the reduction. Plant 3 matters because [run_n5_diagram_gram.py](../scripts/runs/run_n5_diagram_gram.py) computes mod $p=10007$, where positive definiteness -- the one hypothesis that makes the criterion true -- does not exist.

**Verdict:** the screen validates the criterion in the single regime where it is a triviality. It is not evidence for the reduction, and the commit message's "asserted with the dependent-member case as the check" overstates what was checked.

---

## Claim 2 -- the set is n-independent; the determinant framing still collapses

The brief's worry does **not** bite: a contraction diagram on the 12 Weyl legs of a degree-3 covariant is a combinatorial object and only its evaluation sees $n$, so the spanning set does not vary with $n$. The framing collapses for three other reasons.

### B. The $184\times184$ shape presupposes the basis, which is the problem being solved

A $184\times184$ Gram is the Gram of a set **already cut to a basis** -- the file says so: *"nonsingularity is its specialisation to a set already cut to a basis, which is what the 184 are meant to be."* Cutting a spanning set down to a basis **is** the independence question. So $\det M(n)\ne0$ is offered as the proof of a fact one must already hold to write $M(n)$ down.

And the set does not exist. [run_n24_via_diagrams.py](../scripts/runs/run_n24_via_diagrams.py) closes with *"OWED: the current construction emits VECTORS in a weight space, not diagrams"*, and the tail run that would emit even those stopped at 7 of 71 blocks. The selection space is large: the $f=0$ block alone has $12!/(6!\,2^6)=10{,}395$ matchings.

### C. With a genuine spanning set the determinant is identically zero

Degree 2 on $\mathcal W_n$, where the invariant space is one-dimensional and the three natural diagrams $A=W_{abcd}W_{abcd}$, $C=W_{abcd}W_{acbd}$, $T=W_{abab}W_{cdcd}$ span it:

| $n$ | $3\times3$ Gram rank | $\det$ |
|---|---|---|
| 6 | 1 | $1.2\times10^{-43}$ |
| 7 | 1 | $-3.1\times10^{-60}$ |
| 8 | 1 | $9.1\times10^{-42}$ |

$\det\equiv0$ at every $n$. The honest formulation -- *rank $=184$ for all $n\ge12$* -- is a statement about every $184\times184$ minor of a larger matrix, not about one polynomial's roots, and Sturm does not apply to it.

### D. If the padding lemma holds, the $n$-range needs no polynomial at all

$\mathcal W_n\subset\mathcal W_{n'}$ by zero-padding (traces over the extra directions vanish, first Bianchi is untouched), and a reduced diagram takes the same value on the padded tensor -- verified on $I_3=W_{abcd}W_{cdef}W_{efab}$, constant at $0.2869191717$ under padding from $n=6$ to $n'=7,8,9,12,13$. So $\sum x_cJ_c=0$ on $\mathcal W_{n'}$ restricts to $\sum x_cJ_c=0$ on $\mathcal W_{12}$: **independence at $n=12$ implies independence at every $n\ge12$**, with no polynomial and no Sturm.

This is step 2 of [run_n24_via_diagrams.py](../scripts/runs/run_n24_via_diagrams.py), already in the record. The fork is unavoidable:

- that step is **right**, and the Sturm framing buys nothing beyond the $n=12$ statement -- so the reduction has not replaced the stopped elimination, it has added a harder route to the same conclusion; or
- that step is **wrong**, and the $n=24$ reuse claim that [fence-posts.md](../findings/fence-posts.md) rests on falls with it.

### A collateral factual error

The commit asserts *"the machinery for exactly that gluing already exists at n=5 in run_n5_diagram_gram.py."* That file's own output reads: *"The gluing formula is not yet implemented -- the Weyl projector on eight indices is the missing piece, and guessing it into a six-hour run is the mistake this cycle has already made twice."* The missing piece is precisely the Weyl projector whose absence claim 1 turns on.

Script: [c2_the_set.py](../scripts/reviewers/r247/c2_the_set.py).

---

## Summary

The reduction as committed does not stand. Independence of the covariants is a statement in $\mathrm{Sym}^3(\mathcal W_n)$; the pairing whose entries are monomial in $n$ lives on the ambient tensor space, and the first Bianchi identity separates the two at every $n\ge12$. Repairing it by inserting the Weyl projector -- the honest pairing, positive definite, no degeneration at any $n$ -- costs the polynomiality the Sturm step needs, and the projector is the piece [run_n5_diagram_gram.py](../scripts/runs/run_n5_diagram_gram.py) records as not yet built.

What survives: the diagrams are genuinely $n$-independent combinatorial objects, and the padding lemma genuinely transfers independence upward from $n=12$.
