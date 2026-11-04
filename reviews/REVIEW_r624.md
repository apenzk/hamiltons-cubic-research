# Review r624, Lemma L49, the collapse space and its dimension

**Reviewer B, review number 624.** Cold audit of [findings/target.md:722–727](../findings/target.md#L722), on an identical brief to r623, read independently.

> **VERDICT: GAP.** Every clause that is checkable is *true under a reading the block does not state*, and one clause is unproved. The expansion and its coefficient $3$ are **CONFIRMED**, I rebuilt them three independent ways. The dimension count is **CONFIRMED and upgraded**: I give a five-line symbolic proof, so the number is a theorem and not the rank measurement the record established it by. What is owed is four things: the universal quantifier over $\lambda$, which the block drops and without which the count is false; a proof that the trace conditions are *exactly* the ones named; a proof that constant $T$ is unrealisable; and the scope correction that the record already carries in four other places and this block carries in none. The provenance note is **false**, the mathematics has never been in this file.

---

## 0. Conventions adopted, symbol by symbol

Per the brief, and read from [findings/conventions.md](../findings/conventions.md) rather than from the block.

| symbol | reading adopted | source |
| --- | --- | --- |
| $\langle\cdot,\cdot\rangle$ on $\Lambda^2$ | the **half-trace** pairing $\tfrac12\mathop{\mathrm{tr}}(X^{\mathsf T}Y)$, under which $\{\varphi_{ab}=E_{ab}-E_{ba}\}_{a<b}$ is orthonormal | [conventions.md](../findings/conventions.md), "Norms and pairings" |
| $\lVert W\rVert$ | plain Frobenius on the pair matrix, so $\lVert W\rVert^2=\sum_\alpha\lambda_\alpha^2$ | same bullet |
| $c_{\alpha\beta\gamma}$ | $\langle[v_\alpha,v_\beta],v_\gamma\rangle$, **totally antisymmetric**; hence $T=c^2$ totally symmetric and hollow in the $3$-tensor sense | [conventions.md](../findings/conventions.md), "Structure constants" and "hollow" |
| $\#$ | $(R^\#)_{ab}=\tfrac12c_{a\gamma\delta}c_{b\varepsilon\zeta}R_{\gamma\varepsilon}R_{\delta\zeta}$, **the $\tfrac12$ is in the record's own formula** | [fence-posts.md:57](../findings/fence-posts.md#L57), matching [curvature_operator.py](../scripts/lib/curvature_operator.py) and BW08 eq. (4) |
| $\theta$ | $P(W)/\lVert W\rVert^3$; equal to $P(W)=\langle W,Q(W)\rangle$ **only at $\lVert W\rVert=1$** | [conventions.md](../findings/conventions.md), "The objects" |
| $N$ | $\binom n2=\dim\Lambda^2\mathbb R^n$ | [conventions.md](../findings/conventions.md) |
| triple sums | the block's $\sum_{\alpha<\beta<\gamma}$ is over **unordered** triples; I convert to the ordered sum explicitly wherever it matters, because [conventions.md](../findings/conventions.md) fixes *pairs* as ordered and says nothing about triples |, |

**The one convention gap that bites this block.** [conventions.md](../findings/conventions.md) declares "sums over pairs are over ORDERED pairs unless the line says otherwise" and leaves *triple* sums unfixed, which is exactly the normalisation the coefficient $3$ lives in. The block's $\alpha<\beta<\gamma$ makes its own choice explicit, so the block is safe; the convention file is not, and this is the same shape as the settled $S_{XYZ}$ collision the brief names.

---

## 1. The expansion, CONFIRMED, coefficient $3$ right, three independent ways

Since $c$ is totally antisymmetric, $T_{\alpha\beta\gamma}=c_{\alpha\beta\gamma}^2$ is totally symmetric and vanishes whenever two indices coincide, so

$$\sum_{\alpha,\beta,\gamma}T_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta\lambda_\gamma=6\sum_{\alpha<\beta<\gamma}T_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta\lambda_\gamma$$

**with no leftover diagonal terms**. The block's ordering is therefore consistent with $T$'s symmetry, and the hollowness *is* used, silently, but correctly: it is what makes the restricted sum lossless. So the block's claim is exactly $\langle W^\#,W\rangle=\tfrac12\sum_{\alpha\beta\gamma}T_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta\lambda_\gamma$.

**Check A, the record's own $\#$ formula.** [fence-posts.md:57](../findings/fence-posts.md#L57) prints $(R^\#)_{ab}=\tfrac12c_{a\gamma\delta}c_{b\varepsilon\zeta}R_{\gamma\varepsilon}R_{\delta\zeta}$. In an eigenframe this gives $(W^\#)_{\alpha\alpha}=\tfrac12\sum_{\gamma\delta}T_{\alpha\gamma\delta}\lambda_\gamma\lambda_\delta$, hence $\langle W^\#,W\rangle=\tfrac12\sum_{\alpha\gamma\delta}T\lambda\lambda\lambda=3\sum_{\alpha<\beta<\gamma}T\lambda\lambda\lambda$. **The $\tfrac12$ in the $\#$-formula is precisely what makes the block's $3$ rather than $6$.** Drop it and the block is wrong by a factor $2$.

**Check B, rebuilt from $\mathfrak{so}(4)$ by hand, with no reliance on the record.** With $L_{ab}=E_{ab}-E_{ba}$ orthonormal under the half-trace pairing, direct multiplication gives $[L_{ab},L_{bc}]=L_{ac}$ for distinct $a,b,c$. Hence for $v_\alpha=L_{12}$ the only non-commuting partners are $L_{1c},L_{2c}$ ($c\ne1,2$), each contributing $1$:

$$\sum_\beta\lVert[v_\alpha,v_\beta]\rVert^2=2(n-2),$$

reproducing the Killing marginal of [conventions.md](../findings/conventions.md) exactly and confirming the basis normalisation. Now take $e^+_1=\tfrac1{\sqrt2}(L_{12}+L_{34})$, $e^+_2=\tfrac1{\sqrt2}(L_{13}-L_{24})$, $e^+_3=\tfrac1{\sqrt2}(L_{14}+L_{23})$. Expanding the four brackets gives $[e^+_1,e^+_2]=-\sqrt2\,e^+_3$, so $T=2$ on every same-chirality triple and $0$ on every mixed one. Then, for $W=W^+\oplus W^-$ with each block trace-free on $\mathbb R^3$,

$$3\sum_{\alpha<\beta<\gamma}T\lambda\lambda\lambda=6(\det W^++\det W^-)=2\mathop{\mathrm{tr}}(W^3),$$

using $\mathop{\mathrm{tr}}(A^3)=3\det A$ for trace-free $3\times3$ $A$. That is exactly $\langle W^\#,W\rangle=2\mathop{\mathrm{tr}}(W^3)$, hence $\theta=3\mathop{\mathrm{tr}}(W^3)$ on $\mathcal W_4$, the record's Huisken/adjugate anchor at [fence-posts.md:51](../findings/fence-posts.md#L51). *My $c^+=-\sqrt2$ also matches the record's independently-derived $c^\pm=\mp\sqrt2\,\varepsilon$ at [fence-posts.md:61](../findings/fence-posts.md#L61).*

**Check C, the trace identity, from the same expansion.** With $\mathrm{tri}(A,B,C)=\tfrac12\sum T\,a\,b\,c$ in a common eigenbasis, $\mathop{\mathrm{tr}}(W^\#)=\mathrm{tri}(W,W,I)=\tfrac12\sum_{\alpha\beta\gamma}T_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta$. At $n=4$ this is $\tfrac12\cdot2\cdot2\sum_{\alpha\ne\beta}^{(+)}\lambda_\alpha\lambda_\beta$ per chirality $=-\sum\lambda^2$ by trace-freeness, i.e. $\mathop{\mathrm{tr}}(W^\#)=-\lVert W\rVert^2$, the Böhm–Wilking identity the file itself derives at [target.md:25–33](../findings/target.md#L25). Under the coefficient $6$ this check fails by a factor $2$.

**One normalisation slip in the block.** It writes "$\theta=\dots$" for a quantity that is $P(W)=\langle W,Q(W)\rangle$, homogeneous of degree $3$. By [conventions.md](../findings/conventions.md), $\theta=P/\lVert W\rVert^3$, so the display is an identity only at $\lVert W\rVert=1$, which the block never says. Harmless here (every use is scale-invariant in the collapse condition) but it is the class of omission the brief asks to be reported.

---

## 2. The collapse condition, written out

The block says "the condition that $\theta$ reduce to a multiple of $\sum_\alpha\lambda_\alpha^3$" and stops. Written as an equation, there are two candidates and **the block does not say which**:

- **(U) the $\lambda$-uniform condition.** $\exists\kappa$ such that $3\sum_{\alpha<\beta<\gamma}T_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta\lambda_\gamma=(\kappa-1)\sum_\alpha\lambda_\alpha^3$ **as an identity in $\lambda$**, over every $\lambda$ obeying the trace conditions. Linear in $(T,\kappa)$; solution set a genuine linear subspace of $\mathbb R^{\binom N3}\times\mathbb R$.
- **(P) the pointwise condition.** The same scalar equation at the single $\lambda(W)$ that $T(W)$ comes with. Also linear in $T$ *for fixed $\lambda$*, but it is **one** equation, so its solution set has dimension $\binom N3-1$ or $\binom N3$, and in the coupled variable $(\lambda,T)$ the set is not linear at all.

**The block's own words fit (P) and its dimension fits (U).** [results.md:512](../results.md#L512) carries the missing words ("*for every spectrum obeying the trace conditions*") and [findings/target.md:726](../findings/target.md#L726) does not. **The two canonical copies of L49 differ in exactly the quantifier that the record's own history identifies as the fatal one.**

**Answers to the brief's three questions.**

| question | answer |
| --- | --- |
| linear, quadratic or neither | **Linear**, and only under (U). Under (P) it is linear in $T$ at fixed $\lambda$ and *bilinear-flavoured* in the coupled pair, so no linear dimension count applies. |
| dimension counted over what | Over the **$T$'s** (the space of totally symmetric hollow arrays, $\dim\binom N3$), with $\kappa$ as a free scalar. Not over $\lambda$, not over $\mathcal W_n$. **The block never says this**, and $\mathcal W_n$ is the space a reader arrives with. |
| whose collapse | The set the record names elsewhere as the *$\lambda$-uniform collapse mechanisms* ([bispectral.md:162](../findings/bispectral.md#L162)), i.e. the Huisken/adjugate mechanism of [fence-posts.md:45–61](../findings/fence-posts.md#L45). **It is not** the zero-defect set, the diagonal locus, or the graded stratum, and the block claims no such identification. |

---

## 3. The dimension, CONFIRMED, and it is a theorem rather than a measurement

The record established this by computing ranks: [r97](REVIEW_r97.md) reproduces post F2g's table at $N=6,7,9$ and adds $N=10,15$. **Under the record's literal labelling that would make it an `Observation` at those $N$.** It need not be. Here is the count symbolically, at every $N$ at once.

Take (U) with the single condition $e_1(\lambda)=\sum_\alpha\lambda_\alpha=0$, and set

$$F(\lambda)=3\sum_{\alpha<\beta<\gamma}T_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta\lambda_\gamma-c\sum_\alpha\lambda_\alpha^3,\qquad c:=\kappa-1 .$$

$F$ vanishes on the hyperplane $\{e_1=0\}$; $e_1$ is an irreducible linear form, so $F=e_1\,q$ for a quadratic $q=\sum_\alpha a_\alpha\lambda_\alpha^2+\sum_{\alpha<\beta}b_{\alpha\beta}\lambda_\alpha\lambda_\beta$. Match coefficients of $e_1q$:

| monomial | coefficient in $e_1q$ | coefficient in $F$ | consequence |
| --- | --- | --- | --- |
| $\lambda_\alpha^3$ | $a_\alpha$ | $-c$ | $a_\alpha=-c$ for every $\alpha$ |
| $\lambda_\alpha^2\lambda_\beta$, $\alpha\ne\beta$ | $a_\alpha+b_{\alpha\beta}$ | $0$ | $b_{\alpha\beta}=c$ for every pair |
| $\lambda_\alpha\lambda_\beta\lambda_\gamma$ distinct | $b_{\alpha\beta}+b_{\alpha\gamma}+b_{\beta\gamma}$ | $3T_{\alpha\beta\gamma}$ | $T_{\alpha\beta\gamma}=c$ for every triple |

**So the collapse space is exactly the line $\{T\equiv c\}$, of dimension $1$, for every $N\ge3$**, the second row needs $N\ge2$ and the third $N\ge3$. The block's "at every $N\ge4$" is true and one step conservative. *This is the fifth line of a proof, not a rank at a sample dimension, so the label `Lemma` is defensible for this clause.*

**A frame-free corroboration of the same arithmetic.** $\sum_{\alpha<\beta<\gamma}T_{\alpha\beta\gamma}=\tfrac16\sum_\alpha\mathop{\mathrm{tr}}(-\mathrm{ad}_{v_\alpha}^2)=\tfrac16N\cdot2(n-2)=\binom n3$, independent of the frame. So *if* $T$ were constant its value would be forced to $\binom n3/\binom N3$ ($1/12$ at $n=5$) which is exactly the constant [r97](REVIEW_r97.md) measures as the mean of the realised $T$. My derivation reproduces that table row analytically.

### Where the "$=$" is not earned

The brief's first trap applies, in the *opposite* direction to the usual one and therefore easy to miss.

- **Fewer conditions on $\lambda$ means a bigger collapse space.** The count above is exact *given* that the $\lambda$'s range over the whole traceless hyperplane and nothing smaller. If the realisable spectra spanned less, the collapse space would be **larger** than $1$. So "exactly one-dimensional" needs the trace conditions to be *complete*, and the block proves nothing of the kind, it asserts the identification "number of independent trace conditions $=$ number of irreducible summands of $\mathcal W_n$".
- **That identification is a heuristic, and the record says so.** [bispectral.md:166](../findings/bispectral.md#L166) records that the accounting "sees $\lambda$ only": Bianchi constrains the *frame relative to* $\lambda$, and at $n=5$ nineteen conditions ($54$ traceless operators on $\Lambda^2\mathbb R^5$ against $\dim\mathcal W_5=35$) are discarded. The record's evidence that the $n=5$ spectra fill the traceless hyperplane is a **numerical Jacobian rank** ([bispectral.md:166](../findings/bispectral.md#L166)), so that half of the "$=1$" is an `Observation` at $n=5$ even where the linear algebra above is a `Lemma`.
- **The hedge "governed by" is doing real work.** No law relating the number $k$ of conditions to the dimension is stated anywhere. Two data points exist, $k=1\Rightarrow1$, and $k=2$ at $N=6\Rightarrow7$ ([r97](REVIEW_r97.md)), and $1,7$ determines nothing. Per the brief's checklist item on hedging clauses: this one conceals the absence of a general statement.
- **Point-dependent rank.** The rank of the linear system is constant here, because under (U) the system depends on $\lambda$-space only and not on a point. So the second trap does **not** fire, and the set is equidimensional. That is a clean result and worth recording as such.

---

## 4. The unproved clause: "constant $T$ is not realised by any $\mathfrak{so}(n)$"

**I could not find a proof of this anywhere on the record, and I could not construct one.** The claim must mean: *no orthonormal basis of $\mathfrak{so}(n)$ has $c_{\alpha\beta\gamma}^2$ constant across all distinct triples*, quantified over every frame, since an eigenframe of a general $W$ is arbitrary.

The only reason given is [ATTEMPTS.md:2284](../ATTEMPTS.md#L2284): "*$T_{\alpha\beta\gamma}=\langle[v_\alpha,v_\beta],v_\gamma\rangle^2$ vanishes on most triples*". **That is a statement about the coordinate basis $\{L_{ab}\}$, and it is basis-dependent**, in that basis $[L_{12},L_{34}]=0$, so $T_{(12)(34)\gamma}=0$ for all $\gamma$; in a generic frame no pair commutes and every entry is nonzero. So the reason does not reach the claim. [r97](REVIEW_r97.md) endorses "constant $T$ is never realised" in one clause and supplies no argument for it either.

**I checked the obvious marginal obstructions and none of them fires.** Writing $S_\alpha=-\mathrm{ad}_{v_\alpha}^2\succeq0$, constant $T=c$ forces $\lVert[v_\alpha,v_\beta]\rVert^2=(N-2)c$ for all $\alpha\ne\beta$ and $(N-1)(N-2)c=2(n-2)$. Every marginal I can form is then *consistent*:

| test | requirement under constant $T$ | verdict |
| --- | --- | --- |
| pair cap $\lVert[v_\alpha,v_\beta]\rVert^2\le2$ ([L31](../findings/stratum-two-negative.md)) | $2(n-2)/(N-1)\le2$ | satisfied at every $n\ge4$ |
| Killing marginal $\sum_\beta\lVert[v_\alpha,v_\beta]\rVert^2=2(n-2)$ | $(N-1)\cdot2(n-2)/(N-1)$ | identity |
| Casimir $\sum_\alpha S_\alpha=2(n-2)\mathrm{Id}$ | same equation | identity |
| $\mathop{\mathrm{tr}}(S_\alpha^2)\ge\sum_\beta(S_\alpha)_{\beta\beta}^2=4(n-2)^2/(N-1)$ | against the exact value $\mathop{\mathrm{tr}}(\mathrm{ad}_X^4)=4[(m-4)q+3]$ at $n=2m$, $\lVert X\rVert=1$, $q=\sum_jx_j^4\in[1/m,1]$ | satisfied at every $m$, at both ends of the $q$-range |

This is [post F41](../findings/fence-posts.md#L376)'s shape exactly, the obstruction is invisible to the marginals of $\mathrm{ad}(v)$. **What is owed:** either an argument working with the full antisymmetric $3$-form (Jacobi, not marginals), or the clause weakened to what is actually shown. **Is it reachable?** Probably, and cheaply, at $n=4$, where the two ideals of $\mathfrak{so}(4)$ are canonical and equal-modulus entries across the mixed triples ought to be excludable by hand; I see no route at general $n$ that does not amount to a classification. *A numerical search over frames would decide nothing here and I did not run one, the claim is universally quantified over a non-compact family of frames, so only a proof settles it, and the analysis-only rule applies regardless.*

**And the clause is inferentially inert as it stands.** Even granted, it licenses no conclusion about collapse, because collapse at $n=5$ happens with $T$ manifestly non-constant, §5.

---

## 5. The scope correction the block does not carry, and the refuted sentence in the canon

This is the finding that matters most, and it is not new to me: **the record already knows it, in four places, none of them this block.**

| where | what it says |
| --- | --- |
| [bispectral.md:158–170](../findings/bispectral.md#L158) | post F2g is corrected: quantifier inversion; it never computed $n=5$; its driver (irreducibility) is refuted |
| [ATTEMPTS.md:2298](../ATTEMPTS.md#L2298) | "*it is a quantifier inversion, since collapse needs the condition only at the single $\lambda(W)$ that $T(W)$ comes with*" |
| [report/sections/08-fence-posts.tex:63](../report/sections/08-fence-posts.tex#L63) | "*That is a statement about $\lambda$-uniform mechanisms and it decides no dimension.*" |
| [report/sections/06b-bispectral.tex:58–61](../report/sections/06b-bispectral.tex#L58) | "*This corrects the reading of Lemma 49, in three separate places*" |

**The block under audit carries none of it**, and reads as if the $\lambda$-uniform count settled the question it was built to settle. [findings/INDEX-results.md:64](../findings/INDEX-results.md#L64) records the row as "**Gate 2: no verdict on the record**", which is the honest state.

**A refuted sentence, live in the canon.** [results.md:512](../results.md#L512) appends to L49: "*So for $n\ge5$ the cubic is a function of the spectrum alone at no critical point*" and "*At $n=4$, where $\mathcal W_4$ is reducible, the cubic is spectral*". At $n=5$ the cubic **is** $3\mathop{\mathrm{tr}}(W^3)$, the Lovelock six-index syzygy, [bispectral.md:142](../findings/bispectral.md#L142), so the first sentence is **false at $n=5$** and the second's causal clause ("where $\mathcal W_4$ is reducible") is refuted as the reason. *[findings/target.md](../findings/target.md)'s copy stops one sentence earlier and so escapes this; the two copies of a single numbered result disagree in their conclusions.* **I did not edit [results.md](../results.md), per my brief.**

**A numbering collision, noted in passing.** [report/sections/06b-bispectral.tex:175](../report/sections/06b-bispectral.tex#L175) and [report/sections/08-fence-posts.tex:63](../report/sections/08-fence-posts.tex#L63) cite the $n\le5$ collapse as "Lemma 51". On the record, [L51](../findings/second-order.md) is the second-order variation lemma ([results.md:246](../results.md#L246)) and the bi-spectral collapse is [L50](../findings/bispectral.md) ([INDEX-results.md](../findings/INDEX-results.md)). **The scope correction cites a number that resolves to the wrong result.**

---

## 6. Provenance, FALSE, and the argument is in a file barred from carrying it

The note at [target.md:724](../findings/target.md#L724) claims "*the mathematics has always been in this file*" and points at "*The diagonal proof's ENGINE lifts to any critical point, and its corr*".

**I read that section end to end**, [target.md:9–23](../findings/target.md#L9), from its heading to the next one. It derives the $(ab),(ab)$ diagonal of $Q(W)=\lambda W$ **in the coordinate basis of $\Lambda^2$**: the vertex equation $K_{ab}^2+R_{ab}+(W^\#)_{abab}=\lambda K_{ab}$, the $v\otimes v$ pairing, $\lVert G\rVert_F^2=\mu_K^2+\lVert G_{\mathrm{off}}\rVert_F^2$, and the collapse to $\lambda\mu=\mu^2-\mathrm{Dir}$ on the diagonal locus. **It contains no $T_{\alpha\beta\gamma}$, no eigenframe expansion of the cubic, no collapse condition, and no dimension.** It is not merely a different argument; it is in a different basis, the coordinate basis, which [conventions.md](../findings/conventions.md) warns is "essentially never" a spectral eigenbasis. The pointer is false.

**`git` says so in both directions, as the brief asks.**

| probe | result |
| --- | --- |
| `git log -S` on the string `T_{\alpha\beta\gamma}=\langle[v_\alpha,v_\beta],v_\gamma\rangle^2` in [findings/target.md](../findings/target.md) | **exactly one commit**, `86621751` (2026-08-31, *"number the 24 results that only the report had numbered"*), the commit that created the block |
| `git log -S "collapse space"`, whole tree | first at `5670864a`, *"feat(fence-posts): the collapse space computed, trace conditions, not block structure"*, in [findings/fence-posts.md](../findings/fence-posts.md); then `be02e2d0` into [ATTEMPTS.md](../ATTEMPTS.md); then `d25217b6` into [report/](../report/) |
| the ENGINE section itself | `66e64612`, *"feat(target): the diagonal proof's engine lifts as an identity and fails on orientation"*, genuinely older, and about something else |

So "*always been in this file*" is **false twice over**: the mathematics was never in [findings/target.md](../findings/target.md), and the sentence itself is days old rather than always. This matches the pattern the brief warns of, [r602](REVIEW_r602.md), [r607](REVIEW_r607.md) and [r608](REVIEW_r608.md) found the identical failure on three other blocks from the same commit.

**And there is now no home for the argument in [findings/](../findings/) at all.** The originating post F2g has been removed from [findings/fence-posts.md](../findings/fence-posts.md) (the file's post list runs F1, F2, F4, F25, F24, F23, F3… with no F2g heading) while three live links still point at it, from [fence-posts.md:117](../findings/fence-posts.md#L117), [nondegeneracy.md:245](../findings/nondegeneracy.md#L245) and [bispectral.md:158](../findings/bispectral.md#L158). The surviving derivation sits in [ATTEMPTS.md:2284](../ATTEMPTS.md#L2284), **which the record bars from carrying a numbered result's proof**, and in [report/sections/08-fence-posts.tex](../report/sections/08-fence-posts.tex). *The five-line proof in §3 above closes that hole and can be pasted into the block.*

**Pointers in the block.** Its one link, [report/](../report/), resolves. No empty `(#)` target appears anywhere in [findings/target.md](../findings/target.md). One presentational defect: the block is a raw paste from LaTeX and carries the undefined macros `\Weyl_n` and `\so(n)` plus a LaTeX `---`, none of which render in markdown. Systemic rather than local, seven files carry macros from [report/report.tex](../report/report.tex), but present here.

---

## 7. What consumes L49

**Nothing in [findings/](../findings/) does.** Grepping the whole tree, L49 is referenced only by [results.md:174](../results.md#L174) and [results.md:510](../results.md#L510) (the canon's two copies), [INDEX-results.md:64](../findings/INDEX-results.md#L64), [plan-verification.md:75](../plan-verification.md#L75) (unchecked), and nine times in [report/](../report/).

Every consuming use is **narrative** ("here is why Huisken's mechanism does not extend") and every one of the report's uses **already carries the scope correction beside it**. Two of them explicitly need *less* than the exact dimension: [08-fence-posts.tex:71](../report/sections/08-fence-posts.tex#L71) uses only "at $n=4$ a spectral bound is sharp", and [08-fence-posts.tex:116](../report/sections/08-fence-posts.tex#L116) keeps the post "because the negative it names holds, one dimension further out than it said".

**So the blast radius of every defect above is the wording of one block plus one refuted sentence in [results.md](../results.md).** No proof depends on the exact dimension $1$, and none depends on the unrealisability of constant $T$.

---

## 8. Verdict, and what is owed

**GAP.** Itemised:

| clause | verdict |
| --- | --- |
| the expansion, and the coefficient $3$ | **CONFIRMED**, three independent derivations (§1); the $3$ is right *because* the record's $\#$ carries a $\tfrac12$ |
| $T$ hollow and totally symmetric; the $\alpha<\beta<\gamma$ ordering | **CONFIRMED**, used silently but losslessly |
| "linear in $T$" | **True in both readings**, and therefore not the load-bearing claim it looks like |
| "the collapsing configurations form a subspace" | **True under (U)**, and the block never states (U) |
| "dimension governed by the number of trace conditions … the number of irreducible summands" | **GAP**, a hedge over an unproved identification; the completeness of the conditions is what the "$=1$" rests on, and the record's evidence for it is a numerical Jacobian rank at $n=5$ |
| "under a single condition the collapse space is exactly one-dimensional, $T$ constant, at every $N\ge4$" | **CONFIRMED and upgraded to a proof** (§3), valid for every $N\ge3$; the set is equidimensional, so no generic-versus-uniform distinction arises here |
| "constant $T$ is not realised by any $\mathfrak{so}(n)$" | **GAP, unproved**, the only stated reason is basis-dependent, and every marginal obstruction is consistent with constant $T$ (§4) |
| provenance note | **FALSE** (§6) |

**On the brief's "right generically but false as a uniform statement" outcome: it does not apply.** The rank of the (U)-system is point-independent, so the collapse space is a linear subspace and the dimension $1$ is uniform, not generic. The failure is of a different kind, the *reading*, not the *rank*.

**What is owed, in order of cheapness.**

1. **Restore the quantifier** in [findings/target.md:726](../findings/target.md#L726): "*for every spectrum obeying the trace conditions*", as [results.md:512](../results.md#L512) already has it. Without it the block's own count is false.
2. **Paste in the five-line proof of §3** and say the dimension is derived, not measured, this is free, and it moves the clause from `Observation`-at-sampled-$N$ to `Lemma`.
3. **Carry the scope correction into the block**, in the words the report already uses: it counts $\lambda$-uniform mechanisms and decides no dimension; the collapse reaches $n=5$. Cite [bispectral.md](../findings/bispectral.md) by number.
4. **Weaken or prove the constant-$T$ clause.** As it stands it is an assertion with a basis-dependent reason.
5. **Correct the provenance note** to say the block was created 2026-08-31 carrying the statement, the argument having originated in [findings/fence-posts.md](../findings/fence-posts.md).
6. **Outside this block, for whoever owns them:** the refuted final sentences of [results.md:512](../results.md#L512); the "Lemma 51" citations in [report/](../report/) that should read L50; the three dangling links to the deleted post F2g. *I edited none of these.*

**Computation.** None run. No claim here rests on a number I did not derive by hand; the two places where a number would decide something, whether constant $T$ is realisable, and whether the realisable spectra at each $n$ fill the traceless hyperplane, are named in §3 and §4 as owed, with what each outcome would mean, and left open.
