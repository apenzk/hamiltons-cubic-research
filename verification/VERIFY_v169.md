# Verifier v169, Lemma L32, a bivector's centraliser collapses to a line

I read [BRIEF_L32.md](BRIEF_L32.md), the canonical statement-and-proof block at [isotropy-cap.md](../findings/isotropy-cap.md):74-110, the canon and landscape copies at [results.md](../results.md):467 and :150, the report copy at [report/sections/07-gradedness-split.tex](../report/sections/07-gradedness-split.tex):1022-1024, the index row at [INDEX-results.md](../findings/INDEX-results.md):47, the sole consumer in [stratum-two-negative.md](../findings/stratum-two-negative.md):152-170, and the L32 rows of [LEDGER.md](../findings/LEDGER.md). Everything below is cold from the definitions. **No numerical work of any kind was done, no script, no Sage, no evaluation, no sweep; every bivector below is written in closed form and every centraliser was computed by hand from the block decomposition of $\mathfrak{so}(m)$.** The 29-partition Gate 2 sweep was not re-run and is treated as an open hypothesis throughout. Log: [agent_logs/verify-L32-v169.log](../agent_logs/verify-L32-v169.log).

## The claim table

| # | claim, as the record writes it | verdict |
| --- | --- | --- |
| C1 | canon and report: the hypothesis is $m\ne3$ | **CORRECT AND SHARP** |
| C2 | [isotropy-cap.md](../findings/isotropy-cap.md)'s own **Statement** line: no restriction at all | **REFUTED AS STATED, and still unrepaired in the proof block** |
| C3 | landscape and index: the hypothesis is $\mathfrak c\ne0$ | **TRUE BUT NOT SHARP**, it discards $m=2$, where the conclusion holds |
| C4 | $\mathfrak t\subseteq\mathfrak z(x)$, so $\mathfrak c\supseteq\mathfrak t\cap x^\perp=a^\perp$ | **CONFIRMED** |
| C5 | $\mathfrak z(\mathfrak c)\subseteq\mathfrak z(a^\perp)=\mathfrak t\oplus\bigoplus\{\mathfrak g_\beta:\beta\propto a\}$ | **CONFIRMED**, at even $m$ with $\ker x=0$ |
| C6 | for $p\ge3$ no root is $\propto a$, so the intersection is $\mathbb Rx$ | **CONFIRMED** |
| C7 | the main branch is written for even $m$ and never says so | **CONFIRMED as a defect of exposition, not of mathematics** |
| C8 | the case split is $p\ge3$ and $p=2$; $p=1$ is never treated | **GAP, harmless, the conclusion holds at $m=2$** |
| C9 | at $p=2$, $a\propto(1,1)$ is admissible and is exactly the complex-structure case | **CONFIRMED** |
| C10 | in that case the answer is a $3$-dimensional $\mathfrak{su}(2)$ | **TRUE, ASSERTED AND NOT DERIVED** |
| C11 | degenerate branch, $\dim\ker x\ge2$: "the same argument inside the support, additionally centralising $\mathfrak{so}(\ker x)$" | **CONFIRMED**, the sentence expands to a correct argument |
| C12 | the same sentence at $\dim\ker x=1$ | **GAP, it reaches nothing; the earlier finding is CONFIRMED** |
| C13 | the witness $x=\varphi_{12}\in\mathfrak{so}(5)$, centraliser of dimension $4$ where the containment allows $2$ | **CONFIRMED**, with the caveat that this $x$ has corank $3$, not corank $1$ |
| C14 | the exception clause is exactly "a multiple of a complex structure on a $4$-dimensional subspace" | **CONFIRMED at corank $\ne1$; CONDITIONAL at corank $1$**, on the owed step (†) |
| C15 | scope: the criterion is $a$ proportional to a root of $D_p$, which is rank $4$ with equal singular values | **CORRECT AT EVEN $m$**; at odd $m$ it silently drops the short-root family, which is the $m=3$ failure itself |
| C16 | "nondegeneracy is sufficient and not necessary at $m\ge6$", false at $m=4,5$ | **TRUE ONLY UNDER A SECOND, UNTABLED MEANING OF "nondegenerate"** |
| C17 | a rank-$4$ complex structure padded into $\mathbb R^6,\mathbb R^8,\mathbb R^{10}$ returns $3$ every time | **CONFIRMED** |
| C18 | the one consumer sits at $n\ge12$ where the hypothesis is "expected, and not yet checked there" | **STALE**, it is now checked, twice, and holds at every $m\ge4$ |
| C19 | the consumer's blockquote discharge: $\mathfrak z(x)$ contains the torus of $x$'s own $2$-blocks, so $\dim\mathfrak z(x)\ge\lfloor n/2\rfloor$ | **NON SEQUITUR**, true bound, false reason, already diagnosed eight lines above it and left standing; [LEDGER.md](../findings/LEDGER.md):247 repeats it |
| C20 | the reviewers' disagreement was settled by checking $\mathfrak t\cap x^\perp\subseteq\mathfrak c$ at every pattern | **VACUOUS AS A SWEEP**, that containment is one line and is independent of the pattern |
| C21 | "the one use on the record" | **CONFIRMED** |

## The one-line summary

**The surviving statement is true exactly as the canon and the report write it (for every $m\ne3$, every nonzero $x$, with the exception clause neither too wide nor too narrow) but the proof on file establishes it only at even $m$ with $\ker x=0$ and $p\ge2$, and at $\dim\ker x\ge2$; corank $1$ is unreached, $p=1$ is untreated, and the block's own Statement line still carries the form two reviewers refuted.**

## 0. Conventions, fixed once

[conventions.md](../findings/conventions.md) tables neither $x$ nor $\mathfrak c$ nor $\mathfrak t$ nor $a$ nor $p$ for this lemma; all five are defined inline in the block, and the same observation was made by [v166](VERIFY_v166.md) for L33. The one convention this lemma does draw is the norm, quoted from [conventions.md](../findings/conventions.md):70:

> **A skew matrix's norm**, in the form the stratum arguments use: $\langle X,X\rangle=\tfrac12\operatorname{tr}(X^{\mathsf T}X)$, singular values in pairs $s_1,s_1,s_2,s_2,\dots$ with $\sum_i s_i^2=1$.

It is load-bearing in exactly one place, C4: under it $\lVert\varphi_{ij}\rVert^2=1$ and distinct $\varphi_{2i-1,2i}$ are orthogonal, so the identification $\mathfrak t\cong\mathbb R^p$ is an isometry and "$\mathfrak t\cap x^\perp=a^\perp$" is a statement about the ordinary Euclidean orthogonal complement of the singular-value vector. Under plain Frobenius every norm doubles and the identification is still an isometry up to scale, so the step is robust to that normalisation; I record it because [conventions.md](../findings/conventions.md) carries two normalisations elsewhere on the record.

The objects, as the block defines them: $x\in\mathfrak{so}(m)$ nonzero, $\mathfrak z(x)=\{u:[x,u]=0\}$, $\mathfrak c=\mathfrak z(x)\cap x^\perp$, $\mathfrak t$ the span of $x$'s own coordinate $2$-planes, $a=(a_1,\dots,a_p)$ the positive singular values, $p$ the number of $2$-blocks.

### Symbol collisions

Three, all live, none tabled.

- **$p$.** In L32 it is the number of $2$-blocks of $x$. In the sphere-product analysis one screen away in the same report section, [07-gradedness-split.tex](../report/sections/07-gradedness-split.tex):1229, $p$ is a factor dimension, "$\dim(\mathfrak{so}(p)\oplus\mathfrak{so}(q))$". The two live in the same LaTeX file within two hundred lines.
- **$a$.** In L32 it is a vector in $\mathbb R^p$. In [conventions.md](../findings/conventions.md):106 it is the scalar $a=\tfrac1{3\sqrt6}$ fixing the sign of $W_-$.
- **"nondegenerate".** The proof uses it for $\ker x=0$; the scope paragraph, as §7 below shows, needs it to mean maximal rank. [conventions.md](../findings/conventions.md) defines neither, and [nondegeneracy.md](../findings/nondegeneracy.md) is about a third thing, a Weyl tensor's nondegeneracy.

$x$ and $\mathfrak c$ and $\mathfrak t$ are used consistently between L32 and its consumer L33, which I checked line by line against [stratum-two-negative.md](../findings/stratum-two-negative.md):152-158; the identification there is exact, $\mathfrak c$ being both L32's object and $\ker N_x$.

## 1. The hypothesis inventory

**The statement's hypotheses, in each of the four forms the record carries.**

| where | hypotheses carried |
| --- | --- |
| [results.md](../results.md):467, canon | $m\ne3$; $x\in\mathfrak{so}(m)$ nonzero |
| [report/sections/07-gradedness-split.tex](../report/sections/07-gradedness-split.tex):1022, report | $m\ne3$; $x$ skew |
| [results.md](../results.md):150, landscape | $x$ skew nonzero; $\mathfrak c\ne0$ |
| [INDEX-results.md](../findings/INDEX-results.md):47, index | $\mathfrak c\ne0$ |
| [isotropy-cap.md](../findings/isotropy-cap.md):36, the canonical **Statement** line | **$x$ nonzero, and nothing else** |

**The hypotheses the proof actually uses, branch by branch.**

| branch | used | stated in the statement |
| --- | --- | --- |
| main | $\ker x=0$, hence $m=2p$ even | **no**, carried only by the word "nondegenerate" in the proof heading |
| main | $p\ge3$, i.e. $m\ge6$ | **no** |
| main | $a_i\ne0$ for every $i$ (this is $\ker x=0$ again, used a second time, to exclude roots) | **no** |
| main | $\mathfrak t$ is a Cartan subalgebra of $\mathfrak{so}(m)$ and the root system is $D_p$ | **no**, and true only at even $m$ |
| exception | $p=2$ and $a_1=a_2$ | yes, as "a multiple of a complex structure on a $4$-dimensional subspace" |
| degenerate | $\mathfrak{so}(\ker x)\ne0$, i.e. $\dim\ker x\ge2$ | **no** |

**A hypothesis stated and never used**: none. $m\ne3$ appears in the canon and does no work in the proof text, because the proof text does not carry it, the two live in different files. That is itself the defect at C2.

**A step using a hypothesis never stated**: four, tabled above. The load-bearing ones are $\ker x=0$ in the main branch and $\dim\ker x\ge2$ in the degenerate branch; between them they leave $\dim\ker x=1$ with no branch, which is §6.

**Which hypothesis is right, and which the consumers need.** For nonzero $x$, $\dim\mathfrak z(x)\ge\lfloor m/2\rfloor$ (proved in §8) so $\mathfrak c=0$ happens exactly at $m\in\{2,3\}$, and $m\le1$ carries no nonzero $x$ at all. The conclusion holds at $m=2$ (§4) and fails at $m=3$ (the record's witness). So:

- $m\ne3$ is **correct and sharp**; it is the canon's and the report's form.
- $\mathfrak c\ne0$ is **correct and strictly stronger**, differing from $m\ne3$ at exactly one value, $m=2$, where it needlessly withholds a true conclusion.
- the unrestricted form is **false**.

The one consumer, L33, works in $\mathrm{Weyl}_m$, which is zero for $m\le3$, so either surviving form serves it. **The fix owed is to the proof block's own Statement line and to the index row, both of which should read $m\ne3$ to match the canon and the report.**

## 2. The centraliser chain, both inclusions derived

**First, the containment the conclusion needs in the easy direction, which the block never states.** $\mathfrak c\subseteq\mathfrak z(x)$ by definition, so $x$ centralises $\mathfrak c$ and $x\in\mathfrak z(\mathfrak c)$; and $\mathfrak c\subseteq x^\perp$ gives $x\in\mathfrak c^\perp$. Hence $\mathbb Rx\subseteq\mathfrak z(\mathfrak c)\cap\mathfrak c^\perp$ **always**, at every $m$ and every $x$. The whole content of the lemma is the reverse inclusion, and the block's "$\subseteq$" chain delivers only that. This is an omission of one line, not an error.

**$\mathfrak c\supseteq\mathfrak t\cap x^\perp=a^\perp$ (C4).** $\mathfrak t$ is abelian and $x\in\mathfrak t$, so $\mathfrak t\subseteq\mathfrak z(x)$; intersecting with $x^\perp$ gives $\mathfrak t\cap x^\perp\subseteq\mathfrak z(x)\cap x^\perp=\mathfrak c$. Under the norm quoted in §0 the map $\mathfrak t\to\mathbb R^p$ sending $\sum_it_i\varphi_{2i-1,2i}\mapsto(t_1,\dots,t_p)$ is an isometry, and $x\mapsto a$, so $\mathfrak t\cap x^\perp$ is the Euclidean $a^\perp$ inside $\mathbb R^p$. **Confirmed.** Note it uses nothing about $\ker x$ and holds verbatim in the degenerate case with $\mathfrak t$ the torus of the nonzero blocks, which is why the Gate 2 sweep that "settled" the reviewers' disagreement by checking it at every pattern (C20) was checking a pattern-independent one-liner.

**$\mathfrak z(\mathfrak c)\subseteq\mathfrak z(a^\perp)$.** Centralisers reverse inclusions: $a^\perp\subseteq\mathfrak c$ gives $\mathfrak z(\mathfrak c)\subseteq\mathfrak z(a^\perp)$. **Confirmed.**

**$\mathfrak z(a^\perp)=\mathfrak t\oplus\bigoplus\{\mathfrak g_\beta:\beta\propto a\}$ (C5).** Take $m=2p$ even and $\ker x=0$, so $\mathfrak t$ is a Cartan subalgebra of $\mathfrak{so}(2p)=D_p$ and $\mathfrak{so}(2p)=\mathfrak t\oplus\bigoplus_{\beta>0}\mathfrak m_\beta$ with each real root space $\mathfrak m_\beta$ two-dimensional and $\operatorname{ad}(t)$ acting on it, for $t\in\mathfrak t$, with eigenvalues $\pm i\beta(t)$. Write $u=h+\sum_\beta u_\beta$. Then $[t,u]=\sum_\beta[t,u_\beta]$ with $[t,u_\beta]\in\mathfrak m_\beta$, and the summands are independent, so $[t,u]=0$ for every $t\in a^\perp$ forces, for each $\beta$, either $u_\beta=0$ or $\beta$ vanishing identically on $a^\perp$. Since $a\ne0$, $a^\perp$ is a hyperplane, and a functional vanishing on it is a multiple of $\langle a,\cdot\rangle$; so the surviving root spaces are exactly those with $\beta\propto a$. **Confirmed.** The identity is an equality, not merely a containment, because every such $\mathfrak m_\beta$ does centralise $a^\perp$ by the same eigenvalue computation.

**$p\ge3$ (C6).** A root $\pm e_i\pm e_j$ of $D_p$ has exactly $p-2\ge1$ zero coordinates while $a$, under $\ker x=0$, has none; so no root is proportional to $a$ and $\mathfrak z(a^\perp)=\mathfrak t$. Then $\mathfrak c\supseteq a^\perp$ gives $\mathfrak c^\perp\subseteq(a^\perp)^\perp$, and $\mathfrak t\cap(a^\perp)^\perp=\mathbb Rx$, the block's notation is loose here, $(a^\perp)^\perp$ being read once inside $\mathbb R^p$ and once inside $\mathfrak{so}(m)$, but both readings give $\mathbb Rx$ after intersecting with $\mathfrak t$, so nothing turns on it. With the easy inclusion above, $\mathfrak z(\mathfrak c)\cap\mathfrak c^\perp=\mathbb Rx$. **Confirmed at every even $m\ge6$ with $\ker x=0$, uniformly in the singular values, with no case split on the multiplicity pattern.** That last point is the landscape entry's "uniform in the singular values", and it is earned: nothing in the count depends on which $a_i$ coincide, only on all of them being nonzero.

## 3. The main branch is written for even $m$, C7

The branch sets $p=m/2$, which is an integer only at even $m$. **It is a defect of exposition and not of mathematics**, and the reason is worth stating positively: a skew matrix on an odd-dimensional space has odd-dimensional kernel, so $\ker x=0$ already forces $m$ even. The branch is therefore correctly delimited by the word "nondegenerate"; what the reader is never told is that "nondegenerate" and "even $m$ at full rank" are the same condition, and that consequently **every odd $m$, without exception, is handed to the one sentence of the degenerate branch.** A reader who takes "nondegenerate" as a genericity condition will believe the main branch covers the generic case at every $m$; it covers the generic case at no odd $m$ at all.

The imported-theorem trap fires here in its exact form. The block imports the root system of $D_p$ and never checks the hypothesis that makes $\mathfrak{so}(m)$ a $D_p$: $m$ even. At odd $m=2q+1$ the algebra is $B_q$ and its root set contains the short roots $\pm e_i$, which the $D_p$ sentence does not mention. §6 is where that bites.

## 4. $p=1$ is never treated, C8

The case split in the block is "$p\ge3$" and "$p=2$". At $p=1$ with $\ker x=0$ we are at $m=2$, and neither sub-case applies. This is the same defect [LEDGER.md](../findings/LEDGER.md):253 records against [L81](../findings/isotropy-cap.md), whose proof "splits on $p\ge3$ and $p=2$ and never treats $p=1$".

**What is true there.** $m=2$: $\mathfrak{so}(2)=\mathbb Rx$ is one-dimensional, so $\mathfrak c=\mathfrak z(x)\cap x^\perp=\mathfrak{so}(2)\cap x^\perp=0$, $\mathfrak z(0)=\mathfrak{so}(2)$, $\mathfrak c^\perp=\mathfrak{so}(2)$, and $\mathfrak z(\mathfrak c)\cap\mathfrak c^\perp=\mathfrak{so}(2)=\mathbb Rx$. **The conclusion holds**, the exception does not fire (a $2$-plane is not a $4$-plane), and the hole is in the exposition only. It is also the single value at which the two surviving hypotheses differ: $\mathfrak c=0$ here, so the landscape form withholds a true statement.

**$m=3$, for contrast.** $x=\varphi_{12}$, $\mathfrak z(x)=\mathbb R\varphi_{12}$ (dimension $1$, since $\mathfrak{so}(\ker x)=\mathfrak{so}(1)=0$), $\mathfrak c=0$, $\mathfrak z(0)=\mathfrak{so}(3)$, and $\mathfrak z(\mathfrak c)\cap\mathfrak c^\perp=\mathfrak{so}(3)$, dimension $3$. The record's witness, re-derived. **In $B_1$ language this is a short root proportional to $a$**: $\mathfrak t=\mathbb R\varphi_{12}$, $a=(a_1)$, $a^\perp=0$, and $\mathfrak z(a^\perp)=\mathfrak t\oplus\mathfrak g_{\pm e_1}=\mathfrak{so}(3)$. So the failure at $m=3$ and the short roots the block never mentions are one phenomenon, which §7 returns to.

## 5. $p=2$, C9 and C10

**The exception is exactly the complex structures.** At $p=2$ the roots of $D_2$ are $\pm e_1\pm e_2$, with $p-2=0$ zero coordinates as the block says. With $a_1,a_2>0$, a root is proportional to $a$ exactly when $a_1=a_2$, i.e. $x=a_1(\varphi_{12}+\varphi_{34})$, a positive multiple of a complex structure on $\mathbb R^4$. The root $e_1-e_2$ gives the same family read in the other orientation, $a_1(\varphi_{12}-\varphi_{34})$, which is also a complex structure. **Confirmed, and confirmed in both directions**: when $a_1\ne a_2$ no root is proportional to $a$, $\mathfrak z(a^\perp)=\mathfrak t$, and the answer is $\mathbb Rx$. The block states only the admissibility and never states this converse half, so the reader is not told that $m=4$ with distinct singular values behaves like the generic case.

**The value $\mathfrak{su}(2)$ is asserted and not derived (C10).** The chain the block runs gives $\mathfrak z(\mathfrak c)\subseteq\mathfrak z(a^\perp)=\mathfrak t\oplus\mathfrak m_{e_1+e_2}$, of dimension $4$, and stops. Dimension $4$ is not dimension $3$, and no line of the block closes the gap. It is true, by a computation the block does not contain: with $x=a_1(\varphi_{12}+\varphi_{34})\in\Lambda^2_+$, $\mathfrak z(x)=\mathbb Rx\oplus\Lambda^2_-$ of dimension $4$, so $\mathfrak c=\Lambda^2_-\cong\mathfrak{su}(2)$; since $[\Lambda^2_+,\Lambda^2_-]=0$ and $\Lambda^2_-$ has trivial centre, $\mathfrak z(\mathfrak c)=\Lambda^2_+$; and $\mathfrak c^\perp=\Lambda^2_+$, so the intersection is $\Lambda^2_+\cong\mathfrak{su}(2)$, of dimension $3$. **The value is right and the block owes its derivation.**

## 6. The degenerate branch, C11, C12, C13

Fix $V=\operatorname{im}x$ of dimension $2p$, $K=\ker x$ of dimension $k=m-2p$, orthogonal. Then $\mathfrak{so}(m)=\mathfrak{so}(V)\oplus(V\otimes K)\oplus\mathfrak{so}(K)$ with $V\otimes K$ the off-diagonal block $\operatorname{Hom}(K,V)$.

**The centraliser splits.** Writing $x=\begin{pmatrix}X&0\\0&0\end{pmatrix}$ and an off-diagonal $u=\begin{pmatrix}0&B\\-B^{\mathsf T}&0\end{pmatrix}$, one has $[x,u]=\begin{pmatrix}0&XB\\B^{\mathsf T}X&0\end{pmatrix}$, zero iff $XB=0$ iff $B=0$ since $X$ is invertible on $V$. And $\mathfrak{so}(K)$ commutes with $x$ entirely. So $\mathfrak z(x)=\mathfrak z_{\mathfrak{so}(V)}(x)\oplus\mathfrak{so}(K)$ and, since $x\perp\mathfrak{so}(K)$,
$$\mathfrak c=\mathfrak c_V\oplus\mathfrak{so}(K),\qquad \mathfrak c_V:=\mathfrak z_{\mathfrak{so}(V)}(x)\cap x^{\perp_V}.$$

### 6.1 $\dim\ker x\ge3$, C11, confirmed

$\mathfrak{so}(K)$ acts on $\mathfrak{so}(m)=\Lambda^2V\oplus(V\otimes K)\oplus\Lambda^2K$ trivially on $\Lambda^2V$, as $\dim V$ copies of the standard representation on $V\otimes K$, and adjointly on $\Lambda^2K$. For $k\ge3$ the standard representation of $\mathfrak{so}(k)$ has no invariant vector and $\mathfrak{so}(k)$ has trivial centre, so $\mathfrak z(\mathfrak{so}(K))=\mathfrak{so}(V)$. Hence $\mathfrak z(\mathfrak c)\subseteq\mathfrak{so}(V)\cap\mathfrak z(\mathfrak c_V)=\mathfrak z_{\mathfrak{so}(V)}(\mathfrak c_V)$, and $\mathfrak c^\perp\cap\mathfrak{so}(V)=\mathfrak c_V^{\perp_V}$ because the sum above is orthogonal. So $\mathfrak z(\mathfrak c)\cap\mathfrak c^\perp\subseteq\mathfrak z_{\mathfrak{so}(V)}(\mathfrak c_V)\cap\mathfrak c_V^{\perp_V}$, which is §2's conclusion inside $\mathfrak{so}(V)$, even-dimensional with $x$ of full rank there, exactly the main branch's setting. **The one sentence expands to a correct argument.** At $p\ge3$ it returns $\mathbb Rx$; at $p=2$ with equal singular values it returns the $\mathfrak{su}(2)$; at $p=1$ it returns $\mathfrak{so}(V)=\mathfrak{so}(2)=\mathbb Rx$ by §4.

### 6.2 $\dim\ker x=2$, C11, confirmed

$\mathfrak{so}(K)=\mathfrak{so}(2)$ is one-dimensional, so the branch's ingredient is present. Its standard representation on $K$ has no invariant vector, so $V\otimes K$ is still killed, and $\mathfrak z(\mathfrak{so}(K))=\mathfrak{so}(V)\oplus\mathfrak{so}(K)$. The extra summand is removed by orthogonality rather than by centralising: $\mathfrak{so}(K)\subseteq\mathfrak c$, so $\mathfrak c^\perp\cap\mathfrak{so}(K)=0$. The argument then runs as in §6.1. **Confirmed.**

### 6.3 $\dim\ker x=1$, C12, the gap, confirmed

$\mathfrak{so}(K)=\mathfrak{so}(1)=0$. The branch's entire stated content beyond "run it inside the support" is "$\mathfrak z(\mathfrak c)$ additionally centralising $\mathfrak{so}(\ker x)$", and centralising the zero algebra is no condition at all. Concretely: $\mathfrak c=\mathfrak c_V$ lies inside $\mathfrak{so}(V)$, while $\mathfrak z(\mathfrak c)$ is taken in $\mathfrak{so}(m)=\mathfrak{so}(V)\oplus(V\otimes K)$ with $V\otimes K\cong V$ of dimension $2p$. **Nothing written in the block excludes the off-diagonal summand**, and the block's own containment therefore permits $\mathfrak z(\mathfrak c)\cap\mathfrak c^\perp$ to have dimension up to $1+2p$ rather than $1$.

**This is the whole of odd $m$ at generic rank**, since odd $m$ forces odd $k\ge1$ and corank $1$ is the maximal-rank case there. The concrete instance the record names, $x=\varphi_{12}+2\varphi_{34}+3\varphi_{56}$ at $m=7$, sits exactly here.

**The charitable reading, and why it also fails as written (step 3 of the protocol).** The most charitable reading the words support is: pad $a$ with zeros to a full Cartan of $\mathfrak{so}(m)$ and re-run the root count. At $m=2q+1$ that Cartan has rank $q$ and the algebra is $B_q$, whose root set is $\{\pm e_i\pm e_j\}\cup\{\pm e_i\}$; the block's sentence "every root of $D_p$ is $\pm e_i\pm e_j$ and so has $p-2$ zero coordinates" is then false of the ambient algebra, because the short roots are not of that form. So the charitable reading rests on a false premise and does not rescue the branch. **The earlier finding, that the proof reaches neither branch at corank $1$, the degenerate clause being empty and the charitable reading failing for the $B_p$ reason, is CONFIRMED, independently, by the derivation above.**

**Two refinements the record's phrasing does not make, and they matter.**

1. **The $B_p$ problem is confined to corank $1$ and to the padded reading.** At $\dim\ker x\ge2$ the honest branch never touches a Cartan of the big algebra: it reduces to $\mathfrak{so}(V)$, which is a $D$ algebra whatever the parity of $m$. So "the root argument fails at odd $m$" is true of the padded reading and of corank $1$, and is not a statement about odd $m$ in general, every odd $m$ with $\dim\ker x\ge3$ is covered by §6.1.
2. **The record's witness for the $B_p$ failure, $x=\varphi_{12}\in\mathfrak{so}(5)$, has corank $3$, not corank $1$ (C13).** Its arithmetic is right and I re-derived it: padding gives $a=(1,0)$, $a^\perp=\mathbb R\varphi_{34}$, and $\mathfrak z(\varphi_{34})=\mathfrak{so}(2)_{34}\oplus\mathfrak{so}(3)_{125}$ of dimension $4$, whereas the $D_2$ reading admits no root proportional to $(1,0)$ and would give $\mathfrak t$, of dimension $2$. In $B_2$ the short roots $\pm e_1$ are proportional to $a$ and restore the missing $2$. **So the witness correctly refutes the sentence under the padded reading**, and it is not a witness that the lemma's conclusion fails, at corank $3$ the honest branch handles that $x$ and returns $\mathbb Rx$.

**What is owed (†).** *Stated, not proved here; filling it is not this verifier's job.*

> **(†)** For $x\in\mathfrak{so}(2p+1)$ of rank $2p$ with singular values $a$ all nonzero and $p\ge2$: $\mathfrak z(a^\perp)=\mathfrak t$, equivalently, no root of $B_p$, long or short, is proportional to $a$; equivalently, the off-diagonal summand $V\otimes K$ contains no vector annihilated by $\mathfrak c$.

That is one statement, and until it is written and audited the corank-$1$ coverage stands as `HYPOTHESIS-DEBT`. I record that (†) is what the branch needs and that I did not supply it; §7's verdict on the exception clause at corank $1$ is marked conditional on it for the same reason.

## 7. The exception clause and the scope paragraph, C14, C15, C16, C17

**Is the exception clause exactly right?** The clause is "unless $x$ is a multiple of a complex structure on a $4$-dimensional subspace". Reading off the criterion corank by corank:

| corank $k$ | reduction | when the answer exceeds $\mathbb Rx$ | matches the clause? |
| --- | --- | --- | --- |
| $0$ | $D_p$ in $\mathfrak{so}(m)$ | $p=2$, $a_1=a_2$ | **yes**, rank-$4$ complex structure |
| $1$, $p\ge2$ | $B_p$ in $\mathfrak{so}(m)$ | long root $\propto a$: $p=2$, $a_1=a_2$. Short root $\propto a$: impossible for $p\ge2$ | **yes**, conditional on (†) |
| $1$, $p=1$ | $B_1=\mathfrak{so}(3)$ | short root $e_1\propto a$, always | **no**, this is $m=3$, excluded by hypothesis rather than by the clause |
| $2$ | $D_{p}$ inside $\mathfrak{so}(V)$ | $p=2$, $a_1=a_2$ | **yes** |
| $\ge3$ | $D_{p}$ inside $\mathfrak{so}(V)$ | $p=2$, $a_1=a_2$ | **yes** |

**So the clause is neither too wide nor too narrow at any $m\ne3$**, and the single case it fails to name is the single case the hypothesis removes. Two checks in closed form, at the two coranks where the exception fires away from $m=4$:

- $m=5$, $x=\varphi_{12}+\varphi_{34}$, corank $1$: $\mathfrak c=\mathfrak c_V=\Lambda^2_-(V)\cong\mathfrak{su}(2)$; $V\otimes K\cong V\cong\mathbb C^2$ carries the standard $\mathfrak{su}(2)$ representation and has no invariant vector, so $\mathfrak z(\mathfrak c)=\Lambda^2_+(V)$, and the answer is $\Lambda^2_+\cong\mathfrak{su}(2)$, dimension $3$. **The exception fires at odd $m$ too**, and this instance sits inside §6.3's gap, so the record proves it nowhere.
- $m=6$, $x=\varphi_{12}+\varphi_{34}$, corank $2$: $\mathfrak c=\Lambda^2_-(V)\oplus\mathfrak{so}(K)$ of dimension $4$; $\mathfrak z(\mathfrak c)=\Lambda^2_+(V)\oplus\mathfrak{so}(K)$; intersecting with $\mathfrak c^\perp$ deletes $\mathfrak{so}(K)$ and returns $\Lambda^2_+$, dimension $3$. **C17 confirmed**, and the same computation runs verbatim at $m=8,10$ with $\dim K=4,6$, since all that is used of $K$ is $k\ge2$.

**The scope paragraph's criterion (C15).** "The criterion is the singular-value vector being proportional to a root of $D_p$, which is rank $4$ with equal singular values." For a singular-value vector padded with zeros to length $\lfloor m/2\rfloor$, proportionality to $\pm e_i\pm e_j$ says exactly that two singular values are nonzero and equal and the rest vanish, i.e. rank $4$ with equal singular values. **Correct, and correct at even $m$ without qualification.** At odd $m$ the ambient root system is $B$, and proportionality to a short root $\pm e_i$ (rank $2$), is a second family the sentence does not name. That family is nonempty at exactly one value, $m=3$, by the table above. **So the scope paragraph's criterion and the refutation that heads the block are the same fact stated twice, and the paragraph does not know it**: the sentence "$D_p$" is what silently deletes the $m=3$ case from the criterion.

**"Nondegeneracy is sufficient and not necessary at $m\ge6$", false at $m=4,5$ (C16).**

- *Not necessary at $m\ge6$*: **true**. At $m=6$, $x=\varphi_{12}$ is degenerate and $\mathfrak c=\mathfrak{so}(4)_{3456}$, whose centraliser in $\mathfrak{so}(6)$ is $\mathfrak{so}(2)_{12}=\mathbb Rx$; the conclusion holds off the nondegenerate locus.
- *Sufficient, false at $m=4$*: **true**. Nondegenerate $x$ with $a_1=a_2$ is the exception, so nondegeneracy does not deliver $\mathbb Rx$ there.
- *Sufficient, false at $m=5$*: **true only under a second meaning of "nondegenerate"**. Under the proof's meaning, $\ker x=0$, there is no nondegenerate $x$ in $\mathfrak{so}(5)$ at all and the claim is vacuously true rather than false. Under "maximal rank", corank $1$, the maximal-rank $x=\varphi_{12}+\varphi_{34}$ is the exception and the claim is false as the paragraph says. **The paragraph is right under the reading the proof does not use, and the two readings are nowhere distinguished.** This is the third symbol collision of §0, and it is the one that changes a truth value.

## 8. The consumer, and the hypothesis discharge, C18, C19, C21

**C18, "expected, and not yet checked there".** The banner is stale. [stratum-two-negative.md](../findings/stratum-two-negative.md) now carries the check in its body, "$\dim\mathfrak c\ge\lfloor m/2\rfloor-1$, so $\mathfrak c=0$ forces $m\le3$, where $\mathcal W_m=0$", and [LEDGER.md](../findings/LEDGER.md):247 records it as discharged. **I re-derived the bound and it is right, and it is stronger than the consumer needs.** With $x$ of rank $2r$ and $k=m-2r$, $\mathfrak z(x)\supseteq\mathfrak t_r\oplus\mathfrak{so}(k)$, so $\dim\mathfrak z(x)\ge r+\binom k2$; and $r+\binom k2\ge r+\lfloor k/2\rfloor=\lfloor m/2\rfloor$ because $\binom k2\ge\lfloor k/2\rfloor$ at every $k\ge0$ (equality at $k=0,1,2$). Hence $\dim\mathfrak c=\dim\mathfrak z(x)-1\ge\lfloor m/2\rfloor-1$, which vanishes only at $m\le3$. **So the hypothesis holds at every $m\ge4$, not merely at $n\ge12$, and the banner's "expected, and not yet checked there" should be replaced by the count.**

**C19, the discharge that is still wrong where it stands.** The blockquote at [stratum-two-negative.md](../findings/stratum-two-negative.md):167-169 derives the same bound from "$\mathfrak z(x)$ contains the torus spanned by $x$'s own $2$-blocks, so $\dim\mathfrak z(x)\ge\lfloor n/2\rfloor$". **The premise gives only $\dim\mathfrak z(x)\ge r$, the number of blocks, which is $1$ at $x=\varphi_{12}\in\mathfrak{so}(6)$ where the claim asserts $3$.** The kernel summand $\mathfrak{so}(k)$ is what supplies the rest, and the blockquote does not mention it. The same file diagnoses this eight lines above ("The discharge offered before … gives only $\dim\mathfrak z(x)\ge1$") and then leaves the refuted blockquote standing below it, so the file contradicts itself in two directions within twelve lines. [LEDGER.md](../findings/LEDGER.md):247 carries the same false reason. **The conclusion is true; the reason is a non sequitur; two places repeat it.**

**C21, "the one use on the record".** Confirmed. The second citation, at [second-order.md](../findings/second-order.md):64, was deleted at [ROUND_L24](ROUND_L24.md) as decorative, and the line there now runs on the equivariance identity alone. What remains is [stratum-two-negative.md](../findings/stratum-two-negative.md):156, inside L33's proof. The [lean/INDEX.md](../lean/INDEX.md) mentions of L32 under L80 and L81 are comparisons, not uses.

## 9. Withdrawn candidates

Three candidates failed the protocol and are recorded rather than reported.

**9.1 "The main branch is false at odd $m$."** *Withdrawn at step 2.* I could exhibit no odd $m$ at which the main branch asserts something false, because the branch's own hypothesis $\ker x=0$ is unsatisfiable at odd $m$. The branch is silent at odd $m$, not wrong there. What survives, and is reported at C7, is that the silence is unannounced.

**9.2 "The chain $\mathfrak z(\mathfrak c)\subseteq\mathfrak z(a^\perp)$ is too lossy to give equality in the exception case."** *Withdrawn at step 3.* The charitable reading is right: intersecting the four-dimensional $\mathfrak z(a^\perp)=\mathfrak t\oplus\mathfrak m_{e_1+e_2}$ with $\mathfrak c^\perp=\Lambda^2_+$ does return the three-dimensional answer, so the chain is not lossy. The surviving complaint, C10, is only that the block performs neither that intersection nor the reverse inclusion.

**9.3 "The $\mathfrak c\ne0$ form is false."** *Withdrawn at step 2.* It is true; it is merely not sharp, discarding $m=2$. Reported as C3 rather than as a break.

## 10. What would falsify the surviving statement, and what I did to look for it

**The object.** A nonzero $x\in\mathfrak{so}(m)$ with $m\ne3$ that is not a multiple of a complex structure on a $4$-dimensional subspace, and for which $\mathfrak z(\mathfrak c)\cap\mathfrak c^\perp$ is strictly larger than $\mathbb Rx$. By §2's easy inclusion it can only be larger, never smaller, so a falsifier is an element $y\in\mathfrak z(\mathfrak c)\cap\mathfrak c^\perp$ independent of $x$.

**Where such a $y$ could live, and what I did.** By the splitting of §6, $y$ decomposes into a $\mathfrak{so}(V)$ part, an off-diagonal $V\otimes K$ part and a $\mathfrak{so}(K)$ part, and each is a separate opportunity:

- the $\mathfrak{so}(V)$ part requires a root of the $D$ system on $V$ proportional to $a$, which I checked by coordinate count at every $p$: it forces $p=2$ with equal singular values, the stated exception, at every corank;
- the $\mathfrak{so}(K)$ part requires a nonzero centre in $\mathfrak{so}(k)$ surviving the intersection with $\mathfrak c^\perp$, which I checked at $k=0,1,2,\ge3$: at $k=2$ the centre is the whole of $\mathfrak{so}(2)$ but it lies inside $\mathfrak c$ and is deleted by $\mathfrak c^\perp$; at $k\ge3$ the centre is zero;
- the off-diagonal part requires a $\mathfrak c$-invariant vector in $V\otimes K$, which is killed for $k\ge2$ by the standard representation of $\mathfrak{so}(k)$ having no invariant vector, and at $k=1$ becomes exactly the short-root question (†) that the record leaves open. **This is the only compartment where a falsifier is not excluded by an argument on file**, and it is why §6.3's verdict is `GAP` rather than `BROKEN`: at $k=1$ and $p=1$ the compartment is genuinely nonempty and produces the $\mathfrak{so}(3)$ witness, which is precisely why $m\ne3$ is needed; at $k=1$ and $p\ge2$ I found no falsifier and the record reports none.

**No search of any kind was run**, no sweep of multiplicity patterns, no evaluation, no script. Every object above is written in closed form and every centraliser was obtained from the three-summand decomposition by hand.

## Verdict

**`GAP`.**

- **The statement is correct and sharp in the canon's and the report's form, $m\ne3$**, including the exception clause, which I checked at corank $0,1,2,\ge3$ and found neither too wide nor too narrow, conditional at corank $1$ on the owed step (†).
- **The proof on file establishes it at even $m$ with $\ker x=0$ and $p\ge2$, and at $\dim\ker x\ge2$.** Corank $1$ is unreached (the earlier finding is confirmed independently) and $p=1$ is untreated in both branches.
- **Three repairs are owed and none is mathematical**: [isotropy-cap.md](../findings/isotropy-cap.md)'s own **Statement** line still carries the unrestricted form two reviewers refuted, and [INDEX-results.md](../findings/INDEX-results.md):47 carries the non-sharp $\mathfrak c\ne0$; the block's stale banner should carry the count that discharges the hypothesis at every $m\ge4$; and the non-sequitur discharge at [stratum-two-negative.md](../findings/stratum-two-negative.md):167-169 and [LEDGER.md](../findings/LEDGER.md):247 should name the $\mathfrak{so}(\ker x)$ summand that actually supplies the bound.
- **The debt is (†)**, one statement, booked against corank $1$.
