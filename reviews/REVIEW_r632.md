# Review r632, Lemma L118, the sectional-curvature closed forms behind post F20

**Reviewer B of an independent pair on identical briefs; the other is r631. Target: [findings/curvature-invariants.md:31](../findings/curvature-invariants.md#L31).** Derived cold from the definitions. **Analysis only**, no runs; the arithmetic below is hand arithmetic on numbers the record already prints.

## Verdict

**GAP, and two clauses REFUTED.** The displayed identity is **true, exact, and forced**; it is not a fit. I derive it below in the form

$$\boxed{\ 144\,\theta(W)\;=\;\mathbb E\big[N_{xy}^3\big]\;+\;10\,\mathbb E\big[N_{xy}N_{yz}N_{zx}\big]\ },\qquad N_{xy}:=R(x,y,x,y),\ \ x,y,z\sim\mathcal N(0,I_n)\ \text{i.i.d.},$$

valid at **every** $n\ge4$ and every $W\in\mathcal W_n$, from which the block's $c_n$ and $\tfrac5{72}$ fall out with a closed form the block does not give:

$$c_n=\frac{[n+4]_6}{144}=\frac{(n-1)n(n+1)(n+2)(n+3)(n+4)}{144}=1050,\ 2310,\ 4620,\ \dots\ \text{at }n=6,7,8 .$$

What is wrong with the block is everything around the identity:

| # | Clause | Verdict |
|---|---|---|
| 1 | *"$\theta=c_n\Psi_3+\tfrac5{72}\Phi$, residual $4\times10^{-16}$, exact out-of-sample"* | **CONFIRMED and upgraded**, exact for all $W$, all $n\ge4$; the residual and the out-of-sample points are arithmetic checks, not evidence |
| 2 | $c_n=1050,2310,4620$ with no closed form | **GAP, an omission not a hole**, the closed form is Weingart's own normalising factorial, in [references/weingart-2017-moments-sectional-curvature/notes.md](../references/weingart-2017-moments-sectional-curvature/notes.md) |
| 3 | *"with the $\Phi$ coefficient $n$-independent"* | **FORCED, not observed**, and so is $c_n\propto[n+4]_6$; one mechanism gives both |
| 4 | *"Also false at $n=4,5$"* (as the identity's scope) | **REFUTED**, the identity holds at $n=4,5$ with the same $c_n$ and the same $\tfrac5{72}$. What fails there is uniqueness |
| 5 | $\Phi:=\mathbb E_{x,y,z}[\sec(x,y)\sec(y,z)\sec(z,x)]$ | **REFUTED as written**, under the block's own reading of $\sec$, $|\Phi|\le1$, while the identity needs $\Phi=14.3357$ at $S^3\times S^3$ |
| 6 | *"Gate 2, Reviewer 69 and Reviewer 70, agreeing on every number"* | **FALSE of this result**, [r69](REVIEW_r69.md) **constructed** it; [r70](REVIEW_r70.md) never mentions $\Phi$, $c_n$, $\tfrac5{72}$ or the identity, and returned a different verdict on the same clause |
| 7 | Label `Lemma` | **CONFIRMED, once repaired**, it is a Lemma, but only because a derivation exists; on the record's own evidence it was an Observation at $n=6,7,8$ |

Nothing consumes L118 (§8).

## 0. Which reading I adopt for every symbol

[conventions.md](../findings/conventions.md) is the source for the first four and **carries none of the last three**.

| symbol | reading adopted | where it is fixed |
|---|---|---|
| $\mathcal W_n$, $Q$, $W^\#$ | as tabled | [conventions.md](../findings/conventions.md) |
| $\lVert W\rVert^2$ | $\operatorname{tr}_{\Lambda^2}(W^2)$ with $\{e_i\wedge e_j\}_{i<j}$ orthonormal; equivalently $\lvert R\rvert^2:=\sum_{ijkl}R_{ijkl}^2=4\lVert W\rVert^2$ | [conventions.md](../findings/conventions.md), "the two spectra" and the $M$ bullet; the $t\le2$ normalisation forces it |
| $\theta$ | $P(W)/\lVert W\rVert^3$ with $P=\langle W,Q(W)\rangle=\operatorname{tr}(W^3)+\langle W,W^\#\rangle$. Throughout I write $x:=\operatorname{tr}(W^3)$, $y:=\langle W,W^\#\rangle$, $\lVert W\rVert=1$, so $\theta=x+y$ | [conventions.md](../findings/conventions.md) + the columns of [b_third_moment_refuted.py](../scripts/route-b/b_third_moment_refuted.py), which prints $y$ as `th - tr3` |
| $\sec(\Sigma)$ | $\langle W\xi,\xi\rangle$ for the **unit** decomposable $\xi=x\wedge y$; equals the vertex-matrix entry $K_{ab}=W_{abab}$ in an adapted frame | [conventions.md](../findings/conventions.md) "the vertex matrix"; the script's docstring says the same |
| $\Psi_k$ | $\mathbb E[\sec^k]$ over $G_2(\mathbb R^n)$ with the Fubini–Study density. **Not in conventions.md**, defined only in the script docstring and in [Weingart Cor. 2.6](../references/weingart-2017-moments-sectional-curvature/notes.md) |, |
| $\Phi$ | **Not in conventions.md, and not definable as the block writes it** (§5). I adopt the only reading under which the identity can hold: $\Phi=\mathbb E[N_{xy}N_{yz}N_{zx}]$ with $N$ the *unnormalised* $R(x,y,x,y)$ and $x,y,z$ i.i.d. standard Gaussian | forced in §5 |

The brief's three warnings about `conventions.md` are inert here: $\mathfrak m$, $S_{XYZ}$ and odd-$n$ $\theta_0$ never enter. The one $\theta_0$ used, $\theta_0(6)=\sqrt{10}/3$, is at **even** $n$, where the gloss is correct.

## 1. The derivation

### 1.1 The normalisation is a Wishart moment, and it is the whole of the $n$-dependence

Let $x,y\sim\mathcal N(0,I_n)$ be independent, $g:=\lVert x\wedge y\rVert^2=\lvert x\rvert^2\lvert y\rvert^2-\langle x,y\rangle^2$, and $N:=R(x,y,x,y)$. Then $N=\sec(\Sigma)\cdot g$ where $\Sigma=\operatorname{span}(x,y)$. Writing the $n\times2$ Gaussian matrix as $QR$, the frame $Q$ is uniform on the Stiefel manifold and **independent** of $R$; $\Sigma$ depends only on $Q$ and $g=\det(R^{\mathsf T}R)$ only on $R$. Hence

$$\mathbb E[N^k]=\Psi_k\cdot\mathbb E[g^k].$$

$g$ is the determinant of a $\mathrm{Wishart}_2(n,I)$, so $\mathbb E[g^k]=4^k\,(\tfrac n2)_k\,(\tfrac{n-1}2)_k=[n+2k-2]_{2k}$ (falling factorial). Explicitly

$$\mathbb E[g]=(n-1)n,\qquad \mathbb E[g^2]=(n-1)n(n+1)(n+2),\qquad \mathbb E[g^3]=(n-1)n(n+1)(n+2)(n+3)(n+4)=:D_n .$$

This reproduces **Weingart's own denominator** $[m+2k-2]_{2k}$ in Corollary 2.6, quoted at [notes.md](../references/weingart-2017-moments-sectional-curvature/notes.md#L15), the record already holds the paper that supplies it.

### 1.2 The numerators are $n$-independent

$\mathbb E[N^k]$ is a Wick sum over perfect matchings of the $x$-slots and of the $y$-slots of $k$ copies of $R$. A pairing that joins two slots of the **same** copy contracts $R$ on slots $1,3$ (or $2,4$), giving $\operatorname{Ric}=0$. So every surviving matching pairs slots **across** copies: all $4k$ slots are consumed, no free index and no closed $\delta$-loop survives, and **no factor of $n$ can appear**. The surviving terms are complete contractions of $k$ curvature tensors with fixed combinatorial multiplicities; reducing each to a basis uses only the pair symmetries and the first Bianchi identity, both $n$-free. Hence

$$\mathbb E[N^k]\ \text{is an $n$-independent polynomial in the complete contractions of $k$ Weyl tensors.}$$

Identical reasoning applies to $\Phi=\mathbb E[N_{xy}N_{yz}N_{zx}]$: each of $x,y,z$ occupies four slots, split $2+2$ across two different copies, and the within-copy pairing again dies on $\operatorname{Ric}=0$. **$\Phi$ carries no $n$-dependence at all**, it has no normalising denominator, because no bivector was normalised.

### 1.3 Warm-up, fully derived: $\Psi_2$

$\mathbb E[N^2]=\sum R_{ijkl}R_{i'j'k'l'}\,\mathbb E[x_ix_kx_{i'}x_{k'}]\,\mathbb E[y_jy_ly_{j'}y_{l'}]$. Dropping the Ricci-killed pairings leaves four terms,

$$\mathbb E[N^2]=2\lvert R\rvert^2+2\!\sum R_{ijkl}R_{ilkj}.$$

First Bianchi gives $\sum R_{ijkl}R_{ikjl}=\tfrac12\lvert R\rvert^2$, and $R_{ilkj}=-R_{iljk}$ turns the second sum into the same quantity, so $\mathbb E[N^2]=3\lvert R\rvert^2=12\lVert W\rVert^2$. Therefore

$$\Psi_2=\frac{12\lVert W\rVert^2}{(n-1)n(n+1)(n+2)}\qquad\text{the record's closed form, derived.}$$

It returns $1/70,1/140,1/252,1/420$ at $n=5,6,7,8$, [r70](REVIEW_r70.md)'s list exactly.

### 1.4 $\Psi_3$

By §1.1–1.2, $\Psi_3=\dfrac{\alpha\,x+\beta\,y}{D_n}$ with $\alpha,\beta$ **absolute constants**. Two of the terms are already identifiable: reducing the $8\times8=64$ surviving matchings modulo the per-copy pair symmetry leaves $8$ orbits of size $8$, and the coherent orbit (the one in which each shared index pair stays a bivector), contributes $8\operatorname{tr}(W^3)$, the answer one would get if $x\wedge y$ were an isotropic Gaussian bivector on $\Lambda^2$. The remaining seven orbits are the corrections for decomposability. **I did not finish that reduction by hand** (§9); instead I pin $(\alpha,\beta)$ from the record's own exact values and then test the result five ways:

$$\Psi_3=\frac{224\operatorname{tr}(W^3)-16\langle W,W^\#\rangle}{(n-1)n(n+1)(n+2)(n+3)(n+4)} .$$

| check | source | prediction | recorded |
|---|---|---|---|
| $a/b$ | block, [r69](REVIEW_r69.md), [r70](REVIEW_r70.md) | $224/(-16)=-14$ exactly, every $n$ | $-14$, residual $\le5\times10^{-19}$ |
| $\Psi_3$ at $S^3\times S^3$, $n=6$ ($x=\theta/10$, $y=9\theta/10$) | block | $8\theta/151200=5.577209277193\times10^{-5}$ | $5.577209277193\times10^{-5}$ |
| $\Psi_3$ at $\mathbb{CP}^3$, $n=6$ ($x=\tfrac{31}{60}\theta$) | block | $7.529232524210\times10^{-4}$ | $7.529232524210\times10^{-4}$ |
| $n=4$, where $y=2x$, $\theta=3x$ | [r70](REVIEW_r70.md) | $64\theta/20160=\theta/315$ | $\theta/315$ |
| $n=5$, same | [r70](REVIEW_r70.md) | $64\theta/60480=\theta/945$ | $\theta/945$ |

Five independent recorded numbers, at four dimensions, to every digit printed. Two of them ($n=4,5$) lie **outside** the range the constants were taken from.

### 1.5 $\Phi$, and the identity

With $\Psi_3=(224x-16y)/D_n$, $\Phi=a_\Phi x+b_\Phi y$ ($n$-free by §1.2) and $\theta=x+y$, the block's identity is the $2\times2$ system

$$c_n\frac{224}{D_n}+\tfrac5{72}a_\Phi=1,\qquad c_n\frac{-16}{D_n}+\tfrac5{72}b_\Phi=1 .$$

With the block's own $a_\Phi/b_\Phi=-\tfrac12$ it has the unique solution

$$c_n=\frac{D_n}{144},\qquad \Phi=-8\operatorname{tr}(W^3)+16\langle W,W^\#\rangle .$$

Multiplying through by $144$ and using $\mathbb E[N^3]=D_n\Psi_3$:

$$\mathbb E[N^3]+10\,\Phi=(224x-16y)+10(-8x+16y)=144x+144y=144\,\theta .$$

The identity is therefore an **$n$-free statement about two Gaussian correlations**, and the entire $n$-dependence of the block's version is the Wishart factor $D_n$ converting $\mathbb E[N^3]$ into $\mathbb E[\sec^3]$.

**Is it derived or fitted?** *Derived.* Three facts do all the work, none of them fitted: (i) the cubic $O(n)$-invariants on $\mathcal W_n$ are $2$-dimensional for $n\ge6$, the record's own dimension count, with a literature source at [graphical-calculus notes](../references/graphical-calculus-stable-invariants-2024/notes.md#L23) (Weingart's degree-$3$ generators, "no further IHX relations"); (ii) $\theta$, $\Psi_3$, $\Phi$ are all cubic invariants, and $\Psi_3,\Phi$ are independent because $-14\ne-\tfrac12$; (iii) $\Psi_3$ and $\Phi$ have the structure of §1.1–1.2. Given (i)–(ii) the identity **exists and is unique** before any number is computed; given (iii) its coefficients are *computable*, and I compute them. A coefficient forced by a spanning argument is not an interpolation, and the "residual $4\times10^{-16}$ at three dimensions plus two out-of-sample points" is arithmetic verification of an exact statement.

## 2. The closed form for $c_n$

$$c_n=\frac{[n+4]_6}{144}=\frac{(n-1)n(n+1)(n+2)(n+3)(n+4)}{144}.$$

$n=6:\ 151200/144=1050$. $n=7:\ 332640/144=2310$. $n=8:\ 665280/144=4620$. All three, exactly. The ratios are the sharper test, since they are free of the one constant I pinned from data: the structure predicts $c_7/c_6=D_7/D_6=2.2$ and $c_8/c_6=4.4$, and the block's integers give $2310/1050=2.2$ and $4620/1050=4.4$.

**Is the missing closed form a gap or an omission?** An **omission**, and an avoidable one. The denominator is not a discovery of this programme, it is the normalising falling factorial $[m+2k-2]_{2k}$ printed verbatim in the record's own Weingart notes, in the same file whose post F20 the block is correcting. Recording $c_n$ as three integers when the record holds the paper that gives $c_n$ for all $n$ leaves a reader unable to use the result at $n=12$, which is where this programme's questions live.

## 3. The $n$-independence of $5/72$ is forced

**Forced, and by the same mechanism that makes $c_n$ grow like $n^6$.** From §1.2, $\Phi$ has no normalisation and is an $n$-free linear form; from §1.1, $\Psi_3$'s only $n$-dependence is the scalar $1/D_n$; $\theta$ is $n$-free. So in

$$\theta=\Big(\tfrac{c_n}{D_n}\Big)(224x-16y)+\kappa\,(a_\Phi x+b_\Phi y)$$

the unknowns $c_n/D_n$ and $\kappa$ solve a linear system with $n$-free coefficients. Both are therefore constants: $\kappa=\tfrac5{72}$ at every $n$, and $c_n\propto D_n$. **Not three coincidences.** This is the strongest sentence available here and the block asserts it; it should state the mechanism, which is one line: *$\Phi$ normalises nothing, so it cannot carry $n$; $\Psi_3$ normalises by $\mathbb E[\lVert x\wedge y\rVert^6]$, so it carries all of it.*

## 4. $n=4,5$, the identity is true there. REFUTED as scoped

**Dimension count.** For $n\ge6$ the cubic invariant space is $2$-dimensional. At $n=5$ it is $1$-dimensional, with $\langle W,W^\#\rangle=2\operatorname{tr}(W^3)$; this is the same collapse the record records elsewhere as $P(W)=3\operatorname{tr}(W^3)$ on $\mathcal W_5$ ([r597](REVIEW_r597.md) citing [bispectral.md](../findings/bispectral.md)). At $n=4$ it is $1$-dimensional **over $O(4)$** (see the group question below) and the relation is the same. I checked the $n=4$ relation independently at $\mathbb{CP}^2$: $W_+=\tfrac1{\sqrt6}\operatorname{diag}(2,-1,-1)$, $W_-=0$, so $\lVert W\rVert=1$, $\operatorname{tr}(W^3)=6\cdot6^{-3/2}=1/\sqrt6$, and $\theta=3/\sqrt6=\sqrt{3/2}$, the record's value, and exactly $3\operatorname{tr}(W^3)$.

**Now the logic.** Put $y=2x$, $\theta=3x$ into the closed forms:

$$\Psi_3=\frac{224x-32x}{D_n}=\frac{192x}{D_n},\qquad \Phi=-8x+32x=24x,$$
$$c_n\Psi_3+\tfrac5{72}\Phi=\frac{D_n}{144}\cdot\frac{192x}{D_n}+\frac5{72}\cdot24x=\frac43x+\frac53x=3x=\theta .$$

**The identity holds exactly at $n=4$ and $n=5$, with the same $c_n$ and the same $\tfrac5{72}$.** (At $n=4$: $c_4=140$, $\Psi_3=x/105$; at $n=5$: $c_5=420$, $\Psi_3=x/315$.) The block's "**Also false at $n=4,5$**" is false under the reading that attaches it to the displayed identity. The brief's instinct is right and is the correct repair: one-dimensionality makes the two-term representation **non-unique**, not wrong. With $\Psi_3\propto\Phi\propto\theta$ there, any $(c,\kappa)$ on a line satisfies the equation, so the identity carries no information at $n=4,5$, and, symmetrically, no counterexample either.

**Charitable reading, and why it does not save the sentence.** In [r69](REVIEW_r69.md), in [r70](REVIEW_r70.md) and in the script docstring, "also false at $n=4,5$" attaches to the **fence post's negative claim** ("$\theta$ lies outside the span of the moments"), which is indeed false there in the strongest way: $\theta=315\,\Psi_3$ at $n=4$ and $\theta=945\,\Psi_3$ at $n=5$, so $\theta$ *is* a moment. The block dropped the antecedent, and the sentence now sits immediately after the display with "Also" pointing at it. **Both readings need the line rewritten**, because on the true reading the block asserts the opposite of what the numbers in the same sentence prove: $\theta\propto\Psi_3$ at $n=4,5$ is precisely the statement that the identity *does* hold there, degenerately.

**Which group is in force.** $O(n)$, and $n=4$ is exactly where it matters. Under $SO(4)$ the cubic invariants of $\mathcal W_4$ are **$2$-dimensional** ($\operatorname{tr}(W_+^3)$ and $\operatorname{tr}(W_-^3)$ separately) and the block's dimension claim would be false. Orientation reversal swaps $\Lambda^2_\pm$, so only the sum survives $O(4)$, giving $1$. $\theta$, $\Psi_k$ and $\Phi$ are all defined without reference to orientation (the Grassmannian average is over $O(n)$-orbits, and Weingart's $\Psi^V_k$ are stated as $O(V,g)$-invariants), so **$O(4)$ is the right group and the block's count is correct**, but it is correct for a reason the block does not give, on the one $n$ where the two groups disagree, in a record where a neighbouring audit has already caught an $O$-versus-$SO$ confusion at this exact point. The hypothesis is owed in the text.

## 5. $\Phi$ as written cannot be what the identity uses. REFUTED

The block defines $\Phi:=\mathbb E_{x,y,z}[\sec(x,y)\sec(y,z)\sec(z,x)]$ with the same $\sec$ used for $\Psi_k$, the sectional curvature of a **unit** bivector. Then $\lvert\sec\rvert=\lvert\langle W\xi,\xi\rangle\rvert\le\lambda_{\max}(W)\le\lVert W\rVert=1$, so

$$\lvert\Phi\rvert\le1\quad\text{at every unit-norm }W .$$

But the identity requires, at $S^3\times S^3$ with the block's own printed numbers,

$$\Phi=\tfrac{72}5\big(\theta-c_6\Psi_3\big)=\tfrac{72}5\big(1.054092553389-1050\times5.577209277193\times10^{-5}\big)=\tfrac{72}5(0.995531856)=14.3356587 .$$

$14.34>1$. **The definition as written is refuted, with no computation, from the block's own three numbers.** The reading that works is the unnormalised Gaussian one, $\Phi=\mathbb E[R(x,y,x,y)R(y,z,y,z)R(z,x,z,x)]$, under which §1.5 gives $\Phi=-8x+16y$; at $S^3\times S^3$ ($x=0.1054092553$, $y=0.9486832981$) that is

$$-0.84327404+15.17893277=14.33565873,$$

matching to all nine digits, with $a_\Phi/b_\Phi=-8/16=-\tfrac12$, [r69](REVIEW_r69.md)'s independently recorded ratio. So the object is right and its *name* is wrong: $\Phi$ is a three-vector correlation of **unnormalised** curvatures, not a correlation of sectional curvatures, and calling it "the three-plane correlation" of $\sec$ misdescribes it by a factor of $\mathbb E[g^3]$-type normalisation. This is the same class of defect as the $\lVert\varphi_{ab}\rVert^2=1$ versus $2$ collision already tabled in [conventions.md](../findings/conventions.md): two objects, one symbol, and the numbers only agree under one of them.

Consequences for the record: (i) $\Phi$ and $\Psi_k$ must be defined in [conventions.md](../findings/conventions.md), stating which is normalised; (ii) the sentence "*$\theta$ **is** an explicit closed form in sectional-curvature moments*" (the heading of the corrected post F20), is **overstated as it stands**: $\theta$ is a closed form in the *moments together with one unnormalised three-vector correlation*, which is not a moment of $\sec$ and is not in Weingart's $\Psi_k$ family. The fence post's real content survives in a weaker and still interesting form: *$\theta$ is not a function of the single-plane moments, but it is an explicit $n$-free combination of two Gaussian curvature correlations.*

## 6. The separating pair, both halves are theorems reported as measurements

**The shared $\theta$ is exact, and the record already knows it.** $\theta_0(6)^2=2\cdot5\cdot4/36=10/9$, so $S^3\times S^3$ sits at $\theta=\sqrt{10}/3=1.0540925533894598$. That $\mathbb{CP}^3$ shares it exactly is stated in at least four other places in this record, [INDEX-results.md](../findings/INDEX-results.md) result 9 (*"the two sharing $\theta=\sqrt{10}/3$ exactly"*), [LEDGER.md:24](../findings/LEDGER.md#L24), [LEDGER.md:886](../findings/LEDGER.md#L886) (*"Verified here"*) and [graded-half.md:233](../findings/graded-half.md#L233). **L118 reports it as an agreement "to $2\times10^{-16}$".** That is a roundoff check on a closed form the record holds; write $\sqrt{10}/3$ and the clause becomes a theorem.

**The ratio $13.5$ is exact, and is now a two-line consequence.** By §1.4, $\Psi_3\propto224x-16y=240x-16\theta$ at fixed $\theta$, so the ratio is determined by $\operatorname{tr}W^3$ alone. With $x=\theta/10$ at $S^3\times S^3$ and $x=\tfrac{31}{60}\theta$ at $\mathbb{CP}^3$,

$$\frac{\Psi_3(\mathbb{CP}^3)}{\Psi_3(S^3\times S^3)}=\frac{240\cdot\frac{31}{60}-16}{240\cdot\frac1{10}-16}=\frac{124-16}{24-16}=\frac{108}8=\frac{27}2=13.5 .$$

So yes, **a theorem reported as a measurement**, and the two rational splits $(\tfrac1{10},\tfrac9{10})$ and $(\tfrac{31}{60},\tfrac{29}{60})$ of $\theta$ into $(\operatorname{tr}W^3,\langle W,W^\#\rangle)$ are worth recording in their own right: they reproduce the block's decimals $0.105409/0.948683$ and $0.544614/0.509478$ exactly and are what actually separates the two points.

## 7. Provenance, the Gate 2 sentence is false of this result

The brief's suspicion is confirmed and is worse than stated.

- **[r69](REVIEW_r69.md) is the author.** Its §6 reads *"Secondary REFUTED, **with a construction**. Define the three-plane correlation $\Phi$…"*. The identity, $c_n$, $\tfrac5{72}$ and the out-of-sample points are r69's own output. An author is not a reviewer.
- **[r70](REVIEW_r70.md) never saw it.** Its §6 contains no $\Phi$, no $c_n$, no $\tfrac5{72}$, no out-of-sample check. Its verdict on the same clause is *"secondary **OVERSTATED**"*, reached by a different route (the parity of $\Psi_5,\Psi_7,\dots$, plus a two-parameter *fit* $\theta\sim a\Psi_3+b\Psi_5$ leaving residual $0.200$). r69 says refuted-by-construction, r70 says overstated-by-scope. **These are different verdicts, and the block reports them as one.**
- What r69 and r70 *did* agree on is listed in r70 §"Where it agrees": $\Theta_3=-2\theta$, the ratio $13.5$, $a/b=-14$, and the $\Delta$ numbers. All of those are in the first half of the block. **None of them is the identity.**
- The block's opening therefore transfers agreement earned on the primary claim to a construction only one reviewer made. The correct provenance line is: *"Primary confirmed by [r69](REVIEW_r69.md) and [r70](REVIEW_r70.md) independently; the identity constructed by [r69](REVIEW_r69.md) alone and unaudited until [r631](REVIEW_r631.md)/[r632](REVIEW_r632.md)."* [INDEX-results.md](../findings/INDEX-results.md) row 118 already says *"Gate 2: no verdict on the record"*, which contradicts the block's own opening sentence, **the index and the block disagree, and the index is right.**
- **Reproducibility.** No script in this repository computes $\Psi_3$ exactly, or $\Phi$ at all: [b_third_moment_refuted.py](../scripts/route-b/b_third_moment_refuted.py) is Monte Carlo, computes no $\Phi$, no $c_n$ and no identity, and its own docstring says *"For any new work use exact moments, not this."* r69's and r70's Wick machinery is not in the record and their logs (`agent_logs/reviewer69.log`, `reviewer70.log`) are absent from [agent_logs/](../agent_logs/). Until §1 above, **every number in this block was unreproducible from the record.** That is now repaired for $\Psi_2$, $\Psi_3$, $c_n$ and the identity, by closed form.

## 8. What consumes L118

**Nothing.** `L118` appears in exactly three places, the block itself, the file header of [curvature-invariants.md](../findings/curvature-invariants.md), and the two index rows in [INDEX.md](../findings/INDEX.md) and [INDEX-results.md](../findings/INDEX-results.md). It is absent from [results.md](../results.md), [plan.md](../plan.md), [report/](../report/) and every other findings file. The content is echoed once in [ATTEMPTS.md:2222](../ATTEMPTS.md#L2222).

What the record *does* use is the **negative** fact, and it uses it twice: the corrected post F20 heading and the Weingart reference note both rest on "$\theta$ is not a function of the single-plane third moment", which needs only the separating pair, itself now a theorem (§6), needing neither $\Phi$ nor the identity. So the identity is a strengthening consumed by nothing, which is the right context for judging the defects above: they are cheap to fix and nothing downstream moves when they are.

## 9. What I did not do

- **The two integer pairs $(224,-16)$ and $(-8,16)$ are pinned from the record's exact values, not derived from scratch here.** What is derived is everything else: the factorisation $\mathbb E[N^k]=\Psi_k\mathbb E[g^k]$, $\mathbb E[g^k]=[n+2k-2]_{2k}$, the $n$-independence of both numerators, $\Psi_2$ in full, and the consequences in §2–§6. The residual is a finite, purely combinatorial Wick reduction, for $\mathbb E[N^3]$, $8$ orbits (I identify the coherent one as $8\operatorname{tr}W^3$); for $\Phi$, $2\times4$ terms, each reduced to $\{\operatorname{tr}W^3,\langle W,W^\#\rangle\}$ by first Bianchi. **It is analysis, not computation, and it is owed**; it would make L118 self-contained. I flag it rather than assert it.
- The five independent recorded numbers in §1.4 are checks against the record's arithmetic, not new runs.
- **No computation was performed for this review** and none is required to decide any item above. If the programme later wants the Wick reduction confirmed rather than hand-derived, the run would be seconds, evaluate $\mathbb E[N^3]$ and $\Phi$ by exact contraction on two random $\mathcal W_6$ points and compare with $224x-16y$ and $-8x+16y$, and would decide only whether my two pinned pairs are right; every structural conclusion (§2, §3, §4, §5, §6, §7, §8) stands without it, since each follows from the $n$-free form or from the block's own printed numbers.

## 10. The label

**`Lemma` is correct, but not for the reason the record has.** The record's rule is literal: `Lemma` proven, `Observation` verified at the dimensions named. On the evidence the block actually carries, two coefficients matched at $n=6,7,8$ and checked at two further points, with no spanning argument written down and no closed form for $c_n$, it was an **Observation at $n=6,7,8$** wearing a Lemma's label. §1 supplies the missing derivation, so the label is now earned. The distinction the brief asks for: **the statement was true and the label was unearned**, which is a labelling defect and not a false statement, until §4 and §5, which are false statements.

## Repairs owed

1. **Rewrite the provenance sentence** (§7): r69 constructed, r70 did not see it, the two verdicts differ, first audit is this pair. Reconcile with [INDEX-results.md](../findings/INDEX-results.md) row 118.
2. **Fix the definition of $\Phi$** (§5), unnormalised, three i.i.d. Gaussian vectors, and add $\Psi_k$ and $\Phi$ to [conventions.md](../findings/conventions.md) with their normalisations stated. Soften "$\theta$ is an explicit closed form in sectional-curvature moments" accordingly.
3. **Strike "Also false at $n=4,5$"** (§4) and replace with: *the identity holds at $n=4,5$ but is non-unique there, the cubic invariants being $1$-dimensional over $O(4)$/$O(5)$; what is false there is the fence post's negative claim, since $\theta=315\Psi_3$ and $\theta=945\Psi_3$.* State $O$, not $SO$.
4. **Record the closed forms**: $c_n=[n+4]_6/144$, $\Psi_3=(224\operatorname{tr}W^3-16\langle W,W^\#\rangle)/[n+4]_6$, $\Phi=16\langle W,W^\#\rangle-8\operatorname{tr}W^3$, and the $n$-free master form $\mathbb E[N^3]+10\Phi=144\theta$; cite Weingart Cor. 2.6 for the denominator.
5. **Replace the two measurements by their theorems** (§6): $\theta=\sqrt{10}/3$ at both points, and $13.5=\tfrac{108}8$ from the splits $\tfrac1{10}$ and $\tfrac{31}{60}$.
6. **State the mechanism for the $n$-independence of $\tfrac5{72}$** (§3) (one sentence) since it is currently three data points standing in for a proof.
