# REVIEW r340, "Problem P holds iff it holds at every critical point, i.e. iff Conjecture A holds"

Reviewer r340, cold brief, L00. No numerical work was performed: every quantity below is in closed form.

**Statement under review (verbatim):** "Problem P holds if and only if it holds at every critical point --- that is, if and only if Conjecture A holds."

## 1. Hypothesis inventory

### 1.1 Hypotheses the statement carries

| # | Hypothesis | Stated? | Checked against |
|---|---|---|---|
| H1 | $n \ge 12$ | Stated in Problem P; **absent** from the right-hand side of the biconditional | Conjecture A as published covers $n\ge 12$ **and** $8\le n\le 11$ with $W\notin SO(n).W_{\mathbb{CP}^2}$. Mismatch, Finding 2 |
| H2 | $\mathrm{Weyl}_n$ is a finite-dimensional real vector space | Unstated | True: $\mathrm{Weyl}_n=\ker(\mathrm{Ric})\subset S^2(\Lambda^2\mathbb R^n)$, a linear subspace, with $\dim \mathrm{Weyl}_n = \tfrac{n-3}{2}\binom{n+2}{3}$ ([extraction L1042](https://arxiv.org/abs/2311.02404)). Nonzero for $n\ge 4$, so $\mathrm{Weyl}^1_n\ne\emptyset$ for all $n$ in range |
| H3 | The constraint set $\{|W|=1\}$ is **compact** | **Unstated anywhere in Material A or B** | True by H2, but the material never invokes it, Finding 4 |
| H4 | The supremum is **attained** | **Unstated** | Follows from H3 plus continuity of the polynomial $P$; never argued, Finding 4 |
| H5 | $\{|W|=1\}$ is a smooth submanifold with non-vanishing constraint gradient | Unstated | True: $\nabla(|W|^2)=2W\ne0$ on the unit sphere |
| H6 | $Q$ maps $\mathrm{Weyl}_n$ into itself | Stated in the README definitions | True; sourced in §2 below. Without it the Lagrange condition of Material A would read $\mathrm{proj}_{\mathrm{Weyl}_n}Q(W)=\lambda W$, not $Q(W)=\lambda W$. Candidate C3, withdrawn |
| H7 | $T(X,Y,Z)=\langle X,B(Y,Z)\rangle$ is **fully** symmetric | Stated, justified only by $\operatorname{tr}(XYZ)=\operatorname{tr}(ZYX)$ | That identity covers the $W^2$ half only, Finding 5 |
| H8 | "the Weyl tensor of products of spheres" designates the **balanced** split $S^{\lceil n/2\rceil}\times S^{\lfloor n/2\rfloor}$ | Unstated (Problem P says "products of spheres", plural, unquantified) | True, and provable in closed form. Candidate C1, withdrawn |
| H9 | "maximized on" means "attains its maximum value at", **not** "the only maximizers are" | Unstated; the two readings are not equivalent here | Under the rigidity reading the biconditional fails, Finding 3 |
| H10 | $\ker W \ne 0$ is admissible | Unstated | No step needs invertibility: $W^\#$ is the polynomial Lie-algebra square, defined on all of $S^2(\Lambda^2\mathbb R^n)$, and Lagrange multipliers are indifferent to the kernel. **No defect** |
| H11 | $W^{\mathrm{crit}}_{\mathrm{sym}}\in\mathrm{Weyl}^1_n$, i.e. the comparison point is itself admissible and critical | Stated in Material A (equivariance argument) | True and independently sourced: Proposition 2.25 gives $W_{S_{k,l}}^2+W_{S_{k,l}}^{\#}=\theta_{k,l}W_{S_{k,l}}$ ([extraction L1483](https://arxiv.org/abs/2311.02404)) |

### 1.2 Hypotheses of Material B, separately

$\mathcal D_n=\{S\ \text{symmetric, hollow}, S\mathbf 1=0\}$ is a **linear** subspace (all three conditions are linear), which is what makes "orthogonal projection" meaningful; $v$ is unit with $v\perp\mathbf 1$; $n\ge3$ for $n-2>0$; and part (c) additionally needs $n$ **even** for $k=n/2$. None of these hypotheses is a hypothesis of the statement under review, which is the substance of Finding 1.

## 2. Imported-theorem checks

| Imported fact | Where I read it | Verdict |
|---|---|---|
| **Conjecture A, verbatim** | [nienhaus-2311.02404.txt L212–L221](https://arxiv.org/abs/2311.02404): "Let $W\in\mathrm{Weyl}_n$ be a unit Weyl curvature operator that is a critical point of $P(R)=\langle R^2+R^\#,R\rangle$ among $\mathrm{Weyl}^1_n$. **If either $n\ge12$ or $8\le n\le11$ and $W\notin SO(n).W_{\mathbb{CP}^2}$**, we have $P(W)\le P(W^{\mathrm{crit}}_{\mathrm{sym}})$." | Read. The criticality hypothesis is confirmed to be part of the conjecture. The $n$-range is **wider** than Problem P's |
| $W^{\mathrm{crit}}_{\mathrm{sym}}$ is the unit Weyl operator of $S^{\lceil n/2\rceil}\times S^{\lfloor n/2\rfloor}$ | Same passage, L222–L225 | Read. Note $\lceil\cdot\rceil,\lfloor\cdot\rfloor$: for odd $n$ the split is the near-balanced one |
| $Q$ preserves $\mathrm{Weyl}_n$ (H6) | [Böhm–Wilking, proof of Theorem 2](../references/boehm-wilking-2008-space-forms/): "It follows from formula (6) for the Ricci curvature of $R^2+R^\#$ that $(R\pm\mathcal W)^2+(R\pm\mathcal W)^\#$ has vanishing Ricci tensor. Hence $(R\pm\mathcal W)^2+(R\pm\mathcal W)^\#$ is a Weyl curvature operator." Restated as a bare fact at [nienhaus L1195](https://arxiv.org/abs/2311.02404) | Holds. Böhm–Wilking give the argument; Nienhaus asserts it |
| Full symmetry of the trilinear form (H7) | [nienhaus L1145](https://arxiv.org/abs/2311.02404): "$\mathrm{tri}(R,S,T)=\langle Q(R,S),T\rangle$. Note that this is fully symmetric", and L4719: "$\mathrm{tri}(R,S,T)=\operatorname{tr}((R\circ S+S\circ R+2R\#S)T)$ is symmetric in all three arguments" | The **fact** holds and is standard (Huisken's trilinear form). Material A's stated **reason** covers only part of it |
| Critical point $\Rightarrow$ eigenvector of $Q$ (Material A's Lagrange step) | [nienhaus L1166–L1180](https://arxiv.org/abs/2311.02404): $0=\frac{d}{dt}\big|_0 P(\cos t\,R+\sin t\,R_1)=3\langle Q(R),R_1\rangle$ for all $R_1\perp R$, hence $Q(R)=\lambda R$ | Matches Material A. Re-derived below |
| Lagrange multipliers / extreme value theorem | Standard; hypotheses H3, H5 | Hypotheses hold, but are never checked in the material |

## 3. Findings

### Finding 1, Material B does not prove the statement; it proves an unrelated projection lemma. **STANDING**

**Re-derivation.** I derived all three parts of Material B from scratch and they are *correct*.

(a) $\sum_{j\ne i}Z_{ij} = v_i\!\!\sum_{j\ne i}\!v_j + \frac{(n-1)v_i^2+\sum_{j\ne i}v_j^2}{n-2} - \frac{n-1}{(n-1)(n-2)} = -v_i^2 + \frac{(n-2)v_i^2+1}{n-2} - \frac1{n-2} = 0$. Matches.

(b) Set $M_{ij}=v_iv_j$ (all $i,j$). For $i\ne j$, $M_{ij}-Z_{ij}=a_i+a_j+c$ with $a_i=-v_i^2/(n-2)$, $c=1/((n-1)(n-2))$. For $T\in\mathcal D_n$, $\sum_{i<j}(a_i+a_j)T_{ij}=\tfrac12\sum_{i\ne j}(a_i+a_j)T_{ij}=\tfrac12\big[\sum_i a_i(T\mathbf 1)_i+\sum_j a_j(T\mathbf 1)_j\big]=0$, and $\sum_{i<j}cT_{ij}=\tfrac c2\sum_i(T\mathbf 1)_i=0$. With (a) giving $Z\in\mathcal D_n$, $Z=\mathrm{proj}_{\mathcal D_n}(M)$. Correct.

(c) At $v=\tfrac1{\sqrt n}(+1,\dots,+1,-1,\dots,-1)$ with $n/2$ of each sign, over the common denominator $n(n-1)(n-2)$: $Z_{\text{same}}$ has numerator $(n-1)(n-2)+2(n-1)-n=n(n-2)$, so $Z_{\text{same}}=\tfrac1{n-1}$; $Z_{\text{cross}}$ has numerator $-(n-1)(n-2)+2(n-1)-n=-(n-2)^2$, so $Z_{\text{cross}}=-\tfrac{n-2}{n(n-1)}$. Ratio $=-\tfrac{n}{n-2}=-\tfrac{n/2}{n/2-1}$. Matches. And the two-block element of $\mathcal D_n$ with $p=q=n/2$ satisfies $(\tfrac n2-1)\alpha+\tfrac n2\gamma=0$, i.e. $\alpha/\gamma=-n/(n-2)$, which pins it up to scale. Correct.

I also identified what Material B is *actually* doing, which the text does not say: with $R_{ij}:=v_iv_j$ one has $\mathrm{Ric}_i=\sum_{j\ne i}v_iv_j=-v_i^2$ and $\mathrm{scal}=-1$, so the standard Weyl-projection formula $W_{ij}=R_{ij}-\frac{\mathrm{Ric}_i+\mathrm{Ric}_j}{n-2}+\frac{\mathrm{scal}}{(n-1)(n-2)}$ reproduces $Z(v)$ **exactly**. Material B is a self-contained re-proof that the classical Weyl projection formula is the orthogonal projection, specialised to rank-one diagonal data.

**Concrete failure.** Material B contains no occurrence of a critical point, of $Q$, of $P$, of attainment, of compactness, or of Conjecture A. Its conclusion is a statement about a linear projection onto $\mathcal D_n$ and the identification of one distinguished element. The statement under review is a biconditional between two global-maximisation assertions. Neither direction of the biconditional is a consequence of (a), (b) or (c), individually or together: the biconditional would be equally true or false if $Z(v)$ were replaced by any other formula.

**Defence attempted.** The strongest defence is that Material B is a link in a chain whose other links carry the equivalence, for instance, that (c) supplies the identification "the maximiser among the diagonal candidates is the balanced sphere product", which one might want in order to know what $P(W^{\mathrm{crit}}_{\mathrm{sym}})$ is. That defence fails on two counts. First, the equivalence's $\Leftarrow$ direction needs only that $W^{\mathrm{crit}}_{\mathrm{sym}}$ be *some* admissible point; its identity is irrelevant to the logic. Second, Material B is confined to the coordinate-diagonal subspace $\mathcal D_n$, whereas the statement quantifies over all of $\mathrm{Weyl}^1_n$, the diagonal case is, by the README's own account, the part already solved. The defence cannot be completed. The finding stands: **the record's entry names the wrong section as this result's argument.**

### Finding 2, The $\Rightarrow$ direction is false against the published Conjecture A, because of its $8\le n\le 11$ clause. **STANDING**

**Re-derivation.** Conjecture A, read from the source, is the conjunction of two clauses: (A12) for $n\ge12$, every unit critical $W$ has $P(W)\le P(W^{\mathrm{crit}}_{\mathrm{sym}})$; and (A8) for $8\le n\le11$, every unit critical $W\notin SO(n).W_{\mathbb{CP}^2}$ has $P(W)\le P(W^{\mathrm{crit}}_{\mathrm{sym}})$. Problem P is a statement about $n\ge12$ only. A statement about $n\ge12$ cannot imply (A8), which quantifies over dimensions Problem P never mentions.

**Concrete failure.** Take $n=10$. Conjecture A asserts $P(W)\le P(W^{\mathrm{crit}}_{\mathrm{sym},10})$ for every unit critical $W\in\mathrm{Weyl}_{10}\setminus SO(10).W_{\mathbb{CP}^2}$. Problem P places no constraint on $\mathrm{Weyl}_{10}$ whatsoever, so Problem P is consistent with the failure of that $n=10$ inequality. Hence "Problem P $\Rightarrow$ Conjecture A" is not merely unproved but unprovable as stated. The low-dimensional clause is not a decorative appendage: the source's whole point is that $\alpha_n<\beta_n$ for $n\le11$ and the inequality reverses at $n=12$ ([extraction L250](https://arxiv.org/abs/2311.02404)), so in dimensions $8$–$11$ the maximiser is $W_{\mathbb{CP}^2}$ and not the sphere product at all. The two clauses are genuinely different mathematics.

**Defence attempted.** The defence is that "Conjecture A" is being used in the record as a local alias for clause (A12) alone, and the README does describe the goal as the $n\ge12$ statement. This is the likely intent. It fails as a defence of the *statement as written* because the record's own provenance section directs the reader to the Nienhaus paper as the place Conjecture A is stated verbatim, and there it is the conjunction. The repair is one clause long and is given in §4.

### Finding 3, Under the rigidity reading of "maximized on", the $\Leftarrow$ direction is unproved. **STANDING**

**Re-derivation.** Conjecture A's conclusion is the non-strict $P(W)\le P(W^{\mathrm{crit}}_{\mathrm{sym}})$. Combined with attainment it yields: $\max_{\mathrm{Weyl}^1_n}P=P(W^{\mathrm{crit}}_{\mathrm{sym}})$, and $W^{\mathrm{crit}}_{\mathrm{sym}}$ is *a* maximiser. It does not yield that $W^{\mathrm{crit}}_{\mathrm{sym}}$ and its $O(n)$-orbit are the *only* maximisers.

**Concrete failure.** Any unit critical $W'\notin O(n).W^{\mathrm{crit}}_{\mathrm{sym}}$ with $P(W')=P(W^{\mathrm{crit}}_{\mathrm{sym}})$ exactly would satisfy Conjecture A (which permits equality) while falsifying the reading of Problem P on which the sphere products are the exclusive maximisers. Conjecture A is logically silent about the existence of such a $W'$; nothing in Material A or B excludes it. For $n\ge12$ no strictness is available to close this, because $W^{\mathrm{crit}}_{\mathrm{sym}}$ is itself the comparison point.

**Defence attempted.** The strongest defence is the structure of clause (A8): there, $W_{\mathbb{CP}^2}$ is *excluded from the hypothesis* and satisfies $P(W_{\mathbb{CP}^2})=\sqrt{3/2}>\theta_n$, so the strict gap forces every maximiser into $SO(n).W_{\mathbb{CP}^2}$ and uniqueness genuinely does follow. I attempted to transplant this to $n\ge12$ and it does not transplant: there is no excluded orbit and no strict gap, so the argument has no analogue. The source itself distinguishes the two statements, listing "the maximum is only achieved by $W_{\mathbb{CP}^2}$" as a *separate* thing it uses alongside the value ([extraction L4687–L4690](https://arxiv.org/abs/2311.02404)). The defence fails and the finding stands as a scope defect: the biconditional is true for the value reading of Problem P and unproved for the rigidity reading, and the statement does not say which it means.

### Finding 4, The substantive direction's proof is absent from both materials: attainment is never established. **STANDING**

**Re-derivation.** The $\Leftarrow$ direction requires exactly four steps: (i) $\mathrm{Weyl}^1_n$ is compact, being the unit sphere of a finite-dimensional space; (ii) $P$ is a polynomial, hence continuous, so the maximum is attained at some $W^\ast$; (iii) $W^\ast$ maximises $P$ on a smooth constraint manifold with $\nabla|W|^2=2W\ne0$, so $W^\ast$ is a critical point, and by full symmetry of $T$, $dP_{W^\ast}[H]=3T(W^\ast,W^\ast,H)=3\langle H,Q(W^\ast)\rangle$, giving $\langle Q(W^\ast),H\rangle=0$ for all $H\perp W^\ast$ in $\mathrm{Weyl}_n$, hence (using H6) $Q(W^\ast)=\lambda W^\ast$ with $\lambda=\langle W^\ast,Q(W^\ast)\rangle=P(W^\ast)$; (iv) Conjecture A applies to $W^\ast$, so $\max P=P(W^\ast)\le P(W^{\mathrm{crit}}_{\mathrm{sym}})\le\max P$, forcing equality.

**Concrete failure.** Material A carries step (iii) and only step (iii). Steps (i), (ii) and (iv), the ones that convert a statement about critical points into a statement about all of $\mathrm{Weyl}^1_n$, appear nowhere in Material A, and Material B is about a different object entirely (Finding 1). The record explicitly says "There is no canonical restatement of this result anywhere else in the project", so the sandwich argument is genuinely missing rather than merely relocated. Step (ii) is where the whole $\Leftarrow$ direction lives: without attainment, "$P\le c$ at every critical point" says nothing about a supremum that might be approached only at infinity, and here it cannot be, but that is a fact requiring the one-line compactness observation that is never made.

**Defence attempted.** The defence is that the missing steps are trivial and any reader supplies them, so the citation of Material A suffices. I accept this in substance (I supplied them above, and they are correct) but the brief's question is whether the material *proves* the statement, and a proof whose only non-trivial-looking step is present while the load-bearing quantifier-changing steps are absent is not a proof of the biconditional. The defence downgrades the severity; it does not dissolve the finding.

### Finding 5, Material A's justification of full symmetry covers the $W^2$ half only. **STANDING (minor, and internal to Material A)**

**Re-derivation.** Material A writes: "made fully symmetric by the trace identity $\operatorname{tr}(XYZ)=\operatorname{tr}(ZYX)$ for self-adjoint operators." That identity is $\operatorname{tr}(A)=\operatorname{tr}(A^{\mathsf T})$ applied to $A=XYZ$ with $X,Y,Z$ symmetric, and it establishes the symmetry of $(X,Y,Z)\mapsto\operatorname{tr}(XYZ+XZY)$, the polarisation of $W\mapsto\operatorname{tr}(W^3)$, i.e. of the $W^2$ half of $Q$.

**Concrete failure.** $W^\#$ is not a matrix product: it is built from the Lie bracket structure constants of $\mathfrak{so}(n)$ on $\Lambda^2$. No trace identity for products of symmetric operators bears on the symmetry of $(X,Y,Z)\mapsto\langle X\#Y,Z\rangle$, which is the non-trivial half and rests instead on the Jacobi/invariance identity for the bracket.

**Defence attempted.** The strongest defence is that the fact is true and standard, which it is, Huisken's trilinear form $\mathrm{tri}(R,S,T)=\operatorname{tr}((R\circ S+S\circ R+2R\#S)T)$ is fully symmetric ([nienhaus L1145, L4719](https://arxiv.org/abs/2311.02404)). So the *conclusion* $\nabla P=3Q$ used in step (iii) above is safe. Only the stated *reason* is short of the claim. This is a citation defect, not a mathematical one, and I flag it at that weight.

### Candidate C1, "products of spheres" is plural and unquantified. **WITHDRAWN**

I suspected Problem P's "maximized on the Weyl tensor of products of spheres" could be satisfied by an unbalanced $S^p\times S^q$ while Conjecture A's specific comparison point $S^{\lceil n/2\rceil}\times S^{\lfloor n/2\rfloor}$ failed, breaking $\Rightarrow$ even within $n\ge12$. Withdrawn on re-derivation: from $\theta_{k,l}=\sqrt2\sqrt{\frac{k-1}{k}\cdot\frac{l-1}{l}\cdot\frac{n-1}{n-2}}$ with $k+l=n$, put $s=kl=k(n-k)$; then $(k-1)(l-1)=kl-k-l+1=s-n+1$, so $\frac{(k-1)(l-1)}{kl}=1-\frac{n-1}{s}$, strictly increasing in $s$. Over $2\le k\le n-2$, $s=k(n-k)$ is strictly maximised at the balanced (or, for odd $n$, near-balanced) split. So the balanced product strictly dominates every other sphere product, and "the maximum among products of spheres" can only denote Conjecture A's $W^{\mathrm{crit}}_{\mathrm{sym}}$. No ambiguity survives. (Closed form throughout; no arithmetic evaluated.)

### Candidate C2, Material B(b) computes the residual only off the diagonal. **WITHDRAWN**

$M_{ij}=v_iv_j$ has $M_{ii}=v_i^2\ne0$ while $Z$ is hollow, so the residual $M-Z$ has a diagonal the material silently drops. Withdrawn: every $T\in\mathcal D_n$ is hollow, so $\sum_i(M-Z)_{ii}T_{ii}=0$ and the omitted part contributes nothing to the inner product. Orthogonality, hence the projection claim, is unaffected. Equivalently, $\mathrm{proj}_{\mathcal D_n}(M)=\mathrm{proj}_{\mathcal D_n}(M-\mathrm{diag}\,M)$ because $\mathcal D_n$ is hollow.

### Candidate C3, Material A's Lagrange equation should be the projected one. **WITHDRAWN**

If $Q$ did not preserve $\mathrm{Weyl}_n$, criticality on $\mathrm{Weyl}^1_n$ would read $\mathrm{proj}_{\mathrm{Weyl}_n}Q(W)=\lambda W$ and Material A's flat "$Q(W)=\lambda W$" would be wrong. Withdrawn: Böhm–Wilking establish that $R^2+R^\#$ has vanishing Ricci tensor when $R$ is Weyl (proof of their Theorem 2), so $Q(\mathrm{Weyl}_n)\subseteq\mathrm{Weyl}_n$ and the two equations coincide. As an independent consistency check in closed form, Proposition 2.25's $Q(W_{S_{k,l}})=\theta_{k,l}W_{S_{k,l}}$ forces $\operatorname{tr}(W^\#)=-|W|^2$ on that operator, which is exactly the vanishing of the scalar component of $Q(W)$.

### Candidate C4, Material B(c) requires $n$ even. **WITHDRAWN as a defect of the statement**

Part (c) sets $k=n/2$, which is unavailable for odd $n$, whereas Conjecture A's comparison point is $S^{\lceil n/2\rceil}\times S^{\lfloor n/2\rfloor}$ and Problem P admits odd $n\ge12$. Withdrawn from the findings because Material B is not part of this statement's argument at all (Finding 1); it is recorded here so that whichever result *does* rest on Material B is checked for an odd-$n$ hole.

## 4. Verdict

**GAP.**

The mathematical core is true and I have proved it in §Finding 4: **for $n\ge12$, and reading "maximized on" as "attains its maximum value at", Problem P is equivalent to clause (A12) of Conjecture A**, by compactness, attainment, Lagrange multipliers, and a two-sided sandwich. That much is sound and repairable in four lines.

What is unjustified, as the statement and its cited support actually stand:

- **The named argument proves something else.** Material B is a correct but unrelated lemma, the orthogonal projection onto $\mathcal D_n$ of a rank-one diagonal matrix, plus the identification of the balanced two-block element. It bears on neither direction of the biconditional (Finding 1). The record's pointer to it is a mis-citation.
- **One direction is false as literally stated.** Problem P ($n\ge12$) cannot imply the $8\le n\le11$ clause of the published Conjecture A (Finding 2).
- **The other direction is unproved under one of the two available readings.** Conjecture A's non-strict $\le$ does not deliver uniqueness of the maximiser for $n\ge12$ (Finding 3).
- **The load-bearing steps are missing.** Attainment of the supremum is never asserted, and the sandwich is never executed (Finding 4).

Minimal repair, which would move this to `PROVEN (hypotheses corrected`: replace the statement with), *For $n\ge12$: $\max\{P(W):W\in\mathrm{Weyl}^1_n\}=P(W^{\mathrm{crit}}_{\mathrm{sym}})$ if and only if $P(W)\le P(W^{\mathrm{crit}}_{\mathrm{sym}})$ at every critical point of $P|_{\mathrm{Weyl}^1_n}$, i.e. if and only if clause (A12) of Conjecture A holds*, and attach the four-step proof of Finding 4, noting explicitly that uniqueness of the maximiser is **not** part of the equivalence and requires a separate argument.
