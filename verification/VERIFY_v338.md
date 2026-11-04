# Verifier v338, whether the N diagonal equations of L111 are N constraints on a critical point

*Cold brief ([ADJ_L111_D6.md](ADJ_L111_D6.md)). No numerical work, no scripts written, every value below exact and derived by hand. Log: [agent_logs/verify-L111-v338.log](../agent_logs/verify-L111-v338.log).*

| # | Claim | Verdict |
|---|---|---|
| 1 | At a critical point each of the $N$ equations $\sum_{\alpha\beta}\lambda_\alpha\lambda_\beta c_{k\alpha\beta}^2=2\lambda_k(\theta-\lambda_k)$ holds | CONFIRMED AS ALGEBRA |
| 2 | The $N$ equations are $N$ displayed scalar equations, one per $k$ | CONFIRMED |
| 3 | The $N$ equations are $N$ constraints on a critical point, as opposed to fewer | REFUTED AS STATED |
| 4 | Two linear combinations of them hold identically on every unit Weyl tensor with $\theta=P(W)$, so at most $N-2$ are independent | CONFIRMED |

**Summary: the step FAILS, because the trace and the $\lambda$-weighted sum of the $N$ diagonal equations are identities on the whole unit sphere of $\mathcal W_n$, so $N-2$ of the equations imply the other two.**

## 0. Conventions, fixed once

- $\mathcal W_n\subset\mathop{\mathrm{Sym}}^2(\Lambda^2\mathbb R^n)$, $N=\binom n2$, Frobenius inner product, $n\ge4$.
- $\{v_k\}$ an orthonormal eigenbasis of $W$ on $\Lambda^2\cong\mathfrak{so}(n)$, $Wv_k=\lambda_kv_k$, $c_{abc}=\langle[v_a,v_b],v_c\rangle$ totally antisymmetric, $T_{abc}=c_{abc}^2$.
- $Q(W)=W^2+W^\#$, $P(W)=\langle W,Q(W)\rangle$, critical point on $\{\lVert W\rVert=1\}$ means $Q(W)=\theta W$ with $\theta=P(W)$.
- The record's polarisation identity $\langle v,W^\#v\rangle=-\tfrac12\mathop{\mathrm{tr}}(\mathrm{ad}(v)W\mathrm{ad}(v)W)$, with the $\tfrac12$ of Passage B in $\#$.
- Define, for every $W\in\mathcal W_n$ and every real $\theta$, the defect of the $k$-th diagonal equation $E_k:=\sum_{\alpha\beta}\lambda_\alpha\lambda_\beta T_{k\alpha\beta}-2\lambda_k(\theta-\lambda_k)$.

## 1. Hypothesis inventory

- **H1 (polarisation).** $\langle v,W^\#v\rangle=-\tfrac12\mathop{\mathrm{tr}}(\mathrm{ad}(v)W\mathrm{ad}(v)W)$, as Passage A states it.
- **H2 (Weyl trace).** $\mathop{\mathrm{tr}}W=0$ on $\Lambda^2$, which is half the scalar curvature of $W$.
- **H3 (normalisation).** $\lVert W\rVert=1$ and $\theta=P(W)$, as the brief's definition of a critical point fixes them.
- **H4 (trace of $Q$).** $\mathop{\mathrm{tr}}Q(W)=0$ for every $W\in\mathcal W_n$. Section 3 derives it two independent ways: from the record's relation (B), and from the standard fact that $Q$ maps $\mathcal W_n$ into $\mathcal W_n$, which the brief's definition "critical point is $Q(W)=\theta W$" already presupposes (a first-order condition on a sphere in $\mathcal W_n$ reads $\mathop{\mathrm{pr}}_{\mathcal W_n}Q(W)=\theta W$, and it is $Q(W)=\theta W$ exactly when $Q(W)\in\mathcal W_n$).

Nothing in the argument uses criticality. The two identities of Section 4 hold at every unit Weyl tensor.

## 2. The diagonal equation is the diagonal of $Q(W)-\theta W$

In the basis $\{v_a\}$ the matrix of $\mathrm{ad}(v_k)$ is $(\mathrm{ad}\,v_k)_{ab}=\langle v_a,[v_k,v_b]\rangle=c_{kba}$. With $W=\mathop{\mathrm{diag}}(\lambda)$,

$$M_{kk}=\mathop{\mathrm{tr}}(\mathrm{ad}(v_k)W\mathrm{ad}(v_k)W)=\sum_{a,b}c_{kba}\lambda_b\,c_{kab}\lambda_a=-\sum_{a,b}\lambda_a\lambda_bT_{kab},$$

by antisymmetry of $c$. H1 gives $(W^\#)_{kk}=-\tfrac12M_{kk}=\tfrac12\sum_{ab}\lambda_a\lambda_bT_{kab}$. Hence, for every $W\in\mathcal W_n$ and every $\theta$,

$$E_k=2(W^\#)_{kk}+2\lambda_k^2-2\theta\lambda_k=2\big(Q(W)-\theta W\big)_{kk}.$$

At a critical point $Q(W)-\theta W=0$, so every $E_k$ vanishes. This confirms claims 1 and 2 and reproduces the sign in Passage A: criticality gives $(W^\#)_{kk}=\theta\lambda_k-\lambda_k^2$, that is $\sum\lambda_\alpha\lambda_\beta T_{k\alpha\beta}=2\lambda_k(\theta-\lambda_k)$.

Convention check against Passage B: with $W=\mathrm{id}$ the same computation gives $(\mathrm{id}^\#)_{kk}=\tfrac12\sum_{ab}T_{kab}=\tfrac12\cdot2(n-2)=n-2$ by relation (A), which is the halved Böhm–Wilking value Passage B pins. The factor is consistent throughout.

## 3. H4, the trace of $Q(W)$ vanishes on $\mathcal W_n$

**Route 1, from the record's relation (B).** Relation (B), $\sum_{\beta\gamma}\lambda_\beta T_{k\beta\gamma}=-2\lambda_k$, is listed in Passage B as coming from Ricci-flatness, so it holds for every Weyl tensor. Using total symmetry of $T$,

$$\mathop{\mathrm{tr}}W^\#=\sum_k(W^\#)_{kk}=\tfrac12\sum_{k,\alpha,\beta}\lambda_\alpha\lambda_\beta T_{k\alpha\beta}=\tfrac12\sum_\alpha\lambda_\alpha\sum_{k,\beta}\lambda_\beta T_{\alpha\beta k}=\tfrac12\sum_\alpha\lambda_\alpha(-2\lambda_\alpha)=-\lVert W\rVert^2.$$

So $\mathop{\mathrm{tr}}Q(W)=\mathop{\mathrm{tr}}W^2+\mathop{\mathrm{tr}}W^\#=\lVert W\rVert^2-\lVert W\rVert^2=0$.

**Route 2, independent of (B).** The brief's definition of a critical point presupposes $Q(\mathcal W_n)\subset\mathcal W_n$ (H4's parenthesis). Every element of $\mathcal W_n$ has zero trace on $\Lambda^2$ (H2 applied to $Q(W)$), so $\mathop{\mathrm{tr}}Q(W)=0$.

**Route 3, a consistency screen.** $(W_1,W_2)\mapsto\mathop{\mathrm{tr}}(W_1\#W_2)$ is a symmetric $O(n)$-invariant bilinear form on the irreducible representation $\mathcal W_n$, so it is $a\langle W_1,W_2\rangle$ for a universal constant $a$ (a symmetric equivariant endomorphism has invariant eigenspaces). The maximiser of $P$ on the compact unit sphere is a critical point, where $\mathop{\mathrm{tr}}W^\#=\theta\mathop{\mathrm{tr}}W-\mathop{\mathrm{tr}}W^2=-1$. So $a=-1$, agreeing with Routes 1 and 2.

## 4. Two identities among the $N$ equations

For every $W\in\mathcal W_n$ with $\lVert W\rVert=1$ and $\theta=P(W)$, with no criticality assumed:

**Identity I (trace).** $\sum_kE_k=2\mathop{\mathrm{tr}}Q(W)-2\theta\mathop{\mathrm{tr}}W=0$, by H4 and H2.

**Identity II ($\lambda$-weighted).** $\sum_k\lambda_kE_k=2\sum_k\lambda_k\big(Q(W)-\theta W\big)_{kk}=2\big(\langle W,Q(W)\rangle-\theta\lVert W\rVert^2\big)=2\big(P(W)-\theta\big)=0$, by H3. The middle step uses that $W$ is diagonal in the basis, so $\langle W,X\rangle=\sum_k\lambda_kX_{kk}$ for any symmetric $X$.

**The two weight vectors are independent.** If $(\lambda_k)$ were proportional to $(1,\dots,1)$, then H2 would force $\lambda=0$, against $\lVert W\rVert=1$. So there are indices $i,j$ with $\lambda_i\ne\lambda_j$, and Identities I and II solve for the two defects there in closed form. Writing $S_0=\sum_{k\ne i,j}E_k$ and $S_1=\sum_{k\ne i,j}\lambda_kE_k$,

$$E_i=\frac{\lambda_jS_0-S_1}{\lambda_i-\lambda_j},\qquad E_j=\frac{S_1-\lambda_iS_0}{\lambda_i-\lambda_j}.$$

**Where the step fails.** Passage A, line 662: "the diagonal entries pin $\sum\lambda_\alpha\lambda_\beta c_{k\alpha\beta}^2=2\lambda_k(\theta-\lambda_k)$ for every $k$, which is $N$ constraints where the record used one". On the unit sphere of $\mathcal W_n$ with $\theta=P(W)$, the $N-2$ equations $E_k=0$ for $k\ne i,j$ force $E_i=E_j=0$ by the display above. The diagonal family therefore carries at most $N-2$ independent constraints, and the count $N$ overstates it by at least two.

**The same count in bracket variables.** Treat the $T_{k\alpha\beta}$ as unknowns with $\lambda$ fixed. Identity I is then relation (B) summed against $\lambda$ with $\sum\lambda^2=1$ (Route 1), and Identity II is the bracket form of the definition $\theta=P(W)=\sum_k\lambda_k^3+\tfrac12\sum_{k\alpha\beta}\lambda_k\lambda_\alpha\lambda_\beta T_{k\alpha\beta}$. Both are already in the record's system, so the reading in bracket coordinates loses the same two.

## 5. Arguing the opposite

- **Reading "constraints" as displayed equations.** The passage writes one equation per $k$, and that count is $N$ (claim 2). The step as the brief states it, "$N$ constraints on a critical point, as opposed to fewer", is a claim about how much the family restricts a critical point, and Section 4 shows the restriction has rank at most $N-2$. The weak reading holds and the stated one fails.
- **Reading $\theta$ as a free multiplier.** Drop H3's $\theta=P(W)$ and let $(W,\theta)$ vary. Identity I survives unchanged (it uses only H2 and H4, and holds for every $\theta$ and every norm), so at most $N-1$ equations are independent. Identity II becomes $\theta=P(W)/\lVert W\rVert^2$, which determines the multiplier and leaves at most $N-2$ constraints on $W$ itself. No reading reaches $N$.
- **Reading the equations as individually trivial.** That would make the count smaller still. Section 4 needs only the two identities, so the verdict does not depend on whether any single $E_k$ is automatic.
- **Repeated eigenvalues.** On an eigenspace of dimension $m>1$ the individual diagonal entries depend on the choice of eigenbasis, and only their sum over the eigenspace is invariant. This affects which equations are meaningful and leaves Identities I and II intact, since both are basis-independent traces.

## 6. Hand screen on a constructed object, $n=4$ coordinate-diagonal

*A screen, reported as one and never as evidence for a positive claim.* Take $W$ coordinate-diagonal on $\mathbb R^4$ with eigenvalue $a$ on $e_{12},e_{34}$, $b$ on $e_{13},e_{24}$, $c$ on $e_{14},e_{23}$, and $a+b+c=0$ (the $n(n-3)/2=2$-dimensional family). The nonzero brackets of $e_{12}$ pair $e_{13}\leftrightarrow e_{23}$ and $e_{14}\leftrightarrow e_{24}$, so $(W^\#)_{e_{12}}=\tfrac12(bc+cb+cb+bc)=2bc$, and cyclically $2ac$ on $e_{13},e_{24}$ and $2ab$ on $e_{14},e_{23}$. With $\lVert W\rVert^2=2(a^2+b^2+c^2)=1$ and $a^3+b^3+c^3=3abc$, $P(W)=2(a^3+b^3+c^3)+2\cdot3\cdot2abc=18abc$.

- Identity I: $\tfrac12\sum_kE_k=2(2bc+2ac+2ab)+2(a^2+b^2+c^2)=2(a+b+c)^2=0$.
- Identity II: $\tfrac12\sum_k\lambda_kE_k=2\big(a\cdot2bc+b\cdot2ac+c\cdot2ab\big)+2(a^3+b^3+c^3)-\theta=12abc+6abc-18abc=0$.

Here the six equations collapse to three distinct defects $E_a,E_b,E_c$ tied by $E_a+E_b+E_c=0$ and $aE_a+bE_b+cE_c=0$, so off the lines $a=b$, $b=c$, $a=c$ the family carries a single constraint where the step counts six.

## 7. The Lean files

Passage C formalises the matrix form of criticality, the strict weakness of the bracket form, and dropped-count arithmetic. None of its declarations states or counts the independence of the diagonal equations, so the files neither support nor contradict the step.

## 8. Verdict

**FAILS.** The $N$ diagonal equations hold at a critical point (Section 2), but on the unit sphere of $\mathcal W_n$ with $\theta=P(W)$ their sum and their $\lambda$-weighted sum are identities (Section 4), so they are at most $N-2$ independent constraints, and at most $N-1$ even with $\theta$ free. The hypotheses the refutation uses are H1 (the record's polarisation identity), H2 ($\mathop{\mathrm{tr}}W=0$), H3 ($\lVert W\rVert=1$, $\theta=P(W)$) and H4 ($\mathop{\mathrm{tr}}Q(W)=0$, from relation (B) or from $Q(\mathcal W_n)\subset\mathcal W_n$). The strongest wording the step can carry is "$N$ equations, of which at most $N-2$ are independent". The exact number of independent constraints is the generic rank of the differential of $W\mapsto\mathop{\mathrm{diag}}\big(Q(W)-P(W)W\big)$ on the unit sphere, and settling it would need computation that the verdict does not require.
