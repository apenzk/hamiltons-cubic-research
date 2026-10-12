# Krasnov & Tkachev, *Medial and isospectral algebras* (arXiv:2210.08245)

**Yakov Krasnov and Vladimir G. Tkachev**, arXiv:2210.08245v1 [math.RA], 15 Oct 2022. Transcribed 2026-09-02 from [paper.txt](https://arxiv.org/abs/2210.08245) (`pdftotext -layout`). See [README.md](README.md) for why the folder was opened.

## Read this first, Remark 1.2 puts the paper's main class outside this project's setting

> **Remark 1.2.** The latter implies that except for the case of dimension $\dim A=2$, the spectrum of any isospectral generic algebra over $\mathbb C$ contains complex numbers, therefore **a isospectral generic algebra of dimension $\ge3$ is not metrized!** Indeed, a metrized algebra must have a real spectrum because the multiplication operator $L(x)$ is self-adjoint for any element $x\in A$ [58], [59].

**The record's Fox algebra is metrized**, so the *generic* isospectral algebras this paper classifies are disjoint from it in every dimension $\ge3$. What survives for this project is the **non-generic** side, which the paper names and defers:

> Note, that the Hsiang algebras above are isospectral but they normally are not generic and contain infinitely many idempotents if the dimension $\ge4$. **A classification of all non-generic commutative nonassociative isospectral algebras is more involved and will be considered elsewhere.**

And the motivating fact the paper opens with, for exactly that class:

> in any Hsiang algebra all idempotents have the same spectrum with eigenvalues in $\{-1,-\tfrac12,\tfrac12,1\}$, where the multiplicity of each eigenvalue is independent on a choice of an idempotent [42].

## The definitions

Standing convention: an algebra means a **commutative** nonassociative finite-dimensional algebra over a field $K$ with $\mathrm{char}(K)\ne2,3$; $c$ is an idempotent if $c^2=c$; $\mathrm{Idm}(A)$ is the set of nonzero idempotents.

> **Definition 2.1.** The **spectrum** of an idempotent $c$, denoted $\mathrm{spec}(c)$, is the multi-set of all roots of the characteristic polynomial of $L_c$. We also denote by $\sigma(c)$ the **Peirce spectrum** of $c$, i.e. the set of all distinct eigenvalues of $L_c$, the support of $\mathrm{spec}(c)$. Thus, two idempotents may have distinct spectra while their Peirce spectra may be the same. By $\sigma(A)=\bigcup_{c\in\mathrm{Idm}(A)}\sigma(c)$ we denote the Peirce spectrum of an algebra $A$.

> **Definition 1.1.** A commutative nonassociative algebra is called **isospectral** if all nonzero algebra idempotents have the same spectrum.

> **Definition 1.6.** A commutative algebra $A$ satisfying $(xy)(zw)=(xz)(yw)$ for all $x,y,z,w\in A$ is called **medial**. (10)

> **Definition 2.2.** An algebra $A$ over $K$ is called a **generic** nonassociative algebra if its complexification $A_{\mathbb C}$ contains exactly $2^n$ distinct idempotents, where $n=\dim A$.

> **Definition 4.3.** A medial algebra $A$ is said to be **reduced** if $\mathrm{Idm}^\times(A)=\mathrm{Idm}(A)$, where $\mathrm{Idm}^\times(A):=\{c\in\mathrm{Idm}(A):\ker L_c=0\}$.

An idempotent $c$ is **primitive** if the eigenvalue $1$ has multiplicity one; $1\in\sigma(c)$ always.

## The genericity criterion and the syzygies, Theorems 2.3 and 2.4

> **Theorem 2.3 (Theorem 3.3 in [35]).** If $A$ is a commutative nonassociative generic algebra then $\tfrac12\notin\sigma(A)$. In the converse direction: if $\tfrac12\notin\sigma(A)$ and $A$ does not contain 2-nilpotents then $A$ is generic.

**This is directly usable by the record**, since it is a statement about the Peirce spectrum alone. *Note the tension with the Hsiang fact quoted above: Hsiang algebras carry $\pm\tfrac12$ in their Peirce spectrum, which is precisely why they are not generic.*

> **Theorem 2.4.** Let $A$ be a generic commutative nonassociative algebra over $K$, $\dim A=n$. Then
> $$\sum_{c\in\mathrm{Idm}(A)}\frac{\chi_c(t)}{\chi_c(\tfrac12)}=2^n(1-t^n),\qquad\forall t\in\mathbb R,\tag{15}$$
> where $\chi_c(t)=\det(L_c-\tfrac1t)$ is the characteristic polynomial of $L_c$. Furthermore, let $H(x):K^n\to K^s$ be a vector-valued polynomial map ($s\ge1$) such that for each coordinate $\deg H_i\le n-1$, $1\le i\le n$. Then
> $$\sum_{c\in\mathrm{Idm}_0(A)}\frac{H(c)}{\chi_c(\tfrac12)}=0.\tag{16}$$

*Combines Theorem 4.1 and Proposition 4.2 of [35]; the $\tfrac12$ in the denominator is why Theorem 2.3 excludes $\tfrac12$ from $\sigma(A)$.*

## The Peirce structure of medial algebras, the part the folder was opened for

> **Proposition 3.6.** Let $A$ be a medial algebra. For any idempotent $c\in\mathrm{Idm}(A)$: (a) $L_c(xy)=L_c(x)L_c(y)$ for all $x,y\in A$, i.e. the multiplication operator $L_c:A\to A$ is an **algebra endomorphism**; (b) $A_c(0)$ is an **ideal** of $A$; (c) $L_c(A)$ is a **subalgebra** of $A$; (d) $A_c(1)$ is a subalgebra of $L_c(A)$ and $\dim A_c(1)\ge1$; (e) for any idempotents $c_1,c_2\in\mathrm{Idm}(A)$ the transformation rule $L_{c_2}L_{c_1}=L_{c_2c_1}L_{c_2}$ holds. (27)

Proof of (a), which drives the rest: $L_c(xy)=c(xy)=(cc)(xy)=(cx)(cy)=L_cx\,L_cy$. Then $A_c(0)=\ker L_c$ is an ideal as the kernel of a homomorphism, $\mathrm{im}\,L_c$ a subalgebra as its image, $A_c(1)$ the fixed-point set, and $\langle c\rangle\subset A_c(1)\subset cA$ gives $\dim A_c(1)\ge1$.

**This is the statement the record's indecomposability test wants**: it says precisely when a Peirce eigenspace is a subalgebra, and it holds for the whole $\mathrm{Idm}(A)$, but **only under the medial identity (10)**, which the record must verify for the Fox algebra before using any of it.

> **Proposition 4.2.** The Peirce subspace $A_c(0)$ is an ideal in $A$ and the factor $A'=A/A_c(0)$ is a medial algebra. If additionally $c$ is semisimple then $A'_{c'}(0)=0$, where $c'$ is the class of $c$ in $A'$.

> **Proposition 4.5.** Let $c_1,c_2\in\mathrm{Idm}(A)$ [with $A$ reduced medial]. Then $c_1c_2\in\mathrm{Idm}(A)$ and
> $$A_{c_1}(\lambda_1)A_{c_2}(\lambda_2)\subset A_{c_1c_2}(\lambda_1\lambda_2),\qquad A_{c_1}(\lambda_1)A_{c_1}(\lambda_2)\subset A_{c_1}(\lambda_1\lambda_2).\tag{36, 37}$$
> In particular $\sigma(c_1)\cup\sigma(c_2)\subset\sigma(c_1c_2)$ (38) and $\dim A_{c_j}(\lambda_j)\le\dim A_{c_ic_j}(\lambda_j)$ for all $\lambda_i\in\sigma(c_i)$, $i=1,2$. (39)

**The multiplicativity in (36) (eigenvalues multiply, not add), is the structural signature of the medial identity**, and it is what makes the Peirce spectrum cyclotomic.

> **Proposition 4.6.** If $c_1$ is a semi-simple idempotent then for any idempotent $c_2\in\mathrm{Idm}(A)$, the idempotent $c_1c_2$ is also semi-simple and $\mathrm{spec}(c_1)=\mathrm{spec}(c_1c_2)$.

> **Corollary 4.7.** If $c_1$ and $c_2$ are semi-simple idempotents then $\mathrm{spec}(c_1)=\mathrm{spec}(c_2)$.

> **Corollary 4.8.** If all idempotents of a reduced medial algebra $A$ are semi-simple then $A$ is isospectral.

> **Corollary 4.9.** If a reduced medial algebra $A$ is generic and all its idempotents are semi-simple then $A$ is isospectral and its spectrum consists of the primitive roots of unity of degree $\dim A$: $\mathrm{spec}(c)=\{\epsilon_n^k:1\le k\le n=\dim A\}$ for all $c\in\mathrm{Idm}(A)$. *Proof: follows from the syzygy relation in Theorem 2.4.*

Also recorded: **Proposition 3.5**, the idempotents of a medial algebra are closed under multiplication (a magma); **Proposition 3.7**, $\mathrm{Idm}^\times(A)$ is a medial idempotent quasigroup and all its elements have the **same characteristic polynomial**, because $L_{c_1c_2}=L_{c_1}L_{c_2}L_{c_1}^{-1}$ makes the $L_c$ mutually conjugate; **Proposition 3.1**, over a field of characteristic $\ne2,3$ the identity $(xy)^2=x^2y^2$ (23) is equivalent to the medial identity (7); **Proposition 3.8**, every associative commutative algebra is medial; **Proposition 3.9**, a unital medial algebra is associative.

## The classification

> **Theorem 2.6.** For a fixed dimension $n\ge2$, there exists **exactly one** isomorphy class of medial generic isospectral algebras over an algebraically closed field $K$. Furthermore, any medial generic isospectral algebra $A$ satisfies the identity $x^{n+1}=\beta_n(x)x$, $x\in A$, (19) where $n=\dim A$ and $\beta_n:A\to K$ is a multiplicative homomorphism.

The Peirce decomposition driving uniqueness: there is $w_1\in A$ with $A=\bigoplus_{i=0}^{n-1}\langle w_1^i\rangle$, $cw_1^i=\epsilon^iw_1^i$, and $w_1^iw_1^j=\epsilon^{\delta_{ij,0}-(i-1)(j-1)}_nw_1^{i+j}$ (20).

> **Theorem 2.7.** Let $n\ge2$. Consider the quotient $\mathcal C_n=K[z]/(z^n-1)$ with a new multiplication $\circ$ defined by $p(z)\circ q(z)=p(\epsilon_nz)q(\epsilon_nz)\bmod z^n-1$ (21), where $\epsilon_n$ is a primitive root of unity of order $n$. Then $\mathcal C_n$ is a medial isospectral algebra over $\mathbb C$ of dimension $n$, and the multiplicative homomorphism (19) is $\beta(p(z))=p(1)p(\epsilon_n)p(\epsilon_n^2)\cdots p(\epsilon_n^{n-1}):\mathcal C_n\to K$. (22)

> **Theorem 2.8.** Let $A$ be a medial isospectral algebra of dimension $n$. Then there exists a bijection $\varphi:\mathrm{Idm}(A)\to\mathbb Z_{2^n-1}$ such that $\varphi(xy)\equiv\tfrac12(\varphi(x)+\varphi(y))\bmod 2^n-1$.

> **Theorem 2.5 (The Bruck–Murdoch–Toyoda Theorem [41], [8], [61]).** For any medial quasigroup $(Q,\circ)$, there exists an abelian group $(G,+)$, a fixed element $g\in G$, and commuting automorphisms $\varphi,\psi:G\to G$ such that $x\circ y=g+\varphi(x)+\psi(y)$.

## What it cites

Reference [35] (the authors' own earlier paper) supplies Theorems 2.3 and 2.4, the genericity criterion and the syzygies; [42] supplies the Hsiang-algebra spectrum $\{-1,-\tfrac12,\tfrac12,1\}$; [58], [59] supply the self-adjointness of $L(x)$ in a metrized algebra used in Remark 1.2; Griess [23] and Smith [51] for the Monster-algebra precedent; Leibak–Puusemp [38], [37] for CIM quasigroups.

## Incomplete

Examples 1.3, 1.5, 3.19, 3.21, 4.1, Propositions 3.2, 3.4, 3.12, 3.15–3.18, Theorem 3.14, Corollary 3.20 and all of §§5–7 are not transcribed. §§6–7 carry the existence proof for $\mathcal C_n$, which is a construction rather than a constraint and is not what the record needs.
