# Verifier v359, L115 step F1: lambda_max(M)=theta at every global maximiser

Cold brief ([ADJ_L115_F1.md](ADJ_L115_F1.md)). No numerical work, no scripts written, every value below is exact and derived by hand. Log: [agent_logs/verify-L115-v359.log](../agent_logs/verify-L115-v359.log).

| # | Claim | Verdict |
|---|---|---|
| 1 | $\theta$ is an eigenvalue of $M(\lambda)$ at every critical point, so $\lambda_{\max}(M)\ge\theta$ | CONFIRMED |
| 2 | $M(\lambda)=\tfrac16\operatorname{Hess}(P|_{\mathcal D})$, so $\lambda_{\max}(M)=\theta$ is equivalent to $\langle X,L_eX\rangle\le\|X\|^2$ on $\mathcal D$ | CONFIRMED AS ALGEBRA |
| 3 | Lemma L24 yields $\lambda_{\max}(M)\le\theta$ | REFUTED (the cap lives on $\mathcal W_n\cap W^\perp$, and $\mathcal D\not\subseteq\mathcal W_n$) |
| 4 | Step at $n=4$, every global maximiser, every eigenframe | CONFIRMED |
| 5 | Step at padded $W_{\mathbb{CP}^2}$, every $n\ge4$, every eigenframe | CONFIRMED (conditional on it being a global maximiser when $n\ge5$) |
| 6 | Step at every global maximiser for every $n$ (the heading) | REFUTED AS STATED as a proof step: nothing on the record or in standard mathematics establishes it for $n\ge5$, and no counterexample is known |
| 7 | By-product $\theta\ge\max_\alpha\lambda_\alpha$ at a global maximiser | CONFIRMED, unconditionally, by $\lambda_\alpha\le\|\lambda\|=1<\sqrt{3/2}\le M(n)$ |

**Summary: the heading's unrestricted claim FAILS as a step, because its only offered route transfers L24's cap off $\mathcal W_n$, while the conclusion itself is proven here at $n=4$ and at padded $W_{\mathbb{CP}^2}$ for every $n$ and stays open elsewhere.**

## 0. Conventions, fixed once

- $\Lambda^2\mathbb R^n\cong\mathfrak{so}(n)$ with $E_{ij}=e_ie_j^T-e_je_i^T$ ($i<j$) orthonormal and the matrix bracket, so $[E_{ij},E_{jk}]=E_{ik}$.
- For an orthonormal eigenframe $\{v_\alpha\}$ of $W$, $c_{\alpha\beta\gamma}=\langle[v_\alpha,v_\beta],v_\gamma\rangle$ is totally antisymmetric, and $c'^2_{\alpha\beta\gamma}:=c_{\alpha\beta\gamma}^2$ is totally symmetric. Then $(A^\#)_{\gamma\gamma}=\tfrac12\sum_{\alpha,\beta}c_{\alpha\beta\gamma}^2a_\alpha a_\beta$ for $A$ diagonal in the frame, matching Passage B.
- Normalisation check. In Section 3 the Λ+ basis $\omega_1=(E_{12}+E_{34})/\sqrt2$, $\omega_2=(E_{13}-E_{24})/\sqrt2$, $\omega_3=(E_{14}+E_{23})/\sqrt2$ gives $[\omega_1,\omega_2]=-(E_{14}+E_{23})=-\sqrt2\,\omega_3$, so $c^2=2$ on each triple. With this value $P(W_{\mathbb{CP}^2})=\sqrt{3/2}$ and $Q(W_{\mathbb{CP}^2})=\sqrt{3/2}\,W_{\mathbb{CP}^2}$ (Section 3), agreeing with the brief's stated value. So the convention is the brief's.
- $\mathcal D$ is the space of symmetric operators on $\Lambda^2$ diagonal in the chosen eigenframe. $X_x=\sum_\alpha x_\alpha v_\alpha v_\alpha^T$. $X\circ Y=\tfrac12(Q(X+Y)-Q(X)-Q(Y))$, $e=W/\theta$, $L_e=e\circ(\cdot)$.
- Where $W$ has a repeated eigenvalue, $M$ depends on the eigenframe. The strongest reading of the step is "for every eigenframe", and that is the reading tested.

## Hypothesis inventory

- **H0 (given).** $W$ is a unit global maximiser, so $Q(W)=\theta W$ with $\theta=P(W)=M(n)\ge\sqrt{3/2}$, and L24 holds at $W$.
- **H1.** $n=4$. Sufficient for VALID (Section 3).
- **H2.** $W$ is padded $W_{\mathbb{CP}^2}$. Sufficient for VALID at that point for every $n$ (Section 4). Whether H2 describes the global maximisers for $n\ge5$ is open and is not on the record.
- **H3.** $\langle Y,L_eY\rangle\le\|Y\|^2$ for all $Y\in\mathcal D\cap W^\perp$ at the maximiser. Equivalent to the step (Section 2), so it is the step restated. It follows from a cap on $L_e$ over $\mathcal D$'s component in $\mathcal W_n^\perp$ together with control of the cross term, which is the missing cap Passage A names.
- **Symmetry of the trilinear form.** $\langle X,Y\circ Z\rangle$ is totally symmetric, because it is the polarisation of the cubic form $P(X)=\langle X,Q(X)\rangle$ with $\langle X,Y\#Z\rangle$ totally symmetric. Standard (Böhm and Wilking). Used in Section 2.

## 1. Claim 1, $\theta$ is an eigenvalue

At a critical point $Q(W)=\theta W$. In the eigenframe $W=X_\lambda$, and $\theta W$ is diagonal with entries $\theta\lambda_\alpha$. The diagonal entries of $Q(W)$ are $\lambda_\alpha^2+\tfrac12\sum_{\beta,\gamma}c^2_{\alpha\beta\gamma}\lambda_\beta\lambda_\gamma=(M(\lambda)\lambda)_\alpha$. Hence $M\lambda=\theta\lambda$ and $\lambda_{\max}(M)\ge\theta$. CONFIRMED. The step's content is the reverse inequality $\lambda_{\max}(M)\le\theta$.

## 2. Claim 2, what the reverse inequality means

Put $F(x)=P(X_x)=\sum x_\alpha^3+\tfrac12\sum c^2_{\alpha\beta\gamma}x_\alpha x_\beta x_\gamma$. Then $\partial_\alpha\partial_\beta F=6\delta_{\alpha\beta}x_\alpha+3\sum_\gamma c^2_{\alpha\beta\gamma}x_\gamma=6M(x)_{\alpha\beta}$.

The same quadratic form, written invariantly, is $\langle x,M(\lambda)x\rangle=\langle W,X_x^2\rangle+\langle W,X_x^\#\rangle=\langle W,X_x\circ X_x\rangle=\theta\langle X_x,L_eX_x\rangle$.

So $\lambda_{\max}(M)=\theta\cdot\lambda_{\max}(\Pi_{\mathcal D}L_e|_{\mathcal D})$, and the step is $\langle X,L_eX\rangle\le\|X\|^2$ on $\mathcal D$. Write $X=aW+Y$ with $Y\in\mathcal D\cap W^\perp$. Since $L_eW=\theta^{-1}Q(W)=W$ and $L_e$ is self-adjoint, $\langle W,L_eY\rangle=\langle W,Y\rangle=0$, so $\langle X,L_eX\rangle=a^2+\langle Y,L_eY\rangle$. The step is therefore exactly H3. CONFIRMED AS ALGEBRA.

## 3. Claim 3, the L24 transfer

L24 gives $\langle Y,L_eY\rangle\le\tfrac12\|Y\|^2$ for $Y\in\mathcal W_n\cap W^\perp$ only. The step needs it (with constant 1) on $\mathcal D\cap W^\perp$.

Concrete witness that the two spaces differ. At padded $W_{\mathbb{CP}^2}$ on $\mathbb R^5$, $E_{15}$ lies in the zero eigenspace and can be a frame vector, so $X=E_{15}E_{15}^T\in\mathcal D$. It is the curvature operator of a single plane, which has $\operatorname{Ric}(e_1,e_1)\ne0$, so $X\notin\mathcal W_5$. Also $I\in\mathcal D\cap W^\perp$ in every frame and $I\notin\mathcal W_n$. A bound on a subspace constrains nothing off it, which is what [L115.lean](../lean/HamiltonsCubic/Results/L115.lean) records as cap_on_subspace_transfers_nothing. The inference is invalid, exactly as Passage A's own sentence "that is the step Lemma L115 grades a GAP" says. REFUTED.

Argue the opposite. Could global maximality over $\mathcal W_n$ still force H3? Decompose $Y=\pi_{\mathcal W}Y+Y'$ with $Y'$ in the scalar, trace-free Ricci and $\Lambda^4$ components. Then $\langle Y,L_eY\rangle=\langle\pi_{\mathcal W}Y,L_e\pi_{\mathcal W}Y\rangle+2\langle\pi_{\mathcal W}Y,L_eY'\rangle+\langle Y',L_eY'\rangle$. L24 bounds the first term by $\tfrac12\|\pi_{\mathcal W}Y\|^2$ only when $\pi_{\mathcal W}Y\perp W$, which holds since $\langle Y,W\rangle=0$. The other two terms involve $W\circ Y'$ for $Y'\notin\mathcal W_n$, on which neither L24 nor maximality over $\mathcal W_n$ says anything. The one structural fact available is $L_eI=0$ (Section 5), which removes the scalar direction and nothing else. No argument from the passages closes the Ricci and $\Lambda^4$ parts.

## 4. Claim 4, the case $n=4$ is VALID

**The maximisers.** $\mathcal W_4=\mathcal W^+\oplus\mathcal W^-$, $W=(A,B)$ with $A,B$ trace-free symmetric on $\Lambda^\pm\cong\mathfrak{so}(3)$, and $[\Lambda^+,\Lambda^-]=0$. So $Q(W)=(Q(A),Q(B))$ and $P(W)=P_3(A)+P_3(B)$. Diagonalise $A=\operatorname{diag}(a,b,c)$ by $SO(3)$, which $SO(4)$ induces on $\Lambda^+$. Any orthonormal basis of $\mathfrak{so}(3)$ has $c^2=2$ on its one triple (Section 0), so $P_3(A)=a^3+b^3+c^3+6abc=9abc$ using $a+b+c=0$.

With $a+b+c=0$ and $a^2+b^2+c^2=1$, the numbers $a,b,c$ are the roots of $t^3-\tfrac12t-abc$. Three real roots force the discriminant $4(\tfrac12)^3-27(abc)^2\ge0$, so $abc\le1/\sqrt{54}=1/(3\sqrt6)$, with equality iff the spectrum is $(2,-1,-1)/\sqrt6$. Hence $P_3\le3/\sqrt6=\sqrt{3/2}$ on the unit sphere, and $P_3$ is odd so $|P_3(A)|\le\sqrt{3/2}\|A\|^3$.

For $\|A\|=s$, $\|B\|=t$, $s^2+t^2=1$: $P(W)\le\sqrt{3/2}(s^3+t^3)\le\sqrt{3/2}\max(s,t)(s^2+t^2)\le\sqrt{3/2}$, with equality iff one block vanishes and the other has spectrum $(2,-1,-1)/\sqrt6$. So $M(4)=\sqrt{3/2}$ and the global maximisers are exactly $W_{\mathbb{CP}^2}$ in either orientation and any rotation.

**Criticality.** With $\lambda=(2\mu,-\mu,-\mu\,|\,0,0,0)$, $\mu=1/\sqrt6$: $Q_{11}=4\mu^2+2\lambda_2\lambda_3=6\mu^2=3\mu\cdot2\mu$ and $Q_{22}=\mu^2+2\lambda_1\lambda_3=-3\mu^2=3\mu\cdot(-\mu)$. Off-diagonal entries of $W^\#$ vanish because each pair in $\mathfrak{so}(3)$ has a unique third index. So $\theta=3\mu=\sqrt{3/2}$.

**The matrix.** $M_{\alpha\alpha}=\lambda_\alpha$, and for $\alpha\ne\beta$ in one block $M_{\alpha\beta}=\tfrac12\cdot2\cdot\lambda_\gamma=\lambda_\gamma$ with $\gamma$ the third index. Cross-block entries vanish, and the $\Lambda^-$ block vanishes since its $\lambda$ is zero. So $M=\mu N\oplus0_3$ with
$$N=\begin{pmatrix}2&-1&-1\\-1&-1&2\\-1&2&-1\end{pmatrix},\quad N(2,-1,-1)^T=3(2,-1,-1)^T,\quad N(1,1,1)^T=0,\quad N(0,1,-1)^T=-3(0,1,-1)^T.$$
The spectrum of $M$ is $\{\theta,0,-\theta,0,0,0\}$ and $\lambda_{\max}(M)=\theta$.

**Frame independence.** The eigenvalues $2\mu,-\mu,0$ are distinct, so a frame can only rotate within $\operatorname{span}(\omega_2,\omega_3)$ and within $\Lambda^-$. An orthogonal change of basis of $\mathfrak{so}(3)$ sends $\varepsilon_{ijk}$ to $\pm\varepsilon_{ijk}$, so $c^2$ and $M$ are unchanged. CONFIRMED for $n=4$.

## 5. Claim 5, padded $W_{\mathbb{CP}^2}$ at every $n\ge4$, every eigenframe

Padded $W$ has eigenvalue $2\mu$ on $\omega_1$, $-\mu$ on $\operatorname{span}(\omega_2,\omega_3)$, and $0$ on $Z=\Lambda^-\oplus V\oplus\Lambda^2\mathbb R^{n-4}$, where $V=\mathbb R^4\otimes\mathbb R^{n-4}$ is spanned by $E_{ia}$, $i\le4<a$. Any eigenframe is $\{\omega_1\}\cup\{\text{rotated }\omega_2,\omega_3\}\cup\{\text{orthonormal basis }v_\alpha\text{ of }Z\}$. Since $\lambda_\gamma\ne0$ only for $\gamma\in\Lambda^+$, $M_{\alpha\beta}=\tfrac12\sum_{\gamma\in\Lambda^+}\lambda_\gamma\langle[v_\alpha,v_\beta],\omega_\gamma\rangle^2$ off the $\Lambda^+$ block.

- **The $\Lambda^+$ block** is $\mu N$ as in Section 4, spectrum $\{3\mu,0,-3\mu\}$.
- **Cross terms** between $\Lambda^+$ and $Z$ vanish: $\langle[\omega_\alpha,v_\beta],\omega_\gamma\rangle=-\langle v_\beta,[\omega_\alpha,\omega_\gamma]\rangle=0$ because $[\Lambda^+,\Lambda^+]\subseteq\Lambda^+\perp Z$.
- **The $Z$ block.** Put $s_{\alpha\beta}=\|[v_\alpha,v_\beta]^+\|^2$, the squared $\Lambda^+$ component. Since $\lambda_\gamma\in[-\mu,2\mu]$, $|M_{\alpha\beta}|\le\mu\,s_{\alpha\beta}$. The row sums obey $\sum_{\beta\in Z}s_{\alpha\beta}\le\sum_\gamma\sum_{\beta\text{ over a basis of }\mathfrak{so}(n)}\langle v_\beta,[\omega_\gamma,v_\alpha]\rangle^2=\sum_\gamma\|[\omega_\gamma,v_\alpha]\|^2$ by ad-invariance.
- **Evaluating the row sum.** $\operatorname{ad}_{\omega_\gamma}$ kills $\Lambda^-$ and $\Lambda^2\mathbb R^{n-4}$ and acts on $V$ as $\omega_\gamma\otimes1$. As a $4\times4$ matrix $\omega_\gamma^2=-\tfrac12I$ (for instance $(E_{12}+E_{34})^2=-I$), so $\|[\omega_\gamma,p]\|^2=\tfrac12\|p\|^2$ for $p\in V$. Hence $\sum_\gamma\|[\omega_\gamma,v_\alpha]\|^2=\tfrac32\|\pi_Vv_\alpha\|^2\le\tfrac32$.
- **Conclusion for the block.** For $x\in\mathbb R^Z$, $|\langle x,M_Zx\rangle|\le\mu\sum s_{\alpha\beta}|x_\alpha||x_\beta|\le\mu\cdot\tfrac32\|x\|^2$, since a nonnegative symmetric matrix has top eigenvalue at most its largest row sum. So $\lambda_{\max}(M_Z)\le\tfrac32\mu=\theta/2$.

Therefore $M=\mu N\oplus M_Z$ has $\lambda_{\max}(M)=\theta$ in every eigenframe. At $n=5$ with the coordinate frame the $V$ block is $\tfrac\mu4\big(\begin{smallmatrix}0&2&-1&-1\\2&0&-1&-1\\-1&-1&0&2\\-1&-1&2&0\end{smallmatrix}\big)$ with spectrum $\{\mu,0,-\tfrac\mu2,-\tfrac\mu2\}$, inside the bound. CONFIRMED at this point, and it is a statement about a global maximiser only where padded $W_{\mathbb{CP}^2}$ is one, which is proven here for $n=4$ and nowhere on the record for $n\ge5$.

## 6. Claim 6, the heading as stated

- The heading asserts the step at every global maximiser for every $n$. Passage B supplies only $\lambda_{\max}(M)\ge\theta$. Passage A names the upper bound's only derivation (the L24 transfer), grades it a GAP, and states "The unrestricted form is not citable".
- Section 3 shows that transfer is invalid. Section 2 shows the step is equivalent to H3, a cap on $L_e$ over $\mathcal D\cap W^\perp$ that reaches outside $\mathcal W_n$, and nothing on the record supplies it.
- The global maximisers for $n\ge5$ are unknown in closed form (identifying them is Conjecture A's territory), so no closed-form counterexample at a global maximiser exists either. The $C_5$ blow-up of Passage B, where $\lambda_{\max}(M)>\theta$, is a critical point with $\theta$ below $M(n)$, so it is no global maximiser and refutes nothing here.
- What would decide it is analytic: a proof of H3 at global maximisers (for instance a bound $\langle Y',W\circ Y'\rangle$ and the cross term on the Ricci and $\Lambda^4$ components of $\mathcal D$), or a global maximiser for some $n\ge5$ with an eigenframe vector $x$ having $\langle x,Mx\rangle>\theta\|x\|^2$. No finite computation on objects in hand decides it.

REFUTED AS STATED as a step. The claim is unproven, its offered derivation fails at the L24 transfer, and its truth is open for $n\ge5$ away from padded $W_{\mathbb{CP}^2}$.

## 7. Claim 7, the by-product

$\operatorname{diag}M=\lambda$, so $\theta\ge\lambda_{\max}(M)\ge\max_\alpha\lambda_\alpha$ wherever the step holds. The inequality also holds at every global maximiser independently of the step: $\lambda_\alpha\le\|\lambda\|=1<\sqrt{3/2}\le M(n)=\theta$, as [L115Statement.lean](../lean/HamiltonsCubic/Results/L115Statement.lean) records in theta_gt_lambda. CONFIRMED.

## Verdict

**FAILS.** The step "$\lambda_{\max}(M)=\theta$ at every global maximiser, for every $n$" is not established. Its only derivation reads L24's cap, valid on $\mathcal W_n\cap W^\perp$, over the eigenframe-diagonal algebra $\mathcal D\not\subseteq\mathcal W_n$ (Section 3), and the step is equivalent to the unproven cap H3 (Section 2).

A VALID reading needs one of these hypotheses:

- **H1**, $n=4$, where the maximisers are exactly $W_{\mathbb{CP}^2}$ and $\operatorname{spec}M=\{\theta,0,-\theta,0,0,0\}$ (Section 4).
- **H2**, the maximiser is padded $W_{\mathbb{CP}^2}$, at any $n$ and in any eigenframe (Section 5).
- **H3** itself, at the maximiser in question.

The by-product $\theta\ge\max_\alpha\lambda_\alpha$ holds at every global maximiser without the step.
