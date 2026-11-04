# Verifier v369, frame independence of lambda_max(M) in Lemma L115 (step F7)

Cold brief ([ADJ_L115_F7.md](ADJ_L115_F7.md)). No numerical work, no scripts written, every value below exact. Log at [agent_logs/verify-L115-v369.log](../agent_logs/verify-L115-v369.log).

| Claim | Verdict |
|---|---|
| $\lambda_{\max}(M)$ is independent of the orthonormal eigenbasis when $W$ has simple spectrum | CONFIRMED |
| $\lambda_{\max}(M)$ is independent of the orthonormal eigenbasis at every unit $W$, including repeated eigenvalues or a kernel | REFUTED AS STATED |
| The Rayleigh bound $\theta\le\lambda_{\max}(M)$ holds in every eigenframe | CONFIRMED |
| At a critical point $\theta$ is an eigenvalue of $M$ in every eigenframe | CONFIRMED AS ALGEBRA |

**Summary:** at $n=4$ the unit Weyl tensor $W^+=\mathop{\mathrm{diag}}(0,\tfrac1{\sqrt2},-\tfrac1{\sqrt2})$, $W^-=0$ has two orthonormal eigenframes, differing by a $45^\circ$ rotation inside its kernel, in which $\lambda_{\max}(M)$ equals $\sqrt{3/2}$ and $1$, so the step FAILS as written and holds under simple spectrum or an explicit frame quantifier.

## 0. Conventions, fixed once

- $\mathfrak{so}(n)\cong\Lambda^2\mathbb R^n$ carries an ad-invariant inner product, and for an orthonormal basis $\{v_\alpha\}$ the structure constants are $c'_{\alpha\beta\gamma}=\langle[v_\alpha,v_\beta],v_\gamma\rangle$, fully antisymmetric. Any fixed rescaling of this convention rescales the constant $\kappa$ below and changes nothing in the verdict.
- $M(\lambda)_{\alpha\beta}=\delta_{\alpha\beta}\lambda_\alpha+\tfrac12\sum_\gamma c'^2_{\alpha\beta\gamma}\lambda_\gamma$, exactly as Passage B writes it, with $c'^2_{\alpha\beta\gamma}=(c'_{\alpha\beta\gamma})^2$, fully symmetric.
- At $n=4$, $\Lambda^2=\Lambda^+\oplus\Lambda^-$, two commuting orthogonal ideals, each isomorphic to $\mathfrak{so}(3)$. Positively oriented orthonormal bases $f_1,f_2,f_3$ of $\Lambda^+$ and $g_1,g_2,g_3$ of $\Lambda^-$ satisfy $[f_a,f_b]=k\,\varepsilon_{abc}f_c$, $[g_a,g_b]=k\,\varepsilon_{abc}g_c$, $[f_a,g_b]=0$, with one constant $k>0$ for both (an orientation-reversing isometry of $\mathbb R^4$ swaps the ideals and preserves bracket and metric). Put $\kappa=k^2/2$.
- The brief's datum fixes $\kappa$. For $W^+=s\mathop{\mathrm{diag}}(2,-1,-1)$, $W^-=0$, unit means $6s^2=1$, and Passage B's formula gives $P=6s^3+\tfrac12\cdot6\cdot k^2\cdot2s^3=6s^3(1+k^2)=(1+k^2)/\sqrt6$. The brief's $P(W_{\mathbb{CP}^2})=\sqrt{3/2}=3/\sqrt6$ forces $k^2=2$, so $\kappa=1$. As a cross-check, $W^\pm=s\mathop{\mathrm{diag}}(2,-1,-1)$ with $12s^2=1$ gives $P=(1+k^2)/\sqrt{12}=\sqrt3/2=\theta_0(4)$, the balanced product $S^2\times S^2$.
- The Weyl tensors at $n=4$ are exactly the pairs $(W^+,W^-)$ of trace-free symmetric operators on $\Lambda^\pm$.

## Hypothesis inventory

- **H1 (simple spectrum).** Every eigenvalue of $W$ on $\Lambda^2$ is simple. Under H1 the step is VALID (Section 1).
- **H2 (frame-rigid eigenspaces).** Any two orthonormal eigenframes of $W$ have the same table $c'^2$ after a relabelling that preserves $\lambda$. H1 implies H2, and so does $W_{\mathbb{CP}^2}$ at $n=4$ (Section 4). Under H2 the step is VALID.
- **H3 (frame quantifier in the definition).** $\lambda_{\max}(M)$ is read as $\sup$ (or $\inf$) over orthonormal eigenframes of the frame-wise value. This makes the quantity well defined by construction, and it is a change of definition that has to be written into Passage B and Lemma L115.
- Without H1, H2 or H3 the step is false (Section 3).

## 1. Simple spectrum: the step holds

Under H1 an orthonormal eigenbasis is determined up to order and signs, $v_\alpha\mapsto\epsilon_\alpha v_{\pi(\alpha)}$ with $\epsilon_\alpha\in\{\pm1\}$. Then $c'_{\alpha\beta\gamma}\mapsto\epsilon_\alpha\epsilon_\beta\epsilon_\gamma c'_{\pi(\alpha)\pi(\beta)\pi(\gamma)}$, so $c'^2$ is relabelled by $\pi$ and the signs disappear. The vector $\lambda$ is relabelled by the same $\pi$. Hence $M\mapsto P_\pi MP_\pi^{\mathsf T}$ for the permutation matrix $P_\pi$, and the spectrum of $M$, in particular $\lambda_{\max}(M)$, is unchanged. The same computation proves the step under H2.

## 2. What $M$ is, and why a frame can matter

For $x\in\mathbb R^N$ put $X_x=\sum_\alpha x_\alpha v_\alpha v_\alpha^{\mathsf T}$, an element of the eigenframe-diagonal algebra $\mathcal D$. With the convention for $\#$ under which Passage B's formula for $P$ holds, $\langle W,X_x^2\rangle=\sum_\alpha\lambda_\alpha x_\alpha^2$ and $\langle W,X_x^\#\rangle=\tfrac12\sum c'^2_{\alpha\beta\gamma}x_\alpha x_\beta\lambda_\gamma$, so $\langle x,Mx\rangle=\langle W,Q(X_x)\rangle=\langle X_x,L_WX_x\rangle$. So $M$ is the matrix of the compression of $L_W$ to $\mathcal D$ in the orthonormal basis $v_\alpha v_\alpha^{\mathsf T}$, and $\lambda_{\max}(M)=\max\{\langle X,L_WX\rangle: X\in\mathcal D,\ \|X\|=1\}$.

When an eigenvalue of $W$ is repeated, $\mathcal D$ itself depends on the frame: a rotation by $t$ inside a two-dimensional eigenspace $\mathop{\mathrm{span}}(v_1,v_2)$ replaces $v_1v_1^{\mathsf T}-v_2v_2^{\mathsf T}$ in $\mathcal D$ by $\cos2t\,(v_1v_1^{\mathsf T}-v_2v_2^{\mathsf T})+\sin2t\,(v_1v_2^{\mathsf T}+v_2v_1^{\mathsf T})$. The quadratic form $X\mapsto\langle X,L_WX\rangle$ is equivariant only under metric automorphisms of the bracket, and a rotation inside an eigenspace is in general not one. So the maximum of the form over $\mathcal D$ has no reason to be frame independent. Section 3 shows that it is not.

## 3. Closed-form failure at $n=4$

**The family.** Take $W^+=\mathop{\mathrm{diag}}(\mu,a_2,a_3)$ in the basis $f$ and $W^-=\mathop{\mathrm{diag}}(\mu,b_2,b_3)$ in the basis $g$, trace free, so $f_1$ and $g_1$ share the eigenvalue $\mu$. For $t\in\mathbb R$ put $u=\cos t\,f_1+\sin t\,g_1$ and $u'=-\sin t\,f_1+\cos t\,g_1$. Then $(u,u',f_2,f_3,g_2,g_3)$ is an orthonormal eigenframe of $W$ for every $t$, with $\lambda=(\mu,\mu,a_2,a_3,b_2,b_3)$.

**The brackets.** Write $C=\cos^2t$, $S=\sin^2t$. From the conventions,

- $[u,f_2]=k\cos t\,f_3$, $[u,f_3]=-k\cos t\,f_2$, $[u,g_2]=k\sin t\,g_3$, $[u,g_3]=-k\sin t\,g_2$,
- $[u',f_2]=-k\sin t\,f_3$, $[u',f_3]=k\sin t\,f_2$, $[u',g_2]=k\cos t\,g_3$, $[u',g_3]=-k\cos t\,g_2$,
- $[f_2,f_3]=kf_1=k(\cos t\,u-\sin t\,u')$, $[g_2,g_3]=kg_1=k(\sin t\,u+\cos t\,u')$,
- $[u,u']=0$ and $[f_a,g_b]=0$.

So the only nonzero $c'^2$, up to permutation of the three indices, are $c'^2_{u f_2 f_3}=k^2C$, $c'^2_{u' f_2 f_3}=k^2S$, $c'^2_{u g_2 g_3}=k^2S$, $c'^2_{u' g_2 g_3}=k^2C$.

**The matrix.** In the order $(u,u',f_2,f_3,g_2,g_3)$ Passage B's definition gives

$$M_t=\begin{pmatrix}\mu&0&\kappa Ca_3&\kappa Ca_2&\kappa Sb_3&\kappa Sb_2\\0&\mu&\kappa Sa_3&\kappa Sa_2&\kappa Cb_3&\kappa Cb_2\\\kappa Ca_3&\kappa Sa_3&a_2&\kappa\mu&0&0\\\kappa Ca_2&\kappa Sa_2&\kappa\mu&a_3&0&0\\\kappa Sb_3&\kappa Cb_3&0&0&b_2&\kappa\mu\\\kappa Sb_2&\kappa Cb_2&0&0&\kappa\mu&b_3\end{pmatrix}.$$

The entries $\kappa\mu$ come from $\kappa(C+S)\mu$. As a screen of the transcription, $\langle\lambda,M_t\lambda\rangle$ carries the cross term $3k^2(C+S)\mu a_2a_3+3k^2(S+C)\mu b_2b_3$, independent of $t$, as $P$ must be.

**The two frames.** Specialise to a kernel, $\mu=0$, $a_2=a$, $a_3=-a$, $b_2=b$, $b_3=-b$, with $2a^2+2b^2=1$ and $a^2\ne b^2$.

- At $t=0$, $M_0=A_a\oplus A_b$ with $A_a=\begin{pmatrix}0&-\kappa a&\kappa a\\-\kappa a&a&0\\\kappa a&0&-a\end{pmatrix}$. Expanding, $\det(A_a-x)=-x\big(x^2-a^2(1+2\kappa^2)\big)$, so $\lambda_{\max}(M_0)^2=y_0:=\max(a^2,b^2)(1+2\kappa^2)$.
- At $t=\pi/4$, $C=S=\tfrac12$. The vector $(u-u')/\sqrt2$ meets $f_2,f_3,g_2,g_3$ with coefficient $\kappa(C-S)(\cdot)/\sqrt2=0$ and $u,u'$ are uncoupled, so it is an eigenvector for $\mu=0$. On the orthogonal complement, in the order $\big((u+u')/\sqrt2,f_2,f_3,g_2,g_3\big)$, the matrix is $\begin{pmatrix}0&w^{\mathsf T}\\w&D\end{pmatrix}$ with $w=\tfrac{\kappa}{\sqrt2}(-a,a,-b,b)$ and $D=\mathop{\mathrm{diag}}(a,-a,b,-b)$. An eigenvalue $x\notin\mathop{\mathrm{spec}}D$ satisfies $x=\sum_iw_i^2/(x-d_i)=\kappa^2a^2x/(x^2-a^2)+\kappa^2b^2x/(x^2-b^2)$. With $y=x^2$ and $\phi(y)=\kappa^2a^2/(y-a^2)+\kappa^2b^2/(y-b^2)$, every eigenvalue $x>\max(|a|,|b|)$ satisfies $\phi(x^2)=1$. Such an eigenvalue exists, since the root $y_*$ found below gives one, and by Cauchy interlacing the top eigenvalue is at least $\max(|a|,|b|)$. So the top eigenvalue is $\sqrt{y_*}$.

**The comparison.** Say $a^2>b^2$. On $y>a^2$, $\phi$ is strictly decreasing from $+\infty$ to $0$, so $\phi(y)=1$ has exactly one root $y_*$ there. At $y_0=a^2(1+2\kappa^2)$ the first term equals $\tfrac12$, and the second is below $\tfrac12$ because $2\kappa^2b^2<a^2(1+2\kappa^2)-b^2$ is $(1+2\kappa^2)b^2<(1+2\kappa^2)a^2$. So $\phi(y_0)<1$, which puts $y_*<y_0$. Hence

$$\lambda_{\max}(M_{\pi/4})=\sqrt{y_*}<\sqrt{y_0}=\lambda_{\max}(M_0)\qquad\text{for every }\kappa>0\text{ and every }a^2\ne b^2 .$$

**Exact values with $\kappa=1$.**

| Case | $W$ | kernel dimension | $\lambda_{\max}(M_0)$ | $\lambda_{\max}(M_{\pi/4})$ |
|---|---|---|---|---|
| $b=0$ | $W^+=\mathop{\mathrm{diag}}(0,\tfrac1{\sqrt2},-\tfrac1{\sqrt2})$, $W^-=0$ | 4 | $\sqrt{3/2}$ | $1$ |
| $a^2=\tfrac38$, $b^2=\tfrac18$ | $W^+=\mathop{\mathrm{diag}}(0,a,-a)$, $W^-=\mathop{\mathrm{diag}}(0,b,-b)$ | 2 | $\tfrac{3}{2\sqrt2}$ | $\sqrt{(4+\sqrt7)/8}$ |

For $b=0$ the $g$ block of $M_0$ is zero and the root equation reduces to $y=a^2(1+\kappa^2)=1$. For the second row, $\phi(y)=1$ with $\kappa=1$ is $y^2-2(a^2+b^2)y+3a^2b^2=0$, whose larger root is $\tfrac12+\sqrt{\tfrac14-\tfrac9{64}}=(4+\sqrt7)/8$, and $\tfrac98-\tfrac{4+\sqrt7}8=\tfrac{5-\sqrt7}8>0$. In the second row the only repeated eigenvalue of $W$ is $0$, of multiplicity two, which is exactly the "kernel" case the step names.

**Located line.** The failing words are the step's own, "independent of the choice of orthonormal eigenbasis, including when $W$ has repeated eigenvalues or a kernel", applied to Passage B's "In an eigenbasis of $W$, with $c'$ transported there, ... $M(\lambda)_{\alpha\beta}=\delta_{\alpha\beta}\lambda_\alpha+\tfrac12\sum_\gamma c'^2_{\alpha\beta\gamma}\lambda_\gamma$". The notation $M(\lambda)$ presents $M$ as a function of the spectrum, while its entries are squares of frame components, which transform non-linearly under a rotation inside an eigenspace.

## 4. The opposite case, argued

The strongest defence is that frame freedom might act through automorphisms or leave the maximum fixed. It does in these cases, and each is a special case of H2 or of an extra symmetry.

- **Simple spectrum.** Section 1.
- **$W_{\mathbb{CP}^2}$ at $n=4$.** Its eigenspaces are $\mathop{\mathrm{span}}(f_1)$, $\mathop{\mathrm{span}}(f_2,f_3)$ and $\Lambda^-$, each inside one ideal. Every eigenframe is then adapted to $\Lambda^+\oplus\Lambda^-$, and any orthonormal frame of an $\mathfrak{so}(3)$ ideal has $c'^2=k^2|\varepsilon|$. So every eigenframe has the same $c'^2$ table, H2 holds, and $\lambda_{\max}(M)$ is frame independent there.
- **Isospectral halves, one mixed plane.** If $(a_2,a_3)=(b_2,b_3)$, the involution $u\leftrightarrow u'$, $f_j\leftrightarrow g_j$ commutes with $M_t$, and splitting into its $\pm1$ eigenspaces gives $M_t\cong A(1)\oplus A(\cos2t)$, where $A(r)$ is the $3\times3$ matrix $\begin{pmatrix}\mu&\kappa ra_3&\kappa ra_2\\\kappa ra_3&a_2&\kappa\mu\\\kappa ra_2&\kappa\mu&a_3\end{pmatrix}$. $r\mapsto\lambda_{\max}(A(r))$ is convex (top eigenvalue of an affine family) and even (conjugate by $\mathop{\mathrm{diag}}(-1,1,1)$), so its maximum on $[-1,1]$ is at $r=\pm1$ and $\lambda_{\max}(M_t)$ does not move. This covers the rotation of the plane $\mathop{\mathrm{span}}(f_1,g_1)$ at $S^2\times S^2$. It does not cover general frames of the four-dimensional eigenspace $\mathop{\mathrm{span}}(f_2,f_3,g_2,g_3)$ there, which this report leaves open.

What survives in every frame without any hypothesis:

- **The Rayleigh bound.** $\|\lambda\|=1$ and $\langle\lambda,M\lambda\rangle=P=\theta$ in every eigenframe, so $\theta\le\lambda_{\max}(M)$ holds frame by frame.
- **The eigenvalue at a critical point.** $Q(W)=\theta W$ is diagonal in every eigenframe, so $M\lambda=\theta\lambda$ in every eigenframe, as Passage B says.

The counterexample of Section 3 is not a critical point. At $n=4$ a critical point with $\theta>0$ has $W^\pm$ each zero or of the form $r\mathop{\mathrm{diag}}(2,-1,-1)$ with one common $r>0$, since $x_i^2+2x_jx_k=\theta x_i$ on trace-free diagonals forces that shape. So at $n=4$ the critical points are the invariant $W_{\mathbb{CP}^2}$ and the $S^2\times S^2$ tensor of the previous bullet. Whether frame dependence occurs at a global maximiser in higher $n$ is not settled here. Deciding it would take, for a named maximiser with repeated eigenvalues (padded $W_{\mathbb{CP}^2}$ with its kernel of dimension $\binom n2-3$, or $S^m\times S^m$), the supremum and infimum over eigenframes of $\max\{\langle X,L_WX\rangle:X\in\mathcal D,\|X\|=1\}$, and a gap between them would mean "$\lambda_{\max}(M)=\theta$" is true in some frames and false in others.

## 5. Consequence for Lemma L115

Global maximisers in the lemma's scope, padded $W_{\mathbb{CP}^2}$ and $S^m\times S^m$, have repeated eigenvalues and kernels, so the statement "$\lambda_{\max}(M)=\theta$ at every global maximiser" needs a frame quantifier (H3) to be a statement at all. The by-product $\theta\ge\max_\alpha\lambda_\alpha$ needs only one eigenframe in which $\lambda_{\max}(M)=\theta$, because $\mathop{\mathrm{diag}}M=\lambda$ in every frame and $\lambda_\alpha=\langle e_\alpha,Me_\alpha\rangle\le\lambda_{\max}(M)$. The quantity $\sup_W\lambda_{\max}(M)$ in Passage B is likewise frame ambiguous until H3 is written.

## 6. Verdict

**FAILS.** $\lambda_{\max}(M)$ is not well defined at every unit $W$: the unit Weyl tensor $W^+=\mathop{\mathrm{diag}}(0,\tfrac1{\sqrt2},-\tfrac1{\sqrt2})$, $W^-=0$ at $n=4$ gives $\sqrt{3/2}$ in the frame $(f_1,g_1,\dots)$ and $1$ in the frame $\big((f_1+g_1)/\sqrt2,(g_1-f_1)/\sqrt2,\dots\big)$, and a kernel of exact dimension two gives the same failure. A VALID reading needs one of H1 (simple spectrum), H2 (all eigenframes share the $c'^2$ table), or H3 (a $\sup$ or $\inf$ over eigenframes written into the definition).
