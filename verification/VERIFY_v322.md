# Verifier v322, step B1 of Lemma L101: $P\equiv0$ on $V_{1/2}$ from the $SO(n)$-invariance identity

The brief ([ADJ_L101_B1.md](ADJ_L101_B1.md)) was read cold. No numerical work was done and no scripts were written. Every value below is exact. The log is at [agent_logs/verify-L101-v322.log](../agent_logs/verify-L101-v322.log).

| # | Claim | Verdict |
|---|---|---|
| 1 | $T$ is $SO(n)$-invariant and fully symmetric, $P(x)=T(x,x,x)$, and $T(x,y,u)=\langle F_ux,y\rangle$ | CONFIRMED |
| 2 | $T(x,y,[\rho(A),u])=(\lambda-\mu)\,\theta^*\langle A\!\cdot\!x,y\rangle$ for $x\in V_\lambda$, $y\in V_\mu$, eigenvalues labelled in units of $\theta^*$ | CONFIRMED AS ALGEBRA |
| 3 | $F_uu=\theta^*u$, equivalently $Q(u)=\theta^*u$ (criticality of $u$) | CONFIRMED for $n\ge9$, from Theorem 4.14(a) |
| 4 | $T_u(SO(n).u)\subseteq V_{1/2}$ | CONFIRMED, given claim 3 |
| 5 | $V_{1/2}\subseteq T_u(SO(n).u)$ | CONFIRMED for $n\ge9$, from Lemma L21 and claims 3, 4 |
| 6 | $P(x)=0$ for every $x\in V_{1/2}$ | CONFIRMED for $n\ge9$ |
| 7 | The step holds "in every dimension, with no hypothesis, never using criticality", as the paragraph says of the identity | REFUTED AS STATED for the step: it uses criticality of $u$ and the identification $V_{1/2}=T_u(SO(n).u)$, which the passages supply at $n\ge9$ |

**Summary: the step is valid at $n\ge9$, because $V_{1/2}$ is exactly the orbit tangent space, so each $x\in V_{1/2}$ is a single $A\!\cdot\!u$ and the identity at $\lambda=\mu=\tfrac12$ gives $P(x)=T(x,x,A\!\cdot\!u)=0$.**

## 0. Conventions, fixed once

- $\mathcal W_n$ carries the Frobenius inner product. $SO(n)$ acts by $g\cdot W=\rho(g)W\rho(g)^{-1}$, and the infinitesimal action is $A\!\cdot\!W=[\rho(A),W]$ for $A\in\mathfrak{so}(n)$. Since $\rho(A)$ is skew on $\Lambda^2\mathbb R^n$, $\langle A\!\cdot\!X,Y\rangle=-\langle X,A\!\cdot\!Y\rangle$.
- $X\#Y$ is the symmetric bilinear form with $X\#X=X^\#$, and $Q(X)=X^2+X^\#$, read in $\mathcal W_n$ (orthogonal projection onto $\mathcal W_n$ where needed, which leaves every inner product with an element of $\mathcal W_n$ unchanged). Nienhaus writes $Q:\mathrm{Weyl}_n\otimes\mathrm{Weyl}_n\to\mathrm{Weyl}_n$ ([extraction](https://arxiv.org/abs/2311.02404) near L4333), so this is his convention too.
- $X\circ Y=\tfrac12(Q(X+Y)-Q(X)-Q(Y))=\tfrac12(XY+YX)+X\#Y$, $T(X,Y,Z)=\langle X\circ Y,Z\rangle$, $P(X)=\langle X,Q(X)\rangle=T(X,X,X)$.
- $F_u(h)=\tfrac12(uh+hu)+u\#h=u\circ h$, so $\langle F_ux,y\rangle=T(u,x,y)$, and $F_u$ is self-adjoint on $\mathcal W_n$ because $T$ is symmetric.
- $u=W_{\mathbb{CP}^2}$ padded, $\|u\|=1$, $\theta^*=P(u)=\sqrt{3/2}$. $\mathcal O=SO(n).u$ and $T_u\mathcal O=\{A\!\cdot\!u:A\in\mathfrak{so}(n)\}$.
- **Eigenvalue labels are in units of $\theta^*$**: $V_\lambda=\ker(F_u-\lambda\theta^*)$. This is the reading Passage C uses ($F_uW_1=\tfrac13\theta^*W_1$ for $W_1\in V_{1/3}$, $\mu_N=\langle FN,N\rangle/\theta^*$) and the one under which Passage A's general form carries its factor $\theta^*$. Passage A's first display writes $F_ux=\lambda x$ without the factor. That display ends in $0$, so the discrepancy is immaterial there. With this label, L21's $\alpha=\sqrt{2/3}\langle F_uV,V\rangle=\langle F_uV,V\rangle/\theta^*$ is the normalised Rayleigh quotient.

## 1. Hypothesis inventory

- **H0 (conventions).** $T$ is fully symmetric (Passage B) and $SO(n)$-invariant. Invariance holds because conjugation by $\rho(g)$ preserves products, $\#$ is $SO(n)$-equivariant (it is built from the bracket of $\mathfrak{so}(n)$), projection onto $\mathcal W_n$ commutes with the action, and the Frobenius product is invariant.
- **H1 (label normalisation).** $V_\lambda=\ker(F_u-\lambda\theta^*)$, as fixed in §0. Section 6 shows the step also holds under the unnormalised label, trivially.
- **H2 (criticality of $u$).** $Q(u)=\theta^*u$ in $\mathcal W_n$. Supplied by Theorem 4.14(a) of [Nienhaus](../references/nienhaus-2023-second-best-einstein/notes.md) at $n\ge9$, since $F_uu=u\circ u=Q(u)$.
- **H3 (dimension).** $n\ge9$, the range of Lemma L21 (Passage D) and of Theorem 4.14.
- **H4 (Lemma L21, given).** $\langle F_uV,V\rangle/\theta^*\le\tfrac13$ for every unit $V\in u^\perp\cap(T_u\mathcal O)^\perp$.

## 2. The identity (claims 1, 2)

Differentiating $T(e^{tA}\!\cdot x,e^{tA}\!\cdot y,e^{tA}\!\cdot z)=T(x,y,z)$ at $t=0$ gives

$$T(A\!\cdot\!x,y,z)+T(x,A\!\cdot\!y,z)+T(x,y,A\!\cdot\!z)=0.$$

Take $z=u$, $x\in V_\lambda$, $y\in V_\mu$. By symmetry of $T$ and self-adjointness of $F_u$, $T(A\!\cdot\!x,y,u)=\langle A\!\cdot\!x,F_uy\rangle=\mu\theta^*\langle A\!\cdot\!x,y\rangle$ and $T(x,A\!\cdot\!y,u)=\langle F_ux,A\!\cdot\!y\rangle=\lambda\theta^*\langle x,A\!\cdot\!y\rangle=-\lambda\theta^*\langle A\!\cdot\!x,y\rangle$. Hence

$$T(x,y,A\!\cdot\!u)=(\lambda-\mu)\,\theta^*\langle A\!\cdot\!x,y\rangle,$$

which is Passage A's general form. This uses H0 and H1 only. At $x=y$, $\lambda=\mu$ and the right side is $0$, and also $\langle A\!\cdot\!x,x\rangle=0$ by skewness, so the diagonal vanishes twice over. Criticality of $u$ is used nowhere in this section, as Passage A says.

## 3. The orbit tangent space lies in $V_{1/2}$ (claims 3, 4)

$F_uu=\tfrac12(u^2+u^2)+u\#u=Q(u)$, so Theorem 4.14(a) ($F_{W_{\mathbb{CP}^2}}$ has $W_{\mathbb{CP}^2}$ as eigenvector of eigenvalue $\sqrt{3/2}$) is exactly H2: $Q(u)=\theta^*u$. Pairing with $u$ recovers $P(u)=\theta^*$, consistent with Passage B.

Differentiate the equivariance $Q(e^{tA}\!\cdot u)=e^{tA}\!\cdot Q(u)$ at $t=0$. The left side gives $2\,u\circ(A\!\cdot\!u)=2F_u(A\!\cdot\!u)$, the right side gives $A\!\cdot\!Q(u)=\theta^*A\!\cdot\!u$ by H2. So

$$F_u(A\!\cdot\!u)=\tfrac12\theta^*\,A\!\cdot\!u,$$

and $T_u\mathcal O\subseteq V_{1/2}$. This is Nienhaus's Remark 4.16 ([extraction](https://arxiv.org/abs/2311.02404) L4657–4664), rederived.

## 4. $V_{1/2}$ lies in the orbit tangent space (claim 5)

Let $S=\mathbb Ru\oplus T_u\mathcal O$. By §3, $S$ is $F_u$-invariant ($u\in V_1$, $T_u\mathcal O\subseteq V_{1/2}$). $F_u$ is self-adjoint, so $S^\perp=u^\perp\cap(T_u\mathcal O)^\perp$ is $F_u$-invariant as well, and $F_u$ commutes with the orthogonal projections onto $S$ and $S^\perp$.

Take $x\in V_{1/2}$ and write $x=au+t+v$ with $a\in\mathbb R$, $t\in T_u\mathcal O$, $v\in S^\perp$. Projecting $F_ux=\tfrac12\theta^*x$:

- onto $S^\perp$: $F_uv=\tfrac12\theta^*v$. If $v\ne0$, then $V=v/\|v\|$ is a unit vector in $u^\perp\cap(T_u\mathcal O)^\perp$ with $\langle F_uV,V\rangle/\theta^*=\tfrac12>\tfrac13$, contradicting H4. So $v=0$.
- onto $\mathbb Ru$ (note $u\perp T_u\mathcal O$, since $\langle u,A\!\cdot\!u\rangle=0$ by skewness): $a\theta^*=\tfrac12a\theta^*$, and $\theta^*=\sqrt{3/2}\ne0$, so $a=0$.

Hence $x=t\in T_u\mathcal O$ and $V_{1/2}=T_u\mathcal O$. This agrees with Passage C's $\mathrm{mult}(+\tfrac12)=\dim\mathcal O$ and with Remark 4.16's identification of the tangent space with the summand of Theorem 4.14(b), but it needs neither: H2, H3 and H4 suffice.

## 5. The step (claim 6)

$T_u\mathcal O$ is the image of the linear map $A\mapsto A\!\cdot\!u$, so every $x\in V_{1/2}$ equals $A\!\cdot\!u$ for a single $A\in\mathfrak{so}(n)$ (no sum of tangent vectors is needed). Then, by §2 with $y=x$ and $\lambda=\mu=\tfrac12$,

$$P(x)=T(x,x,x)=T(x,x,A\!\cdot\!u)=(\tfrac12-\tfrac12)\,\theta^*\langle A\!\cdot\!x,x\rangle=0.$$

Directly: $T(x,x,A\!\cdot\!u)=-2T(A\!\cdot\!x,x,u)=-2\cdot\tfrac12\theta^*\langle A\!\cdot\!x,x\rangle=0$. So $P\equiv0$ on $V_{1/2}$ at every $n\ge9$.

**Arguing the opposite.** A failure would need some $x\in V_{1/2}$ that is not of the form $A\!\cdot\!u$, for then $T(x,x,x)$ has no reason to vanish (the identity only controls $T(x,y,\cdot)$ against orbit directions). §4 excludes such $x$ at $n\ge9$: any component of $x$ outside $S$ would be a $\tfrac12$-eigenvector transverse to the orbit, which L21 forbids. The quantifier "for every $x\in V_{1/2}$" is therefore met in full.

## 6. Scope and the unwritten hypotheses (claim 7)

- **Criticality is used.** Passage A says its argument "never uses criticality of $u$". That is true of the identity (§2) and false of the step: §3 needs $Q(u)=\theta^*u$ to put the orbit tangent into $V_{1/2}$, and §4 needs that invariance to split $x$. The step is "It also gives", so the sentence reads as inheriting "with no hypothesis". It inherits H2 and H4 instead.
- **Dimension.** Passage A's paragraph says "in every dimension" of the identity. The step's inputs H2 and H4 are supplied by the passages only at $n\ge9$ (Theorem 4.14 and Lemma L21). At $5\le n\le8$ the passages give neither $V_{1/2}=T_u\mathcal O$ nor the transverse bound, so the step is not established there by this argument. Settling it there would need the spectrum of $F_u$ at those $n$ (Nienhaus's Remark 4.12 supplies the decomposition), specifically whether a $\tfrac12\theta^*$-eigenvector exists in $u^\perp\cap(T_u\mathcal O)^\perp$. That is a representation-theoretic question with an exact answer. I did not pursue it because the brief's $u$ is L21's, defined at $n\ge9$.
- **Unnormalised label.** If $V_{1/2}$ were read as $\ker(F_u-\tfrac12)$, the normalised eigenvalue would be $1/(2\theta^*)=1/\sqrt6$. On $S$ the normalised eigenvalues are $1$ and $\tfrac12$, and on $S^\perp$ they are at most $\tfrac13$ by H4. Since $1/6>1/9$, $\tfrac13<1/\sqrt6<\tfrac12$, so this space is $\{0\}$ and $P\equiv0$ on it trivially. The step holds under either label.

## 7. Verdict

**VALID**, for $n\ge9$, under H0 (symmetric, $SO(n)$-invariant $T$ with $T(u,x,y)=\langle F_ux,y\rangle$), H1 (labels in units of $\theta^*$), H2 ($Q(u)=\theta^*u$, from Theorem 4.14(a)), H3 ($n\ge9$) and H4 (Lemma L21). The mechanism is $V_{1/2}=T_u(SO(n).u)$, which makes every $x\in V_{1/2}$ an orbit direction $A\!\cdot\!u$, so the identity at $\lambda=\mu$ gives $P(x)=0$. The paragraph's "in every dimension, with no hypothesis, never using criticality" belongs to the identity and does not transfer to this step, which uses criticality and L21's range.
