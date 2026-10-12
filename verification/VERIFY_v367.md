# Verifier v367, the cap on L_W off Weyl_n together with Lemma L24 gives lambda_max(M) = theta (L115, step F6)

Cold brief ([ADJ_L115_F6.md](ADJ_L115_F6.md)). No numerical work, no scripts written, every value exact. Log at [agent_logs/verify-L115-v367.log](../agent_logs/verify-L115-v367.log).

| # | Claim | Verdict |
|---|---|---|
| 1 | $M(\lambda)=\theta\,\Pi_{\mathcal D}L_e\Pi_{\mathcal D}$ in the orthonormal basis $E_\alpha=v_\alpha v_\alpha^{T}$ of $\mathcal D$ | CONFIRMED |
| 2 | $L_e$ is self-adjoint on $\mathrm{Sym}(\Lambda^2)$, fixes $W$, and leaves $\mathcal W_n$, $\mathcal W_n\cap W^\perp$ and $\mathcal W_n^\perp$ invariant | CONFIRMED (needs H2, H3) |
| 3 | At a local maximiser, $\lambda_{\max}(L_e)$ on all of $\mathrm{Sym}(\Lambda^2)$ equals $\max\big(1,\lambda_{\max}(L_e\vert_{\mathcal W_n^\perp})\big)$ | CONFIRMED |
| 4 | A cap $\lambda_{\max}(L_W\vert_{\mathcal W_n^\perp})\le\theta$, equivalently $\lambda_{\max}(L_e\vert_{\mathcal W_n^\perp})\le1$, with L24 gives $\lambda_{\max}(M)=\theta$ | CONFIRMED |
| 5 | A uniform cap $\lambda_{\max}(L_W\vert_{\mathcal W_n^\perp})\le\sqrt{3/2}$ over unit $W$ suffices at every global maximiser | CONFIRMED |
| 6 | The step with $\mathcal W_n^\perp$ read inside $S^2_B$ (curvature operators) rather than inside $\mathrm{Sym}(\Lambda^2)$ | REFUTED AS STATED (the argument does not reach $\mathcal D$) |

**Summary: the step is VALID, with the cap at level $\theta$ for $L_W=W\circ(\cdot)$ (level $1$ for $L_e$), the complement taken in $\mathrm{Sym}(\Lambda^2)$, and two standard facts about $Q$, and it then holds at every local maximiser with $\theta>0$, not only at global ones.**

## 0. Conventions, fixed once

- $\Lambda^2=\Lambda^2\mathbb R^n\cong\mathfrak{so}(n)$, $N=\dim\Lambda^2$. The ambient space is $\mathrm{Sym}(\Lambda^2)$ with $\langle A,B\rangle=\operatorname{tr}(AB)$. It contains $\mathcal W_n\subset S^2_B\subset\mathrm{Sym}(\Lambda^2)$ and $\mathcal D$.
- $\{v_\alpha\}$ is an orthonormal eigenbasis of $W$, $W v_\alpha=\lambda_\alpha v_\alpha$, and $E_\alpha=v_\alpha v_\alpha^{T}$. Then $\langle E_\alpha,E_\beta\rangle=\delta_{\alpha\beta}$, $\mathcal D=\operatorname{span}\{E_\alpha\}$, and $W=\sum_\alpha\lambda_\alpha E_\alpha\in\mathcal D$.
- $c'_{\alpha\beta\gamma}$ are the structure constants of $\mathfrak{so}(n)$ in the basis $\{v_\alpha\}$, totally antisymmetric because the basis is orthonormal for an ad-invariant inner product, and $c'^2_{\alpha\beta\gamma}=(c'_{\alpha\beta\gamma})^2$ is totally symmetric.
- $Q(X)=X^2+X^\#$ on $\mathrm{Sym}(\Lambda^2)$, $X\circ Y=\tfrac12\big(Q(X+Y)-Q(X)-Q(Y)\big)=\tfrac12(XY+YX)+X\#Y$, so $X\circ X=Q(X)$. $L_X=X\circ(\cdot)$, hence $L_W=\theta L_e$ for $e=W/\theta$.
- $\mathcal W_n^\perp$ is the orthogonal complement of $\mathcal W_n$ in $\mathrm{Sym}(\Lambda^2)$, and $W^\perp$ in Lemma L24 is the tangent space $\mathcal W_n\cap W^\perp$ of the unit sphere of $\mathcal W_n$.
- $\Pi_{\mathcal D}$ is the orthogonal projection onto $\mathcal D$. $\lambda_{\max}$ of an operator restricted to an invariant subspace is its top eigenvalue there, and of a compression $\Pi A\Pi$ is $\max\langle x,Ax\rangle/\langle x,x\rangle$ over the subspace.

## Hypothesis inventory

- **H1 (ambient).** The complement $\mathcal W_n^\perp$ in the cap is taken inside $\mathrm{Sym}(\Lambda^2)$, the space that contains $\mathcal D$. The passage supports this reading: it stresses that elements of $\mathcal D$ are "generically neither trace-free nor Bianchi".
- **H2 ($Q$ preserves Weyl).** $Q(\mathcal W_n)\subseteq\mathcal W_n$. This is standard: $Q$ preserves $S^2_B$, and for $R\in S^2_B$ the Ricci contraction of $R^2+R^\#$ is linear in $\operatorname{Ric}(R)$ (the reaction term of Hamilton's Ricci equation in an Uhlenbeck frame), so it vanishes on Weyl tensors. The brief's own definition of a critical point, $Q(W)=\theta W$ with no projection, already uses it.
- **H3 (symmetry of the sharp).** $(A,B,C)\mapsto\langle A\#B,C\rangle$ is totally symmetric on $\mathrm{Sym}(\Lambda^2)$. Proved in Section 1 from total antisymmetry of $c'$.
- **H4 (the displayed cubic on $\mathcal D$).** Passage B's identity $\langle X,Q(X)\rangle=\sum_\alpha x_\alpha^3+\tfrac12\sum c'^2_{\alpha\beta\gamma}x_\alpha x_\beta x_\gamma$ holds for every $X=\sum x_\alpha E_\alpha\in\mathcal D$. The "one line" derivation uses only that $X$ is diagonal in the frame, not criticality or the norm.
- **H5 (the maximiser).** $W$ is a unit critical point with $\theta=P(W)>0$ that is a local maximiser, so Lemma L24 applies. A global maximiser qualifies, since $\theta=M(n)\ge\sqrt{3/2}>0$ by padded $W_{\mathbb{CP}^2}$.
- **H6 (the cap, the level).** $\lambda_{\max}(L_W|_{\mathcal W_n^\perp})\le\theta$ at the point, equivalently $\lambda_{\max}(L_e|_{\mathcal W_n^\perp})\le1$. A sufficient uniform form is $\sup_{\|W\|=1}\lambda_{\max}(L_W|_{\mathcal W_n^\perp})\le\sqrt{3/2}$, or the same supremum over unit global maximisers.

## 1. $L_e$ is self-adjoint (H3)

The Jordan part is symmetric: for symmetric $X,Y,Z$, $\operatorname{tr}(XYZ)=\operatorname{tr}\big((XYZ)^T\big)=\operatorname{tr}(ZYX)$, and with cyclicity all six orderings of $\operatorname{tr}(XYZ)$ agree, so $\langle\tfrac12(XY+YX),Z\rangle$ is totally symmetric.

The sharp in the frame is $(A\#B)_{\alpha\beta}=\tfrac12\sum c'_{\alpha\gamma\delta}c'_{\beta\varepsilon\eta}A_{\gamma\varepsilon}B_{\delta\eta}$, so $T_\#(A,B,C)=\tfrac12\sum c'_{\alpha\gamma\delta}c'_{\beta\varepsilon\eta}A_{\gamma\varepsilon}B_{\delta\eta}C_{\alpha\beta}$.

- Swapping $A$ and $B$ and renaming $\gamma\leftrightarrow\delta$, $\varepsilon\leftrightarrow\eta$ produces $c'_{\alpha\delta\gamma}c'_{\beta\eta\varepsilon}=(-c'_{\alpha\gamma\delta})(-c'_{\beta\varepsilon\eta})$, the same sum.
- Swapping $A$ and $C$ and renaming $\alpha\leftrightarrow\gamma$, $\beta\leftrightarrow\varepsilon$ produces $c'_{\gamma\alpha\delta}c'_{\varepsilon\beta\eta}=c'_{\alpha\gamma\delta}c'_{\beta\varepsilon\eta}$, again the same sum.

These two transpositions generate $S_3$, so $T(X,Y,Z)=\langle X\circ Y,Z\rangle$ is a totally symmetric trilinear form and every $L_X$ is self-adjoint. The normalisation of $\#$ is immaterial: any constant multiple gives the same symmetry, and Section 2 uses only the cubic of H4.

## 2. $M$ is $\theta$ times the compression of $L_e$ to $\mathcal D$

Put $S_{abc}=\delta_{a=b=c}+\tfrac12 c'^2_{abc}$, a totally symmetric tensor on $\mathbb R^N$. By H4, $T(X,X,X)=\langle X,Q(X)\rangle=\sum S_{abc}x_ax_bx_c$ for $X\in\mathcal D$. A totally symmetric trilinear form is determined by its cubic (polarisation), and the restriction of $T$ to $\mathcal D^3$ is totally symmetric by Section 1, so $T(E_a,E_b,E_c)=S_{abc}$.

Hence, with $e=\sum(\lambda_a/\theta)E_a$,

$$\langle E_\beta,L_eE_\delta\rangle=T(e,E_\beta,E_\delta)=\frac1\theta\sum_aS_{a\beta\delta}\lambda_a=\frac1\theta\Big(\delta_{\beta\delta}\lambda_\beta+\tfrac12\sum_\gamma c'^2_{\beta\delta\gamma}\lambda_\gamma\Big)=\frac{M(\lambda)_{\beta\delta}}{\theta}.$$

So $M(\lambda)=\theta\,\Pi_{\mathcal D}L_e\Pi_{\mathcal D}$ in the orthonormal basis $\{E_\alpha\}$, and

$$\lambda_{\max}(M)=\theta\max_{0\ne X\in\mathcal D}\frac{\langle X,L_eX\rangle}{\langle X,X\rangle}.$$

This is the object Passage A writes as $\lambda_{\max}(L_e|_{\mathcal D})$, and it holds for every choice of eigenbasis when eigenvalues repeat.

## 3. The block decomposition of $L_e$

- **$W$ is fixed.** $L_eW=\tfrac1\theta W\circ W=\tfrac1\theta Q(W)=W$, using $Q(W)=\theta W$ in $\mathrm{Sym}(\Lambda^2)$ (H2 makes this the same as the Weyl-projected equation).
- **$\mathcal W_n$ is invariant.** For $X\in\mathcal W_n$, $L_eX=\tfrac12\big(Q(e+X)-Q(e)-Q(X)\big)\in\mathcal W_n$ by H2.
- **The complements are invariant.** $L_e$ is self-adjoint (Section 1), so it preserves $\mathcal W_n^\perp$, and since it fixes $W$ it preserves $W^\perp$, hence $\mathcal W_n\cap W^\perp$.

Therefore $\mathrm{Sym}(\Lambda^2)=\mathbb RW\oplus(\mathcal W_n\cap W^\perp)\oplus\mathcal W_n^\perp$ is an orthogonal decomposition into $L_e$-invariant subspaces, and

$$L_e=1\ \oplus\ L_e|_{\mathcal W_n\cap W^\perp}\ \oplus\ L_e|_{\mathcal W_n^\perp}.$$

At a local maximiser Lemma L24 gives $\lambda_{\max}(L_e|_{\mathcal W_n\cap W^\perp})\le\tfrac12$. With $\mu:=\lambda_{\max}(L_e|_{\mathcal W_n^\perp})$, the top eigenvalue of $L_e$ on the whole ambient space is $\max(1,\tfrac12,\mu)=\max(1,\mu)$.

## 4. The conclusion and the level of the cap

Write $X\in\mathcal D$ as $X=aW+Y+Z$ with $Y\in\mathcal W_n\cap W^\perp$ and $Z\in\mathcal W_n^\perp$. The invariance in Section 3 kills every cross term, so

$$\langle X,L_eX\rangle=a^2+\langle Y,L_eY\rangle+\langle Z,L_eZ\rangle\le a^2+\tfrac12\|Y\|^2+\mu\|Z\|^2.$$

- **Upper bound.** If $\mu\le1$, the right side is at most $a^2+\|Y\|^2+\|Z\|^2=\|X\|^2$, so by Section 2 $\lambda_{\max}(M)\le\theta$.
- **Lower bound.** $W=\sum\lambda_\alpha E_\alpha\in\mathcal D$ with $\langle W,L_eW\rangle=\|W\|^2=1$, which is Passage B's $M\lambda=\theta\lambda$ and its boxed $\theta\le\lambda_{\max}(M)$.

So $\lambda_{\max}(M)=\theta$. Since $L_W=\theta L_e$, the cap $\mu\le1$ reads

$$\boxed{\ \lambda_{\max}\big(L_W|_{\mathcal W_n^\perp}\big)\le\theta\ }\qquad\text{at the point.}$$

**The level cannot be raised within this argument.** If $\mu>1$, the only bound it gives is $\lambda_{\max}(M)\le\theta\mu$, and whether a top eigenvector of $L_e|_{\mathcal W_n^\perp}$ has a large component along $\mathcal D$ depends on the eigenframe, which the argument does not control. The cap is sufficient and is not claimed to be necessary: what the conclusion actually needs is $\langle Z,L_eZ\rangle\le\|Z\|^2+\tfrac12\|Y\|^2$ for the components of elements of $\mathcal D$ only.

**The uniform form.** At a global maximiser $\theta=M(n)\ge\sqrt{3/2}$. So a bound $\lambda_{\max}(L_W|_{\mathcal W_n^\perp})\le\sqrt{3/2}$ for every unit $W$ (or only for unit global maximisers) implies the pointwise cap of H6 at every global maximiser. This is the one place the word "global" does work. The pointwise cap gives the conclusion at every local maximiser with $\theta>0$.

**What else the argument uses.** Lemma L24 at level $\tfrac12$ (any level $\le1$ would do, and simplicity of the eigenvalue $1$ is unused), H2 for the invariance of $\mathcal W_n$ and for $L_eW=W$, H3 for self-adjointness, and H4 to identify $M$ with the compression. The by-product in Passage A then follows: $\operatorname{diag}M=\lambda$ gives $\lambda_\alpha=M_{\alpha\alpha}\le\lambda_{\max}(M)=\theta$.

## 5. Arguing the opposite: where a reading fails

- **$\mathcal W_n^\perp$ inside $S^2_B$.** $\mathrm{Sym}(\Lambda^2)=S^2_B\oplus\Lambda^4$, and $\mathcal D\not\subseteq S^2_B$ in general, as Passage A says. A cap on the complement of $\mathcal W_n$ inside $S^2_B$ controls nothing on the $\Lambda^4$ component of $X\in\mathcal D$, nor the cross term between that component and $S^2_B\ominus\mathcal W_n$, because $L_e$ need not preserve $\Lambda^4$. This is the pattern of [cap_on_subspace_transfers_nothing](../lean/HamiltonsCubic/Results/L115.lean): a bound on a proper subspace transfers nothing. Under this reading the step does not reach $\mathcal D$, hence claim 6. Passage A's wording favours H1, so the strongest reading stands.
- **Critical point only up to projection.** If $Q(W)$ had a component $K\in\mathcal W_n^\perp$, then $L_eW=W+K/\theta$ and the cross term $2a\langle W,L_eZ\rangle=2a\langle K,Z\rangle/\theta$ would survive, and the cap alone would not close the bound. H2 removes this, and it is a standard fact.
- **A cap at a level above $1$ for $L_e$.** Covered in Section 4: the argument yields only $\lambda_{\max}(M)\le\theta\mu$.
- **Lemma L24 read as the ambient second differential.** Passage C fixes the Riemannian Hessian as $6\theta(L_e-\tfrac12\mathrm{Id})$ and states the bound $\tfrac12$, so the reading is not open.

None of these defeats the strongest reading. They fix which hypotheses it needs.

## 6. Verdict

**VALID.** A cap $\lambda_{\max}(L_W|_{\mathcal W_n^\perp})\le\theta$ (equivalently $\lambda_{\max}(L_e|_{\mathcal W_n^\perp})\le1$, or uniformly $\le\sqrt{3/2}$ over unit $W$, which suffices because $M(n)\ge\sqrt{3/2}$), together with Lemma L24, gives $\lambda_{\max}(M)=\theta$ at every global maximiser, and at every local maximiser under the pointwise form. The reading needs H1 (complement in $\mathrm{Sym}(\Lambda^2)$), H2 ($Q(\mathcal W_n)\subseteq\mathcal W_n$), H3 (total symmetry of $\langle X\#Y,Z\rangle$), H4 (Passage B's cubic on all of $\mathcal D$) and H5. The mechanism is that $M=\theta\,\Pi_{\mathcal D}L_e\Pi_{\mathcal D}$ and $L_e$ splits orthogonally as $1\oplus L_e|_{\mathcal W_n\cap W^\perp}\oplus L_e|_{\mathcal W_n^\perp}$.
