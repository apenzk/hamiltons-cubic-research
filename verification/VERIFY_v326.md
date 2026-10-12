# Verifier v326, the general form of L101's invariance identity and its factor $\theta^*$

The brief ([ADJ_L101_B3.md](ADJ_L101_B3.md)) was taken cold. No numerical work was done and no scripts were written. Every value below is exact. The log is [agent_logs/verify-L101-v326.log](../agent_logs/verify-L101-v326.log).

| # | Claim | Verdict |
|---|---|---|
| 1 | Differentiating the $SO(n)$-invariance of $T$ gives $T(A\cdot x,y,z)+T(x,A\cdot y,z)+T(x,y,A\cdot z)=0$ | CONFIRMED |
| 2 | For $F_ux=\lambda x$, $F_uy=\mu y$ (raw eigenvalues), $T(x,y,[\rho(A),u])=(\lambda-\mu)\langle A\cdot x,y\rangle$ | CONFIRMED |
| 3 | The step, $T(x,y,[\rho(A),u])=(\lambda-\mu)\,\theta^*\langle A\cdot x,y\rangle$ with $\lambda,\mu$ as in "$F_ux=\lambda x$" | REFUTED AS STATED |
| 4 | The same display with $\lambda,\mu$ read as normalised labels, $F_ux=\lambda\theta^*x$ (the subscripts of $V_{1/3}$, $V_{1/2}$, $V_1$) | CONFIRMED AS ALGEBRA |
| 5 | The general form vanishes on the diagonal $\lambda=\mu$ | CONFIRMED |

**Summary: under the meaning the brief fixes for $\lambda$ and $\mu$ the correct identity carries no $\theta^*$, so the step is off by the factor $\theta^*=\sqrt{3/2}$, and $x=u$, $y=[\rho(A),u]$ exhibits the discrepancy in closed form.**

## 0. Conventions, fixed once

- $\mathcal W_n$ is the space of algebraic Weyl tensors, read as symmetric operators on $\Lambda^2\mathbb R^n\cong\mathfrak{so}(n)$, with the Frobenius inner product $\langle\cdot,\cdot\rangle$.
- $Q(W)=W^2+W^\#$, $P(W)=\langle W,Q(W)\rangle$, $X\circ Y=\tfrac12(Q(X+Y)-Q(X)-Q(Y))$, $T(X,Y,Z)=\langle X\circ Y,Z\rangle$.
- For $A\in\mathfrak{so}(n)$ and $X\in\mathcal W_n$, $A\cdot X=[\rho(A),X]$. Passage A's $[A,u]$ is the same object as $[\rho(A),u]$.
- $u=W_{\mathbb{CP}^2}$ padded, unit, $\theta^*=P(u)=\sqrt{3/2}$, $F_u(h)=\tfrac12(uh+hu)+u\#h$.
- "Raw eigenvalue": $F_ux=\lambda x$. "Normalised label": $F_ux=\lambda\theta^*x$. The brief pins the raw meaning for the step.

## Hypothesis inventory

- **H1.** $Q$ is $SO(n)$-equivariant and the Frobenius product is $SO(n)$-invariant, so $T$ is $SO(n)$-invariant. Standard: conjugation respects products, and $\#$ is built from the structure constants of $\mathfrak{so}(n)$, which $\mathrm{Ad}$ preserves.
- **H2.** $\mathcal W_n$ is an $SO(n)$-invariant subspace, and $X\mapsto[\rho(A),X]$ is Frobenius-skew because $\rho(A)$ is skew. Standard.
- **H3.** $T$ is fully symmetric (Passage B, conventions line 24) and $u\circ h=F_u(h)$ on $\mathcal W_n$, with $F_u$ read as a map $\mathcal W_n\to\mathcal W_n$ (the Weyl projection understood if needed, which changes no inner product against $\mathcal W_n$). The identity $u\circ h=\tfrac12(uh+hu)+u\#h$ follows from the definition of $\circ$ and the symmetry of the bilinear $\#$.
- **H4.** $\lambda,\mu$ are raw eigenvalues. This is the brief's pinned reading, and it is the reading Passage A's own display uses, since "$-2T(A\cdot x,x,u)=-2\lambda\langle A\cdot x,x\rangle$" is correct only with $F_ux=\lambda x$.
- **H4'.** (Alternative, not the pinned one.) $\lambda,\mu$ are normalised labels, as in $V_{1/2}$ of the heading and $F_uW_1=\tfrac13\theta^*W_1$ for $W_1\in V_{1/3}$ in Passage C.
- **H5.** (Used only for the witness.) $F_uu=\theta^*u$, which is [Theorem 4.14(a)](../references/nienhaus-2023-second-best-einstein/notes.md) (eigenvalue $\sqrt{3/2}$ on $\langle W_{\mathbb{CP}^2}\rangle$), equivalently $Q(u)=\theta^*u$ since $u\circ u=Q(u)$.

## 1. The invariance identity (claim 1)

By H1, $T(g\cdot X,g\cdot Y,g\cdot Z)=T(X,Y,Z)$ for $g\in SO(n)$. Put $g=\exp(tA)$, so $g\cdot X=X+t\,A\cdot X+O(t^2)$ by H2. $T$ is trilinear, so the $t$-coefficient is $T(A\cdot X,Y,Z)+T(X,A\cdot Y,Z)+T(X,Y,A\cdot Z)$, and it vanishes. Claim 1 is CONFIRMED.

## 2. The correct general form (claim 2)

Take $x\in V_\lambda$, $y\in V_\mu$ with $F_ux=\lambda x$, $F_uy=\mu y$. Claim 1 with $z=u$ gives

$$T(x,y,A\cdot u)=-T(A\cdot x,y,u)-T(x,A\cdot y,u).$$

By full symmetry (H3), $T(X,Y,u)=\langle u\circ X,Y\rangle=\langle F_uX,Y\rangle$, and $F_u$ is self-adjoint on $\mathcal W_n$. $A\cdot x$ and $A\cdot y$ lie in $\mathcal W_n$ by H2. Hence

- $T(A\cdot x,y,u)=\langle A\cdot x,F_uy\rangle=\mu\langle A\cdot x,y\rangle$,
- $T(x,A\cdot y,u)=\langle F_ux,A\cdot y\rangle=\lambda\langle x,A\cdot y\rangle=-\lambda\langle A\cdot x,y\rangle$ by skewness (H2).

Therefore

$$T(x,y,[\rho(A),u])=(\lambda-\mu)\,\langle A\cdot x,y\rangle\qquad(F_ux=\lambda x,\ F_uy=\mu y).$$

No criticality of $u$ enters. Claim 2 is CONFIRMED. At $y=x$ this reproduces Passage A's first display, $-2\lambda\langle A\cdot x,x\rangle=0$, with raw $\lambda$ and no $\theta^*$.

## 3. The step against claim 2 (claim 3)

The step asserts $(\lambda-\mu)\theta^*\langle A\cdot x,y\rangle$ with the same raw $\lambda,\mu$. Subtracting claim 2, the step holds for a pair $(x,y)$ exactly when

$$(\theta^*-1)(\lambda-\mu)\langle A\cdot x,y\rangle=0.$$

Since $\theta^*-1=\sqrt{3/2}-1\neq0$, the step fails at every pair with $\lambda\ne\mu$ and $\langle A\cdot x,y\rangle\ne0$. The quoted line is "$T(x,y,[\rho(A),u])=(\lambda-\mu)\,\theta^*\langle A\!\cdot\!x,y\rangle\ (x\in V_\lambda,\;y\in V_\mu)$", read with "$F_ux=\lambda x$".

### 3.1 A closed-form witness

Under H5 take $x=u$, so $\lambda=\theta^*$. Differentiating $Q(g\cdot u)=g\cdot Q(u)$ along $\exp(tA)$, using that $Q$ is quadratic with polarisation $\circ$, gives $2\,u\circ(A\cdot u)=A\cdot Q(u)=\theta^*A\cdot u$, so

$$F_u(A\cdot u)=\tfrac12\theta^*\,A\cdot u.$$

This matches Theorem 4.14(b), eigenvalue $\tfrac12\sqrt{3/2}$ on the orbit directions. Take $y=A\cdot u$, so $\mu=\tfrac12\theta^*$, and choose $A$ with $A\cdot u\ne0$. Such $A$ exists: $\mathcal W_n$ is a nontrivial irreducible $SO(n)$-module for $n\ge5$, so it has no nonzero fixed vector, and Passage C's $\dim\mathcal O=26,34,42,50>0$ says the same. Then, exactly:

| Quantity | Value |
|---|---|
| Left side, $T(u,A\cdot u,A\cdot u)=\langle F_u(A\cdot u),A\cdot u\rangle$ | $\tfrac12\theta^*\,\lvert A\cdot u\rvert^2=\tfrac12\sqrt{3/2}\,\lvert A\cdot u\rvert^2$ |
| Claim 2, $(\lambda-\mu)\langle A\cdot u,A\cdot u\rangle$ | $\tfrac12\theta^*\,\lvert A\cdot u\rvert^2$, agrees |
| The step, $(\lambda-\mu)\theta^*\langle A\cdot u,A\cdot u\rangle$ | $\tfrac12\theta^{*2}\lvert A\cdot u\rvert^2=\tfrac34\lvert A\cdot u\rvert^2$ |

The step overstates the left side by the factor $\theta^*=\sqrt6/2$, and the difference $\tfrac12\theta^*(\theta^*-1)\lvert A\cdot u\rvert^2$ is strictly positive.

### 3.2 Nontriviality without H5

The failure is not confined to the witness. If $\langle A\cdot x,y\rangle=0$ for every $A$ and every pair of distinct eigenspaces, each $V_\lambda$ is $\mathfrak{so}(n)$-invariant, hence $SO(n)$-invariant, and irreducibility of $\mathcal W_n$ ($n\ge5$) forces $F_u=c\,\mathrm{Id}$. Then $Q(u)=u\circ u=cu$ with $c=\langle Q(u),u\rangle=\theta^*$, and the derivative argument of 3.1 gives $F_u(A\cdot u)=\tfrac12\theta^*A\cdot u\ne c\,A\cdot u$ for $A\cdot u\ne0$, a contradiction. So off-diagonal pairs with $\langle A\cdot x,y\rangle\ne0$ always exist, and Passage A's own "reaching $0.91$ off it" presupposes them.

### 3.3 The opposite case argued

The strongest defence is H4'. The heading names $V_{1/2}$, and Passage C writes $V_{1/3}$ for the space where $F_u=\tfrac13\theta^*$, so the record's eigenspace subscripts are normalised labels. With $F_ux=\lambda\theta^*x$ and $F_uy=\mu\theta^*y$, section 2's computation reads $(\lambda\theta^*-\mu\theta^*)\langle A\cdot x,y\rangle=(\lambda-\mu)\theta^*\langle A\cdot x,y\rangle$, which is the display exactly (claim 4, CONFIRMED AS ALGEBRA). That reading is, however, the one the brief excludes, and it is inconsistent with the sentence the brief pins: "since $F_u$ is symmetric with $F_ux=\lambda x$". Within Passage A the same letter $\lambda$ therefore changes meaning between the two displays, raw in the first and normalised in the second. The diagonal claim survives either reading, because both sides vanish at $\lambda=\mu$ (claim 5, CONFIRMED).

## 4. Verdict

**FAILS.** With $\lambda,\mu$ the raw eigenvalues fixed by "$F_ux=\lambda x$" (H4), the invariance identity gives $T(x,y,[\rho(A),u])=(\lambda-\mu)\langle A\cdot x,y\rangle$, and the displayed factor $\theta^*$ is spurious. The witness $x=u$, $y=[\rho(A),u]$ gives $\tfrac12\sqrt{3/2}\,\lvert A\cdot u\rvert^2$ against the step's $\tfrac34\lvert A\cdot u\rvert^2$.

- **Repair, either of:** delete $\theta^*$ from the display, or state that $\lambda,\mu$ in the general form are normalised labels ($F_u=\lambda\theta^*$ on $V_\lambda$), and change the first display's "$F_ux=\lambda x$" to match.
- **Hypotheses the repaired statement needs:** H1, H2, H3, and the chosen eigenvalue convention (H4 without $\theta^*$, or H4' with it). Criticality of $u$ is not needed for the identity itself.
