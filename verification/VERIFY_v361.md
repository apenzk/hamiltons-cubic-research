# Verifier v361, L115 step F2: $\lambda_{\max}(M)=\theta$ on the coordinate-diagonal locus and at $S^m\times S^m$

Cold brief ([ADJ_L115_F2.md](ADJ_L115_F2.md)), no numerical work, no scripts written, every value exact. Log: [agent_logs/verify-L115-v361.log](../agent_logs/verify-L115-v361.log).

| # | Claim | Verdict |
|---|---|---|
| 1 | Coordinate-diagonal operators are hollow symmetric $S$, Weyl iff $S\mathbf 1=0$ | CONFIRMED ($n\ge3$) |
| 2 | The non-Weyl complement inside the coordinate-diagonal algebra is exactly $\{S_{ij}=u_i+u_j\}$ | CONFIRMED ($n\ge3$) |
| 3 | The Rayleigh quotient there is at most $\tfrac12\lambda_{\max}(K)\le1/\sqrt2$ | CONFIRMED, with $K$ read as the $n\times n$ matrix $\Lambda$ of $W$, exact value in §4 |
| 4 | $1/\sqrt2<\sqrt{3/2}\le\theta$ | CONFIRMED at global maximisers. REFUTED AS STATED at $S^4\times S^4$ and $S^5\times S^5$ ($\theta^2=21/16$ and $36/25$), where only $\theta>1/\sqrt2$ is needed and holds |
| 5 | Unstated: the Weyl and non-Weyl parts do not interact | CONFIRMED, the cross term vanishes identically (§3) |
| 6 | Unstated: the Weyl part is capped at $\theta$ at a coordinate-diagonal global maximiser | CONFIRMED via L24 (§5) |
| 7 | $\lambda_{\max}(M)=\theta$ at every coordinate-diagonal global maximiser | CONFIRMED |
| 8 | $\lambda_{\max}(M)=\theta$ at every $S^m\times S^m$, $m\ge4$, unconditionally | CONFIRMED, for every $m\ge2$, by a direct bound (§6) that the annotation does not carry |

**Summary: the step is VALID in the coordinate frame. "Global" supplies L24 and $\theta\ge1/\sqrt2$, and "$m\ge4$" is not needed.**

## 0. Conventions, fixed once

- $n\ge4$, $N=n(n-1)/2$, $\{e_i\}$ an orthonormal frame of $\mathbb R^n$, $e_{ij}=e_i\wedge e_j$ ($i<j$) the orthonormal coordinate basis of $\Lambda^2$.
- A coordinate-diagonal operator is $D_S=\sum_{i<j}S_{ij}\,e_{ij}\otimes e_{ij}$ with $S$ a hollow symmetric $n\times n$ matrix. Its Frobenius norm is $|D_S|^2=\sum_{i<j}S_{ij}^2=\tfrac12\|S\|_F^2$. $\mathcal D$ is the space of these.
- $W=D_\Lambda$ is a unit coordinate-diagonal Weyl tensor, so $\Lambda$ is hollow symmetric with $\sum_{i<j}\Lambda_{ij}^2=1$, $\|\Lambda\|_F^2=2$. $\mathbf 1$ is the all-ones vector.
- $M=M(\lambda)$ is the matrix of Passage B computed in the coordinate frame. $q(S)=\langle s,Ms\rangle$ where $s$ is the vector $(S_{ij})_{i<j}$.
- Structure constants of $\mathfrak{so}(n)$ in the basis $e_{ij}$: $c'^2_{\alpha\beta\gamma}=1$ when $\alpha,\beta,\gamma$ are the three edges $ij,jk,ik$ of a triangle, and $0$ otherwise. This normalisation is the one in which $I^2+I^\#=(n-1)I$, and §6 checks it independently: it returns $P=\theta_0(2m)$ at the balanced sphere product, as the brief states.

## 1. Hypothesis inventory

- **H1 (frame).** $M$ is computed in the coordinate frame in which $W$ is diagonal. When $W$ has repeated eigenvalues, as $S^m\times S^m$ does, $M$ depends on the eigenframe chosen, and the argument below covers the coordinate frame only. The word "coordinate-diagonal" supplies this frame.
- **H2 (polarisation).** $\tau(X,Y,Z)=\langle X,Y\circ Z\rangle$ is totally symmetric on symmetric operators of $\Lambda^2$, so that $\tau$ is the polarisation of $P$. This is the standard symmetry of $\langle A\#B,C\rangle$ together with trace cyclicity, and L24's Hessian formula $6\theta(L_e-\tfrac12\mathrm{Id})$ presupposes it. It is needed only for §5.
- **H3 (global, for the first clause).** $W$ is a global maximiser. It is used for two things: (a) $W$ is a critical point and a local maximiser with $\theta>0$, so L24 applies, and (b) $\theta=M(n)\ge\sqrt{3/2}>1/\sqrt2$. A local maximiser with $\theta\ge\tfrac12\lambda_{\max}(\Lambda)$ would serve equally.
- **$m\ge4$** is used nowhere. The second clause holds for every $m\ge2$.

## 2. $M$ in the coordinate frame

In the coordinate frame $M_{ij,ij}=\Lambda_{ij}$, and for two planes sharing one index, $M_{ij,ik}=\tfrac12\Lambda_{jk}$ (the only $\gamma$ with $c'^2_{ij,ik,\gamma}\ne0$ is $jk$). Disjoint planes give $0$. Summing the off-diagonal terms triangle by triangle, each triangle $\{i,j,k\}$ contributes $S_{ij}S_{ik}\Lambda_{jk}+S_{ij}S_{jk}\Lambda_{ik}+S_{ik}S_{jk}\Lambda_{ij}$, and $\tfrac12\sum_{j,k}\Lambda_{jk}(S^2)_{jk}$ counts each such term once (apex $i$, unordered base $\{j,k\}$, with $\Lambda$ and $S$ hollow). Hence

$$q(S)=\tfrac12\sum_{i,j}\Lambda_{ij}S_{ij}^2+\tfrac12\mathop{\mathrm{tr}}(\Lambda S^2),\qquad b(S,T)=\tfrac12\sum_{i,j}\Lambda_{ij}S_{ij}T_{ij}+\tfrac12\mathop{\mathrm{tr}}(\Lambda ST)$$

for the associated symmetric bilinear form ($\mathop{\mathrm{tr}}(\Lambda ST)=\mathop{\mathrm{tr}}(\Lambda TS)$ by transposition). Since $q(\Lambda)=P(W)=\theta$ with $|W|=1$, and $\lambda_{\max}(M)=\sup q(S)/|D_S|^2$, the step is equivalent to

$$q(S)\le\theta\,|D_S|^2\quad\text{for every hollow symmetric }S.\tag{$\ast$}$$

## 3. The splitting of $\mathcal D$ and the vanishing cross term

**Weyl condition.** A coordinate-diagonal curvature operator has $R_{ijij}=S_{ij}$ and no other independent component. Every Bianchi sum $R_{ijkl}+R_{jkil}+R_{kijl}$ has a nonzero term only when $\{k,l\}=\{i,j\}$, and then reads $S_{ij}-S_{ij}+0=0$, so the first Bianchi identity holds for every $S$. The Ricci contraction is $\mathrm{Ric}_{ii}=(S\mathbf 1)_i$, $\mathrm{Ric}_{ij}=0$ for $i\ne j$. So $D_S\in\mathcal W_n$ iff $S\mathbf 1=0$. Claim 1 CONFIRMED.

**Complement.** For $U_{ij}=u_i+u_j$ ($i\ne j$), $\langle D_S,D_U\rangle=\sum_{i<j}S_{ij}(u_i+u_j)=\sum_iu_i(S\mathbf 1)_i$. So $\{U\}$ is orthogonal to $\mathcal D_0=\{S\mathbf 1=0\}$. The map $u\mapsto U\mathbf 1=(n-2)u+(\textstyle\sum u)\mathbf 1$ is invertible for $n\ge3$, so $\dim\{U\}=n$ and $\mathcal D_0$ has codimension $n$. Hence $\mathcal D=\mathcal D_0\oplus\{U\}$ orthogonally. Claim 2 CONFIRMED.

**Cross term.** Take $S\in\mathcal D_0$ and write $U=u\mathbf 1^T+\mathbf 1u^T-2D$ with $D=\mathop{\mathrm{diag}}(u)$. Using the symmetry of $\Lambda$ and $S$,

$$\tfrac12\sum_{i,j}\Lambda_{ij}S_{ij}(u_i+u_j)=\sum_iu_i\sum_j\Lambda_{ij}S_{ij}.$$

For the trace term, $U\Lambda=\mathbf 1u^T\Lambda-2D\Lambda$ because $\Lambda\mathbf 1=0$, and $\mathop{\mathrm{tr}}(\mathbf 1u^T\Lambda S)=u^T\Lambda S\mathbf 1=0$, so

$$\tfrac12\mathop{\mathrm{tr}}(\Lambda SU)=\tfrac12\mathop{\mathrm{tr}}(U\Lambda S)=-\mathop{\mathrm{tr}}(D\Lambda S)=-\sum_iu_i\sum_j\Lambda_{ij}S_{ji}.$$

The two cancel, so $b(S,U)=0$ and $q(S+U)=q(S)+q(U)$. This uses only $\Lambda\mathbf 1=0$ and $S\mathbf 1=0$, with no appeal to H2. Claim 5 CONFIRMED. Consequently $(\ast)$ holds iff it holds separately on $\mathcal D_0$ and on $\{U\}$.

## 4. The non-Weyl part in closed form

With $U$ as above and $s=\sum_iu_i$:

- $\tfrac12\sum_{i,j}\Lambda_{ij}(u_i+u_j)^2=\tfrac12\sum_{i,j}\Lambda_{ij}(u_i^2+u_j^2+2u_iu_j)=u^T\Lambda u$, since $\Lambda\mathbf 1=0$ kills the square terms.
- $\mathop{\mathrm{tr}}(\Lambda U^2)$: expanding $(\Lambda u\mathbf 1^T-2\Lambda D)(u\mathbf 1^T+\mathbf 1u^T-2D)$ term by term gives $0+n\,u^T\Lambda u-2u^T\Lambda u-0-2u^T\Lambda u+4\sum_i\Lambda_{ii}u_i^2=(n-4)\,u^T\Lambda u$.
- $|D_U|^2=\tfrac12\sum_{i\ne j}(u_i+u_j)^2=(n-2)|u|^2+s^2$.

Therefore

$$\frac{q(U)}{|D_U|^2}=\frac{(n-2)\,u^T\Lambda u}{2\big((n-2)|u|^2+s^2\big)}\le\tfrac12\lambda_{\max}(\Lambda).$$

$\Lambda$ is symmetric with trace $0$, $\|\Lambda\|_F^2=2$ and $\Lambda\mathbf 1=0$, so its top eigenvalue $\mu_1$ satisfies $\mu_1^2+\mu_1^2/(n-2)\le2$, that is $\tfrac12\lambda_{\max}(\Lambda)\le\tfrac12\sqrt{2(n-2)/(n-1)}<1/\sqrt2$. Claim 3 CONFIRMED, reading the unnamed $K$ as $\Lambda$.

## 5. The Weyl part at a coordinate-diagonal global maximiser

Assume H2 and H3. Then $q(S)=\langle D_S,W\circ D_S\rangle$ for $S\in\mathcal D$, because $\tau$ restricted to $\mathcal D$ is the polarisation of the cubic $x\mapsto\sum x_\alpha^3+\tfrac12\sum c'^2_{\alpha\beta\gamma}x_\alpha x_\beta x_\gamma$, whose Hessian form at $\lambda$ is $x^TM(\lambda)x$.

Take $A\in\mathcal D_0$ and split $A=aW+A'$ with $A'\in\mathcal D_0\cap W^\perp\subseteq\mathcal W_n\cap W^\perp$. Then:

- $q(W)=\theta$.
- The cross term $\langle W,W\circ A'\rangle=\langle W\circ W,A'\rangle=\theta\langle W,A'\rangle=0$, by H2 and $Q(W)=\theta W$.
- $q(A')=\theta\langle A',L_eA'\rangle\le\tfrac\theta2|A'|^2$ by L24, which needs $\theta>0$ and local maximality.

So $q(A)\le\theta a^2+\tfrac\theta2|A'|^2\le\theta|A|^2$. On the complement, §4 gives $q(U)\le\tfrac12\lambda_{\max}(\Lambda)|D_U|^2<\tfrac1{\sqrt2}|D_U|^2<\sqrt{3/2}\,|D_U|^2\le\theta|D_U|^2$, using $\theta=M(n)\ge P(\text{padded }W_{\mathbb{CP}^2})=\sqrt{3/2}$. With §3, $(\ast)$ holds. Claims 4 (at global maximisers), 6 and 7 CONFIRMED.

**What "global" is for.** It provides the local maximality and $\theta>0$ that L24 needs on the Weyl part, and the lower bound $\theta\ge\sqrt{3/2}$ that clears the non-Weyl cap. The second use needs only $\theta\ge\tfrac12\lambda_{\max}(\Lambda)$.

## 6. $S^m\times S^m$, directly and for every $m\ge2$

**The tensor.** $n=2m$ with index blocks $A,B$ of size $m$. The product curvature is $1$ on planes inside a block and $0$ on mixed planes. Removing the part $u_i+u_j$ with $u=\tfrac{m-1}{2(2m-1)}\mathbf 1$ leaves the Weyl part, proportional to $L=mE_{\rm same}-(m-1)E_{\rm mix}$, where $E_{\rm same}=G-I$, $G=\mathbf 1_A\mathbf 1_A^T+\mathbf 1_B\mathbf 1_B^T$, and $E_{\rm mix}=H=\mathbf 1\mathbf 1^T-G$. Row sums are $m(m-1)-(m-1)m=0$. The normalised Weyl part is independent of the radii, since the Weyl tensor is linear in the two sectional curvatures and vanishes for $S^m\times H^m$. Then $\sum_{i<j}L_{ij}^2=m^2(m-1)(2m-1)$, so $\Lambda=\kappa L$ with $\kappa=1/\big(m\sqrt{(m-1)(2m-1)}\big)$.

**$\theta$ from $q$.** The spectrum of $L$ is $0$ on $\mathbf 1$, $2m(m-1)$ on $\mathbf 1_A-\mathbf 1_B$, and $-m$ on the $2m-2$ block-mean-zero vectors. So $\sum_{i,j}L_{ij}^3=2m^2(m-1)(2m-1)$ and $\mathop{\mathrm{tr}}L^3=2m^3(m-1)(2m-1)(2m-3)$, giving $q(L)=m^2(m-1)^2(2m-1)^2$ and

$$\theta=\kappa^3q(L)=\frac{\sqrt{(m-1)(2m-1)}}{m}=\theta_0(2m),$$

which matches the brief and fixes the normalisation of §0. $W$ is critical, because $Q$ is $O(n)$-equivariant and the $O(m)\times O(m)\rtimes\mathbb Z_2$-invariant symmetric operators on $\Lambda^2\mathbb R^m\oplus\Lambda^2\mathbb R^m\oplus(\mathbb R^m\otimes\mathbb R^m)$ that are Weyl form a line. The bound below does not need criticality, since $q(\Lambda)=\theta$ already exhibits $\theta$ as a Rayleigh value.

**The Weyl part without L24.** Let $S=\begin{pmatrix}X&Y\\Y^T&Z\end{pmatrix}\in\mathcal D_0$, with $X,Z$ hollow symmetric. With $\theta/\kappa=(m-1)(2m-1)$, $(\ast)$ on $\mathcal D_0$ reads $F(S)\le(m-1)(2m-1)\|S\|_F^2$, where $F=\sum_{i,j}L_{ij}S_{ij}^2+\mathop{\mathrm{tr}}(LS^2)$.

- $\sum_{i,j}L_{ij}S_{ij}^2=m(\|X\|_F^2+\|Z\|_F^2)-2(m-1)\|Y\|_F^2$.
- $\mathop{\mathrm{tr}}(\mathbf 1\mathbf 1^TS^2)=\|S\mathbf 1\|^2=0$ gives $\mathop{\mathrm{tr}}(HS^2)=-\mathop{\mathrm{tr}}(GS^2)$, hence $\mathop{\mathrm{tr}}(LS^2)=(2m-1)\mathop{\mathrm{tr}}(GS^2)-m\|S\|_F^2$.
- $\mathop{\mathrm{tr}}(GS^2)=\|S\mathbf 1_A\|^2+\|S\mathbf 1_B\|^2=2\|S\mathbf 1_A\|^2=2\big(\|X\mathbf 1\|^2+\|Y^T\mathbf 1\|^2\big)$, since $S\mathbf 1_B=-S\mathbf 1_A$.

Collecting, $F=2(2m-1)\big(\|X\mathbf 1\|^2+\|Y^T\mathbf 1\|^2-\|Y\|_F^2\big)$. The row-sum conditions $X\mathbf 1=-Y\mathbf 1$ and $Z\mathbf 1=-Y^T\mathbf 1$ let the bracket be written symmetrically, and Cauchy–Schwarz on each row ($m-1$ free entries in a hollow row, $m$ in a row of $Y$) gives

$$2\big(\|X\mathbf 1\|^2+\|Y^T\mathbf 1\|^2\big)-2\|Y\|_F^2=\|X\mathbf 1\|^2+\|Y\mathbf 1\|^2+\|Y^T\mathbf 1\|^2+\|Z\mathbf 1\|^2-2\|Y\|_F^2\le(m-1)\|X\|_F^2+2m\|Y\|_F^2+(m-1)\|Z\|_F^2-2\|Y\|_F^2,$$

and the right side is exactly $(m-1)\|S\|_F^2$. Multiplying by $2m-1$ gives $F\le(m-1)(2m-1)\|S\|_F^2$. Equality holds at $S=L$ ($X=Z=m(J-I)$, $Y=-(m-1)J$), as it must.

**The non-Weyl part.** By §4 the cap is $\tfrac12\lambda_{\max}(\Lambda)=\kappa m(m-1)=\sqrt{(m-1)/(2m-1)}$, and $\theta^2$ divided by its square is $(2m-1)^2/m^2\ge1$. So $(\ast)$ holds on $\{U\}$ as well, and §3 joins the parts. Claim 8 CONFIRMED for every $m\ge2$, with no maximality hypothesis.

**Where the written chain fails.** The annotation bounds the complement by "$1/\sqrt2<\sqrt{3/2}\le\theta$". At $S^m\times S^m$, $\theta^2=(m-1)(2m-1)/m^2\ge3/2$ iff $m^2-6m+2\ge0$, that is iff $m\ge6$. At $m=4$, $\theta^2=21/16<3/2$, and at $m=5$, $\theta^2=36/25<3/2$. The link is false there as written. **Arguing the opposite:** the link is used only to reach $\theta>1/\sqrt2$, and $\theta^2\ge1/2$ iff $3m^2-6m+2\ge0$, which holds for every $m\ge2$. The defect is in the inequality quoted and does not reach the conclusion. The annotation also leaves the Weyl part of $S^m\times S^m$ without a source, because "unconditionally" removes the maximality that L24 needs. §6 supplies that part directly.

**What "$m\ge4$" is for.** Nothing in the argument. The display holds at $S^2\times S^2$ and $S^3\times S^3$ by the same computation.

## 7. Verdict

**VALID.** $\lambda_{\max}(M)=\theta$ at every coordinate-diagonal global maximiser, under H1 (M computed in the coordinate frame), H2 (total symmetry of $\langle X,Y\circ Z\rangle$, standard and presupposed by L24) and H3 (global maximality, used for L24 and for $\theta\ge\sqrt{3/2}>1/\sqrt2$). $\lambda_{\max}(M)=\theta$ at every $S^m\times S^m$ under H1 alone, for every $m\ge2$, so "$m\ge4$" is superfluous. The annotation's inequality $\sqrt{3/2}\le\theta$ is false at $m=4,5$, and its Weyl-part cap there has no source, and both are repaired in §6 without changing the display.
