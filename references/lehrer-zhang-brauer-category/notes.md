# Lehrer & Zhang, *The Brauer category and invariant theory* (arXiv:1207.5889)

**G. I. Lehrer and R. B. Zhang**, arXiv:1207.5889v1 [math.GR], 25 Jul 2012; dated 24 July 2012. Transcribed 2026-09-02 from [paper.txt](https://arxiv.org/abs/1207.5889) (`pdftotext -layout`). See [README.md](README.md) for what the folder was opened for.

**Companion**: [lehrer-zhang-sft-orthogonal](../lehrer-zhang-sft-orthogonal/notes.md) is arXiv:1102.3221, the paper this one cites as [LZ4] for the orthogonal main theorem.

## The category and its presentation

> **Theorem 2.6.** (1) The four Brauer diagrams [$I$, $X$, $A$, $U$] generate all Brauer diagrams by composition and tensor product (i.e., juxtaposition). We shall refer to these generators as the **elementary Brauer diagrams** … Note that these diagrams are all fixed by $\sharp$, and that $*$ fixes $I$ and $X$, while $A^*=U$ and $U^*=A$.
> (2) A complete set of relations among these four generators is given by the following, and their transforms under $*$ and $\sharp$. This means that any equation relating two words in these four generators can be deduced from the given relations.
> $$I\circ I=I,\quad(I\otimes I)\circ X=X,\quad(I\otimes I)\circ A=A,\quad(I\otimes I)\circ U=U\tag{2.2}$$
> $$X\circ X=I\tag{2.3}$$
> $$(X\otimes I)\circ(I\otimes X)\circ(X\otimes I)=(I\otimes X)\circ(X\otimes I)\circ(I\otimes X)\tag{2.4}$$
> $$A\circ X=A\tag{2.5}$$
> $$A\circ U=\delta\tag{2.6}$$
> $$(A\otimes I)\circ(I\otimes X)=(I\otimes A)\circ(X\otimes I)\tag{2.7}$$
> $$(A\otimes I)\circ(I\otimes U)=I\tag{2.8}$$

*This is the "seven relations among four generating homomorphisms" of the abstract: (2.3)–(2.8) plus the identity relations (2.2).*

> **Theorem 3.4.** There is a unique additive covariant functor $F:\mathcal B(\epsilon m)\to\mathcal T_G(V)$ of pre-additive categories with the following properties: (i) $F$ sends the object $r$ to $V^{\otimes r}$ and morphism $D:k\to\ell$ to $F(D):V^{\otimes k}\to V^{\otimes l}$, where $F$ is defined on the generators by $F(I)=\mathrm{id}_V$, $F(X)=\epsilon P$, $F(A)=\check C$, $F(U)=\hat C$ (3.7); (ii) $F$ respects tensor products, so that $F(r\otimes r')=V^{\otimes r}\otimes V^{\otimes r'}=F(r)\otimes F(r')$ and $F(D\otimes D')=F(D)\otimes F(D')$.

Here $\epsilon=\epsilon(G)$ is $1$ for $G=O(V)$ and $-1$ for $G=\mathrm{Sp}(V)$ (Lemma 3.1), and $\mathcal T_G(V)$ is the full subcategory of $G$-modules with objects $V^{\otimes r}$ (Definition 3.2).

## The classical fundamental theorems, in the form the paper generalises

> **Theorem 4.1.** The space $(V^{\otimes t})^{G^*}$ is zero if $t$ is odd. If $t=2r$ is even, any element of $(V^{\otimes t})^{G^*}$ is a linear combination of maps of the form $\gamma_\alpha$ ($\alpha\in\mathrm{Sym}_{2r}$), where
> $$\gamma_\alpha:v_1\otimes\cdots\otimes v_{2r}\mapsto\prod_{i=1}^r(v_{\alpha(2i-1)},v_{\alpha(2i)}).\tag{4.1}$$

> **Corollary 4.2.** … $(V^{\otimes t})^{G^*}$ is spanned by $\{\gamma_\alpha\mid\alpha\in T_r\}$, where $T_r:=\mathrm{Sym}_{2r}/(\mathrm{Sym}_r\ltimes(\mathbb Z/2\mathbb Z)^r)$ is a left transversal.

> **Remark 4.3.** Note that since $T_r$ is evidently identified with the set of all pairings of the elements of $\{1,2,\dots,2r\}$, $T_r$ is in bijection with the diagrams in $B^r_r(\epsilon m)$.

**The relation that generates everything, Lemma 4.4, and the reason it holds**

> **Lemma 4.4.** Let $S$ be any subset of $[1,t]$ with $\lvert S\rvert=m+1$. Then for any $\gamma=\gamma_\alpha$ as in (4.1), we have $\sum_{\pi\in\mathrm{Sym}(S)}(-1)^{\lvert\pi\rvert}\pi\gamma=0$. In particular, for $\alpha\in T_r$,
> $$\sum_{\pi\in\mathrm{Sym}(S)}(-1)^{\lvert\pi\rvert}\gamma_{\alpha\pi}=0.\tag{4.2}$$

Proof, in one line: the alternating sum has a factor which is an element of $\Lambda^{m+1}(V)$, **which is zero since $m=\dim(V)$**. *This is exactly the antisymmetrisation mechanism the record met at $\lambda'_1+\lambda'_2\le n$ and at the $n=4,5$ collapse.*

> **Remark 4.5.** (i) When the form is symmetric, the inner sum … may be zero for the trivial reason that an involution in $S$ might fix $\gamma$. **Thus some of the relations above are trivial in the orthogonal case.** (ii) Although $\alpha\pi$ may not be in $T_r$ above, it is always the case that $\gamma_{\alpha\pi}=\pm\gamma_\beta$ for some $\beta\in T$.

> **Theorem 4.6.** Write $m=\dim(V)$ and let $d=m$ if $G=O(V)$, and $d=\tfrac m2$ if $G=\mathrm{Sp}(V)$. **If $r\le d$, the linear functions $\{\gamma_\alpha\mid\alpha\in T_r\}$ of Corollary 4.2 form a basis of the space of $G$-invariants on $V^{\otimes2r}$. If $r>d$, any linear relation among the functionals $\gamma_\alpha$ is a linear consequence of the relations in Lemma 4.4.**

**This is the second fundamental theorem in the form the record needs**, and it is the same statement as Theorem 3.4 of [lehrer-zhang-sft-orthogonal](../lehrer-zhang-sft-orthogonal/notes.md), here with the $\mathrm{Sp}$ case carried alongside and the threshold written as $d$ rather than $n$.

## The categorical generalisation, Theorem 4.8

> **Definition 4.7.** Denote by $\langle\Sigma_\epsilon(m+1)\rangle$ the subspace of $\bigoplus_{k,\ell}B^\ell_k(\epsilon m)$ spanned by the morphisms in $\mathcal B(\epsilon m)$ obtained from $\Sigma_\epsilon(m+1)$ by composition and tensor product. Set $\langle\Sigma_\epsilon(m+1)\rangle^\ell_k=\langle\Sigma_\epsilon(m+1)\rangle\cap B^\ell_k(\epsilon m)$.

With $\phi_r=F(\Sigma_\epsilon(r))\in\mathrm{End}_G(V^{\otimes r})$ acting as $\phi_r(v_1\otimes\cdots\otimes v_r)=\sum_{\sigma\in\mathrm{Sym}_r}(-1)^{\lvert\sigma\rvert}v_{\sigma(1)}\otimes\cdots\otimes v_{\sigma(r)}$, and $\phi_{m+1}=0$:

> **Theorem 4.8.** Assume that $K$ has characteristic 0 and write $d=m$ if $G=O(V)$, and $d=\tfrac m2$ if $G=\mathrm{Sp}(V)$, where $m=\dim(V)$.
> (1) The functor $F:\mathcal B(\epsilon m)\to\mathcal T_G(V)$ is **full**. That is, $F$ is surjective on Hom spaces.
> (2) The map $F^\ell_k$ is **injective if $k+\ell\le2d$**, and $\ker F^\ell_k=\langle\Sigma_\epsilon(m+1)\rangle^\ell_k$ if $k+\ell>2d$.

*Part (1) is the FFT, part (2) the SFT, in categorical form.* The proof reduces to $\ell=0$ using the canonical isomorphism $B^\ell_k\cong B^0_{k+\ell}$ of Lemma 3.6.

> **Corollary 4.10.** If $k+\ell\le2d$, then $\langle\Sigma_\epsilon(m+1)\rangle^\ell_k=0$.

## The orthogonal main theorem, §6

For $p=0,1,\dots,m+1$, $E_{m+1-p}$ denotes an element of the Brauer algebra $B^{m+1}_{m+1}(m)$ of degree $m+1$ given pictorially in Figure 16.

> **Lemma 6.1.** For all $0\le k\le m+1$, the elements $E_k$ are linear combinations of Brauer diagrams over $\mathbb Z$.

> **Lemma 6.2.** (1) $*E_p=E_{m+1-p}$ for all $p$. (2) $F_pE_p=E_pF_p=p!\,(m+1-p)!\,E_p$. (3) $e_iE_p=E_pe_i=0$ for all $i\le m$.

> **Corollary 6.3 ([LZ4]).** Let $D$ be any diagram in $B^{m+1}_{m+1}(n)$ which has fewer than $m+1$ through strings. Then $DE_i=E_iD=0$ for all $i$.

Noted in passing: $E_0=E_{m+1}=\Sigma_{+1}(m+1)$.

> **Proposition 6.4.** Assume $r>m$. As a two-sided ideal of the Brauer algebra $B^r_r(m)$, $\ker F^r_r$ is generated by $E_p$ for all $0\le p\le m+1$.

> **Corollary 6.9.** For all $i=0,1,\dots,m+1$, we have $X_{i,m+1-i}E_iX_{m+1-i,i}=E_{m+1-i}$.

> **Theorem 6.10 ([LZ4]).** The algebra map $F^r_r:B^r_r(m)\to\mathrm{Hom}_{O(V)}(V^{\otimes r},V^{\otimes r})$ is **injective if $r\le m$**. If $r>m$, the two-sided ideal $\ker F^r_r$ of the Brauer algebra $B^r_r(m)$ is generated by the element $E=E_\ell$ with $\ell=\lfloor\tfrac{m+1}{2}\rfloor$.

Its proof: Proposition 6.4 and Corollary 6.9 give generation by $E_0,\dots,E_\ell$; [LZ4, §7] then shows $E_{i-1}$ lies in the ideal generated by $E_i$ for each $i=1,\dots,\ell$.

**Theorem 6.10 is the sharp threshold in the record's own terms: $r\le m=\dim V$ gives injectivity, and above it a single generator carries every relation.**

## The symplectic side, and the semisimplicity threshold

> **Proposition 5.1.** Assume that $r>n$. As a two-sided ideal of the Brauer algebra [$B^r_r(-2n)$], … [$\ker F^r_r$ is generated by $\Phi$].

> **Corollary 5.4.** The element $\Phi/(n+1)!$ is the central idempotent in $B^{n+1}_{n+1}(-2n)$ [corresponding to its trivial representation].

> **Theorem 5.9.** The algebra homomorphism $F^r_r:B^r_r(-2n)\to\mathrm{Hom}_{\mathrm{Sp}(V)}(V^{\otimes r},V^{\otimes r})$ [is injective for $r\le n$; for $r>n$ its kernel is the ideal generated by $\Phi$].

> **Lemma 7.1.** Let $n,r\in\mathbb Z_{>0}$. The following are equivalent for the Brauer algebras over $\mathbb Z$. (1) The Brauer algebra $B_r(n)$ is semisimple. (2) The Brauer algebra $B_r(-2n)$ is semisimple. (3) $r\le n+1$.

Stated as "an immediate consequence of [RS, Theorem 2.3]", **that is the Rui semisimplicity criterion the record files at [rui-brauer-semisimplicity](../rui-brauer-semisimplicity/README.md), and Lemma 7.1 is a first-hand statement of its content.** Lehrer and Zhang draw the conclusion: "$n+1$ is the largest value of $r$ such that $B_r(n)$ and $B_r(-2n)$ are semisimple. The idempotents we have found are thus each in the 'last' Brauer [algebra which is semisimple]."

## Positive characteristic

> **Theorem 7.3.** Over any field $K$ of characteristic $\mathrm{char}(K)\ge m+2$, (1) the functor $F_\epsilon:\mathcal B(\epsilon m)\to\mathcal T_G(V)$ is full; (2) the map $F^\ell_{\epsilon,k}$ is injective if $k+\ell\le2d$, and $\ker F^\ell_{\epsilon,k}=\langle\Sigma_\epsilon(m+1)\rangle^\ell_k$ if $k+\ell>2d$.

*The orthogonal case is [LZ4, Theorem 9.4]; the symplectic case is sketched here from [ALZ] and the authors note they could not find it in the literature. **This project works over $\mathbb Q$ and $\mathbb R$, so §7 and §8 (quantum analogues, BMW algebras) are not needed.***

## Incomplete

Definitions 2.1, 2.3, 2.4, 2.7, 2.8, 2.11, Lemmas 2.10, 2.12, 2.13, 2.15, 2.17–2.19, 2.21, Corollary 2.16, Lemmas 3.1, 3.6, 3.7, Definition 3.2, Lemmas 5.2, 5.3, 5.8, Definition 5.6, Lemmas 6.6, 6.7, 7.2, 8.1 and Theorem 8.2 are not transcribed. The diagram-calculus lemmas of §2 and the explicit formulae for $E_i$ in §6.2 depend on figures the text extraction cannot carry, and **anything drawn from them must be read from [paper.pdf](https://arxiv.org/abs/1207.5889) rather than from the extraction.**
