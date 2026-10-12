# Review r339, "Problem P holds iff it holds at every critical point, i.e. iff Conjecture A holds"

**Reviewer:** r339 (cold brief, no access to the project record beyond the prompt; [references/](../references/) consulted).

**Statement under review, verbatim:** *"Problem P holds if and only if it holds at every critical point --- that is, if and only if Conjecture A holds."*

**Verdict: `PROVEN, hypotheses corrected`.** Two corrections are required, both stated in Finding 1 and Finding 3. Three findings stand; one candidate is withdrawn. Separately, Material B does not bear on this statement at all, and carries an overclaim of its own (Finding 5).

---

## 1. Hypothesis inventory

The statement is a biconditional chaining three propositions. Write them out first, because the whole audit turns on their exact content.

| | Proposition | Exact content |
|---|---|---|
| **(P)** | Problem P | For $n\ge12$: $\max\{P(W): W\in\mathrm{Weyl}_n, \lVert W\rVert=1\}$ is attained on the Weyl tensor of a product of spheres. |
| **(C)** | "it holds at every critical point" | For every $W$ critical for $P\vert_{\mathrm{Weyl}^1_n}$: $P(W)\le P(W^{\mathrm{crit}}_{\mathrm{sym}})$. |
| **(A)** | Conjecture A | Verbatim from [nienhaus-2311.02404.txt L212](https://arxiv.org/abs/2311.02404): *"Let $W\in\mathrm{Weyl}_n$ be a unit Weyl curvature operator that is a critical point of $P(R)=\langle R^2+R^\#,R\rangle$ among $\mathrm{Weyl}^1_n$. If either $n\ge12$ or $8\le n\le11$ and $W\notin SO(n).W_{\mathbb{CP}^2}$, we have $P(W)\le P(W^{\mathrm{crit}}_{\mathrm{sym}})$."* |

### Hypotheses the statement carries

| # | Hypothesis | Stated? | Status against the object |
|---|---|---|---|
| H1 | $\mathrm{Weyl}_n$ is a finite-dimensional real inner-product space, and $\mathcal{S}=\{\lVert W\rVert=1\}$ inside it is its unit sphere | unstated | **Holds.** $\mathrm{Weyl}_n$ is the kernel of the Ricci contraction on $\mathcal{S}^2_B(\Lambda^2\mathbb R^n)$, a linear subspace. So $\mathcal S$ is a compact boundaryless smooth submanifold. |
| H2 | $\mathcal S\ne\emptyset$ | unstated | **Holds** for $n\ge4$, hence for $n\ge12$. |
| H3 | $P$ is continuous and smooth on $\mathcal S$ | unstated | **Holds.** $P$ is a cubic polynomial on $\mathrm{Weyl}_n$. |
| H4 | The supremum of $P$ on $\mathcal S$ is **attained** | **unstated, and absent from both materials** | Holds by H1+H3 (Weierstrass). This is the entire non-trivial content of the "$\Leftarrow$" leg, see Finding 2. |
| H5 | $W^{\mathrm{crit}}_{\mathrm{sym}}\in\mathcal S$ and is the Weyl tensor of a product of spheres | unstated | **Holds.** It is defined as the unit Weyl operator of $S^{\lceil n/2\rceil}\times S^{\lfloor n/2\rfloor}$ with its symmetric Einstein metric ([L219–222](https://arxiv.org/abs/2311.02404)), nonzero for $n\ge4$. |
| H6 | "maximized on the Weyl tensor of products of spheres" means *the maximum value is attained there*, and not *the maximizer set is exactly that family* | **unstated and genuinely ambiguous** | Only the attainment reading is equivalent to (C). See Finding 3. |
| H7 | The dimension range on both sides of the biconditional is $n\ge12$ | **unstated on the (A) side** | (A) as published also asserts an $8\le n\le11$ clause. See Finding 1. |
| H8 | "critical point ... among $\mathrm{Weyl}^1_n$" means *constrained* criticality ($dP\vert_{T_W\mathcal S}=0$), not $\nabla P=0$ on $\mathrm{Weyl}_n$ | implicit | **Correct reading.** Under the unconstrained reading (A) would be near-vacuous: $\nabla P(W)=3Q(W)=0$ forces $P(W)=0\le\theta_n$. Fixed here as the intended reading; not a finding. |
| H9 | $\ker W\ne0$ is admissible | not mentioned | **No dependence.** Nothing in the equivalence touches invertibility of $W$; the Weierstrass/Lagrange argument is indifferent to the kernel. Generic $W\in\mathrm{Weyl}_n$ has a kernel and is covered. |

### Hypotheses of the theorems the argument imports

| # | Imported theorem | Hypotheses | Checked against |
|---|---|---|---|
| I1 | **Weierstrass extreme value theorem** | $f$ continuous on a nonempty compact set | $P$ polynomial (H3) on $\mathcal S$ compact and nonempty (H1, H2). **Pass.** |
| I2 | **Lagrange multipliers / first-order condition on a submanifold** | $f$ differentiable, constraint set a smooth manifold (or constraint gradient nonvanishing) | $\nabla(\lVert W\rVert^2)=2W\ne0$ on $\mathcal S$. **Pass.** |
| I3 | **Full symmetry of the polarization of $P$** (Material A) | $\langle X\#Y,Z\rangle$ fully symmetric; $\operatorname{tr}(XYZ)=\operatorname{tr}(ZYX)$ for self-adjoint $X,Y,Z$ | The trace identity holds since $(XYZ)^{\!\top}=ZYX$ and $\operatorname{tr}A=\operatorname{tr}A^{\!\top}$. Full symmetry of the $\#$-trilinear form is standard Böhm–Wilking. **Pass.** |
| I4 | **$Q(\mathrm{Weyl}_n)\subseteq\mathrm{Weyl}_n$**, needed for Material A's *unprojected* equation $Q(W)=\lambda W$ | none beyond $W\in\mathrm{Weyl}_n$ | **Pass**, see §2. |
| I5 | **$\theta_{k,l}$ closed form** (used only to test H6) | none | Nienhaus Prop. 2.25. **Pass**, see §2. |

---

## 2. Imported-theorem checks, sources read

**I4, $Q$ preserves $\mathrm{Weyl}_n$.** Read in [xu-2412.13633.txt](https://arxiv.org/abs/2412.13633). Equation (2.26) at L406–410 gives $\operatorname{Ric}(Q(R))_{ij}=\sum_k(R^2+R^\#)_{ikjk}=\sum_{p,q}R_{ipjq}R_{pq}=\mathring R(\operatorname{Ric})_{ij}$, and the lemma at L493–505 concludes verbatim: *"If $R\in\langle W\rangle$, by (2.26), we have $\operatorname{Ric}(Q(R))=\mathring R(\operatorname{Ric})=0$, $\operatorname{scal}(Q(R))=\lvert\operatorname{Ric}\rvert^2=0$, thus $Q(R)=R^2+R^\#\in\langle W\rangle$."* Independently corroborated on the diagonal locus: for $\Lambda$ symmetric, hollow, zero row sums, the row sum of $Q$ is $\sum_{j\ne i}\big[\lambda_{ij}^2+\sum_{k\ne i,j}\lambda_{ik}\lambda_{jk}\big]$, and reordering the second term gives $\sum_{k\ne i}\lambda_{ik}\big(\sum_{j\ne i,k}\lambda_{jk}\big)=\sum_{k\ne i}\lambda_{ik}(0-\lambda_{ik})=-\sum_{k\ne i}\lambda_{ik}^2$, which cancels the first term exactly.

**I5, $\theta_{k,l}$.** Read at [L1483](https://arxiv.org/abs/2311.02404): $W^2_{S_{k,l}}+W^\#_{S_{k,l}}=\theta_{k,l}W_{S_{k,l}}$ with $\theta_{k,l}=\sqrt2\sqrt{\tfrac{k-1}{k}\cdot\tfrac{l-1}{l}\cdot\tfrac{n-1}{n-2}}$ and $P(W_{S_{k,l}})=\theta_{k,l}$. Note the consequence used below: $\theta_{k,l}^2=2\tfrac{n-1}{n-2}\big(1-\tfrac{n-1}{kl}\big)$, strictly increasing in $kl$, hence strictly maximized at the balanced split. Note also that this identity makes **every** sphere product a critical point.

**Conjecture A verbatim.** Read at [L212–222](https://arxiv.org/abs/2311.02404), quoted in full in the table above.

---

## 3. The proof, re-derived independently

**"$\Rightarrow$" (P) $\to$ (C).** If $P(W)\le P(W^{\mathrm{crit}}_{\mathrm{sym}})$ for every unit $W$, it holds in particular for critical $W$. Trivial, and it uses none of H4.

**"$\Leftarrow$" (C) $\to$ (P).** By H1–H3 and I1, $P\vert_{\mathcal S}$ attains its maximum at some $W_0\in\mathcal S$. Since $\mathcal S$ is a boundaryless smooth manifold and $P$ is smooth, $d(P\vert_{\mathcal S})_{W_0}=0$, so $W_0$ is a critical point. By (C), $P(W_0)\le P(W^{\mathrm{crit}}_{\mathrm{sym}})$. By H5, $W^{\mathrm{crit}}_{\mathrm{sym}}\in\mathcal S$, so $P(W^{\mathrm{crit}}_{\mathrm{sym}})\le P(W_0)$. Hence $\max_{\mathcal S}P=P(W^{\mathrm{crit}}_{\mathrm{sym}})$, attained on a sphere-product Weyl tensor. $\square$

Material A's Lagrange computation is consistent and I reproduce it: with $T$ the symmetric polarization, $dP_W(H)=3T(H,W,W)=3\langle H,Q(W)\rangle$; the constraint gradient is $2W$; so $Q(W)=\lambda W$ with $\lambda=\langle Q(W),W\rangle=P(W)$. By I4 no projection $\pi_{\mathrm{Weyl}}$ is needed.

**Note on the dimension.** The equivalence itself is dimension-free, it holds verbatim for every $n\ge4$. The $n\ge12$ in Problem P is inherited from where the conjecture is *true*, never from the equivalence. All the mathematical content of Problem P therefore sits in (A); the statement under review transfers none of it.

---

## 4. Findings

### Finding 1, "if and only if **Conjecture A**" is false against Conjecture A as published; it is the $n\ge12$ clause that is equivalent. *Upheld.*

**Re-derivation.** (A) is a conjunction of two clauses: (A$_{\ge12}$) for $n\ge12$, all critical $W$ satisfy $P(W)\le\theta_n$; and (A$_{8\text{–}11}$) for $8\le n\le11$, all critical $W\notin SO(n).W_{\mathbb{CP}^2}$ satisfy $P(W)\le\theta_n$. (P) is quantified over $n\ge12$ only, so (P) $\to$ (A$_{8\text{–}11}$) is not available: (P) says nothing at $n=9$. The correct biconditional is (P) $\Leftrightarrow$ (A$_{\ge12}$), and (A) $\to$ (P) is the sound direction only because (A) $\to$ (A$_{\ge12}$).

**Concrete failure, in closed form.** The two clauses of (A) are not interchangeable, and the middle term (C) read dimension-uniformly is outright **false** at $n=11$. $W_{\mathbb{CP}^2}$ is a critical point (Nienhaus [L245](https://arxiv.org/abs/2311.02404): *"It is straightforward to check that $R^{\mathrm{crit}}_{\mathbb{CP}^2}$ is a critical point"*; equivalently Thm 4.14(a), $Q(W_{\mathbb{CP}^2})=\sqrt{3/2}\,W_{\mathbb{CP}^2}$), so $P(W_{\mathbb{CP}^2})^2=3/2$. At $n=11$ the balanced split is $k=6,l=5$ and
$$\theta_{6,5}^2=2\cdot\tfrac56\cdot\tfrac45\cdot\tfrac{10}{9}=\tfrac{40}{27},\qquad \tfrac32=\tfrac{40.5}{27}>\tfrac{40}{27}.$$
So at $n=11$ there is a critical point with $P>\theta_{11}$: (C) fails, while (A$_{8\text{–}11}$) survives untouched because it excludes exactly that orbit. The reversal at $n=12$ is the same exact comparison: $\theta_{6,6}^2=2\cdot\tfrac56\cdot\tfrac56\cdot\tfrac{11}{10}=\tfrac{55}{36}>\tfrac{54}{36}=\tfrac32$. No numerics: both are rational comparisons.

**Defence attempted.** The charitable reading is that the record uses "Conjecture A" as shorthand for its $n\ge12$ instance, since Problem P is stated only there. That reading rescues the sentence, but it is not what the sentence says, and the record's own provenance section quotes Conjecture A in full including the low-dimension clause. The witness above shows the shorthand is not harmless: the object it abbreviates behaves differently in the excluded range. Correction required, not a break.

**Correction:** *Problem P holds if and only if it holds at every critical point in dimensions $n\ge12$, that is, if and only if the $n\ge12$ clause of Conjecture A holds.*

### Finding 2, attainment of the maximum is never argued, and it is the whole of the non-trivial leg. *Upheld.*

**Re-derivation.** The "$\Leftarrow$" leg needs two facts before Lagrange multipliers can be invoked at all: the supremum is attained, and the attaining point is critical. Material A opens at *"Lagrange multipliers on $\{\lvert W\rvert=1\}$ give $Q(W)=\lambda W$"*, that is the first-order condition **at a critical point already assumed to exist**. Nothing in Material A or Material B asserts compactness of $\mathrm{Weyl}^1_n$, continuity of $P$, or that a maximizer exists.

**Concrete failure.** The gap is one of exposition rather than of truth, and I name the exact missing sentence: *"$\mathrm{Weyl}_n$ is finite-dimensional, so $\mathrm{Weyl}^1_n$ is compact and the polynomial $P$ attains its maximum there, at a point where $d(P\vert_{\mathrm{Weyl}^1_n})=0$."* Supplied in §3. It is load-bearing in the sense that without it the "$\Leftarrow$" leg has no content at all, the "$\Rightarrow$" leg is a tautology, so H4 is the *only* mathematics in the statement.

**Defence attempted.** One can argue the step is too standard to write down. I reject that in this specific case: since "$\Rightarrow$" is a tautology and the equivalence is dimension-free, H4 is *literally everything* the statement asserts. A result whose entire content is one unstated hypothesis should carry that hypothesis explicitly.

### Finding 3, "maximized on the Weyl tensor of products of spheres" is ambiguous, and only the attainment reading is equivalent to Conjecture A. *Upheld.*

**Re-derivation.** Conjecture A concludes an inequality $P(W)\le P(W^{\mathrm{crit}}_{\mathrm{sym}})$ with no equality clause. It therefore cannot imply that the maximizer set equals $SO(n)\cdot W^{\mathrm{crit}}_{\mathrm{sym}}$: a critical $W^\ast$ outside that orbit with $P(W^\ast)=\theta_n$ is fully consistent with (A) and refutes a uniqueness reading of (P). No such $W^\ast$ is exhibited here, so this is a scope defect rather than a counterexample.

**Concrete failure of the *plural*.** The phrase "products of spheres" over-states in a way I can pin down exactly. Every sphere product is a critical point (I5), and $\theta_{k,l}^2=2\tfrac{n-1}{n-2}(1-\tfrac{n-1}{kl})$ is *strictly* increasing in $kl$, so unbalanced products are strictly sub-maximal. At $n=12$, $S^5\times S^7$ against $S^6\times S^6$:
$$\theta_{5,7}^2=2\cdot\tfrac45\cdot\tfrac67\cdot\tfrac{11}{10}=\tfrac{264}{175},\qquad \theta_{6,6}^2=\tfrac{55}{36},\qquad 264\cdot36=9504<9625=55\cdot175 .$$
So the maximum is attained on the *balanced* product alone among the family, and the family as a whole contains critical points that are not maximizers.

**Defence attempted.** The attainment reading ("the max value is attained somewhere on the sphere-product family"), is true and is exactly (A$_{\ge12}$), and is almost certainly what the README means. Nienhaus himself never draws rigidity from Conjecture A: at [L228–232](https://arxiv.org/abs/2311.02404) the "equality if and only if $R_p=R^{\mathrm{crit}}_{\mathrm{sym}}$" comes from the integral inequality (1.1), not from the conjecture. That confirms the reading and confirms that rigidity is *not* in (A).

**Correction:** *"maximized"* must be read as *the maximum value equals $P(W^{\mathrm{crit}}_{\mathrm{sym}})$ and is attained at the balanced product $S^{\lceil n/2\rceil}\times S^{\lfloor n/2\rfloor}$*. Uniqueness of the maximizer is **not** equivalent to Conjecture A and is not delivered by this statement.

### Finding 4, Material B is not an argument for this statement. *Upheld.*

**Re-derivation.** Material B is about $\mathcal D_n=\{S\text{ symmetric, hollow}, S\mathbf 1=0\}$, the vertex matrices of coordinate-diagonal Weyl operators, and about $Z(v)$, the orthogonal projection into $\mathcal D_n$ of the rank-one form $v v^{\!\top}$. Its three parts establish membership, orthogonality of the residual, and a ratio identity. None of the three mentions criticality, compactness, attainment, Conjecture A, or the passage from critical points to global maxima. It is the diagonal-case machinery, one range of the theory below the statement under review.

**Concrete failure.** There is no chain of implication from (a)+(b)+(c) to either leg of the biconditional: (a) and (b) are statements about a linear projection in $\mathbb R^{\binom n2}$; the biconditional is a statement about the extremal structure of a cubic form on a sphere. The record's own entry naming this section as the argument is therefore a misattribution.

**Defence attempted.** Material B could conceivably be a *step* in proving Conjecture A itself (reducing the general case to $\mathcal D_n$), in which case it would sit downstream of the statement, not underneath it. That is plausible from its "Step 2" heading, but it makes the misattribution worse, not better: it is evidence for the harder half, filed against the trivial one.

### Finding 5, Material B (c) asserts the equality case rather than computing it; the ratio it computes does not distinguish the balanced split. *Upheld.*

This finding concerns Material B's internal correctness, not the statement under review.

**Re-derivation.** Parts (a) and (b) check out exactly as written. (a): $\sum_{j\ne i}v_iv_j=-v_i^2$; $\sum_{j\ne i}\tfrac{v_i^2+v_j^2}{n-2}=\tfrac{(n-2)v_i^2+1}{n-2}=v_i^2+\tfrac1{n-2}$; $\sum_{j\ne i}\tfrac1{(n-1)(n-2)}=\tfrac1{n-2}$; total $0$. (b): with $a_i=-v_i^2/(n-2)$ and $c=\tfrac1{(n-1)(n-2)}$, $\sum_{i<j}(a_i+a_j)T_{ij}=\sum_i a_i\sum_{j\ne i}T_{ij}=0$ and $\sum_{i<j}cT_{ij}=\tfrac c2\sum_i(\text{row sum})=0$. Both correct, and (b) is insensitive to whether the ambient space is taken as hollow symmetric matrices or all symmetric matrices, since every $T\in\mathcal D_n$ is hollow.

For (c) I computed the general two-value case rather than only the balanced one. Let $v$ take value $a$ on a block of size $k$ and $b$ on a block of size $l=n-k$, with $\sum v=0$ and $\lVert v\rVert=1$; then $a^2=\tfrac{l}{kn}$, $b^2=\tfrac{k}{ln}$, $ab=-\tfrac1n$. Substituting,
$$Z_{\text{block-1}}=\frac{n(l-1)}{k(n-1)(n-2)},\qquad Z_{\text{block-2}}=\frac{n(k-1)}{l(n-1)(n-2)},\qquad Z_{\text{cross}}=\frac{n\,(n-1-kl)}{kl(n-1)(n-2)},$$
and since $n-1-kl=-(k-1)(l-1)$,
$$\frac{Z_{\text{block-1}}}{Z_{\text{cross}}}=-\frac{l}{k-1},\qquad \frac{Z_{\text{block-2}}}{Z_{\text{cross}}}=-\frac{k}{l-1}.$$
Independently, the Weyl vertex matrix of $S^k\times S^l$ (project the sectional-curvature matrix ($c_1$ within block 1, $c_2$ within block 2, $0$ across), into $\mathcal D_n$, using the Einstein condition $(k-1)c_1=(l-1)c_2=:\mu$) is $S_{\text{block-1}}=\tfrac{\mu l}{(k-1)(n-1)}$, $S_{\text{block-2}}=\tfrac{\mu k}{(l-1)(n-1)}$, $S_{\text{cross}}=-\tfrac{\mu}{n-1}$, with the identical ratios $-\tfrac{l}{k-1}$ and $-\tfrac{k}{l-1}$.

**Concrete failure.** The ratio identity holds for **every** split $k+l=n$, so matching it singles out nothing. At $n=12$, $k=5$, $l=7$, the two-value $v$ with $a^2=\tfrac7{60}$, $b^2=\tfrac5{84}$ gives $Z$ proportional to the vertex matrix of $S^5\times S^7$ (ratios $-\tfrac74$ and $-\tfrac56$), a strictly sub-maximal critical point by Finding 3. Material B's balanced instance $k=l=n/2$ reproduces the special case $-\tfrac{n/2}{n/2-1}=-\tfrac{n}{n-2}$, which I confirm is correct, but the sentence *"the equality case is the balanced product, computed rather than asserted"* does not follow from it. The computation shown is evaluation at an assumed-balanced $v$; the balancedness is an input, never an output. Two further scope holes: (c) covers even $n$ only (no unit $v\perp\mathbf 1$ has an $n/2$–$n/2$ two-value split with $a=b$ when $n$ is odd, yet Conjecture A covers $n=13,15,\dots$), and (c) says nothing about $v$ that is not two-valued.

**Defence attempted.** The strongest defence is that the surrounding argument has already reduced to two-valued $v$ and separately maximizes over $k$ via $\theta_{k,l}$, so (c) is only recording which product the balanced $v$ names. That is entirely plausible, but the brief states this text is all there is, and as written (c) claims to *identify* the equality case. Under the reading that rescues it, (c) proves strictly less than it says.

### Withdrawn candidate, Material A's unprojected critical-point equation $Q(W)=\lambda W$.

I expected the constrained first-order condition on $\mathrm{Weyl}^1_n$ to read $\pi_{\mathrm{Weyl}}Q(W)=\lambda W$, and Material A's unprojected form to carry an unstated hypothesis that $Q$ preserves $\mathrm{Weyl}_n$. **Withdrawn:** $Q$ does preserve $\mathrm{Weyl}_n$. See I4 in §2, Xu (2.26) plus the lemma at L493–505, corroborated by my own row-sum cancellation on the diagonal locus. The README's "$Q$ sending $W_n$ to itself" is correct and Material A's equation needs no projection.

---

## 5. Verdict

**`PROVEN, hypotheses corrected`**

The biconditional is true, and I have proved it in §3 from the definitions. Two hypotheses must be added to the statement as recorded:

1. **Dimension** (Finding 1): "Conjecture A" must be read as its $n\ge12$ clause, and the middle term must be restricted to $n\ge12$. Read dimension-uniformly, the middle term is false at $n=11$ (witness $W_{\mathbb{CP}^2}$, with $\tfrac32>\tfrac{40}{27}=\theta_{6,5}^2$) while Conjecture A's low-dimension clause is not.
2. **Sense of "maximized"** (Finding 3): attainment of the maximum value, not uniqueness of the maximizer. Conjecture A carries no equality clause, and the maximum among sphere products is attained only at the balanced split.

Two presentational defects accompany the result and should be repaired in the record:

- The attainment step (Finding 2) is absent from both materials and is the *entire* content of the non-trivial leg, since the other leg is a tautology and the equivalence is dimension-free.
- Material B (Finding 4) proves an unrelated lemma about the projection onto $\mathcal D_n$ and does not bear on this statement; and within itself, its part (c) (Finding 5) asserts the equality case rather than computing it, since the ratio it exhibits is shared by every split $k+l=n$.

A closing caution for anyone using this result downstream: it is a definitional reduction, not progress. It transfers no difficulty, and every quantitative obstruction to Problem P survives it intact inside Conjecture A.
