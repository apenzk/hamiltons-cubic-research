# Verifier v323, L101 step B2: the general form attains 0.91 off the diagonal

The brief ([ADJ_L101_B2.md](ADJ_L101_B2.md)) was read cold. No numerical work was done and no scripts were written. Every value below is exact, and the decimal $0.91$ enters only as the rational $91/100$. The log is [agent_logs/verify-L101-v323.log](../agent_logs/verify-L101-v323.log).

| # | Claim | Verdict |
|---|---|---|
| 1 | $T(X,Y,u)=\langle F_uX,Y\rangle$ for $X,Y\in\mathcal W_n$, from Passage B's $\circ$ and Passage D's $F_u$ | CONFIRMED |
| 2 | The general form $T(x,y,[\rho(A),u])=(\lambda-\mu)\theta^*\langle A\cdot x,y\rangle$ holds for $x\in V_\lambda$, $y\in V_\mu$ when $V_\lambda$ means $F_ux=\lambda\theta^*x$ (Passage C's convention) | CONFIRMED |
| 3 | The form is off-diagonally nonzero: $x=u\in V_1$, $y=[\rho(A),u]\in V_{1/2}$ gives $\tfrac12\theta^*\lvert[\rho(A),u]\rvert^2>0$ | CONFIRMED |
| 4 | The step as the brief states it: the value $91/100$ is attained for some $x\in V_\lambda$, $y\in V_\mu$, $\lambda\ne\mu$, and some $A$ | CONFIRMED |
| 5 | "Reaching $0.91$" read as the supremum of the unnormalised form | REFUTED AS STATED (the supremum is $+\infty$) |
| 6 | "Reaching $0.91$" read as the maximum over unit $x$, $y$ and a unit $A$ | UNRESOLVED (the passages fix no norm on $A$, and the value needs the exact quantity named in section 5) |

**Summary: the step as posed is VALID, by homogeneity of the form and one explicit off-diagonal witness, and $0.91$ carries no information beyond "nonzero" under any normalisation the passages define.**

## 0. Conventions, fixed once

- $\mathcal W_n$ carries the Frobenius product $\langle X,Y\rangle=\operatorname{tr}(XY)$ on symmetric operators of $\Lambda^2\mathbb R^n$.
- $Q(W)=W^2+W^\#$ with $W^\#=W\#W$ for a symmetric bilinear $\#$, so polarisation gives $X\circ Y=\tfrac12(XY+YX)+X\#Y$. Where $Q$ is followed by orthogonal projection onto $\mathcal W_n$, pairing with an element of $\mathcal W_n$ removes the projection, and $F_u$ is read as the projected operator $h\mapsto\pi_{\mathcal W_n}\big(\tfrac12(uh+hu)+u\#h\big)$ on $\mathcal W_n$.
- $A\in\mathfrak{so}(n)$ acts by $A\cdot X=[\rho(A),X]$ with $\rho(A)$ skew on $\Lambda^2\mathbb R^n$. The first display's $[A,u]$ is the same object as $[\rho(A),u]$.
- $V_\lambda=\{x\in\mathcal W_n: F_ux=\lambda\theta^*x\}$, the normalisation of Passage C, where $F_uW_1=\tfrac13\theta^*W_1$ defines $V_{1/3}$ and $\mathrm{mult}(+1)$, $\mathrm{mult}(+\tfrac12)$ are counted on this scale. Under the unnormalised convention $F_ux=\lambda x$ the factor $\theta^*$ drops from the general form, and nothing below changes.
- $\mathcal O=SO(n).u$ and $T_u\mathcal O=\{A\cdot u: A\in\mathfrak{so}(n)\}$.

## Hypothesis inventory

- **H1** (given, Passage B) $T$ is fully symmetric on $\mathcal W_n$.
- **H2** (standard) $T$ is $SO(n)$-invariant. $Q(g\cdot W)=g\cdot Q(W)$ because conjugation by an orthogonal $\rho(g)$ respects products and the $\#$ construction, and the Frobenius product is conjugation-invariant.
- **H3** (given, Passage D and C) $u$ is the padded $W_{\mathbb{CP}^2}$ of unit norm with $\theta^*=P(u)=\sqrt{3/2}\ne0$, and $n\ge9$ (the dimensions in play are $n=10,12,14,16$).
- **H4** (given, Passage C, a theorem via Nienhaus Theorem 4.14 and Remark 4.16) $\mathrm{mult}(+1)=1$ and $\mathrm{mult}(+\tfrac12)=\dim\mathcal O>0$. Section 4 gives a second witness that uses only H1, H2, H3 and irreducibility of $\mathcal W_n$, so H4 can be dropped.
- **H5** (the reading) $x$, $y$ and $A$ are unconstrained in norm, which is how the passages and the brief's step define them.

## 1. The form $T(\cdot,\cdot,u)$ is the quadratic form of $F_u$

For $X,Y\in\mathcal W_n$, $\langle\tfrac12(XY+YX),u\rangle=\tfrac12\big(\operatorname{tr}(XYu)+\operatorname{tr}(YXu)\big)$ and $\langle\tfrac12(uX+Xu),Y\rangle=\tfrac12\big(\operatorname{tr}(uXY)+\operatorname{tr}(XuY)\big)$. Cyclicity gives $\operatorname{tr}(XYu)=\operatorname{tr}(uXY)$ and $\operatorname{tr}(YXu)=\operatorname{tr}(XuY)$, so the two agree.

The $\#$ part is symmetric under permutation of the three slots by H1, so $\langle X\#Y,u\rangle=\langle u\#X,Y\rangle$. Hence $T(X,Y,u)=\langle F_uX,Y\rangle$, and $F_u$ is symmetric because $T$ is. Claim 1 is CONFIRMED.

## 2. The general form

Differentiating $T(g\cdot x,g\cdot y,g\cdot z)=T(x,y,z)$ along $g=\exp(tA)$ at $t=0$ (H2) gives $T(A\cdot x,y,z)+T(x,A\cdot y,z)+T(x,y,A\cdot z)=0$.

The derivation $X\mapsto[a,X]$ with $a=\rho(A)$ skew maps symmetric operators to symmetric operators, and it is Frobenius-skew: $\langle[a,X],Y\rangle=\operatorname{tr}(aXY)-\operatorname{tr}(aYX)=-\langle X,[a,Y]\rangle$.

Take $z=u$, $x\in V_\lambda$, $y\in V_\mu$. By section 1 and symmetry of $F_u$,

$$T(x,y,A\cdot u)=-\langle F_u(A\cdot x),y\rangle-\langle F_ux,A\cdot y\rangle=-\mu\theta^*\langle A\cdot x,y\rangle-\lambda\theta^*\langle x,A\cdot y\rangle=(\lambda-\mu)\theta^*\langle A\cdot x,y\rangle.$$

Claim 2 is CONFIRMED. The derivation uses neither criticality of $u$ nor any spectral information, as Passage A says.

## 3. An explicit off-diagonal witness, and the value $91/100$

**The witness.** By H4, $V_1=\mathbb Ru$ and $V_{1/2}=T_u\mathcal O$. Directly, criticality of $u$ for $P$ on the unit sphere of $\mathcal W_n$ gives $\pi Q(u)=\theta^*u$, so $F_uu=\pi Q(u)=\theta^*u$ and $u\in V_1$. Differentiating $\pi Q(\exp(tA)\cdot u)=\exp(tA)\cdot\theta^*u$ at $t=0$ gives $2F_u(A\cdot u)=\theta^*A\cdot u$, so $A\cdot u\in V_{1/2}$.

Fix $A_0$ with $A_0\cdot u\ne0$. Such $A_0$ exists because $\dim\mathcal O>0$ by H4, or because a vector fixed by all of $\mathfrak{so}(n)$ is $SO(n)$-fixed and $\mathcal W_n$ has no nonzero invariant vectors. With $x=u$ ($\lambda=1$), $y=A_0\cdot u$ ($\mu=\tfrac12$) and $A=A_0$, section 2 gives

$$T(u,A_0\cdot u,A_0\cdot u)=\tfrac12\theta^*\lvert A_0\cdot u\rvert^2>0,$$

and section 1 confirms it independently, since $T(u,y,y)=\langle F_uy,y\rangle=\tfrac12\theta^*\lvert y\rvert^2$. Claim 3 is CONFIRMED.

**The value.** Replace $A_0$ by $tA_0$ with $t>0$. The quantity becomes $\tfrac12\theta^*t^2\lvert A_0\cdot u\rvert^2$, since $y$ and the third slot both scale by $t$. Choose

$$t^2=\frac{91}{50}\sqrt{\tfrac23}\,\lvert A_0\cdot u\rvert^{-2},\qquad\text{so that}\qquad \tfrac12\sqrt{\tfrac32}\cdot\tfrac{91}{50}\sqrt{\tfrac23}=\tfrac{91}{100}.$$

Equivalently, keep $A=A_0$ and scale $y$ alone, the form being linear in $y$. Either way the value $91/100$ is attained with $\lambda=1\ne\tfrac12=\mu$. Claim 4 is CONFIRMED.

## 4. A witness free of H4 and of criticality

Suppose the form vanished for every $\lambda\ne\mu$, every $x\in V_\lambda$, $y\in V_\mu$ and every $A$. Then $\langle A\cdot x,y\rangle=0$ whenever $\lambda\ne\mu$, so $A\cdot V_\lambda\subseteq V_\lambda$ for every eigenspace. Every eigenspace is then $SO(n)$-stable (the group is connected), so $F_u$ commutes with the action.

$\mathcal W_n$ is an absolutely irreducible real representation of $SO(n)$ for $n\ge5$, so Schur's lemma gives $F_u=c\,\mathrm{Id}$. Then $T(u,X,Y)=c\langle X,Y\rangle$ for all $X,Y$, and by invariance $T(g\cdot u,X,Y)=T(u,g^{-1}X,g^{-1}Y)=c\langle X,Y\rangle$. Linearity in the first slot extends this to the span of $\mathcal O$, which is $\mathcal W_n$ by irreducibility. Taking $v$ and $-v$ forces $c=-c$, so $c=0$ and $T\equiv0$. That contradicts $T(u,u,u)=P(u)=\theta^*=\sqrt{3/2}\ne0$.

So some off-diagonal triple gives a nonzero value $\kappa$, and scaling $y$ by $\tfrac{91}{100}\kappa^{-1}$ gives $91/100$. This reaches claim 4 from H1, H2, H3 and irreducibility alone.

## 5. Arguing the opposite: readings under which "reaching $0.91$" fails or is unsettled

**Supremum of the unnormalised form.** "Reaching" can be read as "attaining its largest value". With $x$, $y$, $A$ free, section 3's family $t\mapsto\tfrac12\theta^*t^2\lvert A_0\cdot u\rvert^2$ is unbounded, so the supremum is $+\infty$ and no finite ceiling of $0.91$ exists. Claim 5 is REFUTED AS STATED. This reading contradicts the brief's own formulation ("attains the value $0.91$ for some"), so it does not govern the verdict.

**Normalised maximum.** The author may have meant $\max$ over unit $x\in V_\lambda$, unit $y\in V_\mu$, $\lambda\ne\mu$, and $A$ of unit norm. The passages fix no norm on $\mathfrak{so}(n)$ (the Frobenius norm of $A$ on $\mathbb R^n$ and that of $\rho(A)$ on $\Lambda^2\mathbb R^n$ differ by a factor depending on $n$), and they give no source for the number. Under this reading the exact quantity is

$$M_n=\theta^*\max_{\lambda\ne\mu}\;(\lambda-\mu)\max_{\substack{x\in V_\lambda,\;y\in V_\mu\\ \lvert x\rvert=\lvert y\rvert=1,\;\lVert A\rVert=1}}\langle[\rho(A),x],y\rangle,$$

which needs the full spectrum of $F_u$ (Passage C bounds the negative part only as $\mu_N\in[-1,-\tfrac16]$) and the $\mathfrak{so}(n)$-coupling between eigenspaces. A lower bound is available exactly from section 3: with $x=u$ and $y=A\cdot u/\lvert A\cdot u\rvert$ it gives $M_n\ge\tfrac12\theta^*\max_{\lVert A\rVert=1}\lvert[\rho(A),u]\rvert$. Deciding whether $M_n=0.91$ would require computing $M_n$ for the chosen norm, and a value different from $91/100$ would refute the decimal while leaving the general form, and claim 4, untouched. Claim 6 is UNRESOLVED.

## 6. Verdict for the step

**VALID.** The step as the brief poses it (the value $0.91$ is attained for some $x\in V_\lambda$, $y\in V_\mu$ with $\lambda\ne\mu$ and some $A$) holds under H1, H2, H3 and H5, with either H4 (section 3, witness $x=u$, $y=[\rho(A),u]$, value $\tfrac12\theta^*\lvert[\rho(A),u]\rvert^2$ scaled to $91/100$) or irreducibility of $\mathcal W_n$ for $n\ge5$ (section 4). The number $0.91$ is not special under this reading: every nonzero real is attained, and the substantive content is only that the form is not identically zero off the diagonal. A normalised reading of "reaching $0.91$" is not defined by the passages and would be UNRESOLVED pending the quantity $M_n$ of section 5.
