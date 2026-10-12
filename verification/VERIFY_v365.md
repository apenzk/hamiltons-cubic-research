# Verifier v365, Lemma L115 step F4: the maximiser-pointwise target and the by-product $\theta\ge\max_\alpha\lambda_\alpha$

*Cold brief ([ADJ_L115_F4.md](ADJ_L115_F4.md)). No numerical work, no scripts written, every value exact. The statement of Conjecture A and the constant $\Theta_n$ are taken from [results.md](../results.md) lines 11, 88, 98 and 1377, the brief's own link. Log: [agent_logs/verify-L115-v365.log](../agent_logs/verify-L115-v365.log).*

| # | Claim | Verdict |
|---|---|---|
| C1 | $\operatorname{diag}M(\lambda)=\lambda$ and $\langle x,M(\lambda)x\rangle=\langle X,W\circ X\rangle$ for $X=\sum x_\alpha v_\alpha\otimes v_\alpha$ | CONFIRMED |
| C2 | (ii) as an implication: $\operatorname{diag}M=\lambda$ and $\lambda_{\max}(M)\le\theta$ give $\lambda_\alpha\le\theta$ for every $\alpha$ | CONFIRMED AS ALGEBRA |
| C3 | (ii)'s premise $\lambda_{\max}(M)=\theta$ is available at every global maximiser from the passages | REFUTED AS STATED |
| C4 | (ii)'s conclusion $\theta\ge\max_\alpha\lambda_\alpha$ at every global maximiser | CONFIRMED (by a different route, $\theta=M(n)\ge\sqrt{3/2}>1\ge\lambda_\alpha$) |
| C5 | (i), forward half: $\lambda_{\max}(M)\le\theta_0$ at a global maximiser implies $M(n)\le\theta_0(n)$ | CONFIRMED |
| C6 | (i), converse half: Conjecture A implies $\lambda_{\max}(M)\le\theta_0$ at every global maximiser | REFUTED AS STATED (needs the premise of C3) |
| C7 | (i) at the constant $\theta_0$ is Conjecture A "rewritten" | REFUTED AS STATED at odd $n\ge13$ and at $n\le11$ |

**Summary: the step FAILS as written, since both halves lean on $\lambda_{\max}(M)=\theta$ at every global maximiser, a premise Passage A itself declares not citable (line 290). Part (ii)'s conclusion survives by the norm bound, and (i) is VALID only under that premise, at $n\ge12$, with $\theta_0$ read as $\Theta_n$.**

## 0. Conventions, fixed once

- $\mathcal W_n$ is the space of algebraic Weyl tensors as symmetric operators on $\Lambda^2\mathbb R^n\cong\mathfrak{so}(n)$ with the Frobenius inner product, $Q(W)=W^2+W^\#$, $P(W)=\langle W,Q(W)\rangle$, and $X\circ Y=\tfrac12(Q(X+Y)-Q(X)-Q(Y))=\tfrac12(XY+YX)+X\#Y$.
- $W$ is a unit global maximiser, so $P(W)=\theta=M(n)$ and $Q(W)=\theta W$. It has orthonormal eigenbasis $\{v_\alpha\}$ with eigenvalues $\lambda_\alpha$, and $\sum_\alpha\lambda_\alpha^2=\lVert W\rVert^2=1$.
- $c'_{\alpha\beta\gamma}=\langle[v_\alpha,v_\beta],v_\gamma\rangle$ are the structure constants in that basis, and $c'^2_{\alpha\beta\gamma}$ denotes $(c'_{\alpha\beta\gamma})^2$. This is the reading under which Passage B's formula for $P$ is the standard $\langle W,W^\#\rangle=\tfrac12\sum c'^2_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta\lambda_\gamma$.
- $M(\lambda)_{\alpha\beta}=\delta_{\alpha\beta}\lambda_\alpha+\tfrac12\sum_\gamma c'^2_{\alpha\beta\gamma}\lambda_\gamma$, a real symmetric $N\times N$ matrix with $N=\dim\Lambda^2$, so $\lambda_{\max}(M)=\max_{\lVert x\rVert=1}\langle x,Mx\rangle$.
- $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$. $\Theta_n^2=2(n-1)(n-2)/n^2$ at even $n$ and $2(n-1)(n-3)/((n+1)(n-2))$ at odd $n$ ([results.md](../results.md) lines 88 and 98). Conjecture A's $n\ge12$ clause is $\sup\{P(W):\lVert W\rVert=1\}=\Theta_n$ ([results.md](../results.md) line 1377).
- $H$ names the hypothesis "$\lambda_{\max}(M(\lambda))=\theta$ at every global maximiser of $P$ on the unit sphere of $\mathcal W_n$".

## Hypothesis inventory

| Label | Hypothesis | Where it is needed | Status on the passages |
|---|---|---|---|
| A1 | $c'$ totally antisymmetric in an orthonormal basis | $\operatorname{diag}M=\lambda$ (C1) | Standard: $\mathrm{ad}$ is skew for the invariant inner product on $\mathfrak{so}(n)$ |
| A2 | $\sum_\alpha\lambda_\alpha^2=1$ | Boxed bound $\theta\le\lambda_{\max}(M)$, and C4 | Given (Frobenius norm, unit $W$) |
| A3 | $M(n)\ge\sqrt{3/2}$ | C4 | Given (padded $W_{\mathbb{CP}^2}$) |
| H | $\lambda_{\max}(M)=\theta$ at every global maximiser | C2's premise, C6 | **Not available.** Passage A (line 288) certifies it only at coordinate-diagonal global maximisers and at $S^m\times S^m$, $m\ge4$, and says "The unrestricted form is not citable" |
| N | $n\ge12$ | C7 | Needed for the pointwise statement to be satisfiable at all |
| K | Target constant $\Theta_n$, equal to $\theta_0(n)$ at even $n$ | C7 | Passage A writes $\theta_0$ |

## 1. The matrix $M$ is the compression of $L_W$ to $\mathcal D$, and its diagonal is $\lambda$

For $X=\sum_\alpha x_\alpha v_\alpha\otimes v_\alpha\in\mathcal D$, the trilinear form $\langle A,B\circ C\rangle=\tfrac12\operatorname{tr}(ABC+ACB)+\langle A,B\#C\rangle$ is totally symmetric, so $\langle X,W\circ X\rangle=\langle W,X\circ X\rangle=\langle W,X^2\rangle+\langle W,X^\#\rangle$.

With $W$ and $X$ both diagonal in $\{v_\alpha\}$, $\langle W,X^2\rangle=\sum_\alpha\lambda_\alpha x_\alpha^2$ and $(X^\#)_{\gamma\gamma}=\tfrac12\sum_{\alpha\beta}c'^2_{\alpha\beta\gamma}x_\alpha x_\beta$, so $\langle X,W\circ X\rangle=\sum_\alpha\lambda_\alpha x_\alpha^2+\tfrac12\sum c'^2_{\alpha\beta\gamma}x_\alpha x_\beta\lambda_\gamma=\langle x,M(\lambda)x\rangle$. At $x=\lambda$ this is Passage B's $P=\langle\lambda,M\lambda\rangle$.

By A1, $c'_{\alpha\alpha\gamma}=\langle[v_\alpha,v_\alpha],v_\gamma\rangle=0$, so $M_{\alpha\alpha}=\lambda_\alpha+\tfrac12\sum_\gamma c'^2_{\alpha\alpha\gamma}\lambda_\gamma=\lambda_\alpha$. **C1 CONFIRMED.**

By A2, $\theta=\langle\lambda,M\lambda\rangle\le\lambda_{\max}(M)$, which is Passage B's boxed bound. At a critical point $Q(W)=\theta W$ is diagonal in $\{v_\alpha\}$ with entries $\theta\lambda_\gamma$, and its $\gamma\gamma$ entry is $\lambda_\gamma^2+\tfrac12\sum_{\alpha\beta}c'^2_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta=(M\lambda)_\gamma$, so $M\lambda=\theta\lambda$ exactly, as Passage B says.

## 2. Part (ii), the by-product

**The implication is sound.** Let $e_\alpha$ be the $\alpha$-th coordinate vector. Then $\lambda_\alpha=M_{\alpha\alpha}=\langle e_\alpha,Me_\alpha\rangle\le\lambda_{\max}(M)$. If $\lambda_{\max}(M)\le\theta$, then $\lambda_\alpha\le\theta$ for every $\alpha$. Only the upper half of $H$ is used. This is exactly [theta_ge_diag](../lean/HamiltonsCubic/Results/L115Statement.lean) in Passage D, whose hypothesis IsTopRayleigh encodes $\lambda_{\max}(A)\le\theta$. **C2 CONFIRMED AS ALGEBRA.**

**The premise is not available as written.** The sentence reads "since $\operatorname{diag}M=\lambda$ and $\lambda_{\max}(M)=\theta$ at a maximiser". The only source for $\lambda_{\max}(M)=\theta$ is Lemma L115 itself, and Passage A's second heading restricts it: "$\lambda_{\max}(M)=\theta$ at every COORDINATE-DIAGONAL global maximiser, and at every $S^m\times S^m,\ m\ge4$. **The unrestricted form is not citable**". The boxed bound gives only $\lambda_{\max}(M)\ge\theta$, which points the wrong way for (ii). So at a general global maximiser the stated derivation has no premise. **C3 REFUTED AS STATED.**

**The conclusion holds anyway, at every global maximiser.** By A2, $\lambda_\alpha^2\le\sum_\beta\lambda_\beta^2=1$, so $\lambda_\alpha\le1$. By A3, $\theta=M(n)\ge\sqrt{3/2}$, and $\sqrt{3/2}>1$ because $3/2>1$. Hence $\theta-\lambda_\alpha\ge\sqrt{3/2}-1>0$ for every $\alpha$, strictly. This is [theta_gt_lambda](../lean/HamiltonsCubic/Results/L115Statement.lean) in Passage D. It uses neither $M$ nor $H$, and it holds at every $n\ge4$. **C4 CONFIRMED.**

So (ii) as a statement is true at every global maximiser, and "free by-product" of $H$ is a correct description only where $H$ is known. The route that reaches every global maximiser is the norm bound.

## 3. Part (i), the forward half

Suppose $\lambda_{\max}(M(\lambda))\le\theta_0(n)$ at some global maximiser $W$. One exists, since $P$ is continuous on the compact unit sphere of the finite-dimensional $\mathcal W_n$. By the boxed bound, $M(n)=\theta\le\lambda_{\max}(M)\le\theta_0(n)$. No use of $H$. **C5 CONFIRMED.** So the pointwise statement is at least as strong as $M(n)\le\theta_0(n)$.

## 4. Part (i), the converse half

Suppose Conjecture A in the form $M(n)\le B$ for the relevant constant $B$. At a global maximiser this gives $\theta\le B$. To reach $\lambda_{\max}(M)\le B$ one needs an upper bound on $\lambda_{\max}(M)$ by $\theta$ or by $B$, and the passages supply only the lower bound $\lambda_{\max}(M)\ge\theta$.

Section 1 locates the missing bound. $\lambda_{\max}(M)=\max\{\langle X,L_WX\rangle:X\in\mathcal D,\ \lVert X\rVert=1\}$ with $L_W=W\circ(\cdot)=\theta L_e$. Lemma L24 (Passage C) gives $L_W\le\theta/2$ on $\mathcal W_n\cap W^\perp$, and $L_WW=Q(W)=\theta W$, so $\langle Y,L_WY\rangle\le\theta\lVert Y\rVert^2$ for $Y\in\mathcal W_n$. An element of $\mathcal D$ is generically neither trace-free nor Bianchi, so it has a component in $\mathcal W_n^\perp$ where L24 says nothing. This is Passage A's own diagnosis, "what would close it is a cap on $\lambda_{\max}(L_W|_{\mathcal W_n^\perp})$, which is nowhere on the record".

With $H$ the converse is immediate: $\lambda_{\max}(M)=\theta=M(n)\le B$. Without $H$, nothing on the passages excludes a global maximiser with $\theta\le B<\lambda_{\max}(M)$. Passage B shows that $\lambda_{\max}(M)>\theta$ does occur at a critical point (the $C_5$ blow-up), so the gap between the two quantities is real in general, although that point is no maximiser. **C6 REFUTED AS STATED.** "Neither easier nor harder" asserts both halves, and the converse half rests on $H$, which is open.

## 5. The constant and the range

**Range.** The pointwise statement at $\theta_0$ is false at every $4\le n\le11$. There $\lambda_{\max}(M)\ge\theta=M(n)\ge\sqrt{3/2}$, and $\sqrt{3/2}>\theta_0(n)$ is $3n^2>4(n-1)(n-2)$, that is $n^2-12n+8<0$, whose roots are $6\pm2\sqrt7$, with $6-2\sqrt7<1$ and $6+2\sqrt7\in(11,12)$ (the polynomial is $-3$ at $n=11$ and $8$ at $n=12$). Conjecture A's clause for comparison is the $n\ge12$ one, so hypothesis N is needed, and the passage's surrounding text (Passage B, "for $n\ge12$") supports reading it in.

**Constant.** At even $n$, $\Theta_n=\theta_0(n)$ and the target is Conjecture A's. At odd $n$,

$$\theta_0(n)^2-\Theta_n^2=\frac{2(n-1)\big[(n-2)^2(n+1)-n^2(n-3)\big]}{n^2(n+1)(n-2)}=\frac{8(n-1)}{n^2(n+1)(n-2)}>0,$$

since $(n-2)^2(n+1)=n^3-3n^2+4$ and $n^2(n-3)=n^3-3n^2$ differ by $4$. At $n=13$ the difference is $96/26026=48/13013$. So at odd $n\ge13$, even granting $H$, the pointwise statement at $\theta_0$ is equivalent to $M(n)\le\theta_0(n)$, which permits $M(n)\in(\Theta_n,\theta_0(n)]$ and is strictly weaker as a statement than Conjecture A's $M(n)=\Theta_n$. **C7 REFUTED AS STATED**, repaired by reading $\theta_0$ as $\Theta_n$ (hypothesis K), under which the equivalence holds at both parities given $H$ and N.

## 6. Arguing the opposite

**Could $H$ be derived at a global maximiser without the missing cap?** Global maximality is second-order information along curves inside the unit sphere of $\mathcal W_n$. Every such variation is a Weyl tensor, so it tests $L_W$ only on $\mathcal W_n$, which L24 already covers. The directions in $\mathcal D$ that carry $\lambda_{\max}(M)$ leave $\mathcal W_n$ and are invisible to any optimality condition on $\mathcal W_n$. The passages hold no other route, and Passage A explicitly records that none is on the record.

**Could the failure be exhibited as a false conclusion?** It cannot from the passages. A closed-form global maximiser with $\lambda_{\max}(M)>\theta$ would need the global maximisers at some $n\ge12$ to be known, and that is Conjecture A. The defect is a missing premise, located at Passage A line 294 ("since $\operatorname{diag}M=\lambda$ and $\lambda_{\max}(M)=\theta$ at a maximiser") against line 290 ("The unrestricted form is not citable"), and for (i) at the same line's "The equivalent target is the pointwise statement at maximisers".

**Is the author's restricted scope enough?** Reading "at a maximiser" as "at a coordinate-diagonal global maximiser" makes (ii)'s derivation valid there. It does not rescue (i): the pointwise statement over coordinate-diagonal maximisers is equivalent to "$M(n)\le\Theta_n$ or no global maximiser is coordinate-diagonal", which is Conjecture A only if some global maximiser is known to be coordinate-diagonal. That is again open. So the strongest reading that makes (i) an equivalence is the full $H$.

## 7. Verdict

**FAILS as written.** Both halves of the step take $\lambda_{\max}(M)=\theta$ at every global maximiser as available, and Passage A itself grants it only at coordinate-diagonal maximisers and $S^m\times S^m$, calling the unrestricted form not citable.

- **(ii)** is true at every global maximiser, but by a different argument: $\theta=M(n)\ge\sqrt{3/2}>1\ge\lambda_\alpha$, needing only A2 and A3. The stated derivation is valid algebra (A1) and needs the upper half of $H$.
- **(i)**: the forward half ($\lambda_{\max}(M)\le\theta_0$ at a maximiser implies $M(n)\le\theta_0$) is VALID unconditionally. The converse, hence the equivalence, is VALID only under **H** ($\lambda_{\max}(M)=\theta$ at every global maximiser), **N** ($n\ge12$) and **K** (constant $\Theta_n$, which is $\theta_0(n)$ at even $n$ only).
