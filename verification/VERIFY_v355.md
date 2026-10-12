# Verifier v355, Lemma L115: λ_max(M)=θ at every global maximiser (heading and restricted display), the step from Lemma L24, the closing cap, the two Conjecture A comparisons, the by-product θ ≥ max_α λ_α, and the Lean files

Cold brief ([BRIEF_L115.md](BRIEF_L115.md)), no numerical work, no scripts written, every value below exact and derived by hand. One imported theorem read at source: [Böhm–Wilking equation (6)](https://arxiv.org/abs/math/0606187). Log: [agent_logs/verify-L115-v355.log](../agent_logs/verify-L115-v355.log).

| # | Claim | Verdict |
|---|---|---|
| 1 | Heading: $\lambda_{\max}(M)=\theta$ at every global maximiser (unrestricted) | GAP |
| 2 | The step from Lemma L24 to $\lambda_{\max}(L_e\vert_{\mathcal D})=1$ (graded GAP by the record) | GAP (record's grading confirmed) |
| 3 | Restricted display: $\lambda_{\max}(M)=\theta$ at every coordinate-diagonal global maximiser and at every $S^m\times S^m$, $m\ge4$ | GAP |
| 4 | "What would close it is a cap on $\lambda_{\max}(L_W\vert_{\mathcal W_n^\perp})$" | GAP (sufficiency holds at level $\theta$, argument not on file) |
| 5 | $\sup_W\lambda_{\max}(M)\le\theta_0$ is strictly stronger than Conjecture A | GAP |
| 6 | The pointwise statement at maximisers is Conjecture A rewritten | GAP |
| 7 | By-product $\theta\ge\max_\alpha\lambda_\alpha$ at a global maximiser | CONFIRMED (strict, by the norm route) |
| 8 | Passage B facts used: $\operatorname{diag}M=\lambda$, $M\lambda=\theta\lambda$, $\theta\le\lambda_{\max}(M)$ | CONFIRMED AS ALGEBRA |
| 9 | Well-posedness of $\lambda_{\max}(M)$ at repeated eigenvalues and $\ker W\ne0$ | GAP (eigenbasis quantifier missing) |
| 10 | Lean files against clauses 1 and 2 | CONFIRMED AS ALGEBRA (clause 2 only, clause 1 untyped) |

**Round action:** retitle L115 to its by-product (clause 2, proven) and record clause 1 as an open statement with the eigenbasis quantifier, the cap level $\theta$ and the block-diagonality argument of section 4 written in, since what remains is exactly $\lambda_{\max}\big(L_e\vert_{P_{\mathcal W_n^\perp}\mathcal D}\big)\le1$.

## 0. Conventions, fixed once

- $\mathcal W_n$ is the space of algebraic Weyl operators on $\Lambda^2\mathbb R^n$, $N=n(n-1)/2$, admissible for $n\ge4$. Frobenius inner product. $X\circ Y=\tfrac12(XY+YX)+X\#Y$, so $X\circ X=Q(X)=X^2+X^\#$ and $L_W X=W\circ X$.
- The trilinear form $\langle X,Y\circ Z\rangle$ is fully symmetric on symmetric operators, since $\operatorname{tr}(X(YZ+ZY))/2$ and $\langle X,Y\#Z\rangle$ both are. Hence $L_W$ is a symmetric operator on $S^2(\Lambda^2)$.
- $\{v_\alpha\}$ is an orthonormal eigenbasis of $W$, $\lambda$ its spectrum, $c'_{\alpha\beta\gamma}$ the structure constants of $\mathfrak{so}(n)$ in that basis, totally antisymmetric, and $c'^2_{\alpha\beta\gamma}=(c'_{\alpha\beta\gamma})^2$, totally symmetric. $\mathcal D=\mathcal D(\{v_\alpha\})$ is the span of $v_\alpha v_\alpha^{T}$. For $x\in\mathbb R^N$ write $X=\sum_\alpha x_\alpha v_\alpha v_\alpha^T$, so $\lVert X\rVert=\lVert x\rVert$.
- The # convention is the one Passage B's formula for $P$ fixes: $(X\#X)_{\gamma\gamma}=\tfrac12\sum_{\alpha\beta}c'^2_{\alpha\beta\gamma}x_\alpha x_\beta$ for $X\in\mathcal D$. In the coordinate basis $e_i\wedge e_j$ this is Hamilton's $(R^\#)_{ij}=\sum_{k\ne i,j}R_{ik}R_{jk}$ ([Böhm–Wilking line 271](https://arxiv.org/abs/math/0606187)), so $c'^2=1$ exactly on triples of coordinate planes $\{ij\},\{jk\},\{ik\}$ and $0$ otherwise, and $M_{\{ij\},\{jk\}}=\tfrac12\lambda_{ik}$.
- $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$. $\theta_0(n)<\sqrt{3/2}$ iff $4(n^2-3n+2)<3n^2$ iff $n^2-12n+8<0$ iff $n<6+2\sqrt7\approx11.29$. So $\theta_0<\sqrt{3/2}$ at $4\le n\le11$ and $\theta_0>\sqrt{3/2}$ at $n\ge12$ (check: $\theta_0(11)^2=180/121<3/2<220/144=\theta_0(12)^2$).
- **The identity every section uses.** For $X\in\mathcal D$, $\langle X,L_WX\rangle=\operatorname{tr}(WX^2)+\langle X,W\#X\rangle=\sum_\alpha\lambda_\alpha x_\alpha^2+\langle W,X\#X\rangle=\sum_\alpha\lambda_\alpha x_\alpha^2+\tfrac12\sum c'^2_{\alpha\beta\gamma}x_\alpha x_\beta\lambda_\gamma=x^TM(\lambda)x$. So **$M(\lambda)$ is the compression of $L_W$ to $\mathcal D$**, and $\lambda_{\max}(M)=\theta\,\lambda_{\max}(P_{\mathcal D}L_e\vert_{\mathcal D})$. This is the record's own reformulation in Passage A, written out.

## 1. Hypothesis inventory

| Hypothesis | Where stated | Object it is applied to | Checked | Used by the written proof |
|---|---|---|---|---|
| $W$ a global maximiser, $P(W)=M(n)$ | L115 heading | every clause | exists by compactness of the unit sphere | used only by the by-product's norm route (section 7). The equality clause never uses globality, only local maximality through L24. Stated, unused by clause 1 |
| $W$ coordinate-diagonal | restricted display | clause 1 as displayed | no argument uses it (section 3) | unused |
| $m\ge4$ for $S^m\times S^m$ | restricted display | $S^m\times S^m$ | no argument uses it, and the claim holds at every $m\ge2$ in the coordinate eigenbasis (section 3) | unused |
| L24: $W$ critical, $\theta=P(W)>0$, local maximiser | [second-order.md line 61](../findings/second-order.md#L61) | a global maximiser | critical by Lagrange, $\theta=M(n)\ge\sqrt{3/2}>0$, local maximiser. All hold | used, but its conclusion lives on $\mathcal W_n\cap W^\perp$ only (section 2) |
| $Q(W)=\theta W$ with $Q$ unprojected | definitions, Passage B | $M\lambda=\theta\lambda$ | holds because $Q(\mathcal W_n)\subseteq\mathcal W_n$: [Böhm–Wilking (6)](https://arxiv.org/abs/math/0606187) gives $\operatorname{Ric}(R^2+R^\#)_{ij}=\sum_k\operatorname{Ric}_{kk}R_{kijk}$, zero for Weyl $R$ | used, unstated reason supplied here |
| $\lVert\lambda\rVert=1$ | Passage B | Rayleigh bound, norm route | $\lVert W\rVert_F^2=\sum\lambda_\alpha^2$ | used |
| $M(n)\ge\sqrt{3/2}$ (padded $W_{\mathbb{CP}^2}$) | brief, a given | norm route | at $n=4$: $W^+=\operatorname{diag}(2,-1,-1)/\sqrt6$, $P=9\lambda_1\lambda_2\lambda_3=18/(6\sqrt6)=\sqrt{3/2}$. Padding preserves Bianchi and $\operatorname{Ric}=0$ | used by the Lean route only, the prose never cites it |
| a choice of eigenbasis | Passage B "in an eigenbasis of $W$" | every appearance of $M$ | $M$ depends on the choice when eigenvalues repeat (section 9) | used, never quantified |

## 2. The step from Lemma L24 to $\lambda_{\max}(L_e\vert_{\mathcal D})=1$

**Located.** [bounds-relaxations.md line 288](../findings/bounds-relaxations.md#L288): "The step to $\lambda_{\max}(L_e|_{\mathcal D})=1$ reads that cap over the whole eigenframe-diagonal algebra $\mathcal D$ ... that is the step Lemma L115 grades a GAP".

**Failure exhibited.** L24 ([line 61](../findings/second-order.md#L61)) bounds the Rayleigh quotient of $L_e$ on $\mathcal W_n\cap W^\perp$. $\mathcal D\not\subseteq\mathcal W_n$ for every eigenbasis: $I=\sum_\alpha v_\alpha v_\alpha^T\in\mathcal D$ and $\operatorname{Ric}(I)=(n-1)g\ne0$. In the coordinate frame $\mathcal D$ is the coordinate-diagonal operators, all Bianchi, with $\operatorname{Ric}_{ii}=\sum_jx_{ij}$, so $\mathcal D\cap\mathcal W_n=\{x:\sum_jx_{ij}=0\ \forall i\}$ of codimension $n$. The $\tfrac12$ cap itself does not survive on $\mathcal D$: at $S^m\times S^m$ (a critical point, section 3) the direction $X=I_{\Lambda^2V_1}-I_{\Lambda^2V_2}\in\mathcal D\cap W^\perp$ has $\langle X,L_eX\rangle/\lVert X\rVert^2=m/(2m-1)>\tfrac12$ for every $m$. This $X$ equals $\tfrac12\,h\owedge g$ with $h=\operatorname{diag}(I_m,-I_m)$ traceless, so it is pure $\operatorname{Ric}_0$, orthogonal to $\mathcal W_n$. Wherever $S^m\times S^m$ is a local maximiser, reading L24's cap over $\mathcal D$ is therefore false as a $\tfrac12$ cap, although the weaker $\le1$ that the step needs survives there.

**Charitable reading.** The record does not assert the step, it grades it GAP. That grading is correct: nothing on file bounds $L_e$ on the part of $\mathcal D$ orthogonal to $\mathcal W_n$. Finding: the record's GAP stands, sharpened by the witness that the $\tfrac12$ level fails on $\mathcal D$.

## 3. The restricted display

**Located.** [line 290](../findings/bounds-relaxations.md#L290): "$\lambda_{\max}(M)=\theta$ at every COORDINATE-DIAGONAL global maximiser, and at every $S^m\times S^m$, $m\ge4$", introduced by "So" at the end of line 288.

**The argument on file.** Line 288 establishes only that the unrestricted step fails. It gives no reason why coordinate-diagonality restores the bound, and in the coordinate frame $\mathcal D$ still contains the $n$-dimensional non-Weyl block $\{h\owedge g:h\text{ diagonal}\}$ on which L24 says nothing. **This claim has no argument on file.** What would have to be proved: for every coordinate-diagonal global maximiser and every diagonal $h$, $\langle h\owedge g,L_e(h\owedge g)\rangle\le\lVert h\owedge g\rVert^2$ (by section 4 this block decouples from $\mathcal W_n$, so that is the whole statement).

**Why global maximality and $m\ge4$.** No step on file uses either. $S^m\times S^m$ at $m=4,5$ ($n=8,10$) is not a global maximiser, since $\theta_0(n)<\sqrt{3/2}\le M(n)$ there, so the second clause is a statement about particular critical points rather than an instance of the first.

**The class is unwitnessed.** At $n=4$ every global maximiser is $W^\pm$ of $\mathbb{CP}^2$ type ($P=P(W^+)+P(W^-)\le\sqrt{3/2}(\lvert W^+\rvert^3+\lvert W^-\rvert^3)\le\sqrt{3/2}$, equality iff one half vanishes and the other is $\operatorname{diag}(2,-1,-1)/\sqrt6$). Its simple top eigenvector $(e_{12}+e_{34})/\sqrt2$ has $\omega\wedge\omega\ne0$, so it is not decomposable and $W$ is coordinate-diagonal in no frame. The coordinate-diagonal clause is empty at $n=4$, and no member is exhibited at any $n$. Padded $W_{\mathbb{CP}^2}$ fails coordinate-diagonality at every $n$ for the same reason.

**Test against $S^m\times S^m$ in the coordinate eigenbasis, all $m\ge2$.** Split $\{1,\dots,2m\}=V_1\sqcup V_2$. The Weyl operator is $a$ on planes inside a factor and $b$ on mixed planes, with $a=m/(2m-1)$, $b=-(m-1)/(2m-1)$ (trace $m(m-1)a+m^2b=0$). Criticality in this scaling: on an inside plane $a^2+(m-2)a^2+mb^2=\theta a$, on a mixed plane $b^2+2(m-1)ab=\theta b$, both giving $\theta=m-1$. Normalising by $\lVert\lambda\rVert^2=m^2(m-1)/(2m-1)$ gives $\theta=\sqrt{(m-1)(2m-1)}/m=\theta_0(2m)$, matching the record. $M$ commutes with $S_m\times S_m\rtimes\mathbb Z_2$. Decomposing edge functions:

| Sector | Dimension | Eigenvalues of $M$ (scale $\theta=m-1$) |
|---|---|---|
| invariant, $p=q$ | 2 | $\theta$ (eigvector $\lambda$), $0$ (eigvector $I$) |
| invariant, $p=-q$, $s=0$ | 1 | $(m-1)a=m(m-1)/(2m-1)$ |
| $\mathrm{std}\otimes\mathrm{triv}$ and $\mathrm{triv}\otimes\mathrm{std}$ | $2(m-1)$ each | roots of $\begin{pmatrix}(m-2)a/2&mb/2\\(m-2)b/2&b+(m-2)a/2\end{pmatrix}$ |
| $(m-2,2)$ inside $V_1$ or $V_2$ | $m(m-3)/2$ each | $0$ |
| $\mathrm{std}\otimes\mathrm{std}$ on mixed planes | $(m-1)^2$ | $b-a=-1$ |

Dimensions sum to $3+4(m-1)+m(m-3)+(m-1)^2=m(2m-1)=N$. For the standard block, trace $=(m^2-3m+1)/(2m-1)$ and determinant $=-m(m-2)/(4(2m-1))$, so the top root is below $m-1$ iff $m(m-2)\le4(m-1)\big[(m-1)(2m-1)-(m^2-3m+1)\big]=4m^2(m-1)$, true for all $m\ge2$ (at $m=2$ the inside-factor part of this sector is zero and the root is $b=-1/3$). Also $(m-1)a<m-1$. **So in the coordinate eigenbasis $\lambda_{\max}(M)=\theta$, simple, at every $m\ge2$.** At $m=2$ the spectrum is $\{1,\tfrac23,0,-\tfrac13,-\tfrac13,-1\}$.

**Three-step record.** Located (line 290). Exhibited: no argument on file, the class is empty at $n=4$, and the $m\ge4$ and globality restrictions are unused. Charitable reading: the $S^m\times S^m$ clause is true in the coordinate eigenbasis for all $m\ge2$, so it is not false, only unproven on file and over-restricted. Finding stands as GAP.

## 4. "What would close it is a cap on $\lambda_{\max}(L_W\vert_{\mathcal W_n^\perp})$"

**Located.** [line 292](../findings/bounds-relaxations.md#L292).

**Would it suffice.** Yes, at level $\theta$, by an argument absent from the record. By [Böhm–Wilking (6)](https://arxiv.org/abs/math/0606187), $Q(\mathcal W_n)\subseteq\mathcal W_n$ (Hamilton's Bianchi preservation plus vanishing Ricci), and polarising gives $\mathcal W_n\circ\mathcal W_n\subseteq\mathcal W_n$, which Böhm–Wilking use in the same form ([lines 297–300](https://arxiv.org/abs/math/0606187)). So $L_e$ maps $\mathcal W_n$ into itself and, being symmetric, maps $\mathcal W_n^\perp$ into itself. For $X\in\mathcal D\cap W^\perp$ write $X=Y+Z$, $Y\in\mathcal W_n$, $Z\in\mathcal W_n^\perp$. Then $\langle Y,W\rangle=\langle X,W\rangle=0$, the cross term $\langle Y,L_eZ\rangle=\langle L_eY,Z\rangle$ vanishes, and $\langle X,L_eX\rangle\le\tfrac12\lVert Y\rVert^2+c\lVert Z\rVert^2\le\lVert X\rVert^2$ whenever $c=\lambda_{\max}(L_e\vert_{\mathcal W_n^\perp})\le1$, that is $\lambda_{\max}(L_W\vert_{\mathcal W_n^\perp})\le\theta$. Together with $M\lambda=\theta\lambda$ this gives $\lambda_{\max}(M)=\theta$ at every local maximiser. Consistency check: $L_eI=e+e\#I=e-e=0$ by [Böhm–Wilking Lemma 2.1](../references/boehm-wilking-2008-space-forms/notes.md) ($W\#I=-W$), matching the eigenvalue $0$ on $I$ in section 3.

**Candidate that was considered.** A nonzero cross block $P_{\mathcal W_n}L_eP_{\mathcal W_n^\perp}$ would make a $\perp$ cap insufficient. Withdrawn: the cross block is zero by the invariance above.

**Finding.** The record names neither the level of the cap nor the decoupling that makes it sufficient, so the sufficiency claim has no argument on file. What is needed is one paragraph (the one above) and the level $\theta$. The cap itself need only hold on $P_{\mathcal W_n^\perp}\mathcal D$, which is weaker. GAP.

## 5. "$\sup_W\lambda_{\max}(M)\le\theta_0$ is strictly stronger than Conjecture A"

**Located.** [line 294](../findings/bounds-relaxations.md#L294): "is strictly stronger than Conjecture A: the $C_5$ blow-up carries ratio $1.206$ while its $\theta$ sits far below $\theta_0$."

**What holds.** $P(W)=\langle\lambda,M\lambda\rangle\le\lambda_{\max}(M)$ for every unit $W$, critical or not, so the sup bound implies $M(n)\le\theta_0(n)$. That direction is CONFIRMED AS ALGEBRA.

**Failure exhibited.** "Strictly" needs a $W$ with $\lambda_{\max}(M(W))>\theta_0(n)$ at an $n$ where Conjecture A is asserted. The offered witness gives a ratio $\lambda_{\max}/\theta>1$, which is a different quantity: its $\lambda_{\max}(M)=0.809017$ is below $\theta_0(4)=\sqrt3/2$, and $\theta_0$ increases with $n$, so it exceeds $\theta_0(n)$ at no $n\ge4$. Those figures are run output (HYPOTHESIS-DEBT in this loop) and even granted they do not witness the claim. At $4\le n\le11$ the target is false outright in closed form: padded $W_{\mathbb{CP}^2}$ has $\lambda_{\max}(M)\ge\theta=\sqrt{3/2}>\theta_0(n)$. There it is not a strengthening of anything, and Passage B's own display restricts Conjecture A to $n\ge12$. At odd $n$ no balanced sphere product exists, and nothing on file addresses the target there.

**Charitable reading.** "Strictly stronger" may mean only "not known to be equivalent". As written it asserts a separation with a witness that does not separate. GAP: no argument on file that the converse fails at any $n\ge12$.

## 6. "The pointwise statement at maximisers ... is Conjecture A rewritten, neither easier nor harder"

**Located.** Line 294. Reading the pointwise statement as "$\lambda_{\max}(M(W^*))\le\theta_0$ at every global maximiser $W^*$".

**Exhibited.** Pointwise $\Rightarrow$ Conjecture A: $M(n)=\theta(W^*)\le\lambda_{\max}(M(W^*))\le\theta_0$, unconditional. Conjecture A $\Rightarrow$ pointwise needs $\lambda_{\max}(M(W^*))\le\theta(W^*)$, which is clause 1, the direction the record calls not citable. At $4\le n\le11$ the pointwise statement is false (section 5), consistent with Conjecture A being restricted to $n\ge12$.

**Charitable reading.** If clause 1 were proven the equivalence would hold at each $n\ge12$. As written it is used as established. "Neither easier nor harder" is an assessment with no mathematical content to check. GAP.

## 7. The by-product $\theta\ge\max_\alpha\lambda_\alpha$

**Route 1, the one written** (line 294): $\operatorname{diag}M=\lambda$ and $\lambda_{\max}(M)=\theta$. $M_{\alpha\alpha}=\lambda_\alpha+\tfrac12\sum_\gamma c'^2_{\alpha\alpha\gamma}\lambda_\gamma=\lambda_\alpha$ because $c'_{\alpha\alpha\gamma}=0$ by antisymmetry, so $\lambda_\alpha=e_\alpha^TMe_\alpha\le\lambda_{\max}(M)$. The remaining inequality $\lambda_{\max}(M)\le\theta$ is clause 1, GAP. Route 1 is conditional.

**Route 2, on file in the Lean** ([theta_gt_lambda](../lean/HamiltonsCubic/Results/L115Statement.lean)): $\lambda_\alpha^2\le\sum\lambda_\beta^2=1$ gives $\lambda_\alpha\le1<\sqrt{3/2}\le M(n)=\theta$ at a global maximiser. Every hypothesis holds at every $n\ge4$ with the given $M(n)\ge\sqrt{3/2}$. It is strict with margin $\theta-\lambda_\alpha\ge\sqrt{3/2}-1>0.2247$ ($1.2247^2=1.49989\le3/2$). It uses global maximality essentially: at a critical point with small $\theta$ nothing follows.

**Finding.** The conclusion is CONFIRMED, strictly, by route 2. The prose argues it by route 1, which rests on the GAP. The record should cite route 2.

## 8. Passage B facts

- $M$ symmetric: $c'^2$ totally symmetric. CONFIRMED.
- $P=\langle\lambda,M\lambda\rangle$ and $\theta\le\lambda_{\max}(M)$ for unit $W$: section 0 identity at $X=W$. CONFIRMED.
- $M\lambda=\theta\lambda$ at a critical point: $(M\lambda)_\alpha=\lambda_\alpha^2+\tfrac12\sum_{\beta\gamma}c'^2_{\alpha\beta\gamma}\lambda_\beta\lambda_\gamma=Q(W)_{\alpha\alpha}=\theta\lambda_\alpha$. This needs the unprojected $Q(W)=\theta W$, true by $Q(\mathcal W_n)\subseteq\mathcal W_n$ ([Böhm–Wilking (6)](https://arxiv.org/abs/math/0606187)). CONFIRMED AS ALGEBRA, with that reason supplied.
- Passage A's gloss of L24, "$\sigma(L_e|_{W^\perp})\subseteq(-\infty,\tfrac12]$ with $1$ simple", is internally loose ($1$ is not in a set bounded by $\tfrac12$). The intended reading, $1$ simple in $\sigma(L_e|_{\mathcal W_n})$ with the rest at most $\tfrac12$, follows from Passage C. Cosmetic.

## 9. Repeated eigenvalues and $\ker W\ne0$

**Located.** Passage B, line 534: "In an eigenbasis of $W$, with $c'$ transported there". Neither L115 nor the display says which eigenbasis.

**Failure exhibited.** At $S^2\times S^2$ ($n=4$, $a=\tfrac23$ on $e_{12},e_{34}$, $b=-\tfrac13$ on mixed planes, $\theta=1$ in this scaling) two orthonormal eigenbases give different $M$. Coordinate basis: spectrum $\{1,\tfrac23,0,-\tfrac13,-\tfrac13,-1\}$, $\lVert M\rVert_F^2=\tfrac43+4\cdot2\cdot\tfrac{2b^2+a^2}{4}=\tfrac83$. Basis $\omega^\pm_1=(e_{12}\pm e_{34})/\sqrt2$, $\omega^\pm_2=(e_{13}\mp e_{24})/\sqrt2$, $\omega^\pm_3=(e_{14}\pm e_{23})/\sqrt2$, still eigenvectors: $[\Lambda^+,\Lambda^-]=0$, so $M=M^+\oplus M^-$ with $M^\pm=\begin{pmatrix}a&b&b\\b&b&a\\b&a&b\end{pmatrix}$ (the off-diagonal constant fixed by $M\lambda=\theta\lambda$), spectrum $\{1,0,-1\}$ each, total $\{1,1,0,0,-1,-1\}$, $\lVert M\rVert_F^2=4$. The top eigenvalue is $\theta$ in both but simple in one and double in the other. At padded $W_{\mathbb{CP}^2}$, $n=5$, the kernel block on $u_\alpha\wedge e_5$ is $\tfrac1{4\sqrt6}\big(3G-(J_4-I)\big)$ with $G_{\alpha\beta}=\langle Ju_\alpha,u_\beta\rangle^2$: the standard frame gives spectrum $\tfrac1{\sqrt6}\{1,0,-\tfrac12,-\tfrac12\}$ and a frame with $G=(J_4-I)/3$ (realised by the antisymmetric orthogonal matrix with all off-diagonal entries $\pm1/\sqrt3$) gives the zero block.

**Charitable reading.** Read clause 1 as "for every orthonormal eigenbasis". Then by section 0 it is $\lambda_{\max}$ of $L_e$ compressed to the block-diagonal operators $\bigoplus_\mu S^2(E_\mu)$ over the eigenspaces $E_\mu$, a basis-free statement, and the tests above do not break it: at $n=4$ $\mathbb{CP}^2$ every eigenbasis gives $M^+$ with spectrum $\sqrt{3/2}\{1,0,-1\}$ and $M^-=0$ (orthonormal frames of $\mathfrak{so}(3)$ all have $c'^2_{123}$ equal), and at $S^2\times S^2$ the full block-diagonal compression reduces, after the off-diagonal $2\times2$ entries enter with Rayleigh ratios $a=\tfrac23$ and $b-a=-1$, to $M^\pm$ again, maximum $1=\theta$. Finding: the quantifier is missing, and at every known global maximiser (padded $\mathbb{CP}^2$ has $\dim\ker W=N-3$) the unquantified statement does not define its object. GAP.

## 10. The Lean files against the record

- [L115.lean](../lean/HamiltonsCubic/Results/L115.lean): lambda2_six, ambient_dim, weyl_six are the true dimension counts $15$, $120$, $84$ at $n=6$ ($84=6\cdot7\cdot8\cdot3/12$). The three "share" lemmas are rational inequalities whose meaning is not stated. cap_on_subspace_transfers_nothing is an abstract two-variable illustration that a bound on a line does not bound a plane, true and unrelated to $L_e$. true_claim_bad_argument is a propositional tautology. None mentions $M$, $\theta$, a maximiser or $\mathcal D$.
- [L115Statement.lean](../lean/HamiltonsCubic/Results/L115Statement.lean): IsTopRayleigh A t is $\forall x,\ x^TAx\le t\,x^Tx$, that is $\lambda_{\max}(\tfrac12(A+A^T))\le t$, an upper bound and never an equality. theta_ge_diag takes that bound as the hypothesis hlam and concludes $\lambda_\alpha\le\theta$: route 1 with the GAP direction assumed, direction and non-strictness matching the prose. theta_gt_lambda and theta_sub_lambda_ge formalise route 2 over an arbitrary finite index type with $\sqrt{3/2}\le\theta$ as hypothesis, which at a global maximiser is the given $M(n)\ge\sqrt{3/2}$. margin and one_lt_sqrt_three_halves are correct numerals. c5_exceeds_nonWeyl_cap compares $1/\sqrt2$ with a run figure and corresponds to no clause of L115 as quoted. witLam is a two-entry unit vector showing theta_gt_lambda's hypotheses are satisfiable, not a Weyl spectrum.
- **Clause 1, $\lambda_{\max}(M)=\theta$, is typed nowhere**, neither unrestricted nor restricted. Clause 2 is typed in its strict form. CONFIRMED AS ALGEBRA for clause 2 only.

## 11. Withdrawn candidates

- **Cross block defeats the proposed cap** (section 4). Located at line 292. Withdrawn at step 2: $L_e$ preserves $\mathcal W_n$ by Böhm–Wilking (6), so the cross block is zero.
- **$\operatorname{diag}M\ne\lambda$.** Withdrawn at step 2: $c'_{\alpha\alpha\gamma}=0$.
- **Clause 1 fails at $S^m\times S^m$ for $m\le3$.** Withdrawn at step 2: the closed-form spectrum of section 3 gives $\lambda_{\max}(M)=\theta$ at every $m\ge2$ in the coordinate eigenbasis.
- **Clause 1 fails at the $n=4$ global maximiser.** Withdrawn at step 2: $\sqrt{3/2}\{1,0,-1\}\oplus0$ in every eigenbasis.
- **The identity Rayleigh direction exceeds $\theta$.** Withdrawn at step 2: $L_eI=0$.
- **Route 2 of the by-product fails at small $n$.** Withdrawn: $M(n)\ge\sqrt{3/2}$ is given at every $n\ge4$.

## 12. The falsifier

Clause 1 is falsified by a global maximiser $W^*$ and an orthonormal eigenbasis with $\lambda_{\max}(M)>\theta$, equivalently (section 4) by $Z\in P_{\mathcal W_n^\perp}\mathcal D$ with $\langle Z,L_eZ\rangle>\lVert Z\rVert^2$. What I did: the only proven global maximisers are at $n=4$, and there no eigenbasis gives it. At padded $W_{\mathbb{CP}^2}$ ($n=5$), in the standard frame and in the $G=(J_4-I)/3$ frame of the $u\wedge e_5$ block, the top eigenvalue stays $\sqrt{3/2}=\theta$, and all brackets into $\Lambda^-$, $\Lambda^2(\mathbb R^{n-4})$ or mixed planes carry weight $0$. The supremum over all symmetric operators on $\ker W$ (dimension $N-3$) was not bounded, because doing so would be building a proof. At $S^m\times S^m$ only the coordinate eigenbasis was tested. No closed-form falsifier exists on file or was found. At $n\ge12$ and at odd $n$ no global maximiser is known, so the claim has no witness in the range Conjecture A concerns.

## 13. Overall verdict

**GAP.** The heading asserts $\lambda_{\max}(M)=\theta$ at every global maximiser with no argument on file, the body calls that form not citable, and the restricted display that replaces it also has no argument, uses neither of its extra hypotheses, and covers a class with no known member. The sufficiency of the closing cap is true at level $\theta$ but unargued, the "strictly stronger" and "equivalent" comparisons both rest on the missing clause or on a witness that does not witness, and $M$ is unquantified over eigenbases at repeated eigenvalues. The one proven content is clause 2, $\theta>\max_\alpha\lambda_\alpha$ at a global maximiser, by the norm route formalised in Lean.
