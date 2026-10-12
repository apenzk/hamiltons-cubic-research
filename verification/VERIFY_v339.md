# Verifier v339, whether the N diagonal equations of Lemma L111 are N constraints

*Cold brief [ADJ_L111_D6.md](ADJ_L111_D6.md). No numerical work, no scripts written, no computation run. Every value below is exact. Log: [agent_logs/verify-L111-v339.log](../agent_logs/verify-L111-v339.log).*

| # | Claim | Verdict |
|---|---|---|
| 1 | The diagonal equations $M_{kk}=2\lambda_k(\lambda_k-\theta)$, equivalently $\sum_{\alpha\beta}\lambda_\alpha\lambda_\beta c_{k\alpha\beta}^2=2\lambda_k(\theta-\lambda_k)$, hold at every critical point, for every $k$ and in every eigenbasis | CONFIRMED |
| 2 | Their unweighted sum $\sum_k d_k$ vanishes identically on $\mathcal W_n$, for every $\theta$ | CONFIRMED AS ALGEBRA |
| 3 | Their $\lambda$-weighted sum is $\sum_k\lambda_k d_k=2(\theta-P(W))$, so it is the definition of $\theta$ | CONFIRMED AS ALGEBRA |
| 4 | The $N$ diagonal equations are $N$ constraints on a critical point, as opposed to fewer | REFUTED AS STATED |
| 5 | In a fixed eigenbasis they carry at most $N-2$ independent conditions on $W$ | CONFIRMED |
| 6 | With the eigenbasis free inside each eigenspace, their content is at most $s-2$ conditions, $s$ the number of distinct eigenvalues | CONFIRMED |

**Summary: the step FAILS as a count of constraints, because two linear combinations of the $N$ equations are identities on every unit Weyl tensor, and the step survives only as a count of displayed equations, which is not what "constraints" means in a passage about what a route may count.**

## 0. Conventions, fixed once

- $\mathcal W_n$ is the space of algebraic Weyl tensors, read as symmetric operators on $\Lambda^2\mathbb R^n\cong\mathfrak{so}(n)$, $N=\binom n2$, Frobenius inner product, $n\ge4$ so that $\mathcal W_n\ne0$.
- $W\varphi_k=\lambda_k\varphi_k$ over an orthonormal eigenbasis, $c_{abc}=\langle[\varphi_a,\varphi_b],\varphi_c\rangle$ totally antisymmetric, $T_{abc}=c_{abc}^2$.
- $Q(W)=W^2+W^\#$, $P(W)=\langle W,Q(W)\rangle$, critical means $Q(W)=\theta W$ on $\lVert W\rVert=1$, which forces $\theta=P(W)$.
- $M_{kl}=\operatorname{tr}\big(\mathrm{ad}(\varphi_k)W\,\mathrm{ad}(\varphi_l)W\big)$ and, from the lemma's polarisation $\langle v,W^\#v\rangle=-\tfrac12\operatorname{tr}(\mathrm{ad}(v)W\mathrm{ad}(v)W)$, $(W^\#)_{kk}=-\tfrac12M_{kk}$.
- The defect of the $k$-th diagonal equation is $d_k(W,\theta)=M_{kk}-2\lambda_k(\lambda_k-\theta)$. The step's equation is $d_k=0$.
- Expanding the trace, $M_{kk}=\sum_{\alpha\beta}\lambda_\alpha\lambda_\beta c_{k\alpha\beta}c_{k\beta\alpha}=-\sum_{\alpha\beta}\lambda_\alpha\lambda_\beta c_{k\alpha\beta}^2$, so $d_k=0$ is exactly the step's display and relation (C) of Passage B.
- $E_\mu$ is the eigenspace of eigenvalue $\mu$, $m_\mu=\dim E_\mu$, and $s$ is the number of distinct eigenvalues.

## Hypothesis inventory

- **H1** $\operatorname{tr}_{\Lambda^2}W=\sum_k\lambda_k=0$. Standard for a Weyl tensor: the trace on $\Lambda^2$ is a multiple of the scalar curvature.
- **H2** $\lVert W\rVert^2=\sum_k\lambda_k^2=1$, the constraint surface of the problem.
- **H3** The polarisation identity of the lemma with its normalisation, which is what makes $M_{kk}=-2(W^\#)_{kk}$.
- **H4** Either relation (B) of Passage B for every Weyl tensor, or the two standard facts used in Section 2's second derivation: $\mathcal W_n$ is $O(n)$-irreducible for $n\ge4$, and $P$ attains a maximum on the compact unit sphere of $\mathcal W_n$.
- **H5** For the VALID reading only: "constraints" read as "scalar equations written down, one per index", with no claim of independence.

## 1. What the step asserts and how it must be read

The passage says the diagonal entries "pin $\sum\lambda_\alpha\lambda_\beta c_{k\alpha\beta}^2=2\lambda_k(\theta-\lambda_k)$ for every $k$, which is $N$ constraints where the record used one". The same blockquote opens by warning that the bracket form "is a change of language, not new information" and that "a route may not count it as an extra constraint". In that setting "constraint" means an independent condition a route may spend, and "$N$ where the record used one" asserts $N$ such conditions against one.

Claim 1 holds without dispute. At a critical point $M_{kl}=2\lambda_k(\lambda_k-\theta)\delta_{kl}$ in any orthonormal eigenbasis, which is the lemma's matrix form, confirmed in Passage C by [matrix_form_is_criticality](../lean/HamiltonsCubic/Results/L111Statement.lean). So all $N$ equations hold. The question is how many of them are independent.

## 2. The unweighted sum is an identity

**First derivation, from relation (B).** By total symmetry of $T$,

$$\sum_k\sum_{\alpha\beta}\lambda_\alpha\lambda_\beta T_{k\alpha\beta}=\sum_\alpha\lambda_\alpha\Big(\sum_{k\beta}\lambda_\beta T_{\alpha k\beta}\Big)=\sum_\alpha\lambda_\alpha(-2\lambda_\alpha)=-2\sum_\alpha\lambda_\alpha^2,$$

using (B) at index $\alpha$. Relation (B) involves no $\theta$ and is attributed to Ricci-flatness, so it holds for every Weyl tensor. Hence $\sum_kM_{kk}=2\sum_k\lambda_k^2$. The right-hand sides sum to $\sum_k2\lambda_k(\lambda_k-\theta)=2\sum_k\lambda_k^2-2\theta\sum_k\lambda_k=2\sum_k\lambda_k^2$ by H1. Therefore

$$\sum_kd_k(W,\theta)=0\qquad\text{for every }W\in\mathcal W_n\text{ and every }\theta\in\mathbb R.$$

**Second derivation, independent of (B) and of its constant.** The quantity $F(W)=\sum_k\operatorname{tr}(\mathrm{ad}(e_k)W\mathrm{ad}(e_k)W)$ is the same for every orthonormal basis $(e_k)$ of $\mathfrak{so}(n)$, and it is a quadratic form in $W$ invariant under $O(n)$, since $\mathrm{Ad}_g$ is orthogonal on $\mathfrak{so}(n)$ and $\mathrm{ad}(\mathrm{Ad}_ge)=\mathrm{Ad}_g\,\mathrm{ad}(e)\,\mathrm{Ad}_g^{-1}$. Its polar form is $\langle AW,W'\rangle$ for a self-adjoint $O(n)$-intertwiner $A$ of $\mathcal W_n$. An eigenspace of $A$ is invariant, so irreducibility (H4) gives $A=c_n\,\mathrm{id}$ and $F(W)=c_n\lVert W\rVert^2$. A maximiser of $P$ on the unit sphere is a critical point (H4), where every $d_k=0$, so $c_n=F(W)=\sum_k2\lambda_k(\lambda_k-\theta)=2$ by H1 and H2. So $\sum_kM_{kk}=2\lVert W\rVert^2$ on all of $\mathcal W_n$, the same identity. The two derivations agree, which also cross-checks the constant in (B).

## 3. The $\lambda$-weighted sum is the definition of $\theta$

By H3, $\sum_k\lambda_kM_{kk}=-2\sum_k\lambda_k(W^\#)_{kk}=-2\langle W,W^\#\rangle=-2\big(P(W)-\operatorname{tr}W^3\big)$, since $P(W)=\operatorname{tr}W^3+\langle W,W^\#\rangle$. The right-hand sides give $\sum_k2\lambda_k^2(\lambda_k-\theta)=2\operatorname{tr}W^3-2\theta$ by H2. Subtracting,

$$\sum_k\lambda_kd_k(W,\theta)=2\big(\theta-P(W)\big).$$

With $\theta=P(W)$, as the Definitions fix it, this combination is an identity. With $\theta$ treated as an unknown multiplier, this combination is the one equation that determines $\theta$, and it places no condition on $W$. This is very plausibly the "one" the record used: the scalar $P(W)=\theta$ is the trace-level content of criticality.

## 4. The count, in a fixed eigenbasis

The coefficient vectors $(1,\dots,1)$ and $(\lambda_1,\dots,\lambda_N)$ are linearly independent, because H1 and H2 forbid a constant $\lambda$. Pick $k_1,k_2$ with $\lambda_{k_1}\ne\lambda_{k_2}$ and suppose $d_k=0$ for every other $k$. Sections 2 and 3 (with $\theta=P(W)$) give

$$d_{k_1}+d_{k_2}=0,\qquad \lambda_{k_1}d_{k_1}+\lambda_{k_2}d_{k_2}=0,$$

a linear system with determinant $\lambda_{k_2}-\lambda_{k_1}\ne0$, so $d_{k_1}=d_{k_2}=0$. **The $N$ equations are therefore equivalent to $N-2$ of them**, on the whole unit sphere of $\mathcal W_n$ and without using criticality. If $\theta$ is left free, $N$ equations in the unknowns $(W,\theta)$ with one identity among them give at most $N-1$ conditions, one of which is spent fixing $\theta$, and the bound on $W$ is again $N-2$. This is an upper bound. Whether the remaining $N-2$ are independent would need a rank computation of the map $W\mapsto(d_k)_k$, which this brief does not run and which the refutation does not need.

## 5. The count, with the eigenbasis free

When $m_\mu\ge2$ the eigenbasis is not determined by $W$, and the individual $d_k$ for $\varphi_k\in E_\mu$ are basis-dependent. Let $B_\mu$ be the compression of $M$ to $E_\mu$ minus $2\mu(\mu-\theta)\,\mathrm{id}$, a symmetric operator on $E_\mu$. The equations $d_k=0$ for $\varphi_k\in E_\mu$ say that $B_\mu$ has zero diagonal in the chosen basis.

**Standard lemma.** A real symmetric operator $S$ on a Euclidean space of dimension $m$ with $\operatorname{tr}S=0$ has an orthonormal basis in which every diagonal entry is $0$. For $S\ne0$ the form $u\mapsto\langle Su,u\rangle$ takes both signs on the unit sphere, which is connected for $m\ge2$, so it vanishes at some unit $u$. The compression of $S$ to $u^\perp$ still has trace $0$, and induction finishes.

So "the diagonal equations hold in some eigenbasis" is equivalent to $\operatorname{tr}B_\mu=0$ for each of the $s$ distinct eigenvalues, which is $s$ conditions. Sections 2 and 3 are sums over eigenspaces, $\sum_\mu\operatorname{tr}B_\mu=0$ and $\sum_\mu\mu\operatorname{tr}B_\mu=0$, with independent coefficient vectors since $s\ge2$. **The basis-free content of the diagonal family is at most $s-2$ conditions.** At the multiplicity patterns the Lean file records, $3+3+9$ at $n=6$ ($N=15$, $s=3$) and $1+1+4$ at $n=4$ ($N=6$, $s=3$), that is at most one condition, against the step's $15$ and $6$.

**The extreme case in closed form.** For $s=2$ the bound is $0$: every unit Weyl tensor with exactly two distinct eigenvalues admits an eigenbasis in which all $N$ diagonal equations hold with $\theta=P(W)$. Such tensors exist. At $n=4$, $\mathcal W_4\cong S^2_0(\Lambda^+)\oplus S^2_0(\Lambda^-)$, and $W^+=W^-=a\,\mathrm{diag}(2,-1,-1)$ with $a=1/\sqrt{12}$ has eigenvalues $2a$ with multiplicity $2$ and $-a$ with multiplicity $4$, norm $12a^2=1$. For it the diagonal family carries no condition at all. Whether this tensor is critical is not needed: the point is that the family is empty of content there, not that it admits a non-critical solution.

**The other quantifier.** If instead the equations are required in every eigenbasis, they force $B_\mu=0$, which is $m_\mu(m_\mu+1)/2$ conditions per eigenspace and includes the off-diagonal entries inside $E_\mu$. That reading imports off-diagonal information the step assigns to the other half of $M$, and its count is again not $N$ unless every $m_\mu=1$.

## 6. Arguing the opposite

- **"$N$ constraints" means $N$ equations, one per index.** Under H5 the step is VALID: the display holds for every $k$ at a critical point, and there are $N$ indices. This reading is literal and trivial, and it is the reading the same blockquote tells the reader not to use, since it is exactly the kind of count "a route may not count".
- **The identities need criticality, so they are information.** They do not. Section 2 holds for every $W\in\mathcal W_n$ and every $\theta$, and Section 3 holds for every $W$ once $\theta=P(W)$. Neither uses $Q(W)=\theta W$.
- **Relation (B) might fail off the critical set, sinking Section 2.** The second derivation of Section 2 uses neither (B) nor its constant, only $O(n)$-irreducibility and the existence of one critical point.
- **The "one" the record used might be something other than Section 3's combination, so $N$ might still be new.** Whatever it was, at least two independent combinations of the $N$ equations are identities, so at most $N-2$ of them are conditions on $W$. "$N$" fails under every identification of the "one".
- **Generic $W$ has simple spectrum, so Section 5 is a corner case.** Section 4 alone refutes $N$ for simple spectrum. Section 5 matters because the critical points the record studies are degenerate.

## 7. Verdict

**FAILS.** The quoted line "which is $N$ constraints where the record used one" overcounts: the $N$ diagonal equations satisfy $\sum_kd_k\equiv0$ on all of $\mathcal W_n$ and $\sum_k\lambda_kd_k=2(\theta-P(W))$, so in a fixed eigenbasis they are at most $N-2$ independent conditions on $W$, and with the eigenbasis free inside each eigenspace they are at most $s-2$, which is $0$ for two distinct eigenvalues. The step is VALID only under H5, counting displayed equations rather than constraints, with H1 to H3 needed for Claim 1 to hold as displayed. A corrected sentence would read: the diagonal entries give one equation per eigenspace trace, of which two combinations are identities, so at most $s-2$ conditions beyond the definition of $\theta$ in the basis-free reading.
