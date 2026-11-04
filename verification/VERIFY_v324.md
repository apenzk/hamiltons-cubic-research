# Verifier v324, L101 step B2: whether $T(x,y,[\rho(A),u])$ attains $0.91$ off the diagonal

The brief [ADJ_L101_B2.md](ADJ_L101_B2.md) was taken cold. No numerical work was done and no scripts were written. Every value below is exact. The log is [agent_logs/verify-L101-v324.log](../agent_logs/verify-L101-v324.log).

| # | Claim | Verdict |
|---|---|---|
| 1 | The general form $T(x,y,[\rho(A),u])=(\lambda-\mu)\theta^*\langle A\cdot x,y\rangle$ for $x\in V_\lambda$, $y\in V_\mu$, with eigenvalues written as $F_ux=\lambda\theta^*x$ | CONFIRMED AS ALGEBRA |
| 2 | The form vanishes on the diagonal $\lambda=\mu$ | CONFIRMED |
| 3 | The form is nonzero for some $\lambda\ne\mu$, $x\in V_\lambda$, $y\in V_\mu$, $A\in\mathfrak{so}(n)$ | CONFIRMED |
| 4 | The step as posed: the value $0.91$ is attained for some such $x,y,A$ | CONFIRMED |
| 5 | $0.91$ as the largest value of the form as the passages define it (no normalisation) | REFUTED AS STATED |
| 6 | $0.91$ as the largest value over unit $x,y$ and a normalised $A$ | UNRESOLVED, needs computation and a stated norm on $\mathfrak{so}(n)$ |

**Summary: the step is VALID, because the form is bilinear in $(x,y)$ and nonzero off the diagonal, so it attains every real number, $0.91$ included, which also makes the figure carry no information until a normalisation is stated.**

## 0. Conventions, fixed once

- $\mathcal W_n$ is the space of algebraic Weyl tensors on $\mathbb R^n$, read as symmetric operators on $\Lambda^2\mathbb R^n$, with the Frobenius inner product $\langle X,Y\rangle=\mathop{\mathrm{tr}}(XY)$.
- $SO(n)$ acts by $g\cdot W=\rho(g)W\rho(g)^{-1}$, and $A\in\mathfrak{so}(n)$ acts by $A\cdot W=[\rho(A),W]$.
- $Q(W)=W^2+W^\#$ (projected to $\mathcal W_n$), $X\circ Y=\tfrac12(Q(X+Y)-Q(X)-Q(Y))$, $T(X,Y,Z)=\langle X\circ Y,Z\rangle$, $P(W)=\langle W,Q(W)\rangle$.
- $u=W_{\mathbb{CP}^2}$ padded, $|u|=1$, $\theta^*=P(u)=\sqrt{3/2}$, $F_u(h)=\tfrac12(uh+hu)+u\#h$.
- $V_\lambda$ is an eigenspace of $F_u$ on $\mathcal W_n$, as the brief's definitions fix it. Eigenvalues are recorded in units of $\theta^*$, so $F_ux=\lambda\theta^*x$ for $x\in V_\lambda$. This is the convention of Passage C ($F_uW_1=\tfrac13\theta^*W_1$, multiplicities of $+1$ and $+\tfrac12$) and the only one under which the displayed general form carries its factor $\theta^*$. Write $\hat\lambda=\lambda\theta^*$ for the actual eigenvalue.
- $n\ge9$ as in Passage D.

## Hypothesis inventory

- **H1.** $T$ is fully symmetric and $SO(n)$-invariant (Passage B for symmetry, Section 1 for invariance).
- **H2.** The $SO(n)$ action on $\mathcal W_n$ is Frobenius-orthogonal, so $A\cdot$ is skew.
- **H3.** $\mathcal W_n$ is an irreducible, nontrivial $SO(n)$-module for $n\ge5$. This is the standard decomposition of algebraic curvature tensors (Besse, Einstein Manifolds, Chapter 1, Section G). It covers $n\ge9$.
- **H4.** $\theta^*=P(u)\ne0$ (given as $\sqrt{3/2}$).
- **H5, units.** Eigenvalues labelled in units of $\theta^*$. The derivation line of Passage A writes $F_ux=\lambda x$, the unnormalised convention, under which the general form reads $(\lambda-\mu)\langle A\cdot x,y\rangle$ with no $\theta^*$. The step's truth is the same under either convention.
- **H6, notation.** $V_\lambda$ is an $F_u$-eigenspace. [conventions.md](../findings/conventions.md) line 64 uses $V_\lambda$ for an $SO(n-4)$-irreducible in the isotypic splitting $M_\lambda\otimes V_\lambda$. The brief fixes the eigenspace reading, and this report adopts it.
- Criticality of $u$ ($Q(u)=\theta^*u$) is used only in the explicit witness of Remark 3.4, and the main argument proceeds without it.

## 1. Invariance of $T$ and the derivative identity

For $g\in SO(n)$, $(gWg^{-1})^2=gW^2g^{-1}$, and $\#$ is built from the structure constants of $\mathfrak{so}(n)$, which are $\mathrm{Ad}$-invariant, so $(g\cdot W)^\#=g\cdot W^\#$. The projection to $\mathcal W_n$ commutes with $SO(n)$. Hence $Q(g\cdot W)=g\cdot Q(W)$, the product $\circ$ is equivariant, and with the invariant Frobenius product $T(g\cdot X,g\cdot Y,g\cdot Z)=T(X,Y,Z)$.

Differentiating along $g_t=\exp(tA)$ at $t=0$:

$$T(A\cdot x,y,z)+T(x,A\cdot y,z)+T(x,y,A\cdot z)=0.$$

Skewness (H2): for symmetric $X,Y$ and skew $R=\rho(A)$, $\langle[R,X],Y\rangle=\mathop{\mathrm{tr}}(RXY)-\mathop{\mathrm{tr}}(RYX)$ and $\langle X,[R,Y]\rangle=\mathop{\mathrm{tr}}(RYX)-\mathop{\mathrm{tr}}(RXY)$, which sum to zero.

## 2. The general form (claims 1 and 2)

**2.1.** Polarising $Q$: $Q(X+Y)-Q(X)-Q(Y)=XY+YX+2X\#Y$, so $X\circ Y=\tfrac12(XY+YX)+X\#Y$ and $F_u(h)=u\circ h$. Therefore $\langle F_uX,Y\rangle=T(u,X,Y)$, symmetric in $X,Y$ by H1, so $F_u$ is self-adjoint and $\mathcal W_n=\bigoplus_\lambda V_\lambda$ orthogonally. Also $F_uu=u\circ u=Q(u)$, so $\langle F_uu,u\rangle=P(u)=\theta^*$.

**2.2.** Put $z=u$ in Section 1 and use full symmetry. For $x\in V_\lambda$, $y\in V_\mu$:

$$T(x,y,A\cdot u)=-T(u,A\cdot x,y)-T(u,x,A\cdot y)=-\langle A\cdot x,F_uy\rangle-\langle F_ux,A\cdot y\rangle=-\hat\mu\langle A\cdot x,y\rangle-\hat\lambda\langle x,A\cdot y\rangle.$$

By skewness $\langle x,A\cdot y\rangle=-\langle A\cdot x,y\rangle$, so

$$T(x,y,[\rho(A),u])=(\hat\lambda-\hat\mu)\langle A\cdot x,y\rangle=(\lambda-\mu)\,\theta^*\langle A\cdot x,y\rangle.$$

This is the displayed general form under H5. At $\lambda=\mu$ the prefactor is $0$, for every $x,y\in V_\lambda$, which is claim 2. No criticality of $u$ enters.

## 3. Attainment of $0.91$ (claims 3 and 4)

**3.1. $F_u$ is not a scalar.** From $T(g\cdot u,h,k)=T(u,g^{-1}\cdot h,g^{-1}\cdot k)$ one gets $F_{g\cdot u}=gF_ug^{-1}$, so $u\mapsto\mathop{\mathrm{tr}}F_u$ is a linear $SO(n)$-invariant functional on $\mathcal W_n$. It equals $\langle u,w_0\rangle$ for an invariant $w_0\in\mathcal W_n$, and H3 forces $w_0=0$. Hence $\mathop{\mathrm{tr}}F_u=0$. If $F_u=c\,\mathrm{Id}$ then $c\dim\mathcal W_n=0$, so $c=0$ and $\theta^*=\langle F_uu,u\rangle=0$, contradicting H4. So $F_u$ has at least two distinct eigenvalues. (Passage C gives the same conclusion from the multiplicities of $+1$ and $+\tfrac12$.)

**3.2. Some eigenspace is moved off itself.** Take any eigenvalue $\lambda$. Then $V_\lambda$ is a nonzero proper subspace by 3.1. If $A\cdot V_\lambda\subseteq V_\lambda$ for every $A\in\mathfrak{so}(n)$, then $V_\lambda$ is invariant under $\exp(\mathfrak{so}(n))$, which generates the connected group $SO(n)$, contradicting H3. So there are $A\in\mathfrak{so}(n)$ and $x\in V_\lambda$ with $A\cdot x\notin V_\lambda$. Decompose $A\cdot x=\sum_\nu w_\nu$ with $w_\nu\in V_\nu$. Some $\mu\ne\lambda$ has $w_\mu\ne0$. Put $y=w_\mu$. By orthogonality $\langle A\cdot x,y\rangle=|w_\mu|^2>0$.

**3.3. The value.** By Section 2 the form at $(x,y,A)$ equals $\tau=(\lambda-\mu)\theta^*|w_\mu|^2\ne0$. Replace $x$ by $x'=\tfrac{91}{100\,\tau}\,x\in V_\lambda$. Bilinearity gives

$$T(x',y,[\rho(A),u])=\tfrac{91}{100\,\tau}\,\tau=\tfrac{91}{100}=0.91$$

exactly. Replacing $0.91$ by any real $r$ gives $r$ the same way. So the set of values off the diagonal is all of $\mathbb R$, which is claim 3 and the step, claim 4.

**3.4. Remark, an explicit witness under criticality.** If $u$ is critical, $Q(u)=\theta^*u$, so $u\in V_1$. Differentiating $Q(g_t\cdot u)=\theta^*g_t\cdot u$ gives $2\,u\circ(A\cdot u)=\theta^*A\cdot u$, that is $A\cdot u\in V_{1/2}$. Since $u\ne0$ and H3 leaves no nonzero invariant vector, some $A$ has $A\cdot u\ne0$. With $x=u$, $y=A\cdot u$ the general form gives $(1-\tfrac12)\theta^*|A\cdot u|^2=\tfrac12\theta^*|A\cdot u|^2$, and the direct evaluation $T(u,A\cdot u,A\cdot u)=\langle F_u(A\cdot u),A\cdot u\rangle=\tfrac12\theta^*|A\cdot u|^2$ agrees. Scaling $A$ by $t>0$ multiplies this by $t^2$ and reaches $0.91$.

## 4. The reading of $0.91$ as a maximum (claims 5 and 6)

**4.1. Unnormalised.** "Reaching $0.91$" read as the largest value fails as stated, because by 3.3 the supremum over the objects as the passages define them is $+\infty$. The line in Passage A that fails under this reading is "vanishing on the diagonal and reaching $0.91$ off it".

**4.2. Normalised.** The strongest contentful reading is

$$\sup\big\{\,|(\lambda-\mu)\theta^*\langle A\cdot x,y\rangle|\ :\ \lambda\ne\mu,\ x\in V_\lambda,\ y\in V_\mu,\ |x|=|y|=1,\ \|A\|=1\big\}=0.91 .$$

The passages name no norm on $\mathfrak{so}(n)$, and the answer depends on the choice. For the witness of 3.4 with $x=u$ and $y=A\cdot u/|A\cdot u|$, the value is $\tfrac12\theta^*|A\cdot u|$, homogeneous of degree one in $A$. The matrix norm $\mathop{\mathrm{tr}}(A^{\mathsf T}A)^{1/2}$ on $\mathbb R^n$ and the Frobenius norm of $\rho(A)$ on $\Lambda^2\mathbb R^n$ differ by the exact factor $\sqrt{n-2}$ (the Dynkin index of $\Lambda^2$ relative to the vector representation, $\mathop{\mathrm{tr}}_{\Lambda^2}\rho(A)^{\mathsf T}\rho(A)=(n-2)\mathop{\mathrm{tr}}A^{\mathsf T}A$), and the half-trace convention differs by $\sqrt2$. A single decimal with no $n$ attached cannot hold under both of the first two norms for every $n\ge9$. The passages also give no witness $(x,y,A)$ and no closed form for the supremum.

**4.3. What would settle it.** Fix the norm on $\mathfrak{so}(n)$ and $n$. The exact quantity is $\max_{\lambda\ne\mu}|\lambda-\mu|\,\theta^*\,\sigma_{\lambda\mu}$ with $\sigma_{\lambda\mu}=\max_{\|A\|=1}\|\pi_\mu\,\mathrm{ad}_{\rho(A)}\,\iota_\lambda\|_{\mathrm{op}}$, where $\iota_\lambda$ is the inclusion of $V_\lambda$ and $\pi_\mu$ the orthogonal projection to $V_\mu$. Its value equal to $\tfrac{91}{100}$ to two places would confirm the normalised reading, and any other value would refute it. It needs the spectrum and eigenspaces of $F_u$ at $u=W_{\mathbb{CP}^2}$, which is computation outside this brief.

## 5. Verdict for the step

**VALID.** The step as the brief poses it, that $T(x,y,[\rho(A),u])$ attains $0.91$ for some $x\in V_\lambda$, $y\in V_\mu$, $\lambda\ne\mu$ and some $A$, holds exactly, with hypotheses H1 to H4 (symmetry and invariance of $T$, orthogonality of the action, irreducibility of $\mathcal W_n$ for $n\ge5$, and $\theta^*\ne0$), with H5 fixing the units of the general form and H6 fixing $V_\lambda$ as an eigenspace. The attainment is a consequence of bilinearity, so every real value is attained. Read as a maximum, the figure is REFUTED AS STATED without a normalisation, and UNRESOLVED with one until a norm on $\mathfrak{so}(n)$ is named and the quantity of 4.3 is computed.
