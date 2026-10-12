# Verifier v352, L113 step E4: the only sources that can constrain $G_2$ beyond positivity and support

Cold brief [ADJ_L113_E4.md](ADJ_L113_E4.md). No numerical work was done and no scripts were written. Every value below is exact. Log: [agent_logs/verify-L113-v352.log](../agent_logs/verify-L113-v352.log).

| Claim | Verdict |
| --- | --- |
| The pinned moments $m_0=\sum_kg_k$ and $m_1=\sum_k\lambda_kg_k$ with $g\ge0$ on the support $\{\lambda_k\}$ bound $G_2$ above by the chord value $(\lambda_{\max}+\lambda_{\min})m_1-\lambda_{\max}\lambda_{\min}m_0$, attained by a two-atom $g$ | CONFIRMED |
| Relation (A) with $T\ge0$ and $T$ vanishing on repeated indices gives $g_k\ge2(n-2)\delta^2$ at every $k$ when the spectrum is simple, $\delta$ the least eigenvalue gap | CONFIRMED |
| That lower bound puts $G_2$ strictly below the chord value at every $W$ with simple spectrum and $n\ge3$ | CONFIRMED |
| Step E4: among the relations the passages hold, only consequences of Jacobi or first Bianchi on $c$ can constrain $G_2$ beyond positivity and support of $g$ | REFUTED AS STATED |
| Repaired reading: beyond the full tensor-level system (A), (B), (C) on $T\ge0$, the remaining non-linear-in-$T$ sources include Jacobi and Bianchi | CONFIRMED AS ALGEBRA, with the inventory incomplete (Section 5) |

**Summary: the step FAILS, because relation (A) itself, read on the tensor $T$ rather than on $g$, strictly cuts the positivity-and-support range of $G_2$ with no appeal to Jacobi or Bianchi.**

## 0. Conventions, fixed once

- $W\in\mathcal W_n$ acts on $\Lambda^2\mathbb R^n\cong\mathfrak{so}(n)$ with orthonormal eigenbasis $\{v_k\}_{k=1}^N$, $N=n(n-1)/2$, eigenvalues $\lambda_k$, $\lambda_{\min}=\min_k\lambda_k$, $\lambda_{\max}=\max_k\lambda_k$.
- $c_{abc}=\langle[v_a,v_b],v_c\rangle$ for the ad-invariant inner product in which $\{v_k\}$ is orthonormal. $T_{abc}=c_{abc}^2$.
- $g_k=\sum_{\alpha\beta}(\lambda_\alpha-\lambda_\beta)^2T_{k\alpha\beta}$, $m_j=\sum_k\lambda_k^jg_k$, $G_2=m_2$.
- "Positivity and support of $g$" means the system $S_1=\{g\in\mathbb R^N:\ g\ge0,\ \sum_kg_k=m_0,\ \sum_k\lambda_kg_k=m_1\}$, which is exactly the Lean predicate Feasible in Passage F with $c=m_0$, $s=m_1$.
- $\ell(\lambda)=(\lambda_{\max}+\lambda_{\min})\lambda-\lambda_{\max}\lambda_{\min}$ is the chord of $\lambda^2$ through the two extreme eigenvalues.

## Hypothesis inventory

- **H1 (antisymmetry).** $c$ is totally antisymmetric. This is the source of the total symmetry of $T$ that Passage B states, and it gives $T_{abc}=0$ whenever two indices coincide. It follows from ad-invariance alone: $\langle[v_k,v_\alpha],v_\alpha\rangle=-\langle v_\alpha,[v_k,v_\alpha]\rangle$, so $c_{k\alpha\alpha}=0$. It uses neither Jacobi nor Bianchi.
- **H2 (relation A).** $\sum_{\beta\gamma}T_{k\beta\gamma}=2(n-2)$ for every $k$, as quoted in Passage B.
- **H3 (simple spectrum).** The $\lambda_k$ are pairwise distinct. Needed only for the exhibit, and one $W$ suffices.
- **H4.** $n\ge3$, so that $2(n-2)>0$ and $N\ge3$.
- Criticality is used nowhere. Relations (B) and (C) are used nowhere in the refutation.

## 1. The positivity-and-support maximum of $G_2$ is the chord value

For every real $\lambda$, $\ell(\lambda)-\lambda^2=(\lambda_{\max}-\lambda)(\lambda-\lambda_{\min})$. Multiplying by $g_k$ and summing gives the exact identity

$$G_2=(\lambda_{\max}+\lambda_{\min})\,m_1-\lambda_{\max}\lambda_{\min}\,m_0-\sum_k(\lambda_{\max}-\lambda_k)(\lambda_k-\lambda_{\min})\,g_k .$$

Each factor $(\lambda_{\max}-\lambda_k)(\lambda_k-\lambda_{\min})$ is $\ge0$, so on $S_1$ the value $G_2$ is at most the chord value $C:=(\lambda_{\max}+\lambda_{\min})m_1-\lambda_{\max}\lambda_{\min}m_0$. Equality holds exactly when $g_k=0$ at every index with $\lambda_{\min}<\lambda_k<\lambda_{\max}$.

The bound is attained on $S_1$ whenever $S_1$ is nonempty and $\lambda_{\min}<\lambda_{\max}$. The two-atom witness of Passage F's feasible_iff, mass $t=(m_1-m_0\lambda_{\min})/(\lambda_{\max}-\lambda_{\min})$ at an index $j$ with $\lambda_j=\lambda_{\max}$ and $m_0-t$ at an index $i$ with $\lambda_i=\lambda_{\min}$, lies in $S_1$ and vanishes at every interior index. So $\sup_{S_1}G_2=C$, attained. $S_1$ is nonempty at any actual $W$, since the actual $g$ lies in it.

## 2. Relation (A) on the tensor gives a per-coordinate floor on $g$

Assume H1 to H4. Let $\delta=\min_{\alpha\ne\beta}\lvert\lambda_\alpha-\lambda_\beta\rvert>0$. By H1 the terms with $\alpha=\beta$ in $\sum_{\alpha\beta}T_{k\alpha\beta}$ vanish, so

$$g_k=\sum_{\alpha\ne\beta}(\lambda_\alpha-\lambda_\beta)^2T_{k\alpha\beta}\ \ge\ \delta^2\sum_{\alpha\ne\beta}T_{k\alpha\beta}=\delta^2\sum_{\alpha\beta}T_{k\alpha\beta}=2(n-2)\,\delta^2,$$

using $T\ge0$ and then H2. This holds at every index $k$ and at every $W$ with simple spectrum, critical or not.

## 3. The floor strictly cuts the chord maximum

Insert Section 2 into the identity of Section 1:

$$G_2\ \le\ C-2(n-2)\,\delta^2\sum_k(\lambda_{\max}-\lambda_k)(\lambda_k-\lambda_{\min}).$$

Under H3 and H4 there are $N\ge3$ distinct eigenvalues, so at least one lies strictly between $\lambda_{\min}$ and $\lambda_{\max}$, and the sum is strictly positive. Hence every realised $G_2$ satisfies $G_2<C=\sup_{S_1}G_2$. The value $C$, and every value in a neighbourhood below it, is admitted by positivity and support and excluded by (A) with H1.

**This is a constraint on the free moment beyond what positivity and support of $g$ give.** Its sources are relation (A), $T=c^2\ge0$, and the antisymmetry of $c$. None is a consequence of the Jacobi identity or of first Bianchi.

A simple-spectrum instance exists in closed form, so the exhibit is not vacuous. At $n=4$ a Weyl tensor is a pair of traceless symmetric $3\times3$ blocks on $\Lambda^+\oplus\Lambda^-$. Taking $W^+=\mathrm{diag}(1,2,-3)$ and $W^-=\mathrm{diag}(4,5,-9)$ gives the spectrum $\{1,2,-3,4,5,-9\}$ on $\Lambda^2$, pairwise distinct.

## 4. The quoted line, and the argument for the opposite

The failing line is Passage A: "The free data $G_2$ helps only if realizability constrains it through something positivity and support do not see, and the only sources on the table are the **Jacobi identity and first Bianchi acting on the $c$-tensor itself**". Relation (A) is on the table (Passage B) and positivity and support do not see its per-coordinate content.

**The case for the step.** Passage A's previous sentence treats positivity and support as "consequences of the spectrum alone", so the author may mean "beyond what the spectrum and $\theta$ determine". The floor of Section 3 is itself a function of the spectrum, so it returns a pinned conclusion once $G_2$ is eliminated, and L113's moral about the pinned class survives.

**Why that does not rescue the step as written.**

- The step's comparison class is named: "positivity and support of $g$". Passage F formalises exactly that class as Feasible, and Section 3 exhibits a relation outside it.
- The spectral reading does not separate sources at all. At fixed $(\lambda,\theta)$ the supremum of $G_2$ over realisations is a function of $(\lambda,\theta)$ whatever relations produced it, Jacobi included, so under that reading no source could ever constrain $G_2$ "beyond the spectrum" in the sense the sentence needs.
- The record already knows the tensor-level system is stronger than its $g$-shadow. Passage D states the full $3N$-row system is "far stronger" than claimed, and Passage E's L109 is a per-coordinate cap on $g$ from $T\ge0$ and the row marginal, again invisible to positivity and support.

## 5. The strongest reading that holds, and what it needs

**Reading R.** "Beyond what the full tensor-level system gives, namely (A), (B), (C) at every index on a totally symmetric $T\ge0$ vanishing on repeated indices, any further constraint on $G_2$ must come from information about $c$ that is not a linear relation on $T$ with coefficients in $(\lambda,\theta)$."

- R holds as algebra: $G_2$ is linear in $T$, so the tensor-level system bounds it by a linear programme whose data are functions of $(\lambda,\theta)$, and anything sharper must use sign or phase information in $c$ that $T=c^2$ discards.
- Jacobi, quadratic in $c$ with signs, and first Bianchi of $W$ expressed through $c$, are such sources.
- **R does not support "the only sources".** The passages do not enumerate the $c$-level information. Two further sources exist in standard mathematics and the step omits them. First, the off-diagonal parts of the same identities that yield (A) and (C): orthonormality of $\{v_k\}$ for the invariant form gives $\sum_{\alpha\beta}c_{k\alpha\beta}c_{l\alpha\beta}=0$ for $k\ne l$, and criticality gives $(W^\#)_{kl}=\tfrac12\sum_{\alpha\beta}\lambda_\alpha\lambda_\beta c_{k\alpha\beta}c_{l\alpha\beta}=0$ for $k\ne l$. These are bilinear in $c$, invisible to $T$, and come from the Killing form and criticality rather than Jacobi or Bianchi. Second, the isomorphism type: $c$ must be the structure tensor of $\mathfrak{so}(n)$ in some orthonormal basis, which Jacobi with the normalisation (A) does not force. Whether these sharpen $G_2$ is not decided here, and deciding it needs an argument about their consequences for the realisable $T$, not a computation of a single quantity.

So R holds with hypotheses H1 and H2 made explicit and "the only sources" weakened to "sources include".

## Verdict for the step

**FAILS.** The step says only Jacobi or first Bianchi on $c$ can constrain $G_2$ beyond positivity and support of $g$. Relation (A) with $T\ge0$ and the antisymmetry of $c$ (H1, H2) gives $g_k\ge2(n-2)\delta^2$ and hence $G_2\le C-2(n-2)\delta^2\sum_k(\lambda_{\max}-\lambda_k)(\lambda_k-\lambda_{\min})<C$ at every simple-spectrum $W$ with $n\ge3$ (H3, H4), while $C$ is attained under positivity and support. A valid version replaces "positivity and support of $g$" by "the full tensor-level system (A), (B), (C) on $T\ge0$ with H1", and replaces "the only sources" by "sources include", naming the off-diagonal Killing and criticality relations and the isomorphism type of $c$ beside Jacobi and Bianchi.
