# Verifier v360, λ_max(M) = θ at coordinate-diagonal global maximisers and at S^m×S^m (L115, step F2)

Cold brief ([ADJ_L115_F2.md](ADJ_L115_F2.md)), no numerical work, no scripts written, every value exact. Log: [agent_logs/verify-L115-v360.log](../agent_logs/verify-L115-v360.log).

| # | Claim | Verdict |
|---|---|---|
| C1 | $\langle x,M(\lambda)x\rangle=\langle D_x,L_W D_x\rangle$, so $\lambda_{\max}(M)=\lambda_{\max}$ of $L_W$ compressed to $\mathcal D$ | CONFIRMED |
| C2 | Coordinate-diagonal operators are hollow symmetric $S$, every one is Bianchi, Weyl iff $S\mathbf 1=0$, non-Weyl complement $\{S_{ij}=u_i+u_j\}$ | CONFIRMED |
| C3 | The compression of $L_W$ to $\mathcal D$ has no cross term between the Weyl part and its complement | CONFIRMED (used silently by the annotation) |
| C4 | Rayleigh quotient on the complement is at most $\tfrac12\lambda_{\max}(K)\le1/\sqrt2$, reading $K$ as the hollow matrix $S$ of $W$ | CONFIRMED (sharp: the supremum equals $\tfrac12\lambda_{\max}(S)$, which is $<1/\sqrt2$) |
| C5 | $\lambda_{\max}(M)=\theta$ at every coordinate-diagonal global maximiser, computed in the coordinate frame | CONFIRMED |
| C6 | The annotation's chain $1/\sqrt2<\sqrt{3/2}\le\theta$ at $S^m\times S^m$, $m\ge4$ | REFUTED AS STATED ($\theta^2=21/16$ at $m=4$ and $36/25$ at $m=5$, both below $3/2$) |
| C7 | $\lambda_{\max}(M)=\theta$ at every $S^m\times S^m$, coordinate frame | CONFIRMED, for every $m\ge2$, by a direct closed form that uses neither L24 nor maximality |

**Summary: the display is VALID in the coordinate eigenframe. "Global" is needed at a general coordinate-diagonal point (for L24 and for $\theta\ge\sqrt{3/2}$), and "$m\ge4$" is needed for nothing, but the quoted argument does not reach $S^m\times S^m$ and is replaced here by an exact computation.**

## 0. Conventions, fixed once

- $n\ge4$, $N=\binom n2$. Operators on $\Lambda^2\mathbb R^n$ carry the Frobenius inner product, and the coordinate planes $e_i\wedge e_j$ ($i<j$) are orthonormal.
- A coordinate-diagonal operator with $X(e_i\wedge e_j)=x_{ij}\,e_i\wedge e_j$ is identified with the hollow symmetric $n\times n$ matrix $X=(x_{ij})$, $x_{ii}=0$. Its norm is $|X|^2=\sum_{i<j}x_{ij}^2=\tfrac12\|X\|_F^2$.
- $\mathbf 1$ is the all-ones vector, $J=\mathbf 1\mathbf 1^{\mathsf T}$.
- Structure constants in the coordinate frame: $c'^2_{\alpha\beta\gamma}=1$ when $\alpha,\beta,\gamma$ are the three edges $\{i,j\},\{j,k\},\{i,k\}$ of a triangle, and $0$ otherwise. This is the normalisation of Passage B: it gives $P=\sum_{i<j}S_{ij}^3+3\sum_{i<j<k}S_{ij}S_{jk}S_{ik}$ (six ordered triples per triangle times $\tfrac12$), and it reproduces the record's $\theta_0(2m)$ at the balanced sphere product (Section 5).
- For $W$ coordinate-diagonal with matrix $S$, the diagonal formula for $Q$ is $Q(W)_{ij}=S_{ij}^2+\sum_{k\ne i,j}S_{ik}S_{jk}$, and polarising, $W\circ X$ is coordinate-diagonal with entries $(W\circ X)_{ij}=S_{ij}x_{ij}+\tfrac12(SX+XS)_{ij}$ for $i\ne j$. It is diagonal because the bracket of two coordinate planes is $\pm$ a single coordinate plane or $0$, so $c'_{\alpha\gamma\delta}c'_{\beta\gamma\delta}\ne0$ forces $\alpha=\beta$.
- "The eigenframe" of a coordinate-diagonal $W$ is taken to be the coordinate frame. Section 7 records why this is a hypothesis.

## 1. Hypothesis inventory

- **H1 (frame).** $M(\lambda)$ and $\mathcal D$ are formed in the coordinate eigenframe. When the spectrum of $W$ is simple this is forced up to signs, which do not change $c'^2$. When eigenvalues repeat, as at $S^m\times S^m$, another eigenframe gives another $M$, and the step is proved for the coordinate one.
- **H2 (L24).** Passage C, a given: at a local maximiser with $\theta>0$, $\langle Y,L_eY\rangle\le\tfrac12|Y|^2$ for $Y\in\mathcal W_n\cap W^\perp$.
- **H3 (lower bound).** $M(n)\ge\sqrt{3/2}$ (padded $W_{\mathbb{CP}^2}$, a given).
- **H4 (standard).** The trilinear form $\langle X,Y\circ Z\rangle$ is totally symmetric on symmetric operators on $\Lambda^2$, so $L_W$ is self-adjoint. Proof: $\langle X,\tfrac12(YZ+ZY)\rangle=\tfrac12(\operatorname{tr}XYZ+\operatorname{tr}XZY)$ is invariant under every permutation for symmetric matrices, and $\langle X,Y\#Z\rangle=\tfrac12\sum c'_{\alpha\gamma\delta}c'_{\beta\varepsilon\zeta}X_{\alpha\beta}Y_{\gamma\varepsilon}Z_{\delta\zeta}$ picks up the square of one sign under a permutation of $X,Y,Z$ because $c'$ is totally antisymmetric.
- "Global" enters through H2 (a global maximiser is a local one) and through H3 (at a global maximiser $\theta=M(n)$). The $S^m\times S^m$ clause needs neither.

## 2. M is the compression of L_W to the eigenframe-diagonal algebra (C1)

For $x\in\mathbb R^N$ put $D_x=\sum_\alpha x_\alpha v_\alpha\otimes v_\alpha$, an isometry onto $\mathcal D$. Expanding with the definitions,

$$\langle D_x,W\circ D_x\rangle=\sum_\alpha\lambda_\alpha x_\alpha^2+\langle W,D_x\#D_x\rangle=\sum_\alpha\lambda_\alpha x_\alpha^2+\tfrac12\sum_{\alpha\beta\gamma}c'^2_{\alpha\beta\gamma}\lambda_\gamma x_\alpha x_\beta=\langle x,M(\lambda)x\rangle,$$

using H4 for the middle step and the total symmetry of $c'^2$. Hence $\lambda_{\max}(M)=\sup_{0\ne X\in\mathcal D}\langle X,L_WX\rangle/|X|^2$. At a critical point $M\lambda=\theta\lambda$ (Passage B), so $\lambda_{\max}(M)\ge\theta$ always, and the step is the reverse inequality.

In the coordinate frame the same form reads, for a hollow symmetric $X$,

$$q_S(X)=\sum_{i<j}S_{ij}x_{ij}^2+\tfrac12\operatorname{tr}(SX^2),$$

because the ordered pairs of adjacent edges $(\{i,j\},\{j,k\})$ are in bijection with ordered distinct triples $(i,j,k)$, and hollowness removes the coincident terms. Check: $q_S(S)=\sum_{i<j}S_{ij}^3+3\sum_{\triangle}S_{ij}S_{jk}S_{ik}=P$.

## 3. The diagonal locus splits, with no cross term (C2, C3)

**C2.** A coordinate-diagonal symmetric operator has no component in $\Lambda^4$, since that component is built from entries $R_{ijkl}$ with four distinct indices, all zero. So every hollow symmetric $S$ is an algebraic curvature operator, with $\operatorname{Ric}_{ii}=(S\mathbf 1)_i$ and $\operatorname{Ric}_{ij}=0$ for $i\ne j$. It is Weyl iff $S\mathbf 1=0$. The map $\rho:X\mapsto X\mathbf 1$ satisfies $\langle X\mathbf 1,u\rangle=\sum_{i<j}x_{ij}(u_i+u_j)$, so $\rho^*u=(u_i+u_j)_{i<j}$ and $\mathcal D=\mathcal D_W\oplus\mathcal D_N$ orthogonally, with $\mathcal D_W=\ker\rho$ and $\mathcal D_N=\{x_{ij}=u_i+u_j\}$.

**C3.** The annotation bounds the two pieces separately, which is legitimate only if $\langle A,L_WB\rangle=0$ for $A\in\mathcal D_W$, $B\in\mathcal D_N$. This holds. Let $T=W\circ A$ with $S\mathbf 1=A\mathbf 1=0$. For each $i$,

$$\sum_{j\ne i}T_{ij}=\sum_jS_{ij}A_{ij}+\tfrac12\Big(\big((SA+AS)\mathbf 1\big)_i-(SA+AS)_{ii}\Big)=\sum_jS_{ij}A_{ij}+\tfrac12\big(0-2\textstyle\sum_kS_{ik}A_{ik}\big)=0,$$

since $SA\mathbf 1=0$, $AS\mathbf 1=0$ and $(SA)_{ii}=(AS)_{ii}=\sum_kS_{ik}A_{ik}$. So $T\in\mathcal D_W$, and with H4, $\langle B,L_WA\rangle=\sum_{i<j}T_{ij}(u_i+u_j)=\langle T\mathbf 1,u\rangle=0$. Therefore

$$\lambda_{\max}(M)=\max\Big(\sup_{\mathcal D_W}\frac{q_S}{|\cdot|^2},\ \sup_{\mathcal D_N}\frac{q_S}{|\cdot|^2}\Big).$$

## 4. The non-Weyl part, exactly (C4)

Take $X=u\mathbf 1^{\mathsf T}+\mathbf 1u^{\mathsf T}-2\operatorname{diag}(u)$, the hollow matrix with $x_{ij}=u_i+u_j$, and $S$ hollow with $S\mathbf 1=0$.

- First term: $\sum_{i<j}S_{ij}(u_i+u_j)^2=\sum_iu_i^2(S\mathbf 1)_i+u^{\mathsf T}Su=u^{\mathsf T}Su$.
- Second term: $SX=Su\mathbf 1^{\mathsf T}-2S\operatorname{diag}(u)$, and expanding $\operatorname{tr}(XSX)$ term by term gives $0-0+n\,u^{\mathsf T}Su-2u^{\mathsf T}Su-2u^{\mathsf T}Su+4\sum_iu_i^2S_{ii}=(n-4)\,u^{\mathsf T}Su$.
- So $q_S(X)=\tfrac{n-2}2\,u^{\mathsf T}Su$, and $|X|^2=(n-2)|u|^2+(\mathbf 1^{\mathsf T}u)^2$.

Write $u=c\mathbf 1+w$ with $w\perp\mathbf 1$. Then $u^{\mathsf T}Su=w^{\mathsf T}Sw$ and $|X|^2=(n-2)|w|^2+(2n-2)nc^2$, so

$$\frac{q_S(X)}{|X|^2}=\frac{(n-2)\,w^{\mathsf T}Sw}{2\big((n-2)|w|^2+(2n-2)nc^2\big)}\le\tfrac12\lambda_{\max}(S),$$

with equality at $c=0$ and $w$ a top eigenvector (which lies in $\mathbf 1^\perp$ because $\operatorname{tr}S=0$ forces $\lambda_{\max}(S)\ge0$ and $\mathbf 1$ has eigenvalue $0$). For unit $W$, $\|S\|_F^2=2$ and $\operatorname{tr}S=0$, so $\lambda_{\max}(S)^2\le\tfrac{n-1}n\cdot2$ and

$$\sup_{\mathcal D_N}\frac{q_S}{|\cdot|^2}=\tfrac12\lambda_{\max}(S)\le\tfrac1{\sqrt2}\sqrt{\tfrac{n-1}n}<\tfrac1{\sqrt2}.$$

This is the annotation's bound with $K=S$. The symbol $K$ is undefined in the passages, and this is the reading under which "$\tfrac12\lambda_{\max}(K)\le1/\sqrt2$" is true.

## 5. The clause at a coordinate-diagonal global maximiser (C5)

- **Weyl part.** $W\in\mathcal D_W$. For $A=aW+A'$ with $A'\in\mathcal D_W\cap W^\perp\subseteq\mathcal W_n\cap W^\perp$, the cross term is $\langle L_WW,A'\rangle=\langle Q(W),A'\rangle=\theta\langle W,A'\rangle=0$, using $W\circ W=Q(W)$. H2 gives $\langle A',L_WA'\rangle\le\tfrac\theta2|A'|^2$. So $q_S(A)\le\theta a^2+\tfrac\theta2|A'|^2\le\theta|A|^2$, with equality at $A=W$, and the Weyl supremum is exactly $\theta$. This needs $\theta>0$ and local maximality.
- **Non-Weyl part.** Section 4 gives a supremum $<1/\sqrt2<\sqrt{3/2}\le M(n)=\theta$ by H3.
- By Section 3, $\lambda_{\max}(M)=\theta$.

**What "global" is for.** It supplies H2 (global implies local) and $\theta\ge\sqrt{3/2}$. At a merely local coordinate-diagonal maximiser the same proof goes through under the explicit condition $\theta\ge\tfrac12\lambda_{\max}(S)$, and nothing in the passages supplies that condition without the value $M(n)$.

## 6. The clause at S^m×S^m (C6, C7)

**The object.** $n=2m$, blocks $B_1,B_2$ of size $m$. The Weyl part of the product of round spheres is coordinate-diagonal with $S_{ij}=ms$ inside a block and $-(m-1)s$ across, that is $S=s\big((2m-1)E-mI-(m-1)J\big)$ with $E$ the block-diagonal ones matrix. Row sums are $(m-1)ms-m(m-1)s=0$. Unit norm gives $m^2(m-1)(2m-1)s^2=1$.

**Critical, with $\theta=\theta_0(2m)$.** Inside a block $Q_{ij}=m^2s^2+(m-2)m^2s^2+m(m-1)^2s^2=m(m-1)(2m-1)s^2=(m-1)(2m-1)s\cdot ms$. Across, $Q_{ij}=(m-1)^2s^2-2(m-1)\cdot m(m-1)s^2=(m-1)(2m-1)s\cdot\big(-(m-1)s\big)$. So $Q(W)=\theta W$ with

$$\theta=(m-1)(2m-1)s=\frac{\sqrt{(m-1)(2m-1)}}m=\frac{\sqrt{2(2m-1)(2m-2)}}{2m}=\theta_0(2m).$$

**C6, the annotation's chain.** $\theta^2\ge3/2\iff m^2-6m+2\ge0\iff m\ge3+\sqrt7$. At $m=4$, $\theta^2=21/16<3/2$, and at $m=5$, $\theta^2=36/25<3/2$. So "$\sqrt{3/2}\le\theta$" is false at $S^4\times S^4$ and $S^5\times S^5$. The argument also reaches $S^m\times S^m$ only through L24, and the passages do not supply local maximality of $S^m\times S^m$. The quoted argument therefore does not establish the second clause. The clause is nonetheless true, as follows.

**C7, non-Weyl part.** The spectrum of $S$ is $0$ on $\mathbf 1$, $s\big((2m-1)m-m\big)=2m(m-1)s$ on $\mathbf 1_{B_1}-\mathbf 1_{B_2}$, and $-ms$ on vectors summing to zero inside a block. By Section 4 the supremum is $m(m-1)s$, and $m(m-1)s<(m-1)(2m-1)s=\theta$ for every $m\ge2$.

**C7, Weyl part, without L24.** Let $A\in\mathcal D_W$ and put $v=A\mathbf 1_{B_1}$. Since $JA=0$ and $A\mathbf 1_{B_2}=-v$, $\operatorname{tr}(JA^2)=0$ and $\operatorname{tr}(EA^2)=2|v|^2$. Writing $\sigma_s,\sigma_x$ for the within-block and cross-block parts of $|A|^2$,

$$q_S(A)=s\big[m\sigma_s-(m-1)\sigma_x+(2m-1)|v|^2-m(\sigma_s+\sigma_x)\big]=(2m-1)s\,\big(|v|^2-\sigma_x\big),\qquad\frac{q_S(A)}{\theta|A|^2}=\frac{|v|^2-\sigma_x}{(m-1)|A|^2}.$$

Let $C$ be the $m\times m$ cross block, $p=C\mathbf 1$, $p'=C^{\mathsf T}\mathbf 1$, $\Sigma=\mathbf 1^{\mathsf T}C\mathbf 1$, $c^2=\|C\|_F^2=\sigma_x$, $X=|p|^2+|p'|^2$. Row sums give $v=(-p,\,p')$, so $|v|^2=X$, and the block $A_1$ is hollow symmetric with $A_1\mathbf 1=-p$ (likewise $A_2\mathbf 1=-p'$).

- For $m\ge3$ the minimum of $\sum_{i<j}(A_1)_{ij}^2$ under $A_1\mathbf 1=-p$ is $\langle p,((m-2)I+J)^{-1}p\rangle=\big(|p|^2-\tfrac{\Sigma^2}{2m-2}\big)/(m-2)$, attained at $(A_1)_{ij}=w_i+w_j$. So $\sigma_s\ge\big(X-\tfrac{\Sigma^2}{m-1}\big)/(m-2)$.
- Cauchy–Schwarz gives $\Sigma^2\le m\min(|p|^2,|p'|^2)\le\tfrac m2X$ and $X\le2m\,c^2$.
- Hence $\sigma_s\ge\tfrac{X}{2(m-1)}$. For $m=2$ each $2\times2$ block carries a single entry, $p,p'$ are forced constant, $X=\Sigma^2$ and $\sigma_s=X/2$, the same inequality.

When $|v|^2\le\sigma_x$ the ratio is $\le0$. Otherwise, with $t=X/c^2\in(1,2m]$,

$$\frac{|v|^2-\sigma_x}{|A|^2}\le\frac{t-1}{1+t/(2m-2)}\le\frac{2m-1}{1+m/(m-1)}=m-1,$$

because $t\mapsto(t-1)/(1+t/(2m-2))$ has derivative of the sign of $1+\tfrac1{2m-2}>0$. So $q_S(A)\le\theta|A|^2$ on $\mathcal D_W$, with equality at $A=W$ (constant $C$, $t=2m$).

**Conclusion.** $\lambda_{\max}(M)=\theta$ at $S^m\times S^m$ in the coordinate frame for every $m\ge2$, with no maximality hypothesis. "Unconditionally" is correct, and "$m\ge4$" is needed for nothing.

## 7. Arguing the opposite

- **Could the cross term in Section 3 be nonzero?** It would be if $L_W$ moved Weyl diagonal operators off the zero-row-sum hyperplane. The row-sum identity for $T=W\circ A$ is exact and uses only $S\mathbf 1=A\mathbf 1=0$ and hollowness, so it is not.
- **Could the frame matter?** Yes, and this is the real scope condition. At $S^m\times S^m$ the eigenspaces are $\Lambda^2\mathbb R^m\oplus\Lambda^2\mathbb R^m$ and $\mathbb R^m\otimes\mathbb R^m$, and rotating the frame inside them changes $c'^2$, hence $M$ and $\mathcal D$. Sections 3 to 6 use the coordinate frame throughout, the non-Weyl complement of a rotated $\mathcal D'$ is no longer of Kulkarni–Nomizu type $u_i+u_j$, and the passages give no route to that case. The display is proved under H1, and whether it survives another eigenframe is left open here.
- **Could "global" be dropped at a general coordinate-diagonal point?** Only with a replacement for $\theta\ge\tfrac12\lambda_{\max}(S)$ and for L24's local maximality. Neither follows from criticality in the passages.
- **Does the $C_5$ remark contradict anything?** No. $1/\sqrt2<0.809017$ only says the top of $M$ there is not on a non-Weyl diagonal direction, and the $C_5$ blow-up is outside the coordinate-diagonal clause.

## 8. Verdict

**VALID**, under H1 (the eigenframe is the coordinate frame), H2 (Lemma L24), H3 ($M(n)\ge\sqrt{3/2}$) and the standard H4.

- At a coordinate-diagonal global maximiser, $\lambda_{\max}(M)=\theta$. "Global" is used twice: L24 needs a local maximiser, and the non-Weyl supremum $\tfrac12\lambda_{\max}(S)<1/\sqrt2$ is beaten by $\theta=M(n)\ge\sqrt{3/2}$. The argument also needs the vanishing cross term of Section 3, which the annotation uses without stating and which holds.
- At $S^m\times S^m$, $\lambda_{\max}(M)=\theta=\theta_0(2m)$ for every $m\ge2$. The annotation's route fails there as written ($\sqrt{3/2}\le\theta$ is false at $m=4,5$, and L24's maximality is unsupplied), and the closed form of Section 6 establishes the clause directly. The restriction $m\ge4$ is not needed.
