# Verifier v364, L115 step F4: the equivalence with Conjecture A and the bound theta at least max lambda

Cold brief ([ADJ_L115_F4.md](ADJ_L115_F4.md)), no numerical work, no scripts written, every value exact. Log: [agent_logs/verify-L115-v364.log](../agent_logs/verify-L115-v364.log).

| # | Claim | Verdict |
|---|---|---|
| 1 | $\mathop{\mathrm{diag}}M(\lambda)=\lambda$ | CONFIRMED |
| 2 | At every global maximiser $\theta=M(n)$ is an eigenvalue of $M(\lambda)$, so $\theta\le\lambda_{\max}(M)$ | CONFIRMED |
| 3 | (i), forward half: $\lambda_{\max}(M)\le\theta_0$ at a global maximiser implies Conjecture A | CONFIRMED |
| 4 | (i), reverse half: Conjecture A implies $\lambda_{\max}(M)\le\theta_0$ at every global maximiser, from the passages | REFUTED AS STATED |
| 5 | (ii), the inference $\lambda_\alpha=M_{\alpha\alpha}\le\lambda_{\max}(M)=\theta$ | CONFIRMED AS ALGEBRA |
| 6 | (ii), its premise $\lambda_{\max}(M)=\theta$ at an arbitrary global maximiser, available from the passages | REFUTED AS STATED |
| 7 | (ii), the conclusion $\theta\ge\max_\alpha\lambda_\alpha$ at every global maximiser, by another route | CONFIRMED |

**Summary: both halves of the step lean on $\lambda_{\max}(M)=\theta$ at every global maximiser, which Passage A declares uncitable two lines earlier, so the step FAILS as written. The forward half of (i) and the conclusion of (ii) survive, the latter by $|\lambda_\alpha|\le1<\sqrt{3/2}\le\theta$.**

## 0. Conventions, fixed once

- $\mathcal W_n$ is the space of algebraic Weyl tensors, read as symmetric operators on $\Lambda^2\mathbb R^n\cong\mathfrak{so}(n)$ with the standard inner product $\langle\cdot,\cdot\rangle$ on $\Lambda^2$ and the Frobenius inner product on operators. A unit $W$ has $\sum_\alpha\lambda_\alpha^2=\mathop{\mathrm{tr}}W^2=1$.
- $Q(W)=W^2+W^\#$, $P(W)=\langle W,Q(W)\rangle$. A critical point on the unit sphere satisfies $Q(W)=\theta W$ with $\theta=P(W)$. $M(n)=\max P$ on the unit sphere, $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$.
- $\{v_\alpha\}$ is an orthonormal eigenbasis of $W$ in $\Lambda^2$, $c'_{\alpha\beta\gamma}=\langle[v_\alpha,v_\beta],v_\gamma\rangle$, and $M(\lambda)_{\alpha\beta}=\delta_{\alpha\beta}\lambda_\alpha+\tfrac12\sum_\gamma c'^2_{\alpha\beta\gamma}\lambda_\gamma$ as in Passage B.
- **Conjecture A** is read as Passage B uses it: $M(n)\le\theta_0(n)$ (in its range $n\ge12$), with equality at the balanced sphere product where that exists.
- "Unrestricted L115" names the statement $\lambda_{\max}(M(\lambda))=\theta$ at every global maximiser. Passage A (line 290) says: "The unrestricted form is not citable".

## Hypothesis inventory

- **H0 (standard).** The inner product on $\Lambda^2\cong\mathfrak{so}(n)$ is ad-invariant, $\langle[A,B],C\rangle=\langle A,[B,C]\rangle$. This holds for the standard inner product, which is a positive multiple of $-\mathop{\mathrm{tr}}(AB)$.
- **H1 (unwritten, load-bearing).** Unrestricted L115: $\lambda_{\max}(M)=\theta$ at every global maximiser. Passage A holds it only at coordinate-diagonal global maximisers and at $S^m\times S^m$, $m\ge4$.
- **H1' (alternative to H1).** Every global maximiser is coordinate-diagonal or an $S^m\times S^m$. It implies H1 through Passage A's restricted statement.
- **H2.** Conjecture A is the inequality $M(n)\le\theta_0(n)$ at the $n$ in question.
- **H3 (given).** $M(n)\ge\sqrt{3/2}$ for $n\ge4$, from padded $W_{\mathbb{CP}^2}$.

## 1. $\mathop{\mathrm{diag}}M=\lambda$

By H0 the trilinear form $(A,B,C)\mapsto\langle[A,B],C\rangle$ is totally antisymmetric: antisymmetric in $A,B$ by antisymmetry of the bracket, and invariance moves $C$ into the second slot. Total antisymmetry is a basis-free property, so it holds in every orthonormal basis of $\Lambda^2$, including the eigenbasis $\{v_\alpha\}$, whether or not that basis comes from $O(n)$. Hence $c'_{\alpha\alpha\gamma}=0$ for all $\alpha,\gamma$, so $M_{\alpha\alpha}=\lambda_\alpha+\tfrac12\sum_\gamma c'^2_{\alpha\alpha\gamma}\lambda_\gamma=\lambda_\alpha$. Claim 1 is CONFIRMED, and it uses H0 only.

## 2. $\theta$ is an eigenvalue of $M$ at every global maximiser

A global maximiser exists because the unit sphere of $\mathcal W_n$ is compact and $P$ is continuous. It is a critical point of $P$ on the sphere, so $Q(W)=\theta W$ with $\theta=P(W)=M(n)$. In the eigenbasis the $\alpha$-th component of $M(\lambda)\lambda$ is $\lambda_\alpha^2+\tfrac12\sum_{\beta,\gamma}c'^2_{\alpha\beta\gamma}\lambda_\beta\lambda_\gamma$, the diagonal entry $Q(W)_{\alpha\alpha}$ in Passage B's formula. Since $Q(W)=\theta W$ is diagonal there, $M(\lambda)\lambda=\theta\lambda$ with $\|\lambda\|=1$. For the real symmetric matrix $M$, $\lambda_{\max}(M)=\max_{\|x\|=1}\langle x,Mx\rangle\ge\langle\lambda,M\lambda\rangle=\theta$. Claim 2 is CONFIRMED.

## 3. Step (i), forward half

Suppose $\lambda_{\max}(M(\lambda))\le\theta_0(n)$ at a single global maximiser $W$. By Section 2, $M(n)=\theta\le\lambda_{\max}(M)\le\theta_0(n)$, which is Conjecture A under H2. One maximiser suffices. Claim 3 is CONFIRMED, with H2 as the only reading needed.

## 4. Step (i), reverse half

**Located.** Passage A, line 292: "The equivalent target is the pointwise statement at maximisers, and that is Conjecture A rewritten, neither easier nor harder." Equivalence needs Conjecture A to imply $\lambda_{\max}(M)\le\theta_0$ at every global maximiser.

**What the passages give.** Conjecture A gives $\theta=M(n)\le\theta_0$. Section 2 gives $\lambda_{\max}(M)\ge\theta$. These two bounds face the same way and put no upper bound on $\lambda_{\max}(M)$. The upper bound would come from $\lambda_{\max}(M)\le\theta$, which is H1, and line 290 of the same passage says H1 is not citable.

**Exact reduction.** Where Conjecture A holds with equality, $M(n)=\theta_0(n)$, the reverse half reads $\lambda_{\max}(M)\le\theta$ at every global maximiser, and with Section 2 that is $\lambda_{\max}(M)=\theta$ at every global maximiser. So in the equality case the reverse half of (i) is logically equivalent to unrestricted L115, the very statement the passage has just withdrawn. Where $M(n)<\theta_0(n)$ the reverse half is implied by H1 and is weaker than it.

**Exhibited concretely, at the level of the inference.** Every linear-algebraic premise the passages supply at a maximiser (a real symmetric $M$, $\mathop{\mathrm{diag}}M=\lambda$, $M\lambda=\theta\lambda$, $\|\lambda\|=1$) is compatible with $\lambda_{\max}(M)>\theta$. Take $\lambda=(1/\sqrt2,1/\sqrt2)$ and $M=\begin{pmatrix}1/\sqrt2&-1/(2\sqrt2)\\-1/(2\sqrt2)&1/\sqrt2\end{pmatrix}$. Then $\mathop{\mathrm{diag}}M=\lambda$, $M\lambda=\tfrac1{2\sqrt2}\lambda$ so $\theta=\tfrac1{2\sqrt2}$, and $M(1,-1)^{\mathsf T}=\tfrac3{2\sqrt2}(1,-1)^{\mathsf T}$ so $\lambda_{\max}(M)=\tfrac3{2\sqrt2}=3\theta$. This matrix is not claimed to arise from a Weyl tensor. It shows that the gap is in the premises, and Passage B's own catalogue records the same phenomenon at an actual critical point, the $C_5$ blow-up, where $\lambda$ is not the top eigenvector. Reading Passage B's quadratic form as the polarised cubic, $\langle x,M(\lambda)x\rangle=\langle X,X\circ W\rangle=\theta\langle X,L_eX\rangle$ for $X=\mathop{\mathrm{diag}}(x)\in\mathcal D$, which makes the same point in Passage A's language: H1 is $\lambda_{\max}(L_e|_{\mathcal D})=1$, and Lemma L24 caps $L_e$ only on $\mathcal W_n\cap W^\perp$, which generically misses $\mathcal D$.

**Arguing the opposite.** (a) Read "at maximisers" as "at the maximisers where L115 is citable", coordinate-diagonal or $S^m\times S^m$. Then Conjecture A implies the pointwise bound there, since $\lambda_{\max}(M)=\theta=M(n)\le\theta_0$. The forward half now needs a global maximiser of that kind to exist, which the passages do not supply, so this reading moves the missing hypothesis without removing it. (b) Read "equivalent target" loosely, as "a sufficient target of the same difficulty". Sufficiency is Section 3, but "neither easier nor harder" asserts the converse, and the converse is H1 in the equality case. (c) Global second-order information might replace H1. Lemma L24 is a local statement on $\mathcal W_n\cap W^\perp$, and global maximality compares $P$ only on $\mathcal W_n$, while $\mathcal D$ contains operators outside $\mathcal W_n$. Neither reaches $\mathcal D$. The objection does not close.

Claim 4 is REFUTED AS STATED: true under H1 (or H1'), not derivable from the passages, and not refuted as mathematics.

## 5. Step (ii)

**The algebra.** For real symmetric $M$ and the standard basis vector $e_\alpha$, $M_{\alpha\alpha}=\langle e_\alpha,Me_\alpha\rangle\le\lambda_{\max}(M)$. With Section 1, $\lambda_\alpha\le\lambda_{\max}(M)$, and with $\lambda_{\max}(M)\le\theta$ this gives $\lambda_\alpha\le\theta$. Passage D's theta_ge_diag is exactly this, with the hypothesis IsTopRayleigh A θ standing for $\lambda_{\max}(M)\le\theta$. Claim 5 is CONFIRMED AS ALGEBRA.

**The premise.** Line 294 uses "$\lambda_{\max}(M)=\theta$ at a maximiser". Only the direction $\lambda_{\max}(M)\le\theta$ is used, and the passages supply only $\ge$ (Section 2). The $\le$ direction at an arbitrary maximiser is H1, withdrawn at line 290. From $\mathop{\mathrm{diag}}M=\lambda$ and $\theta\le\lambda_{\max}(M)$ alone, $\theta$ and $\lambda_\alpha$ are both below $\lambda_{\max}(M)$ and unordered against each other: in the matrix of Section 4, $\lambda_1=1/\sqrt2>\theta=1/(2\sqrt2)$. Claim 6 is REFUTED AS STATED. At coordinate-diagonal global maximisers and at $S^m\times S^m$, $m\ge4$, the premise is the passage's restricted statement and (ii) follows as written.

**The conclusion by another route.** At every global maximiser, $\|\lambda\|=1$ gives $\lambda_\alpha\le|\lambda_\alpha|\le1$, and H3 gives $\theta=M(n)\ge\sqrt{3/2}>1$. So $\theta-\lambda_\alpha\ge\sqrt{3/2}-1>0$ for every $\alpha$, strictly and uniformly, with no use of $M$. This is Passage D's theta_gt_lambda. Claim 7 is CONFIRMED, and it needs H3 and nothing else. The route in line 294 is therefore both uncited at a general maximiser and unnecessary.

## 6. Verdict

**FAILS as written.** Both halves of the step rest on $\lambda_{\max}(M)\le\theta$ at an arbitrary global maximiser (the reverse half of (i) and the premise of (ii)), and Passage A declares that unrestricted form uncitable at line 290, two sentences before using it at line 294. Nothing here refutes the underlying mathematics.

- **A VALID reading of (i)** needs H1 (or H1') and H2. Without H1 only the forward half holds: the pointwise bound at one maximiser implies Conjecture A, so it is a sufficient target, at least as hard as Conjecture A.
- **A VALID reading of (ii) along its written route** needs H0 and H1, or a restriction of "a maximiser" to the coordinate-diagonal and $S^m\times S^m$ cases.
- **The conclusion of (ii)** holds at every global maximiser for $n\ge4$ from H3 alone, with the exact margin $\theta-\max_\alpha\lambda_\alpha\ge\sqrt{3/2}-1$. The repair is to cite that route.
