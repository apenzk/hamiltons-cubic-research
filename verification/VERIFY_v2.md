# REVIEW r337, "Problem P holds if and only if it holds at every critical point --- that is, if and only if Conjecture A holds"

Reviewer r337, cold brief, analytical only. Sources read: the prompt, and [nienhaus-2311.02404.txt](references/nienhaus-2023-second-best-einstein/) (permitted external reference). No project record was opened, no numerical work was done; every computation below is closed-form algebra carried out by hand.

## 1. Hypothesis inventory

### 1.1 Hypotheses the statement carries

| # | Hypothesis | Stated? | Checked against |
| --- | --- | --- | --- |
| H1 | $\mathrm{Weyl}_n$ is a finite-dimensional real inner-product space, so $\{|W|=1\}$ is compact | unstated | True: $\dim\mathrm{Weyl}_n=\tfrac{(n+2)(n+1)n(n-3)}{12}$, finite and positive for $n\ge 4$. Load-bearing for the $\Leftarrow$ direction. |
| H2 | $P$ is continuous (indeed a cubic polynomial) on that sphere | unstated | True by construction, $P(W)=\langle W,W^2+W^\#\rangle$. |
| H3 | $\{|W|=1\}$ is a regular level set of $W\mapsto|W|^2$, so Lagrange multipliers apply | unstated | True: $d(|W|^2)[X]=2\langle X,W\rangle\ne0$ at $|W|=1$. |
| H4 | "Problem P holds **at** a critical point $W$" means the scalar inequality $P(W)\le P(W^{\mathrm{crit}}_{\mathrm{sym}})$ | unstated | Only reading under which the sentence parses; adopted below. |
| H5 | "maximized on the Weyl tensor of products of spheres" is a statement about the **maximum value**, not about the maximiser being unique | unstated | Load-bearing, see Finding 6. |
| H6 | The product of spheres meant is the **balanced** one, $S^{\lceil n/2\rceil}\times S^{\lfloor n/2\rfloor}$ | unstated in the README ("products of spheres"), pinned down in Conjecture A | Load-bearing, see Finding 3. |
| H7 | $n\ge 12$ | stated in Problem P, **not** the full hypothesis of Conjecture A | Fails, see Finding 2. |
| H8 | The extremal $W^{\mathrm{crit}}_{\mathrm{sym}}$ is itself an admissible competitor, i.e. lies in $\mathrm{Weyl}^1_n$ | unstated | True; needed so that $\max\ge P(W^{\mathrm{crit}}_{\mathrm{sym}})$. |
| H9 | The set of critical points is non-empty | unstated | True by H1+H2; without it the right-hand side of the first "iff" is vacuously true and the equivalence collapses. |

### 1.2 Hypotheses of the imported theorems

| Import | Where it is used | Hypotheses | Verdict |
| --- | --- | --- | --- |
| Weierstrass extreme-value theorem | the $\Leftarrow$ direction (the sup is attained) | continuous function, compact domain | Satisfied by H1, H2. **Never invoked in the material.** |
| Lagrange multipliers / first-order condition | Material A, $Q(W)=\lambda W$ | $P$ differentiable, constraint a regular level set | Satisfied by H2, H3. |
| Full symmetry of $T(X,Y,Z)=\langle X,Q(Y,Z)\rangle$ | Material A, to get $dP=3\langle Q(W),\cdot\rangle$ | symmetry of **both** the $\tfrac12(XY+YX)$ part and the $\#$ part | True, but Material A's justification covers only the first part, Finding 5. |
| $Q$ maps $\mathrm{Weyl}_n$ into $\mathrm{Weyl}_n$ | Material A, to drop the projection from $\pi_{\mathrm{Weyl}}Q(W)=\lambda W$ | $R,S\in\mathrm{Weyl}_n$ | **Checked and satisfied.** Nienhaus Lemma 2.13, [nienhaus-2311.02404.txt](references/nienhaus-2023-second-best-einstein/) line 1091: "if $R,S\in\mathrm{Weyl}_n$ ... then $Q(R,S)$ is again a Weyl curvature operator", attributed to [AH11]. Retracts my one candidate finding here. |
| Products of spheres are critical points | Material A (equivariance argument) and the $\Rightarrow$ direction | none beyond $k,l\ge2$ | Confirmed independently: Nienhaus Proposition 2.25, line 1483, $W_{S_{k,l}}^2+W^{\#}_{S_{k,l}}=\theta_{k,l}W_{S_{k,l}}$ with $\theta_{k,l}=\sqrt2\sqrt{\tfrac{k-1}{k}\cdot\tfrac{l-1}{l}\cdot\tfrac{n-1}{n-2}}$. |

### 1.3 Hypotheses of Material B, as a separate object

$n\ge3$ (so $n-2\ne0$), $v\perp\mathbf 1$, $|v|=1$; and in part (c) additionally **$n$ even**. All satisfied on their own terms; see Finding 7 for the scope consequence.

## 2. Imported-theorem checks, what I read and where

- **Conjecture A, verbatim.** [nienhaus-2311.02404.txt](references/nienhaus-2023-second-best-einstein/), lines 212–221: *"Let $W\in\mathrm{Weyl}_n$ be a unit Weyl curvature operator that is a critical point of $P(R)=\langle R^2+R^{\#},R\rangle$ among $\mathrm{Weyl}^1_n=\{W\in\mathrm{Weyl}_n\mid \|W\|=1\}$. If either $n\ge12$ **or** $8\leqslant n\leqslant11$ and $W\notin SO(n).W_{\mathbb{CP}^2}$, we have $P(W)\leqslant P(W^{\mathrm{crit}}_{\mathrm{sym}})$."* The extremal is fixed at line 1449 as $S^{n/2}\times S^{n/2}$ for even $n$ and $S^{(n+1)/2}\times S^{(n-1)/2}$ for odd $n$.
- **Critical point $\Rightarrow$ eigenvector of $Q$.** Same file, Remark 2.16(ii), lines 1160–1178: the one-parameter variation $t\mapsto\cos(t)R+\sin(t)R_1$ gives $0=3\langle Q(R),R_1\rangle$ for all $R_1\perp R$, hence $Q(R)=\lambda R$. This is Material A's Lagrange step, and it silently uses the full symmetry of $\mathrm{tri}$ (asserted at line 1146: "Note that this is fully symmetric").
- **$Q$ preserves $\mathrm{Weyl}_n$.** Lemma 2.13, line 1088.
- **Potential of a product of spheres.** Proposition 2.25, line 1483.

## 3. Findings

### Finding 1, Material B contains no argument for the statement under review. **Stands.**

*Re-derivation.* I worked Material B through independently and it is correct. (a) With $\sum_j v_j=0$ and $\sum_j v_j^2=1$: $\sum_{j\ne i}Z_{ij}=-v_i^2+\frac{(n-1)v_i^2+(1-v_i^2)}{n-2}-\frac{n-1}{(n-1)(n-2)}=-v_i^2+v_i^2+\frac1{n-2}-\frac1{n-2}=0$. (b) The residual is $a_i+a_j+c$ with $a_i=-v_i^2/(n-2)$, $c=\frac1{(n-1)(n-2)}$, and for $T\in\mathcal D_n$, $\sum_{i<j}(a_i+a_j)T_{ij}=\tfrac12\sum_{i\ne j}(a_i+a_j)T_{ij}=\sum_i a_i\sum_{j\ne i}T_{ij}=0$, while $\sum_{i<j}cT_{ij}=\tfrac c2\sum_i(\text{row sum})=0$; together with $Z\in\mathcal D_n$ this is exactly the characterisation of the orthogonal projection. (c) At $v_i=\pm1/\sqrt n$ with $k=n/2$: $\frac{2}{n(n-2)}-\frac1{(n-1)(n-2)}=\frac{2(n-1)-n}{n(n-1)(n-2)}=\frac1{n(n-1)}$, so $Z_{\text{same}}=\frac1n+\frac1{n(n-1)}=\frac1{n-1}$ and $Z_{\text{cross}}=-\frac1n+\frac1{n(n-1)}=\frac{2-n}{n(n-1)}$, giving ratio $-\frac{n}{n-2}=-\frac{n/2}{n/2-1}$ as claimed. I also verified the target ratio independently: for $S^k\times S^k$ with $n=2k$, sectional curvatures $1$ within a factor and $0$ across, the Einstein shift is $\lambda=\frac{k-1}{2k-1}$ (from $(k-1)-(n-1)\lambda=0$), so $W_{\text{within}}=\frac{k}{2k-1}$, $W_{\text{cross}}=-\frac{k-1}{2k-1}$, ratio $-\frac{k}{k-1}=-\frac{n}{n-2}$. Material B is sound.

*Concrete failure.* It is sound about a different proposition. Parts (a)–(c) concern the geometry of $\mathcal D_n$ and the projection of $vv^{\mathsf T}$; the words "critical point", "maximum", "attained", "Conjecture A" do not occur, no implication in either direction of the stated equivalence is asserted, and nothing in (a)–(c) would change if the equivalence were false. The statement's own entry names this section as its argument, and the section argues something else.

*Defence attempted.* The strongest defence is that (c) identifies the balanced product as the object singled out by a variational construction, so it might be read as "the extremal is the product of spheres". That defence fails on quantifiers: (c) shows one distinguished $v$ produces the balanced product's vertex matrix, which is a statement about a single point, not about all critical points and not about attainment of the maximum.

### Finding 2, "that is, if and only if Conjecture A holds" is unjustified in the $\Rightarrow$ direction. **Stands. This is the load-bearing defect.**

*Re-derivation.* Write $\mathrm{CP}(n)$ for "every critical point $W\in\mathrm{Weyl}^1_n$ satisfies $P(W)\le P(W^{\mathrm{crit}}_{\mathrm{sym}})$". Problem P quantifies over $n\ge12$, so the first "iff" delivers at most $\forall n\ge12:\mathrm{CP}(n)$. Conjecture A, read from the source, is $\big(\forall n\ge12:\mathrm{CP}(n)\big)\ \wedge\ \big(\forall\,8\le n\le11:\ \forall W\notin SO(n).W_{\mathbb{CP}^2}\ \text{critical}:\ P(W)\le P(W^{\mathrm{crit}}_{\mathrm{sym}})\big)$. The second conjunct is not a consequence of anything asserted about $n\ge12$: no hypothesis of Problem P constrains dimensions $8$ through $11$.

*Concrete failure.* Fix $n=9$. Suppose some critical point $W_0\in\mathrm{Weyl}^1_9$ with $W_0\notin SO(9).W_{\mathbb{CP}^2}$ had $P(W_0)>P(W^{\mathrm{crit}}_{\mathrm{sym},9})$. Conjecture A is then false while Problem P (a statement about $n\ge12$ only) is untouched. No step of Material A or Material B excludes this configuration, and no step could: the material never mentions dimensions below 12 or the $\mathbb{CP}^2$ orbit at all. So the claimed equivalence has an unprovable direction as stated.

*Defence attempted.* Two defences. (i) The record might use "Conjecture A" as shorthand for its $n\ge12$ clause. That is not available here: the record's own provenance paragraph identifies Conjecture A with the statement in the Nienhaus source, and I read that statement, it carries the $8\le n\le11$ clause and the $\mathbb{CP}^2$ exclusion. (ii) Both propositions might simply be true, making the biconditional true as a truth-value identity. Granted, and this is why I do not call the result BROKEN, but a biconditional offered as a *result* is a claim of proved equivalence, and the $\Rightarrow$ direction here has no proof and cannot acquire one along the given route. The correct statement is the restricted one: *Problem P holds iff the $n\ge12$ clause of Conjecture A holds.*

### Finding 3, the $\Rightarrow$ direction additionally needs "balanced beats every other product", which the material never supplies. **Stands, repairable.**

*Re-derivation.* Problem P as quoted says "products of spheres", with $p,q$ unspecified; Conjecture A names the balanced split. Suppose Problem P held with the maximum attained at $W_{S^p\times S^q}$ for some unbalanced $(p,q)$ with $P(W_{S^p\times S^q})>P(W^{\mathrm{crit}}_{\mathrm{sym}})$. Then $W_{S^p\times S^q}$ is a critical point (Nienhaus Prop 2.25) violating the Conjecture A inequality, so Problem P would hold while Conjecture A failed. The gap is real in the material as given.

*Concrete failure and its repair.* The repair is available but is an import, not a step of Materials A or B. From $\theta_{k,l}=\sqrt2\sqrt{\frac{k-1}{k}\cdot\frac{l-1}{l}\cdot\frac{n-1}{n-2}}$ with $k+l=n$, put $s=\frac1k+\frac1l=\frac{n}{kl}$; then $\left(1-\frac1k\right)\left(1-\frac1l\right)=1-s+\frac{1}{kl}=1-s+\frac{s}{n}=1-s\cdot\frac{n-1}{n}$, which is strictly decreasing in $s$, and $s$ is minimised exactly when $kl$ is maximised, i.e. at the balanced split. So the balanced product does dominate, and H6 is legitimate, but it is Nienhaus Prop 2.25 plus this one line, neither of which appears in the material under review.

*Defence attempted.* One could argue "products of spheres" in the README is already understood to mean the balanced one. Even granting that, the $\Rightarrow$ direction still needs the *other* products not to beat it, since they are critical points too; the argument above is required either way.

### Finding 4, the entire content of the $\Leftarrow$ direction (attainment, and that a maximiser is a critical point) is absent. **Stands, repairable in three lines.**

*Re-derivation.* $\Rightarrow$ is trivial: if $P(W)\le P(W^{\mathrm{crit}}_{\mathrm{sym}})$ for all unit $W$, it holds in particular at critical points. $\Leftarrow$ is the whole result and needs: $\mathrm{Weyl}^1_n$ is compact (H1) and $P$ continuous (H2), so $P|_{\mathrm{Weyl}^1_n}$ attains its maximum at some $W_\ast$; $\mathrm{Weyl}^1_n$ is a smooth regular level set (H3), so $W_\ast$ is a critical point of the constrained functional; the hypothesis then gives $P(W_\ast)\le P(W^{\mathrm{crit}}_{\mathrm{sym}})$; and $W^{\mathrm{crit}}_{\mathrm{sym}}\in\mathrm{Weyl}^1_n$ (H8) gives the reverse, so the maximum equals $P(W^{\mathrm{crit}}_{\mathrm{sym}})$ and is attained there.

*Concrete failure of the material as written.* Material A stops at the first-order condition $Q(W)=\lambda W$, $\lambda=P(W)$, that is the $\Rightarrow$-side bookkeeping, i.e. it tells you what a critical point satisfies. It never says the supremum is attained, never says a maximiser is a critical point, and never states either implication. Material B says nothing on the subject (Finding 1). Non-vacuity matters here and is nowhere addressed: if the critical set were empty, "holds at every critical point" would be vacuously true while Problem P could fail, so compactness is not a formality but the hinge.

*Defence attempted.* The defence is that this is standard and omitted for brevity, and I accept the mathematics, the three lines above close it. But the audit question is whether the material proves the statement, and a proof whose only non-trivial direction is entirely unwritten is a gap in the record, not a proof.

### Finding 5, Material A's symmetry justification covers only half of $Q$. **Stands, minor, load-bearing.**

*Re-derivation.* Material A says $T$ is "made fully symmetric by the trace identity $\operatorname{tr}(XYZ)=\operatorname{tr}(ZYX)$ for self-adjoint operators". That identity does establish full symmetry of $(X,Y,Z)\mapsto\tfrac12\operatorname{tr}(X(YZ+ZY))$: cyclicity gives $\operatorname{tr}(XYZ)=\operatorname{tr}(YZX)=\operatorname{tr}(ZXY)$ and transposition gives $\operatorname{tr}(XZY)=\operatorname{tr}(ZYX)=\operatorname{tr}(YXZ)$, so the symmetrised sum is invariant under all six permutations. It says nothing whatever about $\langle X,Y\#Z\rangle$, which involves the Lie bracket structure constants of $\mathfrak{so}(n)$ and no trace of a product of the three operators.

*Concrete failure.* The symmetry is load-bearing, not decorative: $dP(W)[X]=3\langle Q(W),X\rangle$ (and hence $Q(W)=\lambda W$ rather than a first-order condition mixing $Q(W)$ with $Q(W,X)$), holds precisely because $T$ is fully symmetric in all three slots. If the $\#$ half were only partially symmetric the Lagrange conclusion of Material A would change form.

*Defence attempted.* The symmetry of the $\#$ term is true and standard, Nienhaus states it flatly at line 1146 ("Note that this is fully symmetric") for Huisken's trilinear form $\mathrm{tri}(R,S,T)=\langle Q(R,S),T\rangle$, and it follows from the total antisymmetry of the structure constants in $(R\#S)_{\alpha\beta}=\tfrac12 c^{\gamma\delta}_{\alpha}c^{\varepsilon\zeta}_{\beta}R_{\gamma\varepsilon}S_{\delta\zeta}$. So the claim is correct; the *reason* given for it in Material A is not the reason, and covers only the $W^2$ half. Downgraded to a citation defect accordingly.

### Finding 6, the equivalence holds under the value reading of "maximized", and fails under the uniqueness reading. **Stands as a hypothesis correction.**

*Re-derivation.* Conjecture A is a non-strict inequality $P(W)\le P(W^{\mathrm{crit}}_{\mathrm{sym}})$ at critical points. It is therefore consistent with the existence of a critical point $W_0\notin SO(n)\cdot W^{\mathrm{crit}}_{\mathrm{sym}}$ with $P(W_0)=P(W^{\mathrm{crit}}_{\mathrm{sym}})$.

*Concrete failure.* In that configuration $W_0$ is also a global maximiser and is not the Weyl tensor of a product of spheres, so the reading "the maximisers are exactly the products of spheres" fails while Conjecture A holds, the $\Leftarrow$ direction breaks. The rigidity statement is strictly stronger than Conjecture A and is not equivalent to it.

*Defence attempted.* The README's wording, "is maximized on the Weyl tensor of products of spheres", most naturally asserts that the maximum is attained there, not that it is attained only there; under that reading the $\Leftarrow$ direction is fine. I therefore record this as a hypothesis that must be stated rather than as an error: **the equivalence is valid for "the maximum value equals $P(W^{\mathrm{crit}}_{\mathrm{sym}})$ and is attained at it", and is not valid for the uniqueness-of-maximiser strengthening.**

### Finding 7, Material B (c) covers even $n$ only. **Stands, scope note, immaterial to the statement.**

*Re-derivation.* (c) sets $k=n/2$ and $a=b=1/\sqrt n$, which requires $n$ even; the two-value $v$ with $k=n/2$ and $\sum v=0$ forces $a=b$ only in that case.

*Concrete failure.* Problem P quantifies over all $n\ge12$, including odd $n$, where the extremal named by Conjecture A is the unbalanced $S^{(n+1)/2}\times S^{(n-1)/2}$ (Nienhaus, line 1449) and (c)'s two-value computation is not carried out. For $n=13$, say, the ratio $-n/(n-2)$ derived in (c) is not the within/cross ratio of the relevant product, which has two distinct within-block values.

*Defence attempted.* The $Z$ construction does accommodate unbalanced two-value $v$, $Z_{ij}$ depends on $v_i^2+v_j^2$, so within-block-1 and within-block-2 entries differ automatically, so the framework plainly extends and this is an omission rather than an obstruction. Since Material B is not an argument for the statement anyway (Finding 1), this affects the verdict only by confirming that B is aimed at a different, and partially covered, target.

### Withdrawn candidate, "$Q(W)$ may leave $\mathrm{Weyl}_n$, so the critical equation should read $\pi_{\mathrm{Weyl}}Q(W)=\lambda W$"

*Withdrawn.* I raised this because the constrained gradient of $P$ on $\mathrm{Weyl}^1_n$ is a priori only the $\mathrm{Weyl}$-projection of $Q(W)$, and because $\operatorname{tr}Q(W)=|W|^2+\operatorname{tr}(W^{\#})$ need not obviously vanish. It is settled by Nienhaus Lemma 2.13 (line 1091, citing [AH11]): $Q$ maps $\mathrm{Weyl}_n\times\mathrm{Weyl}_n$ into $\mathrm{Weyl}_n$, so the projection is the identity on $Q(W)$ and Material A's $Q(W)=\lambda W$ is exactly right. Recorded so the next reviewer does not re-open it.

### Withdrawn candidate, "$\lambda=P(W)$ is a further assumption"

*Withdrawn.* It is a one-line consequence: pairing $Q(W)=\lambda W$ with $W$ gives $\langle W,Q(W)\rangle=\lambda|W|^2=\lambda$ on the unit sphere. Correct as written in Material A.

## 4. Verdict

**GAP.**

The first equivalence (Problem P holds iff $P(W)\le P(W^{\mathrm{crit}}_{\mathrm{sym}})$ at every critical point), is **true**, and I supply its three-line proof in Finding 4; but that proof appears nowhere in the material, and the section the record names as the argument (Material B) proves an unrelated projection result (Finding 1). The second equivalence (the identification of that condition with **Conjecture A**), is **unjustified in the $\Rightarrow$ direction** and cannot be justified along this route, because Conjecture A as stated in the source also asserts the bound for $8\le n\le11$ outside $SO(n).W_{\mathbb{CP}^2}$, and nothing about $n\ge12$ bears on those dimensions (Finding 2); the same direction separately needs the balanced product to dominate every other product of spheres, which requires Nienhaus Prop 2.25 plus a monotonicity argument that the material does not contain (Finding 3).

**Repair.** The statement becomes correct, with all steps in hand, if it is restated as: *for each $n\ge12$, Problem P in dimension $n$ holds if and only if $P(W)\le P(W^{\mathrm{crit}}_{\mathrm{sym}})$ at every critical point $W\in\mathrm{Weyl}^1_n$ (that is, if and only if the $n\ge12$ clause of Conjecture A holds) where "maximized" means that the maximum value is attained at $W^{\mathrm{crit}}_{\mathrm{sym}}$, and $W^{\mathrm{crit}}_{\mathrm{sym}}$ is the balanced $S^{\lceil n/2\rceil}\times S^{\lfloor n/2\rfloor}$*, with the compactness argument of Finding 4 written out and the domination of unbalanced products (Finding 3) cited.
