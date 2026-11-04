# Verifier v166, Lemma L33, one eigenvalue of one sign forces the tensor to vanish

I read [BRIEF_L33.md](BRIEF_L33.md), the canonical block at [stratum-two-negative.md](../findings/stratum-two-negative.md):119-160, both quoted copies in [results.md](../results.md):152 and :471-481, the report copy at [report/sections/07-gradedness-split.tex](../report/sections/07-gradedness-split.tex):1026-1034, [Lemma L32](../findings/isotropy-cap.md) at source, the [Petersen–Wink notes](../references/petersen-wink-2019-bochner-technique/notes.md), and the L32/L33/L81 entries in [LEDGER.md](../findings/LEDGER.md). Everything below is cold from the definitions. **No numerical work of any kind was done, no script, no Sage, no evaluation; every value here is exact and every bracket was computed by hand from $[E_{ij},E_{jk}]=E_{ik}$.** Log: [agent_logs/verify-L33-v166.log](../agent_logs/verify-L33-v166.log).

## Claim table

| # | claim | verdict |
| --- | --- | --- |
| C1 | $\sum_\alpha\lambda_\alpha\,\mathrm{ad}(v_\alpha)^2=2W$ on $\mathrm{Weyl}_m$, equivalently $\sum_\alpha\lambda_\alpha N_{v_\alpha}=0$ | **CONFIRMED, and re-derived here without the uncited source** |
| C2 | $\Lambda^4$ is Ricci-flat and carries eigenvalue $-4$, so Ricci-flatness alone fails | **CONFIRMED, witness rebuilt, the eigenvalue is exactly $-4$** |
| C3 | $\langle u,N_vu\rangle=2\langle v,u\rangle^2+\lVert[v,u]\rVert^2$ and $\ker N_v=v^\perp\cap\mathfrak z(v)$ | **CONFIRMED, both inclusions** |
| C4 | $\ker N_x\subseteq\bigcap_i\ker N_{y_i}$ from positive semidefiniteness | **CONFIRMED, and it does need all terms on one side, which the hypothesis supplies** |
| C5 | $\mathfrak c\ne0$ holds automatically, because $\mathfrak c=0$ forces $m\le3$ | **CONFIRMED, $\dim\mathfrak c\ge\lfloor m/2\rfloor-1$** |
| C6 | every $y_i\in\mathfrak z(\mathfrak c)\cap\mathfrak c^\perp=\mathbb Rx$, hence $y_i=0$ | **CONFIRMED given L32** |
| C7 | $W=\pm x\otimes x$ and Ricci-flatness forces $x=0$ | **CONFIRMED, via the trace, which the block does not name** |
| C8 | the $\mathrm{Weyl}_4$ ambiguity witness $W^+=W^-=\mathop{\mathrm{diag}}(2,-1,-1)$ | **CONFIRMED, rebuilt cold, every clause of it holds** |
| C9 | *"with multiplicity"* reaches every quoted copy | **CONFIRMED, all three sites carry it; no live copy of the false reading remains** |
| C10 | the *"in particular"* clause at even $m\ge6$ follows from the main statement | **CONFIRMED, and $m\ge6$ is sharp** |
| C11 | the statement is safe at $\ker W\ne0$ | **CONFIRMED, zero eigenvalues drop out of the identity and the hypothesis is about signs** |
| C12 | the result covers **odd $m$** and degenerate minority eigenvectors | **GAP, L32's written proof covers neither branch at $\dim\ker x=1$** |
| C13 | Besse, *Einstein Manifolds* §1.143 | **UNHELD CITATION, no Besse in [references/](../references/); it is not load-bearing, see §3.4** |
| C14 | symbol collisions: $\mathfrak c$, $q$, $r$, $N$, $x$ | **one untabled live collision ($N$ against $N_v$, same file); the rest clear** |

## One line

**Every step L33 writes down is correct and I re-derived all of them, the operator identity included, without using the source the record cannot produce, and the one hole is inherited: [L32](../findings/isotropy-cap.md)'s written proof covers even $m$ with nondegenerate $x$ and degenerate $x$ with $\dim\ker x\ge2$, and L33's advertised coverage of odd $m$ lands exactly in the corank-1 case that neither branch reaches.**

## 0. Conventions, fixed once

Quoted, not restated. From [conventions.md](../findings/conventions.md):

> | $\mathcal W_n$ | the space of algebraic Weyl curvature operators on $\mathbb R^n$ | [README.md](../README.md) |

> | $N$ | $\binom n2=\dim\Lambda^2\mathbb R^n$ |, |

> | $q$, $r$ in [stratum-two-negative.md](../findings/stratum-two-negative.md) | **each carries two senses inside that one file.** $q$ is the Weitzenböck operator at line 142 and a scalar parameter of $W_4(q,r)$ at line 166, twenty-four lines apart; $r$ is the support dimension at line 33 and the second parameter of $W_4$ at line 166.

$\mathfrak c$ and $x$ are tabled nowhere; both are defined inline, identically, in [L32](../findings/isotropy-cap.md) and in L33, $\mathfrak c=\mathfrak z(x)\cap x^\perp$, $x$ a bivector.

For the computations below I fix the only normalisation the block's algebra is consistent with: $\langle A,B\rangle=-\tfrac12\mathop{\mathrm{tr}}(AB)$ on $\mathfrak{so}(m)$, under which $\{E_{ij}\}_{i<j}$ with $(E_{ij})_{kl}=\delta_{ik}\delta_{jl}-\delta_{il}\delta_{jk}$ is orthonormal and $\mathfrak{so}(m)\cong\Lambda^2\mathbb R^m$ carries $E_{ij}\leftrightarrow e_i\wedge e_j$. The inner product is $\mathrm{ad}$-invariant, so $\mathrm{ad}(v)$ is skew-adjoint, the one fact C3 turns on. Structure constants: $[E_{ij},E_{jk}]=E_{ik}$ for distinct $i,j,k$, and $[E_{ij},E_{kl}]=0$ when $\{i,j\}\cap\{k,l\}=\emptyset$.

## 1. Hypothesis inventory

**A pass with no inventory is not a pass, so here is the whole list, with what each gives and where the written proof spends it.**

| hypothesis | what it gives | where the written proof uses it |
| --- | --- | --- |
| $W\in\mathrm{Weyl}_m$, first Bianchi | kills the $\Lambda^4$ summand of $\mathrm{Sym}^2(\Lambda^2)$, so $\Phi(R)=2R-(\mathrm{Ric}\circ\omega+\omega\circ\mathrm{Ric})$ | the operator identity; **load-bearing, and the block says so** |
| $W\in\mathrm{Weyl}_m$, Ricci-flat | deletes the Ricci correction | the operator identity |
| $W\in\mathrm{Weyl}_m$, trace-free | $\mathop{\mathrm{tr}}_{\Lambda^2}W=\tfrac12\mathrm{scal}=0$ | **the closing step**, where the block writes only *"Ricci-flatness forces $x=0$"* |
| $W$ symmetric on $\Lambda^2$ | an orthonormal eigenbasis, hence $y_i\perp x$ | the last line of the proof |
| **one-dimensional** eigenspace on one side, with multiplicity | after rescaling, exactly one $N$-term on the left and every other on the right | the sign split $N_x=\sum_iN_{y_i}$ and, through it, C4 |
| $x$ not a multiple of a complex structure on a $4$-plane | removes L32's stated exception | the L32 step |
| $\mathfrak c\ne0$, **L32's hypothesis, discharged inline** | L32 applies at all | the L32 step; §5 confirms the discharge |
| $m\ne3$ (equivalently $\mathfrak c\ne0$) | L32's sharp hypothesis, per [LEDGER.md](../findings/LEDGER.md):1584 | subsumed by the line above, since $\mathcal W_m=0$ at $m\le3$ |

**Which the written proof actually uses.** All eight. I found **no hypothesis stated and left unused**. I found **one input used and not stated**: tracelessness at the closing step, which the block calls Ricci-flatness, charitable and correct, since $\mathrm{Ric}=0\Rightarrow\mathrm{scal}=0$, but the pairing is unnamed. [LEDGER.md](../findings/LEDGER.md):288 already records *"one pairing named beside the coefficient $2$, which three copies of the identity leave unstated"*.

**What *"one-dimensional eigenspace on one side"* means, and how it differs from *"one distinct eigenvalue"*.** The first says the total multiplicity of eigenvalues of that sign is $1$; the second says the number of distinct eigenvalue *values* of that sign is $1$. The second is strictly weaker, and §8 rebuilds the object that separates them.

**The complex-structure exception.** *"$x$ is a multiple of a complex structure on a $4$-dimensional subspace"* means: $x$ has rank $4$ and its two nonzero singular values are equal. This is scale-invariant, which matters because the proof's $x$ is the *rescaled* eigenvector $\sqrt{|\lambda_0|}\,v_0$ and the statement's is $v_0$; the hypothesis transfers because it is a statement about the line $\mathbb Rx$.

## 2. Quantifier order and scope

The conclusion is $W=0$, quantified over $W\in\mathrm{Weyl}_m$ meeting the hypotheses, at every $m$. The *"in particular"* clause is a different shape (it says a certain object does not exist) so it has to be checked to follow rather than assumed. §10 does that.

## 3. The operator identity

### 3.1 The two forms are the same statement

With $W=\sum_\alpha\lambda_\alpha v_\alpha\otimes v_\alpha$ in an orthonormal eigenbasis of $\Lambda^2$,

$$\sum_\alpha\lambda_\alpha N_{v_\alpha}=\sum_\alpha\lambda_\alpha\big(2v_\alpha\otimes v_\alpha-\mathrm{ad}(v_\alpha)^2\big)=2W-\sum_\alpha\lambda_\alpha\mathrm{ad}(v_\alpha)^2 .$$

So $\sum_\alpha\lambda_\alpha N_{v_\alpha}=0\iff\sum_\alpha\lambda_\alpha\mathrm{ad}(v_\alpha)^2=2W$. **CONFIRMED**, and it is bookkeeping.

### 3.2 The identity itself, derived here

Write $\Phi(R):=\sum_\alpha\lambda_\alpha\mathrm{ad}(v_\alpha)^2$. Two observations make this checkable by hand.

- **$\Phi$ is linear on $\mathrm{Sym}^2(\mathfrak{so}(m))$.** The map $(a,b)\mapsto\tfrac12(\mathrm{ad}(a)\mathrm{ad}(b)+\mathrm{ad}(b)\mathrm{ad}(a))$ is symmetric bilinear and polarises $v\mapsto\mathrm{ad}(v)^2$, so $\Phi(R)$ depends on $R$ as an element of $\mathrm{Sym}^2$ and not on the eigenbasis chosen. Its value is again a symmetric operator, since $\mathrm{ad}(v)$ is skew.
- **$\Phi$ is $SO(m)$-equivariant**, because $\mathrm{ad}(\mathrm{Ad}_g v)=g\,\mathrm{ad}(v)\,g^{-1}$.

So $\Phi$ is an equivariant endomorphism of $\mathrm{Sym}^2(\Lambda^2\mathbb R^m)=\mathbb R\oplus\mathrm{Sym}^2_0\oplus\mathcal W_m\oplus\Lambda^4$. The four summands have pairwise distinct highest weights, trivial, $2\epsilon_1$, $2\epsilon_1+2\epsilon_2$, $\epsilon_1+\epsilon_2+\epsilon_3+\epsilon_4$, so $\Phi$ preserves each and acts on $\mathcal W_m$ by a scalar $c_m$. **It therefore suffices to evaluate $\Phi$ at one nonzero Weyl tensor.**

**The test object: padded $W_{\mathbb{CP}^2}$, at every $m\ge4$.** On the $4$-plane $\mathop{\mathrm{span}}(e_1,\dots,e_4)$ set

$$s_1=\tfrac1{\sqrt2}(E_{12}+E_{34}),\quad s_2=\tfrac1{\sqrt2}(E_{13}-E_{24}),\quad s_3=\tfrac1{\sqrt2}(E_{14}+E_{23}),$$

the orthonormal self-dual basis, and $a_1,a_2,a_3$ the anti-self-dual one with the middle signs flipped. Put $W=2\,s_1\otimes s_1-s_2\otimes s_2-s_3\otimes s_3$, zero elsewhere.

*It is in $\mathcal W_m$.* Each $s_k$ is $1/\sqrt2$ times a complex structure on the $4$-plane, so $s_k^2=-\tfrac12\mathrm{Id}_4$ as a matrix, and

$$\textstyle\sum_\alpha\lambda_\alpha v_\alpha^2=2s_1^2-s_2^2-s_3^2=\big(-1+\tfrac12+\tfrac12\big)\mathrm{Id}_4=0,$$

which is exactly Ricci-flatness. First Bianchi holds because the $\Lambda^4$ component of a $*$-commuting operator on $\Lambda^2\mathbb R^4$ is $\mathop{\mathrm{tr}}(W|_{\Lambda^2_+})-\mathop{\mathrm{tr}}(W|_{\Lambda^2_-})=0-0=0$, and padding adds no components. $W\ne0$.

*The brackets.* Direct from $[E_{ij},E_{jk}]=E_{ik}$:

$$[s_1,s_2]=\tfrac12\big(-E_{23}-E_{14}-E_{14}-E_{23}\big)=-\sqrt2\,s_3,\qquad [s_2,s_3]=\tfrac12\big(-E_{34}-E_{12}-E_{12}-E_{34}\big)=-\sqrt2\,s_1,$$

so $\{s_i\}$ is an $\mathfrak{su}(2)$ with structure constant $-\sqrt2$ and $\mathrm{ad}(s_i)^2s_j=-2s_j$ for $i\ne j$, $\mathrm{ad}(s_i)^2s_i=0$. Also $[\Lambda^2_+,\Lambda^2_-]=0$, so $\mathrm{ad}(s_i)a_j=0$.

*The evaluation, on a spanning set of $\Lambda^2\mathbb R^m$.*

| $\omega$ | $\Phi(W)\omega$ | $2W\omega$ |
| --- | --- | --- |
| $s_1$ | $0+2s_1+2s_1=4s_1$ | $4s_1$ |
| $s_2$ | $2(-2s_2)-0-(-2s_2)=-2s_2$ | $-2s_2$ |
| $s_3$ | $-2s_3$ by the same lines | $-2s_3$ |
| $a_j$ | $0$ | $0$ |
| $E_{ij}$, $i\le4<j$ | $\big((2s_1^2-s_2^2-s_3^2)e_i\big)\wedge e_j=0$ | $0$ |
| $E_{ij}$, $4<i<j$ | $0$ (brackets vanish) | $0$ |

So $c_m=2$ at every $m\ge4$: $\Phi(W)=2W$. **C1 CONFIRMED.** At $m=4$, $\mathcal W_4=\mathrm{Sym}^2_0\Lambda^2_+\oplus\mathrm{Sym}^2_0\Lambda^2_-$ is two summands; the computation settles the first, and $\Phi$ is $O(4)$-equivariant while orientation reversal exchanges the two, so the scalar is $2$ on both.

### 3.3 Which hypothesis does which work, and the $\Lambda^4$ witness

**The $\mathbb R$ summand pins the shape of the correction.** $\Phi(\mathrm{Id}_{\Lambda^2})=\sum_{i<j}\mathrm{ad}(E_{ij})^2$, and on $E_{12}$ only the $2(m-2)$ pairs meeting $\{1,2\}$ in exactly one index contribute, each by $[E_{1k},[E_{1k},E_{12}]]=[E_{1k},E_{2k}]=-E_{12}$. So $\Phi=-2(m-2)$ there. Against the block's stated form $\mathcal A(R)=2R-(\mathrm{Ric}\circ\omega+\omega\circ\mathrm{Ric})$: $\mathrm{Id}_{\Lambda^2}$ has $\mathrm{Ric}=(m-1)g$, giving $2-2(m-1)=-2(m-2)$. **The two agree exactly**, so the block's attribution of the correction term is right.

**The $\Lambda^4$ witness, rebuilt.** Take $\eta=e_1\wedge e_2\wedge e_3\wedge e_4$, whose associated operator on $\Lambda^2$ is $A_\eta=*$ on $\Lambda^2\mathbb R^4$ and $0$ elsewhere: eigenvalue $+1$ on $\mathop{\mathrm{span}}(s_i)$, $-1$ on $\mathop{\mathrm{span}}(a_i)$. Then, writing $\Sigma_\pm$ for the two half-sums,

$$\Sigma_+E_{12}=\tfrac1{\sqrt2}\Sigma_+s_1=\tfrac1{\sqrt2}(-4s_1)=-2(E_{12}+E_{34}),\qquad \Sigma_-E_{12}=\tfrac1{\sqrt2}(-4a_1)=-2(E_{12}-E_{34}),$$

using $E_{12}=\tfrac1{\sqrt2}(s_1+a_1)$, $\Sigma_+a_1=\Sigma_-s_1=0$ and $\Sigma_\pm$ acting on its own $\mathfrak{su}(2)$ by $-4$. Hence

$$\Phi(A_\eta)E_{12}=\Sigma_+E_{12}-\Sigma_-E_{12}=-4E_{34}=-4\,A_\eta E_{12}.$$

**The eigenvalue is exactly $-4$.** And $A_\eta$ is Ricci-flat: the Ricci contraction $\sum_k\eta_{ikjk}$ vanishes by antisymmetry in the repeated pair. And it fails first Bianchi maximally, the Bianchi map returning $3\eta$ on a totally antisymmetric tensor. **C2 CONFIRMED: a Ricci-flat object with $\Phi=-4$ rather than $+2$, so Ricci-flatness alone does not give the identity, and first Bianchi is doing the work the block says it does.**

### 3.4 The citation

[references/](../references/) holds **no Besse**, as the brief warns and as five earlier verifier reports already record. I fetched nothing and I treated no search prose as a citation. What the folder *does* hold is [petersen-wink-2019-bochner-technique](../references/petersen-wink-2019-bochner-technique/), with the PDF, the extracted text, and a [notes.md](../references/petersen-wink-2019-bochner-technique/notes.md) that quotes Proposition 1.6 verbatim and carries a derivation of the identity from it. **What Petersen–Wink gives** is the eigenbasis rewriting $g(\mathrm{Ric}(u),u)=\sum_\alpha\lambda_\alpha\lVert[v_\alpha,u]\rVert^2$ and, with the first Bianchi rearrangement $R_{ikjl}-R_{iljk}=R_{ijkl}$ (which I checked from $R_{ikjl}+R_{ijlk}+R_{ilkj}=0$ and the antisymmetries), the evaluation $\sum_{kl}R_{ikjl}\omega^{kl}=\tfrac12(R\omega)_{ij}$. **What it does not give** is the Weitzenböck normal form $q(R)\omega=\mathrm{Ric}\circ\omega+\omega\circ\mathrm{Ric}-2\mathring R\omega$, which is the Besse content and which the on-file notes invoke. The block's own division of credit (Petersen–Wink for *"the eigenbasis rewriting and not the evaluation"*), is accurate.

**So the unheld citation is exactly that, and it is not load-bearing here**: §3.2 establishes $\Phi=2\,\mathrm{Id}$ on $\mathcal W_m$ from Schur plus one hand evaluation, using no Weitzenböck formula at all. Acquiring Besse would tidy the record; it would not change what is proved.

## 4. $N_v$: the quadratic form and the kernel

$N_v:=2\,v\otimes v-\mathrm{ad}(v)^2$, with $v\otimes v$ meaning $u\mapsto\langle v,u\rangle v$. Since the inner product is $\mathrm{ad}$-invariant, $\langle u,[v,w]\rangle=-\langle[v,u],w\rangle$, so

$$-\langle u,\mathrm{ad}(v)^2u\rangle=-\langle u,[v,[v,u]]\rangle=\langle[v,u],[v,u]\rangle=\lVert[v,u]\rVert^2,$$

and therefore

$$\boxed{\ \langle u,N_vu\rangle=2\langle v,u\rangle^2+\lVert[v,u]\rVert^2\ }$$

**C3 CONFIRMED**, and with it $N_v\succeq0$. Both inclusions of the kernel: $u\in\ker N_v\Rightarrow\langle u,N_vu\rangle=0\Rightarrow\langle v,u\rangle=0$ and $[v,u]=0$; conversely those two give $N_vu=2\langle v,u\rangle v-[v,[v,u]]=0$ directly. So $\ker N_v=v^\perp\cap\mathfrak z(v)$, **both directions, each in one line from the displayed form**. [isotropy-cap.md](../findings/isotropy-cap.md):299 records the harder direction as *"unstated and load-bearing"*; against the explicit quadratic form it is not hard, and L33 in fact needs both, $\mathfrak c\subseteq\ker N_x$ is the easy one, $\ker N_{y_i}\subseteq y_i^\perp\cap\mathfrak z(y_i)$ is the other, so the record's *"uses only the easy inclusion"* at [LEDGER.md](../findings/LEDGER.md):288 understates it by one direction that costs one line.

## 5. The kernel inclusion, and whether it needs all terms on one side

**The rescaling first.** $N_{cv}=c^2N_v$, so with the minority eigenvalue $\lambda_0$ and eigenvector $v_0$, setting $x=\sqrt{|\lambda_0|}\,v_0$ and $y_i=\sqrt{|\lambda_i|}\,v_i$ turns $\sum_\alpha\lambda_\alpha N_{v_\alpha}=0$ into $N_x=\sum_iN_{y_i}$. Terms with $\lambda_\alpha=0$ drop. **This is where the hypothesis is spent: it is what puts exactly one term on the left and gives every term on the right the same sign.**

**The inclusion.** For $u\in\ker N_x$: $0=\langle u,N_xu\rangle=\sum_i\langle u,N_{y_i}u\rangle$, a sum of non-negative reals, so each vanishes, so each $u\in\ker N_{y_i}$. **C4 CONFIRMED**, and **yes, it needs all terms on one side**, with mixed signs the sum can vanish without the summands vanishing, and the conclusion fails at once. So $\mathfrak c:=\ker N_x=\mathfrak z(x)\cap x^\perp$ satisfies $[y_i,\mathfrak c]=0$ and $\langle y_i,\mathfrak c\rangle=0$, i.e. $y_i\in\mathfrak z(\mathfrak c)\cap\mathfrak c^\perp$.

**$\mathfrak c\ne0$, checked.** Every $x\in\mathfrak{so}(m)$ lies in a maximal torus $\mathfrak t$, of dimension $\lfloor m/2\rfloor$, and $\mathfrak t\subseteq\mathfrak z(x)$, so $\mathfrak c\supseteq\mathfrak t\cap x^\perp$ of dimension $\lfloor m/2\rfloor-1$. Hence $\mathfrak c=0$ forces $\lfloor m/2\rfloor\le1$, i.e. $m\le3$, where $\mathcal W_m=0$ and the statement is vacuous. **C5 CONFIRMED, L32's missing hypothesis genuinely never reaches L33, and the block's one-line discharge is right.**

## 6. The L32 step, read at source

[Lemma L32](../findings/isotropy-cap.md) is marked **REFUTED AS STATED** in its own block, on the witness $x=e_{12}\in\mathfrak{so}(3)$ where $\mathfrak c=0$. **What survives is the statement with $\mathfrak c\ne0$ added**, equivalently $m\ne3$, per [LEDGER.md](../findings/LEDGER.md):1584, which also records that $m\ge4$ is conservative by the one case $m=2$. §5 shows L33 uses only the surviving part.

**The surviving proof, checked line by line for nondegenerate $x$ at even $m$.** With $\mathfrak t$ the torus of $x$'s $p=m/2$ blocks and $a$ its singular values, all nonzero: $\mathfrak c\supseteq\mathfrak t\cap x^\perp=a^\perp$; an element $Z=Z_{\mathfrak t}+\sum_\beta Z_\beta$ centralises $a^\perp$ exactly when every occurring root satisfies $\beta|_{a^\perp}=0$, i.e. $\beta\propto a$; every root of $D_p$ has $p-2$ zero coordinates while $a$ has none, so for $p\ge3$ no root qualifies and $\mathfrak z(\mathfrak c)\subseteq\mathfrak t$; then $\mathfrak z(\mathfrak c)\cap\mathfrak c^\perp\subseteq\mathfrak t\cap(a^\perp)^\perp=\mathbb Rx$, with the reverse inclusion because $x$ commutes with $\mathfrak z(x)\supseteq\mathfrak c$ and is orthogonal to $\mathfrak c$ by construction. At $p=2$ the roots $\pm e_1\pm e_2$ have no zero coordinate, so $a\propto(1,\pm1)$ qualifies, the complex-structure case, where I confirm the answer is the opposite $\mathfrak{su}(2)$: at $x=E_{12}+E_{34}$, $\mathfrak c=\mathfrak{su}(2)^-$ and $\mathfrak z(\mathfrak{su}(2)^-)\cap(\mathfrak{su}(2)^-)^\perp=\mathfrak{su}(2)^+$, of dimension $3$. **All of this is correct.**

**The exception matches L33's exclusion exactly.** L32's criterion, $a$ proportional to a root, i.e. exactly two nonzero singular values and they are equal, is precisely *"a multiple of a complex structure on a $4$-dimensional subspace"*, which is what L33 excludes. **CONFIRMED.**

**The padded case, checked, since L33 lives at $m\ge6$.** At $x=E_{12}+E_{34}\in\mathfrak{so}(m)$, $m\ge6$: $\mathfrak c=\mathfrak{su}(2)^-\oplus\mathfrak{so}(\ker x)$; the commutant of $\mathfrak{su}(2)^-$ in $\mathfrak{so}(m)$ is $\mathfrak{su}(2)^+\oplus\mathfrak{so}(\ker x)$ because $\mathbb R^4$ is $\mathbb H$-isotypic and $\ker x$ is trivial for it; intersecting with the commutant of $\mathfrak{so}(\ker x)$ and then with $\mathfrak c^\perp$ leaves $\mathfrak{su}(2)^+$, dimension $3$. **This reproduces L32's *"returns $3$ every time"* for padding into $\mathbb R^6,\mathbb R^8,\mathbb R^{10}$.**

**The exception is complete, and the derivation is L33's own.** In the excepted case $y_i\in\mathfrak{su}(2)^+\cap x^\perp=\mathop{\mathrm{span}}(s_2,s_3)$, so $W=x\otimes x-\sum_iy_i\otimes y_i$ is supported on $\Lambda^2_+$ of the $4$-plane: **the padded $\mathrm{Weyl}_4$ family, self-dual half only**. The block's claim that the exception is *"realised and complete … with no second family"* is therefore right, and one notch sharper than it states.

## 7. The gap, C12, and the only live finding

**The claim.** The block's box says three true clauses were dropped in the move, *"notably that the result covers odd $m$ and degenerate minority eigenvectors"*, and results.md and the report state L33 with no restriction on $m$'s parity. That coverage is consumed entirely through L32.

**1. Located exactly.** L32's proof runs the root argument over $D_p$ with $p=m/2$ (even $m$, nondegenerate $x$) and disposes of everything else in one sentence:

> For degenerate $x$ the same argument runs inside the support, with $\mathfrak z(\mathfrak c)$ additionally centralising $\mathfrak{so}(\ker x)$.

**2. The failure, in closed form.** Two branches, and the corank-1 case falls between them.

- *The literal reading* (restrict to the support $V$ and add the constraint from $\mathfrak{so}(\ker x)$), works when $\dim\ker x\ge2$: for $k\ge3$ the commutant of $\mathfrak{so}(k)$ in $\mathfrak{so}(m)$ is $\mathfrak{so}(V)$, and for $k=2$ the mixing part $V\otimes\ker x$ carries only weights $\pm1$ under $\mathfrak{so}(2)_{\ker}$ and so has no invariants. It supplies **nothing** at $k=1$, where $\mathfrak{so}(\ker x)=\mathfrak{so}(1)=0$. Take $m=7$ and $x$ with singular values $(1,2,3)$ and $\ker x=\mathbb Re_7$: the added input is the zero subalgebra, and the written argument says nothing about whether $\mathfrak z(\mathfrak c)$ meets the six-dimensional mixing space $\mathop{\mathrm{span}}(E_{i7})$.
- *The charitable reading* (re-run the root computation in $\mathfrak{so}(m)$ with $a$ padded by zeros), breaks in the opposite direction. At odd $m=2p+1$ the algebra is $B_p$, not $D_p$, and its short roots $\pm e_i$ have $p-1$ zero coordinates, so the sentence *"every root of $D_p$ is $\pm e_i\pm e_j$ and so has $p-2$ zero coordinates"* is simply false there. Concretely, at $x=e_{12}\in\mathfrak{so}(5)$ the centraliser of $\mathfrak t\cap a^\perp=\mathbb RE_{34}$ is $\mathop{\mathrm{span}}(E_{12},E_{34},E_{15},E_{25})$, of dimension $4$, where the displayed containment allows $2$. [LEDGER.md](../findings/LEDGER.md):1592 records exactly this against [L81](../findings/isotropy-cap.md) and prescribes the $\mathfrak{so}(\ker x)$ clause as the fix, *"the degenerate clause names $\mathfrak{so}(\ker x)$ and never uses it, and that is what closes the case"*, **which is the branch that is empty at $k=1$.**

**So neither the written proof nor the record's own prescribed repair covers $m$ odd with $x$ of corank exactly $1$**, and that is the generic odd-$m$ configuration, the one L33's box advertises.

**3. The opposite argued.** The most charitable defence is that the two mechanisms together tile the cases, and they do: at $k=1$ the padded $a$ has **no** zero coordinate on the support, so no short root $\pm e_i$ is proportional to it for $p\ge2$, and the $D_p$ lines then run unchanged. **That argument is correct and it is not on the record.** Supplying it is not my job; naming it is. The conclusion of L32 is therefore true at corank $1$, and what is missing is the proof of it.

**Verdict on this item: GAP, not BROKEN.** I could not exhibit a failure of the conclusion at any rank pattern I built by hand, corank $0,1,2$ and $\ge3$, ranks $2$ and $4$ and full, equal and unequal singular values, at $m=4,5,6,7,8$, and in every one $\mathfrak z(\mathfrak c)\cap\mathfrak c^\perp$ came out $\mathbb Rx$ except at the rank-$4$ equal-singular-value case, where it came out $\mathfrak{su}(2)$.

**What is unaffected.** The *"in particular"* clause quantifies over **even $m\ge6$ with a nondegenerate eigenvector** (corank $0$) which is exactly the branch L32 proves in full. Every consumer of L33 I found ([stratum-two-negative.md](../findings/stratum-two-negative.md):84, :395, :523, [LEDGER.md](../findings/LEDGER.md):913, :1001) uses it in that range or through the $m\ge6$ citation guard at [stratum-two-negative.md](../findings/stratum-two-negative.md):398.

## 8. The ambiguity, and the $\mathrm{Weyl}_4$ witness rebuilt cold

$W\in\mathcal W_4$ is exactly a symmetric operator on $\Lambda^2\mathbb R^4$ commuting with $*$ and trace-free on each of $\Lambda^2_\pm$. Set $W|_{\Lambda^2_+}=\mathop{\mathrm{diag}}(2,-1,-1)$ in $(s_1,s_2,s_3)$ and $W|_{\Lambda^2_-}=\mathop{\mathrm{diag}}(2,-1,-1)$ in $(a_1,a_2,a_3)$.

- **It is in $\mathrm{Weyl}_4$**: each block is trace-free on its own half, and $\dim\mathcal W_4=10=5+5$ is exactly $\mathrm{Sym}^2_0\Lambda^2_+\oplus\mathrm{Sym}^2_0\Lambda^2_-$. **CONFIRMED.**
- **Spectrum $(2,2,-1,-1,-1,-1)$**: eigenvalue $+2$ on $\mathop{\mathrm{span}}(s_1,a_1)$, $-1$ on the other four. **CONFIRMED.**
- **One distinct value on the positive side, and its eigenspace is two-dimensional.** So the object satisfies the *distinct-value* reading and violates the *with-multiplicity* one. **CONFIRMED.**
- **Its $+2$ eigenspace contains a rank-$2$ element that is no complex structure**: $s_1+a_1=\sqrt2\,E_{12}$, of rank $2$, and a complex structure on a $4$-plane has rank $4$. **CONFIRMED.**
- **$W\ne0$.** **CONFIRMED.**

**So the lemma is false under the distinct-value reading and the exception cannot rescue it**, since with a two-dimensional eigenspace there is no *"that eigenvector"* to test, and the generic member of the eigenspace fails the exception outright. The repair (*"exactly one eigenvalue counted with multiplicity"*), is the right one and it is minimal.

**The second witness at $m=8$, checked.** [L34](../findings/stratum-two-negative.md)'s $m=8$ object has spectrum $\{-1/\sqrt3\ (\times2),\ 1/(2\sqrt3)\ (\times4)\}$: **one distinct negative value at multiplicity two**, so it too separates the readings, and it sits outside the repaired hypothesis. The $m=6$ object has spectrum $(-3,-1,1,1,1,1)/\sqrt{14}$ (two distinct negative values) so it is not a witness, and the block correctly names only $m=8$. [LEDGER.md](../findings/LEDGER.md):983-997 already records that each $\omega_i$ there *is* L33's exception while the generic eigenvector is not, which is why the $\mathrm{Weyl}_4$ object is the primary witness and the $m=8$ one corroborative. **I confirm that reading.**

**C9, does *"with multiplicity"* reach every quoting site?** Yes. I grepped the whole tree for the pre-repair phrasing: it survives only in [reviews/](../reviews/) and in [LEDGER.md](../findings/LEDGER.md)'s and [INDEX-results.md](../findings/INDEX-results.md)'s record *of* the repair, which is where it belongs. The three live copies all carry it:

| site | text |
| --- | --- |
| [results.md](../results.md):152 | *"exactly one eigenvalue counted **with multiplicity**"* |
| [results.md](../results.md):473 | *"exactly one eigenvalue counted **with multiplicity**"* |
| [report/sections/07-gradedness-split.tex](../report/sections/07-gradedness-split.tex):1027 | *"exactly one eigenvalue counted **with multiplicity**"* |

## 9. The closing step

With every $y_i=0$, every non-minority eigenvalue vanishes and $W=\pm x\otimes x$, the sign being that of the minority side. Then $\mathop{\mathrm{tr}}_{\Lambda^2}W=\pm\lVert x\rVert^2$. A Weyl operator has $\mathop{\mathrm{tr}}_{\Lambda^2}W=\sum_{i<j}W_{ijij}=\tfrac12\mathrm{scal}=0$, so $\lVert x\rVert^2=0$ and $x=0$, hence $W=0$. **C7 CONFIRMED.** The block's *"Ricci-flatness forces $x=0$"* is correct ($\mathrm{Ric}=0\Rightarrow\mathrm{scal}=0$) but the step that actually runs is the trace, and the block never says which pairing it takes. Screened against padded $W_{\mathbb{CP}^2}$: eigenvalues $2,-1,-1,0,\dots,0$ sum to $0$, as required.

## 10. The edges

**The smallest admissible $m$.** $\mathcal W_m=0$ for $m\le3$, so the statement is empty there; $m=3$ is also exactly where L32 fails, and the two facts line up.

**$m=4$, where the exception lives, and the statement is vacuous there.** $W\in\mathcal W_4$ commutes with $*$, so each eigenspace of $W$ is $*$-invariant, so a **one-dimensional** eigenspace is a $*$-eigenline and lies in $\Lambda^2_+$ or $\Lambda^2_-$. Every unit element of $\Lambda^2_\pm\mathbb R^4$ is $1/\sqrt2$ times a complex structure on the $4$-plane. **So at $m=4$ the hypothesis and the exception cannot be satisfied together, and L33 says nothing.** This is what [stratum-two-negative.md](../findings/stratum-two-negative.md):398 records as *"the citation of Lemma L33 needs $m\ge6$, at $m=4$ a full-rank eigenvector is a complex structure"*, and I confirm it independently.

**Odd $m$.** Claimed and consumed; §7 is the finding.

**Degenerate minority eigenvectors.** Claimed. The rank-$2$ and padded rank-$4$ cases I checked by hand and they hold; the corank-1 case is §7's gap.

**$\ker W\ne0$, the trap, answered.** Zero eigenvalues sit on neither side, contribute nothing to $\sum_\alpha\lambda_\alpha N_{v_\alpha}=0$, and are untouched by the rescaling. **The statement is neither vacuous nor broken at a padded object**: padded $W_{\mathbb{CP}^2}$ at $m\ge6$ has $\ker W$ of dimension $\binom m2-3$, a one-dimensional $+2$ eigenspace, and its eigenvector $s_1$ **is** a $4$-plane complex structure multiple, so it lands squarely in the exception rather than refuting anything. This is the *"padded $\mathrm{Weyl}_4$ family is the only boundary case"* of the landscape entry, and §6 derives that it is the whole of the boundary. *Compare [conventions.md](../findings/conventions.md), where $S(W)$ carries the warning that its screen is vacuous when $\ker W\ne0$; L33 has no such defect.*

**The *"in particular"* clause, and $m\ge6$ is sharp.** A rank-$3$ $W$ has three nonzero eigenvalues summing to $0$, so the signs are mixed and the minority side carries exactly one eigenvalue at multiplicity one, whatever the coincidences among the other two. A nondegenerate bivector at even $m\ge6$ has rank $m\ge6$ and so is not a rank-$4$ complex structure, so the exception is off and L33 gives $W=0$, contradicting rank $3$. **CONFIRMED.** Both restrictions are needed: at odd $m$ no bivector is nondegenerate, so the clause would be vacuous; at $m=4$ it would be **false**, the object $W|_{\Lambda^2_+}=\mathop{\mathrm{diag}}(2,-1,-1)$, $W|_{\Lambda^2_-}=0$ being a rank-$3$ $\mathcal W_4$ tensor whose nondegenerate minority eigenvector $s_1$ exists. **C10 CONFIRMED, with $m\ge6$ sharp.**

## 11. Imported theorems, checked against the object

Only one theorem is imported into the proof body: **L32**, and §5-§7 check its hypotheses against this object one at a time, $\mathfrak c\ne0$ discharged, the complex-structure exception excluded by L33's own hypothesis, the degenerate branch consumed and only partly proved. The identity of §3 is imported in the block's telling but is re-derived here, so nothing in L33 rests on a theorem whose hypotheses I could not read. **I found no repeat of the unital-algebra shape the brief warns of.**

## 12. Symbol collisions

| symbol | finding |
| --- | --- |
| $\mathfrak c$ | untabled in [conventions.md](../findings/conventions.md), defined inline and **identically** in L32 and L33 as $\mathfrak z(x)\cap x^\perp$. I found no competing sense anywhere. **Clear.** |
| $q$ | **live and tabled.** $q(R)$ is the Weitzenböck operator inside the L33 block and a scalar parameter of $W_4(q,r)$ twenty-four lines below it, in the same file. The table already names it. **Clear because tabled.** |
| $r$ | two senses in the same file, neither of them used inside the L33 block. **No impact.** |
| $N$ | **live and untabled.** [conventions.md](../findings/conventions.md) fixes $N=\binom n2$; the L33 block introduces the operator $N_v$ at [stratum-two-negative.md](../findings/stratum-two-negative.md):47, and [L34](../findings/stratum-two-negative.md) fifty lines later writes $U=\mathop{\mathrm{im}}\,v_{N-1}+\mathop{\mathrm{im}}\,v_N$ in the tabled sense. The subscript separates them, and nothing on the record does. **The one collision this round adds.** |
| $x$ | one sense throughout, but the statement's $x$ is the unit eigenvector and the proof's is $\sqrt{|\lambda_0|}\,v_0$. The transfer is legitimate because the exception is a property of the line $\mathbb Rx$; the block never says so. **Clear on inspection.** |

## 13. Withdrawn candidates

Each of these I raised and then dropped, with the reason.

- **W1, *"Ricci-flatness forces $x=0$"* names the wrong hypothesis.** The step is the vanishing trace. **Withdrawn**: $\mathrm{Ric}=0\Rightarrow\mathrm{scal}=0\Rightarrow\mathop{\mathrm{tr}}_{\Lambda^2}W=0$, so the words are true under the charitable reading, and the record already carries the unnamed-pairing debt at [LEDGER.md](../findings/LEDGER.md):288.
- **W2, L32 is stated with $m\ne3$ in [results.md](../results.md) and with $\mathfrak c\ne0$ in [isotropy-cap.md](../findings/isotropy-cap.md).** **Withdrawn**: the two are equivalent for nonzero $x$, since $\dim\mathfrak c\ge\lfloor m/2\rfloor-1$ and $\mathfrak c=0$ at $m=3$ exactly. [LEDGER.md](../findings/LEDGER.md):1584 already says so.
- **W3, the report's L32 drops *"nonzero"* from $x$.** **Withdrawn**: at $x=0$ one gets $\mathfrak c=\mathfrak{so}(m)$, $\mathfrak z(\mathfrak c)=0$ for $m\ne2$, and $\mathbb Rx=0$, so the conclusion holds anyway. No failure to exhibit.
- **W4, L33 is vacuous at $m=4$, so the statement's range is overstated.** **Withdrawn**: vacuity is not falsity, the statement remains true there, and [stratum-two-negative.md](../findings/stratum-two-negative.md):398 already records the $m\ge6$ guard for consumers.
- **W5, the block claims first Bianchi is *"the load-bearing hypothesis"* while both hypotheses are needed.** **Withdrawn**: the block's next clause says Ricci-flatness *"only deletes the correction"*, which is the accurate division, and §3.3 confirms both halves of it against the $\mathbb R$ and $\Lambda^4$ summands.
- **W6, the record says L33 *"uses only the easy inclusion"* of $\ker N_v$.** **Withdrawn as a defect**: L33 does use the other direction, at $\ker N_{y_i}\subseteq y_i^\perp\cap\mathfrak z(y_i)$, but it costs one line from the explicit quadratic form, so nothing is owed and nothing is wrong downstream.

## 14. What would falsify it, and what I did to look

**The falsifier is a nonzero $W\in\mathrm{Weyl}_m$ with a one-dimensional eigenspace on one side, spanned by a bivector $x$ of rank other than $4$, or of rank $4$ with unequal singular values.** By §5 such a $W$ forces every other eigenvector into $\mathfrak z(\mathfrak c)\cap\mathfrak c^\perp\cap x^\perp$, so **its existence is equivalent to L32 failing at that $x$**, there is no other door.

**What I did.** I built $\mathfrak c$ and $\mathfrak z(\mathfrak c)\cap\mathfrak c^\perp$ in closed form at every configuration I could reach by hand: rank $2$ at $m=3,4,5,6$; rank $4$ with equal singular values at $m=4,6,8$; rank $4$ with unequal singular values at $m=6$; rank $6$ with pattern $(a,a,b)$ at $m=6$; corank $1$ with distinct singular values at $m=5,7$; corank $2$ at $m=6$. The answer was $\mathbb Rx$ in every case but the rank-$4$-equal ones, where it was the opposite $\mathfrak{su}(2)$ of dimension $3$. **I found no falsifier and I do not believe one exists.** I ran nothing numerical, and I did not search: a falsifier would have to be exhibited in closed form to count, and none of the configurations above admits one.

**What I did not do.** I did not supply the corank-1 argument of §7 to the record, and I did not repair L32.

## Verdict

**GAP.**

- **L33's own argument is correct at every step and complete**, and the operator identity it rests on is not merely cited but re-derived here from the definitions, so the missing Besse volume is a bibliographic debt rather than a mathematical one.
- **The *"in particular"* clause at even $m\ge6$ is PROVEN**, and both of its restrictions are sharp.
- **The gap is inherited and precisely located**: [L32](../findings/isotropy-cap.md)'s written proof covers even $m$ with nondegenerate $x$, and degenerate $x$ with $\dim\ker x\ge2$; **the corank-1 case (generic odd $m$), is reached by neither branch, and the record's own prescribed repair at [LEDGER.md](../findings/LEDGER.md):1592 is the branch that is empty there.** L33's box advertises coverage of odd $m$, so the gap is consumed rather than dormant.
- *What would have to be proved to close it, exactly:* **for $x\in\mathfrak{so}(m)$ of corank $1$ with $\mathfrak c=\mathfrak z(x)\cap x^\perp$, that $\mathfrak z(\mathfrak c)\cap\mathfrak c^\perp=\mathbb Rx$ unless $x$ has rank $4$ with equal singular values**, the case where $\mathfrak{so}(\ker x)$ is trivial and the root argument must instead be run in $B_p$ rather than $D_p$.
