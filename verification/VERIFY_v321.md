# Verifier v321, Lemma L101 step B1: $P\equiv0$ on $V_{1/2}$ from the $SO(n)$-invariance identity

**The brief [ADJ_L101_B1.md](ADJ_L101_B1.md) was read cold. No numerical work was done and no scripts were written. Every value below is exact.** The log is [agent_logs/verify-L101-v321.log](../agent_logs/verify-L101-v321.log).

*Disclosure of what was read.* Besides the brief, I read [findings/route-a.md](../findings/route-a.md) lines 174, 404-408 and 423-449, [findings/conventions.md](../findings/conventions.md) lines 24, 64 and 136, the [Nienhaus notes](../references/nienhaus-2023-second-best-einstein/notes.md), and the [extraction](https://arxiv.org/abs/2311.02404) at lines 4260-4290, 4360-4420 and 4655-4668. The print of route-a.md spanned lines 420-450, so the uncited lines 420-422 and 424-440 (a Gate 2 summary placed inside the L101 block) passed in front of me. The two hypotheses named below had been derived before that print, and no argument here rests on those lines.

| # | Claim | Verdict |
|---|---|---|
| 1 | $P(x)=T(x,x,x)$ for every $x\in\mathcal W_n$ | CONFIRMED |
| 2 | $T(x,x,[\rho(A),u])=0$ for every eigenvector $x$ of $F_u$ and every $A\in\mathfrak{so}(n)$ | CONFIRMED |
| 3 | $T_u\mathcal O\subseteq V_{1/2}$ | CONFIRMED, given $Q(u)=\theta^*u$ (Theorem 4.14(a), Remark 4.16) |
| 4 | $V_{1/2}\subseteq T_u\mathcal O$ | CONFIRMED at $n\ge9$ from L21, and at $n=4$ by closed form. Open at $5\le n\le8$ from the givens |
| 5 | The displayed identity alone gives $P\equiv0$ on $V_{1/2}$ | REFUTED AS STATED: it gives $P\equiv0$ on $T_u\mathcal O$, and claims 3 and 4 are needed to reach $V_{1/2}$ |
| 6 | $P(x)=0$ for every $x\in V_{1/2}$ at the padded $u=W_{\mathbb{CP}^2}$, $n\ge9$ | CONFIRMED |

**Summary: the step is VALID at $n\ge9$ (and at $n=4$) once two unwritten facts are supplied, that $u$ is an eigenvector of $Q$ with $Q(u)=\theta^*u$ and that $V_{1/2}$ is exactly the orbit tangent, the second following from L21.**

## 0. Conventions, fixed once

- $\mathcal W_n$ carries the Frobenius inner product. $Q(W)=W^2+W^\#$, taken with its orthogonal projection onto $\mathcal W_n$ wherever the raw expression leaves $\mathcal W_n$. That projection is $SO(n)$-equivariant, so every equivariance statement below holds with or without it.
- $X\circ Y=\tfrac12(Q(X+Y)-Q(X)-Q(Y))$ and $T(X,Y,Z)=\langle X\circ Y,Z\rangle$, fully symmetric (Passage B).
- $F_u(h)=\tfrac12(uh+hu)+u\#h$, projected as $Q$ is. Since $\#$ is symmetric bilinear, $u\circ h=\tfrac12(uh+hu)+u\#h=F_u(h)$, and $F_u=\tfrac12DQ_u$.
- **$V_\lambda$ is the eigenspace of $F_u$ for the eigenvalue $\lambda\theta^*$.** This is the normalisation Passage C fixes ($F_uW_1=\tfrac13\theta^*W_1$ for $W_1\in V_{1/3}$) and the one the general identity's factor $(\lambda-\mu)\theta^*$ uses. The first display of Passage A writes $\lambda$ for the raw eigenvalue. Only the diagonal $\lambda=\mu$ is used below, where the two readings agree.
- $A\cdot X=[\rho(A),X]$ for $A\in\mathfrak{so}(n)$, and $T_u\mathcal O=T_u(SO(n).u)=\{[\rho(A),u]:A\in\mathfrak{so}(n)\}$. Passage A's $[A,u]$ is read as $[\rho(A),u]$.
- $u=W_{\mathbb{CP}^2}$ padded to $\mathcal W_n$, unit norm, $\theta^*=P(u)=\sqrt{3/2}$.

## Hypothesis inventory

- **H0 (standard).** $Q$ is $SO(n)$-equivariant, $\langle\cdot,\cdot\rangle$ is $SO(n)$-invariant, $T$ is fully symmetric, and $\rho(A)$ is skew on $\Lambda^2\mathbb R^n$.
- **H1 (eigen-relation at $u$).** $Q(u)=\theta^*u$, equivalently $F_uu=\theta^*u$. Supplied by [Theorem 4.14(a)](../references/nienhaus-2023-second-best-einstein/notes.md) for $n\ge9$. This is criticality of $u$ for $P$ on the unit sphere, and Passage A's sentence "the argument never uses criticality of $u$" is true of the orthogonality and false of the step.
- **H2 (spectral gap transverse to the orbit).** $V_{1/2}\cap(\mathbb Ru\oplus T_u\mathcal O)^\perp=0$. Supplied at $n\ge9$ by Lemma L21 (Passage D), as shown in section 3.
- **H3 (range).** $n\ge9$, the range of L21 and Theorem 4.14 and the standing range of the section. At $n=4$ the conclusion also holds (section 5). At $5\le n\le8$ H1 and H2 are not supplied by the givens.

## 1. $P$ is the cubic form of $T$

$Q$ is homogeneous quadratic, so $x\circ x=\tfrac12(Q(2x)-2Q(x))=\tfrac12(4Q(x)-2Q(x))=Q(x)$. Hence $P(x)=\langle x,Q(x)\rangle=\langle x\circ x,x\rangle=T(x,x,x)$. Claim 1 CONFIRMED.

## 2. The diagonal identity

For $g\in SO(n)$, $(gXg^{-1})^2=gX^2g^{-1}$, and $\#$ commutes with conjugation because $\mathrm{Ad}_g$ preserves the structure constants of $\mathfrak{so}(n)$. So $Q(g\cdot X)=g\cdot Q(X)$, hence $g\cdot X\circ g\cdot Y=g\cdot(X\circ Y)$ and $T(g\cdot X,g\cdot Y,g\cdot Z)=T(X,Y,Z)$. Differentiating at $g=\exp(tA)$, $t=0$:
$$T(A\cdot x,y,z)+T(x,A\cdot y,z)+T(x,y,A\cdot z)=0.$$
Put $y=x$, $z=u$ and use full symmetry: $T(x,x,A\cdot u)=-2T(A\cdot x,x,u)=-2\langle A\cdot x,u\circ x\rangle=-2\langle A\cdot x,F_ux\rangle$. If $F_ux=\lambda\theta^*x$ this equals $-2\lambda\theta^*\langle[\rho(A),x],x\rangle$. For $B=\rho(A)$ skew and $x$ symmetric, $\langle[B,x],x\rangle=\operatorname{tr}(Bx^2)-\operatorname{tr}(xBx)=0$. So $T(x,x,[\rho(A),u])=0$ for every eigenvector $x$ and every $A$. Claim 2 CONFIRMED, with H0 only.

The off-diagonal form follows the same way. For $x\in V_\lambda$, $y\in V_\mu$: $T(x,y,A\cdot u)=-\langle A\cdot x,F_uy\rangle-\langle F_ux,A\cdot y\rangle=-\mu\theta^*\langle A\cdot x,y\rangle+\lambda\theta^*\langle A\cdot x,y\rangle=(\lambda-\mu)\theta^*\langle A\cdot x,y\rangle$, using skewness in the second term. The displayed identity is exact under H0.

**What the identity delivers for $P$.** If $x$ is an eigenvector of $F_u$ AND $x=[\rho(A),u]$ for some $A$, then by section 1 and the diagonal identity with that same $A$,
$$P(x)=T(x,x,x)=T(x,x,[\rho(A),u])=0.$$
So the identity gives $P\equiv0$ on the set of eigenvectors lying in $T_u\mathcal O$, and nothing about an eigenvector outside $T_u\mathcal O$. The step therefore needs $V_{1/2}\subseteq T_u\mathcal O$, and it needs $T_u\mathcal O$ to consist of eigenvectors, which is $T_u\mathcal O\subseteq V_{1/2}$. Claim 5 is REFUTED AS STATED: "It also gives" is true only with these two inclusions supplied.

**Arguing the opposite.** Could $P\equiv0$ on $V_{1/2}$ follow from the identity with no inclusion? The identity's third slot is always in $T_u\mathcal O$, and $P(x)=T(x,x,x)$ has its third slot equal to $x$. For $x\in V_{1/2}$ with a nonzero component $v$ orthogonal to $T_u\mathcal O$, the identity constrains $T(x,x,t)$ for $t\in T_u\mathcal O$ only, and $T(x,x,v)$ is untouched. So the inclusion is a genuine input and the identity cannot replace it.

## 3. $V_{1/2}=T_u\mathcal O$ at $n\ge9$

**$T_u\mathcal O\subseteq V_{1/2}$ (claim 3).** Equivariance gives $Q(\exp(tA)\cdot u)=\exp(tA)\cdot Q(u)$. Differentiating, $2F_u([\rho(A),u])=DQ_u([\rho(A),u])=[\rho(A),Q(u)]$. Under H1 the right side is $\theta^*[\rho(A),u]$, so $F_u([\rho(A),u])=\tfrac12\theta^*[\rho(A),u]$. This is [Remark 4.16](https://arxiv.org/abs/2311.02404) at line 4657. Without H1 the image is $\tfrac12[\rho(A),Q(u)]$, which need not be parallel to $[\rho(A),u]$, so H1 is used here.

**$V_{1/2}\subseteq T_u\mathcal O$ (claim 4).** $F_u$ is self-adjoint by full symmetry of $T$: $\langle F_uh,k\rangle=T(u,h,k)=\langle h,F_uk\rangle$. By H1 it preserves $\mathbb Ru$, by claim 3 it preserves $T_u\mathcal O$, hence it preserves $E:=(\mathbb Ru\oplus T_u\mathcal O)^\perp$. Also $u\perp T_u\mathcal O$, since $\langle[\rho(A),u],u\rangle=0$ by skewness. Take $x\in V_{1/2}$ and write $x=au+t+v$ with $t\in T_u\mathcal O$, $v\in E$. Then
$$F_ux=a\theta^*u+\tfrac12\theta^*t+F_uv,\qquad F_uv\in E,$$
and comparing with $\tfrac12\theta^*x$ component by component gives $a\theta^*=\tfrac12a\theta^*$, so $a=0$, and $F_uv=\tfrac12\theta^*v$. If $v\ne0$, the unit vector $V=v/\lVert v\rVert$ lies in $u^\perp\cap T_u(SO(n).u)^\perp$ and has
$$\alpha=\sqrt{2/3}\,\langle F_uV,V\rangle=\sqrt{2/3}\cdot\tfrac12\sqrt{3/2}=\tfrac12>\tfrac13,$$
contradicting L21 at $n\ge9$. So $v=0$ and $x=t\in T_u\mathcal O$. With claim 3, $V_{1/2}=T_u\mathcal O$ exactly.

**Cross-check against the source, by dimension only.** Theorem 4.14(b) names the $\tfrac12\sqrt{3/2}$ eigenvectors as $\mathrm{Weyl}^{-,1}_4\oplus X^{-,2}_4\otimes\mathbb R^{n-4}$. The orbit has stabiliser $U(2)\times SO(n-4)$ up to components, of dimension $4+\binom{n-4}2$, so $\dim\mathcal O=\binom n2-\binom{n-4}2-4=4n-14$, which is $26,34,42,50$ at $n=10,12,14,16$ as Passage C records. Passage C's "$\mathrm{mult}(+\tfrac12)=\dim\mathcal O$" is the same equality $V_{1/2}=T_u\mathcal O$ and agrees with the L21 argument.

## 4. The step at $n\ge9$

Let $x\in V_{1/2}$. By section 3, $x=[\rho(A),u]$ for some $A\in\mathfrak{so}(n)$, and $x$ is an eigenvector of $F_u$. By section 2, $P(x)=T(x,x,[\rho(A),u])=0$. Claim 6 CONFIRMED.

**The alternative normalisation does not change the verdict.** If $V_{1/2}$ were read with raw eigenvalue $\tfrac12=\tfrac1{\sqrt6}\theta^*$, then $\tfrac12$ is neither $\theta^*$ nor $\tfrac12\theta^*$, and on $E$ every eigenvalue is at most $\tfrac13\theta^*<\tfrac1{\sqrt6}\theta^*$ by L21 (since $\tfrac13<\tfrac1{\sqrt6}$, as $9>6$). That eigenspace is $\{0\}$ and $P\equiv0$ holds vacuously. The substantive reading is the one of section 0.

## 5. Dimensions outside L21's range

Passage A's paragraph says "in every dimension", and that phrase belongs to the orthogonality claim, which section 2 confirms at every $n$ under H0. For the step, H1 and H2 carry the dimension dependence.

**$n=4$, closed form.** $\mathcal W_4=\mathcal W^+\oplus\mathcal W^-$, each the traceless symmetric $3\times3$ matrices on $\Lambda^\pm$, and $\mathfrak{so}(4)=\mathfrak{so}(3)_+\oplus\mathfrak{so}(3)_-$ with no bracket between the factors. So $\#$ decouples blockwise, and on one block $U\#U=\kappa\,\mathrm{adj}(U)$ for a constant $\kappa$ fixed by the basis. Take $u=\mathrm{diag}(2,-1,-1)c$ on $\Lambda^+$, $0$ on $\Lambda^-$, with $6c^2=1$. Then $U^2+\kappa\,\mathrm{adj}\,U=\mathrm{diag}(4+\kappa,1-2\kappa,1-2\kappa)c^2$, whose traceless part is $(1+\kappa)c\,U$. So $\theta^*=(1+\kappa)c=(1+\kappa)/\sqrt6$, and $\theta^*=\sqrt{3/2}$ forces $\kappa=2$, which is also the value the orthonormal self-dual basis gives ($[e^+_a,e^+_b]=\sqrt2\,\varepsilon_{abc}e^+_c$ doubles $\#$ relative to $\varepsilon$). H1 holds. With $u_i$ the diagonal of $U$, $F_u(H)=\tfrac12(UH+HU)+\tfrac\kappa2D\,\mathrm{adj}_U(H)$, and at diagonal $U$:
- off-diagonal $E_{ij}$ ($k$ the third index): eigenvalue $\tfrac12(u_i+u_j)-u_k$, giving $\tfrac32c=\tfrac12\theta^*$ on $E_{12},E_{13}$ and $-3c=-\theta^*$ on $E_{23}$.
- $\mathrm{diag}(0,1,-1)$: image $c\,\mathrm{diag}(0,-1,1)+c\,\mathrm{diag}(0,-2,2)=-\theta^*\,\mathrm{diag}(0,1,-1)$, already traceless.
- $\mathcal W^-$: $uh=hu=0$ and $u\#h=0$, eigenvalue $0$.

So $V_{1/2}=\mathrm{span}(E_{12},E_{13})$. The orbit tangent is $\{[a,U]\}$ with $a\in\mathfrak{so}(3)_+$, whose entries are $(u_i-u_j)a_{ij}$, nonzero exactly at $(1,2)$ and $(1,3)$. Hence $V_{1/2}=T_u\mathcal O$ and the step holds at $n=4$. The spectrum $\{1,\tfrac12,\tfrac12,-1,-1\}\theta^*$ on $\mathcal W^+$ and $0$ on $\mathcal W^-$ matches Theorem 4.14's pieces (a), (b), (g), (d) restricted to $\mathrm{Weyl}_4$.

**$5\le n\le8$, not settled by the givens.** Theorem 4.14 and L21 are stated for $n\ge9$, and route-a.md line 406 records that the $SO(n-4)$ argument fails at $m=4$. [Remark 4.12](https://arxiv.org/abs/2311.02404) at line 4264 supplies the decomposition at $n=5,\dots,8$ but not the eigenvalues. Section 2 and claim 3 go through there once H1 holds. The quantity that decides the step in those dimensions is whether $\tfrac12\theta^*$ is an eigenvalue of $F_u$ restricted to $(\mathbb Ru\oplus T_u\mathcal O)^\perp\subset\mathcal W_n$, together with $Q(u)\in\mathbb R u$ for the padded $u$ (the conventions file records the padding commutation $Q(\mathrm{pad}\,W')=\mathrm{pad}\,Q(W')$ as unproved). If $\tfrac12\theta^*$ is absent, the step holds by section 4 verbatim. If present, the identity says nothing about $P$ on those eigenvectors, and the step would need a separate argument. An exact block-by-block evaluation of $F_u$ on Remark 4.12's summands would settle it. It was not done.

## Verdict

**VALID** at the padded $u=W_{\mathbb{CP}^2}$ for $n\ge9$, and also at $n=4$, under this reading: $V_{1/2}$ is the $\tfrac12\theta^*$-eigenspace of $F_u$, and the identity is applied to $x\in V_{1/2}$ written as $x=[\rho(A),u]$, so that $P(x)=T(x,x,[\rho(A),u])=0$. The reading needs H0 (standard equivariance and full symmetry of $T$), **H1, $Q(u)=\theta^*u$** (Theorem 4.14(a), which is criticality of $u$ and contradicts the paragraph's "never uses criticality" as applied to this step), and **H2, $V_{1/2}\subseteq T_u\mathcal O$**, derived from L21 at $n\ge9$. As written, "It also gives $P\equiv0$ on $V_{1/2}$" omits H1 and H2, and the identity alone delivers $P\equiv0$ only on eigenvectors inside the orbit tangent. At $5\le n\le8$ the step is UNRESOLVED from the givens, pending whether $\tfrac12\theta^*$ occurs in the spectrum of $F_u$ transverse to $\mathbb Ru\oplus T_u\mathcal O$.
