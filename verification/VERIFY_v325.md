# Verifier v325, the general form of the SO(n)-invariance identity in Lemma L101 (step B3)

This adjudication was done cold from [ADJ_L101_B3.md](ADJ_L101_B3.md). No numerical work was done and no scripts were written. Every value below is exact. The log is [agent_logs/verify-L101-v325.log](../agent_logs/verify-L101-v325.log).

| # | Claim | Verdict |
|---|---|---|
| C1 | $T$ is $SO(n)$-invariant, so $T(A\cdot x,y,z)+T(x,A\cdot y,z)+T(x,y,A\cdot z)=0$ | CONFIRMED |
| C2 | For $F_ux=\lambda x$, $F_uy=\mu y$ (raw eigenvalues), $T(x,y,[\rho(A),u])=(\lambda-\mu)\langle A\cdot x,y\rangle$, with no factor $\theta^*$ | CONFIRMED |
| C3 | The step: $T(x,y,[\rho(A),u])=(\lambda-\mu)\,\theta^*\langle A\cdot x,y\rangle$ with $\lambda,\mu$ read as in "$F_ux=\lambda x$" | REFUTED AS STATED |
| C4 | The same display with $\lambda,\mu$ read as normalised labels, $F_ux=\lambda\theta^*x$, $F_uy=\mu\theta^*y$, the convention of $V_{1/3}$, $V_{1/2}$ in Passage C | CONFIRMED |
| C5 | The form vanishes on the diagonal $\lambda=\mu$ | CONFIRMED |

**Summary: under the meaning the brief fixes ($F_ux=\lambda x$) the display carries a spurious factor $\theta^*=\sqrt{3/2}$ and fails at $x=u$, $y=[\rho(A),u]$, while under the normalised eigenvalue labels used for $V_{1/3}$ and $V_{1/2}$ it is exact.**

## 0. Conventions, fixed once

- $\mathcal W_n$ is the space of algebraic Weyl tensors as symmetric operators on $\Lambda^2\mathbb R^n$, with $\langle X,Y\rangle=\operatorname{tr}(XY)$.
- $\#$ is the record's halved Böhm–Wilking product, a symmetric bilinear map $\mathcal W_n\times\mathcal W_n\to\mathcal W_n$ with $W^\#=W\#W$ ([conventions.md](../findings/conventions.md) lines 75–79). $Q(W)=W^2+W^\#$.
- $X\circ Y=\tfrac12(Q(X+Y)-Q(X)-Q(Y))=\tfrac12(XY+YX)+X\#Y$, and $T(X,Y,Z)=\langle X\circ Y,Z\rangle$.
- $u=W_{\mathbb{CP}^2}$ padded, $\|u\|=1$, $\theta^*=P(u)=\sqrt{3/2}$, $F_u(h)=\tfrac12(uh+hu)+u\#h$. Comparing with the previous item, $F_u=u\circ(\cdot)=L_u$ exactly.
- $SO(n)$ acts by $g\cdot W=\rho(g)W\rho(g)^{\mathsf T}$. For $A\in\mathfrak{so}(n)$, $A\cdot X=[\rho(A),X]$, where $\rho(A)$ is skew. The first display's $[A,u]$ is the same object.
- **Raw eigenvalue** means $F_ux=\lambda x$. **Normalised label** means $F_ux=\lambda\theta^*x$. Nienhaus's Theorem 4.14 ([notes.md](../references/nienhaus-2023-second-best-einstein/notes.md) lines 66–75) states the raw values: $\sqrt{3/2}$ on $\langle u\rangle$, $\tfrac12\sqrt{3/2}$ on case (b), $\tfrac13\sqrt{3/2}$ on case (c). Passage C's $V_{1/3}$ with "$F_uW_1=\tfrac13\theta^*W_1$", its $\mathrm{mult}(+1)$ and $\mathrm{mult}(+\tfrac12)$, and $\mu_N=\langle FN,N\rangle/\theta^*$ all use normalised labels.

## Hypothesis inventory

- **H1 (full symmetry).** $T$ is symmetric in its three arguments, as Passage B asserts. Used as $T(X,Y,u)=\langle X,F_uY\rangle$.
- **H2 (equivariance of $Q$).** $Q(g\cdot W)=g\cdot Q(W)$ for $g\in SO(n)$. The square part is immediate from $\rho(g)$ orthogonal. The $\#$ part holds because the Böhm–Wilking product is built from the Lie bracket of $\mathfrak{so}(n)$ and the trace form, both $\mathrm{Ad}$-invariant. Standard.
- **H3 (invariance of the inner product).** $\langle g\cdot X,g\cdot Y\rangle=\langle X,Y\rangle$. Immediate from cyclicity of trace.
- **H4 (bilinear $\#$).** $W^\#=W\#W$ for the same symmetric bilinear $\#$ that appears in $F_u$, so that $F_u=L_u$. This is the record's convention.
- **H5 (reading of $\lambda,\mu$).** The brief fixes the raw reading. The valid alternative needs the normalised reading, which is the convention of the section's eigenspace labels but contradicts the sentence "$F_ux=\lambda x$".
- For the witness in Section 3 only: **H6**, Theorem 4.14(a), $F_uu=\theta^*u$, and **H7**, $u$ is not $SO(n)$-fixed, which holds because $\mathcal W_n$ is a nontrivial irreducible $SO(n)$-module for $n\ge5$ and $u\ne0$ (equivalently $\dim\mathcal O>0$, which Passage C records as $26,34,42,50$).

## 1. The infinitesimal invariance identity (C1)

By H2, $\circ$ is the polarisation of an equivariant quadratic map, so $g\cdot(X\circ Y)=(g\cdot X)\circ(g\cdot Y)$. With H3, $T(g\cdot X,g\cdot Y,g\cdot Z)=\langle g\cdot(X\circ Y),g\cdot Z\rangle=T(X,Y,Z)$. Put $g=\exp(tA)$ and differentiate at $t=0$. Since $\frac{d}{dt}\big|_0\exp(tA)\cdot X=[\rho(A),X]$ and $T$ is trilinear, the product rule gives $T(A\cdot x,y,z)+T(x,A\cdot y,z)+T(x,y,A\cdot z)=0$.

Two side facts used below. First, $[\rho(A),X]$ is symmetric when $X$ is: $(\rho(A)X-X\rho(A))^{\mathsf T}=-X\rho(A)+\rho(A)X$. It lies in $\mathcal W_n$ because it is the derivative of a curve in $\mathcal W_n$. Second, $A\cdot$ is Frobenius-skew: $\langle[\rho(A),X],Y\rangle=\operatorname{tr}(\rho(A)XY)-\operatorname{tr}(\rho(A)YX)$ and $\langle X,[\rho(A),Y]\rangle=\operatorname{tr}(\rho(A)YX)-\operatorname{tr}(\rho(A)XY)$, which is its negative.

## 2. The identity with raw eigenvalues (C2, C5)

Let $F_ux=\lambda x$ and $F_uy=\mu y$. Set $z=u$ in Section 1:

$$T(x,y,A\cdot u)=-T(A\cdot x,y,u)-T(x,A\cdot y,u).$$

By H1 and H4, $T(A\cdot x,y,u)=T(y,u,A\cdot x)=\langle y\circ u,A\cdot x\rangle=\langle F_uy,A\cdot x\rangle=\mu\langle A\cdot x,y\rangle$. Likewise $T(x,A\cdot y,u)=\langle F_ux,A\cdot y\rangle=\lambda\langle x,A\cdot y\rangle=-\lambda\langle A\cdot x,y\rangle$ by skewness. Hence

$$T(x,y,[\rho(A),u])=(\lambda-\mu)\,\langle A\cdot x,y\rangle\qquad(F_ux=\lambda x,\ F_uy=\mu y).$$

No criticality of $u$ enters. At $\lambda=\mu$ the right side is $0$, which is C5 and the passage's first display. That first display writes $T(A\cdot x,x,u)=\lambda\langle A\cdot x,x\rangle$, which is the raw reading, so the sentence "$F_ux=\lambda x$" and the first display agree with each other.

## 3. The step under the brief's reading fails (C3)

The step asserts $(\lambda-\mu)\theta^*\langle A\cdot x,y\rangle$. Section 2 proves the same expression without $\theta^*$. Since $\theta^*=\sqrt{3/2}\ne1$, the two agree exactly when $(\lambda-\mu)\langle A\cdot x,y\rangle=0$, so the step fails at any pair of eigenvectors with distinct eigenvalues and $\langle A\cdot x,y\rangle\ne0$. Such a pair exists, in closed form.

**Witness.** Take $x=u$ and $y=A\cdot u$ with $A\cdot u\ne0$ (H7). By H6, $F_uu=\theta^*u$, and $F_uu=u\circ u=Q(u)$, so $Q(u)=\theta^*u$. Differentiating $Q(\exp(tA)\cdot u)=\exp(tA)\cdot Q(u)$ at $t=0$ gives $2\,u\circ(A\cdot u)=\theta^*A\cdot u$, that is $F_u(A\cdot u)=\tfrac{\theta^*}2A\cdot u$. So $\lambda=\theta^*$ and $\mu=\theta^*/2$ in the raw sense.

- Left side, directly: $T(u,A\cdot u,A\cdot u)=\langle u\circ(A\cdot u),A\cdot u\rangle=\tfrac{\theta^*}2\|A\cdot u\|^2=\tfrac{\sqrt6}4\|A\cdot u\|^2$.
- Section 2's identity: $(\theta^*-\tfrac{\theta^*}2)\langle A\cdot u,A\cdot u\rangle=\tfrac{\sqrt6}4\|A\cdot u\|^2$. It agrees.
- The step, raw reading: $(\theta^*-\tfrac{\theta^*}2)\,\theta^*\,\|A\cdot u\|^2=\tfrac{(\theta^*)^2}2\|A\cdot u\|^2=\tfrac34\|A\cdot u\|^2$.

The ratio of the true value to the step's value is $\tfrac{\sqrt6/4}{3/4}=\sqrt{2/3}=1/\theta^*$, and $\|A\cdot u\|^2>0$. The failing line is the second display of Passage A, "$T(x,y,[\rho(A),u])=(\lambda-\mu)\,\theta^*\langle A\!\cdot\!x,y\rangle$", read with "$F_ux=\lambda x$" from the sentence above it.

**Arguing the opposite.** Could the factor $\theta^*$ be absorbed by a normalisation of $T$, $\circ$ or $F_u$ that makes the raw reading correct? It cannot. $F_u=L_u$ holds by the definitions in Passage B and Passage D with no scalar (H4). A different $\#$ normalisation would change only the $\#$ part of $F_u$ and $T$ together, and would not produce a uniform factor. The witness uses only $T$, $\circ$ and $F_u$ as defined, and the direct evaluation matches Section 2 rather than the step.

## 4. The step under the normalised reading holds (C4)

Write the eigenvalue equations as $F_ux=\lambda\theta^*x$ and $F_uy=\mu\theta^*y$. Section 2 with raw eigenvalues $\lambda\theta^*$ and $\mu\theta^*$ gives $T(x,y,[\rho(A),u])=(\lambda\theta^*-\mu\theta^*)\langle A\cdot x,y\rangle=(\lambda-\mu)\theta^*\langle A\cdot x,y\rangle$, which is the display exactly. This is the reading under which the heading's and Passage C's labels $V_{1/2}$, $V_{1/3}$, $\mathrm{mult}(+1)$ make sense, and at the witness it reads $(1-\tfrac12)\theta^*\|A\cdot u\|^2=\tfrac{\sqrt6}4\|A\cdot u\|^2$, matching Section 3. Under this reading the sentence "$F_ux=\lambda x$" and the first display's "$-2\lambda\langle A\cdot x,x\rangle$" would need $\lambda\theta^*$ in place of $\lambda$, which leaves their value $0$ unchanged.

The numeral "$0.91$ off it" is outside the step and was not checked.

## 5. Verdict

**FAILS** as the brief states the step. With $\lambda,\mu$ carrying the meaning of "$F_ux=\lambda x$", the correct identity is $T(x,y,[\rho(A),u])=(\lambda-\mu)\langle A\cdot x,y\rangle$ (H1–H4), and the display's extra $\theta^*=\sqrt{3/2}$ is refuted by $x=u$, $y=[\rho(A),u]$ (H6, H7), where the true value is $\tfrac{\sqrt6}4\|A\cdot u\|^2$ against the display's $\tfrac34\|A\cdot u\|^2$.

The display is VALID under the reading that $\lambda,\mu$ are normalised labels, $F_ux=\lambda\theta^*x$, which is the convention of $V_{1/3}$ and $V_{1/2}$ in the same section. That reading needs H1–H4 and the correction of the sentence "$F_ux=\lambda x$" to "$F_ux=\lambda\theta^*x$". The defect is a clash of eigenvalue conventions inside Passage A, and none of its conclusions that rest on $\lambda=\mu$ is affected.
