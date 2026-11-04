# Review r623, Lemma L49, the collapse space and its dimension

**Reviewer A of a Gate 2 pair on identical cold briefs (sibling: r624). Target: [findings/target.md:722](../findings/target.md#L722), with the canonical copy at [results.md:510](../results.md#L510).**

## Verdict

**REFUTED as recorded, on a split that matters and that the record's own [report/](../report/) already knows.**

- **The linear algebra is CONFIRMED, and I upgrade it from a rank measurement to a theorem.** The collapse space is *exactly* one-dimensional under one trace condition, at every $N\ge3$, and *exactly* seven-dimensional under the two conditions of $n=4$ at $N=6$. Both derived below symbolically, with no computation.
- **The conclusion drawn from it is REFUTED, with the witness at $n=5$.** [results.md:512](../results.md#L512) asserts *"for $n\ge5$ the cubic is a function of the spectrum alone at no critical point"*. At $n=5$ the cubic **is** a function of the spectrum alone ($\theta=3\mathop{\mathrm{tr}}(W^3)$ on all of $\mathcal W_5$), by the record's own [Lemma L50](../results.md#L244) and [fence post 2g](../findings/fence-posts.md#L121). This is a quantifier inversion the record diagnosed on **2026-08-26**, five days before the block was written on 2026-08-31.
- **The clause *"which is the number of irreducible summands of $\mathcal W_n$ under $O(n)$"* is FALSE at $n=4$.** $\mathcal W_4$ is $O(4)$-**irreducible**; an orientation-reversing isometry exchanges $\mathcal W^{+}$ and $\mathcal W^{-}$. Read literally, the canon's own rule predicts a one-dimensional collapse space at $n=4$ and so contradicts the $7$ it is built to explain. The group is $SO(n)$.
- **The provenance note is FALSE on both counts**, confirmed by `git log`: see §5.
- **Nothing consumes L49**, so the blast radius is the canon's own text.

## 0. Symbols, each fixed before use

The brief warns that [conventions.md](../findings/conventions.md) is incomplete. Every symbol I use, and the reading I take:

| symbol | reading adopted | authority |
| --- | --- | --- |
| $\langle\cdot,\cdot\rangle$ on $\Lambda^2$ | the **half-trace** pairing, $\langle X,Y\rangle=\tfrac12\mathop{\mathrm{tr}}(X^{\mathsf T}Y)$, under which $\{\varphi_{ab}\}_{a<b}$ is orthonormal and $\mathop{\mathrm{tr}}(v^2)=-2$ for a unit bivector | [conventions.md](../findings/conventions.md), *Norms and pairings*, first two bullets |
| $\lambda_\alpha$ | the spectrum of $W$ **as an operator on $\Lambda^2\mathbb R^n$**, at $\lVert W\rVert=1$, so $\sum\lambda_\alpha=0$ and $\sum\lambda_\alpha^2=1$. **This is what [conventions.md](../findings/conventions.md) calls $\mu$**; the block writes $\lambda$, and $\mu$ is one of the record's tabled three-way collisions, so I avoid it | [conventions.md](../findings/conventions.md), *the two spectra* |
| $\theta$ | $\langle W,Q(W)\rangle$ at $\lVert W\rVert=1$ | [conventions.md](../findings/conventions.md), objects table |
| $T_{\alpha\beta\gamma}$ | $c_{\alpha\beta\gamma}^2$ with $c_{\alpha\beta\gamma}=\langle[v_\alpha,v_\beta],v_\gamma\rangle$ **totally antisymmetric**, so $T$ is totally symmetric and **hollow in the $3$-tensor sense**, it vanishes whenever two indices coincide | [conventions.md](../findings/conventions.md), *Structure constants*; *hollow* row |
| $N$ | $\binom n2=\dim\Lambda^2\mathbb R^n$, so the realised values are $6,10,15,21,\dots$ | [conventions.md](../findings/conventions.md) |
| $\mathcal W_n$, $\mathrm{Weyl}_n$ | the same object; I write $\mathcal W_n$ | [conventions.md](../findings/conventions.md) |

$\mathfrak m$, $S_{XYZ}$ and $\theta_0(n)$ (the three gaps the brief names), play no part in this lemma, so none of their ambiguities reaches it.

**Computation used: none.** Every number below, including the $7$, is derived by hand. I ran no screen.

## 1. The expansion, derived cold

Write $W=\sum_\alpha\lambda_\alpha\,v_\alpha\otimes v_\alpha$ in an orthonormal eigenframe of $\Lambda^2\mathbb R^n\cong\mathfrak{so}(n)$. Then $\theta=\langle W,W^2\rangle+\langle W,W^{\#}\rangle=\mathop{\mathrm{tr}}(W^3)+\langle W,W^{\#}\rangle$, and $\mathop{\mathrm{tr}}(W^3)=\sum_\alpha\lambda_\alpha^3$ needs nothing.

For the sharp product, take the Lie-algebra form $W^{\#}=c\sum_{\alpha,\beta}\lambda_\alpha\lambda_\beta\,[v_\alpha,v_\beta]\otimes[v_\alpha,v_\beta]$, so that $(W^{\#})_{\gamma\gamma}=c\sum_{\alpha\beta}T_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta$. **The constant is $c=\tfrac12$**, and I pin it from outside the block: for the identity operator, $(\mathrm{Id}^{\#})_{\gamma\gamma}=c\sum_{\alpha\beta}T_{\alpha\beta\gamma}=c\sum_\alpha\lVert[v_\alpha,v_\gamma]\rVert^2=2c(n-2)$ by the Killing marginal $\sum_\beta\lVert[v_\alpha,v_\beta]\rVert^2=2(n-2)$ of [conventions.md](../findings/conventions.md), and $\mathrm{Id}^{\#}=(n-2)\mathrm{Id}$ forces $c=\tfrac12$.

Hence

$$\langle W,W^{\#}\rangle=\tfrac12\sum_{\alpha,\beta,\gamma}T_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta\lambda_\gamma=\tfrac12\cdot 3!\sum_{\alpha<\beta<\gamma}T_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta\lambda_\gamma=3\sum_{\alpha<\beta<\gamma}T_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta\lambda_\gamma .$$

**The coefficient $3$ is CONFIRMED, and it is exactly the multinomial weight $3!/2$.** The brief's warning is live: the $3$ is the product of the $\tfrac12$ in $\#$ and the $6$ from the strict ordering, so it is normalisation-sensitive at both ends. Answering the brief's two sub-questions:

- **$T$'s vanishing on repeated indices is load-bearing.** The step $\sum_{\alpha,\beta,\gamma}=6\sum_{\alpha<\beta<\gamma}$ is valid only because every term with a repeated index is zero. Without hollowness the ordered sum carries $\lambda_\alpha^2\lambda_\beta$ terms and the identity is false.
- **The $\alpha<\beta<\gamma$ ordering is consistent with $T$'s total symmetry**, which is itself a consequence of the ad-invariance of the pairing making $c_{\alpha\beta\gamma}$ totally antisymmetric.

**Two independent anchors, both of which the expansion passes.**

1. *$\mathop{\mathrm{tr}}(W^{\#})=-\lVert W\rVert^2$.* With $c=\tfrac12$, $\mathop{\mathrm{tr}}(W^{\#})=\tfrac12\sum_{\alpha\gamma}\lambda_\alpha\lambda_\gamma\lVert[v_\alpha,v_\gamma]\rVert^2$, which is $\langle W,W^{\#}\mathrm{Id}\rangle$ under the same $c$; the record's $W\#\mathrm{Id}=-W$ ([target.md:29](../findings/target.md#L29), Böhm–Wilking Lemma 2.1) then gives $-\lVert W\rVert^2$. Consistent.
2. *The $n=4$ value, computed from scratch.* $\mathfrak{so}(4)=\mathfrak{so}(3)^+\oplus\mathfrak{so}(3)^-$, so $T$ is supported inside the two triples. Taking $v_1=\tfrac1{\sqrt2}(\varphi_{12}+\varphi_{34})$, $v_2=\tfrac1{\sqrt2}(\varphi_{13}+\varphi_{42})$, $v_3=\tfrac1{\sqrt2}(\varphi_{14}+\varphi_{23})$ and expanding four brackets by hand gives $[v_1,v_2]=-\sqrt2\,v_3$, so $T_{123}=2$, and likewise $T_{456}=2$; every mixed triple is $0$ since the factors commute. With $\mathcal W_4$ trace-free on each half, $\lambda_1\lambda_2\lambda_3=e_3=\tfrac13p_3$ per half, so $\theta=p_3^++p_3^-+3\cdot 2\cdot\big(\tfrac13p_3^++\tfrac13p_3^-\big)=3\mathop{\mathrm{tr}}(W^3)$. **This reproduces the record's $\langle Q(W),W\rangle=3\mathop{\mathrm{tr}}(W^3)$ on $\mathcal W_4$ and its $\langle W^{\#},W\rangle=2\mathop{\mathrm{tr}}(W^3)$ exactly**, from an independent bracket computation, which pins both $c=\tfrac12$ and the $3$.

## 2. The collapse condition, written out

Fix $n$. Let $H\subset\mathbb R^N$ be the linear subspace cut out by the trace conditions the spectrum obeys, $H=\{e_1(\lambda)=0\}$ for $n\ge5$; $H=\{e_1(\lambda^+)=0\}\cap\{e_1(\lambda^-)=0\}$ at $n=4$. Let $\mathcal T$ be the space of totally symmetric **hollow** $3$-tensors on $N$ indices, $\dim\mathcal T=\binom N3$, and set $C_T(\lambda):=\sum_{\alpha<\beta<\gamma}T_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta\lambda_\gamma$. The condition is

$$\mathcal C:=\{\,T\in\mathcal T\ :\ \exists\,\kappa\in\mathbb R\ \text{ with }\ 3\,C_T(\lambda)=\kappa\,p_3(\lambda)\ \text{ for every }\lambda\in H\,\}.$$

Answering the brief's three questions:

- **It is LINEAR**, in $(T,\kappa)$ jointly, hence a subspace, and its image in $\mathcal T$ is a subspace. The block's *"linear in $T$"* is correct. No smoothness or genericity caveat is needed; the dimension below is the dimension of a genuine linear subspace, not a generic rank.
- **The dimension is counted over the $T$'s**, in $\mathcal T\cong\mathbb R^{\binom N3}$, not over the $\lambda$'s and not in $\mathcal W_n$. **The block never says so**, and the record's own $7/20$ and $1/20$ figures only make sense under this reading ($\binom63=20$). *This is the single most important thing the block omits, because it is what makes the "dimension" harmless: a one-dimensional subspace of $T$-space says nothing about a locus in $\mathcal W_n$.*
- **Whose collapse.** $\mathcal C$ is **not** the zero-defect set, the diagonal locus or a graded stratum; it is a subspace of a tensor space that no point of $\mathcal W_n$ inhabits *as a set*. The set it should be compared against is the honest one, $\{W\in\mathcal W_n:\theta(W)=3\mathop{\mathrm{tr}}(W^3)\}$, and that set is **all of $\mathcal W_n$ for $n\le5$** ([Lemma L50](../results.md#L244), [bispectral.md:142](../findings/bispectral.md#L142)). $\mathcal C$ and that set are different objects, and conflating them is the defect.

## 3. The dimension, proved, not measured

**Claim (one trace condition).** For every $N\ge3$, $\mathcal C=\mathbb R\cdot\mathbf 1$, where $\mathbf 1_{\alpha\beta\gamma}=1$ on distinct triples. So $\dim\mathcal C=1$ exactly.

*Proof.* First, $T\mapsto C_T\big|_H$ is **injective** on $\mathcal T$. If $C_T$ vanishes on $H=\{e_1=0\}$ then $e_1\mid C_T$, so $C_T=e_1\cdot q$ for a quadratic $q=\sum_{\alpha\le\beta}q_{\alpha\beta}\lambda_\alpha\lambda_\beta$. The coefficient of $\lambda_\alpha^3$ in $e_1q$ is $q_{\alpha\alpha}$, which must vanish since $C_T$ has no cube; then the coefficient of $\lambda_\alpha^2\lambda_\beta$ is $q_{\alpha\beta}$, which must vanish since $C_T$ has no such monomial. So $q=0$ and $T=0$.

Second, $C_{\mathbf 1}=e_3$, and on $H$ the Newton identity $p_3=e_1^3-3e_1e_2+3e_3$ reduces to $p_3=3e_3$. So $3C_{\mathbf 1}=p_3$ on $H$: $\mathbf 1\in\mathcal C$ with $\kappa=1$.

Third, by injectivity the fibre of $T\mapsto C_T|_H$ over $\tfrac\kappa3 p_3|_H=\kappa\,e_3|_H$ is at most a point, and $\kappa\mathbf 1$ is in it. Hence $\mathcal C=\mathbb R\cdot\mathbf 1$. $\square$

**Claim ($n=4$, two trace conditions, $N=6$).** $\dim\mathcal C=7$.

*Proof.* Write $A=\{1,2,3\}$, $B=\{4,5,6\}$, $u=\lambda_1+\lambda_2+\lambda_3$, $v=\lambda_4+\lambda_5+\lambda_6$. Now $C_T$ vanishes on $H$ iff $C_T\in(u,v)$. Two families work: $T_{abj}:=s_{ab}$ for $a<b\in A$, $j\in B$, giving $C_T=v\cdot\sum s_{ab}\lambda_a\lambda_b$; and its mirror $T_{aij}:=s'_{ij}$ for $a\in A$, $i<j\in B$, giving $C_T=u\cdot\sum s'_{ij}\lambda_i\lambda_j$. That is $3+3=6$ dimensions, and they are independent (they occupy the $AAB$ and $ABB$ blocks). They exhaust the kernel: any factorised $T=g\otimes s$ needs either $g$ annihilated on $H$ (which is the constant $g$ already listed) or $\sum s_{ab}\lambda_a\lambda_b\equiv0$ on $\{u=0\}$, and substituting $\lambda_3=-\lambda_1-\lambda_2$ gives $-s_{13}\lambda_1^2-s_{23}\lambda_2^2+(s_{12}-s_{13}-s_{23})\lambda_1\lambda_2$, zero only at $s=0$. Adding the $p_3$ direction ($\mathbf 1$ again works, since $e_1=0$ on $H$ so $p_3=3e_3$ still) gives $\dim\mathcal C=6+1=7$. $\square$

**So the record's $1/20$ and $7/20$ are reproduced symbolically, and the traps the brief names are both avoided here.** The count is not "the codimension of a target", so the free-codimension trap does not apply; and the rank is not point-dependent, because the map is a fixed linear map between fixed vector spaces, there is no locus over which it could drop. **The dimension is a theorem, and after this review it has a proof on the record rather than [fence post 2g](../findings/fence-posts.md#L121)'s table of six computed ranks at $N=6,7,9$.**

Two wording defects survive the confirmation:

- **"at every $N\ge4$"** should be $N\ge3$; and since $N=\binom n2$, the realised values start at $6$, so the quantifier is over an abstract $N$ that the reader has no reason to expect. Harmless, but say which $N$ is meant.
- **"the number of irreducible summands of $\mathcal W_n$ under $O(n)$"**, at [results.md:512](../results.md#L512), **is false at $n=4$**. $\mathcal W_4=\mathcal W^+\oplus\mathcal W^-$ is a decomposition under $SO(4)$ only: an orientation-reversing isometry exchanges $\Lambda^{\pm}$ and hence $\mathcal W^{\pm}$, and since $\mathcal W^+\not\cong\mathcal W^-$ as $SO(4)$-modules, the only $O(4)$-invariant subspaces are $0$ and the whole. So under $O(n)$ the summand count is $1$ at **every** $n\ge4$, and the canon's own rule would give $\dim\mathcal C=1$ at $n=4$, contradicting the $7$ it exists to explain. The [report](../report/sections/08-fence-posts.tex#L63) avoids this by naming the trace conditions directly. *The honest driver is the $SO(n)$-decomposition of $\Lambda^2\mathbb R^n$, together with $W$ being trace-free on each summand.*

## 4. What is refuted: the inference, and its witness at $n=5$

**[results.md:512](../results.md#L512) concludes: *"So for $n\ge5$ the cubic is a function of the spectrum alone at no critical point."* That is false at $n=5$.**

The witness is on the record twice over. [Fence post 2g](../findings/fence-posts.md#L121), rewritten 2026-08-26, and [bispectral.md:142](../findings/bispectral.md#L142): on $\mathcal W_n$ for $n\le5$ and only there, $\langle W^{\#},W\rangle=2\mathop{\mathrm{tr}}(W^3)$, hence $\theta=3\mathop{\mathrm{tr}}(W^3)$, **for every $W\in\mathcal W_5$, critical or not**. The mechanism is Lovelock's dimensionally-dependent identity: the generalized Kronecker delta on six indices vanishes identically for $n\le5$, and $\beta-\tfrac\alpha2$ is its contraction against three copies of $W$. My own $n=4$ bracket computation in §1 lands on exactly $\theta=3\mathop{\mathrm{tr}}(W^3)$, which is the $n=4$ instance of that statement reached by a route sharing nothing with it, an independent corroboration of the collapse formula at the one dimension I can do by hand.

**The failure is precisely a quantifier inversion, and the record names it as such.** $\mathcal C$ is defined by *"for every $\lambda\in H$"*. Collapse of the cubic at a point $W$ needs $3C_{T(W)}(\lambda(W))=\kappa\,p_3(\lambda(W))$ at the **single** pair $(\lambda(W),T(W))$ that $W$ supplies. $\mathcal C=\mathbb R\mathbf 1$ therefore establishes only that *constant $T$ is the unique $\lambda$-uniform mechanism*, and, in [fence post 2g](../findings/fence-posts.md#L137)'s own words, **"which decides no dimension"**. At $n=5$ the realised eigenframe $T$ is manifestly non-constant and the cubic collapses anyway.

**The clause the block spends its last words on is inert, and it needs a qualifier.** *"Constant $T$ is not realised by any $\mathfrak{so}(n)$"* is vacuous read over **all** triples, since $T$ is hollow ([ELIM-target.md:190](ELIM-target.md#L190) already flagged this); it must read *constant on distinct triples*. Under that reading it is also **not proved anywhere on the record**, [ATTEMPTS.md:2284](../ATTEMPTS.md#L2284) offers only *"$T_{\alpha\beta\gamma}$ vanishes on most triples"*, which is a statement about the **coordinate** frame, whereas $T$ here is built from an **eigenframe** of $W$, and [conventions.md](../findings/conventions.md) warns in terms that a generic spectral eigenbasis is essentially never of coordinate form.

**A partial proof, offered because the clause otherwise has none.** Suppose $\lvert c_{\alpha\beta\gamma}\rvert=s>0$ on all distinct triples. Then $\lVert[v_\alpha,v_\beta]\rVert^2=\sum_\gamma T_{\alpha\beta\gamma}=s^2(N-2)$ for every pair, and the Killing marginal $\sum_\beta\lVert[v_\alpha,v_\beta]\rVert^2=2(n-2)$ forces $s^2(N-2)=\dfrac{2(n-2)}{N-1}=\dfrac4{n+1}$, using $N-1=\tfrac{(n-2)(n+1)}2$. Now pair the Jacobi identity for $v_\alpha,v_\beta,v_\gamma$ with $v_\delta$, for four **distinct** indices:

$$\sum_\varepsilon\big(c_{\alpha\beta\varepsilon}c_{\varepsilon\gamma\delta}+c_{\beta\gamma\varepsilon}c_{\varepsilon\alpha\delta}+c_{\gamma\alpha\varepsilon}c_{\varepsilon\beta\delta}\big)=0 .$$

Every term with $\varepsilon\in\{\alpha,\beta,\gamma,\delta\}$ has a repeated index in one factor and vanishes. Every one of the remaining $3(N-4)$ terms equals $\pm s^2$. A sum of $3(N-4)$ terms $\pm s^2$ vanishes only if $3(N-4)$ is even, i.e. **$N$ even**. So constant $T$ is **impossible whenever $\binom n2$ is odd**, that is at every $n\equiv2,3\pmod 4$, including $n=6$ and $n=7$, the first two dimensions where the collapse actually fails. *It leaves $n\equiv0,1\pmod 4$ open, so the clause is still owed a proof at $n=8,9,12,13,\dots$, reachable, but not by this argument.*

## 5. Provenance, FALSE, on both counts, and the check is in `git`

The note reads: *"the result was numbered in [report/](../report/) and the mathematics has always been in this file, but it carried no block. The statement is below; the argument is in this file under 'The diagonal proof's ENGINE lifts to any critical point, and its corr'."*

| clause | verdict | evidence |
| --- | --- | --- |
| *"numbered in `report/`"* | **TRUE** | [08-fence-posts.tex:35](../report/sections/08-fence-posts.tex#L35) carries `\begin{Lem}{49}`, entered by `d25217b6` on 2026-08-26 09:32 |
| *"the mathematics has always been in this file"* | **FALSE** | `git log -S` on the string `T_{\alpha\beta\gamma}=\langle[v_\alpha,v_\beta],v_\gamma\rangle^2` restricted to [target.md](../findings/target.md) returns exactly **one** commit: `86621751`, 2026-08-31 20:50, the very commit that created the block. The expansion had never appeared in this file before |
| *"the argument is in this file under 'The diagonal proof's ENGINE…'"* | **FALSE** | I read [that section](../findings/target.md#L9) end to end. It is the vertex equation $K_{ab}^2+R_{ab}+(W^{\#})_{abab}=\lambda K_{ab}$, the $v\otimes v$ pairing, the skew-conference-matrix witness and the norm budget closing post F29. **No $T_{\alpha\beta\gamma}$, no eigenframe cubic, no collapse space, no trace conditions.** It shares no object with L49 |

**So this is another instance of the pasted boilerplate the brief warns of, the phrase occurs $4$ times in [target.md](../findings/target.md) alone and in nine other files.** The argument's real homes are [ATTEMPTS.md:2284](../ATTEMPTS.md#L2284), which the record **bars** from carrying a numbered result's proof, and [fence post 2g](../findings/fence-posts.md#L121), whose current text **refutes the use L49 makes of it**. [ELIM-target.md:184](ELIM-target.md#L184) had already reached the same conclusion; this review confirms it from `git` rather than by reading alone.

**The chronology is the sharpest part.** F2g's refuting rewrite landed in `1f82f29f` on **2026-08-26 11:51**, two hours after the report numbered the lemma. The findings block was written on **2026-08-31 20:50**, five days later, from the pre-refutation text, and the correction was available in the repository the whole time.

## 6. The record already settles it, in three places the block does not cite

The brief's *"does the block's own file already settle it"* check pays again, though the answer is one file over:

- **[report/sections/08-fence-posts.tex:63](../report/sections/08-fence-posts.tex#L63)** (the paragraph immediately under the report's own copy of the lemma), states in bold: *"That is a statement about $\lambda$-uniform mechanisms and it decides no dimension"*, cites the $n=5$ collapse, and says *"irreducibility is not the separating fact; the rank of the six-index Kronecker delta is."* **The report is correct. [findings/target.md](../findings/target.md) and [results.md](../results.md) both dropped this paragraph**, and results.md then asserted the opposite.
- **[report/sections/09-status.tex:73](../report/sections/09-status.tex#L73)** carries *"Scope corrected: it counts $\lambda$-uniform mechanisms, so it decides no dimension."* *Note that [09-status.tex:209](../report/sections/09-status.tex#L209) still carries the uncorrected claim in a second table, the report is not internally consistent either, and that row is a separate defect.*
- **[results.md:244](../results.md#L244), Lemma L50**, three hundred lines above L49 in the same file: *"Collapses to one spectrum exactly for $n\le5$."* **Two numbered results of the same canon contradict each other at $n=5$**, and they sit adjacent in [INDEX-results.md](../findings/INDEX-results.md#L64), row 49 and row 50.

## 7. What consumes L49

**Nothing mathematical.** Exhaustive search over [findings/](../findings/), [results.md](../results.md), [report/](../report/) and [scripts/](../scripts/): the only occurrences are the block itself, its two canon copies at [results.md:174](../results.md#L174) and [results.md:510](../results.md#L510), the index row at [INDEX-results.md:64](../findings/INDEX-results.md#L64), the queue entry at [plan-verification.md:75](../plan-verification.md#L75), the two report passages above, and [ELIM-target.md](ELIM-target.md). No lemma, bound or route consumes either the containment or the dimension.

**So the blast radius is the canon's own prose.** The correction costs nothing downstream, which is also why it has survived: no consumer would have tripped over it.

## 8. Hedging clauses, itemised

| clause | what it conceals |
| --- | --- |
| *"its dimension is governed by"* | it **equals**, and I prove so in §3; the hedge disguises a theorem as a heuristic and let the wrong group ($O(n)$) in behind it |
| *"the number of independent trace conditions the spectrum obeys"* | never stated for which $n$ this is $1$ and for which $2$ in the [target.md](../findings/target.md) copy; the reader must supply $n=4$ |
| *"$T$ constant"* | must read **constant on distinct triples**; over all triples it is vacuous, $T$ being hollow |
| *"is not realised by any $\mathfrak{so}(n)$"* | unproved on the record; §4 proves it for $N$ odd only |
| *"at every $N\ge4$"* | true, and true from $N\ge3$; but $N=\binom n2$ is never $4$ or $5$ |
| *"the mathematics has always been in this file"* | false; §5 |

**Pointers.** [target.md](../findings/target.md) carries no empty `(#)` targets, I grepped. The section title the note quotes is truncated mid-word (*"and its corr"*) but does resolve to a real heading at [target.md:9](../findings/target.md#L9); it is the content, not the pointer, that fails.

## 9. What is owed

1. **Restore the scope sentence to both copies.** [results.md:512](../results.md#L512)'s final two sentences, *"So for $n\ge5$ the cubic is a function of the spectrum alone at no critical point… At $n=4$… the cubic is spectral"*, must be **struck** and replaced by the report's paragraph: the lemma counts $\lambda$-uniform mechanisms and decides no dimension; the cubic is spectral for $n\le5$ by [L50](../results.md#L244), and the separating fact is the rank of the six-index Kronecker delta.
2. **Delete "under $O(n)$"** from [results.md:512](../results.md#L512) and name $SO(n)$, or better, name the trace conditions directly as the report does.
3. **Replace the provenance note** with the truth: numbered in [report/](../report/) on 2026-08-26, argument in [fence post 2g](../findings/fence-posts.md#L121), never in [target.md](../findings/target.md). *L49 is fence-post material and is misfiled in the census file, exactly as [L45](../findings/target.md#L694) was found to be by [r601](REVIEW_r601.md)/[r602](REVIEW_r602.md) three blocks above it.*
4. **Add the qualifier** *constant on distinct triples*, and either record §4's parity proof for $N$ odd or mark the clause as owed.
5. **Fold in §3's proof**, which turns the dimension from six measured ranks into a two-paragraph argument valid at every $N$.
6. **Fix [09-status.tex:209](../report/sections/09-status.tex#L209)**, which still states the uncorrected claim inside a report that corrects it twice elsewhere.

## Bottom line

**The arithmetic is right, the theorem is stronger than the record claims, and the sentence built on top of it is false at $n=5$.** The record diagnosed the error on 2026-08-26 and then numbered the pre-diagnosis text as a Lemma on 2026-08-31, with the correction sitting in [report/](../report/) the whole time. Nothing consumes it, so the repair is confined to four paragraphs of prose.
