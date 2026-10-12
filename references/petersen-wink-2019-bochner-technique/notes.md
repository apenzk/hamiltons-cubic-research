# Notes, Petersen–Wink, New Curvature Conditions for the Bochner Technique

## Proposition 1.6 (p. 7 of the arXiv text), verbatim

> Let $R:\Lambda^2V\to\Lambda^2V$ be an algebraic curvature operator and $\{\Xi_\alpha\}$ an orthonormal basis for $\Lambda^2V$. It follows that
> $$\mathcal R(\hat T)=R\circ\hat T=\sum_\alpha R(\Xi_\alpha)\otimes\Xi_\alpha T.$$
> Furthermore, if $\{\Xi_\alpha\}$ is an eigenbasis of $R$ and $\{\lambda_\alpha\}$ denote the corresponding eigenvalues, then
> $$g(R(\hat T),\hat T)=\sum_{\alpha,\beta}g(R(\Xi_\alpha),\Xi_\beta)\,g(\Xi_\alpha T,\Xi_\beta T)=\sum_\alpha\lambda_\alpha|\Xi_\alpha T|^2.$$

Here $\Xi T$ denotes the action of $\Xi\in\mathfrak{so}(V)$ on the tensor $T$ by the derivation extending the standard action, and $\hat T$ is the associated element of $\Lambda^2V\otimes E$ (§1.2).

## Proposition 1.11 and Example 1.10 (p. 9)

> $g(\mathrm{Ric}(S),T)=g(R(\hat S),\hat T)$.

Example 1.10 records that the Hodge Laplacian is the Lichnerowicz Laplacian with $c=1$, that symmetric $(0,2)$-tensors use $c=1$, and that algebraic curvature tensors satisfy $\nabla^*\nabla\mathrm{Rm}+\mathrm{Ric}(\mathrm{Rm})=0$ in the Einstein case (their (1.13) and §4).

## What this gives the project

Take $E=\Lambda^2$, so the module is the adjoint representation of $\mathfrak{so}(n)$ and $\Xi_\alpha T=[\Xi_\alpha,T]$. Proposition 1.6 then reads, for $T=u$ a 2-form,

$$g(\mathrm{Ric}(u),u)=\sum_\alpha\lambda_\alpha\,\|[v_\alpha,u]\|^2=-\Big\langle u,\ \sum_\alpha\lambda_\alpha\,\mathrm{ad}(v_\alpha)^2\,u\Big\rangle .$$

So the operator $\mathcal A(W)=\sum_\alpha\lambda_\alpha\,\mathrm{ad}(v_\alpha)^2$ used in the B0 argument is exactly $-\mathrm{Ric}(\cdot)$ on 2-forms, i.e. the classical Weitzenböck curvature term

$$q(R)\,\omega=\mathrm{Ric}\circ\omega+\omega\circ\mathrm{Ric}-2\,\mathring R\,\omega .$$

For a **Ricci-flat** $R$ the two Ricci terms drop, and the first Bianchi identity gives $\sum_{k,l}R_{ikjl}\,\omega^{kl}=\tfrac12\sum_{k,l}R_{ijkl}\,\omega^{kl}=(R\omega)_{ij}$ for skew $\omega$, from $R_{ikjl}-R_{iljk}=R_{ijkl}$, which is the first Bianchi identity rearranged. Hence $q(R)=-2R$, i.e.

$$\boxed{\ \sum_\alpha\lambda_\alpha\,\mathrm{ad}(v_\alpha)^2=2W\ }\qquad\text{on }\mathrm{Weyl}_m .$$

**So the identity is published and is cited rather than claimed.** What is not in this source, and is the whole content of the B0 argument, is that the identity splits into per-eigenvector **positive semidefinite** pieces

$$N_v:=2\,v\otimes v-\mathrm{ad}(v)^2\succeq0,\qquad \ker N_v=v^\perp\cap\mathfrak z(v),$$

so that $\sum_\alpha\lambda_\alpha N_{v_\alpha}=0$ becomes a containment of centralisers between the positive and negative eigenspaces.

## Proposition 1.7 (p. 7), verbatim, the second-moment identity

> If $\{\Xi_\alpha\}$ is an orthonormal basis for $\Lambda^2V$ that diagonalizes $R\in\mathrm{Sym}^2(\Lambda^2V)$ and $\{\lambda_\alpha\}$ denote the corresponding eigenvalues, then
> $$|LR|^2=2\sum_{\alpha<\beta}(\lambda_\alpha-\lambda_\beta)^2\,g(L\Xi_\alpha,\Xi_\beta)^2$$
> for every $L\in\mathfrak{so}(V)$.

Their proof is three lines: $(LR)(\Xi_\alpha,\Xi_\beta)=-\lambda_\beta g(L\Xi_\alpha,\Xi_\beta)-\lambda_\alpha g(\Xi_\alpha,L\Xi_\beta)=(\lambda_\alpha-\lambda_\beta)g(L\Xi_\alpha,\Xi_\beta)$, using that $L$ acts skew-adjointly.

**Translated into this project's notation.** Take $L=v_\gamma$, an eigenvector of $W$. Then $\Lambda^2\cong\mathfrak{so}(n)$ makes $L\Xi_\alpha=[v_\gamma,v_\alpha]$, so $g(L\Xi_\alpha,\Xi_\beta)=\langle[v_\gamma,v_\alpha],v_\beta\rangle=c'_{\gamma\alpha\beta}$ and

$$\boxed{\ \big\|[\mathrm{ad}_{v_\gamma},W]\big\|^2=\sum_{\alpha,\beta}(\lambda_\alpha-\lambda_\beta)^2\,T_{\gamma\alpha\beta}\ }$$

verified here at $10^{-15}$ for $n=5,6,7$ against the operator commutator computed independently.

**Why it matters for the stalled band.** The class ceiling closed every bound built from $T$ weighted by $\lambda_\alpha\lambda_\beta\lambda_\gamma$ together with row marginals and pair caps. This identity weights $T$ by $(\lambda_\alpha-\lambda_\beta)^2$ and equates the result to a quantity computable from $W$ alone, so it is **outside that class**. And for $\gamma\in\mathfrak m$ the sum splits by whether $\alpha,\beta$ lie in $\mathfrak m$ or $\mathfrak h$, with $S=0$ killing the $\mathfrak{mm}$ part, the mechanism behind Lemma 36, now carrying a signed weighting.

