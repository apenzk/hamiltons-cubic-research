# r726, the two-ninths identification: the two decompositions do join, and the debt discharges

*Gate 2, cold brief, on a derivation not on the record. Analysis only: no sweep, search or census was run, and no screening compute was needed, every number below is closed-form hand algebra on a three-dimensional space. Log: [agent_logs/r726.log](../agent_logs/r726.log).*

| # | claim under review | verdict |
| --- | --- | --- |
| C1 | the $(2,2)$-split four-set block is $2$-dimensional per four-set, three pairings, one Bianchi relation | **CONFIRMED, AND ALREADY ON THE RECORD** as [L120](../findings/second-order.md)'s own proof of its decomposition |
| C2 | pair symmetry and the Weyl trace conditions remove nothing further on a four-set | **CONFIRMED**, pair symmetry is spent in writing the space as $S^2(\Lambda^2)$, and every Ricci trace on four distinct indices is empty |
| C3 | $R_{ijkl}$ spans $\Lambda^2V_1\odot\Lambda^2V_2$ and $R_{ikjl},R_{iljk}$ span $S^2(V_1\otimes V_2)$, **as subspaces of $S^2(\Lambda^2)$** | **CONFIRMED, AND ALREADY ON THE RECORD** as [L133](../findings/second-order.md) Step 2's support table |
| C4 | that $\Lambda^2V_1\odot\Lambda^2V_2$ line **is** [L149](../findings/second-order.md)'s $\Lambda^2\!\otimes\!\Lambda^2$ summand | **REFUTED**, [L27](../findings/nondegeneracy.md)'s summand is an $O(m)\times O(m)$ isotypic component of $\mathcal W_n$; the line named here meets $\mathcal W_n$ in $\{0\}$ |
| C5 | "the $(2,2)$-split four-set block **strictly contains** the $\Lambda^2\!\otimes\!\Lambda^2$ summand" | **REFUTED UNDER ITS OWN READING**, the two subspaces of the three-space intersect in $\{0\}$, so no containment holds at all. *True under the record's reading, by a line the derivation does not identify* |
| C6 | "the identification is false as stated … the decompositions provably do not coincide" | **REFUTED**, they join exactly: $\Lambda^2\!\otimes\!\Lambda^2$ is the $+\mu$ line of each $(2,2)$ four-set block |
| C7 | "which of the two consequences holds is not decidable from the passages read here" | **REFUTED**, it is decidable from the record, and **neither** consequence holds; §5 gives the third reading |
| C8 | the derivation's positive contribution beyond the record | **NONE FOUND**, C1 duplicates L120, C3 duplicates L133 Step 2, and the one new step, C4, is the false one |
|, | **the standing `HYPOTHESIS-DEBT` at [second-order.md:1241](../findings/second-order.md)** | **DISCHARGED**, §4 proves the identity $\lVert D(\mathrm{Alt}\,W_-)_{W^*}[H]\rVert^2=\tfrac29\lVert\Pi_{\Lambda^2\otimes\Lambda^2}H\rVert^2$, stronger than the debt asked for |

**One line.** The derivation reads L149's $\Lambda^2\!\otimes\!\Lambda^2$ as a coordinate subspace of $S^2(\Lambda^2)$ when it is a representation-isotypic subspace of $\mathcal W_n$; under the record's own reading the two decompositions join on the $(2,-1,-1)$ direction, the penalty is not merely bounded by $\tfrac29$ but *equals* $\tfrac29$ times the squared weight on that summand, and L149's $\rho^{\mathrm{eff}}$, its monotonicity and its convex-combination form all stand.

## 0. Conventions, fixed once

All from [conventions.md](../findings/conventions.md) and the lemmas cited, quoted rather than restated.

- $W^*$ is the unit Weyl tensor of $S^m\times S^m$, $n=2m\ge12$, $\mathbb R^n=V_1\oplus V_2$ with $\dim V_i=m$, $e=W^*/\theta_0$, $L_e=e\circ(\cdot)$. $W^*$ is **coordinate-diagonal** in the frame adapted to the split: the coordinate $2$-planes are its eigenvectors ([L133](../findings/second-order.md) Step 1), so [L120](../findings/second-order.md)'s sign-character decomposition applies in that frame.
- "Diagonal" means diagonal in the coordinate $2$-planes $e_i\wedge e_j$, per [conventions.md](../findings/conventions.md).
- Fix a four-set $\{i,j,k,l\}$ with $i,j\in V_1$ and $k,l\in V_2$, a **$(2,2)$-split** four-set. Raw coordinates on the three pairings are $(H_{ij,kl},H_{ik,jl},H_{il,jk})$; **signed coordinates** are $(x,y,z)$ with the middle entry negated, in which first Bianchi reads $x+y+z=0$ and $\mathrm{Alt}$ is the orthogonal projection onto $\mathbf 1$ ([L121](../findings/second-order.md), [L133](../findings/second-order.md) Step 2). Write $\gamma$ for the common weight with $\lVert H\rVert^2=\gamma(x^2+y^2+z^2)$; $\gamma=2$, pinned twice in [L133](../findings/second-order.md) Step 3, and it cancels from everything below.
- $\mathrm{Alt}(R)_{ijkl}=\tfrac13(R_{ijkl}+R_{iklj}+R_{iljk})$, the orthogonal projection of $S^2(\Lambda^2)$ onto $\Lambda^4$ ([conventions.md](../findings/conventions.md)).
- $\sigma(H):=\lVert D(\mathrm{Alt}\,W_-)_{W^*}[H]\rVert^2/\lVert H\rVert^2$, the squared contraction ratio, the object [L141](../findings/second-order.md)(a) bounds by $\tfrac14$ and [L141](../findings/second-order.md)(b) bounds by $\tfrac29$ on the defect-active block.
- $\mu=\mu_{m,m}=\frac{n-2}{2(m-1)^2}=\frac2{n-2}=\frac1{m-1}$, $\lambda_m=\frac{m-2}{2(m-1)}$ ([L26](../findings/nondegeneracy.md), [L27](../findings/nondegeneracy.md)).
- **Two objects both written $\Lambda^2\!\otimes\!\Lambda^2$ on this record, and telling them apart is the whole review.** Write $L_{\mathrm{coord}}$ for $\Lambda^2V_1\odot\Lambda^2V_2\subset S^2(\Lambda^2\mathbb R^n)$, the span of $e_{ab}\odot e_{cd}$ with $a,b\in V_1$, $c,d\in V_2$, the derivation's object. Write $\Lambda^2\!\otimes\!\Lambda^2$ for [L27](../findings/nondegeneracy.md)'s $O(m)\times O(m)$-isotypic summand of $\mathcal W_n$, L149's object.

## 1. The component count, redone from scratch (C1, C2)

Fix four distinct indices $i,j,k,l$. Take the subspace of $S^2(\Lambda^2\mathbb R^n)$ spanned by elements whose support is exactly those four indices.

**Three pairings, and they are independent before Bianchi.** A partition of a four-set into two unordered pairs has three refinements: $(ij)(kl)$, $(ik)(jl)$, $(il)(jk)$. The corresponding elements $e_{ij}\odot e_{kl}$, $e_{ik}\odot e_{jl}$, $e_{il}\odot e_{jk}$ are distinct basis vectors of the symmetric square of a basis of $\Lambda^2$, hence linearly independent. Three.

**The pair symmetry is already spent, not a further relation.** $R_{abcd}=R_{cdab}$ is exactly the statement that $R$ lies in $S^2(\Lambda^2)$ rather than $\Lambda^2\otimes\Lambda^2$ (the tensor product of the bivector space with itself). We built the three-space inside $S^2(\Lambda^2)$, using the symmetric product $\odot$; the symmetry has therefore been consumed in choosing the ambient space and imposes nothing new. *The derivation is silent on this and the brief was right to ask; the answer is in its favour.*

**One Bianchi relation, not more.** First Bianchi is $\mathrm{Alt}(R)=0$. On four distinct indices $\Lambda^4\langle i,j,k,l\rangle$ is one-dimensional, so $\mathrm{Alt}$ restricted to the three-space is a rank-one map and its kernel has codimension exactly $1$. Concretely $\mathrm{Alt}\propto R_{ijkl}+R_{iklj}+R_{iljk}=R_{ijkl}-R_{ikjl}+R_{iljk}$; permuting the four indices reproduces this relation up to sign and gives nothing independent. So: $3-1=2$.

**The Weyl trace conditions remove nothing here, and the brief's worry does not bite.** Ricci-flatness is $\sum_aR_{iaja}=0$. Every term of every such trace carries a repeated index, hence at most three distinct indices, hence is zero on a tensor supported on four distinct indices. The condition is vacuous on this block. *This is [L120](../findings/second-order.md)'s own sentence ("Ricci-flatness being empty there since a trace needs a repeated index") and it is correct.* So the count is **not** "counting a space no Weyl tensor occupies": the two dimensions are occupied, and [L26](../findings/nondegeneracy.md)'s $X$ and [L133](../findings/second-order.md)'s $(0,1,-1)$ exhibit a basis of them.

**Verdict.** C1 and C2 CONFIRMED, and the count is [L120](../findings/second-order.md)'s, printed in its proof paragraph. The derivation records "no script was run"; it also does not record that the count it redoes is on the record.

## 2. The assignment of components to summands (C3, C4)

**The half that is right.** $(ij)$ has both indices in $V_1$ and $(kl)$ both in $V_2$, so $e_{ij}\odot e_{kl}\in\Lambda^2V_1\odot\Lambda^2V_2=L_{\mathrm{coord}}$. Each of $(ik),(jl),(il),(jk)$ has one index in each factor, so lies in $V_1\wedge V_2\cong V_1\otimes V_2$, and $e_{ik}\odot e_{jl},\,e_{il}\odot e_{jk}\in S^2(V_1\otimes V_2)$. **CONFIRMED**, and it is verbatim [L133](../findings/second-order.md) Step 2's table row: "*$x$ couples $\Lambda^2V_1$ with $\Lambda^2V_2$ (both $+$); $y,z$ couple two mixed planes*". Nothing new.

**The half that is fatal.** The derivation then writes "**$R_{ijkl}$ is the $\Lambda^2V_1\otimes\Lambda^2V_2$ component**, and it is ONE dimension per four-set" and carries that name unchanged into the sentence about L149. That equivocates $L_{\mathrm{coord}}$ with [L27](../findings/nondegeneracy.md)'s summand. They are different spaces, and here is the proof.

**(a) $L_{\mathrm{coord}}$ meets $\mathcal W_n$ in $\{0\}$ on each four-set.** In signed coordinates $L_{\mathrm{coord}}\cap\langle\text{four-set}\rangle$ is the line $\mathbb R(1,0,0)$, the sign flip touching only the middle entry. The Weyl space cuts the three-space to $\{x+y+z=0\}$. Since $1+0+0=1\ne0$, the intersection is $\{0\}$: **no Weyl tensor has a nonzero component on a single four-set concentrated in $L_{\mathrm{coord}}$.** A summand of $\mathcal W_n$ therefore cannot be $L_{\mathrm{coord}}$-per-four-set.

**(b) [L27](../findings/nondegeneracy.md)'s labels are representation types, not coordinate locations.** The list is $\langle W\rangle\oplus\mathrm{Weyl}_p\oplus\mathrm{Weyl}_q\oplus(\mathbb R^p\!\otimes\!\mathbb R^q)\oplus S^2_0(\mathbb R^p)\oplus S^2_0(\mathbb R^q)\oplus(S^2_0\!\otimes\!S^2_0)\oplus(\Lambda^2\!\otimes\!\Lambda^2)\oplus(X_p\!\otimes\!\mathbb R^q)\oplus(X_q\!\otimes\!\mathbb R^p)$, with $X_m$ of Young label $[2,1]$. $X_p\otimes\mathbb R^q$ settles the point on its own: $X_p$ is not a subspace of $\Lambda^2$ in any reading, so the entries name **isomorphism classes** of $O(p)\times O(q)$-representations and each summand is the corresponding isotypic component of $\mathcal W_n$. Under (a) the coordinate reading would give that entry dimension $0$ and break the ten-summand dimension identity that [L27](../findings/nondegeneracy.md) says holds identically in $p,q$.

**(c) The summand's actual location, and it is on the record.** [L27](../findings/nondegeneracy.md) states $L_e=+\mu$ on $\Lambda^2\!\otimes\!\Lambda^2$, **citing [L26](../findings/nondegeneracy.md) for it**; [L26](../findings/nondegeneracy.md) supplies the eigenvector $X=\phi_\pi\odot\phi_\rho$ with its $\Lambda^4$ part removed, $\pi$ a coordinate $2$-plane in $V_1$ and $\rho$ one in $V_2$, coefficients $\tfrac23,\tfrac13,-\tfrac13$ on the three pairings and $\lVert X\rVert^2=\tfrac43$; and [L133](../findings/second-order.md) Step 3 converts those to the signed triple $(\tfrac23,-\tfrac13,-\tfrac13)\propto(2,-1,-1)$. **So the summand's line inside a $(2,2)$ four-set block is $\mathbb R(2,-1,-1)$, not $\mathbb R(1,0,0)$.** It satisfies Bianchi ($2-1-1=0$) as it must.

**Verdict.** C3 CONFIRMED and duplicative; **C4 REFUTED**.

## 3. What L120 and L133 actually say (the brief's "weakest link", and it holds)

The brief flags that [L120](../findings/second-order.md) is stated over sign characters at a diagonal critical point and may not define the "$(2,2)$-split four-set block" the derivation assumes. **It does, and the derivation is safe here.**

- [L120](../findings/second-order.md)'s four-set summands $V_{ijkl}$ are indexed by **four-subsets of $[n]$**, one per subset, each of dimension $2$, and criticality is explicitly unused, "$\Gamma$-equivariance needs only that $M$ is $\Gamma$-fixed".
- $W^*$ is $\Gamma$-fixed in the split-adapted frame, its coordinate $2$-planes being eigenvectors ([L133](../findings/second-order.md) Step 1), so L120 applies at $W^*$ in that frame.
- "$(2,2)$-split" is a **refinement of L120's index set by extra data** (how $\{i,j,k,l\}$ meets $V_1$ and $V_2$), not a different partition. [L133](../findings/second-order.md) Step 2's table is organised on exactly that refinement, with rows $(4,0)$, $(3,1)$, $(2,2)$. So "the $(2,2)$-split four-set block" means $V_{ijkl}$ for $\lvert\{i,j,k,l\}\cap V_1\rvert=2$, which is what the derivation assumes.

*Argued the opposite, as strongly as it goes.* One could say the sign group is a property of the frame while the $(p,q)$ split is a property of $W^*$, so the two indexings are logically independent and their combination needs a joint statement. The reply is that L133 Step 2 **is** that joint statement, printed as a table, and the frame in question is the split-adapted one, in which the two structures are compatible by construction. The objection has no bite.

## 4. The joint, in closed form, and the debt discharges

Everything below is at $W^*$, $n=2m\ge12$.

**Step A, the $\mu$-eigenspace of $L_e$ is exactly $\Lambda^2\!\otimes\!\Lambda^2$.** By [L27](../findings/nondegeneracy.md) the decomposition is multiplicity-free and $L_e$ is a real scalar on each summand, with values $1$, $\tfrac12$, $\lambda_m$ (twice), $+\mu$, $-\mu$, and $0$ (four times). At $p=q=m$ these separate $\mu$ from every other value: $\mu=1\Leftrightarrow m=2$; $\mu=\tfrac12\Leftrightarrow m=3$; $\mu=\lambda_m\Leftrightarrow\frac1{m-1}=\frac{m-2}{2(m-1)}\Leftrightarrow m=4$; $\mu=-\mu$ and $\mu=0$ never, $\mu>0$. So for $m\ge5$ (a fortiori on L149's range $m\ge6$), the eigenspace $E_{L_e}(\mu)$ **is** the summand $\Lambda^2\!\otimes\!\Lambda^2$, of dimension $\binom m2^2$.

**Step B, that eigenspace is the span of one line per $(2,2)$-split four-set.** [L26](../findings/nondegeneracy.md) exhibits, for each ordered pair $(\pi,\rho)$ of a coordinate $2$-plane in $V_1$ and one in $V_2$, an eigenvector $X_{\pi\rho}$ at $+\mu$ supported on the four-set $\pi\cup\rho$. Distinct pairs give distinct four-sets, so the $X_{\pi\rho}$ have pairwise disjoint supports and are linearly independent. There are $\binom m2^2$ of them, the number of $(2,2)$-split four-sets, and the dimension from Step A. Hence
$$\Lambda^2\!\otimes\!\Lambda^2\;=\;\bigoplus_{\{i,j,k,l\}\ (2,2)}\mathbb R\,(2,-1,-1)_{ijkl}\;\subset\;\bigoplus_{\{i,j,k,l\}\ (2,2)}V_{ijkl}.$$
**This is the joint the debt asks for.** Each $(2,2)$ four-set block contributes exactly one dimension to $\Lambda^2\!\otimes\!\Lambda^2$; its complementary line $\mathbb R(0,1,-1)$ is the $-\mu$ eigendirection and lies in $S^2_0\!\otimes\!S^2_0$, again by Step A applied at $-\mu$.

**Step C, the defect response is supported exactly on $\Lambda^2\!\otimes\!\Lambda^2$, with constant $\tfrac29$.** By [L133](../findings/second-order.md) Step 2, $\mathrm{Alt}\circ DW_-$ kills every block but the $(2,2)$ four-sets, and on such a block sends $(x,y,z)\mapsto-\tfrac x3\mathbf 1$. Write $H=\alpha(2,-1,-1)+\beta(0,1,-1)$ for the block's general element, the whole of $\mathbf 1^\perp$, as [L133](../findings/second-order.md) Step 4 does. Then $x=2\alpha$, and
$$\lVert\mathrm{Alt}\,DW_-[H]\rVert^2=\tfrac\gamma3x^2=\tfrac{4\gamma}3\alpha^2,\qquad \lVert H\rVert^2=\gamma(6\alpha^2+2\beta^2),\qquad \lVert\Pi_{\Lambda^2\otimes\Lambda^2}H\rVert^2=6\gamma\alpha^2 .$$
The first and third are proportional with **no $\beta$ and no $\gamma$**:
$$\boxed{\ \big\lVert D(\mathrm{Alt}\,W_-)_{W^*}[H]\big\rVert^2\;=\;\tfrac29\,\big\lVert\Pi_{\Lambda^2\otimes\Lambda^2}H\big\rVert^2\quad\text{for every }H\in\mathcal W_n.\ }$$
Blocks are $L_e$-orthogonal and different four-sets give orthogonal $\Lambda^4$ images, so summing over blocks preserves the identity. Hence
$$\sigma(H)=\tfrac29\,\frac{\lVert\Pi_{\Lambda^2\otimes\Lambda^2}H\rVert^2}{\lVert H\rVert^2}\;\le\;\tfrac29,$$
with **equality exactly on $\Lambda^2\!\otimes\!\Lambda^2$** and $\sigma=0$ on its orthogonal complement.

**Step D, this reproduces [L141](../findings/second-order.md)(b) line for line.** L141(b) writes $s$ for "the fraction of a direction's weight carried by the defect-active part of the block", by Step C that part **is** $\Lambda^2\!\otimes\!\Lambda^2$, so $s=6\alpha^2/(6\alpha^2+2\beta^2)$ and $\sigma=\tfrac29 s$ identically. With $\tfrac12\mathrm{Hess}=3\theta_0(L_e-\tfrac12)$ and $L_e=\pm\mu$ on the two lines,
$$\frac{\tfrac12\mathrm{Hess}[H,H]}{\lVert H\rVert^2}=3\theta_0\big(\mu s-\mu(1-s)-\tfrac12\big)=3\theta_0\big(2\mu s-\mu-\tfrac12\big),\qquad \frac{-\kappa_n\lVert D(\mathrm{Alt}W_-)[H]\rVert^2}{\lVert H\rVert^2}=\tfrac29\lvert\kappa_n\rvert s,$$
which is L141(b)'s display exactly. Its "$s=1$, that is, at $\sigma=\tfrac29$" is therefore correct, and $s=1$ names $\Lambda^2\!\otimes\!\Lambda^2$.

**Step E, L149's convex-combination form survives, and is right.** The penalised margin on a unit $H$ is $\sum_V m_V\lVert\Pi_VH\rVert^2$ over [L27](../findings/nondegeneracy.md)'s summands, with $m_V$ the summand margin $3\theta_0(\tfrac12-\lambda_V)$ except on $\Lambda^2\!\otimes\!\Lambda^2$, where Step C replaces it by $m-\tfrac29\lvert\kappa_n\rvert$. The weights sum to $1$, so it **is** a convex combination, and its minimum is the smallest entry. Excluding $\langle W^*\rangle$ and the orbit by the domain, the entries at $p=q=m$ are $3\theta_0\frac{m-3}{2(m-1)}-\tfrac29\lvert\kappa_n\rvert$ on $\Lambda^2\!\otimes\!\Lambda^2$, $c_p=\frac{3\theta_0}{n-2}$ on the two $S^2_0(\mathbb R^m)$ copies, $3\theta_0(\tfrac12+\mu)$ on $S^2_0\!\otimes\!S^2_0$ and $\tfrac32\theta_0$ on the four zero-eigenvalue summands. The first is the smallest, so
$$c_{\min}-c_p=3\theta_0\frac{n-8}{2(n-2)}-\tfrac29\lvert\kappa_n\rvert=\rho^{\mathrm{eff}}_n$$
as L149 prints it, and **"the penalty lands on that same summand" is a theorem, not an assumption**.

**Residual dependency, stated because a discharge should name what it inherits.** The numeral $\tfrac29$ inherits [L133](../findings/second-order.md) Step 2's norm bookkeeping, that the input and the $\Lambda^4$ output are measured with the same weight $\gamma$. That is Gate-2 confirmed twice ([L133](../findings/second-order.md)'s header) and cross-checked against $\delta^2(W_{\mathbb{CP}^2})=\tfrac19$, and it is consistent with [L141](../findings/second-order.md)(a)'s independent $\sigma\le\tfrac14$, which any constant above $\tfrac14$ would contradict. **What §4 adds is the identification, which was the debt; the bookkeeping was never in dispute.**

## 5. The two consequences, and the third reading (C6, C7)

The derivation offers a fork and declares it undecidable. Both prongs are wrong and the fork is false.

- **Its consequence 1, "$\sigma\le\tfrac29$ bounds the whole block, so the record's use is safe but loose."** REFUTED twice. First, the inference is invalid on its own terms: it argues from a containment ($L_{\mathrm{coord}}\subset$ block) that §2(a) shows is not merely unproved but false, $L_{\mathrm{coord}}$ meeting the block in $\{0\}$. Second, the conclusion is wrong: by Step C the bound is **attained**, on $\Lambda^2\!\otimes\!\Lambda^2$ itself, so it is sharp rather than loose and the coefficient cannot be smaller.
- **Its consequence 2, "the margin and the penalty are on different spaces, so L149's convex combination does not have the form it claims."** REFUTED by Step E. They are on the same space, that space is $\Lambda^2\!\otimes\!\Lambda^2$, and the combination is convex because the summand projections are orthogonal and their weights sum to one.
- **The third reading, which is the true one.** The penalty is not an inequality on a space that has to be located; it is the **identity** of Step C. $\sigma$ is a quadratic form whose matrix is $\tfrac29\Pi_{\Lambda^2\otimes\Lambda^2}$. The margin's minimising summand and the penalty's support coincide because both are the $+\mu$ eigenspace of $L_e$, which is why the constant is $\tfrac29$ and not $1$, and why $\rho^{\mathrm{eff}}_n$'s monotonicity, which [L149](../findings/second-order.md) records as reversing under the coefficient-$1$ reading, holds in the recorded direction.

**A side consequence for the record, offered rather than written.** [L149](../findings/second-order.md)'s "The penalty term, which had no account" paragraph reaches the penalty through $u\le w$, i.e. $\sigma\le1$. Step C gives $u^2=\tfrac29v^2$ with $v$ the weight on $\Lambda^2\!\otimes\!\Lambda^2$, hence $u\le\tfrac{\sqrt2}3w$, so that paragraph's $\tfrac32\theta_0-\lvert\kappa_n\rvert=0.416$ is the loose accounting and the box is the tight one. *This is the qualification [ROUND_L149r](../verification/ROUND_L149r.md) and [VERIFY_v17](../verification/VERIFY_v17.md) §6 both asked for; it is stated here and written nowhere by me.*

## 6. Whether the record already settles it (the mechanism search)

Searched by mechanism, "the $+\mu$ eigendirection of the $(2,2)$ block", "$(2,-1,-1)$", "$O(p)\times O(q)$ summand", "$\sigma$" and "$\tfrac29$", across [findings/](../findings/), [verification/](../verification/), [ATTEMPTS.md](../ATTEMPTS.md) and [plan.md](../plan.md), rather than by the symbols the derivation uses. *Reviewer reports were located by grep only and none was read, per the brief.*

| where | what it holds | status |
| --- | --- | --- |
| [L120](../findings/second-order.md), proof paragraph | the $3\to2$ four-set count with Ricci vacuous | **the derivation's §"The count" already on file** |
| [L133](../findings/second-order.md) Step 2 table | $x$ couples $\Lambda^2V_1$ with $\Lambda^2V_2$; $y,z$ couple mixed planes | **the derivation's §"Where those two dimensions live" already on file** |
| [L26](../findings/nondegeneracy.md) | the $+\mu$ eigenvector $X=\phi_\pi\odot\phi_\rho$, one per $(2,2)$ four-set | half the joint |
| [L27](../findings/nondegeneracy.md) | $L_e=+\mu$ on $\Lambda^2\!\otimes\!\Lambda^2$, **by L26**, multiplicity-free | the other half |
| [L133](../findings/second-order.md) Step 3 | the $(2,2)$ block's $+\mu$ eigenvector **is** L26's $X$, in signed coordinates $(2,-1,-1)$ | the two halves touching, one line apart |
| [LEDGER.md:823](../findings/LEDGER.md) | "the $+\rho$ eigenvector $(2,-1,-1)$ … is L26's $\tfrac23,\tfrac13,-\tfrac13$" | the same touch, recorded as a cross-check |
| [VERIFY_v17](../verification/VERIFY_v17.md) §6–7 | names the debt precisely, calls the identification "plausible … asserted, not argued", and prints the summand-margin table | the debt's sharpest prior statement |
| [ROUND_L149r](../verification/ROUND_L149r.md) | hands the debt to the research loop | the debt's origin |

**So every ingredient was on the record and no entry composed them.** Step A's separation of $\mu$ from the other nine eigenvalues, and Step C's promotion of the bound to an identity, are the two steps that were missing; both are three lines. **The derivation under review had all of this in the same two files it cites and reached the opposite conclusion**, because it substituted $L_{\mathrm{coord}}$ for the summand and then reasoned about dimensions of the wrong space.

## 7. The strongest defence of the derivation, and why it fails

*Argued as strongly as the material allows, then answered.*

**Defence 1, "Nienhaus writes $\Lambda^2\!\otimes\!\Lambda^2$, so the summand is $\Lambda^2V_1\odot\Lambda^2V_2$ intersected with $\mathcal W_n$; the derivation is reading the source literally."** *Answer:* that intersection is $\{0\}$ on every four-set by §2(a), so the summand would be $0$-dimensional and could not carry the eigenvalue $\mu\ne0$ that [L27](../findings/nondegeneracy.md) assigns it, nor could the ten dimensions sum to $\dim\mathcal W_n$ identically in $p,q$ as L27 states they do. The neighbouring entry $X_p\otimes\mathbb R^q$ is not a subspace of $\Lambda^2$ at all, which fixes the list's convention as representation types. The literal reading is refuted by the list it is read from.

**Defence 2, "the $+\mu$ eigenspace could be larger than $\Lambda^2\!\otimes\!\Lambda^2$, so Step B's span argument may capture only part of it and the identification could still fail."** *Answer:* the containment runs the other way and both directions close. $\dim E_{L_e}(\mu)=\dim\Lambda^2\!\otimes\!\Lambda^2=\binom m2^2$ by Step A's eigenvalue separation on a multiplicity-free list, and Step B exhibits $\binom m2^2$ independent $\mu$-eigenvectors inside the four-set blocks. Equal finite dimensions with one contained in the other force equality.

**Defence 3, "even granting the identification, $\sigma\le\tfrac29$ was derived on the 2-dimensional block, and restricting an upper bound to a subspace does not make it attained there."** *Answer:* correct in general and irrelevant here, because Step C computes $\sigma$ rather than bounding it. On $\beta=0$, $\sigma=\tfrac{4\gamma\alpha^2/3}{6\gamma\alpha^2}=\tfrac29$ exactly. The bound is attained on the very line the identification names, which is the sharpest outcome available.

**Defence 4, "the derivation's stated conclusion, that the block strictly contains the summand two dimensions against one, is true under the record's reading, so it was right for the wrong reason."** *Answer:* the arithmetic coincides and the mathematics does not. The derivation's stated ground for the containment is that the summand is the $R_{ijkl}$ line, which §2(a) refutes; and its stated conclusion, "the decompositions provably do not coincide … what is owed is which space each of $\sigma$ and the margin actually lives on", is the opposite of what follows, since both live on the same space. A conclusion whose premise is false and whose consequences are both wrong is not right for the wrong reason.

## 8. Verdict

**The derivation is REFUTED at C4, C5, C6 and C7**, and its surviving content (C1, C3) duplicates [L120](../findings/second-order.md) and [L133](../findings/second-order.md) Step 2 without saying so. Its recorded finding ("the debt is not 'join two decompositions'), the decompositions provably do not coincide", is exactly backwards: they do coincide, on the $+\mu$ line of each $(2,2)$-split four-set block.

**The `HYPOTHESIS-DEBT` at [second-order.md:1241](../findings/second-order.md) is DISCHARGED** by §4, in the stronger form of an identity:
$$\lVert D(\mathrm{Alt}\,W_-)_{W^*}[H]\rVert^2=\tfrac29\lVert\Pi_{\Lambda^2\otimes\Lambda^2}H\rVert^2 ,$$
resting on [L26](../findings/nondegeneracy.md), [L27](../findings/nondegeneracy.md), [L120](../findings/second-order.md), [L121](../findings/second-order.md) and [L133](../findings/second-order.md) Steps 2–3, all already on the record, all Gate-2 confirmed. [L149](../findings/second-order.md)'s $\rho^{\mathrm{eff}}_n$, its monotonicity, and its convex-combination margin form stand as written. *Folding this into [findings/](../findings/) is the parent's call; nothing was written there by me.*
