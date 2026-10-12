# Review r96, posts 2c, 2e2, 2f and the invariant-theory closure

**No numerical checking was used anywhere in this report.** Every statement below is exact hand algebra or exact symbolic algebra (sympy over `Integer`/`Rational`/`sqrt`, plus one exhaustive enumeration over the finite set of integer edge-labellings of $K_6$). No floating point, no sampling, no solvers, no optimisation. The one non-algebraic input is a literature check for claim 3(a), flagged as such.

Reviewed cold: the sharp map, the adjugate identity, the $\mathfrak{so}(4)$ chirality constants, the collapse criterion, the Gell-Mann tensor, the moduli arithmetic and the orbit-count arithmetic were all derived here before the posts were read for anything beyond their statements.

---

## Summary of verdicts

| # | Claim | Verdict |
|---|---|---|
| 1a | $(R^\#)_{ab}=\tfrac12c_{a\gamma\delta}c_{b\varepsilon\zeta}R_{\gamma\varepsilon}R_{\delta\zeta}$ is the project's / Böhm–Wilking's $\#$ | **CONFIRMED** |
| 1b | $\operatorname{adj}(R)_{ij}=\tfrac12\varepsilon_{iab}\varepsilon_{jcd}R_{ac}R_{bd}$, "residual exactly 0" | **CONFIRMED for symmetric $R$; false as stated for general $R$** (it is the cofactor matrix $=\operatorname{adj}(R)^{\mathsf T}$) |
| 1c | $\#$ is the adjugate $\iff c$ is the volume form | **REFUTED as stated**, normalisation-dependent, and it fails on the very algebras post F2c is about |
| 1d | $\dots\iff\dim\mathfrak g=3$ | **CONFIRMED, by an argument the post never gives** (degree count) |
| 1e | "$\langle W^\#,W\rangle$ is spectral exactly when the form is a volume form" | **REFUTED by the author's own $n=4$ example** |
| 1f | Post F2c's display $\langle W^\#,W\rangle=3(\det W^++\det W^-)=\operatorname{tr}(W^3)$ | **REFUTED, out by a factor 2**, and it contradicts the next sentence of the same post |
| 1g | Post F2c's two-line proof of Huisken Lemma 3.5 | **CONFIRMED** (the one unambiguously good result in this batch) |
| 2a | Collapse criterion, sufficiency as stated | **REFUTED as stated**, needs one $t$ common to all blocks, not "constant on each block" |
| 2b | Collapse criterion, necessity ("exactly when") | **REFUTED**, exact counterexample with full cross-block support |
| 2c | Newton self-correction ($p_3=3e_3$ whenever $e_1=0$, any block size) | **CONFIRMED** |
| 2d | $\mathfrak{su}(3)$ Gell-Mann: $T=f^2\in\{\tfrac14,\tfrac34,1\}$ | **CONFIRMED** |
| 2e | "$28$ of its $56$ triples carry $T=0$" | **REFUTED, it is $47$** |
| 2f | "Condition 3 fails for every block larger than 3" | **UNPROVEN**, and the $\mathfrak{su}(3)$ evidence bears on the wrong object |
| 3a | Orbit finiteness exactly for $N\le8$ | **CONFIRMED** (literature; and the half actually used is provable here in two lines) |
| 3b | "Any argument reaching $\theta$ through a classification of $c$ cannot exist" | **REFUTED, badly overstated; a category error** |
| 4 | "Three independent appearances of the $n=4$ boundary" | **REFUTED**, three *different* boundaries, two of them the same argument |
| 5a | $f(323)>\tfrac{129}{100}>f(324)$; unimodal, decreasing from $n=11$ | **CONFIRMED** (with a caveat: $f(6)<1+\tfrac{\sqrt3}6$) |
| 5b | $n=6$ isospectral pair, $P=0$ against $P=24$ | **CONFIRMED, and stronger than recorded** |
| 5c | Huisken norm correction $\lvert W\rvert=2\lVert W\rVert$ | **CONFIRMED as a norm fact; the conversion it is used for is a non-sequitur as written (factor 4 missing), though the conclusion is right** |

---

## 1. The sharp map as adjugate (post F2e2)

### 1a. The formula is right, CONFIRMED

Derived independently from the project's own definition in [curvature_operator.py](../scripts/curvature_operator.py), `R_sharp_quadform`:

$$\langle R^\#\eta,\eta\rangle=-\tfrac12\sum_i\langle[\eta,R([\eta,R\omega_i])],\omega_i\rangle=-\tfrac12\operatorname{tr}\!\big(\mathrm{ad}_\eta R\,\mathrm{ad}_\eta R\big).$$

With $(\mathrm{ad}_\eta)_{\gamma\alpha}=\eta_\beta c_{\beta\alpha\gamma}$ this is $-\tfrac12\eta_b\eta_f\,c_{bac}c_{fed}R_{ad}R_{ec}$; relabelling and using $c_{b\varepsilon\zeta}=-c_{b\zeta\varepsilon}$ turns the sign over and gives exactly the post's

$$(R^\#)_{ab}=\tfrac12\,c_{a\gamma\delta}c_{b\varepsilon\zeta}R_{\gamma\varepsilon}R_{\delta\zeta}.$$

Symbolic check on $\mathfrak{so}(3)$ with a fully general symmetric $R$: author-formula minus script-formula $=0$, entry by entry.

It also agrees with [Böhm–Wilking](https://arxiv.org/abs/math/0606187) equation (4), $\langle(R\#S)h,h\rangle=\tfrac12\sum_{\alpha\beta}\langle[Rb_\alpha,Sb_\beta],h\rangle\langle[b_\alpha,b_\beta],h\rangle$, which expands to $(R^\#)_{ef}=\tfrac12c_{e\gamma\delta}c_{f\alpha\beta}R_{\alpha\gamma}R_{\beta\delta}$, the same index pairing. Their inner product $\langle A,B\rangle=-\tfrac12\operatorname{tr}(AB)$ is the project's, so the conventions match with no rescaling. **CONFIRMED.**

### 1b. The adjugate identity is the *cofactor* identity

For a general $3\times3$ $R$, exact expansion gives

$$\tfrac12\varepsilon_{iab}\varepsilon_{jcd}R_{ac}R_{bd}-\operatorname{adj}(R)^{\mathsf T}=0,\qquad \tfrac12\varepsilon_{iab}\varepsilon_{jcd}R_{ac}R_{bd}-\operatorname{adj}(R)\ne0 ,$$

the second residual being the antisymmetric part (e.g. entry $(0,1)$ is $r_{01}r_{22}-r_{02}r_{21}-r_{10}r_{22}+r_{12}r_{20}$). Harmless here because every $R$ in play is symmetric, but "verified here symbolically, residual exactly $0$" is true only under that unstated hypothesis. Fix the statement to $\operatorname{cof}(R)_{ij}$ or add "for symmetric $R$".

### 1c. "$\#$ is the adjugate $\iff$ the structure constants are the volume form", REFUTED as stated

The forward half is fine and I confirm it: in the project's basis $E_{(ij)}$ (declared orthonormal, i.e. $\langle A,B\rangle=\tfrac12\operatorname{tr}(A^{\mathsf T}B)$), $\mathfrak{so}(3)$ has $c_{abc}=\varepsilon_{abc}$ **exactly** (max $\lvert c-\varepsilon\rvert=0$), and then $R^\#-\operatorname{adj}(R)=0$ identically on symmetric $R$.

But a $3$-dimensional compact algebra with an invariant metric has $c=\lambda\varepsilon$ for *some* $\lambda$, and then $R^\#=\lambda^2\operatorname{adj}(R)$. So the middle equivalence needs $\lambda^2=1$, which is a normalisation, not a consequence of $\dim\mathfrak g=3$.

**This is not pedantry, it fails on exactly the algebras posts 2c and 2e2 exist to explain.** Building the chirality basis $\omega^\pm$ of $\mathfrak{so}(4)$ with the correct Hodge signs, $\omega^\pm=\tfrac1{\sqrt2}\big(E_{01}\pm E_{23}\big),\ \tfrac1{\sqrt2}\big(E_{02}\mp E_{13}\big),\ \tfrac1{\sqrt2}\big(E_{03}\pm E_{12}\big)$, the Gram matrix is $I_6$ and the structure constants are

$$c^+=+\sqrt2\,\varepsilon,\qquad c^-=-\sqrt2\,\varepsilon,\qquad c(\text{mixed})=0 .$$

Hence on each chirality $W^\#=\mathbf{2}\operatorname{adj}$, verified as an exact symbolic identity $W^\#|_{+}-2\operatorname{adj}(A)=0$ with $A$ a general symmetric $3\times3$. **At $n=4$ the sharp map is twice the adjugate, not the adjugate.** The post's headline is therefore false in the one case it is invoked for.

### 1d. "$\iff\dim\mathfrak g=3$", true, but for a reason the post does not give

$R\mapsto R^\#$ is homogeneous of degree $2$ for every $N$; $R\mapsto\operatorname{adj}(R)$ is homogeneous of degree $N-1$. Equality of the two as maps forces $N-1=2$. That one line is the whole backward direction and it is missing from the post; what the post offers instead ("the structure constants *are* the volume form") is a restatement, not an argument, and 1c shows it is the weaker of the two.

### 1e. "It is spectral exactly when that form is a volume form", REFUTED by the author's own example

This is the sentence the entire invariant-theory section is built on, and it is contradicted two paragraphs earlier in the same post. At $n=4$, $c$ is an alternating $3$-form on $N=6$ dimensions; it is **not** a volume form (a volume form on $\mathbb R^6$ is a $6$-form). Yet $\langle W^\#,W\rangle=2\operatorname{tr}(W^3)$ identically on $\mathrm{Weyl}_4$, verified below as an exact polynomial identity. So spectrality does *not* require a volume form. What it requires at $n=4$ is that $c$ decomposes into commuting $3$-dimensional ideals with a per-ideal trace condition, which is post F2f's content, and post F2f is the correct statement of the mechanism.

The invariant statement the post should be making is: **$\mathfrak g$ is a sum of $3$-dimensional ideals** (i.e. $\mathfrak g\cong\mathfrak{su}(2)^k$), not $\dim\mathfrak g=3$. For $\mathfrak{so}(n)$ that selects $n=3,4$, which is the boundary the post wants, and it gets it only by patching "and $\mathfrak{so}(4)$ escapes by splitting" onto a criterion that does not cover it.

### 1f. Post F2c's displayed chain is out by a factor 2, REFUTED

With $A=W^+$, $B=W^-$ general symmetric $3\times3$ blocks and each trace-free:

$$\langle W^\#,W\rangle-2\operatorname{tr}(W^3)=0,\qquad 3(\det A+\det B)-\operatorname{tr}(W^3)=0 ,$$

both exact. So $\langle W^\#,W\rangle=6(\det A+\det B)$, whereas post F2c displays

$$\langle W^\#,W\rangle=3\big(\det W^++\det W^-\big)=\operatorname{tr}\big((W^+)^3\big)+\operatorname{tr}\big((W^-)^3\big),$$

which is $\operatorname{tr}(W^3)$, **half the truth**. The very next sentence ("Reviewer 94 fixes the constant at $\langle W^\#,W\rangle=2\operatorname{tr}(W^3)$") is correct and directly contradicts the display. The display is the residue of the "$\#=\operatorname{adj}$" error of 1c: it uses $\langle\operatorname{adj}A,A\rangle=3\det A$ where the true map is $2\operatorname{adj}$.

Independent confirmation on $W_{\mathbb{CP}^2}$, $\Lambda^2$-spectrum $(2,-1,-1,0,0,0)$: exact $\langle W^\#,W\rangle=12$, $\operatorname{tr}(W^3)=6$, $P=\langle Q(W),W\rangle=18$, $\lVert W\rVert^2=6$, $\theta^2=\tfrac{18^2}{6^3}=\tfrac32$. So $\langle W^\#,W\rangle=2\operatorname{tr}(W^3)$ and $P=3\operatorname{tr}(W^3)$ both hold; the display does not.

### 1g. The two-line proof of Lemma 3.5 is correct, CONFIRMED

Recorded here because it is the one claim in this batch that is both new and right. Okumura at $m=3$ reads $\operatorname{tr}(A^3)\le\frac{m-2}{\sqrt{m(m-1)}}(\operatorname{tr}A^2)^{3/2}=\frac1{\sqrt6}(\operatorname{tr}A^2)^{3/2}$, with equality at $\operatorname{diag}(2,-1,-1)$ ($6=\tfrac1{\sqrt6}\cdot6\sqrt6$, exact). Then with $a=\lVert W^+\rVert^2$, $b=\lVert W^-\rVert^2$,

$$P=3\operatorname{tr}(W^3)\le\tfrac3{\sqrt6}\big(a^{3/2}+b^{3/2}\big)\le\tfrac3{\sqrt6}(a+b)^{3/2}=\sqrt{\tfrac32}\,\lVert W\rVert^3,$$

since $\tfrac3{\sqrt6}=\sqrt{3/2}$, with equality exactly at $b=0$ and $W^+\propto\operatorname{diag}(2,-1,-1)$, i.e. $W_{\mathbb{CP}^2}$. Clean, and it does make Huisken's Lagrange enumeration non-load-bearing.

### Answering the brief's 1(b) and 1(c) directly

- **Could $\#$ coincide with something adjugate-like in higher dimensions?** Not with the adjugate, degree forbids it (1d). But the post's framing conceals the fact that the *relevant* higher-dimensional structure is not "a substitute for $\det$" at all: $\langle R^\#,R\rangle$ is a fixed $O(n)$-invariant cubic form and it is completely explicit ($T_{abc}=c_{abc}^2$, equal to $1$ on triangles and $0$ elsewhere in the diagonal frame, confirmed at $n=5$: all nonzero $\lvert c\rvert=1$, with exactly $10=\binom53$ of the $\binom{10}3=120$ triples nonzero). Nothing needs to be invented to play the role of $\det$.
- **Does the conclusion follow?** No. "$\#$ is literally defined by $\tfrac12ccRR$, and $\operatorname{adj}$ is $\tfrac12\varepsilon\varepsilon RR$" is a re-reading of a definition, not a discovery, and everything the post extracts from it beyond the degree count (1e, and the whole of section 3 below) does not follow.

---

## 2. The collapse criterion (post F2f)

Setting, confirmed against [isotropy-cap.md](../findings/isotropy-cap.md): in an eigenframe $\theta=\sum_\alpha\lambda_\alpha^3+3\sum_{\alpha<\beta<\gamma}T_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta\lambda_\gamma$ with $T_{abc}=c_{abc}^2$, which I re-derive from 1a: $\langle R^\#,R\rangle=\tfrac12\sum_{a\gamma\delta}c_{a\gamma\delta}^2\lambda_a\lambda_\gamma\lambda_\delta=3\sum_{\alpha<\beta<\gamma}T\lambda\lambda\lambda$.

### 2a. Sufficiency fails as stated, one $t$ per block is not enough

Condition 3 reads "$T_{\alpha\beta\gamma}$ constant over all $\binom{\lvert B\rvert}3$ triples of $B$". Take two blocks $\{1,2,3\}$, $\{4,5,6\}$ with $T\equiv t_1$ inside the first and $t_2$ inside the second, nothing across, and impose condition 2. Exact residual:

$$\theta-\kappa\textstyle\sum\lambda^3=-3\Big[(1+t_1-\kappa)\big(\lambda_1^2\lambda_2+\lambda_1\lambda_2^2\big)+(1+t_2-\kappa)\big(\lambda_4^2\lambda_5+\lambda_4\lambda_5^2\big)\Big],$$

zero iff $\kappa=1+t_1=1+t_2$, i.e. **iff $t_1=t_2$**. The stated conditions therefore do not imply collapse; the post's own next line, "$\sum_{\alpha<\beta<\gamma\in B}T\lambda\lambda\lambda=t\,e_3$", silently uses a single global $t$. At $n=4$ the two blocks do share $t=2$ (from $c^\pm=\pm\sqrt2\varepsilon$), so the example survives; the criterion as written does not.

### 2b. Necessity is REFUTED, condition 1 is not necessary

Exact counterexample. $N=6$, blocks $B_1=\{1,2,3\}$, $B_2=\{4,5,6\}$; set $T\equiv t$ on the two intra-block triples and $T\equiv s$ on **all eighteen** mixed triples, $s$ arbitrary. Then on the slice $\lambda_1+\lambda_2+\lambda_3=\lambda_4+\lambda_5+\lambda_6=0$,

$$\theta-(1+t)\sum_\alpha\lambda_\alpha^3=0\qquad\text{identically, for every }s .$$

The reason is one line: the mixed mass assembles as $s\big[e_2(\lambda_{B_1})e_1(\lambda_{B_2})+e_1(\lambda_{B_1})e_2(\lambda_{B_2})\big]$, and condition 2 kills both $e_1$'s. The cross-block tensor is genuinely nonzero (its cubic evaluates to $1255$ at $\lambda=(1,2,3,5,7,11)$ with $t=0,s=1$). So a $T$ with **full cross-block support** collapses exactly as well as one supported inside blocks, and "no cross-block bracket mass" is not necessary. The claimed "exactly when" is false.

The correct necessary-and-sufficient statement is the obvious linear-algebra one, which the post should say instead: writing $L$ for the linear slice cut out by the block trace conditions, collapse holds iff the cubic $3\sum T\lambda\lambda\lambda-(\kappa-1)p_3$ lies in the ideal $I(L)$. Conditions 1–3 (with 2a's repair) are one sufficient family among others.

*Caveat, stated so it is not overclaimed:* my counterexample is a counterexample to the criterion **as stated in terms of $T$**, which is how the post states it. I do not exhibit a Lie algebra realising that $T$ as $c^2$; whether the "iff" is recoverable under the extra hypothesis $T=c^2$ is open, and the post neither states nor uses that hypothesis in the criterion.

### 2c. The Newton self-correction is right, CONFIRMED

$p_3=e_1p_2-e_2p_1+3e_3$, so $e_1=0\Rightarrow p_1=0\Rightarrow p_3=3e_3$, in any number of variables. The retraction of "Newton forces blocks of size 3" is correct, and the replacement ("what forces size 3 is condition 3") is correct as far as it goes.

### 2d/2e. The $\mathfrak{su}(3)$ computation, values CONFIRMED, count REFUTED

Built the Gell-Mann $T_a=\lambda_a/2$ and extracted $f_{abc}=-2i\operatorname{tr}([T_a,T_b]T_c)$ exactly. The nonzero unordered triples are exactly

$$(123),(147),(156),(246),(257),(345),(367),(458),(678)$$

**nine** of them, with $T=f^2$ taking $1$ on $(123)$, $\tfrac14$ on the six middle triples, $\tfrac34$ on $(458),(678)$. So $\{ \tfrac14,\tfrac34,1\}$ is **CONFIRMED**, and the row marginals are the constant $\sum_{b<c}T_{abc}=\tfrac32$ for every $a$.

But $\binom83=56$ and $56-9=47$. The post's "**28** of its $56$ triples carrying $T=0$ besides" is **wrong by 19**; the correct figure is $47$, and it makes the post's own point (that $T$ is nowhere near constant) considerably stronger. $28=\binom82$, which is where the number probably came from.

### 2f. "Condition 3 fails for every block larger than 3", UNPROVEN, and argued from the wrong object

Two problems.

1. **The evidence does not bear on the claim.** Condition 1 says $c_{\alpha\beta\gamma}=0$ unless all three indices lie in one block; that forces $[\,\mathrm{span}\,B,\mathrm{span}\,B\,]\subseteq\mathrm{span}\,B$ and $[\mathrm{span}\,B,\mathrm{span}\,B']=0$, i.e. **the blocks are commuting ideals**. For $\mathfrak{so}(n)$, $n\ge5$, simplicity leaves exactly one block: all of $\mathfrak g$. $\mathfrak{su}(3)$ is an ideal of no $\mathfrak{so}(n)$, so the Gell-Mann computation (however correct), is a statement about an algebra that can never occur as a block here. It is presented as "already fails for the smallest candidate"; it is not a candidate.
2. **The claim that is actually needed is never stated, let alone proved.** For $n\ge5$ the criterion collapses to a single sharp question: *is there an orthonormal basis of $\mathfrak{so}(n)$ in which $\lvert c_{abc}\rvert$ is constant over all $\binom I3$ triples?* (Condition 2 is then automatic, since $\operatorname{tr}_{\Lambda^2}W=0$ for every Weyl tensor.) In the diagonal frame the answer is plainly no (at $n=5$ only $10$ of $120$ triples are nonzero, all with $\lvert c\rvert=1$) but the criterion quantifies over *all* eigenframes, and no frame-independent obstruction is given. The row-marginal arithmetic does not supply one: constant $T\equiv t$ would need $\binom{N-1}2t=n-2$, i.e. $t=\frac{2(n-2)}{(N-1)(N-2)}$, and the pair cap $\sum_cT_{abc}=(N-2)t=\frac{2(n-2)}{N-1}\le2$ is satisfied for every $n$. So nothing in the project's own constraint set rules it out. **UNPROVEN.**

---

## 3. The invariant-theory closure, the impossibility claim is badly overstated

### 3a. The boundary itself, CONFIRMED, and the half actually used needs no literature

Nothing in [references/](../references/) states the orbit classification; the local Turán papers ([turan-multilinear-2026](../references/turan-multilinear-2026/), [qiao-2020](../references/qiao-2020-turan-alternating-multilinear/)) do not contain it, which the post already concedes. A literature check confirms the fact: Gurevich (1935) classified trivectors for $N=8$ over $\mathbb C$ with finitely many orbits, this fails for $N\ge9$, and **Vinberg–Elashvili classified $N=9$ completely** (several parametrised families, at most $4$ parameters), via the $\mathbb Z/3$-grading of $E_8$; Djoković's real classifications cover $N=8$ and, later, $N=9$.

More usefully, the direction the post actually uses is elementary and provable here:

$$\dim\Lambda^3(\mathbb C^N)-\dim GL_N=\binom I3-N^2=\frac{N\,(N^2-9N+2)}6>0\iff N\ge9 ,$$

exactly ($-16,-14,-8,+3,+20,+44$ at $N=6,\dots,11$). Orbits have dimension $\le N^2$, so moduli exist for $N\ge9$ with no citation required. **The post cites literature for something it could have proved in one line, and the boundary $N\le8$ is nothing more than the solution of that inequality**, which matters for §4.

Also worth noting: $N=\binom n2\in\{3,6,10,15,\dots\}$ **skips $9$ entirely**. The first relevant case beyond $n=4$ is $N=10$, where no classification exists and the $N=9$ literature says nothing. The cited boundary is not tight for the family in question.

### 3b. "Any argument reaching $\theta$ through a classification of $c$ cannot exist", REFUTED

Blunt: this is a category error dressed as a structure theorem, and it repeats a non-sequitur this very file already records as refuted.

1. **$c$ is not a variable point of $\Lambda^3$; it is one specific form, and it is already known.** For each $n$ there is exactly *one* $c$ (the structure form of $\mathfrak{so}(n)$) and the project has it in closed form ($T_{abc}=c_{abc}^2$, equal to $1$ on triangles and $0$ elsewhere in the diagonal frame, all $\lvert c\rvert\in\{0,1\}$, confirmed at $n=5$). A moduli space of *all* alternating $3$-forms is irrelevant to a statement about one distinguished, homogeneous, $\mathrm{Aut}(\mathfrak{so}(n))$-characterised point in it. "Classifying $c$" is not a step any argument here needs to take, because $c$ requires no classification.
2. **The group is wrong.** The alignment data is an eigenframe, so the acting group is $O(N)$ (indeed the stabiliser of the bracket, $\mathrm{Aut}(\mathfrak{so}(n))$), not $GL_N$. $GL_N$-orbit finiteness is neither necessary nor sufficient for anything about $O(N)$-orbits: even at $N\le8$, where $GL$-orbits are finite, the $O(N)$-orbit space of $\Lambda^3$ is a positive-dimensional moduli space. So the cited fact does not even do the work at $n=4$, where the collapse actually happens for a completely different reason (post F2f).
3. **"No finite classification $\Rightarrow$ no argument" is a non-sequitur, and post F2d already says so.** Post F2d records: "'a spectral bound cannot suffice' is a **non-sequitur**". Post F2e2 commits the identical inference in new clothes. Moduli spaces carry sharp inequalities routinely, symmetric matrices modulo $O(n)$ have an $n$-dimensional moduli space (the spectrum) and support Okumura's sharp bound, which post F2c uses two paragraphs earlier.
4. **The project's own target is a counterexample.** Conjecture A is $P\le\theta_0(n)\lVert W\rVert^3$, an inequality over $\mathrm{Weyl}_n/O(n)$, which by the post's own arithmetic has $\frac{n^2(n^2-13)}{12}$ moduli: $4$ at $n=4$, $25$ at $n=5$, $69$ at $n=6$. **At $n=4$ there are already $4$ moduli and the sharp bound is nonetheless proved**, by the two-line argument of 1g. So the one case the post offers as "the finite range where the adjugate already works" is a case with moduli in which an argument exists. That single observation destroys the inference.
5. **"Has moduli" $\ne$ "no usable classification".** $N=9$ is fully classified (Vinberg–Elashvili), moduli and all, into families with at most $4$ parameters.

What the post has actually established is: *the naive hope of enumerating normal forms of $c$ and checking $\theta$ case by case does not scale past $N=8$.* That is worth recording. It is not "any argument reaching $\theta$ through $c$ cannot exist", and the difference is the difference between a fence post and an overclaim. Recommend rewriting the box to the former.

---

## 4. "Three independent appearances of the $n=4$ boundary", REFUTED

They are neither three boundaries at $n=4$ nor three independent arguments.

| appearance | what it actually says | its boundary |
|---|---|---|
| $\#=\operatorname{adj}\iff\dim\mathfrak g=3$ | $\binom n2=3$ | $n=3$ |
| $\frac{n^2(n^2-13)}{12}$ moduli | $-3,\ 4,\ 25,\ 69$ at $n=3,4,5,6$: moduli appear at $n=4$ | $n=3\mid4$, with $n=4$ on the **moduli** side |
| $\Lambda^3$ orbit finiteness, $N\le8$ | $\binom n2\le8\iff n(n-1)\le16\iff n\le4$ | $n=4\mid5$ |

- The first is the $n=3$ boundary, not the $n=4$ one. The post reaches $n=4$ only by appending "and $\mathfrak{so}(4)$ escapes by splitting", i.e. by abandoning the criterion it just proved.
- The second **points the other way**. It says $n=4$ already has $4$ moduli. Post F2d, three lines below, closes with "at $n=4$ moduli and spectrum are both $4$" and refutes the barrier inference drawn from this count. Citing it as a confirmation of a barrier at $n\ge5$ contradicts the adjacent post.
- Methodologically, the second and third are the **same argument**: dimension of a representation against dimension of the acting group. The third's boundary $N\le8$ is literally $\binom I3\le N^2$ (§3a). Only the first is a different kind of statement, and it lands at a different $n$.

Verified arithmetic: $\dim\mathrm{Weyl}_n-\dim O(n)-\frac{n^2(n^2-13)}{12}=0$ identically; $\binom n2\le8\iff n\le4$ since $\binom42=6$, $\binom52=10$.

---

## 5. Sweep of the other corrections

### 5a. The $1+\frac{\sqrt3}6$ floor, CONFIRMED, with a caveat the post does not carry

$f(n)=\frac{n(n-3)}{(n-1)(n-2)}+\frac{n\sqrt3}{6\sqrt{(n-1)(n-2)}}$. Exactly:

- $\lim_{n\to\infty}f=1+\frac{\sqrt3}6$. **CONFIRMED.**
- $f(k+1)-f(k)>0$ for $k=6,\dots,10$ and $<0$ for $k=11,\dots,19$: unimodal with maximum at $n=11$, $f(11)=\frac{44}{45}+\frac{11\sqrt{30}}{180}$. **CONFIRMED.**
- $f(323)-\frac{129}{100}=\frac{323\sqrt{34454}}{206724}-\frac{1498849}{5168100}>0$ and $f(324)-\frac{129}{100}=\frac{27\sqrt{312018}}{52003}-\frac{1508187}{5200300}<0$. **CONFIRMED exactly**, the refutation of $1.29$ as an unconditional floor stands, at precisely the stated $n$.
- **Caveat.** $f(6)=\frac9{10}+\frac{\sqrt{15}}{10}<1+\frac{\sqrt3}6<f(7)=\frac{14}{15}+\frac{7\sqrt{10}}{60}$. So $1+\frac{\sqrt3}6$ is a lower bound on $f$ only for $n\ge7$. The post's wording ("unimodal and decreasing from $n=11$ to the limit") is defensible, but a reader will take $1.2886$ as the unconditional floor and it is not one at $n=6$, the very dimension the project's smallest live case sits at.

### 5b. The $n=6$ isospectral pair, CONFIRMED, and stronger than recorded

A diagonal Weyl operator at $n=6$ is a symmetric zero-diagonal $\lambda_{ij}$ on $K_6$ with vanishing row sums (Ricci-flat; first Bianchi is automatic). Then $P=\sum_{i<j}\lambda_{ij}^3+3\sum_{i<j<k}\lambda_{ij}\lambda_{ik}\lambda_{jk}$, since $T=1$ exactly on triangles.

Exhaustive exact enumeration over all $3^{15}$ integer labellings, filtered to spectrum $(1^6,0^3,(-1)^6)$ and zero row sums, yields **300 tensors**, with

$$P\in\{-24,\,0,\,+24\},\qquad\text{counts }60/180/60,$$

all with $\lVert W\rVert^2=12$ and $\operatorname{tr}(W^3)=0$. So the pair exists (**CONFIRMED**) and the true spread is $48$, not $24$: the record quotes $0$ against $24$ but $-24$ also occurs. (Structurally: the three zero edges must form a perfect matching, so $\lambda$ is $K_6$ minus a $1$-factor $=K_{2,2,2}$, $2$-factored into a $+$ part and a $-$ part; $P=\pm24$ when the $\pm$ parts are triangle pairs, $P=0$ when they are hexagons.) I did not check the stabiliser claim; it is not needed for the conclusion, which is that no spectral function determines $P$.

### 5c. The Huisken norm correction, the fact is right, the conversion as written is not

$\lvert W\rvert=2\lVert W\rVert$ is correct. But the note in [huisken notes](../references/huisken-1985-ricci-deformation/notes.md) says the sharp constant "$\frac{\sqrt6}4$ against $\lvert W\rvert^3$ ... in the project's normalisation becomes $\frac{\sqrt6}2$", attributing the whole conversion to the norm. That does not work:

$$\tfrac{\sqrt6}4\lvert W\rvert^3=\tfrac{\sqrt6}4\cdot8\lVert W\rVert^3=2\sqrt6\,\lVert W\rVert^3\ \ne\ \tfrac{\sqrt6}2\lVert W\rVert^3 ,$$

a factor of exactly $4$ adrift. The missing factor is in the *cubic*, not the norm, and the note never says so. Supplied here: with the $4$-dimensional normal form $W^\pm=\operatorname{diag}(\lambda_i\pm\mu_i)$, $\sum\lambda=\sum\mu=0$, Huisken's

$$P=6\{\lambda_1\lambda_2\lambda_3+\lambda_1\mu_2\mu_3+\lambda_2\mu_1\mu_3+\lambda_3\mu_1\mu_2\}+\textstyle\sum\lambda_i^3+3\sum\lambda_i\mu_i^2$$

satisfies $P-\tfrac32\operatorname{tr}(W^3)=0$ **exactly**. Hence Huisken's left-hand side $=8P=12\operatorname{tr}(W^3)=4\langle Q(W),W\rangle$, and

$$\langle Q(W),W\rangle\le\tfrac14\cdot\tfrac{\sqrt6}4\big(2\lVert W\rVert\big)^3=\tfrac{\sqrt6}2\lVert W\rVert^3=\sqrt{\tfrac32}\lVert W\rVert^3 .$$

The stated conclusion is therefore right and the note's independent $\mathbb{CP}^2$ check ($\theta=3\cdot6/6^{3/2}$) is right; only the stated *reason* is incomplete. Recommend the note record "$8P=4\langle Q(W),W\rangle$" alongside "$\lvert W\rvert=2\lVert W\rVert$", since the norm alone gives the wrong constant by $4\times$.

---

## What to change

1. **Post F2c:** delete the display $\langle W^\#,W\rangle=3(\det W^++\det W^-)=\operatorname{tr}((W^+)^3)+\operatorname{tr}((W^-)^3)$; it is half the correct value and contradicts the sentence after it. Replace with $\langle W^\#,W\rangle=6(\det W^++\det W^-)=2\operatorname{tr}(W^3)$, and say that on each chirality $\#=2\operatorname{adj}$ because $c^\pm=\pm\sqrt2\,\varepsilon$. Keep 1g's two-line proof unchanged; it is correct.
2. **Post F2e2:** replace "$\#$ is the adjugate $\iff\dim\mathfrak g=3$" by the statement that actually covers $n=4$, *$\langle R^\#,R\rangle$ is spectral when $\mathfrak g$ is a sum of $3$-dimensional ideals and $R$ is trace-free on each*, and add the missing degree argument ($\#$ quadratic, $\operatorname{adj}$ of degree $N-1$) for the backward direction. Delete "it is spectral exactly when that form is a volume form": $n=4$ refutes it.
3. **Post F2f:** condition 3 must require **one $t$ common to all blocks**; and the "exactly when" must go, because cross-block mass of the $2{+}1$ pattern is invisible on the block-trace-free slice. State the correct criterion as the ideal membership $3\sum T\lambda\lambda\lambda-(\kappa-1)p_3\in I(L)$. Fix $28\to47$. Drop $\mathfrak{su}(3)$ as "the smallest candidate" (condition 1 forces blocks to be ideals, so it is not a candidate) and replace it with the question that is actually at stake: is there an orthonormal basis of $\mathfrak{so}(n)$ with $\lvert c_{abc}\rvert$ constant? That is open.
4. **The invariant-theory box:** downgrade from "any argument reaching $\theta$ through a classification of $c$ cannot exist" to "normal-form enumeration of $c$ does not scale past $N=8$". $c$ is a single known form; the group is $O(N)$, not $GL_N$; and $n=4$ is itself a moduli case with a proved sharp bound.
5. **"Third independent appearance of the $n=4$ boundary":** delete. The three land at $n=3$, $n=3\!\mid\!4$ and $n=4\!\mid\!5$, the middle one points the other way, and two of the three are the same dimension-versus-group count.
6. **Huisken notes:** add $8P=4\langle Q(W),W\rangle$; the norm correction alone leaves the constant $4\times$ too large.
7. **Post F1:** the $n=6$ spread is $\{-24,0,+24\}$ over $300$ tensors, not $\{0,24\}$.
