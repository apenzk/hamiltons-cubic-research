# Verifier v327, step B4 of Lemma L101: $[A,u]$ as the infinitesimal action of $\mathfrak{so}(n)$ on $\mathcal W_n$

The brief [ADJ_L101_B4.md](ADJ_L101_B4.md) was read cold. No numerical work was done and no scripts were written. Every value below is exact. The log is [agent_logs/verify-L101-v327.log](../agent_logs/verify-L101-v327.log).

| # | Claim | Verdict |
|---|---|---|
| 1 | $[A,u]$ read literally as the matrix commutator of $A\in\mathfrak{so}(n)$ (an $n\times n$ matrix) with $u\in\mathcal W_n$ (an $N\times N$ matrix, $N=\binom n2$) is defined | REFUTED AS STATED for every $n\ge4$, a notational abuse that the lemma's own heading repairs |
| 2 | $[\rho(A),u]$ is a symmetric operator on $\Lambda^2\mathbb R^n$ | CONFIRMED |
| 3 | $[\rho(A),u]$ lies in $\mathcal W_n$ | CONFIRMED |
| 4 | $[\rho(A),u]=A\cdot u:=\frac{d}{dt}\big\vert_{t=0}\exp(tA)\cdot u$ exactly, sign included | CONFIRMED |
| 5 | Under $\Lambda^2\mathbb R^n\cong\mathfrak{so}(n)$, $\rho(A)=\operatorname{ad}_A$, so $[A,u]$ can also be read as $[\operatorname{ad}_A,u]$ | CONFIRMED AS ALGEBRA |

**Summary: the step is VALID once $[A,u]$ is read as $[\rho(A),u]$ with $\rho(A)$ the induced derivation on $\Lambda^2\mathbb R^n$, which is the notation of line 423 and of the very sentence that uses it.**

## 0. Conventions, fixed once

- $N=\binom n2=\dim\Lambda^2\mathbb R^n$. $\Lambda^2\mathbb R^n$ carries the inner product $\langle v\wedge w,v'\wedge w'\rangle=\langle v,v'\rangle\langle w,w'\rangle-\langle v,w'\rangle\langle w,v'\rangle$. Any positive multiple gives the same conclusions.
- For $g\in SO(n)$, $\rho(g)(v\wedge w)=gv\wedge gw$. For $A\in\mathfrak{so}(n)$, $\rho(A)(v\wedge w)=Av\wedge w+v\wedge Aw$, the differential of $\rho$ at the identity. The same letter serves both, as in the record.
- $\mathcal W_n\subset\operatorname{Sym}(\Lambda^2\mathbb R^n)$ is the space of symmetric operators $R$ satisfying the first Bianchi identity $b(R)=0$ and the Ricci condition $\operatorname{Ric}(R)=0$, with the Frobenius inner product $\langle X,Y\rangle=\operatorname{tr}(XY)$.
- The action is left conjugation, $g\cdot u=\rho(g)\,u\,\rho(g)^{-1}$, as the brief's definitions state. $A\cdot X:=\frac{d}{dt}\big\vert_{t=0}\exp(tA)\cdot X$ for every $X\in\mathcal W_n$, the same rule for $x$, $y$ and $u$.

## Hypothesis inventory

- **H1 (notation).** $[A,u]$ means $[\rho(A),u]=\rho(A)u-u\rho(A)$. Line 423 writes $T(x,y,[\rho(A),u])$ and line 445 writes "the derivation $X\mapsto[\rho(A),X]$", so the author supplies this reading in the same block.
- **H2 (convention).** The action is left conjugation by $\rho(g)$, and $A\cdot x$, $A\cdot y$, $A\cdot u$ are all the derivative of that one action. This is stated in the brief's definitions.
- **H3 (invariance of the metric).** The inner product on $\Lambda^2\mathbb R^n$ is $SO(n)$-invariant, so $\rho(g)$ is orthogonal and $\rho(A)$ is skew. This holds for the induced inner product fixed in section 0.
- Needed nowhere: criticality of $u$, the value of $n$ beyond $n\ge4$ (below which $\mathcal W_n=0$ and the step is vacuous), the choice $u=W_{\mathbb{CP}^2}$, and any property of $F_u$ or its eigenspaces.

## 1. The literal commutator is undefined, and where the repair sits

The sentence at line 441 reads "using $A\!\cdot\!u=[A,u]$". Here $A\in\mathfrak{so}(n)$ is an $n\times n$ matrix and $u$ is an operator on $\Lambda^2\mathbb R^n$, an $N\times N$ matrix. The products $Au$ and $uA$ exist only if $N=n$, that is $n(n-1)/2=n$, whose only positive solution is $n=3$. At $n=3$ the space $\mathcal W_3$ is zero. So for every $n$ where $\mathcal W_n\neq0$ the expression $[A,u]$ taken literally denotes nothing.

Arguing the opposite: the lemma's heading (line 423) states the identity with $[\rho(A),u]$, and line 445, inside the same argument, names the derivation $X\mapsto[\rho(A),X]$. The drop of $\rho$ at lines 441 and 443 is therefore an abbreviation for the operator that the block itself names, and H1 is the author's meaning rather than an invented one. Section 5 gives a second reading, $[\operatorname{ad}_A,u]$ under $\Lambda^2\mathbb R^n\cong\mathfrak{so}(n)$, which denotes the same operator. The defect is cosmetic.

## 2. $[\rho(A),u]$ is symmetric

$\rho$ is a smooth homomorphism $SO(n)\to O(\Lambda^2\mathbb R^n)$ by H3, since $\langle gv\wedge gw,gv'\wedge gw'\rangle$ is a determinant of inner products each preserved by $g$. Its differential satisfies $\rho(\exp tA)=\exp(t\,\rho(A))$. Differentiating $\rho(\exp tA)^{\mathsf T}\rho(\exp tA)=I$ at $t=0$ gives $\rho(A)^{\mathsf T}+\rho(A)=0$, so $\rho(A)$ is skew. For symmetric $u$,
$$[\rho(A),u]^{\mathsf T}=u^{\mathsf T}\rho(A)^{\mathsf T}-\rho(A)^{\mathsf T}u^{\mathsf T}=-u\rho(A)+\rho(A)u=[\rho(A),u].$$

## 3. $[\rho(A),u]$ lies in $\mathcal W_n$

The Bianchi map $b:\operatorname{Sym}(\Lambda^2\mathbb R^n)\to\Lambda^4\mathbb R^n$ and the Ricci contraction $\operatorname{Ric}:\operatorname{Sym}(\Lambda^2\mathbb R^n)\to\operatorname{Sym}^2\mathbb R^n$ are built from the metric on $\mathbb R^n$ alone, so they are $O(n)$-equivariant: $b(\rho(g)R\rho(g)^{-1})=g\cdot b(R)$ and $\operatorname{Ric}(\rho(g)R\rho(g)^{-1})=g\,\operatorname{Ric}(R)\,g^{-1}$. Hence $\mathcal W_n=\ker b\cap\ker\operatorname{Ric}\cap\operatorname{Sym}$ is an $SO(n)$-invariant linear subspace, which is also what the brief's phrase "$SO(n)$ acts on $\mathcal W_n$ by conjugation" asserts.

The curve $c(t)=\exp(tA)\cdot u$ therefore lies in $\mathcal W_n$ for all $t$. A linear subspace of a finite-dimensional space is closed, and $c'(0)=\lim_{t\to0}(c(t)-u)/t$ is a limit of elements of $\mathcal W_n$, so $c'(0)\in\mathcal W_n$. Section 4 shows $c'(0)=[\rho(A),u]$.

An independent check by differentiating the equivariance: $b([\rho(A),R])=A\cdot b(R)$ and $\operatorname{Ric}([\rho(A),R])=[A,\operatorname{Ric}(R)]$, both zero when $R\in\mathcal W_n$.

## 4. $[\rho(A),u]=A\cdot u$, sign included

By H2 and section 2, $c(t)=\exp(t\rho(A))\,u\,\exp(-t\rho(A))$. The product rule at $t=0$ gives
$$c'(0)=\rho(A)\,u-u\,\rho(A)=[\rho(A),u].$$
The sign is $+$ under left conjugation. Under the right action $g\cdot u=\rho(g)^{-1}u\rho(g)$ the derivative would be $-[\rho(A),u]$, which is why H2 is named. Under H2, applied uniformly, $A\cdot x=[\rho(A),x]$ as well, so the invariance identity $T(A\cdot x,y,z)+T(x,A\cdot y,z)+T(x,y,A\cdot z)=0$ at line 441 and the substitution $z=u$, $A\cdot u=[\rho(A),u]$ use one and the same derivation. The element is well defined: it depends on $A$ and $u$ only, with no choice made along the way.

## 5. The $\operatorname{ad}_A$ reading gives the same operator

Identify $v\wedge w$ with $vw^{\mathsf T}-wv^{\mathsf T}\in\mathfrak{so}(n)$. For $A^{\mathsf T}=-A$,
$$[A,\,vw^{\mathsf T}-wv^{\mathsf T}]=Avw^{\mathsf T}-Awv^{\mathsf T}-vw^{\mathsf T}A+wv^{\mathsf T}A=(Av)w^{\mathsf T}-w(Av)^{\mathsf T}+v(Aw)^{\mathsf T}-(Aw)v^{\mathsf T},$$
using $w^{\mathsf T}A=-(Aw)^{\mathsf T}$ and $v^{\mathsf T}A=-(Av)^{\mathsf T}$. The right side is the image of $Av\wedge w+v\wedge Aw=\rho(A)(v\wedge w)$. So $\rho(A)=\operatorname{ad}_A$ on $\mathfrak{so}(n)$, and reading $[A,u]$ as $[\operatorname{ad}_A,u]$ yields the operator of sections 2 to 4. The identification is an isometry up to the factor $2$ on the Frobenius norm of $\mathfrak{so}(n)$, which rescales nothing in the commutator.

## Verdict for the step

**VALID.** For $A\in\mathfrak{so}(n)$ and $u\in\mathcal W_n$, $[\rho(A),u]$ is a symmetric operator satisfying the Bianchi and Ricci conditions, hence an element of $\mathcal W_n$, and it equals $\frac{d}{dt}\big\vert_{t=0}\exp(tA)\cdot u$ exactly. The reading needs H1 ($[A,u]$ abbreviates $[\rho(A),u]$, as the heading at line 423 and the derivation at line 445 write it), H2 (left conjugation, the same action for $x$, $y$ and $u$) and H3 (an $SO(n)$-invariant inner product on $\Lambda^2\mathbb R^n$). The literal matrix commutator of an $n\times n$ with an $N\times N$ matrix is undefined for $n\ge4$, and that is a notational defect of lines 441 and 443 only.
