# Verifier v366, the cap on L_W off the Weyl space as the closure of Lemma L115

**Cold brief ([ADJ_L115_F6.md](ADJ_L115_F6.md)). No numerical work, no scripts written, every value exact. Log: [agent_logs/verify-L115-v366.log](../agent_logs/verify-L115-v366.log).** References opened: [Böhm–Wilking](https://arxiv.org/abs/math/0606187) lines 50–72, 176–206 and 294–302, and [Jaeger](https://repositorium.uni-muenster.de/document/miami/820840d1-0252-4bf3-8fc7-853730eee3f5/diss_jaeger_florian.pdf) lines 466–486.

| # | Claim | Verdict |
|---|---|---|
| C1 | $M(\lambda)$ is the Gram matrix, in the orthonormal basis $v_\alpha\otimes v_\alpha$, of the quadratic form $X\mapsto\langle X,L_WX\rangle$ restricted to $\mathcal D$ | CONFIRMED AS ALGEBRA (under H1) |
| C2 | $L_W$ is self-adjoint on $\mathrm{Sym}(\Lambda^2)$, maps $\mathcal W_n$ into $\mathcal W_n$, and hence maps $\mathcal W_n^\perp$ into $\mathcal W_n^\perp$, and $L_WW=\theta W$ | CONFIRMED |
| C3 | At a global maximiser, $\lambda_{\max}(L_W\vert_{\mathcal W_n^\perp})\le\theta$ together with Lemma L24 gives $\lambda_{\max}(M)=\theta$ | CONFIRMED |
| C4 | "A cap", at an unnamed level, closes the step | REFUTED AS STATED: the argument closes exactly when the cap is at most $\theta$, equivalently $\lambda_{\max}(L_e\vert_{\mathcal W_n^\perp})\le1$ |
| C5 | The cap may be read on the complement of $\mathcal W_n$ inside the curvature operators $S^2_B$ | REFUTED AS STATED: $\mathcal D$ carries a $\Lambda^4$ component, so the complement must be taken in all of $\mathrm{Sym}(\Lambda^2)$ |

**Summary: the step is VALID with the cap $\lambda_{\max}(L_W|_{\mathcal W_n^\perp})\le\theta$, complement taken in $\mathrm{Sym}(\Lambda^2)$, and the argument additionally uses the standard fact that $L_W$ preserves $\mathcal W_n$, which makes the cross block vanish.**

## 0. Conventions, fixed once

- $N=\binom n2$, $\Lambda^2=\Lambda^2\mathbb R^n\cong\mathfrak{so}(n)$ with the inner product induced from $\mathbb R^n$, which is ad-invariant, so the structure constants $c_{\alpha\beta\gamma}=\langle[v_\alpha,v_\beta],v_\gamma\rangle$ in any orthonormal basis are totally antisymmetric.
- $\mathrm{Sym}(\Lambda^2)$ is the space of self-adjoint operators on $\Lambda^2$ with $\langle A,B\rangle=\operatorname{tr}(AB)$. It splits orthogonally as $S^2_B\oplus(S^2_B)^\perp$, where $S^2_B=\ker b$ is the kernel of the Bianchi map and $(S^2_B)^\perp\cong\Lambda^4$. Further $S^2_B=\mathcal W_n\oplus(\text{Ricci part})$.
- $\mathcal W_n^\perp$ denotes the orthogonal complement of $\mathcal W_n$ in $\mathrm{Sym}(\Lambda^2)$. It contains the Ricci part and the $\Lambda^4$ part.
- $A\#B$ is the Böhm–Wilking bilinear product, $Q(X)=X^2+X\#X$, $X\circ Y=\tfrac12(XY+YX)+X\#Y$ its polarization, and $L_W=W\circ(\cdot)$ acts on all of $\mathrm{Sym}(\Lambda^2)$. Lemma L24's $L_e=L_W/\theta$.
- $W$ is a unit global maximiser with eigenframe $\{v_\alpha\}$ and spectrum $\lambda$, $\theta=P(W)=M(n)$. For $x\in\mathbb R^N$, $D_x=\sum_\alpha x_\alpha\,v_\alpha\otimes v_\alpha\in\mathcal D$, so $\|D_x\|=|x|$ and $D_\lambda=W$.
- "Cap at level $\kappa$" means $\langle Z,L_WZ\rangle\le\kappa\|Z\|^2$ for every $Z\in\mathcal W_n^\perp$.

## Hypothesis inventory

- **H1 (meaning of $c'^2$).** $c'^2_{\alpha\beta\gamma}=c_{\alpha\beta\gamma}^2$ with $c$ the $\mathfrak{so}(n)$ structure constants in the eigenframe, and $\#$ normalized so that $(A\#B)_{\alpha\beta}=\tfrac12\sum c_{\alpha\gamma\delta}c_{\beta\varepsilon\zeta}A_{\gamma\varepsilon}B_{\delta\zeta}$. This is the reading under which Passage B's identity $P=\langle\lambda,M\lambda\rangle$ is the cubic $\langle W,Q(W)\rangle$.
- **H2 (where the complement lives).** $\mathcal W_n^\perp$ is the complement in $\mathrm{Sym}(\Lambda^2)$, the space containing $\mathcal D$.
- **H3 (cap level).** $\lambda_{\max}(L_W|_{\mathcal W_n^\perp})\le\theta$ at the maximiser, equivalently $\lambda_{\max}(L_e|_{\mathcal W_n^\perp})\le1$. Since $\theta=M(n)\ge\sqrt{3/2}$, the uniform condition $\lambda_{\max}(L_W|_{\mathcal W_n^\perp})\le\sqrt{3/2}$ for all unit critical $W$ implies it.
- **H4 (invariance, a standard theorem).** $X,Y\in\mathcal W_n\Rightarrow X\circ Y\in\mathcal W_n$. Sourced in Section 3.
- **H5 (standing facts at a global maximiser).** A global maximiser is a local maximiser and a critical point, $\theta=M(n)\ge\sqrt{3/2}>0$, and $Q(W)=\theta W$.

## 1. $M$ is the compression of $L_W$ to $\mathcal D$

For diagonal $A=D_x$, $B=D_y$ the product formula of H1 gives $(D_x\#D_y)_{\alpha\beta}=\tfrac12\sum_{\gamma,\delta}c_{\alpha\gamma\delta}c_{\beta\gamma\delta}x_\gamma y_\delta$, so $\langle D_z,D_x\#D_y\rangle=\tfrac12\sum_{\alpha,\gamma,\delta}c^2_{\alpha\gamma\delta}\,z_\alpha x_\gamma y_\delta$.

Also $\langle D_x,\tfrac12(WD_x+D_xW)\rangle=\operatorname{tr}(D_xWD_x)=\sum_\alpha\lambda_\alpha x_\alpha^2$ because $W=D_\lambda$. Hence

$$\langle D_x,L_WD_x\rangle=\sum_\alpha\lambda_\alpha x_\alpha^2+\tfrac12\sum_{\alpha,\beta,\gamma}c^2_{\alpha\beta\gamma}\,x_\alpha x_\beta\lambda_\gamma=\langle x,M(\lambda)x\rangle .$$

Since $x\mapsto D_x$ is an isometry onto $\mathcal D$, $\lambda_{\max}(M)=\max\{\langle D,L_WD\rangle:D\in\mathcal D,\ \|D\|=1\}$. At $x=\lambda$ this recovers $P=\langle W,Q(W)\rangle$, the check Passage B records. So $\lambda_{\max}(M)$ is the top of the compression of $L_W$ to $\mathcal D$, and the task is to bound $\langle D,L_WD\rangle$ for unit $D\in\mathcal D$.

## 2. $L_W$ is self-adjoint on $\mathrm{Sym}(\Lambda^2)$

Böhm–Wilking (5) define $\mathrm{tri}(R_1,R_2,R_3)=\operatorname{tr}\big((R_1R_2+R_2R_1+2R_1\#R_2)R_3\big)$ and show it is symmetric in all three arguments via $\operatorname{tr}(2(R_1\#R_2)R_3)=\sum\langle[R_1b_\alpha,R_2b_\beta],R_3b_\gamma\rangle\langle[b_\alpha,b_\beta],b_\gamma\rangle$. That computation uses only self-adjointness of the $R_i$ and total antisymmetry of $c$, so it holds on all of $\mathrm{Sym}(\Lambda^2)$, with no Bianchi condition. Since $\langle Y,L_WX\rangle=\tfrac12\mathrm{tri}(W,X,Y)$, $L_W$ is self-adjoint on $\mathrm{Sym}(\Lambda^2)$.

## 3. $L_W$ preserves $\mathcal W_n$, $\mathcal W_n^\perp$ and $W^\perp$

- **Bianchi.** $R^2+R^\#\in S^2_B$ for every $R\in S^2_B$ ([Jaeger](https://repositorium.uni-muenster.de/document/miami/820840d1-0252-4bf3-8fc7-853730eee3f5/diss_jaeger_florian.pdf) line 466, citing Chow et al. 11.2.3). Polarizing, $X\circ Y=\tfrac12(Q(X+Y)-Q(X)-Q(Y))\in S^2_B$ for $X,Y\in S^2_B$.
- **Ricci.** Böhm–Wilking (6): in a Ricci eigenframe, $\mathrm{Ric}(R^2+R^\#)_{ij}=\sum_k\mathrm{Ric}_{kk}R_{kijk}$, equivalently Jaeger (1.5), $\mathrm{Ric}(Q(R))_{ij}=\sum_{k,l}\mathrm{Ric}(R)_{kl}R_{kijl}$. This is linear in $\mathrm{Ric}(R)$, so $\mathrm{Ric}(Q(X))=0$ for $X\in\mathcal W_n$. For $X,Y\in\mathcal W_n$, $X\pm Y\in\mathcal W_n$, so $X\circ Y=\tfrac14\big(Q(X+Y)-Q(X-Y)\big)$ has vanishing Ricci. Böhm–Wilking make exactly this polarization at lines 298–300, and Jaeger (1.7) records $W^2+W^\#\in\mathcal W_n$.
- Hence $L_W\mathcal W_n\subseteq\mathcal W_n$ (H4). By Section 2, $L_W\mathcal W_n^\perp\subseteq\mathcal W_n^\perp$.
- $L_WW=W\circ W=Q(W)=\theta W$ (H5), so $W$ is an eigenvector of $L_W$ on the whole of $\mathrm{Sym}(\Lambda^2)$, and by self-adjointness $L_W$ preserves $W^\perp$ and $\mathcal W_n\cap W^\perp$. This also confirms that the critical-point equation $Q(W)=\theta W$ is an identity in $\mathcal W_n$, without projection.

So $\mathrm{Sym}(\Lambda^2)=\mathbb RW\oplus(\mathcal W_n\cap W^\perp)\oplus\mathcal W_n^\perp$ is an orthogonal decomposition into $L_W$-invariant subspaces.

## 4. The bound

Take unit $D\in\mathcal D$ and write $D=aW+Y+Z$ with $Y\in\mathcal W_n\cap W^\perp$, $Z\in\mathcal W_n^\perp$, $a^2+\|Y\|^2+\|Z\|^2=1$. By Section 3 every cross term vanishes: $\langle W,L_WY\rangle=\theta\langle W,Y\rangle=0$, $\langle W,L_WZ\rangle=\theta\langle W,Z\rangle=0$, and $\langle Y,L_WZ\rangle=0$ because $L_WZ\in\mathcal W_n^\perp$. So

$$\langle D,L_WD\rangle=\theta a^2+\langle Y,L_WY\rangle+\langle Z,L_WZ\rangle .$$

- **The Weyl block.** Lemma L24 applies at a local maximiser with $\theta>0$ (H5). Its Riemannian Hessian $6\theta(L_e-\tfrac12\mathrm{Id})$ acts on the tangent space $\mathcal W_n\cap W^\perp$, which Section 3 shows is $L_e$-invariant, so its conclusion reads $\langle Y,L_WY\rangle=\theta\langle Y,L_eY\rangle\le\tfrac\theta2\|Y\|^2$.
- **The complementary block.** H3 gives $\langle Z,L_WZ\rangle\le\kappa\|Z\|^2$ with $\kappa\le\theta$.

Therefore

$$\langle D,L_WD\rangle\le\theta a^2+\tfrac\theta2\|Y\|^2+\kappa\|Z\|^2\le\theta .$$

Taking the maximum over $D$ and using Section 1, $\lambda_{\max}(M)\le\theta$. The reverse inequality is Passage B's boxed $\theta\le\lambda_{\max}(M)$, which is the case $D=W\in\mathcal D$. So $\lambda_{\max}(M)=\theta$ at every global maximiser, which is the unrestricted form of L115. The by-product $\theta\ge\max_\alpha\lambda_\alpha$ then follows from $\operatorname{diag}M=\lambda$, as the Lean theorem `theta_ge_diag` in [L115Statement.lean](../lean/HamiltonsCubic/Results/L115Statement.lean) formalizes.

## 5. The level of the cap

- **Level $\theta$ is the threshold of this argument.** With a cap at $\kappa>\theta$, the bound of Section 4 is $\max(\theta,\kappa)$ over the three blocks, and the argument yields only $\lambda_{\max}(M)\le\kappa$. With $\kappa\le\theta$ it yields $\theta$. So the cap the step needs is $\lambda_{\max}(L_W|_{\mathcal W_n^\perp})\le\theta$, which in Lemma L24's normalization is $\lambda_{\max}(L_e|_{\mathcal W_n^\perp})\le1$, twice the level L24 gives on the Weyl block.
- **A uniform sufficient form.** Because $\theta=M(n)\ge\sqrt{3/2}$ at a global maximiser, the statement "$\lambda_{\max}(L_W|_{\mathcal W_n^\perp})\le\sqrt{3/2}$ for every unit critical $W$" implies H3 at every global maximiser.
- **A sharper sufficient form.** Only the components $Z=\pi_{\mathcal W_n^\perp}(D)$ with $D\in\mathcal D$ enter, so it suffices that $\langle Z,L_WZ\rangle\le\theta\|Z\|^2$ on the subspace $\pi_{\mathcal W_n^\perp}(\mathcal D)$. The full-complement cap is the form the step names.
- **The slack on the Weyl block is spare.** The coefficient $\tfrac\theta2$ on $\|Y\|^2$ is below $\theta$, so the Weyl block never binds, and L24 is used only in the weak form $\lambda_{\max}(L_e|_{\mathcal W_n\cap W^\perp})\le1$.

## 6. Arguing the opposite

- **The cross block.** A cap on each of two complementary subspaces transfers nothing when the operator couples them: the symmetric matrix $\begin{pmatrix}\theta/2&b\\ b&\theta\end{pmatrix}$ has top eigenvalue $\tfrac34\theta+\sqrt{\theta^2/16+b^2}>\theta$ for every $b\ne0$. This is the failure mode of the Lean witness `cap_on_subspace_transfers_nothing` in [L115.lean](../lean/HamiltonsCubic/Results/L115.lean), and the step as written names neither the cross block nor the fact that removes it. Section 3 shows $b=0$ identically, by H4 and self-adjointness, so this failure is closed. The step is valid only with H4 supplied, and H4 is a published theorem.
- **The complement taken inside $S^2_B$ (C5).** Under that reading the $\Lambda^4$ component of $D$ is uncapped, and the bound of Section 4 acquires an unbounded term. That component is present: $b(v\otimes v)$ is a nonzero multiple of $v\wedge v\in\Lambda^4$, which vanishes exactly when the 2-form $v$ is decomposable. For the Kähler form $\omega=e_{12}+e_{34}$, $\omega\wedge\omega=2\,e_{1234}\ne0$, and $\omega$ is an eigenvector of the Fubini–Study Weyl operator of $\mathbb{CP}^2$. So eigenframe-diagonal operators leave $S^2_B$ as soon as an eigen 2-form is indecomposable, and H2 is required. The passage's own remark that elements of $\mathcal D$ are "generically neither trace-free nor Bianchi" supports H2 as the intended reading.
- **The identification of $M$ (H1).** Should $c'^2$ carry a different normalization than the one making $\langle x,Mx\rangle=\langle D_x,L_WD_x\rangle$, the matrix $M$ would be a different compression and Section 1 would fail. H1 is the reading under which Passage B's identity $P=\langle\lambda,M\lambda\rangle$ is the definition $P=\langle W,Q(W)\rangle$ with the same $\#$, so it is the reading the passage supports.
- **Whether a weaker cap could still give the conclusion.** The conclusion may hold with a cap above $\theta$ if the offending directions of $\mathcal W_n^\perp$ miss $\pi_{\mathcal W_n^\perp}(\mathcal D)$. That concerns the conclusion, and the step asks what closes the argument, which Section 5 settles at $\theta$.

## 7. Verdict

**VALID.** A cap $\lambda_{\max}(L_W|_{\mathcal W_n^\perp})\le\theta$ (equivalently $\lambda_{\max}(L_e|_{\mathcal W_n^\perp})\le1$, implied uniformly by the level $\sqrt{3/2}$) together with Lemma L24 gives $\lambda_{\max}(M)=\theta$ at every global maximiser. The valid reading needs:

- H1, $M$ as the compression of $L_W$ to $\mathcal D$ with $c'^2_{\alpha\beta\gamma}=c^2_{\alpha\beta\gamma}$ and the Böhm–Wilking $\#$.
- H2, $\mathcal W_n^\perp$ taken in all of $\mathrm{Sym}(\Lambda^2)$, including the $\Lambda^4$ part.
- H3, the cap at level $\theta$.
- H4, $L_W\mathcal W_n\subseteq\mathcal W_n$ (Böhm–Wilking (6) and its polarization, Jaeger (1.7)), which with the self-adjointness of $L_W$ (Böhm–Wilking (5)) kills the cross block. The step leaves this unstated, and it is the load-bearing ingredient beyond the two caps.
- H5, global maximiser implies local maximiser and critical point with $\theta=M(n)>0$ and $Q(W)=\theta W$, plus Passage B's $\theta\le\lambda_{\max}(M)$.
